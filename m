Return-Path: <stable+bounces-96022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75999E0335
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0F2B4495D
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DA41D8A14;
	Mon,  2 Dec 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TRRV+JJA"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD071FC7D0
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144970; cv=none; b=SJbKJziV8JZ1b9BZjXI5MkMlhiquwDaE4O8hoj+pilPZA06YqGNqeA1WJrkkjvAdzEhzlL66JWs7UTbaR+TbI2V4tSHGd0Bb1Ww2xtHZShGaZI5KwkKPnAROuj0/wZiKpUKQ4O+/qk+SgsxOQQjZSAqk4OyWtrKe1b+kL3bR7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144970; c=relaxed/simple;
	bh=dsTzzdSsZt+oSYYQVH8XXEIY8xe/TzmTIfPnEtBZcuc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uurJycf11A4M7yO7ksBXrS+FkxVVcOxJs/BNYi4dZ+29w/n/7BKTr94AgISfTdPzoXZbSst3hMYC6sxfotKdgR2gIr53nna2GAYOkrAsNdM2IFp6BvR6McDJJ+oKu/ylEkAzucGdpMRJSQTFUeeWfEiUKf3pKBo7wEUnNSY3VzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TRRV+JJA; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id F1A53A05BF;
	Mon,  2 Dec 2024 14:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=QprCmApmWccNGNvY+IltxdtuK+uddv+3S7q2PtnzOmc=; b=
	TRRV+JJA8QPMfvw0PRgZKE/n7J5LAN+uCkpF06SCuoZTGyqs8r6rCEDxGe48nUZF
	mOCMUkUWf8l8Qu6EQ4qo38MhPmfgXDuyUcidv4N3K9jOWddCuUiKdpdNcgKYXha5
	LMIbncEvNVjSMEED/k/XFY4H1mF4VWLSg9rFvTyBXEZlCdddm+aMSzYFoxTFto5e
	UijZMH4t+ejQWLzeil6XKHl+sfK2z7fbYe4QryxU3n80lV2+44/NJKQIo5tAN3MI
	8ISEA6DUidHN7HxkRBj9jDx58xC9hIKfbgBveJ2bHNoXmTG/gZqAypjL4NKZ0uQd
	NOP4t6dKZel5I5JJ3ltFzeG3emNyvZuPwEtU4DliC05t5lITijwr9LGWLuIE4RRq
	AF4tShCwpZb+6yyQCOBHuzK8/39wz46fewGHq45+AdN5Y2adPxnfEWCKMtvrCUR4
	pjWYTp7Uqt5zjVcIJNGisl3Kohdx17K2dvBu/32qDVSodImRzlXKJajgCerGgPR+
	LblM6Vtzp3zuFSdQ1JN3Dvux5aX013neVmB43JRJdwFDf6ywgoR7zSWRQwsZyXMZ
	a8J+o0RdOrMdoViKzITrvoMIG4TaFveVg6Vt1EgSi173Qm5NJied3yvaU8V0YHsy
	gbC3dJJ5uM7r/8Ncg8Mat4pitnA1D70yyNult1sf8V4=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.12 v2 0/3] Fix PPS channel routing
Date: Mon, 2 Dec 2024 14:07:32 +0100
Message-ID: <20241202130733.3464870-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733144964;VERSION=7982;MC=124138276;ID=156980;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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

Francesco Dolcini (3):
  dt-bindings: net: fec: add pps channel property
  net: fec: refactor PPS channel configuration
  net: fec: make PPS channel configurable

 Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
 drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.34.1



