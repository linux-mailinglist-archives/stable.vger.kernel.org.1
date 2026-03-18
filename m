Return-Path: <stable+bounces-227059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EPHCdyeumkkZwIAu9opvQ
	(envelope-from <stable+bounces-227059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:47:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FBB2BBC93
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89FE93008681
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0943876BF;
	Wed, 18 Mar 2026 12:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeQTtHtv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524D723C516
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837794; cv=none; b=bNoywAaKvw6GSiIYL4Lccl1DWQ8uj7K1sh80Q3uNxhYnMbqjgXA2bPG8aMzSv06iRK1sYHnsmg5Y1VntcFqddR+EysoIcTWJmfQOpgUNmfX1yHnKQkFgwLyOFKFdXsxo47u/6KbMqYlSWGAg2LEzY1d/Wa9qhU1r11CwHMiHSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837794; c=relaxed/simple;
	bh=Hd3KjOute50UKVsHNlFYsH/xaKzPsQ7yQvhCqpRUvEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxjJi11PXCiJNb/UbdcYxVdfZHRvPfNJyjc+6pce8MVv145sBCrR2+/U0kGdNJSdLfIeFz8pc7/flNUOHgvAAVlO99acXj2wdC509jWZjVdZ8ZqzByENB49cJmPHXTbn0zkLqhiyrwYUNRtJbJGID0FT6zDuejTCmD+eVdI2Ylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeQTtHtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F7DC19421;
	Wed, 18 Mar 2026 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773837793;
	bh=Hd3KjOute50UKVsHNlFYsH/xaKzPsQ7yQvhCqpRUvEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AeQTtHtviczvGXNZk0jFH24kwGV7nsXUy14A2Y+T0O1CTlBFpfax41kwAbEACCHjZ
	 zxVPuyE+Cl7GcoIEA3bhvZL2W2O72i2w3ty+gqT5g6IsvQlCRnRrIlq5pwZDDB00mh
	 bjB4LG0uJWaLJp0l5VH+thkkdcd68x60Y0LCe2u8srRQ7peBu9Zdcsl/jHY1nGAuE7
	 xZsccGFPrSk8zFC0CWxAue7KQ6yxumrL67DpYg04bnNyTuVySwFY3EpAXMSSvFcjY6
	 fbhG57v5GlR6B5ieVJjdKZeRA9y6a1Rt3R+J4yQvz0/ve5g/37vzUxrz4s5B8ER6O6
	 y8Jvi/2L6nTMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pmdomain: bcm: bcm2835-power: Fix broken reset status read
Date: Wed, 18 Mar 2026 08:43:11 -0400
Message-ID: <20260318124311.706015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031713-dish-reseal-2bd6@gregkh>
References: <2026031713-dish-reseal-2bd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[igalia.com,broadcom.com,gmx.net,linaro.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-227059-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,igalia.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 31FBB2BBC93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 550bae2c0931dbb664a61b08c21cf156f0a5362a ]

bcm2835_reset_status() has a misplaced parenthesis on every PM_READ()
call. Since PM_READ(reg) expands to readl(power->base + (reg)), the
expression:

    PM_READ(PM_GRAFX & PM_V3DRSTN)

computes the bitwise AND of the register offset PM_GRAFX with the
bitmask PM_V3DRSTN before using the result as a register offset, reading
from the wrong MMIO address instead of the intended PM_GRAFX register.
The same issue affects the PM_IMAGE cases.

Fix by moving the closing parenthesis so PM_READ() receives only the
register offset, and the bitmask is applied to the value returned by
the read.

Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains under a new binding.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/bcm2835-power.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 1e0041ec81323..050389869035a 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -566,11 +566,11 @@ static int bcm2835_reset_status(struct reset_controller_dev *rcdev,
 
 	switch (id) {
 	case BCM2835_RESET_V3D:
-		return !PM_READ(PM_GRAFX & PM_V3DRSTN);
+		return !(PM_READ(PM_GRAFX) & PM_V3DRSTN);
 	case BCM2835_RESET_H264:
-		return !PM_READ(PM_IMAGE & PM_H264RSTN);
+		return !(PM_READ(PM_IMAGE) & PM_H264RSTN);
 	case BCM2835_RESET_ISP:
-		return !PM_READ(PM_IMAGE & PM_ISPRSTN);
+		return !(PM_READ(PM_IMAGE) & PM_ISPRSTN);
 	default:
 		return -EINVAL;
 	}
-- 
2.51.0


