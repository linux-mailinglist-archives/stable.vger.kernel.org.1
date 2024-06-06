Return-Path: <stable+bounces-48339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 815DE8FE894
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661841C2354F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26232197517;
	Thu,  6 Jun 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2oJ+YR1m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838B196C8E;
	Thu,  6 Jun 2024 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682910; cv=none; b=Drcher3JqfFCYhMCf2ddYTnFhYKz+Pac/ifo5acoGNTpyrdoaM+Cb3Nnp23Afn0wauQd8cUKXgfRXYtUprnU0eoUd94ltS3f2OjLCRHVu669r7Rt6CHJZGpOrbPsQ+6N6ng7UAJ1skGLZwwW9JbLpvJ+mzJNKAbMC5B1nCpTfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682910; c=relaxed/simple;
	bh=sDvVXlfXy5HDqXMMcn21Sr4cOo2uWrMJgL+KR3duFAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhCyxR0wfda5xVEXsnGW7uCdnEej7BnnPxI9BBjNh21cgKSTBC3VAnY7hM6C1/MF/XHxv15N+PJubmZYL0CoGd0no9vOz4PKyWo+/x3VBWgVCXNxmJ6Cv62PLJcc9o8kJqzWN/l79gIR/ehk90acM6jZ97FnZ8wux21pxQrKLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2oJ+YR1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94ADC2BD10;
	Thu,  6 Jun 2024 14:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682910;
	bh=sDvVXlfXy5HDqXMMcn21Sr4cOo2uWrMJgL+KR3duFAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2oJ+YR1mtKffdGPtv9UE5sA9/uHwyOWLkSogGjF/eWDiblkdyGzaQH1UY9QYmnqcF
	 lxUvGZoqqCexJ2GCbtBMt2cIoAcRKkJ8VtOxyRLLPQJCO7/0f0HlZigbDgETLYUuZ5
	 LUl1dlQnh4/rs2jxeO89pkUzpwvYiCtjZjEwXRVs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 038/374] dt-bindings: PCI: rcar-pci-host: Add missing IOMMU properties
Date: Thu,  6 Jun 2024 16:00:17 +0200
Message-ID: <20240606131653.098223094@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 78d212851f0e56b7d7083c4d5014aa7fa8b77e20 ]

make dtbs_check:

    arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: pcie@fe000000: Unevaluated properties are not allowed ('iommu-map', 'iommu-map-mask' were unexpected)
	    from schema $id: http://devicetree.org/schemas/pci/rcar-pci-host.yaml#

Fix this by adding the missing IOMMU-related properties.

[kwilczynski: added missing Fixes: tag]
Fixes: 0d69ce3c2c63 ("dt-bindings: PCI: rcar-pci-host: Convert bindings to json-schema")
Link: https://lore.kernel.org/linux-pci/babc878a93cb6461a5d39331f8ecfa654dfda921.1706802597.git.geert+renesas@glider.be
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/pci/rcar-pci-host.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index b6a7cb32f61e5..835b6db00c279 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -77,6 +77,9 @@ properties:
   vpcie12v-supply:
     description: The 12v regulator to use for PCIe.
 
+  iommu-map: true
+  iommu-map-mask: true
+
 required:
   - compatible
   - reg
-- 
2.43.0




