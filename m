Return-Path: <stable+bounces-212651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IYoM61Pemnk5AEAu9opvQ
	(envelope-from <stable+bounces-212651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:04:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B706A76FA
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2CAE3029243
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA93325495;
	Wed, 28 Jan 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN7KUR8p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26FE2BEC2E
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623365; cv=none; b=LXhuPtkGyjg59SmeicGntZJpoI5XMIyCwOo3/L6dvWR1ZbCsyzC1LkJ6QBfYh1JkjlcvbZv7IPP42un1Jy6FqnC6UEE0nybtzw/SLgLEvHoh1S2+ZrPh8iHBKeNUCCh6PAKGMXhjT+59TeRoFmjjr73+0RQDb9rf7vpeiD/cpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623365; c=relaxed/simple;
	bh=uzTz49XE1Hx2csddmUgMnlS4lyasEN/R0ed2DF1alq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmLvxXJC9RTkvTIy4yGNn9r/VwXzi1zJjlfaZb0rkYZ35WM5ufstVdOnMxqokOXZjFr1pE6O1mfaxo179sjBANwd5Xx+1AQzEpjD9VZzjKCLv6wLiKR1s8Ht7ydBILwdjJHmg7VM4VER5/9eu8U5UnX0zBFKHUyzlmmyqzJAF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN7KUR8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DD3C4CEF1;
	Wed, 28 Jan 2026 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769623365;
	bh=uzTz49XE1Hx2csddmUgMnlS4lyasEN/R0ed2DF1alq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sN7KUR8pdsOcVGAkw7UCqGas3wE6MtIeGDftXCSaRXoEsu2Vv4TxEvKpgVq/HbhJH
	 Suvv3SL/ZJ9fOFpM/saSi1U/UUHaBjoEHhhapX8eBdhDAT7HdooPJ0Mua9yHsSaXgL
	 /+7d2M9gXrslOHd8rfwqed2tkTCGmBsymi6BN2xWr1Yz6fZXKSChujz1APSt+7xCrf
	 xRsGBwOHG942dvGa6ftDKO4shty8rEfPCplVAGuOBpgu/7BgLmzk3uyUJhUmYxi7X0
	 qk3/pgW8KS2ha1H96oC+Uurl0SGLROyw2lPVcB3gnsOwohiCnmCtnLMvDgJ5pP9MnM
	 52K4/K353GtCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Guang <yang.guang5@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>,
	David Yang <davidcomponentone@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] w1: w1_therm: use swap() to make code cleaner
Date: Wed, 28 Jan 2026 13:02:42 -0500
Message-ID: <20260128180243.2612857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012736-shaping-sixfold-2889@gregkh>
References: <2026012736-shaping-sixfold-2889@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zte.com.cn,gmail.com,linuxfoundation.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212651-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zte.com.cn:email]
X-Rspamd-Queue-Id: 2B706A76FA
X-Rspamd-Action: no action

From: Yang Guang <yang.guang5@zte.com.cn>

[ Upstream commit e233897b1f7a859092bd20b10bfd412013381a10 ]

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Link: https://lore.kernel.org/r/cb14f9e6e86cf8494ed2ddce6eec8ebd988908d9.1640077704.git.yang.guang5@zte.com.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 761fcf46a1bd ("w1: therm: Fix off-by-one buffer overflow in alarms_store")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/w1/slaves/w1_therm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 67d1cfbbb5f7f..b745070e8c4ae 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1782,7 +1782,7 @@ static ssize_t alarms_store(struct device *device,
 	u8 new_config_register[3];	/* array of data to be written */
 	int temp, ret;
 	char *token = NULL;
-	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
+	s8 tl, th;	/* 1 byte per value + temp ring order */
 	char *p_args, *orig;
 
 	p_args = orig = kmalloc(size, GFP_KERNEL);
@@ -1833,9 +1833,8 @@ static ssize_t alarms_store(struct device *device,
 	th = int_to_short(temp);
 
 	/* Reorder if required th and tl */
-	if (tl > th) {
-		tt = tl; tl = th; th = tt;
-	}
+	if (tl > th)
+		swap(tl, th);
 
 	/*
 	 * Read the scratchpad to change only the required bits
-- 
2.51.0


