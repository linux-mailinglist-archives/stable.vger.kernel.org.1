Return-Path: <stable+bounces-242512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPR6CaEC9WnAHAIAu9opvQ
	(envelope-from <stable+bounces-242512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:44:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F4C4AF4CD
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE366304E31D
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA770421F17;
	Fri,  1 May 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viMRSb1e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21rA0Hj2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C21421F1B;
	Fri,  1 May 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664422; cv=none; b=trpZqnkpvnVNNvjN15TLb+HvFI460NajLwptODZN5lvMfchRVzVncZMCRWbMc8yMvGkNmhS84zuTKPGkYo/MsQQbkrXenoyCdb3hccoLtgrZHUDq7VzFkkllNVIPcXY6bcfAhAUwtmbx/Rs312vX4D/4lJkTW6/jtXzQhhL7gMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664422; c=relaxed/simple;
	bh=Y3dP55OpUbT0iGURtuKB5JQzOYDhZ2lmVWEkuWHuVGY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=KgfVsRtYe9wV31nwrYeonWIlpdV4DvEHDrpGSFWx+d1iHta71qm5VTy3/fW9lh5XjXMh/IfSmMQnxvfRWwzS7utVic0QKHZtRdkEXoLeflfAEwu96uoIK9hFZedWUMluWW38zvLT1WzGizpPvHdwDI28PS6c6bCmPGG3a7crD74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viMRSb1e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=21rA0Hj2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 May 2026 19:40:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777664417;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CRXEhULAjmXeh4RbJTke1IVnySSF7CqFNNM+UDOBHxs=;
	b=viMRSb1e4rrBI/FwTFdI6+WVk771eH7+mOFKOZ722yt/25zsq0QbY7efPQ//aljSUeduJO
	3igaIAJA1fYTa0QqnT3Ut63Y7DtChdn13QKJ87eFQtq9w/uMKYc6uRFsYn/LJfnDSYNPC0
	UCLTLkvbArBgFsHBWjQ8iwbzbFoFU+afAfy0xI2RjD9rbOEjPGsqj2+FQjFC/h+Gohn79n
	TSjM6Di2zvC/C7Lg7N8QNC1NWlM4XDF5XHprqeiFO+8s/N62s1Wd3Zg7efNxmJio0JTTL3
	oIGoENvoszhSDhldl0jbXdCniccauTGafDDwfbPaP3K+zuSQhFlraybkAXOAjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777664417;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CRXEhULAjmXeh4RbJTke1IVnySSF7CqFNNM+UDOBHxs=;
	b=21rA0Hj2BaVsYs3UvwGJKLxbHjR6pQtyW9+aitYvbUEJTGzAjcCqeH7oAxew2JnB3rAIXL
	h3CTyAadlUU0iZDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] rseq: Don't advertise time slice extensions if disabled
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dmitry Vyukov <dvyukov@google.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177766441612.3521451.2344559394479967112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 48F4C4AF4CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242512-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,infradead.org:email,vger.kernel.org:replyto,msgid.link:url]

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     010b7723c0a3b9ad58f50b715dbe2e7781d29400
Gitweb:        https://git.kernel.org/tip/010b7723c0a3b9ad58f50b715dbe2e7781d=
29400
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 28 Apr 2026 09:34:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 May 2026 21:32:20 +02:00

rseq: Don't advertise time slice extensions if disabled

If time slice extensions have been disabled on the kernel command line,
then advertising them in RSEQ flags is wrong.

Adjust the conditionals to reflect reality, fixup the misleading comments
about the gap of these flags and the rseq::flags field.

Fixes: d6200245c75e ("rseq: Allow registering RSEQ with slice extension")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://patch.msgid.link/20260428224427.437059375%40kernel.org
Cc: stable@vger.kernel.org
---
 include/uapi/linux/rseq.h |  5 ++++-
 kernel/rseq.c             |  9 +++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index f69344f..ca6fe1f 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -28,7 +28,7 @@ enum rseq_cs_flags_bit {
 	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	=3D 0,
 	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	=3D 1,
 	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	=3D 2,
-	/* (3) Intentional gap to put new bits into a separate byte */
+	/* (3) Intentional gap to keep new bits separate */
=20
 	/* User read only feature flags */
 	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	=3D 4,
@@ -161,6 +161,9 @@ struct rseq {
 	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
 	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
 	 *	- RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
+	 *
+	 * It is now used for feature status advertisement by the kernel.
+	 * See: enum rseq_cs_flags_bit for further information.
 	 */
 	__u32 flags;
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index b9f1193..586f58f 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -462,10 +462,11 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, =
rseq_len, int, flags, u32
 		return -EFAULT;
=20
 	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
-		rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
-		if (rseq_slice_extension_enabled() &&
-		    (flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON))
-			rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+		if (rseq_slice_extension_enabled()) {
+			rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+			if (flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)
+				rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+		}
 	}
=20
 	scoped_user_write_access(rseq, efault) {

