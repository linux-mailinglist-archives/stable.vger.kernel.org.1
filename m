Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05076ADA5
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjHAJbH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjHAJaq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:30:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE24F2112
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:29:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74DDA614BB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AFCC433C8;
        Tue,  1 Aug 2023 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882171;
        bh=VWfNMe8kmAKFD6sqF8IDUl7cmA/NafciYJoUzMKftk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YufGKSb5Upo9KeX6a656uA0C+MRRNjHdPSum3KeuHSvAHqeOjb4pDem/AKIlZ/FTH
         eOBmxuphNCdFBW/310Dj044NrMZ7TPoCCIfqtUg3p25tYrgg+j6OIEyRdu+b5eQSfh
         mzEXtP+vdG082sKftC+In6hfQ096afK/wlDlZGu4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haren Myneni <haren@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/228] powerpc/pseries/vas: Hold mmap_mutex after mmap lock during window close
Date:   Tue,  1 Aug 2023 11:17:49 +0200
Message-ID: <20230801091923.243105710@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Haren Myneni <haren@linux.ibm.com>

[ Upstream commit b59c9dc4d9d47b3c4572d826603fde507055b656 ]

Commit 8ef7b9e1765a ("powerpc/pseries/vas: Close windows with DLPAR
core removal") unmaps the window paste address and issues HCALL to
close window in the hypervisor for migration or DLPAR core removal
events. So holds mmap_mutex and then mmap lock before unmap the
paste address. But if the user space issue mmap paste address at
the same time with the migration event, coproc_mmap() is called
after holding the mmap lock which can trigger deadlock when trying
to acquire mmap_mutex in coproc_mmap().

t1: mmap() call to mmap              t2: Migration event
    window paste address

do_mmap2()                           migration_store()
 ksys_mmap_pgoff()                    pseries_migrate_partition()
  vm_mmap_pgoff()                      vas_migration_handler()
    Acquire mmap lock                   reconfig_close_windows()
    do_mmap()                             lock mmap_mutex
     mmap_region()                        Acquire mmap lock
      call_mmap()                         //Wait for mmap lock
       coproc_mmap()                        unmap vma
         lock mmap_mutex                    update window status
         //wait for mmap_mutex            Release mmap lock
          mmap vma                        unlock mmap_mutex
          update window status
         unlock mmap_mutex
    ...
    Release mmap lock

Fix this deadlock issue by holding mmap lock first before mmap_mutex
in reconfig_close_windows().

Fixes: 8ef7b9e1765a ("powerpc/pseries/vas: Close windows with DLPAR core removal")
Signed-off-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230716100506.7833-1-haren@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/vas.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
index 880b962afc057..041a25c08066b 100644
--- a/arch/powerpc/platforms/pseries/vas.c
+++ b/arch/powerpc/platforms/pseries/vas.c
@@ -744,6 +744,12 @@ static int reconfig_close_windows(struct vas_caps *vcap, int excess_creds,
 		}
 
 		task_ref = &win->vas_win.task_ref;
+		/*
+		 * VAS mmap (coproc_mmap()) and its fault handler
+		 * (vas_mmap_fault()) are called after holding mmap lock.
+		 * So hold mmap mutex after mmap_lock to avoid deadlock.
+		 */
+		mmap_write_lock(task_ref->mm);
 		mutex_lock(&task_ref->mmap_mutex);
 		vma = task_ref->vma;
 		/*
@@ -752,7 +758,6 @@ static int reconfig_close_windows(struct vas_caps *vcap, int excess_creds,
 		 */
 		win->vas_win.status |= flag;
 
-		mmap_write_lock(task_ref->mm);
 		/*
 		 * vma is set in the original mapping. But this mapping
 		 * is done with mmap() after the window is opened with ioctl.
@@ -763,8 +768,8 @@ static int reconfig_close_windows(struct vas_caps *vcap, int excess_creds,
 			zap_page_range(vma, vma->vm_start,
 					vma->vm_end - vma->vm_start);
 
-		mmap_write_unlock(task_ref->mm);
 		mutex_unlock(&task_ref->mmap_mutex);
+		mmap_write_unlock(task_ref->mm);
 		/*
 		 * Close VAS window in the hypervisor, but do not
 		 * free vas_window struct since it may be reused
-- 
2.39.2



