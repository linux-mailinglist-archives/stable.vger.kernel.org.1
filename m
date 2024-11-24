Return-Path: <stable+bounces-95085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631629D731F
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222D2165206
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7DF217651;
	Sun, 24 Nov 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJD9LhCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE36217641;
	Sun, 24 Nov 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455922; cv=none; b=NNryq59r3sqe5Zpehnt9tg+mDiQWTzc0FcWQc+wrSNPoUjxNMEU7WxghSRaTvz6cjgNAGOyUELQQmUPnv9BhFz3X8NNN3us2s80MBdUzhCrt52SeajUQ2NLotav2gDz/nXLV64/XSFXEMt1epaHsfQdtOhe2+yZWGAmHe+fkbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455922; c=relaxed/simple;
	bh=8TYYnKXrnWWxbmOvj6BXnz+AAs1kWru1KbHDvmHVS1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llJCMQnpTEvAC19Fd0rxtxu0Os4KX6ca/GBzmjZeftsLtiRufrZxM32t7GeIcVJGIthXeX0MiXHQryikYcnM8y2uupRHIxG6CmC3PaS2M4ciSe6u7eanQRpaXi/tjkj3lecEUJHsuirmKxYUL1mbfnCOfk5oSEKXdz/BlNeywk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJD9LhCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A52C4CED7;
	Sun, 24 Nov 2024 13:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455922;
	bh=8TYYnKXrnWWxbmOvj6BXnz+AAs1kWru1KbHDvmHVS1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jJD9LhCkmS44cEobt6sO40xcS0ut9XokNsEbYCViqvsVPEo0aniIuAOh+InymBvdP
	 JngYW74gkQ/EGxQuryPStLHZ22i12fFyxHZOmW+KqAbogmfvbPn9GpYFHWowtw4EZj
	 E9c+ly6o9GNRMmrDcFv/STfe7AJJIfAdXT6mnbfAFw+gILgmoeUCSa6RjwkqLaPEyf
	 mC8OWrnD0+9tuPnhl5nTSAw8wHpDhDlaHpLjQ5rjSOF1JHBZaizm32bzTv4LbU2Sx9
	 bgMd7f0r7vmuf+m3XxkE5eCpgJjxEzaVoUes13Pf97aG2gBD4lh+Ig5bDKWvQClcSW
	 ee0dT7fApwVAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Danil Pylaev <danstiv404@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 82/87] Bluetooth: Set quirks for ATS2851
Date: Sun, 24 Nov 2024 08:39:00 -0500
Message-ID: <20241124134102.3344326-82-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 2d48db08dadf4..b8c4b0a26d449 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3952,6 +3952,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT, &hdev->quirks);
 	}
 
 	if (!reset)
-- 
2.43.0


