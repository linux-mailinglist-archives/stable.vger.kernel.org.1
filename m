Return-Path: <stable+bounces-244308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mADCBPW2+mlsSAMAu9opvQ
	(envelope-from <stable+bounces-244308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 05:35:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE354D5ECF
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 05:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FA0830416A8
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 03:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF932DFA2F;
	Wed,  6 May 2026 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inkirFqI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF828B4FA
	for <stable@vger.kernel.org>; Wed,  6 May 2026 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778038495; cv=none; b=N+3FwiPRX3vivpfuixRv4o7NXVuJVx2DeNNt0guAM/jU+kzipa7PT0WI+fghANt3n0cXWMuz9jYaMbt1Bg7Q+GNh6/i7eEhpVDVJWUdhj8VKdZzAS4PLk7wk926x51zxKLYQ+E3cTW0ow4y+GgUO7GE4vtmFlHiYWkEl/GBTBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778038495; c=relaxed/simple;
	bh=aGl0FFslKa/Rl4d04+/BDVaWg4vCkgnn57v9of+wR7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r7wNxlbWV9ynoeGf+pMhj9bqvD9LwHOIVSL9UDkF/6mJiRlxd7/dwEadXeZtOvSF/Mwnv9LLjDMDzg8KdTUw/SoS7YGWrZDhngXntB+sq2plaOdC1/bnOVW9YbBPpKgZ/TcQwMddSijMo6xOryddejqaCRpGYRzaiXaSDSapX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inkirFqI; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12e332315a8so1202022c88.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 20:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778038493; x=1778643293; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UV5FKrfWHwBi+1GNXlHYzL1K9RCWMMuYYjYFQ6+sCZk=;
        b=inkirFqI0V06POq1pn0uVjKtm0RbGKNElaZ6gTvF/atAnDYuBqHJ7tpPdEYfF/jB5j
         5mh1meOYrK1p8r9lhSp4q7mgjYx+CI2UyjiWNoHBN+63KXhd0RcfU3MuPF9kx68/Xxg/
         N/qEgg3svxa12SZ1PAPCQjhQS0ATmzkd+Q8RdzKmj1rMkSaf6xAX20Mfe4lml8LNLfuF
         C97ovDbSxehTufHuThZ+bTyJ73ixC+pZ6mz++xV7btVaFQ/0awAGR/z/KxQHOXWurE1J
         5ewbEHUe9xMCmDPb4B/f900YSdHK+Dtwfi0yBc4qi5/O6cTWXCOmFoiTwYcb7sN6En1M
         shrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778038493; x=1778643293;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV5FKrfWHwBi+1GNXlHYzL1K9RCWMMuYYjYFQ6+sCZk=;
        b=mASQJB1KfoxQ/b45gJspZWdVrD6pyom4crfAA2+lxNu2fHfvDdRvVOIyWIVKl66Mbg
         7mnv/W726xIFo9FMzBb6ssdJdlxJaxQjWLQ3K8znGSymNK8te1aJWqQ38l2iePHDo1/C
         WEpbn/bRWufMDfm6PVjcwrfe5qOKPkCxTvwWYjQeYVD0TO/09msXWk8ZVN8kI1Eo4Q59
         rOSgI2ADw0sUsEJIhtUn1Ia57MYg1Xp2iiB0mB52mIr2CQ13KrePQI9j8DVdWn9R9j0g
         45JIjFrEIXqAmnvr111coNgkRgTuMKJOusdpeozde5fycoiHgzfkq/Ah8saQga2Kn7A+
         G2pg==
X-Forwarded-Encrypted: i=1; AFNElJ/beyEKpwk+ICR9Lkz9/t5m8Gx3hn1LWmeZy74q+AQxEI92rr7jyFMRSyA3DXpspMreR8vJqtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvC4jjDqnGic5Fu1Xx1p/9CRNYpXTgERvEONU4k8jy8dSJxxRf
	Pi1TzWdkmRVF7RdFWYHyHaPGxDu7sTjpu1LTTyvCG7c17SUh+DW7hmpw3apC/JCx
X-Gm-Gg: AeBDievS7ICLda51cBmjezdQC3PSOphDIMQJccxNLhDfurnoHdCY4K4OCbauD9yY1ay
	m41fX2NjhwMzxSBVInhjXohYAcB/d7iwmhEwjGYOClNoufr1RMFKOFLKnOSEP4Sud02o2WPeAZO
	WPLsZ3CypodVhQtYnrHiOeXl+FpOfDdOiS+LiUPTBWoscC+aKKKy1xBJ/lSY89J/ABmaSzp5ZR9
	rkg16E7aeUULkVnB1sPLN86vvfWfNS8RI3YY99bIqYdS5m1TZtNvT0KgkZ+QCxJwRhE7dVF3X43
	Qd87VTHbVau1RbAs+RInfcZPbLnPD9lz3PP0wQmm4XtlIGHGZyQ6V9TuRKPgIK5Bb81tEE4LQVD
	irn8kFe+C+f23tvvTrd46bVbtvpajiBDbAt4B94MY4VdpnaJRvY5S3ZMCJv4V6/36hZsiHgXrST
	D1kkc2+XobK+PNUivAQUUdF++ADcDOy2hYO0wLzxxbmDV+4ZPtfLBFcKvgR0f/NxmNFm+5R4TMF
	m96SqgKKNOt
X-Received: by 2002:a05:7022:4593:b0:128:d51a:5161 with SMTP id a92af1059eb24-1318e7f7f75mr1073101c88.27.1778038492984;
        Tue, 05 May 2026 20:34:52 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9789e3dsm1787536c88.8.2026.05.05.20.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 20:34:52 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 06 May 2026 00:34:47 -0300
Subject: [PATCH] ALSA: core: Serialize deferred fasync state checks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-alsa-core-fasync-on-lock-v1-1-ea48c77d6ca4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDugQYX2KqWLZJzYUUlKphVFv
 LuxLt/i/w2Uk7DCo9gg8SwqMWRUtwLobUPPKF02mNK0ZW0M2kktUkyM3uoaCGPAKdKIDTnqmsq
 3d+cg55/EXpb/+vm6rD83MH3PH+z7AYoGiV18AAAA
X-Change-ID: 20260422-alsa-core-fasync-on-lock-5cbcd51f69bb
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=aGl0FFslKa/Rl4d04+/BDVaWg4vCkgnn57v9of+wR7E=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJm/tt2ysy66Vstpf2JTypTwdc53Ijseb0lYyMvG7mB0m
 c0sKuRWRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAEzEzIDhn5Wt8SbRmUJBF3qf
 Gi5+La35/92Wlf3lf66v+fYx77atSzkjw+MV+5Yz2wek6K9bqStxqVt/ZijLuY3sy2I+13Yd/WA
 hzgkA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 7BE354D5ECF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244308-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

snd_fasync_helper() updates fasync->on under snd_fasync_lock, and
snd_fasync_work_fn() now also evaluates fasync->on under the same
lock. snd_kill_fasync() still tests the flag before taking the lock,
leaving an unsynchronized read against FASYNC enable/disable updates.

Move the enabled-state check into the locked section.

Also clear fasync->on under snd_fasync_lock in snd_fasync_free()
before unlinking the pending entry. Together with the locked sender-side
check, this publishes teardown before flushing the deferred work and
prevents a racing sender from requeueing the entry after free has
started.

Fixes: ef34a0ae7a26 ("ALSA: core: Add async signal helpers")
Fixes: 8146cd333d23 ("ALSA: core: Fix potential data race at fasync handling")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/core/misc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/core/misc.c b/sound/core/misc.c
index 5aca09edf971..833124c8e4fa 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -148,9 +148,11 @@ EXPORT_SYMBOL_GPL(snd_fasync_helper);
 
 void snd_kill_fasync(struct snd_fasync *fasync, int signal, int poll)
 {
-	if (!fasync || !fasync->on)
+	if (!fasync)
 		return;
 	guard(spinlock_irqsave)(&snd_fasync_lock);
+	if (!fasync->on)
+		return;
 	fasync->signal = signal;
 	fasync->poll = poll;
 	list_move(&fasync->list, &snd_fasync_list);
@@ -163,8 +165,10 @@ void snd_fasync_free(struct snd_fasync *fasync)
 	if (!fasync)
 		return;
 
-	scoped_guard(spinlock_irq, &snd_fasync_lock)
+	scoped_guard(spinlock_irq, &snd_fasync_lock) {
+		fasync->on = 0;
 		list_del_init(&fasync->list);
+	}
 
 	flush_work(&snd_fasync_work);
 	kfree(fasync);

---
base-commit: 0d672ef050d4e1c3891c9944f72c85769978bbee
change-id: 20260422-alsa-core-fasync-on-lock-5cbcd51f69bb

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


