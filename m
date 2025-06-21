Return-Path: <stable+bounces-155236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CDAE2CDA
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 00:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5AD17795C
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 22:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4CC1D89FD;
	Sat, 21 Jun 2025 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGNJnBZX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576D8F5B;
	Sat, 21 Jun 2025 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750545136; cv=none; b=Xgo5H0FIezqh64B4CinAba6LdtIZ0p4HQGg2viN2CqcvRLiCdPqi9CC54uiim3fbDZ+gMs7tAVJTCRH8eOz4CldD86s9Qn8gHyzWT0fRwf+5PBjeBjZn9TeKwor1mCG7mzHWT6CAvjhBxg9blTwGaRuv/BMYSH6DatdAfB0zS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750545136; c=relaxed/simple;
	bh=ON7DH6xoSIFxZmkM6N6EvNOMSutTfTLjnZiqAp6jygs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBk0kGpUENDcJAxlSV2G2bfQUyguOeYUaz54OGxt4tMWJLWOXosqeSSzxUF7xhxyd56jUNhGeFA258Lj0Wf3DnyP8BgeZyvYaq51ovsspNBOrwwkt2aTE9cNHD/ljXDlr4xmrDLHdejcf9qjswk5omqr8/g4dxcv8v60+amm8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGNJnBZX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so19584245e9.1;
        Sat, 21 Jun 2025 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750545133; x=1751149933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAoxW/e+ggRYMDlt9WgSDd264vOhbbl8QTdPx9pQhnA=;
        b=YGNJnBZXY/WLuVtlABPhzADG/BkGXT3lptX6UEie1Rbp36NdVNVR4v6r8d90M2ymHR
         NPhee8wnUnYvJTW/HaKuAUvhspmEFujeVIl1/pzSiM3nCidR8tQ8R99Qv+94dueWcL+M
         WNpfVz7GajrI/0Pfu8384rj6Yn6busdDzYx6ou4tIpS3Uu6exAo21kvauz5tY2ULplr5
         U6EUmDUd85XBq6rVzWsfz6Zy7ICI25z+2XwZw9z8YF8WzA80YjwALkiACAG1biGcmzwO
         yDoRDiAO2KfEKzkfqqADSGStB1EP3w4TddbwdiwDfZ6QKfujjggqUVy7QTh9NREemuz4
         S6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750545133; x=1751149933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAoxW/e+ggRYMDlt9WgSDd264vOhbbl8QTdPx9pQhnA=;
        b=javDIy2mbMnSv/QzSqoocMss637ZR6w7T6vlN3khG7V/6VNcGdd6DJYSM2s07C/vUB
         knc0rfMQOQQOAMiPs5NLmPj5gzWaDv0qQP2eYONKk1BbWPaHrASjf9uE58IxRduLnga3
         1ALXjCY82q6FXn/o2GiZ0mFa1/cW2dyXKZsMWYss18N4+290H2gBDaNLURmti1auFTo8
         hPigiXUG19oMoq7/cgmdVX0WcS67BQXkbBwRJCP7X9rc3gQPlEp34cJwxuqyyMfygq0H
         JWjKARJQvMKaYWyEpoPn1VXU8XgbxDE7dVgtBPtLu2SxvsQwNEec2kRIGDZYztn4a275
         TIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiUlk2jCmw85850BXiRzHc73PIjvwsYRkExKc3XgJq16gf8mSTnyoqImRieo72NSeaOZVhDohG@vger.kernel.org, AJvYcCVj3AZV8zvAF/P10pD+F3AfX6SUDHKkNXwWrMx2q74B7RlvX3GnhV70sAxmJXT7N33IhinPG6hSWex9+UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMuXQY/ZEnqkzFOZksfhj+6F9pNdebgNDEFJwYI0vy7xIVwC9r
	IiwHrmqMOChrPKP5iSMGRBOgRbjKSTtDQYoGI2w77seBbQ5C70d0Gt+n
X-Gm-Gg: ASbGncu1IrHSrhMphvBVp5W2SdHWxoBJOigvN1vAOjbqeUIsPPFxDDaq66dlHMLj5Tt
	eVaaxcJ0JAGzJN0YLk4YFfLT2KwGM4/qLlShhrG5+pGTQR97kW6VNId25fSxsDVQbX52v9B6AlL
	eTaKCpZ17hlc0lP/VfIZa8RH0qcDnkW6i2On3br+aPbt+hlaustkbVl2ysU2swlmLaGT0+9hth9
	YYoa8fMb0e4C+I62o7b2q6skTPolazhxHdbre+rQW3shdlcSTiF/n+bK7l2qNWZeQf/mt3xjobk
	Ih59cm7gJg8JPNFH+chHHNQ4t8pYokd58Sinh+u41jJn7qijgHbyqaUAyxwhkVH+GvZ+HBQpMMm
	cNP4Ru0NbOBm4eqFk9wB+MQ+JB2gq7J2pu5VOchb5U68fp6zygmOGMuMFpychW9KfQe1y
X-Google-Smtp-Source: AGHT+IEyYiFS1aymjKhEFgjm3HvGDg7MoeLT4KRKQRjXrxRwA9Uc+FvhStlDTDFXtpW2mUn8PGLY7Q==
X-Received: by 2002:a05:600c:a30f:b0:453:691d:900 with SMTP id 5b1f17b1804b1-453691d0bbemr38490845e9.2.1750545133311;
        Sat, 21 Jun 2025 15:32:13 -0700 (PDT)
Received: from Honeytree.fritz.box (p200300ff2f00f50106daab39821fba35.dip0.t-ipconnect.de. [2003:ff:2f00:f501:6da:ab39:821f:ba35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1189977sm5541206f8f.82.2025.06.21.15.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 15:32:12 -0700 (PDT)
From: Oliver Schramm <oliver.schramm97@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Oliver Schramm <oliver.schramm97@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for Lenovo IdeaPad Slim 5 15
Date: Sun, 22 Jun 2025 00:30:01 +0200
Message-ID: <20250621223000.11817-2-oliver.schramm97@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's smaller brother has already received the patch to enable the microphone,
now add it too to the DMI quirk table.

Cc: stable@vger.kernel.org
Signed-off-by: Oliver Schramm <oliver.schramm97@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 98022e5fd428..c9e1b777b70e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -360,6 +360,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83J2"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83J3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.49.0


