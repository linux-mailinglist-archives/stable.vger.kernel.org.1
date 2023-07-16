Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8642775550C
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjGPUg6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjGPUg5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CAAE6A
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:36:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A99F60EC0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5691EC433C7;
        Sun, 16 Jul 2023 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539806;
        bh=x68mS2r2gBvCa2ErOvoXX/QObzir5PBJSG0U56DjDiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVT2qSOie/6/IR8+OiUj0/fyrOuUjSJtsVuFaHtZ1ltMEdLfw/pH2LTwosDxzE5lp
         6YfaUVOoNRvWgsiqWSi6pB7yPHnZC6LpOBQ59+kIboewelQfP6+7z+KgCqIkhe2ogG
         xln/Q2mIJxqSRP11FAcCRrNq0sBrNm2PUOE+W1Jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
        Baoquan He <bhe@redhat.com>, Cong Wang <amwang@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 102/591] kexec: fix a memory leak in crash_shrink_memory()
Date:   Sun, 16 Jul 2023 21:44:01 +0200
Message-ID: <20230716194926.515501596@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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
index ca2743f9c634e..79c012fbb49c8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1035,6 +1035,7 @@ int crash_shrink_memory(unsigned long new_size)
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
+	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
@@ -1046,9 +1047,7 @@ int crash_shrink_memory(unsigned long new_size)
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



