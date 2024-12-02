Return-Path: <stable+bounces-96116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F49E0868
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C559916986A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4664181AC8;
	Mon,  2 Dec 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="DLnyJV4F"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB12126C03
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155043; cv=none; b=Q33KE/frO3wk6LQnTRFfnSB6QLgEMV518DLahVHzKFzxBE41CDT2HqhduzE0n9LWrbBbl2GCXGQl3ORSsbInvUrEQ7X46KZetzk1LOtY+uW1qmROgW5jawQ18nnBHviWymdrlhMUkBpPs1f64wEvO3t3EhNCbustWGIsjQKESVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155043; c=relaxed/simple;
	bh=UXKaK2jLvVYzadqwgc702aI4x6tDl8hBRaN/b8xoGws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjinI6IZRs3ZKt/mkaZ+PFistUjYXvP9TWpNrT0KewH3kgk8ZJLd3UHNPbRRnYZVVPKCpnyElJYWSlleuJbXz0FS6pqSj448uDhd6tZAonOJF9/pZh4PVje4IS2ERAOKcsCEjLI/mSMlQEYNF87glD17q3aT3c0UL54eBIO9mqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=DLnyJV4F; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id EA97DA07FF;
	Mon,  2 Dec 2024 16:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=vNUVxMx0Y/UCbH/xe8ME
	xQ76FwQUIPaWGNQiNlvJ4BY=; b=DLnyJV4FEYv/WDdx3BiE4LardhjF+KTouNvd
	7zHNDmAjhKlLFDa6LedBPD+cd1MlUPdjsWEfV/UdMqF8i6QyW/fekOcS1Imw9Frf
	5R8M+kfmmIqXcwdJqOWaRhnnSwprSVh5EozJF/tRAxL/I0xoU87GG7GAomwIBs42
	vERX61jSJnbMl/VzGQrDCSndY0SY4OZZgeKTi9FwQrrHpu59KjgabDnHpUvOOAuO
	CMUPf3P8iFCJMxXlsjjXlGCe+R4tFOU4/Mna6BZ530flKQL8F7M9kvUyThxdZyGV
	nI7u3cxVnetMSFCvfcsfq7HWKr4Dv0LxxI81/Irptq0N91plSJx1lsgcikTnNqqC
	N+McGeosuW/HJ/ldoyV0SnJ4mgp1roewvqikalP8JIcN15MQSiuVROTTb+9W8JMI
	tBYd0R4IwD0URntyGLCLDDG4SCAroCNtGkzivauJ725+0ted4R8Y7wY/pRWdxMMt
	ryp+BrexV415lRkKql4zu3Jf+uPOOwUvBqgteePobVO0knFXlB5El4TLRdkBdhsO
	w0JZTvAteuEw5aXqpwZcBtOTtyItfOKqMNXTnP2FMpHF10cF412tLwFFLJbeNmBd
	d1xlnjCzvzP/pcRWl9LGX/RpUTQEiUeNrE0WRNP77DVRJOZl1TGsG277AkoNPN0u
	vh23w9g=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 v3 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon, 2 Dec 2024 16:57:11 +0100
Message-ID: <20241202155713.3564460-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202155713.3564460-1-csokas.bence@prolan.hu>
References: <20241202155713.3564460-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733155037;VERSION=7982;MC=1228731497;ID=157279;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

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



