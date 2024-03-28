Return-Path: <stable+bounces-33091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4F8902DE
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753FB1C2AAA2
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01AF80630;
	Thu, 28 Mar 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1qYUUmi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0E7E583;
	Thu, 28 Mar 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639220; cv=none; b=mvyh0b/tcbOuKtIXGB5opTyV/P8V0ZrPY53Jn2PFhrIJej1Dnmrkm9+1zlcdtgdsiJcju96hE7sWxd2ZqGxB2vgg3thMJUISi+v/RP/grRSiOYQS4E/HMsf9ourT9bhYQ34B1rDr7x+MjMEae/OtCmPo2kz0M81WU2m0s6YuO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639220; c=relaxed/simple;
	bh=lx78ueMU3ybsRd2ie/yVOFVz5hFq0sjCDHSdZ+fmqk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RGC6ptjJ9jExbAz1UxcbBb9YcHATWvtdrzqTE9NF3uymSF9b2tsHexqyRGFeWtOZCQJ+jtAKa59f0WON7j3P4mlsgdDRAv128Ikn0NHH1XDoThSsR7E8bQUHTjslvett1MbpqGzQ4xr6O1GIrxrmxgEHZtqeBHWKNVob2GAmy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1qYUUmi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ea7b38f773so235725b3a.0;
        Thu, 28 Mar 2024 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639218; x=1712244018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VDlh8QZOxfzH7OHKeOlQuBivsfBTWU+c4hMjaVYdeSo=;
        b=i1qYUUmiZXvFhUsOLCUuLCJpNIQViUP2D8pitBv3Wamj40fgFiTUwOXvmeWcQTKVj8
         5vKiUiWqDqgp5kPcBCUANTKpZaYffRzzo9pNxc9TNSZ6Y88QwgBXlNoQc+AezgYx7dkd
         28Y9xL17gOMswi6wwnhAJo9k5MSSGxkJ39E/uurAy5BdEyPujXS2gH5W3Bpw0GisqI3x
         iJW+J89/MWSnyiPa4GAvyWVtLhonXDS46qbuXhoiepw4i04bsc7SpONPEQooclh5ojin
         WywLopGRb+Okoy6XofyNqhB1A1tU677fNlDqu79RiehPGD7cHFA1CE9XAFSCI9AfYa2A
         q5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639218; x=1712244018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDlh8QZOxfzH7OHKeOlQuBivsfBTWU+c4hMjaVYdeSo=;
        b=HDSm1RZwSxxojWjuDrosUdfx9qYhCOtS/4QVISIAoo8K5Gd1D7NCyP0hbaTPnEk/Bc
         2hgqpo39QqLzChnRoiI9Gm2kIqZbFDMqOuoVod+S8IYIB+bj98k5hpXzfOmPCW9DtNLX
         xYb64naFZwEbwVLr6RHJWfAIb6kcp4iuY9MgGZc97IA2w/PcmahPpW5vnBqDcCJlCcS9
         PUTk6rBkj2VW0/5oGr2/rNKKTkZkB7tb/mVnigexqV6fSvnxP+YB5cWnvCca0tf6AHbc
         C2o1n1dZTGvVM1q2LE/kNzvoKNBcRHuImeMv6p9BCu0Tl5ODwRCrEpNxzSr1QAEbPFte
         6Qhg==
X-Forwarded-Encrypted: i=1; AJvYcCU0oGPp7/FitGayxDNnFOeWhOr2Ei9huyv/YLnt+XcFbzlUb0ZHl4oMsTLIIE1xqHBSkS0wqck1/n8Z2z0IpPi+1xG7jTwth4jKr9W/uamJdbcHnqTEPnXQAlLM9uKlxnGc6w==
X-Gm-Message-State: AOJu0YxTkaYY6eNoIv8iAqqNbJi//uOHPnv96fzN/5fjArSs587KNv2Y
	2/XYaTxBNPYamGKB8cAiUS/oBzPr1kfqN+Pdef1X39WbYJcwGFoL
X-Google-Smtp-Source: AGHT+IHX3RYb+V0FstTFGsMqchayvFhdq4FA1/ADFGTZbNSW5ZMHVQdXk5BUBR3XJRufLE9pJf5xTQ==
X-Received: by 2002:a05:6a00:4f96:b0:6e7:7bd3:f69a with SMTP id ld22-20020a056a004f9600b006e77bd3f69amr3539359pfb.2.1711639218405;
        Thu, 28 Mar 2024 08:20:18 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:918f:1fce:e47c:7f91])
        by smtp.gmail.com with ESMTPSA id w8-20020a056a0014c800b006eac4b45a88sm1529251pfu.90.2024.03.28.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:20:17 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: shawnguo@kernel.org
Cc: sakari.ailus@linux.intel.com,
	hdegoede@redhat.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7s-warp: Pass OV2680 link-frequencies
Date: Thu, 28 Mar 2024 12:19:54 -0300
Message-Id: <20240328151954.2517368-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

Since commit 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint
property verification") the ov2680 no longer probes on a imx7s-warp7:

ov2680 1-0036: error -EINVAL: supported link freq 330000000 not found
ov2680 1-0036: probe with driver ov2680 failed with error -22

Fix it by passing the required 'link-frequencies' property as
recommended by:

https://www.kernel.org/doc/html/v6.9-rc1/driver-api/media/camera-sensor.html#handling-clocks

Cc: stable@vger.kernel.org
Fixes: 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint property verification") 
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
index ba7231b364bb..7bab113ca6da 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7s-warp.dts
@@ -210,6 +210,7 @@ ov2680_to_mipi: endpoint {
 				remote-endpoint = <&mipi_from_sensor>;
 				clock-lanes = <0>;
 				data-lanes = <1>;
+				link-frequencies = /bits/ 64 <330000000>;
 			};
 		};
 	};
-- 
2.34.1


