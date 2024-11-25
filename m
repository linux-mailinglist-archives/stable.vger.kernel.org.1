Return-Path: <stable+bounces-95359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A759D820C
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 10:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 172CD163093
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDF18FDC2;
	Mon, 25 Nov 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="D77n2q8I"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A37185935;
	Mon, 25 Nov 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526217; cv=none; b=JNrs2qnrjfbVAeC6q3DiKMbOXB94bOVVn/2of7qFJOBTgPR6Vplo/KYIvjYUOhi2cmj5YNJyX+HB4DTD5Ru/uaGtYw3snKZhPWtanmqvJ+OqvhqUw+eRfIx57KpIMWa2r8l/4pMZVFoCOFnRfBZIz7KUDQv7Dd87p6KIgGHG0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526217; c=relaxed/simple;
	bh=lbIWNYMvSjyfLtOw1mvuOqw21VstXoAYqxbOHR064L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZkGl+0LcI4CxNbjl2IatVLxxGJtbypLoUtWMimXCJlY16KEulIehUw7qvMv+x0hzKlYn6TnfDabJ+U4z5BAIx52i8CN3P1CUe2E3GiJGJElANTElA4ZePgT+NfOV5v4Xc5nTx4x/MYbdnJa4XZedzGP0Ifg9RPkHCxHcBDTRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=D77n2q8I; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 04FB9A06EA;
	Mon, 25 Nov 2024 10:16:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Q6wYDtIQjR5+T/DQDg0D6iro4kbT0EVZiPNUQPiaEF8=; b=
	D77n2q8I+1axsoSfEUHf0oXpCp8HYOhEeOmuJ5cmgXsKxK+W21I9qsJt/BQo70K1
	7cW42scuXJZ4oGJkrTmPLGnHyVZcxpxPkiV8JbTrUB3dTXi+lHh/8BcmJsF+72O7
	T0435DSBWWStm4ONl0+rT2Oiqjeq3IdTMeEwD2ZQd7jilgRDQb8/8LzTYawYW4vW
	0bbRTbOOkzc9k8ysTm3kkUB6JKyB19ZRhqyrzEP8G2IdmN3hUtNpGHCFJB+hQ2FP
	C1s52uOMOunvpDJrsQncQQY8X5qFF8vM5IuEej6KQ/Ke8t6g7lDIueXlI90/NO5L
	fCHGkf7IWgDCWsNVAxFNvvrmWOZ3hkVCHr0LC/0dT3lyS+ty7hPTjaKPOGKBmoTD
	mGlxsM8S20rGVCu+0ki/AnszcQjbHIRC2ShyGbDx1tAhLdm9ZMgrzoOP6UofmFUa
	5gwPBEBJfmEvqrXXrhfS1LOjO5mASxGnQoovG4VN9itan6zcXsnRGW8p1LPkHEuc
	S9oj8INYBQThsJ/xBh4gfzkxEB0xXBs92O+gHN6w5IEYEtfc22peuzu6HA5w3fLL
	6FX9o7nalAJTUG9IkUsH3e14QTNQsD2FDtUDZ6EhOPOBtnQxecBuFKq6oFxn+Ddg
	2eW2tTcWnfO8BBsTCG8BAZR7dhwBBx5Jc81BiuuAOfs=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>, <netdev@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH 6.6 0/3] Fix PPS channel routing
Date: Mon, 25 Nov 2024 10:16:36 +0100
Message-ID: <20241125091639.2729916-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1732526205;VERSION=7980;MC=2019651544;ID=94027;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855607C67

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



