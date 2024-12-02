Return-Path: <stable+bounces-95970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0799DFF74
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5505E2809C8
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3071FCF41;
	Mon,  2 Dec 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="i9JFV/rr"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8A1FCCEA
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137053; cv=none; b=hIA8iBQhoWO15Uf9V6zrmnqBXffuM1z7dISPfbeXTKmx07g8qeSZutAiCyALqC1pjoyu/iYNGrE1dXIw2CyK4pi1sACry5Aj2fk4oxwi7TtTCy4OLspZ3nee1DtGXImqcddgs/f7WMWTx0ZQgLPYG/DiwO9FozsgjEIqOYM7Qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137053; c=relaxed/simple;
	bh=lbIWNYMvSjyfLtOw1mvuOqw21VstXoAYqxbOHR064L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d1bz7GuCL2hjwOJxXn22MKm4G6jMhPqlNE5ZUBwd0nos1Ei/FkD1wE+6rBLjIKukaQG5cNOhBNwajAmb45vOm2jEiqBg1wOQY0GLHm/RPYPpDKC9V4ziU4AxzisCYSskx8KipoBH7VrQ47Oz1tH4M99nEqEhICP5qGki7V6W1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=i9JFV/rr; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 9B20BA03FB;
	Mon,  2 Dec 2024 11:57:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Q6wYDtIQjR5+T/DQDg0D6iro4kbT0EVZiPNUQPiaEF8=; b=
	i9JFV/rrpvDJ62qjUuoqG+IRIu0DAZsiPQkrmzPfs+DFQrIIjS/FVN4zRqn0ihoo
	iIlYtewQHtLYpAP70NKJsOvt3MaiMYahx1+a9G4c58ybORyNW8Xz4jkwVc6ntGE1
	ogl64Og+OLwJv1AdNHI2qy+oUULNfw9XGlHhY6P2x/EcKJfwfdBQdbEoA9zG6JN6
	9gY62MOkq8JQA7PygIu5eaIQ2SRKCIBrGdLHD9gSG+iKnYg8HnopYwdedneMl7bH
	TymRVOlqQtHnAsaBLnET/cd6x9ZWO35q/E1nndEhExFDFN1x/nDHs27XR0a+5qNQ
	eNYSJDACV6IBkuCFr+Ryln77MergOgdH9hI4vr7SaV6UyGLuyGWKjKrkQwUixUK9
	zE9TELBg/RnMqgvZvOLxXj9p0xlFHxZGpGDulcDbrY81jvfzXjalh8Hib5bfwOur
	1GnXPg8nc6EIVseuBXtPQcu6tt4tbHzn3ArwKG/tZmoqtcjyXoRQpe86kT9OVIxF
	E+BmGHtRzBV0Ev2nzuOWehMr3pE8AM+bezg7mE43Guh4tFD3xduGHlGBJ89KGng3
	KYKULuWRQcji5+wcL43KlQKwf6U54eM4Kjbttnt5Ru2QodgMri2IU6FpUHogJZVO
	leUhgEXmbVoMZlknAXKD6Gp6hqb4jZ7kFI/IEu88uzw=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.11 0/3] Fix PPS channel routing
Date: Mon, 2 Dec 2024 11:56:43 +0100
Message-ID: <20241202105644.3453676-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733137049;VERSION=7982;MC=2775895811;ID=155630;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637263

On certain i.MX8 series parts [1], the PPS channel 0
is routed internally to eDMA, and the external PPS
pin is available on channel 1. In addition, on
certain boards, the PPS may be wired on the PCB to
an EVENTOUTn pin other than 0. On these systems
it is necessary that the PPS channel be able
to be configured from the Device Tree.

[1] https://lore.kernel.org/all/ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810/

Francesco Dolcini (3):
  dt-bindings: net: fec: add pps channel property
  net: fec: refactor PPS channel configuration
  net: fec: make PPS channel configurable

 Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
 drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.34.1



