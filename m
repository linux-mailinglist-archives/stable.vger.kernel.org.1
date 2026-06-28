Return-Path: <stable+bounces-269545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +jXAHk9KQWq9nAkAu9opvQ
	(envelope-from <stable+bounces-269545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 799E86D45B7
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 18:22:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=YGzy9eXx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269545-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269545-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC5D7300492E
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956419CC14;
	Sun, 28 Jun 2026 16:22:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05B227B94
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:22:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663754; cv=none; b=ZikyBaZB2XWy5cal18QDaZYLRyREVbTy9KqX+W4bVhU9hm8Cp9ztC4i2E714PM0wPXzSKJf8XIaKyD7DTsqwVD1cimXyYvAUHvi7NNTIWQchn39hvrn2XGktijwQuY0R9Tm9+/8SJWxstE1/aGMicI6ldKd0kTP5kGYORnCe2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663754; c=relaxed/simple;
	bh=G2HuD6gprTMTSu8NLi4yli0yca4zT0Op16ZQtohoxKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiQJU0TdnAvGsUS/8JGVWU/Q4+tX9vtI3NhbO2QduphtBN+w3IMi2U2BezdB7WrwzIn80yKH3I6gY2DFVt9vnfLKacfpArvUs9Yw386ZxrqwtxD/JuL+CBOodzhgevUhH5EtKfXvQb1aNrpDzv5MyhlTe9XnSD6KNvIIPztin70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YGzy9eXx; arc=none smtp.client-ip=54.207.22.56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782663655;
	bh=SkHIk8rdDdpTapS5Scc+Uq+s6eHgFOzCrVOenI3338c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=YGzy9eXxLpdQmDzzzyHJ8K+Iq2qCBrHwOEI2+rvAzuqkAIWSDoKELo+yRXRCgEUvB
	 /cq5RmuJixv++7B1DPHWGGx38fIFe80t+ecVmocGAQuA6Y6s7VqpXkLJ9T10wLDQVh
	 kfxCjnw/3/6Gi9jjw/7NfnLFR2omlz1vBnBKdywc=
X-QQ-mid: esmtpgz10t1782663650tb43a7f09
X-QQ-Originating-IP: A0jsSvxsIf7ApYq88ME3cdeMzBhJbqZQZ/WQlPEw5B8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 00:20:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11240722143322007615
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
Subject: [PATCH 6.1.y 8/9] eventpoll: move epi_fget() up
Date: Mon, 29 Jun 2026 00:19:41 +0800
Message-Id: <20260628161933.532572-9-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MMhCNUSfqElxN5Sw4Qa9fQLnETL1tB41HC3d/fH+8AMZsbLXlGdHWAD2
	SvBYZX4fnIJ9Bh/qP1bV26iIy1vYMt4Eou3NbuvrNvECMuMoIRnQe9/rFwPMhw6oBw5Qvf9
	FJbxRYkHFu5SbL4rpurvzffJJAiIZpj8sF91epKziNb6qPYb0o9x4dGAaleIk4U3elr74G5
	xT1GIF+dtH58VyrDJmLrGoViPGRMcOp9XYZnf+6z5+AyyiqHb7pa6BsxKqg8TlyDUQCe8uA
	cmDwkvYCDY7k5v27GDfr9V10aTv1YAT6Wv8r7aD24roWm98/1DjxWpzgXUPzrvOUFsI7LBy
	n4BX2k9/VPpFAe/+EE0H0M3R+xzjLm/v9HKHPPg925ImcGFpwWLGBrvT+5RxL9pdVr2T4MF
	LDWK9V+/eQUOhWIfE2jhKf6Ezz89XbPZhTJQ5iynr9cljTepiYCuMEFzTGL/n5k/HusCHKK
	nQr0H5ELmEVMqlUlTTfMgmTFetD9eiFm9q/T0hagCGH12xZrlwcVYCzVyJjAl/4VTxhXzu2
	mGujH7owkWjibEnoCKlXJc+u/gsk64HzntMcZAGY/VZRiPx+Ha1xKAk664Hnjl2gaqwK2yg
	E4cCpSQT7Up3JHVEURV3GIk4d1oFZvKFcv6QQSeUn5NzUm0WumkMKBVqo26EIVB9D+svmtU
	u0/x6V26RAPwncaWsguhe6hO9yW7OmZhbn4PPLcpEBThmbeh/0px2HsNu3bLrS5uc28xROL
	gwUKXGglMXTWuYElx1pKEvQt2oTPL64qAp10HzwzFBbTjW9ejEl6gUIQX2eAweTm+rL2mDt
	aEzDtYe3eRXU5KtX7lLzMkm6wN73qGacblxjCA7nYms9Kgzqpls2P83TKdqIWWOpy/3iHuX
	/g9dneC/9rEr0P/dkVU/Af6Wm3NvJN9Xl2IYV4jq5odqd61WKDrH/7OJaqQiLK5RhMQPCZ/
	rXeIitFhRe49u9SM3CM2x8qYSJbxmMF46mXX7bqY9b4rUIVSl/d2Kjd6EQrMz5L0nhBcyPW
	xJWgRoVOCPBm1HGZuJkUtEAzsntYgAKk2u65MJbvVcEjaqv4GHrtF5iKM9YlvzN0ytyrRb5
	4LOttDHxt4zNrcH+JP+cKXKF+spV3SUsYHWx55RXswzlFTaSFtM6EgYbof5W+Oh9Q==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269545-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:carnil@debian.org,m:benh@debian.org,m:brauner@kernel.org,m:foss+kernel@0leil.net,m:gregkh@linuxfoundation.org,m:guanwentao@uniontech.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:quentin.schulz@cherry.de,m:foss@0leil.net,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,msgid.link:url,cherry.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 799E86D45B7

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 86e87059e6d1fd5115a31949726450ed03c1073b ]

