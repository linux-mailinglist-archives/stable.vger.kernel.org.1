Return-Path: <stable+bounces-94397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF7C9D3D10
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDE02849CA
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179661BDA83;
	Wed, 20 Nov 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCc9t9eA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6F1BD9CC;
	Wed, 20 Nov 2024 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111581; cv=none; b=VI0qnVxAD7rXVPlcxAaZaZElzGuWr8hbjd062cW0DPu1Xssq2zN5CAWPuYzHU3OkyHTx2lqzaW4rshBrZKOX+lH3eoEL4Duaf19fLMI2lQOhd7w3fD5yW0d/9tvZ+j+qzDsAv5340OaXGuMXKAX8lCp8IjsTQKuUNu3Q+rXZlds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111581; c=relaxed/simple;
	bh=b2KMYcgaePsFT9lMEfCAsjP86DjVhP2wLMv3z3GDTF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aF9kuBdZfhK7E7ZJulbSqewDb7RRdy93L6szAc7ItFtA81XMuAPsLPz2dN822qR5UMj3KGDAQUhpcfvawkTH0IPU8VY3b1XT//Wl8MOu1J2lfD5mTt5DHu6PzrIbDChBd209UhfXU8WXlrmcsvr7MbzTJQ8clkOcJDpHlNOPg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCc9t9eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C660DC4CECE;
	Wed, 20 Nov 2024 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111581;
	bh=b2KMYcgaePsFT9lMEfCAsjP86DjVhP2wLMv3z3GDTF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCc9t9eA8TKfa+yL5dkyBlWXo6FE0eoVFPDzdQs2Lt3+gQN+YxDhJD8y7PlVSscWU
	 uJIlDDShEsULv79iMWHWZQqReu4HgMJGyQAHlB1kAKfWoPpoxm8Zu8RlcOUM1fh57N
	 7hcTxauJXiyiGc1/vxR9HMNA1hXjj1tx4L5LaMlihQqLBCGAtAvRCtLYwZ8j8o2AHg
	 8zhpJwwmVu2YX5Obogyj72ciebi4HoRZUy6B7RD/rXw1BTOL9wArj4awAcnzv9TV8Q
	 LApwfYfYVOqBBi2XO7xDoXd0a7BTXdwUwZqYrRdBblOvFLAIsFIBZFa/7TKPXHtCWO
	 Wj/CRhjqo0o6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eryk Zagorski <erykzagorski@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	lina@asahilina.net,
	soyjuanarbol@gmail.com,
	cyan.vtb@gmail.com,
	mbarriolinares@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 06/10] ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry
Date: Wed, 20 Nov 2024 09:05:31 -0500
Message-ID: <20241120140556.1768511-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140556.1768511-1-sashal@kernel.org>
References: <20241120140556.1768511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.9
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
index 24c981c9b2405..199d0603cf8e5 100644
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


