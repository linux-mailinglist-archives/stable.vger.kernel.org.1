Return-Path: <stable+bounces-105481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F289F988E
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03C219611BF
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114B1231A21;
	Fri, 20 Dec 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biahL2B6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64821A45A;
	Fri, 20 Dec 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714808; cv=none; b=udwo3sOk7nmhXi3gMPzSOnQqyf6MXYEYNvnhujjqRwHvf2TzB4944LwWKcv9WKpKGfw39LrpC8d2Aha/o354QUej5IDA62m9N5TFHuFIaMXejOykY4coXX7FXGkdQQrxYdfdwvHGZHsTSqhkn3T82GioFrz5ip6aVT0zV7OKnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714808; c=relaxed/simple;
	bh=ZmU6skRUAaHDOO2tmT+YNt3NFANa5hYasTGlX8D/uKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9oJ+4yihoO9DolVZy5xDaEUhNg/z4Lb3NbYiEvkHhU26iX/Z4vgcOxVcJBPK+4jOnTJYvLwby6NkuqfNuhMOhV/gGXjBPWUN2aSyhMCGtM+pgn5sL8CKEnlt/mPNCqVhQW0/npfLO2HUmgD6mY2NtOzTBii+R7QAwESNKo71qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biahL2B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EABC4CED7;
	Fri, 20 Dec 2024 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714808;
	bh=ZmU6skRUAaHDOO2tmT+YNt3NFANa5hYasTGlX8D/uKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biahL2B6LZj0PukTcKNYYUYPY6DohXJD7xU6TXffbA1BBxyh5E8nQ1AYDsRP+MUFK
	 TC20wnDcV8hdNhqP3e5Bd3Oaza26SLg3KIvbuIDyDiDQmgVZ0wHt5mlDTu+K3zXEK5
	 G6xMtWxWUOMpzMExZE6FxKAZ/Zr3wNzlQG1RUnwdy1DHk0wgdZN0EKqZT6PhdIfTXW
	 CCdPIW8pDiN2v5XAon1SeqXq2tUaSmKQq1wnFwJed62UhzflMAe7MuzxoL9NGf2Up5
	 Ia4DIa/6nWtG/j8MBHnP/SyuRtn7/8y5ceKlH/3NZJxGpHNHLR7yndJTZFxCZmcLrh
	 PfJSWCF4OiqXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/12] ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model
Date: Fri, 20 Dec 2024 12:13:09 -0500
Message-Id: <20241220171317.512120-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171317.512120-1-sashal@kernel.org>
References: <20241220171317.512120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.121
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit 50db91fccea0da5c669bc68e2429e8de303758d3 ]

Introduces the alc2xx-fixup-headset-mic model to simplify enabling
headset microphones on ALC2XX codecs.

Many recent configurations, as well as older systems that lacked this
fix for a long time, leave headset microphones inactive by default.
This addition provides a flexible workaround using the existing
ALC2XX_FIXUP_HEADSET_MIC quirk.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://patch.msgid.link/20241207201836.6879-1-kovalev@altlinux.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bd0f00794c30..8d4cbd9ac2f3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10436,6 +10436,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
+	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.39.5


