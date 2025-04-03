Return-Path: <stable+bounces-127909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917A4A7AD2F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BA9178CB3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034B2298CCA;
	Thu,  3 Apr 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DegWdWru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1D298CC0;
	Thu,  3 Apr 2025 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707364; cv=none; b=dnH6iTA/QwXRawo0rLOBm92rtKEoHLGCnGs1HYbOdksHE0FoTpqI22TNq0eAjcw+uF3RbqncoM5qHUgFC7/yBMmzZhdi5vddh/PVNHK5fs7QMIbHeE8N4Juysgeh92r8zy5wbFp69qeLXaQTek+dQKk4kEEmLu2QNtkSdBfmR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707364; c=relaxed/simple;
	bh=7zBfxOeKowvILKEW1QSzrQZrveRRJM0g71wQQJo401k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovT4KG2ZvkdtBmHm4rOl6ge1O/I+mY4vkt4BTZj8alUt0cAH1jIssUsWvLpa2PUPHw8opSXZJPlsylI0oyrkU3K88BCO1LqyfHxD0Y4oNHWj/PEBZpewmPJqCjuNTp2jiV75FJuPSpkITN2z2r6FebKuHr6gQQm2C52OmcjsXOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DegWdWru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49912C4CEE8;
	Thu,  3 Apr 2025 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707364;
	bh=7zBfxOeKowvILKEW1QSzrQZrveRRJM0g71wQQJo401k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DegWdWruHCdhP9JJA0QrggNiXWBDI23y7cgUAleIOX4Oxc3Q1hBidGzpkDfl99l3v
	 58T+zg+b+0rWmEIISSHx5Hp3LrJGGZ1kKowuvw8+vo7HSAkTTwCGQg8gtcJYOheDOt
	 v4Cz8rRRdMuEIfFg7QoJPSifnPKDXanK1QFUo/DLMbA+4LUcobNs4UiY07tQcpdl4/
	 BLrB+RBAiDknSqfb7473VIMpfNHW7MtTFgPGmXxIi/gwFyz4c+QdCBzUvWlUGHWCqp
	 v1U0dRSutfEo0qakyBAPo6ugyG7gogAhFVjnz2F+9HHjQ6IsdIRBnVIXm4IxyIUAW+
	 wqlkDpLI7g28A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/18] Bluetooth: qca: simplify WCN399x NVM loading
Date: Thu,  3 Apr 2025 15:08:44 -0400
Message-Id: <20250403190845.2678025-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190845.2678025-1-sashal@kernel.org>
References: <20250403190845.2678025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 1cc41b5092e3aa511454ec882c525af311bee631 ]

The WCN399x code has two separate cases for loading the NVM data. In
preparation to adding support for WCN3950, which also requires similar
quirk, split the "variant" to be specified explicitly and merge two
snprintfs into a single one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btqca.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 892e2540f008a..5651f40db1736 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -807,6 +807,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   const char *firmware_name)
 {
 	struct qca_fw_config config = {};
+	const char *variant = "";
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
@@ -901,13 +902,11 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		case QCA_WCN3990:
 		case QCA_WCN3991:
 		case QCA_WCN3998:
-			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID) {
-				snprintf(config.fwname, sizeof(config.fwname),
-					 "qca/crnv%02xu.bin", rom_ver);
-			} else {
-				snprintf(config.fwname, sizeof(config.fwname),
-					 "qca/crnv%02x.bin", rom_ver);
-			}
+			if (le32_to_cpu(ver.soc_id) == QCA_WCN3991_SOC_ID)
+				variant = "u";
+
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/crnv%02x%s.bin", rom_ver, variant);
 			break;
 		case QCA_WCN3988:
 			snprintf(config.fwname, sizeof(config.fwname),
-- 
2.39.5


