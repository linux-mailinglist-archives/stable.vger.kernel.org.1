Return-Path: <stable+bounces-218140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOJIMONQnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F518EDBD
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D5B53071851
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57D92505B2;
	Wed, 25 Feb 2026 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aswZG/cq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC54369A;
	Wed, 25 Feb 2026 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982922; cv=none; b=EKkTgMhXLgVtVTxdJ/bfW5YAS6nNuQma+9lDMCMjyDsqKlYS17pLhX/YzmLlvqanOruAhvaVGm1+L+RpLQQqD4Clz9nIrRs/hHTJ7qXe7rHdt3BtwqydsKQu8Mhuctzfr5T//nUFiuyh5aUGuqXHpXimYpD5OZx2QyCo48xF0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982922; c=relaxed/simple;
	bh=m9X5iQog2QwkF7NALmPzdxCe1f3H01Pn2cZYyozfjdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nw+WTrBsCge491WtamjVf+ahr859TQOFX+zo46q9lM3EuOyNrxcuP5SByNDrfn+/sCn9UIe3v6Z5s5fVa5ZoV1QDlKSfTe+mepnYT0tRthGl3FTF4Q29HWiIbDFCvzmVD9PwGGrc00ieG3e3NewM2rcwYu+tZS2Vvd8kTVCCOVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aswZG/cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3440EC116D0;
	Wed, 25 Feb 2026 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982922;
	bh=m9X5iQog2QwkF7NALmPzdxCe1f3H01Pn2cZYyozfjdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aswZG/cq9Io2qLPj5J0NaheTUSYgrdGreHC4s1/cP2nsbm0niVTDJ88kKGYUhPgQl
	 Ae+QNZcKXS46SYuaJjcpNbp3dtyardZy4VfYwaIRACzYDZZJV+pEoKHnV4MjJ7wR9p
	 LYIfLof2UVDxUEJ4U+hA/GGyaXgkH5fv0oWMwZIA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amery Hung <ameryhung@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 101/781] rqspinlock: Fix TAS fallback lock entry creation
Date: Tue, 24 Feb 2026 17:13:30 -0800
Message-ID: <20260225012402.164266315@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218140-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 382F518EDBD
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 82f3b142c99cf44c7b1e70b7720169c646b9760f ]

The TAS fallback can be invoked directly when queued spin locks are
disabled, and through the slow path when paravirt is enabled for queued
spin locks. In the latter case, the res_spin_lock macro will attempt the
fast path and already hold the entry when entering the slow path. This
will lead to creation of extraneous entries that are not released, which
may cause false positives for deadlock detection.

Fix this by always preceding invocation of the TAS fallback in every
case with the grabbing of the held lock entry, and add a comment to make
note of this.

Fixes: c9102a68c070 ("rqspinlock: Add a test-and-set fallback")
Reported-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Tested-by: Amery Hung <ameryhung@gmail.com>
Link: https://lore.kernel.org/r/20260122115911.3668985-1-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/rqspinlock.h | 2 +-
 kernel/bpf/rqspinlock.c          | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 0f2dcbbfee2f0..5c5cf2f7fc395 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -191,7 +191,7 @@ static __always_inline int res_spin_lock(rqspinlock_t *lock)
 
 #else
 
-#define res_spin_lock(lock) resilient_tas_spin_lock(lock)
+#define res_spin_lock(lock) ({ grab_held_lock_entry(lock); resilient_tas_spin_lock(lock); })
 
 #endif /* CONFIG_QUEUED_SPINLOCKS */
 
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index f7d0c8d4644ed..2fdfa828e3d35 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -265,10 +265,11 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 
 	RES_INIT_TIMEOUT(ts);
 	/*
-	 * The fast path is not invoked for the TAS fallback, so we must grab
-	 * the deadlock detection entry here.
+	 * We are either called directly from res_spin_lock after grabbing the
+	 * deadlock detection entry when queued spinlocks are disabled, or from
+	 * resilient_queued_spin_lock_slowpath after grabbing the deadlock
+	 * detection entry. No need to obtain it here.
 	 */
-	grab_held_lock_entry(lock);
 
 	/*
 	 * Since the waiting loop's time is dependent on the amount of
-- 
2.51.0




