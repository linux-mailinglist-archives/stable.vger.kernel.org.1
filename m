Return-Path: <stable+bounces-93634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792049CFE59
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 11:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1AAB27FAF
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15019750B;
	Sat, 16 Nov 2024 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYB7etzL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9519343E;
	Sat, 16 Nov 2024 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731754665; cv=none; b=kiCTURDsu6mteFP5l+foUo8/NYaiVQj2GvbEUKqKaM1RQK1C2ikc3u9LODbyaFj+W8r1PPoxs5VmDyGoPPPwEzA9ug7CEqU6tWwq8tUrTFlP+e16EtQg7qYAgfFlQ3Foik+jneZHFiQOknA/g4YwkxjQl3Y6Q1jNDuxVTqLF6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731754665; c=relaxed/simple;
	bh=eQb9wF7oznZn0WEVMLZdiD0aGrnPGx+MTcEP57njRgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPeXtAurHiftEM2Sdqq5MAi52LGc3HF5Wz5qnswkTQOO4VXz/HFK6UJPn/517ZfpD89opfMLJX46CQ9J8N6QUoa9JucTOwLJH9edQ8NG6gLra+QCUFFA6gHpicx8ate17WJy5vPXvQX6m0maP+tTdzI8RpDFxam/fIVYpiukF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYB7etzL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so21764245e9.3;
        Sat, 16 Nov 2024 02:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731754662; x=1732359462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=goImJceAXEwHpBa6B6ghd+sdLyfuey1E4bvkcllMT6A=;
        b=eYB7etzLzLLa/jENfc8yI5/jtyvEIwjjVdhAaD2C6o4YaJLyVGEO/LcYTX9bTIb+Di
         eyJ+csD/Dssk/q6pYo17rrjKO4SpoLIvAQqbfNmOeYHW1jrYHqcachuFtgLvjRyaPHdu
         nCHrdphG35nTV4lzzIHOVsfCnxGrgimQVtm2wq9OaGE0kRWyOc/67tHG2YPIlQrfw6Dx
         QjqHJJY42sD4OrO2N4H7sr0tqfw44R9/LXQOVqxv+6WnMtgSnXxzsVH4DeM2X8iHM5o2
         Jv5sP4wUPxJpbCjNm/h8UEVj/OskEzeAb/f3/mSBCyv0VrGKBSqjBJCjPfi3jvBtLekT
         aI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731754662; x=1732359462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goImJceAXEwHpBa6B6ghd+sdLyfuey1E4bvkcllMT6A=;
        b=hbn13q3YcBxgdNlMwc1B220KfU7bpH8HTnJKVSAUNy4shLewgmGIk7Cw/AhJU1KaEC
         pDAEREdCDOz78xT1wFnjKey3ouPMZ9+yLwznLf5vfBDCgCIEVPK9rqbrMFupOEBzJyK9
         qyAZL872tsS9X8N6FBxHDavAz0uDY7TZrGOBfE8FyE6cPJn5NQ/KKO9zmmj9Gz7AV1x0
         sMwkrWJk1Y3+u1abG1LqI+bI5spzpg87OjuDZog7E4/MyffgYm7RIe0qxtvYt0k5PswE
         YM5ctWZYxj5ejhNqN0I7SVQIpYtfVddehmXXuOQO8hf6B+sMDM7DJ47+oFir8JwJ7gHT
         NqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYlv72LyprBxxC9dZ38rEIz+cNI0PaAq4g0rGvyCt/WJihj7U7zPNaYW4XAgpUnPH1aZkY/vw6bkc=@vger.kernel.org, AJvYcCXMDaVNq/ywL3QZyOh9HSyg3eftZ61FHZnft1aGJ+JLtwgHoBoZTXdlUfcZegBSk9NdFxKuX6yw5NFORj+U@vger.kernel.org, AJvYcCXUEmIMTe7ylknwHYsMd3NNq90agC/Rw8rE9toy8uZdjpCFaKOH6dHShW+ZYFKIKrQcwlZWCtUe@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0YEu1JSlUsut2Nu373eTaysz+MN11bvc0w5xfRp8Rd1H257u
	UnBkF75HbScixiAUDooYXl6ZqO4OPMSBRm7MH1fT3VhPwmQiTlINa80EZQ==
X-Google-Smtp-Source: AGHT+IEId6zSIFqCE8N53mVdYJ0fjpuVXnudlSr0iOmtwTmdqhLz3XGrAeBVhVV8RSj1oCQVzHEe2A==
X-Received: by 2002:a05:6000:18ab:b0:37c:cc4b:d1ea with SMTP id ffacd0b85a97d-38225aa6573mr4908953f8f.53.1731754661934;
        Sat, 16 Nov 2024 02:57:41 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-382377822ffsm1302814f8f.82.2024.11.16.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 02:57:41 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] clk: en7523: Fix wrong BUS clock for EN7581
Date: Sat, 16 Nov 2024 11:56:53 +0100
Message-ID: <20241116105710.19748-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Documentation for EN7581 had a typo and still referenced the EN7523
BUS base source frequency. This was in conflict with a different page in
the Documentration that state that the BUS runs at 300MHz (600MHz source
with divisor set to 2) and the actual watchdog that tick at half the BUS
clock (150MHz). This was verified with the watchdog by timing the
seconds that the system takes to reboot (due too watchdog) and by
operating on different values of the BUS divisor.

The correct values for source of BUS clock are 600MHz and 540MHz.

This was also confirmed by Airoha.

Cc: stable@vger.kernel.org
Fixes: 66bc47326ce2 ("clk: en7523: Add EN7581 support")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index e52c5460e927..239cb04d9ae3 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -87,6 +87,7 @@ static const u32 slic_base[] = { 100000000, 3125000 };
 static const u32 npu_base[] = { 333000000, 400000000, 500000000 };
 /* EN7581 */
 static const u32 emi7581_base[] = { 540000000, 480000000, 400000000, 300000000 };
+static const u32 bus7581_base[] = { 600000000, 540000000 };
 static const u32 npu7581_base[] = { 800000000, 750000000, 720000000, 600000000 };
 static const u32 crypto_base[] = { 540000000, 480000000 };
 
@@ -222,8 +223,8 @@ static const struct en_clk_desc en7581_base_clks[] = {
 		.base_reg = REG_BUS_CLK_DIV_SEL,
 		.base_bits = 1,
 		.base_shift = 8,
-		.base_values = bus_base,
-		.n_base_values = ARRAY_SIZE(bus_base),
+		.base_values = bus7581_base,
+		.n_base_values = ARRAY_SIZE(bus7581_base),
 
 		.div_bits = 3,
 		.div_shift = 0,
-- 
2.45.2


