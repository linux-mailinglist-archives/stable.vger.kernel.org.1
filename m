Return-Path: <stable+bounces-231332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE8WEklny2mAHQYAu9opvQ
	(envelope-from <stable+bounces-231332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:18:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A1364707
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5134730210DB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3415438737F;
	Tue, 31 Mar 2026 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0CEs0Ci"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3F634CFCF
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937918; cv=none; b=PZ8OzTBUH6rx/sWtTkgPqGuUsdLa6sux4dwM6zINo7yrWKrD3p8m9t8ONDljceGAkBokz/QRw3n93RyHl6518/4cHefbNAySdiK9yqWq7orIE+SvDlbz2osptjqyUztMt3+zkXbP8Nnjd5QkqGyvWtrwzaJWSBuSBRgTYy+932U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937918; c=relaxed/simple;
	bh=dmQ29kP7K8FBF47XhosSKu5r0d1kMW1R0rtkLUub+i0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bHxgj6hdzZPkSNkySBSyCw0g8e7SLbMaqTqEMmBKXzigoUzD2S/MA/sWou1TxXUmtWEhYuMgQiFNmF5ILy7MQpNVwaWWgy+2WHaOPvnE4/rNpS6FLGm2Ktn2vuTv1jBbWzIowtYqoDjdvIYXqvTJR5fiX3Mr48YHL+Cg/CIYHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0CEs0Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7697C19424;
	Tue, 31 Mar 2026 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774937917;
	bh=dmQ29kP7K8FBF47XhosSKu5r0d1kMW1R0rtkLUub+i0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=F0CEs0CiY7D26OPwi9UxwC/EcP+1JzfIUxis2ntIX+9V1GbrCi8b8tLGm8rrL2oUJ
	 tvkgfNnAnlDt7/3gh2lV4qaQMbHpWKAtzX2n762yTy/B7zvHo2i8b0z80/ZU7Klqad
	 lgwR/c7OfZrBPocEy+Cuse3bRvtoQsR7MZj48DJXzyqYeX/1I+bBZm9SCtlSZNoVFh
	 2LkmS3Lwzcc9PNlhWdE6J4wFaDldCPM6UhDWEjy/Xtig+vNQRXyr2DE1G69tAT7QzM
	 oCquu2w82bxTgU9/vr/Hne5FP3T3u5pG3CVMUngCi1wVMx5CNxrAqBkKN4k645//8i
	 rDM3CF5G/f3Tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94537FF60D0;
	Tue, 31 Mar 2026 06:18:37 +0000 (UTC)
From: Kyle Farnung via B4 Relay <devnull+kfarnung.gmail.com@kernel.org>
Date: Mon, 30 Mar 2026 23:17:47 -0700
Subject: [PATCH] wifi: ath11k: apply existing PM quirk to ThinkPad P14s Gen
 5 AMD
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY2MD3QJDk2LdglzdwtLMomxdg0RTw6REQ0sjY9M0JaCegqLUtMwKsHn
 RsbW1AB5tVOlfAAAA
X-Change-ID: 20260330-p14s-pm-quirk-0a51ba19235f
To: jjohnson@kernel.org
Cc: mpearson-lenovo@squebb.ca, stable@vger.kernel.org, 
 Kyle Farnung <kfarnung@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774937917; l=1833;
 i=kfarnung@gmail.com; s=20260330; h=from:subject:message-id;
 bh=kq96BemCwbcNxO2n44+TaDQg1Fcri89cgz/ZQ9TgDdg=;
 b=pa5pjOR2vnhafTL+EdDpqtqMPiEzGYbPgE054MTKHj0n1HJxummszMac60OE+n92t2gaDjBcI
 Yqltxiep5NKBk37sa8X4egufw0LmuqRukWlYVVDl/otSgFeDVKz+tA6
X-Developer-Key: i=kfarnung@gmail.com; a=ed25519;
 pk=47jis5OdLKFgZynNQVqkx1mTGiEgFTUX+MecmG9rbmE=
X-Endpoint-Received: by B4 Relay for kfarnung@gmail.com/20260330 with
 auth_id=706
X-Original-From: Kyle Farnung <kfarnung@gmail.com>
Reply-To: kfarnung@gmail.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231332-lists,stable=lfdr.de,kfarnung.gmail.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[squebb.ca,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[kfarnung@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lenovo.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B87A1364707
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kyle Farnung <kfarnung@gmail.com>

Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
reliability issues similar to those reported in [1]. These platforms
were not previously included in the ath11k PM quirk table.

Add DMI matches for product IDs 21ME and 21MF to apply the existing
ATH11K_PM_WOW override, improving suspend/resume behavior on these
systems.

Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
[2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/

Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb9c93d9ef692d127fe 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G5 AMD #1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* P14s G5 AMD #2 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
+		},
+	},
 	{}
 };
 

---
base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
change-id: 20260330-p14s-pm-quirk-0a51ba19235f

Best regards,
-- 
Kyle Farnung <kfarnung@gmail.com>



