Return-Path: <stable+bounces-159120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C347AEEEE2
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 08:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449277A477A
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6825B1F4;
	Tue,  1 Jul 2025 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gguqPsN7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B22248F42
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751351793; cv=none; b=q+8bgh6qP2Y1akbLcoLzZsjLgD4yQHc0C4GSP8yZt2DMYeZ3ZOowKOwgl4NUZaEQH3wz8QCxc7TCr+n1LW4071aZYSdllCzGB9Tl1/S3/s/EdL9gVhmO01jkm0Alks46GrBx7LmGhxP7dUeL/F4bofho9q39UvZTObPDFf4ZfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751351793; c=relaxed/simple;
	bh=S6cjipfxAita73V6JkLosCs6f9j35AYf4JtRigU5I9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWy6Wr5ZUr1UrDlfd8lG59yT8HwcOiwI36zL7pAsVQpEhn8psXJ1lPdowbebyNHJGcBWUIrYYXo1qH4MYnmKXGIzyNIkFr+8QDuIGupg0v/3xB5bEgRvb622E0Uml8NpqXDELtiGR3RNuJ8AinDxrNC1QMwEQmVUP6+f9OaSIjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gguqPsN7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so894017f8f.0
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751351790; x=1751956590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EZS2dGfFhz4DV5h9FGWwFN5DAtPdX96LRkBj81DNpcM=;
        b=gguqPsN7Tsz336dNL6RoQmqQZiom3ibRshTpot3aaoFy6CUsqqJ+8gg0psuvuLvPVs
         ILT+QiA04ertZ2Jmo3uwHnoLt5jO7x2Sry9igp/kT/hOIR5qzq2VmG73TYl/d6Y/WCM2
         X7rzBxbCkGjvlNvKK6yZPwAlIbud4PwxBgj9fH6bssN32tL/5IwaTZVUPlXJQkNZUrs7
         DAvRFu7omm6pywA1ZjS9mTH8Jgles4cXVeWoiEYPjLVUW2/hWMtAW4GLZQlXcqGz0yAr
         F6vZEFoq6qN85HJfXCF7tRc4hWkf+sRgM23hkKOwS1aL7RWjIUWIoFVR6xILUbj/AEyE
         FiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751351790; x=1751956590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZS2dGfFhz4DV5h9FGWwFN5DAtPdX96LRkBj81DNpcM=;
        b=iXZ8D1wHkUgbG+OE//oJSO+NbBYRYmySN59L28DkM+9vEI5U0QjLeqeura1OFPItyw
         uhWV8EG39sx78C6ayPJ6xChX1GOKuaMb3gpen+Igqn4xafWpra1ziImS/j4ud6xa12RE
         i1Y78I6GCB/hpBrTlB+NUihpA5eOJ2xsWPsp5zRaZjfztgnyBElLe+hX3QYHzv4QqrQ/
         fwZvaxUiuUT/1A+WIhakepEPKYfgqPK/RGBE9t8RlwVgL0xwgV0RdRq6vK/gVUltqP9g
         yGKHUTe7mGa1HKFpfg4j3XkNRmkMFuwck+CyIx5dAMDZc4Z4veOJACcNPAZaN4GuhU6l
         BhaA==
X-Forwarded-Encrypted: i=1; AJvYcCX8g2GRkm3ITEglYfF8o4POd/Vy+5Lo5b8yPEnpmj/EI/Krz4i6gKjQWGnsLFo9V4LNksWt7wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIj8geICsouShoEG+tsS66fVqRHPbqRKP7moAjHJD/6jaMkSUc
	wzcW3PSqu1w3eM93eTdcfJg4GQ7APQtsK1IBXuH+LLZKYAw7f9OzA1SZrqeAsRg2SIk=
X-Gm-Gg: ASbGncujFVRsjptLV5KDR9jGHaNWX7WsZY8+OrDQffxtBzEBNzPkUFif9Lr2Lf3OUtW
	vJcdy4awygVp0hN3wlyXSgTL7WgPI9Bd2Tl56ZRsJWLEIsdDMhBFBFG6IjwJmsGqH3ZlfopXteJ
	6yP9uI5Wonfowp+lHtbYGCk/UJWEGvn6zFK1XmYpeHrmTsJVdgGda9b1zVwrqs05mLjsFnlm6HQ
	3NvQmFXNyLbS0Oxkjg+zSoJp/KWxzi1j/j2LjkAVfNa5X7RUPT5CHeESzcDFyANJPxfBCLxLcmO
	W0wje0yc3L2SnW1hYILrhRsQUBPtY2elehpFhVx7wf+T2WNe63eqEqqUQaBEW0Yr5os8Fk2X9Hk
	=
