Return-Path: <stable+bounces-95934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DAE9DFBB5
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C23CB22274
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547FA1F9A93;
	Mon,  2 Dec 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UsOE4jgC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9A1D89FA
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127375; cv=none; b=oIKvjmj+gfCSaAisRB78XfrHMA1lSj356+Qt64zwHOoWeP6X8tQuUlu+7XUB1EDDK7kIBiG5czZdKa33B080gI84wW4BPiWXvKuekF5sQUBJTkQxYZwQpRXf5IVssK0p71UYyVsfnvYgCdQzlHMa0JDuAz8+gbIHGAgo3nhY+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127375; c=relaxed/simple;
	bh=cKjQ4U+62O9DIJTfWQt+BVUMCS1OvPdRfnbG1jjIL1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=slxZMkOxqnySu66yMmroMsLLgezBNnH586faoIw1k1+mBuIh5vYFQZpbzyZ46hIlUVAi3/Iuc+jCAKR11HEe61djVYvXtDSgsIvB8SezxQ++mF8h44WeYwgrCpokNT4uczK8slekkUK5OV4HorrlSO7IAfD8H68i3mBFyxrz2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UsOE4jgC; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f4325168c8so1870258a12.1
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 00:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733127373; x=1733732173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gfcfEqLWRgyB2HQV5UbiI2sXq612OlwtqN3jGuE7po=;
        b=UsOE4jgCSyuHkG897ntJ9p1fVrOz1ta324z6HymQYrDKnsGNM+2pFtX2/2O76jVuWN
         QFLw4Ed6O2TrItcCG52t6eGt+w3Jy0TguwSEdEPc4FzMwY+ek/mwyskAHBFz5PgLtbCP
         bL/akNDhw1MCRPXxRE7jQV3QPGrXkeFXXl0jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127373; x=1733732173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gfcfEqLWRgyB2HQV5UbiI2sXq612OlwtqN3jGuE7po=;
        b=BbAnJ3izS85vJ4uD6B7pPJTkQv8W4F7ZP9cmf2OnygxmdZ39XhXWrGQ0rnNxlbDwhK
         b8wq9hCeM5TTBp7LNeoRI4slMxp1nrF1KUz8Jot6/t1UithITASBmnKJnYwTpndlC7sc
         urYXuyLWnOLj7XzgKHw9QXtXCadiOnuywHzymxofRM3qUqvhhEjsiJ+9NenuAzxbMkUH
         TPVoUP4SpvXb1RO1fGPYErcPzDoeQbkjGQumx06zOPawy6e4YGBd+rmzq9KC/V1PQONf
         fKInlkt1nmejQwJFHDnD9RFgbsvVumztsJRtFyDxY3WpZ8LixcEKQwkNJDrIWL6VTHaH
         T6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxkQ50QTJj7mgWzP3kLuL48wu1ukr/6mlAEOKl9/vYMm0Ja9wWMjSzxUg6I/UDmfOTlgUyN8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zweTHXPbdT7wEP1yy8Ab04KU4r9jVjunHlN8U+bHhapjObpS
	6kXw/msDl1vtCaR0A1aING4pCNkt0AYrcCRj0R934OErG/K8tq+4ZWLhvDtchg==
X-Gm-Gg: ASbGncskany9CKMp5ufD3OK8Mh4Z1nvhAWvcY4MmQAqBBby1wVhWGt34VaLgqk9nVeu
	T2OA3+FfwoUFZ/R+olpfyLHWfFDyFdMwp+D1f83O56exaB5abu7HeUvW8JZ6IdapT7N7RyBzb7b
	CMP/dWWm18Nh3HWQVVvLcrO0ZgUDOlwdTcrRluZPpkBzXcMYDcjkg/RmGsg9/V32/JupXgQlsfU
	l8sauiKoVZDysJpk7f92tbwHA7wUbndoWwQZmCpVzz0xFoI1H97m87OvEDDMfSy0Aqs
X-Google-Smtp-Source: AGHT+IFqZTzJX7eXH4gzncrgMaOzS5d2OoQ3YCV38eFWBvyrMOWlzrisueoiJ989ZcLF70r9MzLOag==
X-Received: by 2002:a05:6a20:1593:b0:1db:df7b:471a with SMTP id adf61e73a8af0-1e0e0bf54d3mr32960644637.43.1733127372940;
        Mon, 02 Dec 2024 00:16:12 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:94c8:21f5:4a03:8964])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848505sm7891833b3a.178.2024.12.02.00.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:16:12 -0800 (PST)
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
Subject: [PATCH 6.6 1/2] Revert "arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled"
Date: Mon,  2 Dec 2024 16:15:49 +0800
Message-ID: <20241202081552.156183-1-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 090386dbedbc2f099c44a0136eb8eb8713930072.

The hunk was applied to the wrong device node when the commit was
backported to the 6.6 stable branch.

Revert it to re-do the backport correctly.

Reported-by: Koichiro Den <koichiro.den@canonical.com>
Closes: https://lore.kernel.org/stable/6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw/
Fixes: 090386dbedbc ("arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 34e18eb5d7f4..b78f408110bf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1312,7 +1312,6 @@ &xhci3 {
 	usb2-lpm-disable;
 	vusb33-supply = <&mt6359_vusb_ldo_reg>;
 	vbus-supply = <&usb_vbus>;
-	mediatek,u3p-dis-msk = <1>;
 };
 
 #include <arm/cros-ec-keyboard.dtsi>
-- 
2.47.0.338.g60cca15819-goog