We'll need it when removing files so move it up. No functional change.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-5-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
[file_ref_get(&file->f_ref) from original commit left as
 atomic_long_inc_not_zero(&file->f_count) due to v6.12.y missing commit
 90ee6ed776c0 ("fs: port files to file_ref") and its dependent commit
 08ef26ea9ab3 ("fs: add file_ref")]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 fs/eventpoll.c | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2a335dcb995c0..67ba8bf17b800 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -715,6 +715,34 @@ static void ep_free(struct eventpoll *ep)
 	kfree_rcu(ep, rcu);
 }
 
+/*
+ * The ffd.file pointer may be in the process of being torn down due to
+ * being closed, but we may not have finished eventpoll_release() yet.
+ *
+ * Normally, even with the atomic_long_inc_not_zero, the file may have
+ * been free'd and then gotten re-allocated to something else (since
+ * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
+ *
+ * But for epoll, users hold the ep->mtx mutex, and as such any file in
+ * the process of being free'd will block in eventpoll_release_file()
+ * and thus the underlying file allocation will not be free'd, and the
+ * file re-use cannot happen.
+ *
+ * For the same reason we can avoid a rcu_read_lock() around the
+ * operation - 'ffd.file' cannot go away even if the refcount has
+ * reached zero (but we must still not call out to ->poll() functions
+ * etc).
+ */
+static struct file *epi_fget(const struct epitem *epi)
+{
+	struct file *file;
+
+	file = epi->ffd.file;
+	if (!atomic_long_inc_not_zero(&file->f_count))
+		file = NULL;
+	return file;
+}
+
 /*
  * Called with &file->f_lock held,
  * returns with it released
@@ -886,34 +914,6 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	return res;
 }
 
-/*
- * The ffd.file pointer may be in the process of being torn down due to
- * being closed, but we may not have finished eventpoll_release() yet.
- *
- * Normally, even with the atomic_long_inc_not_zero, the file may have
- * been free'd and then gotten re-allocated to something else (since
- * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
- *
- * But for epoll, users hold the ep->mtx mutex, and as such any file in
- * the process of being free'd will block in eventpoll_release_file()
- * and thus the underlying file allocation will not be free'd, and the
- * file re-use cannot happen.
- *
- * For the same reason we can avoid a rcu_read_lock() around the
- * operation - 'ffd.file' cannot go away even if the refcount has
- * reached zero (but we must still not call out to ->poll() functions
- * etc).
- */
-static struct file *epi_fget(const struct epitem *epi)
-{
-	struct file *file;
-
-	file = epi->ffd.file;
-	if (!atomic_long_inc_not_zero(&file->f_count))
-		file = NULL;
-	return file;
-}
-
 /*
  * Differs from ep_eventpoll_poll() in that internal callers already have
  * the ep->mtx so we need to start from depth=1, such that mutex_lock_nested()
-- 
2.30.2


