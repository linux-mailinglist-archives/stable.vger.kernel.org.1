Return-Path: <stable+bounces-104012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18369F0B00
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81324281AD4
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE41DED52;
	Fri, 13 Dec 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="L+sev/Ue"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9A187325
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089401; cv=none; b=V04EJJj6bchsopEZXb30d6ByByT640VqVPD6b8RhJuKiN21DX0U8cfJUIe2j1rlZq3mPljGimMpOu0frV89mEFleru1ykG1w6vQPebRsKJJu3lk5PQZo5hPrUiBuTMS4E/DpJnHYBxNMMMbdTZ0kBMHTWM2f538xo1GvrsmeYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089401; c=relaxed/simple;
	bh=z2DkbMYkTph1UTHyTsTSsbXYM/0WeXWwIP2pLbEImJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9SBf6g1/VW1X044rsjwkRCGfLWYwEten4EBg7CHDpvDfKsxe9L79FP49ZhejaSPr/e3h9C5l/rklPH776oj8qF2S5v9zseL8Z77mWW9lY6v1IBco8NdjHJjV0TSU657SEUue7fvL1B39zzyWCORumNrgb9Le/RINGuWjT8QCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=L+sev/Ue; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8D5CEA066B;
	Fri, 13 Dec 2024 12:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=D8I9hiUit/OZsJvzmsYY
	2EWgY89GziM5Y4gaKHbM5Es=; b=L+sev/UeY+JIsPo1lWwOR5nLUEXZNtxRBq8t
	iXWgMONL3S7OEnDj9xqdDd+N2hv6XffMQMjNvNvteRGNXU7TkX0zqTNByN6WyOS2
	uEUO4eMkWhPGs9Z66E6wHdePiMfqwKtltpFzL6ySfuxkOvkfiPF9XOzBquvD2ivi
	CWspRHTASDKb12DqBEB0lAvajKZzf7m568hvyyU/28/Lmx1eG/UiODTlGXBcYSi2
	Y6PM1w/SjLhOeQ/HiUWbveax89FOfa6bLN+ft9CxJB5uWz8i9P+fSjxKQj6trtDn
	Wp+0wMgQWmCnCpVXk7QsUsrDmeFpewtOZK71YLCBPt3oa2OWT2MUtoL9QVg95YE7
	Kk6UuMi0Z3rxB2KXN4J5Tz6lRe3Hq1Y7NM1251t4CEBuba0nWFmzB+7a1Q+cDMXP
	SrFOV8kc5ckSGsGp8MofYA5v9bPvqPJoexnNb/8v5hU4Wri/MJ56cVeUUKI5OgXc
	/YrAnhRz34pW5v1F7tNP3wAhMobeBNaic5UFJW9YWLkJ52+MB2nGAZdOCcRZQgPZ
	8lSzg+tO/IyW+rkk9/FlW7sAjjh/PBDzUMbJ09vffQUPV1JTC1rWFy3GKndZJmTK
	Iq5GkD892snKfBaV0TXSeYpWhVjPwWSWB8nrvfITT7gigFRXzadv2sV1WK35O6t7
	Ibs+GcY=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.6 resubmit 1/3] dt-bindings: net: fec: add pps channel property
Date: Fri, 13 Dec 2024 12:29:20 +0100
Message-ID: <20241213112926.44468-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213112926.44468-1-csokas.bence@prolan.hu>
References: <20241213112926.44468-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734089397;VERSION=7982;MC=3500219996;ID=408616;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855627C65

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



