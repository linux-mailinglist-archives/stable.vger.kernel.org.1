Return-Path: <stable+bounces-256360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMbXHCKtGGpymAgAu9opvQ
	(envelope-from <stable+bounces-256360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F335FA134
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 384B03053DF3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B896318BB5;
	Thu, 28 May 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B1bgbXT3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30212F260C;
	Thu, 28 May 2026 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001482; cv=none; b=dmzNol7yVbHSysZhIg5s2gbhKvjeWeHtajbAPHWEbcRjyRIdiTARp06vUYFSX4b4a+v9ILHKCof/9lM3gaXW8HraCO4XhKFxDWzrXnMLZ41kXJDbSvgztFlHsh7E6ck2LTb6bva9Z1NawtuPr0emnU8fHVPE+p2KYOJyozIenRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001482; c=relaxed/simple;
	bh=l4ouSpS0ns+NDw/vOl6NiDCk/LACBdUIbjkxx+WxdxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mri5FI4y6Diyb5uF2y7tJ2axBQgbdcRTk+8ATutGUlKr8VzV5R7/+rE20gXYwJeMGKYQkysqoVN9ZsXMgNVeYHGAqpWWZVR4tZlZEJLr+tZKMd2RNZt3w32gDJBTrDRu3gHp5AFWAo/IGwUXHcaa1P7zcvurLc4xPcHbi3eWTkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B1bgbXT3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454A01F000E9;
	Thu, 28 May 2026 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001481;
	bh=6intE7uH7a3GyeesxcmjXzf413vnfY3Vx34pgpT+ncM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B1bgbXT3aXrRRospzLIBMCug1AvaIpgng5AxLKSTKIwDCvhPZKyOTgblnCaq2wq4I
	 6vvuzHt9Y2651OxuEprkpBVsF0tWZq4r/4Pz5+AA/MOu9nJgFrKmrCGBvo4N5tHfm7
	 ZwnW4lYKK7CFIT23EYVqta3oQaA/iqZ2RzW4SwYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Sayali Patil <sayalip@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 142/186] powerpc/time: Remove redundant preempt_disable|enable() calls from arch_irq_work_raise()
Date: Thu, 28 May 2026 21:50:22 +0200
Message-ID: <20260528194932.785638671@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-256360-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.ibm.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E5F335FA134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sayali Patil <sayalip@linux.ibm.com>

[ Upstream commit 31467b23823ffec1f6fff407f8e3ca9af8b7491a ]

A kernel panic is observed when handling machine check exceptions from
real mode.

  BUG: Unable to handle kernel data access on read at 0xc00000006be21300
  Oops: Kernel access of bad area, sig: 11 [#1]
  MSR:  8000000000001003 <SF,ME,RI,LE>  CR: 88222248  XER: 00000005
  CFAR: c00000000003ffc4 DAR: c00000006be21300 DSISR: 40000000 IRQMASK: 0
  NIP [c000000000029e40] arch_irq_work_raise+0x10/0x70
  LR [c00000000003ffc8] machine_check_queue_event+0xa8/0x150
  Call Trace:
  [c0000000179d3c70] [c00000000003ff64] machine_check_queue_event+0x44/0x150
  [c0000000179d3d30] [c0000000000084e0] machine_check_early_common+0x1f0/0x2c0

The crash occurs because arch_irq_work_raise() calls preempt_disable()
from machine check exception (MCE) handlers running in real mode. In
this context, accessing the preempt_count can fault, leading to the panic.

The preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
was originally added by commit 0fe1ac48bef0 ("powerpc/perf_event: Fix
oops due to perf_event_do_pending call") to avoid races while raising
irq work from exception context.

Later, commit 471ba0e686cb ("irq_work: Do not raise an IPI when
queueing work on the local CPU") added preemption protection in
irq_work_queue() path, while commit 20b876918c06 ("irq_work: Use per
cpu atomics instead of regular atomics") added equivalent
protection in irq_work_queue_on() before reaching arch_irq_work_raise():

  irq_work_queue() / irq_work_queue_on()
    -> preempt_disable()
      -> __irq_work_queue_local()
        -> irq_work_raise()
          -> arch_irq_work_raise()

As a result, callers other than mce_irq_work_raise() already execute
with preemption disabled, making the additional
preempt_disable()/preempt_enable() pair in arch_irq_work_raise()
redundant.

The arch_irq_work_raise() function executes in NMI context when called
from MCE handler. Hence we will not be preempted or scheduled out since
we are in NMI context with MSR[EE]=0. Therefore, it is safe to remove
the preempt_disable()/preempt_enable() calls from here.

Remove it to avoid accessing preempt_count from real mode context.

Fixes: cc15ff327569 ("powerpc/mce: Avoid using irq_work_queue() in realmode")
Suggested-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
[Maddy: Fixed the commit title]
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260513081413.222490-1-sayalip@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/time.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index df20cf201f74d..dda35c404a676 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -436,6 +436,10 @@ DEFINE_PER_CPU(u8, irq_work_pending);
 
 #endif /* 32 vs 64 bit */
 
+/*
+ * Must be called with preemption disabled since it updates
+ * per-CPU irq_work state and programs the local CPU decrementer.
+ */
 void arch_irq_work_raise(void)
 {
 	/*
@@ -449,10 +453,8 @@ void arch_irq_work_raise(void)
 	 * which could get tangled up if we're messing with the same state
 	 * here.
 	 */
-	preempt_disable();
 	set_irq_work_pending_flag();
 	set_dec(1);
-	preempt_enable();
 }
 
 static void set_dec_or_work(u64 val)
-- 
2.53.0




