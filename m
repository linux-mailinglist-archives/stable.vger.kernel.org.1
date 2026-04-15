Return-Path: <stable+bounces-238204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBoeOLro32kNaQAAu9opvQ
	(envelope-from <stable+bounces-238204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:36:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF8407669
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E2273020EC9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B14346798;
	Wed, 15 Apr 2026 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCKE2mof"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC92334C17
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281776; cv=none; b=DEJifoFZeoICw0Te3b3Bne71/YnKCB2+5Aey3ZYuh9ITjTvPS8LgnL+/4qwbZDpE+MNkPTM6McHF+IpBPzK926AMXnl/THx5hOzPA/UWuYr5eeC/4dP151PhJcx5qJjnwBrq/7siQm3uDQBnAN4916v2ADBbS4T2EKMs1xb/KgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281776; c=relaxed/simple;
	bh=3PJEU8igOIlkmnCg9XmCLrfQJ/utVhcr8k3kYGS3Obo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSiLHrBHarFDaJYUan+6Of/DsmwVJgYBTg566uUtr5AaA++D4GmUmXoD8CKPVyamChn30FzGPbl9mobdxIvsyQEPL2YCLXrxBDklOGDMWwSto/+0tJENZQ+Q/1OdFcsEgaADcOQlL48GVYYFbP4lGo7CjoooQeygAp0b8P8tDUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCKE2mof; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c79662bbd2eso20233a12.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776281774; x=1776886574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz9bMfi91YOLLJ4kszgcbcahbPfD11cvB1ZlFvmz24g=;
        b=VCKE2mof/A6brOvkIGv5kqW434RQdW32ZTTJ0VxvhrvsuUfLx0B9Mx7Xg5Cp0SHbmH
         dUeUS+5rf9HhyXyoHRUZhsG7pp313ZewYTaH5j779WPmBv3VWQKIASXN4Zx92aESeMZX
         j0zJvg1A93YuIfib5vfyHAXLaB7fR8rbjQNeryifCG3A5kM+quVgArtAQudikAmrOJy+
         y72UaPUr5xWvVQ0w025gRuoiKKvoD7e70tWnYZo1SuhPhmYiy+z8aTFIE50uCbqgXFHp
         r+WhAfvg8X7X2rEDpabmNHbtYlv3QuAkNz738TLt5CPQkYtJanU/nrdTyZ0clzh1U1ez
         rGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776281774; x=1776886574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz9bMfi91YOLLJ4kszgcbcahbPfD11cvB1ZlFvmz24g=;
        b=QJC+VdyTk+QgswwYmv3YxaGrvq8d01yeUhIUUWWwZ6LGj/azdWUjH9eHPMF9+N4vwP
         BH/rtik4bibYJnkLMp+bJ/uo1fHLkAUpvEiZ9Bw3hXdnZZsXqilE9SLP9xdijTU1ZUIj
         cwQr7FXaImEVUQusS2m4mLbN9u1oaE5OVEMA8kDk3oKL64f1rO5k41eXLIeOnNg9jAna
         boKS/Nz7vmeiGrAW5uLH5tSP4qbqDH2A3h+jCwBqCPdYsKzKYyxrNNQ8s+eSj5QCdh5j
         q69vtL7ddkuu5CfBftcPzdcCHV+vvddQZEMpOLwk26oxeDm5MkN6iQ5Bv1MEpPs4VLzy
         0Kqw==
X-Forwarded-Encrypted: i=1; AFNElJ9YasiTryXUFXZwhorDYUJDzE/3Lhq+LVlmN2MeqI44vanpDCApn8YnMhGkDBO6L+T7JEQ8Cc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX4VGKQHY6by33Ny/W6Ij9kve8Z6FOQ+xMp6aS4RT0z9QR6WMN
	buz30Z8Xh8G4Nbt3aHMfjTWtZgU25leGXjclaqDx0j5CZKvt1Ihi9pAo
X-Gm-Gg: AeBDieuPS1pi8g4NBqOSqWsKRwKZKtw+QBq3+x3UeWe7QSy1rTeiFdYoL77Pj46J26G
	wu3GB6FGqHNQ+1HeoKUGZX92OZv2KjjqjhwfcoBL/pa4vVR3P8QKeRmLRXkvUoGYp/o+gZFl5T9
	duZck+fSjvPitNEAESn776jZXBAuQ+EbqVTGAjh2DNCST61r8OxglMb2HJwscAZl9NSCD/RiKKM
	IjjIy8Voe3v9ggbUgxf4k4g51I2cbrnaw35gWN35W9f2lCz9KLhfcQw/XmvnNX0RVVGwkg95X0F
	1Qm7DNWs6ndh2ekRkyjG3nzvzq11gpi7q4DlKZj46Fs8Hyjsc03fFV1b0aPu/KcSCcWtrN+q3Mr
	vIEy///dxtTQ+Ifv1C41FkHUbqIekLuW2zZ1nIEdkZGOZuIzXg72fmfhMKd61hkjr7eGviaQ/fg
	iOkgj9G3kuHXhZuuwS75v6AeuBEff+zc8S7HfRWxwmtlb6h0Qq9OvLUxyWAhGT
X-Received: by 2002:a05:6a20:7494:b0:39b:9644:6e93 with SMTP id adf61e73a8af0-39fe3c748demr27510095637.6.1776281774367;
        Wed, 15 Apr 2026 12:36:14 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:49:cbd5:ab58:206c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f741addb1sm1069076b3a.42.2026.04.15.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:36:14 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] sched_ext: Prevent RB-tree corruption in scx_bpf_task_set_dsq_vtime()
Date: Thu, 16 Apr 2026 03:32:44 +0800
Message-ID: <20260415193459.933175-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238204-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BAF8407669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

scx_bpf_task_set_dsq_vtime() allows modifying a task's dsq_vtime without
checking if it is already enqueued on SCX_DSQ_PRIQ. Since dsq_vtime is
the rb-tree sorting key, mutating it in-place violates the BST invariant
and corrupts the tree structure.

In ops.dispatch():
	p = scx_bpf_dsq_peek(PRIO_DSQ); // Get a task already in the DSQ
	if (p) {
		// This illegally returns %true
		scx_bpf_task_set_dsq_vtime(p, 0xFFFFFFFFFFFFFFFF);
	}

Fix this by adding a check for the SCX_TASK_DSQ_ON_PRIQ flag. Disallow
vtime modification and trigger scx_error() if the task is already queued
on a priority DSQ.

Fixes: 3035addfaf28 ("sched_ext: Add scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime()")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 012ca8bd70fb..7a54f9bc5e7a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -8540,7 +8540,8 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
  * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's virtual time to @vtime. Returns %true on success, %false if the
- * calling scheduler doesn't have authority over @p.
+ * calling scheduler doesn't have authority over @p. If @p is already enqueued
+ * on a priority DSQ, scx_error() is triggered and %false is returned.
  */
 __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 					    const struct bpf_prog_aux *aux)
@@ -8552,6 +8553,11 @@ __bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
 	if (unlikely(!scx_task_on_sched(sch, p)))
 		return false;
 
+	if (unlikely(READ_ONCE(p->scx.dsq_flags) & SCX_TASK_DSQ_ON_PRIQ)) {
+		scx_error(sch, "vtime modification disallowed while on a priority DSQ");
+		return false;
+	}
+
 	p->scx.dsq_vtime = vtime;
 	return true;
 }
-- 
2.48.1


