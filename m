Return-Path: <stable+bounces-94410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF899D3D2F
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D55B25B9C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85FC1CB301;
	Wed, 20 Nov 2024 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9rUnhxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9E1BD4EB;
	Wed, 20 Nov 2024 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111655; cv=none; b=iEijZsqci/BCfKZwSxbU6+t0n/WDRmlxOumxDi6twUozDTFJW5ApsuxyEEZQSBjlOEsF8mw4k06XaBtUtOweKVXFNC5onsTug6nwfEkwVwlXQWkvZQPTqQHOgDlD7p/UCrcuGzwWD3Gnxjo2LEVFc7HWmyl9vV1YYIROwR+Hb2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111655; c=relaxed/simple;
	bh=g/fDauAIwxP9y+zEDZ7jVmGSEPPMIjIzGldIfN7Ozfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lzjxd4Ok23mMw6V/HyYV//Kn034zTZ5ixXb7AdeDIHL91DS0JXs6azz5ayzJO26TBoeX9EJr5+dTXQ0s3J3dLhTFdXqAs0/rnTMyn4UPQhCItiucMbFxwps6JNshW7gRDSXp9Dg3YiM/cnLB8lFyh4DizTDXIqVsXxbwtKIdPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9rUnhxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303BEC4CECD;
	Wed, 20 Nov 2024 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111655;
	bh=g/fDauAIwxP9y+zEDZ7jVmGSEPPMIjIzGldIfN7Ozfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9rUnhxZjeCjaZ0TdUFcXVX7p23ryRdLvFdG79RCiBKYDogElDHq2tUhK7KaboHFx
	 pEEIMEqn+VjC5gQzCaUdSW2jFyZ4WRAA1iS9KUcI7pOQ3DQwusfB92JzsJGQ8gBoEg
	 YHEBUvzZRISJdXEUZRZKgv1OluiDZXwPdmh7F7ZSpvMxUyx5405/vLaDMyTasHBTMG
	 gX+lX/pyEno5jO/vAL9RAUB6ai9+2xjpgz+1bI/T7bFVnCJbfoATiZsCAZ3W9rMj31
	 +y8WCcuBHcnzIFW9tlg6qmsHBaJ3sM3zKy4q8gLVM4KGx9jrMejYdfnfsP2IQeczzK
	 T9KMacTMIQtKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eryk Zagorski <erykzagorski@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	lina@asahilina.net,
	cyan.vtb@gmail.com,
	soyjuanarbol@gmail.com,
	mbarriolinares@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/6] ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry
Date: Wed, 20 Nov 2024 09:07:09 -0500
Message-ID: <20241120140722.1769147-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140722.1769147-1-sashal@kernel.org>
References: <20241120140722.1769147-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.118
Content-Transfer-Encoding: 8bit

From: Eryk Zagorski <erykzagorski@gmail.com>

[ Upstream commit 6f891ca15b017707840c9e7f5afd9fc6cfd7d8b1 ]

This patch switches the P-125 quirk entry to use a composite quirk as the
P-125 supplies both MIDI and Audio like many of the other Yamaha
keyboards

Signed-off-by: Eryk Zagorski <erykzagorski@gmail.com>
Link: https://patch.msgid.link/20241111164520.9079-2-erykzagorski@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/quirks-table.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 75cde5779f38d..d1bd8e0d60252 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -324,7 +324,6 @@ YAMAHA_DEVICE(0x105a, NULL),
 YAMAHA_DEVICE(0x105b, NULL),
 YAMAHA_DEVICE(0x105c, NULL),
 YAMAHA_DEVICE(0x105d, NULL),
-YAMAHA_DEVICE(0x1718, "P-125"),
 {
 	USB_DEVICE(0x0499, 0x1503),
 	QUIRK_DRIVER_INFO {
@@ -391,6 +390,19 @@ YAMAHA_DEVICE(0x1718, "P-125"),
 		}
 	}
 },
+{
+	USB_DEVICE(0x0499, 0x1718),
+	QUIRK_DRIVER_INFO {
+		/* .vendor_name = "Yamaha", */
+		/* .product_name = "P-125", */
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			QUIRK_COMPOSITE_END
+		}
+	}
+},
 YAMAHA_DEVICE(0x2000, "DGP-7"),
 YAMAHA_DEVICE(0x2001, "DGP-5"),
 YAMAHA_DEVICE(0x2002, NULL),
-- 
2.43.0


