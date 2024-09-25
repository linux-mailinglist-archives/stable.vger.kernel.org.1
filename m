Return-Path: <stable+bounces-77125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B4985878
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FCF1F2162B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6718E358;
	Wed, 25 Sep 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMShfbbj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9BE18E345;
	Wed, 25 Sep 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264263; cv=none; b=iOXV95ea1NIawoblZ3zJGsh9akvqIkwms+7ZTk9HrzRwkfflkYi818YauJwnIyqPbJMTZiU/ltaIfOSA+gcnSw6YU5zVt8tV/RbDY7yfepn72HOv69gK0PNBMaaFOrOZzS5ZHOd/esRjjcFDy2nEQbK9nupN9O1isSKhXnFN/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264263; c=relaxed/simple;
	bh=hNK6gdVOxMWFm4KxtKhrShK+GAqDkBU+ks8WELQp0/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrcUbSv5uwL1tGgztQ+xcYbDyucVUIVM/eCFmvtSoitHCzslcziVFxBqF+r14k1EF4qQ0KgHtvv6FHUYQ1PI5FUDCGLm+JxcaIYh50QXU3DnRxoLXFJQVKtL4gKp2eWowiQaQU3uvu1Hj36R5OPpUhrp+vtXGqut8TfJg4/l+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMShfbbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA86C4CEC3;
	Wed, 25 Sep 2024 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264262;
	bh=hNK6gdVOxMWFm4KxtKhrShK+GAqDkBU+ks8WELQp0/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMShfbbjxLawr2z1tztaIYd+rHMaFyBY8uNI33CufNU/HRDh5L6pYEJtsru5gQ2NN
	 /IRZl5DeWpkvdo0WtGtpS1Z9gjAtIieciaMEn5aaJjPBoNsjvGgvEOAzSgjcn0Iyf4
	 u/fX0jEfhbEkyi8+JcNfAibKJAXC2I4MXGsnPHf16P9jFtN3yDvDn1gPuzaGYnOMqK
	 UzWpY/ooqjvyzhUAWKdXFVR1R0J0wIuRNeIcXWKmd2EPVaT+KoN0a6pxj+2bZ7GAUL
	 LdUSMiVXf3aT+kYzoI88112JAqQKwkEgoNhwQoA7HUo4oS2JPoF+fw9BO9H6iG+kHK
	 REYnol/Z7+3Tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hilda Wu <hildawu@realtek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 027/244] Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B
Date: Wed, 25 Sep 2024 07:24:08 -0400
Message-ID: <20240925113641.1297102-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index fd7991ea76726..7cce4abc8a023 100644
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


