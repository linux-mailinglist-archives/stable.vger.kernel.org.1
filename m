Return-Path: <stable+bounces-96027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFD9E02EE
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2174F169434
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25501FF61B;
	Mon,  2 Dec 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="r2sb9i7H"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC71FECC7
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145038; cv=none; b=RBdy8gEeCxi6Hh+LBOa730CsMtGnoePkFdvtHo0KX/ltUv2WlhBN50+kkgEAQEqClBLe032bOXng05qlFq4DVW2psa8NLHtdJPj1QcwTcYCX+FrhyX3zMXJojQJGrGemUW39TFXGjEx28/06T2msifL/ceIqNme2FpK69MQmmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145038; c=relaxed/simple;
	bh=AsmS0O0LobS4HF34MnQU1zcw4SRgmr4teuSJuhQf67w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=js64a6g1EC/OvKeH3TvM6/nBBcW9xOJlq0WUq3C+3w6uPGjHJIHHVm+zQbw4oCdILy/ydQBB10ilOoPALhF2Dm/fizkuOBR0f8ebXK/H1o//OqChxl1AY4JDJgHfV2e5vP35pf2Wc8XI1dCzjaqNeZyuocc9VfjUpjO+T/bEZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=r2sb9i7H; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C16ABA06EB;
	Mon,  2 Dec 2024 14:10:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=YOuKY9km4OF/f7YVbyq/
	ULvcl4sIlXanZsvH0J4LkgQ=; b=r2sb9i7H+1eFS7yEFL1C+lOxMeY2IKl9/IVF
	O/C8Da6JbK+vexnrdQoqbUtFwL8HKcvYP6Ae3htEFsdL+TnhZZQut6/dUwamNF92
	/jkgSp9mXXw+tE3BOvaGFG+44uvs4ScyE39n5sib51s+QbYuw3tt9e7tr69bfX9M
	LlxsnrA3xzQIQGMGdyOKkVtVzCEGybYAcJXUE/DKluk7TRJVi5SfzA7+BOQ7+ffO
	kQj4qrStxG8CGBlUT1ySACCcRaI06Ri8HgGs3Nc8x81rd16pq8hUSAB7p4+ABNbT
	M8K/651nx12Mw2+GDwF+jAJ+2JTeb9b7Jb69GZKL88k1PWw6UKMU6Himp+QLKDFK
	8A7byI3Qccqp+1olNELRHA3h2Jy0N0YOjHa/bLSuLOQFLVyn81gt2t5ZT+17t9wX
	Hj6NNKv6CGS9t0QpHNnqOKJrnsBS8RF11H+KRD6HM6zmRda2AYpoFKAmmG3OIS9W
	9nEw5tlrdcfiGMQ/BUnQvPxhBtlOgxZeo0rQwhhjlbCHS8RjMViZLnGH9I6tt3YO
	GTg0tf8EKJpsMqBAVA2eeHrP0FpUE6KznI15bw98QcEVGhsz+PnRUpxEDgO6VVtf
	3pt60QTWwszHDa0Hzu5wqqdjzb9+vdyqu8YkRK6eb6SyjYVoVeAtd3PHapXR5qOS
	y8zw6Ks=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 v2 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon, 2 Dec 2024 14:10:23 +0100
Message-ID: <20241202131025.3465318-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131025.3465318-1-csokas.bence@prolan.hu>
References: <20241202131025.3465318-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733145035;VERSION=7982;MC=430863224;ID=156986;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



