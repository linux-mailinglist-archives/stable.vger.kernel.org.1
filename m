Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64AC742C34
	for <lists+stable@lfdr.de>; Thu, 29 Jun 2023 20:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjF2SpO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 29 Jun 2023 14:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjF2Soz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Jun 2023 14:44:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370073AA1
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 11:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0647615E7
        for <stable@vger.kernel.org>; Thu, 29 Jun 2023 18:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6DBC433C8;
        Thu, 29 Jun 2023 18:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688064279;
        bh=4OkHtDS3GIPBNXpx314FO0/jEro6ZzGkwNmvjCsMeo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eU2vv3WWBImceFZugvau/PTCtGn5VNEEGzmLhqG1Ez1LyMidw1Li0AQ/wxbGqutQ/
         aG50dlkIjlixO/dm1KvGyv8Rp2mCvzzA4VSlOCJsTiSlS1qQm+aI5YNhIAjQeTv8/t
         V1ykjOtBvvxGgb4/ZVyLElRikL5YlXYSMbHe+/Kc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 10/30] x86/smp: Use dedicated cache-line for mwait_play_dead()
Date:   Thu, 29 Jun 2023 20:43:29 +0200
Message-ID: <20230629184152.082833510@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629184151.651069086@linuxfoundation.org>
References: <20230629184151.651069086@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit f9c9987bf52f4e42e940ae217333ebb5a4c3b506 upstream.

Monitoring idletask::thread_info::flags in mwait_play_dead() has been an
obvious choice as all what is needed is a cache line which is not written
by other CPUs.

But there is a use case where a "dead" CPU needs to be brought out of
MWAIT: kexec().

This is required as kexec() can overwrite text, pagetables, stacks and the
monitored cacheline of the original kernel. The latter causes MWAIT to
resume execution which obviously causes havoc on the kexec kernel which
results usually in triple faults.

Use a dedicated per CPU storage to prepare for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615193330.434553750@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/smpboot.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -99,6 +99,17 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+struct mwait_cpu_dead {
+	unsigned int	control;
+	unsigned int	status;
+};
+
+/*
+ * Cache line aligned data for mwait_play_dead(). Separate on purpose so
+ * that it's unlikely to be touched by other CPUs.
+ */
+static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
+
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
@@ -1746,10 +1757,10 @@ EXPORT_SYMBOL_GPL(cond_wakeup_cpu0);
  */
 static inline void mwait_play_dead(void)
 {
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
-	void *mwait_ptr;
 	int i;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
@@ -1784,13 +1795,6 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
-	/*
-	 * This should be a memory location in a cache line which is
-	 * unlikely to be touched by other processors.  The actual
-	 * content is immaterial as it is not actually modified in any way.
-	 */
-	mwait_ptr = &current_thread_info()->flags;
-
 	wbinvd();
 
 	while (1) {
@@ -1802,9 +1806,9 @@ static inline void mwait_play_dead(void)
 		 * case where we return around the loop.
 		 */
 		mb();
-		clflush(mwait_ptr);
+		clflush(md);
 		mb();
-		__monitor(mwait_ptr, 0, 0);
+		__monitor(md, 0, 0);
 		mb();
 		__mwait(eax, 0);
 


