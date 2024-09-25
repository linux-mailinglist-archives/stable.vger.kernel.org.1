Return-Path: <stable+bounces-77369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F81985C5D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EEB1C24A26
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3221CEE90;
	Wed, 25 Sep 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/FTC3tB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DE1CEAC4;
	Wed, 25 Sep 2024 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265564; cv=none; b=GxKNtUnDgQNoZwkgnqMiFfPz6hQwezz8DiRUiJzmmTlcwimRNozwEYfUbxN1KnoCys0ca+pMIRcf7vc7CAcBA4dh+wTiX+g2M8zx1yHz/CkppX20HZtZE6SfYmqX0EAbBOGDXgQEho71O5X4GmFIMLl/SWFRxIE791QmmsbC/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265564; c=relaxed/simple;
	bh=GLGBRaOB7vwzqPbWZD30daJmxV5lZ7retN6JsiWu7vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhnwJog/+mIFrJP7tNEtur+StMCWsvWgnsYpUcH9S3R7gbryVy+K8c8ngEQEYfAldGiAi+LPy07DmsIJBc395ysiS4jzOKjEuOt/xqEoYQaBmJ8L/wZ18F19ep6mgVWoGJejZKZEhw3V26Q0b1KEVt3lcEN61++2k6QzfMg2QZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/FTC3tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC76C4CECE;
	Wed, 25 Sep 2024 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265564;
	bh=GLGBRaOB7vwzqPbWZD30daJmxV5lZ7retN6JsiWu7vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/FTC3tBV+AN/DElABJY1yWiKmxymOXxNl59ZyJO2prmhJ3U9Yb27SUHamCrGXT0F
	 dJ35+ZV+kwXA6eDaIv2vF+X5JakJkMko8CRe4VOgakHHvgQbYQ13Gy1FMRSYoIft5L
	 0U/L+KifcCV3/JbM0Ap9xNWrKozQpPXuMwZC6SopOdMLJk5SHPJgM87/JZly5Bgy0S
	 +69aZGhygbwg8n1x7R/GSMHFwx9nC0Mbmd11Sh6SIeqOSHBvkhlJAx8IXh4K3/9zJA
	 pjryF73vOKbYoIAFE5Bcu7PxmGrMnIzO6wbYds/2Gg7k62R4QmeUEtJfypRBwmAWj4
	 C3gH2x94FStnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hilda Wu <hildawu@realtek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 024/197] Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B
Date: Wed, 25 Sep 2024 07:50:43 -0400
Message-ID: <20240925115823.1303019-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Hilda Wu <hildawu@realtek.com>

[ Upstream commit 9a0570948c5def5c59e588dc0e009ed850a1f5a1 ]

For tracking multiple devices concurrently with a condition.
The patch enables the HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk
on RTL8852B controller.

The quirk setting is based on commit 9e14606d8f38 ("Bluetooth: msft:
Extended monitor tracking by address filter")

With this setting, when a pattern monitor detects a device, this
feature issues an address monitor for tracking that device. Let the
original pattern monitor keep monitor new devices.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btrtl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index bfcb41a57655f..78b5d44558d73 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1296,6 +1296,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
 
 		if (btrtl_dev->project_id == CHIP_ID_8852A ||
+		    btrtl_dev->project_id == CHIP_ID_8852B ||
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
-- 
2.43.0


