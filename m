Return-Path: <stable+bounces-190037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A0C0F470
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F142188CF6F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8B30E82B;
	Mon, 27 Oct 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFHSNwt7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52B307AFC
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582542; cv=none; b=cEfsCzIqikveT+THf6RSxXnNa6evEwZAPv1E9Mq3cDbEMzNbpsI/ZSU7K3vo7m8XQ12YKLlJr/cDhLsnA2myyNG77eA+LRBC3bwk2W/IsjP8VrEbdWTBaRsDbhWkPnnTlOXrgMNYObh/Izy9dKvc6oUlJfaNOWi6ev+qQcmuvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582542; c=relaxed/simple;
	bh=DCOqxa9UzgR/ESPWKHhR7LZzVThxTMIJJ//KVQUqiVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzMmp5SVdgt6o5PCg7rwg6FhOlmG56j8aXaBhk8Uaeq4ihvr/wSYmFPDY/9IhXvSBICs25b23VkCDx+HWabvn6jf6oMN0ockTw+cABaeh+D8Iewnag1qdTyr9+Je/8sDxEAJnTCKLjcYJnBeOh4SNUuY3K5pOjkf7HmfHn9S8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFHSNwt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ED8C4CEF1;
	Mon, 27 Oct 2025 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761582541;
	bh=DCOqxa9UzgR/ESPWKHhR7LZzVThxTMIJJ//KVQUqiVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFHSNwt7HA8PsHgF8flHsnU76SWiD7n0WMybNAdmTf0Kmn1JuUpqgen8fp7nCJWiZ
	 smfT+0QIQzr47BXCUGnr/MHKo1/ilrfkvV2JG21spFqGLHPOC39w9meA6F8mTHg4SE
	 73emMrPQAn6IcF9M4mzuOy/AY2YtVpI24JGvor7ijCHTVt7Ba22oUERTH5XLZB3Agd
	 6ePEHxsL9+kJ5YAWd8LLcYhNdN+xH4lOFGRUUJMC640ucKiGWLf5pMaOwZs4SHzNGQ
	 Sf3Cc7F/znKJySi11Y4R3eJpAgr03VZOMBYBDgxGrxHuijCaB5NhSWgdYUjqwqOtpJ
	 sd6g1R7JD3sRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	stable <stable@kernel.org>,
	Jun Li <jun.li@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] dt-bindings: usb: dwc3-imx8mp: dma-range is required only for imx8mp
Date: Mon, 27 Oct 2025 12:28:58 -0400
Message-ID: <20251027162858.577729-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102701-congrats-attire-807b@gregkh>
References: <2025102701-congrats-attire-807b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 268eb6fb908bc82ce479e4dba9a2cad11f536c9c ]

Only i.MX8MP need dma-range property to let USB controller work properly.
Remove dma-range from required list and add limitation for imx8mp.

Fixes: d2a704e29711 ("dt-bindings: usb: dwc3-imx8mp: add imx8mp dwc3 glue bindings")
Cc: stable <stable@kernel.org>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml       | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
index 974032b1fda04..70c657ffedb10 100644
--- a/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
@@ -60,12 +60,20 @@ required:
   - reg
   - "#address-cells"
   - "#size-cells"
-  - dma-ranges
   - ranges
   - clocks
   - clock-names
   - interrupts
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx8mp-dwc3
+    then:
+      required:
+        - dma-ranges
+
 additionalProperties: false
 
 examples:
-- 
2.51.0


