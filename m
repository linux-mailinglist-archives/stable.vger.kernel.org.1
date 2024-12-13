Return-Path: <stable+bounces-104015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E59F0B04
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462A61887EC9
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44561DEFC2;
	Fri, 13 Dec 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="fRqKywsE"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6591DE8B9
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089403; cv=none; b=p09fpF+H4e4pY/TBe1at8r1Mn2F2L/c39KiJCKqxVVJj7o1r20qKgqsy0hj9KzV5auOjWZRLAjL9/Af9I5nuNaTixzbo3LOQVy5v1rJsx6mUfBhOmrDc4q+F3YIu3V6C7oKbJMQ7MJuhY6O6d9kBkMoO5LCmG+xhuXYp/S9BYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089403; c=relaxed/simple;
	bh=IIcVbhuQPHfwWUqLKc1AhRds3MVIB8X1uXDnOYZLJUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNoGxBWo69gZCr48ollZScg8wjSmGiYU8lWC8w5GGEfA5A3h9t/WDLs4Tw8rpVwNPFutMiUuhzWJfnikAcEiHjaXKKsZrBzu15PdRLNhne2EG+4tabLNo9UwsEvYv9z8MQPv1vRbTbWi0TM7U20OMXZPs805Nobf+9vuPVD51K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=fRqKywsE; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BDB0CA0AC4;
	Fri, 13 Dec 2024 12:29:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=4jVV7O5ydmCRNe1Kb5Db
	sQ86T+boqlJDOq5G7zOoO4M=; b=fRqKywsEd7UEj2bn5vVCXXtHtLX2lzEYIP7f
	2n6LzOaKPdQkJ9vgw5ZP1Vd3sufsLJa17VE1jCHcwmy++C2KnHsX+pcNPkd0onvK
	ci7kmB07wKc2TyBEHIaqmg8xQ8M9QoUqCaB6SVKJNa9fm5P70EjzQU4AWIet4RMd
	UtoOl46z696zfLBQyq2W5FcJiMZiD8UVwkKPkXecHRzAie/7tj3PGIGLJJBC1Y4d
	xjvRBzz1LDDzC75JZzjI2NFuLZMYa4P758/72jhkD4Bjh6IN7JWYlrXk8N99Lp1X
	yriZvOkqBGhmtbilMdPiVOAp78T12dSlpWaTnMWiZq15/hgIEDSvca1RKAX3ArB9
	OUhB4I0bbf4nHhRgWS/SLilO7fp1ClM7jDnbXJYhTELIzq3IJL2pNTP6L3knUR38
	6CHAnWzr47HBju0L6JapMrzgdNW6LjglDLj3xiSjpqpDTngimJB52fIcRPJLNbqd
	gCDS2xul/amUgTVWU2LCq4o72q1tUQ/NWcc3XH+3y3nAgjV5qY1tnVgEKmM8J9It
	ihjaoOa9DqNdR/xZ1m19iNbBj3IfpwZNVASesdB/ZNtOpneLwBkIiXdQVK63jEKh
	hlf/jYaygi/86N9oTOuoyPht0p68mwglDA/SuDtvOi7DhK/znzFwnF27f/qk1UL6
	scIdb+w=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 v4 1/3] dt-bindings: net: fec: add pps channel property
Date: Fri, 13 Dec 2024 12:29:24 +0100
Message-ID: <20241213112926.44468-6-csokas.bence@prolan.hu>
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734089399;VERSION=7982;MC=2356978147;ID=408620;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



