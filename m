Return-Path: <stable+bounces-172115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 668CAB2FADF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A04C18903A9
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6D5338F2D;
	Thu, 21 Aug 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ADMwA5yb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EC338F2B
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783250; cv=none; b=kOMxqlPZZdh2sSBrrVPNmgMYXxvoZ49efRP26ENXeM4KXPvkRK1CnT05uro5tdZl2I8WPayo81tggAdKcsAR9RKACfSM0dUEUedyw7r5VswHEucffAetntZiYPVP45VEPwvahTeBhvxNONlEXVnKUj/wt0tLZ5Z4Ubezz1rC3Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783250; c=relaxed/simple;
	bh=VMrQ5PlcvHJbBuPefbJzsjgK97XHj7fOl1Vl6uO5Aoc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uUzagdNEmBiTjDGw3lklHRAw/6hq15DxS5WljyTpCY/Fe4TuBoDr1O4MNbauFrZBGn+4nNPYzmnP5PH9b7+39v6dntcpAkbBpTS++OgyHmTRRG4CfjG9OniLbE1ZE2fyPz7Yjva5ktGc6ZGvDSFh8WRfXyp7isVDc7D5FN51ews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ADMwA5yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91331C4CEEB;
	Thu, 21 Aug 2025 13:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755783250;
	bh=VMrQ5PlcvHJbBuPefbJzsjgK97XHj7fOl1Vl6uO5Aoc=;
	h=Subject:To:Cc:From:Date:From;
	b=ADMwA5ybY4oZngktrBhKmyOmEZXke4QV/tZlgUnerPAx0YVe5iR0frTR2zyxXsMeG
	 6+l6LhTZJ40uDS6LmCNWWxBu9WJOFs6vlrnrpgiU5dF1kcelrc8kyd36Te6xPTDogF
	 NQ/ntB5aI3n/5gEETo1LJfdRAAew6FhnqhH0GiPM=
Subject: FAILED: patch "[PATCH] parisc: Revise gateway LWS calls to probe user read access" failed to apply to 5.15-stable tree
To: dave.anglin@bell.net,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:34:06 +0200
Message-ID: <2025082106-pantyhose-finished-9731@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f6334f4ae9a4e962ba74b026e1d965dfdf8cbef8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082106-pantyhose-finished-9731@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6334f4ae9a4e962ba74b026e1d965dfdf8cbef8 Mon Sep 17 00:00:00 2001
From: John David Anglin <dave.anglin@bell.net>
Date: Fri, 25 Jul 2025 12:12:14 -0400
Subject: [PATCH] parisc: Revise gateway LWS calls to probe user read access

We use load and stbys,e instructions to trigger memory reference
interruptions without writing to memory. Because of the way read
access support is implemented, read access interruptions are only
triggered at privilege levels 2 and 3. The kernel and gateway
page execute at privilege level 0, so this code never triggers
a read access interruption. Thus, it is currently possible for
user code to execute a LWS compare and swap operation at an
address that is read protected at privilege level 3 (PRIV_USER).

Fix this by probing read access rights at privilege level 3 and
branching to lws_fault if access isn't allowed.

Signed-off-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # v5.12+

diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 0fa81bf1466b..f58c4bccfbce 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -613,6 +613,9 @@ lws_compare_and_swap32:
 lws_compare_and_swap:
 	/* Trigger memory reference interruptions without writing to memory */
 1:	ldw	0(%r26), %r28
+	proberi	(%r26), PRIV_USER, %r28
+	comb,=,n	%r28, %r0, lws_fault /* backwards, likely not taken */
+	nop
 2:	stbys,e	%r0, 0(%r26)
 
 	/* Calculate 8-bit hash index from virtual address */
@@ -767,6 +770,9 @@ cas2_lock_start:
 	copy	%r26, %r28
 	depi_safe	0, 31, 2, %r28
 10:	ldw	0(%r28), %r1
+	proberi	(%r28), PRIV_USER, %r1
+	comb,=,n	%r1, %r0, lws_fault /* backwards, likely not taken */
+	nop
 11:	stbys,e	%r0, 0(%r28)
 
 	/* Calculate 8-bit hash index from virtual address */
@@ -951,41 +957,47 @@ atomic_xchg_begin:
 
 	/* 8-bit exchange */
 1:	ldb	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 	b	atomic_xchg_start
 2:	stbys,e	%r0, 0(%r20)
-	nop
-	nop
-	nop
 
 	/* 16-bit exchange */
 3:	ldh	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 	b	atomic_xchg_start
 4:	stbys,e	%r0, 0(%r20)
-	nop
-	nop
-	nop
 
 	/* 32-bit exchange */
 5:	ldw	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	b	atomic_xchg_start
 6:	stbys,e	%r0, 0(%r23)
 	nop
 	nop
-	nop
-	nop
-	nop
 
 	/* 64-bit exchange */
 #ifdef CONFIG_64BIT
 7:	ldd	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 8:	stdby,e	%r0, 0(%r23)
 #else
 7:	ldw	0(%r24), %r20
 8:	ldw	4(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 9:	stbys,e	%r0, 0(%r20)


