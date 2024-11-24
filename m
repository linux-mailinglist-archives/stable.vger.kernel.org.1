Return-Path: <stable+bounces-95147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C979D76C5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0562C01ED8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018522F664;
	Sun, 24 Nov 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBTBqi8G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85B22F65A;
	Sun, 24 Nov 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456139; cv=none; b=G4VhEP3take7SA96pmGk3MJDUUL0dLrqGsaCBsdSS//6N0+AWtiuhRBTT50Tt/wr9qeYJrmOLD/Wjc1hsYUPoYAiDRrcAntl87JcdnO3adh7yRQstdpjOqPWgkIUhc/vlY1oQ24xZvVGpChO16IOAXP8MDzutX68oh07Hacz810=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456139; c=relaxed/simple;
	bh=HQu77XFg0aT1U7uWWUflh3GXzswXFL2V0AkWMKKHtoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTmQxfQ5MdtJGL+w2YsWI6QIH3P5WOIjDp3bKG7ZOX5JEUaXk0G88Q4DGbST3eNp0evwF0bJEgRPmK7U2ic00M3mDGlAfP8UitySNKAFbi8l2r7DvX0p1F37A2dkL+/63OnpkNWP9uOqV0pRTohMdjON3fFzc7F34hBkjKxXnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBTBqi8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E4DC4CECC;
	Sun, 24 Nov 2024 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456139;
	bh=HQu77XFg0aT1U7uWWUflh3GXzswXFL2V0AkWMKKHtoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBTBqi8Ga9wsGPbsb9qUjM9FCh5/7TUCj/5Vja4t+fySBPldLB+lpFwWqt9I13By6
	 rBaDcDNYrDsNN2ilI8RmQppyglbiFzvxmwbTyt2t9K24vCZ6DC0KxLcqq0M6hLugnV
	 AUlk6QcGmAhNmRiSAiv3KGfcLdnIze3z05l+vr/ns6rstMqQ3eoYQo535wpEkw1rnu
	 wHrLy/7e4zfKxDYhnNk5kylkgtWukrzEgVXp96XPux7umLGWHqUOgJwULLkGrDGzu7
	 7uapGOAL7kf4GrniaULRmxBWuC797MChpOQ/0kPXbX9eUgp/G/GXY2adLa/5gDBpUH
	 nKcWeW/emTKIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Danil Pylaev <danstiv404@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 57/61] Bluetooth: Set quirks for ATS2851
Date: Sun, 24 Nov 2024 08:45:32 -0500
Message-ID: <20241124134637.3346391-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Danil Pylaev <danstiv404@gmail.com>

[ Upstream commit 677a55ba11a82c2835550a82324cec5fcb2f9e2d ]

This adds quirks for broken ats2851 features.

Signed-off-by: Danil Pylaev <danstiv404@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 326ef250bab94..fe5e30662017d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4490,6 +4490,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT, &hdev->quirks);
 	}
 
 	if (!reset)
-- 
2.43.0


