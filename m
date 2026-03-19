Return-Path: <stable+bounces-227272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j4q8FTjiu2njpQIAu9opvQ
	(envelope-from <stable+bounces-227272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:47:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734C2CA901
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9681A328A5CB
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27073C0615;
	Thu, 19 Mar 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/5Kgm0S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9123BED46
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920407; cv=none; b=q+gWYl8XVfITcrA70SHH/T6hOvH2Gw1pf3bCLK6QtjVkoR1XeQUNRH3ti3DwJ/4OXFiGqiBs86pobHpC+pE+PpRsJRG6pvAU6DGeaTRhj/Q053D3KMFAF3eWAUmZP5x8E8Boxq23JkGGVI9iWHoDmZbnIPztYAyJ8go3Ho0e/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920407; c=relaxed/simple;
	bh=OHnytwDlbJRTCUT8R6VAclgJZY1BY5OTAMMeSv8Qobs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASRc+PmOVQgw+TZsGs+e5MKEY75QM+LES9XL72ggHWN19FS7iE14Pj1pW9Yion10aJin6Ra135G9napN/3EQmKqRUqZYNViG+EFWjndzZ2AW+LTut8VWCmm6ovFVgBAeYr4b5XD+p9tX8SCiG/2S4TtaT8XomcET/Vb+qzuw7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/5Kgm0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF2DC19424;
	Thu, 19 Mar 2026 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920406;
	bh=OHnytwDlbJRTCUT8R6VAclgJZY1BY5OTAMMeSv8Qobs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/5Kgm0SPaXjYH1Y5CGaGzx2m52Hq5WIY5M67Ucn56/+ZU2k1br9+Kspp4V7CM0b0
	 xK9+/HnKCGTetAHUMOH/kRgLOD1Gg1h6hcDcPwY1l67HeKm4dn7/SbYXVArO95DLXa
	 5cbkiJoNJrbCjw7PPY27efiiSbV3h7zvAjWsUFlQ9nKXIVRqiO0bW/ITOuphMCgr4H
	 joycHRaYcRC7jH0cO+ofX97QKYja7Go9i1Ri8TIl1LHfvxlLF52pXX42wy0G1zJU7t
	 TdZAJt9D3qdrqg66GAJzVTk/snOZtKS8TE3s8cVTlugOotOXCWtZMv+Sw3+dViNwnD
	 2/ASsHUUp1fSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harald Freudenberger <freude@linux.ibm.com>,
	Ingo Franzki <ifranzki@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] s390/zcrypt: Enable AUTOSEL_DOM for CCA serialnr sysfs attribute
Date: Thu, 19 Mar 2026 07:40:04 -0400
Message-ID: <20260319114004.2348873-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031714-skimpily-large-6221@gregkh>
References: <2026031714-skimpily-large-6221@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227272-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9734C2CA901
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
index 6a3c2b4609652..ed662b27504e2 100644
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
 	pg = (u8 *) __get_free_page(GFP_KERNEL);
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 06024bbe9a585..2a627a74920a6 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -81,8 +81,7 @@ static ssize_t cca_serialnr_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	if (ap_domain_index >= 0)
-		cca_get_info(ac->id, ap_domain_index, &ci, zc->online);
+	cca_get_info(ac->id, AUTOSEL_DOM, &ci, zc->online);
 
 	return scnprintf(buf, PAGE_SIZE, "%s\n", ci.serial);
 }
-- 
2.51.0