X-Google-Smtp-Source: AGHT+IFtrU4YoQ/j7QsTLU6w1l0Gl0/puRBtn5UoLC4Rc4bLHeuG9LgcLkzyP525KKRGuBzuEKPP5w==
X-Received: by 2002:a05:6000:178e:b0:3a5:8b43:2c19 with SMTP id ffacd0b85a97d-3af48a83a9dmr416781f8f.4.1751351790022;
        Mon, 30 Jun 2025 23:36:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5963csm12294776f8f.79.2025.06.30.23.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 23:36:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH net] dt-bindings: net: sophgo,sg2044-dwmac: Drop status from the example
Date: Tue,  1 Jul 2025 08:36:22 +0200
Message-ID: <20250701063621.23808-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=S6cjipfxAita73V6JkLosCs6f9j35AYf4JtRigU5I9E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoY4Hl6oFY6MC1mYY3tYMqGk+Xq4qtbynXG0VKf
 o4z8NuGJQ6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaGOB5QAKCRDBN2bmhouD
 17vkD/4lwb76qcvbDpG1bX92LByyYKigIiXJxiNcw7iJhyOz/uTjY3I9NhZuyiOIqxv40YBYzuJ
 ZvAx5nw8qpRLROL2Lhc+UAZSKriUlMxsZMRuIxDSAG0nUrspxP4Apb2LCGFCDuymBn9X1M6NNx5
 UR3Q7hIMidIXmsBG0EOH28pOoW43+XPX5dEcPYkyYCG0hi5QWCdY+fWzzf9pbbFWBffc6sm/gMG
 6gHkizBuTkNgvf9OQ+6ESUAglErh4kwOyIhcujG18uNr72N1nBHBz74USDZKbEPKznsXaQDbuij
 K0g+2gF503iGxuI8vtSaiA6tpUshj9B8WBDxrUngLZROQs8aJLfrfAUx01OmVzsmGZRIIg57N+g
 Fx+08WIJnvdLlB2Uvv8eoO028JJxeDMsQq/LLs8S1AACMdjEcx5H4mZT+Wplh0QGURXG1t6XFv0
 +w3T6moXyOLD/t3SgDHBwr7lWEnjO5QpbNh0zC+i7WVAxJHc42cbj2q+Lwh6yRKLSKmBcih/yHW
 /TmuvZeauEYDJ35dM5omlLWntZKOpjEt5VDIQkCqrmzb6g5UcWCNBJycKM4ifQxhFLko+XjdaqT
 lXew70S8oxXEXXJm3f/QHfk3pnRDaKIjwDUU030X+Z8KTFueHnKOSEmkf3oAw2Pp6PsRjOTYlhu NSGDdhRSScXbykw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Examples should be complete and should not have a 'status' property,
especially a disabled one because this disables the dt_binding_check of
the example against the schema.  Dropping 'status' property shows
missing other properties - phy-mode and phy-handle.

Fixes: 114508a89ddc ("dt-bindings: net: Add support for Sophgo SG2044 dwmac")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index 4dd2dc9c678b..8afbd9ebd73f 100644
--- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -80,6 +80,8 @@ examples:
       interrupt-parent = <&intc>;
       interrupts = <296 IRQ_TYPE_LEVEL_HIGH>;
       interrupt-names = "macirq";
+      phy-handle = <&phy0>;
+      phy-mode = "rgmii-id";
       resets = <&rst 30>;
       reset-names = "stmmaceth";
       snps,multicast-filter-bins = <0>;
@@ -91,7 +93,6 @@ examples:
       snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
       snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
       snps,axi-config = <&gmac0_stmmac_axi_setup>;
-      status = "disabled";
 
       gmac0_mtl_rx_setup: rx-queues-config {
         snps,rx-queues-to-use = <8>;
-- 
2.43.0


