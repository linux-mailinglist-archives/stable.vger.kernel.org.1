Return-Path: <stable+bounces-127816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FD8A7AC16
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E69F178EAF
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25264268C60;
	Thu,  3 Apr 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkafPM1e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D81268C59;
	Thu,  3 Apr 2025 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707150; cv=none; b=GVhkBpud99Piii02GIgBf1noVu2KTX4SEoX/Vt/lWFMRHU6Ei3lSLGbqXgtQMhyzgaic3tYcIlNSMliH+5syWG7ad4mz7Xzcov0PRCONskYP/qDSunVgNhFtoUTX6PUrOsmVw6SZBsy5Q7zhWqNirp+Yg1/kZH8VeUFwLkdX+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707150; c=relaxed/simple;
	bh=pT4Q3S01Su1Abesxq99U45A/8NkbW73u1b0G/aLZtOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUFrv+1e85MxkEjxus1jU5HXCsKILeUAesCFLfSRu08OMM8SFQSaDA9ZRzV3Qrx2kDztnvIVA0GvfentECJRT43JfZ8lS7lFh5n1zPAl5c2dan0nVmzsKuhR6yo7FNKcDhbHkfSSNkSDK7EwasyTPC2QQMyGxgghYG5IYXu6DbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkafPM1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5E4C4CEE8;
	Thu,  3 Apr 2025 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707150;
	bh=pT4Q3S01Su1Abesxq99U45A/8NkbW73u1b0G/aLZtOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkafPM1eiyMr2ZOIWoKgpiA/v0BxvLQ/D+pDjbytUg/UB0l5EBmhACreB0dEZfdO/
	 Yo9YNoTgg7je6Lvx0o6LMyojQPA20C7YAm+1eMgXlHo+xbXZbkPN7i22tgjI2Za1Yk
	 wcQEcVULvkrakILqLeKi179tg6Pf3W5IA+G6VN0pWMkXt0eXzD3pHqcNZsRLM7ww45
	 5l8RNjZKN+4Y/773MvfUjGr6QRuJ2Zsnjo18vCBlHz9l9MBa4YQw8cD5NLBQrXMnfC
	 /I6DqP7S9bgF/3Ebn4w4ABxyMR/JrtkBmMOJjGT5ksS1Xu9cxiW/E/LB6vJY5QruIx
	 d+OVwEw+8YUjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 47/49] Bluetooth: qca: simplify WCN399x NVM loading
Date: Thu,  3 Apr 2025 15:04:06 -0400
Message-Id: <20250403190408.2676344-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 04d02c746ec0f..dd2c0485b9848 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -785,6 +785,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   const char *firmware_name)
 {
 	struct qca_fw_config config = {};
+	const char *variant = "";
 	int err;
 	u8 rom_ver = 0;
 	u32 soc_ver;
@@ -879,13 +880,11 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
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


