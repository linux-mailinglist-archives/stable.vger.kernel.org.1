Return-Path: <stable+bounces-96113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF79E07B6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96ADF281A9F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647D137C37;
	Mon,  2 Dec 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="op65QxVH"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FE757EA
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155041; cv=none; b=vEfGdo7khZ1pc9pWka6BDPVVI+Sy1m5jPXnKuMHQdOwjDVtV0gCc7X5L5MTmj3OSf3NHDClp/GWuhuWYn/VZxPbc8/c22pLAdbNZ8i4YPaUKlT6ffq/Vt3x0L8+jjjbZKJGATgYnp59ElcEkgy1s29SdTaGyHUI1FRruT8V9Co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155041; c=relaxed/simple;
	bh=yWFq+Poe5+N66thnGMSozM+ZhNaYMnx6L/VBZhX+XB4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EejG+gnnRCd7KiTwEtsLjZkbWLIehL6Pkuj5eQw3/cMVfiGrPZzoJDTtzxKC+F8KmTQGhZW3q6vdOK8W620UBePqK4kTLUae4Y+6tWLGgKn6pxOHYlpK/BpstL0LXfKUkUsGNRbVP9y22sDUg0J5HUOrGpZju2yZWsdHAtGVl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=op65QxVH; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A4D04A06EB;
	Mon,  2 Dec 2024 16:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=3bEWoIa3XLMJ6jUI1yRMUgzskV81OmI43xN+QSpepsY=; b=
	op65QxVH+H4z1dZqzi195qPetS/MSGjRRi1vK4sfcv2+JJDeBi8J2ggeLtzbL8SE
	8GVIEXb3ejC9Tb8SDvu/wITuOyI2fAvFkhUkK1chkpypjhdsGQ6Ued2NKMFzuKCZ
	nPS3iOzk0h1Od0O+FBpanfYU4o6e01G3nCwlBmi3GZAdz9Cjk9Zf7IXjQ/Av0csg
	QyMxKNnT4EmA/J5mxNyGh+ej6GG8vJYoe6DBGkTl3qldlzgg8/F8xsf9mQuxP4WB
	LqEKxf2/geK4uklfhHUndse4DOnChrqQ6X+BSetgjGmcWtx8Y0HKS8KomDyGZ7MM
	R/4prvadSCmyXi5yzL8uMT4M98UF0KCgQ7AwKR5IbCprpmwyNEWPLaViGXYpyD0w
	uV6i0zmRioMb4ZwmTSrOpHNFpsYJ2v0NmaN7/K0qqaSPb/9O4+Fn9HOv1wFHbIa1
	d1DRAJsbqcn5xOAdRVn4+mkYnVmQnhjVxhR8Np2g5mB4MDzjpHw3XeJ6YtyUZG7O
	SvR/dFC7hAWtgvmMGfvcwI3OBhNYQQc9GIdvyY5+BfH6yUYSNQk3trkAAH6MBi9b
	aYau2vpkxeKQqKs1+t94qJC1uFyK+lFL1ACmPIfWm4NYKjq8GwjyplMmtPiCb2+k
	IVQOP62FHTRF0XnkXX7XalmPdQS9XSlkAokVWxf+33w=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.11 v3 0/3] Fix PPS channel routing
Date: Mon, 2 Dec 2024 16:57:10 +0100
Message-ID: <20241202155713.3564460-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733155037;VERSION=7982;MC=1247557910;ID=157278;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637261

On certain i.MX8 series parts [1], the PPS channel 0
is routed internally to eDMA, and the external PPS
pin is available on channel 1. In addition, on
certain boards, the PPS may be wired on the PCB to
an EVENTOUTn pin other than 0. On these systems
it is necessary that the PPS channel be able
to be configured from the Device Tree.

[1] https://lore.kernel.org/all/ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810/

Changes in v2:
* add upstream hash (pick -x)
Changes in v3:
* Add S-o-b despite Sasha's complaining bot

Francesco Dolcini (3):
  dt-bindings: net: fec: add pps channel property
  net: fec: refactor PPS channel configuration
  net: fec: make PPS channel configurable

 Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
 drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.34.1



