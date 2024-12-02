Return-Path: <stable+bounces-95936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15C9DFBBD
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1016282F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183361F9ABD;
	Mon,  2 Dec 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A3UmPTew"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A544430
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127392; cv=none; b=tACSP1g9I7l/quJpjB9qrYoYI2Eu7Ukt8lR6xPfFKvBAc9k+d1uLVFZJpfAwamz2HOu779oOwy9CToSYDSV3DEHPGdO2HWq9oBwEShcoxQiPvEYBDVvLPeM9IzPIF1i9zx7tPNlWZQ/4yY+l8bAV2ldovfNUyddCOxydGjBEqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127392; c=relaxed/simple;
	bh=z6lWNIu1GGYkQCaqJ/kxgszC+2/1aMZsx7ZC0zPdLBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckLfNR09a1AKmltI7+dnT+QMeX9wftC1So8zFnFaZYZQ8t1ZqP6h6dtS+lQKXUly86yrg99DCnrclaIqHvPf6Jrg0hYKu1scqkv/DwUatwmePGSJeEhb0bTO8sFtUvZPYjDGbSMk9j12m0Eif2mW+RFYJyEqbN7O2q7va9Br3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A3UmPTew; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fcc8533607so610543a12.0
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 00:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733127391; x=1733732191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pg3Yz4At6rILnrTbhiFAD+QZrbg9FZ7kQ3hH3sJqcUI=;
        b=A3UmPTewMQoHi53IeBVTU1qXWEDG+XKJCvWwK838Rlcga3cLWPUihpOBqB1o4/vwPy
         0Y15MD+egSxg0LQY3BISVR0FhvdzSYQ8YxuJ/+T82ik/mgp+qn0/gXbWF5XvDo/gu9eI
         LfiCjCltsO5Z8zMQemwWGaiVTXsx8MtfeYC90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127391; x=1733732191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pg3Yz4At6rILnrTbhiFAD+QZrbg9FZ7kQ3hH3sJqcUI=;
        b=dstZEsuTJAlGrxmCxBRMXXhhNoreMLF2nWcAgjR7ytLMe4V6gNvpHSZw97H28OVJC8
         iCjEwVj8mdw+pYQxb54mGc2VHwOFZrPz+A7ifDxS0vhubtQaCv02PTy+u409pE9+7d2U
         g9OJA+TAftHmudfbCOgKDdHhmnesFqejS91ST56+GCIOK77h2r3JrbLG0CY53cTAKBZN
         SAG2HFltHzZSDkstgFcWuia2iwDePydXu4pt8F4zi+DAjzvTG/TVPcXByTjhSMaU7XPq
         w43v7Aj3/cfA1Kg1nPYlQTyRB0rF6PjJ31PPoZAi5BUvgVZ+lfEwdzUfdYYYRe9G7WMk
         s6mg==
X-Forwarded-Encrypted: i=1; AJvYcCWE+cvRZB2agsyLxbWVMZ1qyFs0W4zSmvXsTdK44wrSPhTUxjyVeHLaed3dUdnudU9lILPcans=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpN8RxeG7IPfMFMThATqhHb4r8tJFieHz01wJ7DI1HKIDj0sty
	f6ljYhKZ4w1j9nSE9tefyvGUcB7fe1WXNOYsZCjWXLTBriM09sdxpBDJsnfmiw==
X-Gm-Gg: ASbGnct2DOlFLnSDavPWgXt11W3oaZhe95Q0gfU8Tvtak61mLWJM48vAaDlYO5gHVk3
	AElRFicak9tGZEQFoWzoomP8VclWeb4197ChlAbiBGwoVGuFxHiT7LgEAve7HSZbqk8b8PF9ffh
	WhJVlZhyEtS7mVESwVAcpRfkEU1f8KqcpbdXAxBHtNlwhitsX1rx8rVaUCDhIWxLwHIUexEIAG5
	X+gC85qNkSzzeFNtARd4kJNzVWQI8a/FhMUeaAXtdRYYu+cLDm8u8ybJO3nAp2Q1Ncx
X-Google-Smtp-Source: AGHT+IEyKQIaeusGCCWVxa+Pk5NLnro9d/aITgSeBa7Kg6kcWmmYAuoWP7vfPPAfBDvpL5S8TRfv5Q==
X-Received: by 2002:a17:90b:1805:b0:2ee:b0f1:ba17 with SMTP id 98e67ed59e1d1-2eeb0f1bc4dmr6645889a91.37.1733127390703;
        Mon, 02 Dec 2024 00:16:30 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee488af41dsm6312844a91.28.2024.12.02.00.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:16:30 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Koichiro Den <koichiro.den@canonical.com>
Subject: [PATCH 6.1 1/2] Revert "arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled"
Date: Mon,  2 Dec 2024 16:16:21 +0800
Message-ID: <20241202081624.156285-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit edca00ad79aa1dfd1b88ace1df1e9dfa21a3026f.

The hunk was applied to the wrong device node when the commit was
backported to the 6.1 stable branch.

Revert it to re-do the backport correctly.

Reported-by: Koichiro Den <koichiro.den@canonical.com>
Closes: https://lore.kernel.org/stable/6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw/
Fixes: edca00ad79aa ("arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 39e4f6a560f9..9180a73db066 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -922,7 +922,6 @@ &xhci3 {
 	usb2-lpm-disable;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
-	mediatek,u3p-dis-msk = <1>;
 };
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.47.0.338.g60cca15819-goog


