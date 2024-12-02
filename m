Return-Path: <stable+bounces-95983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83D99DFF89
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E06D2809C6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D81F9407;
	Mon,  2 Dec 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="eSJs+Jbq"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BE156C40
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137257; cv=none; b=f76LBGYiYIslwqjw14c8te1AQFrjPK5/vfNnIQ5eHpXgWDquW9G6D/S9/kvm2lDOSTBORYXsxwXU8cShIVok4bo9/X8QQWtJxhmdIxg2GQJ/YLSwesmjIW6oaFyojMcnCcD3S4F5qgGMWDvWOBqa8+xRvNu/mT9VN9GIkQVDWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137257; c=relaxed/simple;
	bh=lcyJGzSJ/OyqT8N1bx8uWTBCfIdRy8oHgTOWiOTiQqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/te7x8AutsPotqF6ae3GWo5AWdIVHtJlG/qJ1NRrMPf40fytI3afaUbFN86V8dX8hVpZeQ7/5Xw2ZCLfT0zLvc4mcM1k7sPCp9gEQMneH+iC8FP17kXFWyGHsXcZAIK/qXabSkQheol27+XQiU/Z02RAqKC+O/PzhglIjwfrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=eSJs+Jbq; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7474CA09FA;
	Mon,  2 Dec 2024 12:00:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=9QtBXFL+VFaymHlksRrX
	NzOI21C8muB0L90mgKfGc0c=; b=eSJs+JbqKEQlhb3cNl28Ga461oVpU4MXTRIH
	3UMoLrbZrSEynHM718EfbBlgjXd7b4TW0fV77FQbnWEQeNCTlw+I5cadEnJ/1x8g
	GCeKsQa0EfMO3XiKYEnPrBHT1eekfqlvVo+Hs+m1BSYPkSYctfXab69QI7vs7GYy
	2MAKcqsJRak5BL7EMpj5JkudIOMo/bP7nQKqwECJP2a22BEat94H5H75Yls4BHI+
	KPqMGtV7ZO+F0UkJVheq38jtO41HiBoT8K6I9JTyKFPIqUBWgnZQy1yegrp/VCwh
	onJ6mFZLmtP5ZCgC6YhLPdD3vHH+sOUmyRF5+JWOWrdelBWwRuMu6l0Ai/CPVDy2
	abT9KdX36FLSGfiUGtVnud7YrTZ/ux8UZm/OnlvVqhjQ22FV9qi4OPcTMqoFryGO
	JjeN3iADGK0UIoHx8E5NUvVDe1PN3Pud/lqipF/E/L4AuoEMgb+pBGe717FdQEKO
	t2GLefAqapEZpppyo74fDq87u6XQLS11pC8t7TWdFNTYTUFKEX6eV97p+dM5imM7
	2eoHqUum2WI+g0rqfWhLzHo/zRb6j1ISM6qgITDjzwLVeA1YnfFAfyKUdPqIJiSI
	gKv8lILjcX5vjB4G7wzMVDvFVG70GZbvJlNr/bjHJRWS2cyVD1tS0JyswQu0j0dt
	vP2lB1Y=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon, 2 Dec 2024 11:59:59 +0100
Message-ID: <20241202110000.3454508-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202110000.3454508-1-csokas.bence@prolan.hu>
References: <20241202110000.3454508-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733137252;VERSION=7982;MC=2867564212;ID=147635;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855637263

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add fsl,pps-channel property to select where to connect the PPS signal.
This depends on the internal SoC routing and on the board, for example
on the i.MX8 SoC it can be connected to an external pin (using channel 1)
or to internal eDMA as DMA request (channel 0).

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
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



