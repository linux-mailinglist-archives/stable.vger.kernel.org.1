Return-Path: <stable+bounces-253827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHA9LNyjEGqYbwYAu9opvQ
	(envelope-from <stable+bounces-253827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:43:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 138A75B9214
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 20:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89C50300694C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124F8372070;
	Fri, 22 May 2026 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="p2ekR4DK"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC763644C1;
	Fri, 22 May 2026 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475411; cv=none; b=HYLdFIjeXlI/6Zyccqrbq0GFPXNbNl8PKTElhXrDgLyZYPMi/a2kLEdgLAgOI58d1Tg99HJlspreBlhH3T5itKfw0qvpUGFlm+hvrSj0CYEF5UqHT53HgkdLR8965uhHXaQSy5DvR15wyF8M3EYhi4DD08+mc03Xdsx+zvWhX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475411; c=relaxed/simple;
	bh=4Hu/47ALj1TFYHMqlVUelSx0EjTjIuZzdGwlJ2yzKAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLpiF1CrKEE7B7JBw+aeRBTqkqe4vLARfoo/Ny7oryccNYKbsKL+YP4lNQrOEZUj+Uq7pX9MFrahzq1QV0oFz1j9ulYLpy11t6axTLZuespVZfeM1i3HecR+FghwBN9lUzMgvBEAmY3t32RJkrR8C+KJOrwxcisYlqLRti6u+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=p2ekR4DK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=CnSgnNA0hMubCrJhiT7jVUAm7Vyf++O7TFQWPZMuzJA=; b=p2ekR4DKpYWIAobDNwopGJBeGQ
	D/Kh6/wKWBwyxMcJwp1ZgBj4gK5AIFZfN1aulnX1Z8w4hSD9YCkFwpEVs2JeuKrROdJP6ek94el1f
	W9oUzwsUSXvp4ZNHvNeA7Q5dpIATU0aHOkGOc71MWOCsjkxYBMFWHJCQvquGo6kOY6LwA/82JUv3g
	Pv1hWCQ6L1V5vjkEEvQTvJOXfiMnxv93r2GUcqf4lNHPuZrSp8y0g15ov4tC5vUPUAh+xFMZXbMNF
	AepjagtA8rzxG0r1GfX9MpccglvI2Fk4i1UlMJK3YLbXpd+YRX2d6fJTwVccj/EsYz00+hkFC8QPL
	f3c9QZrQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: ulfh@kernel.org,
	shawn.lin@rock-chips.com,
	jh80.chung@samsung.com
Cc: heiko@sntech.de,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc-rockchip: Add missing private data for very old controllers
Date: Fri, 22 May 2026 20:43:07 +0200
Message-ID: <20260522184307.2979579-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253827-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[sntech.de:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sntech.de:email,sntech.de:mid,sntech.de:dkim]
X-Rspamd-Queue-Id: 138A75B9214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The really old controllers (rk2928, rk3066, rk3188) do not support UHS
speeds at all, and thus never handled phase data.

For that reason it never had a parse_dt callback and no driver private
data at all.

Commit ff6f0286c896 ("mmc: dw_mmc-rockchip: Add memory clock auto-gating
support") makes the private data sort of mandatory, because the init
function checks whether phases are configured internally or through the
clock controller.

This results in the old SoCs then experiencing NULL-pointer dereferences
when they try to access that private-data struct.

While we could have if (priv) conditionals in all places, it's way less
cluttery to just give the old types their private-data struct.

Fixes: ff6f0286c896 ("mmc: dw_mmc-rockchip: Add memory clock auto-gating support")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index c6eece4ec3fd..75c82ff20f17 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -441,6 +441,22 @@ static int dw_mci_common_parse_dt(struct dw_mci *host)
 	return 0;
 }
 
+static int dw_mci_rk2928_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_rockchip_priv_data *priv;
+	int err;
+
+	err = dw_mci_common_parse_dt(host);
+	if (err)
+		return err;
+
+	priv = host->priv;
+
+	priv->internal_phase = false;
+
+	return 0;
+}
+
 static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 {
 	struct dw_mci_rockchip_priv_data *priv;
@@ -514,6 +530,7 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
 
 static const struct dw_mci_drv_data rk2928_drv_data = {
 	.init			= dw_mci_rockchip_init,
+	.parse_dt		= dw_mci_rk2928_parse_dt,
 };
 
 static const struct dw_mci_drv_data rk3288_drv_data = {
-- 
2.47.3


