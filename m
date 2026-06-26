Return-Path: <stable+bounces-268728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JCNpDu38PWoe+AgAu9opvQ
	(envelope-from <stable+bounces-268728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:15:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEFA6CA13D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:15:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="CqSR/2zY";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268728-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268728-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02D54305653D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AD30C177;
	Fri, 26 Jun 2026 04:15:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385E2571D7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:15:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782447335; cv=none; b=O64eX8zYSTukR+ZrzdcNmP8vodcsOcnZ5Pm7ZZNY7JOu6RG8uf0DsFcasLvsSQIchmzK9Ghq0kOQePDrgYGseUdsk8inyTvL4p4EJo5MBK1JXvFhpk1R2yNzOZu1qG6v6eAfSSuvH1r03lL0ccki0Wzqq8NiYUuklMYTLRVVQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782447335; c=relaxed/simple;
	bh=F8ZVhFjGUtKIaRj3F41eP0fPctRQDbknKoKt+EhQdzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiFUCME8qnBrnxu7n/TXWw3ghpHWWcHD1nMGU5C9JsdaCa2FML5RR+Vd2GE+XJ2U0B9uy4YM0QEud8m/+uZwPH41dVH1CFUDFAPINtcAQ2fnBYa0EmdYyyWChSsbeOIF8CHkZAwQWoWvfVIH9obCG9z8iX7Kb3DIuCQ10I5dz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CqSR/2zY; arc=none smtp.client-ip=54.206.16.166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782447293;
	bh=lpY3Zdfgcu8mc5g0PD2RAWWrMsmuSFhHEbciJOzp5JE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=CqSR/2zY1+0LGiTU4SVhR9b+e13AzQW9Re0BdCgXOq5eAMBwwUUTe+lA1tT9vLG+3
	 /w9utK47PUOIw7foGAEMCS8TVPNYXLDhZ1TeatXqpebsokoakruZiLNItVTmnpNbrv
	 1UNn7Nj+nK3CSDoXtRMeyXVZ+1FzEmTGKU3lWu7g=
X-QQ-mid: zesmtpgz1t1782447285tfc9bfe49
X-QQ-Originating-IP: TgENz+557nXNohvmDXMmw/pvES+RFQhxmVeO5/XpUXw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:14:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6289407196931923603
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: stable@vger.kernel.org,
	brauner@kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.6.y 6/8] eventpoll: rename ep_remove_safe() back to ep_remove()
