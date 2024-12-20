Return-Path: <stable+bounces-105467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC59F980B
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A9F1898D2D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108BC22CBE3;
	Fri, 20 Dec 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHQEQXgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C044B21B918;
	Fri, 20 Dec 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714775; cv=none; b=cBl2P9/hPihJraUhJx8KjeGU6zy6UE9eniPcQm0FqeNaYxsZk3hxiajznUKuRk3SpI6Qhok9S+HJqn3/DfsftK6ach4lp59Kd+ySUb8ZrHHMoNEcCNsiCZQ5XZZoA68k9tbLsvmVhYzT/d/UhBM6grY/8o28hoqP1c4I6/N8+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714775; c=relaxed/simple;
	bh=hNHGnYc5ZAkJa5JuS9WLxLxnTFw9mkeP2Jg5g2FEn1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HthPPwW90MXVHNQnj37sGJ7+hV13t7KDNQw+C93F0vz2/3jvZCefWtNakfwDT9vI/j0OsRIOPW5eGjRsZaPgFUOKv17p5S/Mliiv4w6cinxfvyfpz0gMBBUXU+h5yv13ggOYNM7FQ7W3rzPykCWo81H8DWmtg5X+sVGvaB+4yWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHQEQXgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361F9C4CECD;
	Fri, 20 Dec 2024 17:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714775;
	bh=hNHGnYc5ZAkJa5JuS9WLxLxnTFw9mkeP2Jg5g2FEn1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHQEQXgp/QTye6o6Kx2QPAsuN/auJMnHNNQ3JQEBwrXSMvLzIWwx26bO8UiETQwZG
	 aeM+xRrBsRjURdFJlbnc+UsEIYSM9KuQZyzwr4hy/TOLo8h/aPTR9H0qPQRKHaLib9
	 +H/P1cksD/EW2svKiNNNu/4ibhbO0Od90GABFEkg66OPDNOQcUGrnPyrLA7XB6L/5K
	 I4h/iEz+Q2bDr3Gv9E6eUepYzE5dq+mszMx8NsEG8JesO68EEGcNJzMIf03g24MK3C
	 m7BKBMu8LaZKKU4LrY7Rrn9q3PeeJf2octe7ffZuXaEaX0bit5BB1V/BoWTvuk+LoO
	 79rDjd5dlRVCQ==
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
Subject: [PATCH AUTOSEL 6.6 06/16] ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model
Date: Fri, 20 Dec 2024 12:12:30 -0500
Message-Id: <20241220171240.511904-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171240.511904-1-sashal@kernel.org>
References: <20241220171240.511904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.67
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
index d61c317b49ea..19266af04443 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10624,6 +10624,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
+	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.39.5


