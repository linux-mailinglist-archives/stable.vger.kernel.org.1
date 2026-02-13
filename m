Return-Path: <stable+bounces-216114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MzXBmosj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:51:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CEE13690A
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3244F304D929
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D47135FF62;
	Fri, 13 Feb 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kVdFVw1X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0235FF6F;
	Fri, 13 Feb 2026 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990681; cv=none; b=n4MKNCJqM7jQOOPXiAz34dxcz/fyODTMIYdGglgJOZTsVwFv4ZIIC9chcejKJRQo7qBVlDqbxAfKI9cFZh7shutpDX2aPftXbfA90TjFVmYhdr563/bCZwzM8mCgFTWBAPKZkFNeShRMnil7PRtzMnXuZRklc2AvoDSWH67Jv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990681; c=relaxed/simple;
	bh=4PqD2sbK7vf6qK7kG2u5bp1h8+ZID5y0UVFjAahYBoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDFBTY9QgA4BrvxJSQxJexwGN9WczgHVRZrGcdO8G7qadM5RzUnMRGDlX2rzBMGboYCnmdfHmYToG5oxXyVS5AYeum4vxpRDXNqmEsTY+ky/jGe8twKx0R+pa1xO7ZgEQrwc/F1qsZ50loPzAbN4G5/EbEbch3AMTrEsTQdW9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kVdFVw1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E52C116C6;
	Fri, 13 Feb 2026 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990681;
	bh=4PqD2sbK7vf6qK7kG2u5bp1h8+ZID5y0UVFjAahYBoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVdFVw1XOfEmNbHNs5yky02mcuABLf8ZMYs/Q38r6EAshs/8XePR0nXw2y4JEhSY1
	 NqIIKZjPmyFo+4zBpK2gwyEeJxTZEMwcrqUsq06KuaSXnYaabUQhoXQLJKCyIC1NSO
	 7a96EksEX/Br6S3x9Vp8k83NCyYDjor785mSrifE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.19 43/49] sched/mmcid: Dont assume CID is CPU owned on mode switch
Date: Fri, 13 Feb 2026 14:48:02 +0100
Message-ID: <20260213134710.292691810@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
References: <20260213134708.713126210@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216114-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,wdc.com:email]
X-Rspamd-Queue-Id: A5CEE13690A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@kernel.org>

commit 1e83ccd5921a610ef409a7d4e56db27822b4ea39 upstream.

Shinichiro reported a KASAN UAF, which is actually an out of bounds access
in the MMCID management code.

   CPU0						CPU1
   						T1 runs in userspace
   T0: fork(T4) -> Switch to per CPU CID mode
         fixup() set MM_CID_TRANSIT on T1/CPU1
   T4 exit()
   T3 exit()
   T2 exit()
						T1 exit() switch to per task mode
						 ---> Out of bounds access.

As T1 has not scheduled after T0 set the TRANSIT bit, it exits with the
TRANSIT bit set. sched_mm_cid_remove_user() clears the TRANSIT bit in
the task and drops the CID, but it does not touch the per CPU storage.
That's functionally correct because a CID is only owned by the CPU when
the ONCPU bit is set, which is mutually exclusive with the TRANSIT flag.

Now sched_mm_cid_exit() assumes that the CID is CPU owned because the
prior mode was per CPU. It invokes mm_drop_cid_on_cpu() which clears the
not set ONCPU bit and then invokes clear_bit() with an insanely large
bit number because TRANSIT is set (bit 29).

Prevent that by actually validating that the CID is CPU owned in
mm_drop_cid_on_cpu().

Fixes: 007d84287c74 ("sched/mmcid: Drop per CPU CID immediately when switching to per task mode")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/aYsZrixn9b6s_2zL@shinmob
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c  |    7 +++----
 kernel/sched/sched.h |    6 ++++--
 2 files changed, 7 insertions(+), 6 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10729,10 +10729,9 @@ void sched_mm_cid_exit(struct task_struc
 					return;
 				/*
 				 * Mode change. The task has the CID unset
-				 * already. The CPU CID is still valid and
-				 * does not have MM_CID_TRANSIT set as the
-				 * mode change has just taken effect under
-				 * mm::mm_cid::lock. Drop it.
+				 * already and dealt with an eventually set
+				 * TRANSIT bit. If the CID is owned by the CPU
+				 * then drop it.
 				 */
 				mm_drop_cid_on_cpu(mm, this_cpu_ptr(mm->mm_cid.pcpu));
 			}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3758,8 +3758,10 @@ static __always_inline void mm_unset_cid
 static __always_inline void mm_drop_cid_on_cpu(struct mm_struct *mm, struct mm_cid_pcpu *pcp)
 {
 	/* Clear the ONCPU bit, but do not set UNSET in the per CPU storage */
-	pcp->cid = cpu_cid_to_cid(pcp->cid);
-	mm_drop_cid(mm, pcp->cid);
+	if (cid_on_cpu(pcp->cid)) {
+		pcp->cid = cpu_cid_to_cid(pcp->cid);
+		mm_drop_cid(mm, pcp->cid);
+	}
 }
 
 static inline unsigned int __mm_get_cid(struct mm_struct *mm, unsigned int max_cids)



