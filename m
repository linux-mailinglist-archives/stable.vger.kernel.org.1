Return-Path: <stable+bounces-96276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208D9E1945
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580E6287A89
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1541E200A;
	Tue,  3 Dec 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="dRvFQu6T"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C11E1C36
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221785; cv=none; b=Eerh0NCVHCBlT0DsTdzPx2Hfm1Tnd3HqT/JZDq+aoturCffxDg823I5uCglxe4ANBxzhm7LIz5Q7phdDmqkri4OEno7Jaum4Asax+9oJCE/ang2yhyTbnVC/c+/zB0kEZOIWTs5Xj+KxHMsXyYHJGMbl2f76cGHFKe4QNTTaTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221785; c=relaxed/simple;
	bh=IIcVbhuQPHfwWUqLKc1AhRds3MVIB8X1uXDnOYZLJUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPyJIRmA/cTS75iuX1KgmEalEOjK8oq+685zr/ZS5Alpe1MwkxC7JkyV6z8sDJJ9QWWrh80OaS9wpl5bfm0iOp+SyB9B67zN3NToCsqJPaNdpvnaK1RqjrYj0OkB3rZfeJiD5TJ7FLqjbHpXHuyjimXO6o37JLV7/giY0cLgES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=dRvFQu6T; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 43F09A0AAA;
	Tue,  3 Dec 2024 11:29:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=4jVV7O5ydmCRNe1Kb5Db
	sQ86T+boqlJDOq5G7zOoO4M=; b=dRvFQu6T15rPb4KJOBOQCy80NTOVryPSQZLY
	VJ3f3Rqmi6cuU/uMvl5xYH94xMeAPqS3mdFQiCHSTV0ouTo+yID0h7cKqcFfFaJz
	RpjtpVRLsPxcISzuYkfKurC5ZySJya2Vw61YhOGXy55/6Oyzs+tNYc6VcPtSv1Wf
	CYoR4iVSmZJav7e0EJrc+6X3ePX7QPBWknCjhGUFPOSQIk3i8GWPDOJLNl4Tpokl
	6DG71/auFa+gAn28a7v147Q5fWxDPXJf8RiuuS6M0M2gWcT+rwOXSv9b6hbEB6Vw
	6Izg+cfIMillcLiDaUdCBLIGTv5j+ceGbyJh8adKx25VlIvRvaXVxpY+RoUKFImr
	JOSTCDC1fqSCKVa9eItXg6Snp9NTrWjpZ9MxuBcpnduH6s8qaztXcxL2K3N9Kx/f
	D0VEngAw0OBptr8M2iccQERIR6M21R1/d+8MmusiROmwAzdC05fM5diuZVcFDgDh
	axJSRtouuN9U0o/L1IAJuKGkGBbLbzpcK7qtE6tftXG3X7sOJoAKdXR2Ss9Hhk7X
	tHTNqnzHpU+20N1/6zy6L7+N2Ot5TjFEqg8Sh20zfamgKSnUdztsC0FJ9z1hYO5g
	3pDywXgRDVX/xrBDEYuOFbRNGerzb0ZNQZ67eR6KxzQ8HKwksCD7AP2YJOABMl1i
	RUaFpY0=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH 6.12 v4 1/3] dt-bindings: net: fec: add pps channel property
Date: Tue, 3 Dec 2024 11:29:30 +0100
Message-ID: <20241203102932.3581093-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203102932.3581093-1-csokas.bence@prolan.hu>
References: <20241203102932.3581093-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733221772;VERSION=7982;MC=3430753851;ID=156226;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855637D61

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
index 5536c06139ca..24e863fdbdab 100644
--- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
@@ -183,6 +183,13 @@ properties:
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



