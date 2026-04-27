Return-Path: <stable+bounces-241376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJRpLa2R72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:41:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B0476916
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F9B0300B8D6
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D933D648A;
	Mon, 27 Apr 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TvXfP3Uy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2863CF042
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307859; cv=none; b=Ke61hhd5nY12WpzmrfG7N4ijcprfP+VcbU7OSU3GdwbSvmiYzFtK4lnVzdvbA+AIVv3onE0w2Usl022Wts7cG/Vev6GttkLDU467MAVSwuf/1KC+lkUdHT3aipXGPzyeFk/aIOpclXNu+OhdsNxTyD9MJT+HraSwzQ/kbisddhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307859; c=relaxed/simple;
	bh=D5ZbZu8ruSdkqbMm/NdyO6Q6pKsA91rArlJdNZzsvfg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nM537GMVlgnv1VzSP5Ux3PqMYHQXk4j0a284Ng0eEnRsySyjjvgY4HG14Shxf4fX543mMahqRdbayxO9zn2FxGT2mDMTe/gb+hBNO3M++nbYvmcKueLrUU/Odo+jxDra1lQ7QMRb8H7QfMcynCB8ES32PbGk6JqhVvKjzuqs/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TvXfP3Uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A24C2BCC4;
	Mon, 27 Apr 2026 16:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777307859;
	bh=D5ZbZu8ruSdkqbMm/NdyO6Q6pKsA91rArlJdNZzsvfg=;
	h=Subject:To:Cc:From:Date:From;
	b=TvXfP3UyC4CxXjd5g/ktmMxiYvlnZyacH5Pi1dxFB5rUUcUTAme8dVHYTXtXHA3Iy
	 cgBmq5UXRaqwDLZ0UIrS9dbGPdurxjZJBzOlII3geG56SFu7A2GBPK3pNlWN2GoxRT
	 4xJIRxUhx80+dsPbEPW38EipnmYR4Cjb6kqwedu4=
Subject: FAILED: patch "[PATCH] LoongArch: Add spectre boundry for syscall dispatch table" failed to apply to 5.10-stable tree
To: gregkh@linuxfoundation.org,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:36:55 -0600
Message-ID: <2026042755-skimming-uncover-4670@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C70B0476916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241376-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,loongson.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0c965d2784fbbd7f8e3b96d875c9cfdf7c00da3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042755-skimming-uncover-4670@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c965d2784fbbd7f8e3b96d875c9cfdf7c00da3d Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 22 Apr 2026 15:45:12 +0800
Subject: [PATCH] LoongArch: Add spectre boundry for syscall dispatch table

The LoongArch syscall number is directly controlled by userspace, but
does not have a array_index_nospec() boundry to prevent access past the
syscall function pointer tables.

Cc: stable@vger.kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index 1249d82c1cd0..dac435c32743 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -9,6 +9,7 @@
 #include <linux/entry-common.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
+#include <linux/nospec.h>
 #include <linux/objtool.h>
 #include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
@@ -74,7 +75,7 @@ void noinstr __no_stack_protector do_syscall(struct pt_regs *regs)
 	add_random_kstack_offset();
 
 	if (nr < NR_syscalls) {
-		syscall_fn = sys_call_table[nr];
+		syscall_fn = sys_call_table[array_index_nospec(nr, NR_syscalls)];
 		regs->regs[4] = syscall_fn(regs->orig_a0, regs->regs[5], regs->regs[6],
 					   regs->regs[7], regs->regs[8], regs->regs[9]);
 	}


