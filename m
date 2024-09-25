Return-Path: <stable+bounces-77569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95966985EA7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4901A1F255EC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DBD2141C7;
	Wed, 25 Sep 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwd4DQVm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF192141BF;
	Wed, 25 Sep 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266352; cv=none; b=CCOT8oRsUyMMBJDEMP3OOD0WWH4PvfaBulXca6TdOUNpMvq8ZFIKqsSE38dXKSf0JjDgnn69J7Ks+dJOI4zwzCp2k82IWzG7Dk6oA222lR9jaZFVic9iZFDok7kdMOgMDhP3pecaneTN0sB/rCkonz2PjQlqQ+T23f6uQw7aIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266352; c=relaxed/simple;
	bh=ssEjc5/dRTO6MB+5i2lZDvUMo5OiEdGAdMn6GaNnZpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQNdOnmPxmmQwx+9v38EVCiN/6HGEtwl2wTITpwrYMEg0YCrnHuF/rhHpKFOgmQLgL/v+EeB8vEAi1MNtaEliex27FZW7wkRtW0QcOzMgt0geJEBuFl5E5silcMR0oXvDUthkpNexfUky/VPWozLu6JIyueSzU0Qbv1EXCAk8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwd4DQVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FA1C4CEC7;
	Wed, 25 Sep 2024 12:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266350;
	bh=ssEjc5/dRTO6MB+5i2lZDvUMo5OiEdGAdMn6GaNnZpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mwd4DQVmn7h8FrVNVUurdxyR4gNALy6OP6hSqA1QwbCeeL5043QpAOS4TPVSW7DMN
	 8Szbl5EmJYt5RpsgDAk154WOrst4SgHx1CfI8Dn8DVveH+JsYHvAW7vXtz8np/BQAk
	 pjI/RZmd76nWdgBop/DSFPFMy7iFT5QKD7ZTambNS5T6yRaskVN3LRVnDxOtTk8frJ
	 s/koGglcji9hndETZjYN/ucTuqnGQ0ZtrbKmEMGmadmRkDk4w3TBseY6KRI6OHT/2l
	 zYpPLxMjFrI/Oz9xiy81NYb2RphaCBFFtsK4hMM3dsN2TFk/YYvKVg32DE+HK3ZjRl
	 5749CMAxN3smQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hilda Wu <hildawu@realtek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 022/139] Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B
Date: Wed, 25 Sep 2024 08:07:22 -0400
Message-ID: <20240925121137.1307574-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 277d039ecbb42..1e7c1f9db9e4b 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1285,6 +1285,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
 
 		if (btrtl_dev->project_id == CHIP_ID_8852A ||
+		    btrtl_dev->project_id == CHIP_ID_8852B ||
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
-- 
2.43.0


