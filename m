Return-Path: <stable+bounces-218647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK7yLUVUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D718FC41
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95E2A30CA82E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D6C26463A;
	Wed, 25 Feb 2026 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m2/efVcF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F0248881;
	Wed, 25 Feb 2026 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983498; cv=none; b=YWXbsk2VH/8DkV2XGXRZsqfHg3fiDfWvFG4n8pm4oKUqG0FC+eZlXBYYmkTPB7GNAiwDCWwtHm7z2WFwLb0YN1xKVKvBMnLOLMOlSOIDoeQlPuNBrftC82zWpT8YnAsJGTyY4VDhUZftZ8RAqrHqhWLcG1ZQnAbH8PcYoWBlKTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983498; c=relaxed/simple;
	bh=Lj7+ZEV6WRbsKT9oKXbxC65mwMK8xhgctkJ8qMPLshI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmGoNf4QumZTZ04tTKJLhHTH76j6NNuWlVmFRyX6VUWo2ZdH2DCkwQ0/2+uoe0G4GVVlw6uB9s9lr3uQZFLdLsqZTsVwUFWjba0DGZAs+qXdWK1/47vIdLUpRFp6fFHJQHxMFb2kDUcTCzbZ0rfKcXXmKPagCRx59bcMpz4NAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m2/efVcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5D4C116D0;
	Wed, 25 Feb 2026 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983498;
	bh=Lj7+ZEV6WRbsKT9oKXbxC65mwMK8xhgctkJ8qMPLshI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2/efVcFCDrksC85lC+5gfdpBuZdRfQtkhmfec7k62IbdE/IZ5JZ5k6Es+5fL6cVq
	 ylaHvsV6pg3xJ9zJSfi1OlUbFmwFc+eFa6ppThYOHsvdBz5oC/zvK9bauW3yvfJEQ2
	 W/4rZn6TPAxj/ZrlnT65pocZO1h3zwzWYOu9CcKc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 607/781] leds: qcom-lpg: Check the return value of regmap_bulk_write()
Date: Tue, 24 Feb 2026 17:21:56 -0800
Message-ID: <20260225012414.681268838@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218647-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 093D718FC41
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit f42033b5ce8c79c5db645916c9a72ee3e10cecfa ]

The lpg_lut_store() function currently ignores the return value of
regmap_bulk_write() and always returns 0. This can cause hardware write
failures to go undetected, leading the caller to believe LUT programming
succeeded when it may have failed.

Check the return value of regmap_bulk_write() in lpg_lut_store and return
the error to the caller on failure.

Fixes: 24e2d05d1b68 ("leds: Add driver for Qualcomm LPG")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260108175133.638-1-vulab@iscas.ac.cn
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 72da0bf469ad8..f54851dfb42fc 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -369,7 +369,7 @@ static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
 {
 	unsigned int idx;
 	u16 val;
-	int i;
+	int i, ret;
 
 	idx = bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size,
 					 0, len, 0);
@@ -379,8 +379,10 @@ static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
 	for (i = 0; i < len; i++) {
 		val = pattern[i].brightness;
 
-		regmap_bulk_write(lpg->map, lpg->lut_base + LPG_LUT_REG(idx + i),
-				  &val, sizeof(val));
+		ret = regmap_bulk_write(lpg->map, lpg->lut_base + LPG_LUT_REG(idx + i),
+					&val, sizeof(val));
+		if (ret)
+			return ret;
 	}
 
 	bitmap_set(lpg->lut_bitmap, idx, len);
-- 
2.51.0




