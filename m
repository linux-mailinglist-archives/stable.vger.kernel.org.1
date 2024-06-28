Return-Path: <stable+bounces-56062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1F891BD3C
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E711C21608
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA21155A56;
	Fri, 28 Jun 2024 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdPk/6ij"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD51865A;
	Fri, 28 Jun 2024 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719573496; cv=none; b=oAOeFWs2t6DsSKL+K9q9qvVa6CthPJPhZ1oh30EROgHG1h1SMxaRHx/hXTPrWTqu6Udvn3ZTCj5cn9JLOJ9nXlakwxcohR3gjvxNgR61G2qxA4K2onO5YCjsRrQqjTJuqACfEbCaz1RP6/hFJspleCEHzc7Q+aJiVqtH2gHXmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719573496; c=relaxed/simple;
	bh=lj3alnjoF6IS2vUlkaWQ49CLsjb6nBsT1IQIE4C6OPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/GkTXUGDRu35rsBpRPCeRcivN4HvLa8sjmh+7sEi2x+icvS2yVBcUtA1+5FbyafkkYQLl/62cayvKKWiCG2YIlLVUqegaRJ3qcYaxrwx67bZWgvBDBY+5Yc+UY5t/OZkWbMkh+N7AGGg/XZWBbYecb9zzqK8MtW9COYiepQBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdPk/6ij; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42138eadf64so4327465e9.3;
        Fri, 28 Jun 2024 04:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719573493; x=1720178293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfb8qh56GtYXoD9jZvOPRH85DxPa0JeSyiOdHUBDC38=;
        b=IdPk/6ij5a9AcZuZJvAhoetFu2wX0EWUdvTOO8jGsQYfD+p+MyOu/9LPf5uGWZM1d0
         uh8rUymlALqy05rVx6usyWfOYlB6LGi8x8hcg2OC70EvD2UlVUEwRM0imAcqotMs9Xi5
         BGcUmCW17TSnryZVu0s3vOJSbQOOa3iSseHhQNPwFUkCLhNS+f/TZXBez0TtrsFyMaGv
         BmCktTgyjXSxCdFDdvqwM4dGFTzJ1jdfmTEqizs8qbyM+0+WTnvZtDdkwvNDsXfkiZCo
         HIjsG68IMTT8vHYYDvu76nj/D4qocJcu3BJtDJ9iIr9vd6EyUSaB9LIEhEOJXiDcErJZ
         0SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719573493; x=1720178293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xfb8qh56GtYXoD9jZvOPRH85DxPa0JeSyiOdHUBDC38=;
        b=JoCpPTo4eEnQpavJP7x2GsRCxAgoDIc4kvHF7m04Yn48/pWV8qIGp06kTbfuOKXuEx
         1Evb4VTpXGVnrceJU9l+EAuLqFL4H+1X6snfWCV3RmNLcUgOspxub7wutDaIozT2W0md
         cOdMAfwAY8Q3oaLZtgFhJVuuCUm7D6Lw29EFyW9iReWZSpWLL087WPLYSVms4q7q07Bp
         HqqDq9WQimsRok39wAO6CZeyuAhHmaaDZUtN+Ftc5IW5oYJy+BlaoI8PQAmjwD0U64Rn
         DzBtPFfM3aisSSbUP525vIl3TvWAKZ++fdyYRWRK22VS5AM/Htn7Zu4g5MKOhRNAzc2y
         1HTg==
X-Forwarded-Encrypted: i=1; AJvYcCWuAdQbyOeNzcyyPgKZc1Daj62+fo4cgTf5qh7jzywW04RWDrHOvzNKoAbI6fgFbYWnJz9w+Zjn5E1swCWzqtIc8+Y00gPNCm285gwNl93J8PdqLbDIizK1xq3wwr1hlZZQMzYYF6FLLvu/jLe+4dUsBY0gD1bCCTTNf8R7Yg3moXxAJw1yRIZMp6oaeTF9x9xVoQpTHCapQk6PaQ==
X-Gm-Message-State: AOJu0YyQUjJN2k27HVbj1werxpo3g09KiZNLNAxmoppAfGou6Br1RQ9N
	k61GPJLT8tpNjx3SU0wCFsmh/KlJr3wbdmNjILIFWdBm+1WqwETu
X-Google-Smtp-Source: AGHT+IEgaXUd+94Izm1S8dyRGK9F05m7nglJMAYA5JVpVKSGCoyzmAAlgx33pqSiP1IHukiCb84uNQ==
X-Received: by 2002:a05:600c:2d84:b0:425:622e:32f4 with SMTP id 5b1f17b1804b1-425622e3408mr45368885e9.26.1719573492849;
        Fri, 28 Jun 2024 04:18:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a1055b9sm1979495f8f.95.2024.06.28.04.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:18:12 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: mediatek: mt7622: readd syscon to pciesys node
Date: Fri, 28 Jun 2024 12:55:40 +0200
Message-ID: <20240628105542.5456-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sata node reference the pciesys with the property mediatek,phy-node
and that is used as a syscon to access the pciesys regs.

Readd the syscon compatible to pciesys node to restore correct
functionality of the SATA interface.

Fixes: 3ba5a6159434 ("arm64: dts: mediatek: mt7622: fix clock controllers")
Reported-by: Frank Wunderlich <frank-w@public-files.de>
Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 917fa39a74f8..bb0ec1edbe5b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -790,7 +790,7 @@ u2port1: usb-phy@1a0c5000 {
 	};
 
 	pciesys: clock-controller@1a100800 {
-		compatible = "mediatek,mt7622-pciesys";
+		compatible = "mediatek,mt7622-pciesys", "syscon";
 		reg = <0 0x1a100800 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.45.1


