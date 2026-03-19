Return-Path: <stable+bounces-227270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDspEvneu2lXpQIAu9opvQ
	(envelope-from <stable+bounces-227270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:33:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E72CA55B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F8F930066B9
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A870337AA6F;
	Thu, 19 Mar 2026 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYNXpX2b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F7318EDC
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919981; cv=none; b=HmzGyzSFmC7TJ4GtKePW6E7xS2ky1/7HHsZDP0tKzzbEUm+FRH389b9n5Cd21luweEUVUd4kFNmwbCxr+CMCu/nHyT14TCyByReRg62faNAmt4wdBqh/XhXeLVMvQADVIzYNskFUa44LuDmMepkd8qIuTnQrca7Q/Pn3J+gLYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919981; c=relaxed/simple;
	bh=LFksIAdA50VvK0bS4J8uxy1pTF03YowavNtAZqinLhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW2+1QZKDCNChhA8RJT+qPa1RgwX5MbzDea2BvzHmp4dCQdYXIcbPQ3Jb9li8dLkcAIyKgDSIXCdtnn0OB0Kz8jTi2HK0iSFXuXk2s5L0R6J41voFUr3+HRjYzzT3e2Vy7CY58y5GDzqd89j82kB9K1niRSPoPVKuREgUHkvXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYNXpX2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9ADC19424;
	Thu, 19 Mar 2026 11:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773919980;
	bh=LFksIAdA50VvK0bS4J8uxy1pTF03YowavNtAZqinLhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYNXpX2bIhCtxVrWuhQ36qAQ4ldx8GIOcz6pA5QGNRQOxK/3Qd2KKRv6/aF7HXJWy
	 ROzLIHp4Uxw/YqST+woOqazbJPhLNUaf+7ayhTQyAJlA91E4qZiQKdug6No6HO6MZ0
	 gx7U93W4Ijxkds8i86r8duPK0qVlU275rxegj4yXva0FTozuNruefHwlHCt20SrO/z
	 hXQw2LCdpUQ9YJE0l67oU/j0JdKHZbpwnEjWxYcqVtUOTmHC1a/OPsE0WM6cy5ctCA
	 SMA8ClFjYJj9g1AabZ8EaZWHiz7ObR0WzUWJpsqSayFnMH3gpOAbRX9R3jhcHMOH3w
	 hZmcionwAG2LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.ibm.com>,
	Ingo Franzki <ifranzki@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute
Date: Thu, 19 Mar 2026 07:32:58 -0400
Message-ID: <20260319113258.2340305-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031713-obsessed-gorged-3caa@gregkh>
References: <2026031713-obsessed-gorged-3caa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227270-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 042E72CA55B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 598bbefa8032cc58b564a81d1ad68bd815c8dc0f ]

The serialnr sysfs attribute for CCA cards when queried always
used the default domain for sending the request down to the card.
If for any reason exactly this default domain is disabled then
the attribute code fails to retrieve the CCA info and the sysfs
entry shows an empty string. Works as designed but the serial
number is a card attribute and thus it does not matter which
domain is used for the query. So if there are other domains on
this card available, these could be used.

So extend the code to use AUTOSEL_DOM for the domain value to
address any online domain within the card for querying the cca
info and thus show the serialnr as long as there is one domain
usable regardless of the default domain setting.

Fixes: 8f291ebf3270 ("s390/zcrypt: enable card/domain autoselect on ep11 cprbs")
Suggested-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
[ preserved zc->online as the fourth argument to cca_get_info() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/zcrypt_ccamisc.c | 12 +++++++-----
 drivers/s390/crypto/zcrypt_cex4.c    |  3 +--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 60ba20a133bed..a2cea4f4a6b85 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -1689,11 +1689,13 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
 
 	memset(ci, 0, sizeof(*ci));
 
-	/* get first info from zcrypt device driver about this apqn */
-	rc = zcrypt_device_status_ext(cardnr, domain, &devstat);
-	if (rc)
-		return rc;
-	ci->hwtype = devstat.hwtype;
+	/* if specific domain given, fetch status and hw info for this apqn */
+	if (domain != AUTOSEL_DOM) {
+		rc = zcrypt_device_status_ext(cardnr, domain, &devstat);
+		if (rc)
+			return rc;
+		ci->hwtype = devstat.hwtype;
+	}
 
 	/* prep page for rule array and var array use */
 	pg = (u8 *)__get_free_page(GFP_KERNEL);
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index b03916b7538bc..3eb14af475f66 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -85,8 +85,7 @@ static ssize_t cca_serialnr_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci, zc->online);
+	cca_get_info(ac->id, AUTOSEL_DOM, &ci, zc->online);
 
 	return scnprintf(buf, PAGE_SIZE, "%s\n", ci.serial);
 }
-- 
2.51.0


