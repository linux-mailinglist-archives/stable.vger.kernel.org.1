Return-Path: <stable+bounces-230850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIvBKUvSyGnprAUAu9opvQ
	(envelope-from <stable+bounces-230850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:18:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1218D35103D
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F785301AD0C
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A629D281;
	Sun, 29 Mar 2026 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJ8HlnIA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BEB22D4DC
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774768708; cv=none; b=ncWm1xZDR9GK7XF/nZHEZPV3IDZnyLb/VruTYBdQjf5e3MamaiDedyBoNSkhfEWr9uiZRR8t4mEibreOpZcjDtibNN0I95Fbf4+n/WJs78n+MRxDRwusxwQvq+4PTRNPw+gdGP9SgHr477rTjSwsqqMxsOprvOS8nBdF8VhGNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774768708; c=relaxed/simple;
	bh=XTJr/joAqHRuNIlq5VABLMOheW+feyBqER3SHd+r7NQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h0U5wqspTEELv7qQu7PWBup74Vost1OeJGlMCip3Zu+Gcy7PqjvRsra3EnVme03eC6IbNnXAUGq1Jb4IftrTfbdxoa8FsXn+MxSkFuiExu685U9h/PVsUpyk5MDnD5bjszv2X2eIbaQ/w13jG8LZfqi1QehtwqKeD6AFcuWeCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dJ8HlnIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D25C116C6;
	Sun, 29 Mar 2026 07:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774768707;
	bh=XTJr/joAqHRuNIlq5VABLMOheW+feyBqER3SHd+r7NQ=;
	h=Subject:To:Cc:From:Date:From;
	b=dJ8HlnIAVZlSRG+nwP0zErirXUOebnZd8n7woZffp6cQK2DSiXnjiPJeLMkAT/N3A
	 aprXJdGEG0O30LuhQAyDcxvOL8lgb1qttthCt3oiItmz43L/Rs8P2I/9XtamGrTdpf
	 7EoRTc3tHieIrZ9LtINv6M0go3qwpyYNPjkGRvco=
Subject: FAILED: patch "[PATCH] s390/entry: Scrub r12 register on kernel entry" failed to apply to 6.6-stable tree
To: gor@linux.ibm.com,iii@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 09:18:23 +0200
Message-ID: <2026032923-rerun-crouch-f0cc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230850-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1218D35103D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0738d395aab8fae3b5a3ad3fc640630c91693c27
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026032923-rerun-crouch-f0cc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0738d395aab8fae3b5a3ad3fc640630c91693c27 Mon Sep 17 00:00:00 2001
From: Vasily Gorbik <gor@linux.ibm.com>
Date: Thu, 26 Mar 2026 19:50:14 +0100
Subject: [PATCH] s390/entry: Scrub r12 register on kernel entry

Before commit f33f2d4c7c80 ("s390/bp: remove TIF_ISOLATE_BP"),
all entry handlers loaded r12 with the current task pointer
(lg %r12,__LC_CURRENT) for use by the BPENTER/BPEXIT macros. That
commit removed TIF_ISOLATE_BP, dropping both the branch prediction
macros and the r12 load, but did not add r12 to the register clearing
sequence.

Add the missing xgr %r12,%r12 to make the register scrub consistent
across all entry points.

Fixes: f33f2d4c7c80 ("s390/bp: remove TIF_ISOLATE_BP")
Cc: stable@kernel.org
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 4873fe9d891b..689d253e1afc 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -271,6 +271,7 @@ SYM_CODE_START(system_call)
 	xgr	%r9,%r9
 	xgr	%r10,%r10
 	xgr	%r11,%r11
+	xgr	%r12,%r12
 	la	%r2,STACK_FRAME_OVERHEAD(%r15)	# pointer to pt_regs
 	mvc	__PT_R8(64,%r2),__LC_SAVE_AREA(%r13)
 	MBEAR	%r2,%r13
@@ -407,6 +408,7 @@ SYM_CODE_START(\name)
 	xgr	%r6,%r6
 	xgr	%r7,%r7
 	xgr	%r10,%r10
+	xgr	%r12,%r12
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA(%r13)
 	MBEAR	%r11,%r13
@@ -496,6 +498,7 @@ SYM_CODE_START(mcck_int_handler)
 	xgr	%r6,%r6
 	xgr	%r7,%r7
 	xgr	%r10,%r10
+	xgr	%r12,%r12
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)


