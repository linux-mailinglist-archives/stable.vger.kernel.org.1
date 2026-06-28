Return-Path: <stable+bounces-269541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xtIkKExKQWq6nAkAu9opvQ
	(envelope-from <stable+bounces-269541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C266D45B1
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=G34WybYF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269541-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269541-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB473300CE6A
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C37146D5A;
	Sun, 28 Jun 2026 16:22:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD9ABE63
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663744; cv=none; b=oPBmWPEbNUs2EHLO+4kw2rFzXnqSLHvoj4aqaG7aBqd+IW8UlDluFl26wztfup+SR+1ERekf6AzhrL475q0jKltx90EPqYW5hHexElAkqcCm6OtblC4CaIx44bKfqcnNPCZIGfOX21igIHUW3JGE2Wt4Vr0DxU1GIDT1lbIOf/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663744; c=relaxed/simple;
	bh=y1hP9KOj61X1d0LS1MBtcNboovz0X/9pMYRlE+KzgGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acETUUSPefyB6BxC1m3jDj2QK5m6w/V28DBTKUXhSo158PheKJuSBms6flWb08xyJob+WERRuTWW/hlTViZB1y4eqIf0o4qJN/jzvIBcUxfZ1TZlqVH6yl8FcDNZRJyeiOg1d5uAMJm9VKvOMIgtOST9wYJfCbvzNglnIZxXb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=G34WybYF; arc=none smtp.client-ip=54.206.16.166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663640;
	bh=aUe0TRbVGFkRHV+utHw34QovdZosd/Qm38Hy3naUO+o=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=G34WybYFUclDNwo95fBqsB5bWlO2B8F2uqhjHI0Aysn88/gdkx+zhMoXvOBZTmcUS
	 NaH3pUMyXALX5G/HB4SdUGrDc/o+dkq1m9nkfvbBXjzMFmKElVzkB3ox740VC6L8y4
	 1l5/Hg1P6Z9E/8b0NOYJDI1pYAJ2iOp3kdMbTKAY=
X-QQ-mid: esmtpgz10t1782663619tf311be0a
X-QQ-Originating-IP: zSQO5kCW8rBgrifYBeMVRmPAAtvxYYu76GK41kU/P9o=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:20:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14030382111034841978
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: carnil@debian.org
Cc: benh@debian.org,
	brauner@kernel.org,
	foss+kernel@0leil.net,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 6.1.y 4/9] eventpoll: split __ep_remove()
Date: Mon, 29 Jun 2026 00:19:33 +0800
Message-Id: <20260628161933.532572-5-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: METBPFwEUDZ+xy0+QDKZTRmEHYC3DPQiFwVjAw6Q3Hk63HLxTXNFkDpW
	vvuwhHu4dhZOTVv/hdnpU8B6QjsgMUiyjCLBTWlkNg5l3UwOjlZ11ZKExEMGTwpCNye2Lfb
	PM3mu9nQeNIDvR31iZSvgr+P4rDjLJLk3T7BRQdU0VI3IX5VRWkME9bBjdaprQRB6C4IL1/
	WFeQkeu17+VxTWXwBUOw/plwAnYlFCTKslJk5SAs9bTp4lByTszDzFNbei7FRUYUDkIyKxZ
	t8DS8Om8pmM2KO1qhXfurhUkaBMVxq/qvkIAquRTmG1cixCJ74FbbHvHk+Q9GtGoQxadeCt
	vCTGZ841s1AeyRDvZIxff0XAg6BkROpFmhS7mqKUbTRabohXfgsJqZUAChje0oFZynI1+3C
	hW7Eh4aOctl9vAmfb3Ke1PjauNhXoQwjfRAPqY1ZuMeQpWip0bMazcPfSsTkfVZT6Eu6cQb
	AORRgfTw0ABWE2nxxdf3d2b+q+Vv5MuRCdyQpefICyPznlzEnOZ+teqqFMN4JpO7Ow5AiDw
	srGidS/vkn2lftp4awMLxk6jpSODwDzXO/9Q514PS4sibNxLX48MNiMnOOu+rNirRK+pdWc
	wEgbhrjHjkOQJCDg48s+fZqaigynwv+1YRt3vm58IE24FTsXVJ6r9Iotu1ZrYXQKzLtdNHv
	ovfM6KZqLKrnH1dpxQ7GkntChNmW9sJgs0eNIzURjRCANDfMhWJxee9aZiYtAV3Epn6kWLP
	Wy7FNBT+ib9KzVooo1vgAR4qHNZjpXndaJHTcZuGbIiBO1LTqlcaQzZi2lWcidjtjd53Dtl
	EqGn48FCd1P1iwTKkj4g+qwjOa8UCgJzj0DkGTuVA5DOWz3gPn8Zu+xScIMW19CnJ9q53zZ
	aGhR+RIwQ4i4zTVfIz11Nt57JfhYbYsFV7FpetANvZP714xQ2Y9sdeeYl7Nsy2TYaKNSUBg
	GrC5zya25o9Hw9LNAqkGvnO1KUlqzSRa7n4dZzOkQX2nfCWQtQ+OCojzOXlaKd+NZ2vVYUE
	5ZyKpfG2u5pli5/EF+BPKW/BobotjcFh6/B0nFVNBX8ABMhg88J15FYv3J8WQqO3ZdBVqqM
	/rngN1SZ7xyRqFarBVWVbyNxyEtwGRtRA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RBL_SEM_FAIL(0.00)[172.234.253.10:query timed out];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269541-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:carnil@debian.org,m:benh@debian.org,m:brauner@kernel.org,m:foss+kernel@0leil.net,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:torvalds@linux-foundation.org,m:quentin.schulz@cherry.de,m:foss@0leil.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[msgid.link:query timed out];
	ALIAS_RESOLVED(0.00)[];
	SURBL_MULTI_FAIL(0.00)[linux-foundation.org:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,cherry.de:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32C266D45B1

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0f7bdfd413000985de09fc39eb9efa1e091a3ce0 ]

Split __ep_remove() to delineate file removal from epoll item removal.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-2-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/eventpoll.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index bc605ad291499..9e728b359ea3d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -715,6 +715,9 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file);
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi);
+
 /*
  * Removes a "struct epitem" from the eventpoll RB tree and deallocates
  * all the associated resources. Must be called with "mtx" held.
@@ -726,8 +729,6 @@ static void ep_free(struct eventpoll *ep)
 static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 {
 	struct file *file = epi->ffd.file;
-	struct epitems_head *to_free;
-	struct hlist_head *head;
 
 	lockdep_assert_irqs_enabled();
 
@@ -743,8 +744,21 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 		return false;
 	}
 
-	to_free = NULL;
-	head = file->f_ep;
+	__ep_remove_file(ep, epi, file);
+	return __ep_remove_epi(ep, epi);
+}
+
+/*
+ * Called with &file->f_lock held,
+ * returns with it released
+ */
+static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi, struct file *file)
+{
+	struct epitems_head *to_free = NULL;
+	struct hlist_head *head = file->f_ep;
+
+	lockdep_assert_held(&ep->mtx);
+
 	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
@@ -758,6 +772,11 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	hlist_del_rcu(&epi->fllink);
 	spin_unlock(&file->f_lock);
 	free_ephead(to_free);
+}
+
+static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+{
+	lockdep_assert_held(&ep->mtx);
 
 	rb_erase_cached(&epi->rbn, &ep->rbr);
 
-- 
2.30.2


