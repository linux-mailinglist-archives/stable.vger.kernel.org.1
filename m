Return-Path: <stable+bounces-127891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89DDA7ACE9
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9EB1894398
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DB2857F4;
	Thu,  3 Apr 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5A32CgG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC12857EB;
	Thu,  3 Apr 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707324; cv=none; b=jmSHAfX5to7wolpCKkMtkcl3w8te0i7iLohQOOKPqt808LX5nt35YNlecdogO860EjdHQRAeptv0BaC0RnAKmWrmzB+GBiaoMeoLXcp1z3tF6rT1NiUeXOkduyyzBDufkH690FaZnaZyaDZGm30OZSVZy6hMvucWPzJ6EMHTB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707324; c=relaxed/simple;
	bh=7zBfxOeKowvILKEW1QSzrQZrveRRJM0g71wQQJo401k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhROi5J2zC0k3WggMtohn+5CVYw1oSJiF1hFI/CED+Ndd7NQQR6GAxhE7BvB6vgyjeaD/yYx8USqhKgEMIUZhWJC83rDqYa5zPZLvky2NKZnmEsAw+fYGpgef3yzt8rJRxBgw7iMO7zjRzveyiuKvTGYblhOb2gJBqiJN8PxEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5A32CgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538EFC4CEE9;
	Thu,  3 Apr 2025 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707324;
	bh=7zBfxOeKowvILKEW1QSzrQZrveRRJM0g71wQQJo401k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M5A32CgG2boCZmt8otWIujz4BxW/Wc7jBUm/ULQ+KEo3CtN6eyiu6hLCJgk8VB9OC
	 unJ6U9SBjtDaxshoU4sL3nSk6EIKSK6CNM8VZ2IHZDGcoSQJ+7Cx3uGG4RaNeVpwcf
	 XWz5KiAMbz7r5YQYE9/V5njoMad8NuAL2ZhrzcrvfHPKJHLWOPSI9dxUGz9HElr0By
	 f8eyhqORkCmOC5BIiE3FtgNXt4B92d/IzwrxKQxHSHLgQf1YTsyOKgmLGMK3rBULDb
	 F2/fBOLA+QMQkzPkzv6+R9vCpMFr2b8ROxCOaUR0mXzOKoasl67J6RJ5M5Nh32nyr7
	 AnqAfQCuSyUgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 26/26] Bluetooth: qca: simplify WCN399x NVM loading
Date: Thu,  3 Apr 2025 15:07:45 -0400
Message-Id: <20250403190745.2677620-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190745.2677620-1-sashal@kernel.org>
References: <20250403190745.2677620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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


