Return-Path: <stable+bounces-269542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yr50Ek9KQWq7nAkAu9opvQ
	(envelope-from <stable+bounces-269542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CA36D45B2
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=QMGAoagK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269542-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269542-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9F8300F510
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40A1E51E0;
	Sun, 28 Jun 2026 16:22:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ECD548EE
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663746; cv=none; b=qFGDuOc1W/HVR6rn7eV3M9HXlE7ZJCJ4LJBk+gPAWIe+mCWHFqtGO2SJteoT9GKY3eeOtKaY2h84hBKGEcJXuqgPrNw+cvrlooeMlAR5pVSmU0e9G7VgtNkL7LJCrJcpyaqwL3wkRUbWeskQR7UXGRVFh63jSf4OxZK4gFZYqXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663746; c=relaxed/simple;
	bh=t1OgmKZDh3/38NdHpSUs6mcJku0vsJub3xpAUZnYb14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yg9brHImxrBh02x8qdS1E0VoH9n0TxBvALp9g90Y5ZIEWWQmrcGn5qqhHb7o0TJbo3gxZC95oAisVsxO2Dpw7jscDkdljBWHIowhTJW5MpmStOqzQEv0yhBSymPNWPc1W75kvq3kbOBipsi0Y7cnNlFmDO//g3Lx9kYjJXT3yIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QMGAoagK; arc=none smtp.client-ip=114.132.67.179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663647;
	bh=J+qerMXjp2uQspZqOXxy5ALb9tqhGPqrYYrlO5MsSLA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=QMGAoagKwgv98KpnebWzmubTfB+kh+BcoRWLM23qd7arTg1rJkDQBy6eZB1VNPly8
	 dOs1b1Fxdk7isYdqljTooZEEXbnDnfnuCwqLL1wA+r8mzU4248gaQW2eKNTnmKB87S
	 gkgaI4T30xKPJcwBGjZTEQZ10DrQVZG+SvdNzPJc=
X-QQ-mid: esmtpgz10t1782663642t82b2726a
X-QQ-Originating-IP: HdQVeT4i48V/0oRvaDSvECRP7ncp+sw+vUTqtpqkLSs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:20:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13433364519093346513
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.1.y 7/9] eventpoll: rename ep_remove_safe() back to ep_remove()
Date: Mon, 29 Jun 2026 00:19:39 +0800
Message-Id: <20260628161933.532572-8-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <akEtsUNOcuws0xPC@eldamar.lan>
References: <akEtsUNOcuws0xPC@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OYcWkDQesdWF2jU6ckvCknSQX9SZ8Ktlg8DTWSI9cJaMdBHcvf8CnpeB
	3gYwaP7ZzCL70piRCWgp3qRV7cP4fjeG1d0SefdSDhNLDo8UEF+JShT923ypq3NSlr58XE+
	vynpMFrT5duSDEGmRjNVzRTMb0V+49z9gdi386b5tvgpYeS6Tva7W1NsD63K/q+4zz/32ha
	BhZ6gEUZyOZ989Yox/F51JoBf3T1Awj8KjHTMbzMx4d5meQek+HF1DtFgTD9iUoALbylr6A
	Vwf+6469hCUyfze7XEW2vlBd/vclwfDsyN6Zyi+72wx3ChtfZEKC/Bwaz64db8PrFEMjN6N
	o1o7Rgod1M9qxxC6kEgF60brwZ+0qkNITBbdWbHP27B2l9Pc4jJW6LRK7/1aFC/wORadbPi
	MDK7C0Dr85+Il3Rq8eAgsDlpzUGWbPzsh4Lw/fWJkRhkwJpXYbaCAYll775CnNdQsvlnx3/
	SPXTVwYb9JZcHCzHWw56C7I1XN+pJ+VQdiFg2n+6v6JvniXhMal739zL4IdqQGB+aA55o59
	rHn2SlpE0+mcaHFKfigXX/TUEkcjWlU0Va4hmIflg1il1yDNi9uWMPAGPPzmRhG13++Te99
	wDqNuch3LUhqRyzns4Q1i/fBdG2ByM1BoC6f06xK0BjZ4VVnafChBsCwace8Hbtsixg44tz
	MqnCSDLglFOUdbAQ4nfYFhE27b0+UaY1jkhSwMncTdHfh40IcspBEAPKxUCWMN1qY+n5u5H
	I+ziW7/O2/xuIU2ApLxDmVn6WqH3JhCUUUJoYaixa5NLAZHcEAJkaGRyTgywcO9bLRbUPA0
	iFkafivveuGRh9bxKQSIKnquqXeEc3Ab/HynswqUNQK1a6cPO83e12gmjHDrZSTUpHXuwuq
	glrC5A2aKAbi5+3c8IIFtq9RpZgSIBOd18e//JoVmB97T5q+j61dknLqCvZDXp2OZa56S68
	VNPy2OssDpLgGENTaP3f+SKdS/ffiQUN9m64CnTqbuQCLsTsPw2kIiyRk6+W4aX7XmFszcT
	dQoLJ29St8pkSyjr1W9NPGoqWntr9gEuGb55fV4SS6C8dK+SoWxDdfvhogeDqHzKtzEx5XS
	rCQKrTzsSBOwnHUG78Ye7OZAVLdAj8DwZCgkKCvG91phV/Fz7CJOEB4VOkS7fqwtw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:query timed out];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269542-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:carnil@debian.org,m:benh@debian.org,m:brauner@kernel.org,m:foss+kernel@0leil.net,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:quentin.schulz@cherry.de,m:foss@0leil.net,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[cherry.de:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	DBL_FAIL(0.00)[cherry.de:query timed out];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3CA36D45B2

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0bade234723e40e4937be912e105785d6a51464e ]

The current name is just confusing and doesn't clarify anything.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-4-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/eventpoll.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c63c2c46869e9..2a335dcb995c0 100644
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
 
@@ -1505,21 +1505,21 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
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
@@ -1543,7 +1543,7 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 * high memory pressure.
 	 */
 	if (unlikely(!epq.epi)) {
-		ep_remove_safe(ep, epi);
+		ep_remove(ep, epi);
 		return -ENOMEM;
 	}
 
@@ -2222,7 +2222,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
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


