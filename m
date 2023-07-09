Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6DF74C28A
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGILVr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjGILVq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D230A18F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51CDA60B7F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EA8C433C7;
        Sun,  9 Jul 2023 11:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901703;
        bh=Xw1ldOvh5cxXQOHAzdqNI9rFo1LD/6yRyJjj0pFFMi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xpaXqRFK48efsQeitt3xGhfRqoZzdOdAKGe5QWbgXQfQk57GVNfhHZ9CSHaSvhN7w
         Azz026a2X7QJTp62O1Om9tLpGjz5DX8eK/gx/jO1YJx+J6sJzGxHMbThCiDTOHVM/p
         37CoPHKkVBzGuyH7qSbAEKOiRtSm4vL+TYHKDpF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
        Baoquan He <bhe@redhat.com>, Cong Wang <amwang@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 114/431] kexec: fix a memory leak in crash_shrink_memory()
Date:   Sun,  9 Jul 2023 13:11:02 +0200
Message-ID: <20230709111453.828745439@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

[ Upstream commit 1cba6c4309f03de570202c46f03df3f73a0d4c82 ]

Patch series "kexec: enable kexec_crash_size to support two crash kernel
regions".

When crashkernel=X fails to reserve region under 4G, it will fall back to
reserve region above 4G and a region of the default size will also be
reserved under 4G.  Unfortunately, /sys/kernel/kexec_crash_size only
supports one crash kernel region now, the user cannot sense the low memory
reserved by reading /sys/kernel/kexec_crash_size.  Also, low memory cannot
be freed by writing this file.

For example:
resource_size(crashk_res) = 512M
resource_size(crashk_low_res) = 256M

The result of 'cat /sys/kernel/kexec_crash_size' is 512M, but it should be
768M.  When we execute 'echo 0 > /sys/kernel/kexec_crash_size', the size
of crashk_res becomes 0 and resource_size(crashk_low_res) is still 256 MB,
which is incorrect.

Since crashk_res manages the memory with high address and crashk_low_res
manages the memory with low address, crashk_low_res is shrunken only when
all crashk_res is shrunken.  And because when there is only one crash
kernel region, crashk_res is always used.  Therefore, if all crashk_res is
shrunken and crashk_low_res still exists, swap them.

This patch (of 6):

If the value of parameter 'new_size' is in the semi-open and semi-closed
interval (crashk_res.end - KEXEC_CRASH_MEM_ALIGN + 1, crashk_res.end], the
calculation result of ram_res is:

	ram_res->start = crashk_res.end + 1
	ram_res->end   = crashk_res.end

The operation of insert_resource() fails, and ram_res is not added to
iomem_resource.  As a result, the memory of the control block ram_res is
leaked.

In fact, on all architectures, the start address and size of crashk_res
are already aligned by KEXEC_CRASH_MEM_ALIGN.  Therefore, we do not need
to round up crashk_res.start again.  Instead, we should round up
'new_size' in advance.

Link: https://lkml.kernel.org/r/20230527123439.772-1-thunder.leizhen@huawei.com
Link: https://lkml.kernel.org/r/20230527123439.772-2-thunder.leizhen@huawei.com
Fixes: 6480e5a09237 ("kdump: add missing RAM resource in crash_shrink_memory()")
Fixes: 06a7f711246b ("kexec: premit reduction of the reserved memory size")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Cong Wang <amwang@redhat.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee3..22acee18195a5 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1122,6 +1122,7 @@ int crash_shrink_memory(unsigned long new_size)
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
+	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
@@ -1133,9 +1134,7 @@ int crash_shrink_memory(unsigned long new_size)
 		goto unlock;
 	}
 
-	start = roundup(start, KEXEC_CRASH_MEM_ALIGN);
-	end = roundup(start + new_size, KEXEC_CRASH_MEM_ALIGN);
-
+	end = start + new_size;
 	crash_free_reserved_phys_range(end, crashk_res.end);
 
 	if ((start == end) && (crashk_res.parent != NULL))
-- 
2.39.2



