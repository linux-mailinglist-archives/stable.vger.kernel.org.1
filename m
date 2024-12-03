Return-Path: <stable+bounces-96273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E229E1943
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBC416561C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC0A1E2018;
	Tue,  3 Dec 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="SzG1HSCD"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51611E1C33
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221783; cv=none; b=c2SJvhtDwAjbdx/pJQMXWIn60UeuSRjW/TPGXVnO6f8dLYvSgZC9gmhfCY+xfXc8X0Blo7t27CVd84KtO98iEXr9uKYtYochmX33vf8ucFrYykPWDVbeIeWowvNUnYMaJOG7Zv87NYoKCRRsWxb5OuWOME94gdEdSPV8wo+4Qcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221783; c=relaxed/simple;
	bh=tzRBKOi7nYqm9D9vCH+hmN9iYyHYhs0yEmOQ8CA++Hk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hKOEr1zZUdJWDnHjG1xIOnX5Kq27q9Z+0pPW+hf/IqlAEOs6E0mTd6ie3sFJZpotO5pSC/oTc8zXpPOMvgQofOH3hLYXujjH6eo5eufzuS2yzSJOwRm/VLKNctJbVrO3SiNk/HdOXEyd/nfCnDvk8Y5UGxHyw9QS+edrMV9WD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=SzG1HSCD; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E8979A0A10;
	Tue,  3 Dec 2024 11:29:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=ro+9xHT458y73PBdep8DhosoomcfuMfHyp4+zWFlMyM=; b=
	SzG1HSCDLXXkWh/nM4rdUxySAGMEELWisTKzsp93ytoDSNFqBv5aUHOX8SzcJ8PM
	gmeOc1Cye5NQQqusSJfZCOgvQMZ3sgQ4m7PSc6ceCJi20wIl8RV3zmSXrMKxL8J9
	v+O65hwAVjfrqlnnzvZcm5Y3DDf2+CidJ4vYEZrFYmbu8U2AW3muLdPsp5sdpiMS
	maDae68lMbFgB/KRz+Z9DMrbnZS/ldK8okqA9RVEczOjoMwcoW4oIt8hpldxygi4
	L5lswe/IeRXEWT/5DTXMD9PSRNA8T/tcBdUNMDaNQEuDpS9QPGD+NFXDFH5/tSg1
	D6kS631KeQXwRIO6p74SkeE9f2ggE+5fr+7yWbfYV+JtzFIhGNjN2SdZHI1J7Oe0
	vDxeUhOxW8ftYfdDE3vFlor5pyUM//IcwIjwqLAd8WCyi50/Bm2ZkFvxmCMTlWJB
	Ns5ydzmOascRL9K5uFeBLNwyImv9Sf0VQEfMH9IeWBUnnZcviSM3D/H8YAnasYvD
	+vAa7lxAMUuKesX1rgAyAzc2Aj5i4LswtKbZ0pVtC/IX1QqEcaIYyBawWU5+vlmT
	gpEmAFq9HYrG3WpKW2BD9UigqTmzfcaJDcOkLTxfIPDg4Ur6xeCmpG9vYZeuiGA1
	dbFBHzgkQYRo1iwbt5vEigQZ2Mw5UP/lZxb0zOVWUKk=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.12 v4 0/3] Fix PPS channel routing
Date: Tue, 3 Dec 2024 11:29:29 +0100
Message-ID: <20241203102932.3581093-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733221772;VERSION=7982;MC=2360674769;ID=156225;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855637D61

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
Changes in v4:
* Remove blank line in S-o-b area

Francesco Dolcini (3):
  dt-bindings: net: fec: add pps channel property
  net: fec: refactor PPS channel configuration
  net: fec: make PPS channel configurable

 Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
 drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.34.1



