Return-Path: <stable+bounces-254722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKoTIabiF2pOUQgAu9opvQ
	(envelope-from <stable+bounces-254722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:37:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E75ED502
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 08:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4F1730EED35
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70C31F9AC;
	Thu, 28 May 2026 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBZEd604"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B093321D4
	for <stable@vger.kernel.org>; Thu, 28 May 2026 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950004; cv=none; b=T4FsmBKXV47VtMuLtOTVvJcGMlMwyJ2vrfP2AdPHG/SqqPkBCao2QKruVFjVX/SgmFGZSSZp80JopaujvqF2k9hyHy4z0spRZPo4yqM2ytVxu8LTOipWAEbCaVetWrDtyroB5PUvLbcY6nHfvFdY43qZ4CeSUd1IknE3f6m0RT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950004; c=relaxed/simple;
	bh=aro1TDCeOiWY0+RzyW2elDOAf2h3a+8DCzCJJvqEZLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGBnHdn4H3FCImU28uZGxfSCG5BWadFpzNkd6ghJqcZOeTlrdHzcV9qWOoeXIbuYbfqbQpNBKdd60GpjBTLYSw7K+rHKDWCjYXZlKq1xqSV3dyip89JwF3DxYP0n+7cUjHmw6UcV6kPt8/eNpWQ5Mfo8Am0YNsyqPUe8MZNVpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBZEd604; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-835386ff122so12591407b3a.3
        for <stable@vger.kernel.org>; Wed, 27 May 2026 23:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779950002; x=1780554802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZfTQcGtDAIuHbsFKSWK4VJ69GdmAZwJ+7pbD2EwyB0=;
        b=gBZEd604Esd4+rWrApOgBltIbx4tbLfU5Ezx7+c/Xj7rkAGYz0zj40tYs7MWwJpMrF
         6jHldbEynVNAqvUIxpV7w2ncHJ6COt3f3HQ3RMiu+x1j/mCUmHsr6RSKS2+3tCjiOosy
         8vPAdxF77QsoJgOA4oFv9JovF2+MCMSXqpemwc5+aXtIDB73jchUTSTs+6uVycijophP
         Pa2S7JDCvt+/K1kSYkPijPNTcwWePx9oHbvwm6QYTCsM9oThMnOMbf2ldBQax55cZTEZ
         kq+wcFXGcxFr+4bhMgTRleYSfqX9dylaFZUyvpQntzKBLJfc1mgVrCGW9VLb1Njbg7Ny
         loEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779950002; x=1780554802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZfTQcGtDAIuHbsFKSWK4VJ69GdmAZwJ+7pbD2EwyB0=;
        b=hrhPnjnggj8fV1llajN6rNiRsK3BNeS8Fno7E4oGlA6L+21cnTK4064GmRedpRvjQi
         qgDBGfO2bjPL2HbhY5/5UcgTaXpFhfhBcLNQnilrp97ev3sIExzu0pz1QE0x4QjAvCjo
         sze85vHv3UZ06fvIeyBLlcgn3Vg64ZA31MjegYZ+H7i6rZydkX4F3LUrKxEwnavCiFCG
         IVFQSiROegrnUNA1gO7kUdXKOYnqvcMNZVCmig0emqMfO8ue1Qu0N/E627VHWPG7ICgh
         zdXRPZju2I9kFOyciF9RuDNHp7oo7ovw9PNAkmzuBgC9Nwwv5BrjEprZ5DOOAinS+fnL
         DUMQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CqpHvSqJ6mK1NRpdGrV+wmIAg4QAmnAjSj7kEDF7pCgrU7a1oFfoIp7c8sQpoqrPoa9X3Nuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaM79Fcamj3D1rRzb4vjaPXYvjxzrrp/alkA3v2FaGtYiWXm5
	ib0tZghR3FIx5fzcVJCPyPoKfI0REYrZA+bg2zgCspbDnm+DHam9w6eU
X-Gm-Gg: Acq92OEo+kzxUkSHlA1CGQquFdmQnWQ7TmPaqOn7vfzh8JGL6mC3/O+k4XE++hkITxA
	+YD7/8u5i4xwR60V2CnaW9cdt2CogOWnL8Lzpi1E80TH4zJ7lJ24A0M8V8Pp6ej/N86K10M4Zd+
	lMkhQ9J9+ySK4E9kQHHL3R4XJEArffLDJQU8XkCndLLxgnILhRyRREhLPXuNMv5ie4bRkvSkjSE
	Th7HodOrfUfQt+17qY528lzwMMcp6QR+qfgnONFfwgMqtyoLmdVpKqc3weWo4e9SkQQ3W4q/6Py
	QTPm3VF1cbAi53S2UFCdQ5w36OKuE4646DkToD9yBDl2mmkgIQRnu43+VBEHTbynXOAoAYUN+zm
	V1sQu28JB5vm2BWvWOT8La9YbDGOmKKT6yH3XVT9uhduroejjdKJYc05G52MXq3iNA5ElFTTgsm
	q3t4E+2NTuunDR4+JaD915GoATckdGuLCFRkukA59DxejOCtr8Y6AtoicGUjg=
X-Received: by 2002:a05:6a00:4482:b0:82f:a89e:e16f with SMTP id d2e1a72fcca58-8415f3fdbd5mr24554235b3a.14.1779950002362;
        Wed, 27 May 2026 23:33:22 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6d60d07sm5628781b3a.0.2026.05.27.23.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 23:33:21 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ntsync: honour caller's time namespace for absolute MONOTONIC timeouts
Date: Thu, 28 May 2026 14:33:11 +0800
Message-Id: <20260528063311.3300393-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528063311.3300393-1-maoyixie.tju@gmail.com>
References: <20260528063311.3300393-1-maoyixie.tju@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254722-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E12E75ED502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ntsync_schedule() takes the absolute timeout from userspace and hands
it to schedule_hrtimeout_range_clock() with HRTIMER_MODE_ABS. For the
default CLOCK_MONOTONIC path, it does not call timens_ktime_to_host()
first.

A process inside a CLOCK_MONOTONIC time namespace computes the
absolute timeout in its own clock view. The kernel reads the same
value against the host clock. The two differ by the namespace offset.
The timeout then fires too early or too late.

Other consumers of absolute timeouts run the ktime through
timens_ktime_to_host() before hrtimer. Examples are timerfd,
posix-timers, alarmtimer, posix-stubs and futex. ntsync was added
later and missed that step.

/dev/ntsync is mode 0666. Any user inside a time namespace that can
open it is affected. The visible effect is wrong timeout behaviour
for Wine in a container that sets a CLOCK_MONOTONIC offset.

Reproducer: unshare --user --time, set the monotonic offset to -10s,
issue NTSYNC_IOC_WAIT_ANY with a 100 ms absolute MONOTONIC timeout.
The baseline run elapses about 100 ms. The run inside the namespace
elapses about 0 ms.

Apply timens_ktime_to_host() to the parsed timeout when the caller
did not set NTSYNC_WAIT_REALTIME. The helper does nothing in the
initial time namespace, so the fast path is unchanged.

Fixes: b4a7b5fe3f51 ("ntsync: Introduce NTSYNC_IOC_WAIT_ANY.")
Cc: stable@vger.kernel.org # v6.14+
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/misc/ntsync.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 30af282262ef..02c9d1192812 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -19,6 +19,7 @@
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/time_namespace.h>
 #include <uapi/linux/ntsync.h>
 
 #define NTSYNC_NAME	"ntsync"
@@ -836,6 +837,8 @@ static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_ar
 
 	if (args->flags & NTSYNC_WAIT_REALTIME)
 		clock = CLOCK_REALTIME;
+	else
+		timeout = timens_ktime_to_host(clock, timeout);
 
 	do {
 		if (signal_pending(current)) {
-- 
2.34.1


