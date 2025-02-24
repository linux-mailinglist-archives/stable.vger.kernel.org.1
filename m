Return-Path: <stable+bounces-118783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E67A41BB4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDD9172121
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189C24BBFE;
	Mon, 24 Feb 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzIfCvLU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFB24502C
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394472; cv=none; b=TkLtHJft1xuA18gWjYY2bEdLPxDRSE7bUwtyWvXvpdTNspJMeVL3NmQGPqSn9U/cfUH54NnBKH1369Fxue9S5KxyUrUhxGYHIqENCJRySncQDV58Z6+B9afN1iEmZeNUiw599wsEvilu4evwCiAWT1PjTluFHUIBrVNhNambKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394472; c=relaxed/simple;
	bh=mWPuIEmxzffwImrnUPFeCYarmrlFWpGcHY9nECaPOKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F23pNxnSlF4AJsCYd5FJ33swT9fMyj/vMgp6cK10Ee0JVj8Ni5H+gb7tO5KKkiz59RvWkoPVU7eCjOAGRBfMtJoOrjKhCqjYafYw5tSZqlvVa2XiTiatSF9CEzcI70Fc/AYE1/mp0scI4Nl/yEJSnQYc3HNlWzUerfcn0bULApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OzIfCvLU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22185cddbffso84762045ad.1
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 02:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740394469; x=1740999269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qHwrz4K9MCVNdQFc/BfOO79uUOXHPSMf/MZekqYlX8=;
        b=OzIfCvLUwNktec3/Y36kaCefmlmYzKmoqN3oflpXzrT4EiV4eE4nQx4DI6EhUFoLgt
         LXRSkMyq5nGShjAna8/qCZa6mSbRPdECI/fYF2sIuDRnqbPH0eYseydfBqvI+8rM0AT+
         oPLkhE1LTxpht2wAj9Bctp2+L19OdfsTcZDAIcatwWjHCD641r5eedsLRC8gzu8Kjx7K
         ZZr8lW61PAEaHLVVdvoso9oBQnUgPy4M38Q3WnxbyBAt85qrVbn98TkcCov0xAu4ra2R
         8YIobb1a2c97Hwf8xs5dfdwrYNJbVn+dWhj7MSD+H+4S+Qhg0DeYm3aj5Z035kCEWtSP
         0+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740394469; x=1740999269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qHwrz4K9MCVNdQFc/BfOO79uUOXHPSMf/MZekqYlX8=;
        b=oB3d2JA9gayLMJYl3RRNWbiHYXkzHI7qCaiKUSpZZ+Zv8iSL3Bp7zE4EV+q4epm9uq
         63JPrw8HMfgjObXgIa51fNr9hG5S2lEiR6CaoGVK2aR/GMVqNC70mVVZzn5hUVSXz28f
         fpgG+dgRDg1rz714xV0sYHN0WlBw6rHE5k7ReWyq6s6zmiP14C3vFzW7jUfes/3l1RBn
         +et/jdb/Aqp3PSD0lYZYDmCSGuTGnN2gFAubLctTMm+LX/QNXeM5kiVqs2boXyXq9F6Y
         iSQnLoGcguPUr3HlmkSFQXXL6DeriitbIcW1pGTPUI8HUqZjpQ/COmeXTp8Ntxu/Lgf1
         +HLg==
X-Gm-Message-State: AOJu0YwBvhSPCPWqkK06S7feex6u5+E8CsK/z67tIZunayqXV9ROAEUA
	OS5Y17vn2QZCgScefuf8xBuKjnlgolIC49C/9WaBXebPNN+7rbIzKXWUd50fwM8=
X-Gm-Gg: ASbGncuM1klqQYQyWCh3RKnmH6pWopQrUHl4jmrI9QMuxDpQCMtHp7X8aCPODI+jxz/
	/K4Tl5H6wftR6JMC45OekwRC3FnPgj3TVb1wmjNOxgeL14jUooDBxT41ZFrnUKnudy2CeVA3Dsm
	w5OJhwSXbpUF1WEZBE+0k2TqCjcFeDFV+bYABK2cMrOFN/aLqa7l3llOBa9GzB76oY5cJOH06E7
	41vMO4jy4Blb3XlQqHx6hB27CQ/OVMmD2370YnbKGsYA8fmIulNwWdrtAHWoaO/W9pYMezXrJIB
	kgB2fXykrR4cUHtlNUNlAPLID1uu
X-Google-Smtp-Source: AGHT+IE+H266UR1qNveZMOCRth3ANEC95XAr6ayLwugwDgOCVRvuH3jxxESJImTpduEntuGnXsj2AQ==
X-Received: by 2002:a05:6a00:4f85:b0:725:4915:c0f with SMTP id d2e1a72fcca58-73425cde0bbmr21166013b3a.11.1740394468655;
        Mon, 24 Feb 2025 02:54:28 -0800 (PST)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:5146:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546301sm20535611b3a.33.2025.02.24.02.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:54:28 -0800 (PST)
From: Tianling Shen <cnsztl@gmail.com>
To: stable@vger.kernel.org
Cc: Tianling Shen <cnsztl@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.12.y] arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
Date: Mon, 24 Feb 2025 18:54:22 +0800
Message-ID: <20250224105422.840097-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025022431-print-cure-5210@gregkh>
References: <2025022431-print-cure-5210@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general the delay should be added by the PHY instead of the MAC,
and this improves network stability on some boards which seem to
need different delay.

Fixes: 387b3bbac5ea ("arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Link: https://lore.kernel.org/r/20250119091154.1110762-1-cnsztl@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
(cherry picked from commit a6a7cba17c544fb95d5a29ab9d9ed4503029cb29)
[Fix conflicts due to missing dtsi conversion]
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
index 4237f2ee8fee..f57d4acd9807 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts
@@ -15,9 +15,11 @@ / {
 };
 
 &gmac2io {
+	/delete-property/ tx_delay;
+	/delete-property/ rx_delay;
+
 	phy-handle = <&yt8531c>;
-	tx_delay = <0x19>;
-	rx_delay = <0x05>;
+	phy-mode = "rgmii-id";
 
 	mdio {
 		/delete-node/ ethernet-phy@1;
-- 
2.48.1


