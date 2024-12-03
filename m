Return-Path: <stable+bounces-96315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC29E1ED1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E5B2809AA
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256D1F4712;
	Tue,  3 Dec 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Txhcxy4a"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69291E4B0
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235367; cv=none; b=OeyyYJJHNNbw+lHZtZ7CPoUO3dk2cK4rFtwRy/T+hMPpFRMZLuTA0DJdtsDI8I7HUTnLBxAO/tI5EWTBPBD1YFT8R0DGPpWaGgRjiPq3/v4ok40HzEemDvQ+jN3MW44nrqrkzc1tZni5Ci7nRPivhOhIeQjuVjBlykacuMgN17E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235367; c=relaxed/simple;
	bh=tzRBKOi7nYqm9D9vCH+hmN9iYyHYhs0yEmOQ8CA++Hk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a6SFKFXY0/fdzrCvFt7QfAmymNaCgOM7IgyQsw5YiuMFKxIkGpOCi8qvu4bdtiYtKldDXdW50zBvr7Ug/XIg3VDi7aq6mJ36wbxYqTojZ02axY/sDxaaQHgGEP6qmrR9tQQ18ZD1L8GcVIqD/zAcWhmrmTt7s3L7x5A7j2Kbw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Txhcxy4a; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 3FF1CA0CF9;
	Tue,  3 Dec 2024 15:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=ro+9xHT458y73PBdep8DhosoomcfuMfHyp4+zWFlMyM=; b=
	Txhcxy4amvKW1YyOyOPzXhS89+mNNZnlIojJjhzJhPwab8ZuMX1mrokr0wUYlDUS
	U7PAVkw8G7P4u2HbzzYkp3WJTSY+7Rrz2CayTw8Umo739jwCbs+HTPCX9bcnsfRi
	xXxV9GnaghyBLm8GOtsZbJuWoc7uR/4r28HKYFZLrkWHtv0w7VjKl6/cZKJ70uRd
	3+TevlQzgMpa1OIweNFgj/ZrM/oCZqiRp4t4EtHqMTqvWTnj81EYHFMKxqcSslEx
	Yis7ZcTOpqPp+dpw+aPwB83yCPp/FbVzTwFcODkqVik8bf2zxfBKpKq36uezBJ7H
	xM40PJEmoKlIpNkNUa6YgunTtJq/QvpsBGYTyODjtOaY4ObwbVhKvWh5A8BGtxuX
	vVyBd1+ofFXYw5NT1HH9d4YPqk9tE3uXpkXLF0Y6tS6FZXUAEeK4ARe64dSRYjii
	S1ZdlIy6f5z1Shbi3cpbPUiUsuoBJlqKUv85al9WM5lxspbGF9s24f599eYd0gg0
	WaYTRqOilNefSKKT2AreMdIP2x1PT3nqKKr+r4jKFz94gU9effl1mwVxBTDp/mXW
	n/pNI/zjqcWf8xbrRIaJOZ2CroLTeXIw3dk1l+XA2u2J38KyyGNrZ+jKKyuzoJZn
	wwe4BeqNRSHisVGvZC+O5yiZ6oW4sdm5We1PwIEhXIk=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.11 v4 0/3] Fix PPS channel routing
Date: Tue, 3 Dec 2024 15:15:57 +0100
Message-ID: <20241203141600.3600561-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733235361;VERSION=7982;MC=3625444454;ID=166214;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855637D67

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