Date: Fri, 26 Jun 2026 12:14:01 +0800
Message-Id: <20260626041403.85968-7-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MuQi2Rc0Jry0nl2LxFuAoV7k+Z1QQdy94Gxda0vyAwDBuGpsvLBYnqNf
	4OD6zxdIECZoKJvEOyTuN5QIlIXleQtk2HJh5SKDGT2FIx6zo0yTg3ExXaFmZEJJUpH30Ha
	hWh+qgqnNcr5cXeuDlSsfETbFGVO4A/qVHwF3r8Q+OSdle6LdaWGFq+p+PAVbEF46Kn+ame
	OF4vi4vbw9ALxXOghsGA1SCwTxcDbQWaVd0QJV/70JgkmwbNzPL87R3I2/NFMY/KnRXtqL3
	E0eTkYU5of7xSWX1i5Exn3/ran3kMfanJlXwe64iT75q0R7aCVn/Lj0G5S9ExDjTiHcWvyK
	E9KNvWABk8KWDKXz6Y13X1FcpSvN2zXfx9O4FNhJHwVyT2fpKZlV79Yj0xJpJBAjCDXdvZb
	ddpeBiZvYbvOkeGMGQmF1U8yMK3PWDzAQePH6+3PB1i2kwZxIZiNnri69B+g49QmsLJD8cV
	dbJbaYekL8qMKNaiWL0OsWee/YZAOImOKyRAbO3gI3uYx/M0UvSmMOXmRw9C81AwWEUGcLf
	RfXpvRoBvsNOqIGyG/fuULGkmWUtlcTExohP4BbcrgHPfLjPPuOuEP059ddJNVFVnVRIc+S
	76yrsLTxjychUtGTn+SsRIcLnZz6gmvnLfh5gAUqAhox4Z4Fm9Th+A3YQBID3K+M9eWF6CS
	5EM0b1fdjeYpKlABEqbXkZnYheNBf6K/fiWi1KtNQ1fNdCITw33EaPUrarwz6TTHvsEong8
	O7WvAg3YpiD2+3lm4HFjzaWB4V0H8RLObmRttdlwdJ6RFtaOZYiqQ5i/ZZKkjHjFP1WbMr1
	YKLlCUE+f1uapV+fkDcyGQeMxM0E07ya101wb2tlZBWoqYdj8TtDe6++djf97FxBA+2ywVw
	PeGEyUqLEv+U6NlgRtxJPlXhrKQmncqGuE6z0HpU1OqnsaC2sKkOPZ7WaAaWmysj9oVeBoE
	sUVVg+V1pD3QhN4bFNsewv1S5S9dXbxr+rsF8RdyLC1j9qrglFhZFRXH+jXIgKZFTCySkJ1
	gQ5jP7+7/1rrb/9qK+pMIMFvIzC1App7Brf1/i1YXiRiaPIWApbv5vjg4hx8UL2rYtkxXMZ
	uXPdVPk9pm75U8cmV3UqJOqpzUb28dibld2SKFN1VkY8UlUd4sChvI=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:foss+kernel@0leil.net,m:stable@vger.kernel.org,m:brauner@kernel.org,m:quentin.schulz@cherry.de,m:foss@0leil.net,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268728-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCEFA6CA13D

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0bade234723e40e4937be912e105785d6a51464e ]

The current name is just confusing and doesn't clarify anything.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-4-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0a54a42263575..db5d7c1d726c8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -771,7 +771,7 @@ static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
 /*
  * ep_remove variant for callers owing an additional reference to the ep
  */
-static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
+static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
 	struct file *file = epi->ffd.file;
 
@@ -818,7 +818,7 @@ static void ep_clear_and_put(struct eventpoll *ep)
 
 	/*
 	 * Walks through the whole tree and try to free each "struct epitem".
-	 * Note that ep_remove_safe() will not remove the epitem in case of a
+	 * Note that ep_remove() will not remove the epitem in case of a
 	 * racing eventpoll_release_file(); the latter will do the removal.
 	 * At this point we are sure no poll callbacks will be lingering around.
 	 * Since we still own a reference to the eventpoll struct, the loop can't
@@ -827,7 +827,7 @@ static void ep_clear_and_put(struct eventpoll *ep)
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = next) {
 		next = rb_next(rbp);
 		epi = rb_entry(rbp, struct epitem, rbn);
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		cond_resched();
 	}
 
@@ -1497,21 +1497,21 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 		mutex_unlock(&tep->mtx);
 
 	/*
-	 * ep_remove_safe() calls in the later error paths can't lead to
+	 * ep_remove() calls in the later error paths can't lead to
 	 * ep_free() as the ep file itself still holds an ep reference.
 	 */
 	ep_get(ep);
 
 	/* now check if we've created too many backpaths */
 	if (unlikely(full_check && reverse_path_check())) {
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		return -EINVAL;
 	}
 
 	if (epi->event.events & EPOLLWAKEUP) {
 		error = ep_create_wakeup_source(epi);
 		if (error) {
-			ep_remove_safe(ep, epi);
+			ep_remove(ep, epi);
 			return error;
 		}
 	}
@@ -1535,7 +1535,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * high memory pressure.
 	 */
 	if (unlikely(!epq.epi)) {
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		return -ENOMEM;
 	}
 
@@ -2227,7 +2227,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 			 * The eventpoll itself is still alive: the refcount
 			 * can't go to zero here.
 			 */
-			ep_remove_safe(ep, epi);
+			ep_remove(ep, epi);
 			error = 0;
 		} else {
 			error = -ENOENT;
-- 
2.30.2


