Return-Path: <stable+bounces-95972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3769B9DFF77
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608B0B229A4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54A1FCCF9;
	Mon,  2 Dec 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Ts6D7+RU"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C221FC0E5
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137054; cv=none; b=PAq+gnazXy0bZs3GrR/DA71lD5zMZMrca9yNLH1+XrxsMkElL5zsXo23eOfA6WGjZXAfp5FP0yqF6Emn1S5h1qdjeMLZa7QJhnTzGvTVQbghxKm3LiIXQTW4zC0LbHvjw/AMa1jc8TH1fFxX6I5tQzWg7fFVEgtMG/fjmi8mdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137054; c=relaxed/simple;
	bh=lcyJGzSJ/OyqT8N1bx8uWTBCfIdRy8oHgTOWiOTiQqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY25h00R8CkCAaJyimA++/b9vJ47/ZNvG1BOhMK3wpyRI0cwcgnOOCTvV9M4NICzaSb1mIbatrdgGrQXOuczwMwfRrHm/MezzAkWLtYt8rPUbmmjdsxWmNCRHaKIHVCpqVOmldUdvB4lX9jsiCENCtAn2xsdWGzWvMlgr6lr4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Ts6D7+RU; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id D3BB1A066B;
	Mon,  2 Dec 2024 11:57:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=9QtBXFL+VFaymHlksRrX
	NzOI21C8muB0L90mgKfGc0c=; b=Ts6D7+RUnPuXbj9CEj/WKlYZFOWNZC+c7nd0
	VgzcYsidIYV0p+pIh3j/w9XNPX9EYtM/ngUfechq2LHSv0jUbY2ISekCmLjsYkKu
	CNbLrLYkDxtoIK8yDUbdGdrukGA/0YhP4i4brWQKdByftXjseALC8FoScdQTTt+C
	42ekyc7hjfSvujeISlPF/LWSi1vLRiKceAkdpdUeRpIgH7Tl8I1HHkFSVNnyQ5oy
	sIjCBRBlYNqwsR1mpKbPa9NduOb68ITNSBgk4MrnKsawe4crYXepYis5i6ddn/HN
	2fyKmoqQuqDZ90YvrgiEQ9D2MLTXioQrTDm9ykv7jR4GoAPcu9Thv/1DG7IiJhGK
	inilTzIjYUBwumibaozo+sh0HBOaV86gFJM6ORwrJrKrY8X/wRyjYtzmJJDlezbp
	61QyMD3H5inxLIYmZTil74W8snDOjKlJ1YAa+ZrlXljoD3obvqI1JtvAo8AtZ+zj
	GbJA1nrNX/o9xKzOfb6X8BuOLnJ/swi1H7TLPupGkVDC/BD6NnB0mgD46r0ymXeV
	hi/3Ig6kyB9M9pRUgtCWOrNxz8BLfbSqTyGAQjutZIM3PG0ajE7QrK/aTqmdUYQA
	hqOz7Ur55fdU4Kqtbncp0QrCCpO6yty7yYyVeCQUCz0po39iKgaYPoryRh/mk4eQ
	ZQR1tJE=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Sasha Levin
	<sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Conor
 Dooley" <conor.dooley@microchip.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.11 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon, 2 Dec 2024 11:56:44 +0100
Message-ID: <20241202105644.3453676-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202105644.3453676-1-csokas.bence@prolan.hu>
References: <20241202105644.3453676-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733137049;VERSION=7982;MC=2638218254;ID=155631;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637263

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



