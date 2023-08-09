Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D555B7759AF
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjHILCp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjHILCn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085342681
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BA0461FA9
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C6FC433C8;
        Wed,  9 Aug 2023 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578956;
        bh=Pg6wQzaebYk/OUXpeziGMaaeM5hwFoBuPiZsFgfA3Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQjaGHX0U8l/iXH2YCgbZdRhAZ6bu1f+Ci3ROrn4S74AJDQMcbCmpXFCFuc/Ry5hY
         CaWMAXEwFKZSLAjAfXuNiM3d2MihMSaHO8dZ4ByO0j0vl8qWae4psy5XUA/owOsw1M
         tEdLjHgRkBWFP/4kLvNGmNo0O1lmwsqJaMC2hd5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhen Lei <thunder.leizhen@huawei.com>,
        Baoquan He <bhe@redhat.com>, Cong Wang <amwang@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 024/204] kexec: fix a memory leak in crash_shrink_memory()
Date:   Wed,  9 Aug 2023 12:39:22 +0200
Message-ID: <20230809103643.376298210@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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
index 27cf24e285e0c..3d87dcbb9cbd6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1016,6 +1016,7 @@ int crash_shrink_memory(unsigned long new_size)
 	start = crashk_res.start;
 	end = crashk_res.end;
 	old_size = (end == 0) ? 0 : end - start + 1;
+	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
 	if (new_size >= old_size) {
 		ret = (new_size == old_size) ? 0 : -EINVAL;
 		goto unlock;
@@ -1027,9 +1028,7 @@ int crash_shrink_memory(unsigned long new_size)
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



