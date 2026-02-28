Return-Path: <stable+bounces-220356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Pd5H1M4o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E8D1C6431
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D75B9305A0CB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACF939EE3E;
	Sat, 28 Feb 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0oiCI3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90C39EE33;
	Sat, 28 Feb 2026 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300253; cv=none; b=FspHICaRWdKQpdNfZgzPeMhVKO6VAgeDgVz6sSCycByPIFxSFwwY5B1JUhOdPuHbRqUCH2ZqWWVZK8x7HAksnA8W7p7jwKvXhxEqPxr0QXIrx1E9llYvFxvzaqgzQX5k0v5Qo6JDHh5i3D7phWuM1RKw2inTDWXjZqmwg6+DWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300253; c=relaxed/simple;
	bh=lcDeFNBWSFo8oY08B/UekAKMABrcudq9S4nux/vEcbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNLkc4Cw0rmVT/g6DhX4aT8fA+5NkkPCsjDjxYBWLLti8M2LJglyiAzG7DdNdA2EeuD/XI2xbg5gkawtv2I1TVtTB/GsrJRIB/o9RNeSqPL+acLnxTh1oJA8IiF1Y7QgWtMferUuLSbGyEqK3YmqS4VgJRJun8tq2a1eQmkQE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0oiCI3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11BFC116D0;
	Sat, 28 Feb 2026 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300253;
	bh=lcDeFNBWSFo8oY08B/UekAKMABrcudq9S4nux/vEcbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0oiCI3MJIc7esWBPOswR2UiOD3La9Zg0abhD5PWK+fWnMzRCGmalwjuE9hIHzcUW
	 80EFL9am3t1WOPilOXk8RR9RrEFaeTiCKaCHbfmlTfjvIrYz2rRY40XubTS7l9S3Dx
	 i6gpXhLebccd4VRpzZTGSX3j9lG7BjDaAthM592rG15g/75rG8MY55XTm8IsdeQqjA
	 T9+Gti4kMK7FIBn9IYUS2ghXdwbKIcinDhD6VejB3GiwTbPQFfxdTYvR04a40IDdgL
	 D0GwLzPwX5wvfO3ETaZQrt9jtCAlTCMYvc7ms3NqC9ZVlDCfOLrKpXPE6IYh27rXKS
	 3vXSpD7d5voOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ross Vandegrift <ross@kallisti.us>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 278/844] wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1
Date: Sat, 28 Feb 2026 12:23:11 -0500
Message-ID: <20260228173244.1509663-279-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220356-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A9E8D1C6431
X-Rspamd-Action: no action

From: Ross Vandegrift <ross@kallisti.us>

[ Upstream commit 4015b1972763d7d513172276e51439f37e622a92 ]

Z16 Gen1 has the wakeup-from-suspend issues from [1] but was never added
to the appropriate quirk list.  I've tested this patch on top of 6.18.2,
it fixes the issue for me on 21D4

Mark Pearson provided the other product IDs covering the second Z16 Gen1
and both Z13 Gen1 identifiers.  They share the same firmware, and folks
in the bugzilla report do indeed see the problem on Z13.

[1] - https://bugzilla.kernel.org/show_bug.cgi?id=219196

Signed-off-by: Ross Vandegrift <ross@kallisti.us>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://patch.msgid.link/wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 06b4df2370e95..78a1b0edd8b45 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -994,6 +994,34 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
 		},
 	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z13 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D2"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z13 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D3"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z16 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
+		},
+	},
+	{
+		.driver_data = (void *)ATH11K_PM_WOW,
+		.matches = { /* Z16 G1 */
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
+		},
+	},
 	{}
 };
 
-- 
2.51.0


