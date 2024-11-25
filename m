Return-Path: <stable+bounces-95360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65F9D820F
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 10:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E00281D0D
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84362190462;
	Mon, 25 Nov 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="pHQtCrjx"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078A18B476;
	Mon, 25 Nov 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526217; cv=none; b=jtAr6jvZ0P0Cb5XHYWgnTfTQMQB3BoWAy05q73rifuAVAYiPIGf6T5RNHQ0089oc3Y5dfdoBJGcFnvu5uzwIfUOihQG96YbKYD+UPh176WpipvQfIhCzu0MhjJvOKKrju5WZKlMSyNQZIu5dCR96HXwxCtKCKgrYjbxs4aYJCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526217; c=relaxed/simple;
	bh=iDJtZwn4B5g2vaImap3rOYI3eZ2Sb1T1E+6N7dCpfIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZvlY6ebNiSbgodPpjBVxZGn+3k7WpN+hCRI+wWf6TlgQ3likJg80cJHaKAAvPHnRxHlXb9L6WpIbAEiQsnL09LNA7gY+2dv/uj0Uca5GyWFYTA5/CbnjAqeWNQXJHbd7pfU8+zruOB3HCfIAVtUNKWza9fSnYfGH/thTCmWNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=pHQtCrjx; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BB29EA0827;
	Mon, 25 Nov 2024 10:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=zd8wKecSdXBVrXpZnl+5
	FGQh/68mIATekqahVWyBWDg=; b=pHQtCrjxWbBB965rNEgZROH5rDmlmlMnNItJ
	0W61Xo3aGN6zTOwc4q32QEGjc+jXCAe3T1RSQzT/DtQjxjp8IHWgYcJMRqQEw8wo
	WizduR8Tq7Uc+H0tMD0uCrUYbLLuX2+X1TR2FvXCNa7AGtOQ2jG8wW7vlz+KhgHy
	n+kNfYwtShrhUW1eCtAox/Uu6YO/DJVJwA4RzVoZo/OYmqntnklRWZcBKkiK3a4Q
	l71Ecsh0RDnGVJVcEmj1qfkAFEymxksUlkp69IjLXzv0xQrErKYuM8BbH+b4ZORf
	cCt51Q6KQNyqmqiqmqoskZy2lpPIRY5daFJAQtAxfUpxeDM2pIp3QSGWf0Gbzm4N
	oSiSXOu+CtEIBOCsrNx1ADa4VYH8SydrnVZE4zdpJkMpdIgphIccwZAHCeyy/EUl
	brBfdm730rbvAP/X2VBasAZhnqW+sAuGHzOxUvi2x165X7Md3VL4Ep8PZG7vF/o6
	a5iQXQS6n/EAcDoLw8lJI7612On6BB+Dw+RIOfp2KCHg7LuX4a9ww3PV6zkiwKXP
	FgqO/fOi0crPhaQdGxOaT2ZSjzZqgYzWcPO277HyyNDFyTEOgL0aBYxX9B1BkEa0
	/1qyHRCgz8ZPM8ZOGDEfpPCdQqjosDiF077f85Ha4VRRAcgFBulKl89IysOCvzjj
	P6pCE+8=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Wei Fang
	<wei.fang@nxp.com>, Linux Team <linux-imx@nxp.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Shenwei
 Wang" <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
Subject: [PATCH 6.6 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon, 25 Nov 2024 10:16:37 +0100
Message-ID: <20241125091639.2729916-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125091639.2729916-1-csokas.bence@prolan.hu>
References: <20241125091639.2729916-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732526206;VERSION=7980;MC=1203325918;ID=94028;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855607C67

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fsl,pps-channel property to select where to connect the PPS signal.
This depends on the internal SoC routing and on the board, for example
on the i.MX8 SoC it can be connected to an external pin (using channel 1)
or to internal eDMA as DMA request (channel 0).

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

(cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 Documentation/devicetree/bindings/net/fsl,fec.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
index b494e009326e..9925563e5e14 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -182,6 +182,13 @@ properties:
     description:
       Register bits of stop mode control, the format is <&gpr req_gpr req_bit>.
 
+  fsl,pps-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description:
+      Specifies to which timer instance the PPS signal is routed.
+    enum: [0, 1, 2, 3]
+
   mdio:
     $ref: mdio.yaml#
     unevaluatedProperties: false
-- 
2.34.1



