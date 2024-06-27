Return-Path: <stable+bounces-55997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8FA91B0FF
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 22:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BB81C24DA3
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 20:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8450019E81D;
	Thu, 27 Jun 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2t1HGT0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094914D6EB;
	Thu, 27 Jun 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521594; cv=none; b=ufDhPVwTZUqZjOPzL9u/Gb82i9q4VfOSrVLKV5DiFMWvZjtU9vIvPvciQL0vDm4IWlONyD0FFNXJBI4SQGQueSpD2BHUP4AkjegND0Y4N4v8AbIeeufXEU+s2JDrLqT0GaI2Vd4wj4+ZO7kDxZd5Goa+kboW68qeAYfWs3PD574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521594; c=relaxed/simple;
	bh=lj3alnjoF6IS2vUlkaWQ49CLsjb6nBsT1IQIE4C6OPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSQy7OXycJyYjQ/j/ap4Kk2AwQgnw1L/l/rQw4cvEqSgpfgkpGVlwHEOxcoRR9Bl50rJ2lZva7nI7Ng1Kg64ZDV4FQt2CvgrXQDKU0ZnUEFQXbwojesu7aQnu7P4my+G+6ibvgSbpznnITG/S44rPwZWrRVUWwvEdvzB5cDcmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2t1HGT0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4256aee6e4dso2308515e9.1;
        Thu, 27 Jun 2024 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719521591; x=1720126391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xfb8qh56GtYXoD9jZvOPRH85DxPa0JeSyiOdHUBDC38=;
        b=C2t1HGT0FC+UYk6ybqxS57C69ZQEtiu9N30pgaen/OmI6lBs1k65py7qZerrbz4H44
         HQJAxQT8p7A6yu9BKG+zxudWCPS3/LcxSlmLgkmNfABZUlVRvJdLub5FF/qWIJQ21ILl
         IBilisaTL4fphFILi9RjzdcwbzPEBbaGafYFgx8CYZOs3FAshKBrQPWTco6xVRl75vA/
         TbJkfCT3kbco7fTuZ9LWGmY5eaoXNJSIzR7WEab8Dvd3CLU9WAcJ7vd+/TkTrC7FDWop
         6s8wiK9VJrqkFEKaCnlcTytDQxXFtR31YRzJATHxo2ejgTUQHD3JrfPsShQ2RHBzUlcf
         LOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719521591; x=1720126391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xfb8qh56GtYXoD9jZvOPRH85DxPa0JeSyiOdHUBDC38=;
        b=g3hMMxX5BFl/pFpmYuw/lzG6/DB2quBKqrzHEhLYVXp3oCOd7O4bfrIzeib+88VaQ7
         HqCDBjcJkx+EhOl2aHWt+NNCLw4E3Dl6tlXQM8oBRRLIwL6PbJApDaCrVJPhHNulOCb8
         9k7/7cTsljfxdzk2LD5uCv5tkua85geQXLFUWdnLLV7acn+eNHoPUZYBlMh3+XQngRFF
         Kn96HO7vVEag6xb3d3zMCMsYNnQg9OuwvPAWrg9YP9WOBjBQIvarGs9XgXbnarnvtUkm
         wDo/L373FCfq4KqZPMQqJjSb844lbt5U3h3FOB18PaNFVDrtVPo3LkfsvytugnK3s+V0
         8iyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV2prVxwNXlllOAWLBf9j8wmADbCE+2XfaaRqP5u/aJgtZ9hO74Rcwn+bgM/gGyoGTiHkpiL8PpM9UIVy4iaInxKPPEhwO1hbkt0OmQ613vszrCwMYfWOwH159F3baHygppwvc7ioBWcqZyKtbix/phogzpBQE8bcCboOAyYCQQAuVonw0ft7io4UYMqbkRDFxge3MGsVpWW6uDg==
X-Gm-Message-State: AOJu0YxezMSvLxa7cXsHYOJsB1/5CWtoAZs+P8tJbISgCRI+ogZBZ5C5
	Elokf4i0AqMCADNUI7/HnKo2ulMMoqECE5x+UfjYHAxlwRAnkdrM
X-Google-Smtp-Source: AGHT+IEyFGnUG+ZaEsbZSSMkgKHiw+IpNLv9h1YAzb4VBZz9c2j4FW3QknMf/JcEiIHOYQfbwlYHow==
X-Received: by 2002:a05:600c:6a98:b0:425:5f86:41bf with SMTP id 5b1f17b1804b1-42564571f40mr24797395e9.30.1719521590820;
        Thu, 27 Jun 2024 13:53:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b068e93sm7216935e9.24.2024.06.27.13.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:53:10 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: mediatek: mt7622: readd syscon to pciesys node
Date: Thu, 27 Jun 2024 22:52:56 +0200
Message-ID: <20240627205309.28742-1-ansuelsmth@gmail.com>
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


