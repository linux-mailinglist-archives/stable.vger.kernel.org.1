Return-Path: <stable+bounces-96117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F369E07BB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8887F280A8B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD52813632B;
	Mon,  2 Dec 2024 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oWRvZiry"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0B134AC
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155085; cv=none; b=MQOe+hcbR0qjZ0u6rldQI+PlVUbe78WwRTg6dLMGG9lC99WPILNkgw5zCPkN1Hde5Odusor8dCTsy/bPvKbhJSF0h/F+6h6q2sBVY5aeVTPt9CeXPalzv6u0MxUhRvhPgt46ApKpUJYIC2+Ad92ATY94/sveaa5Uyq/LCg4XRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155085; c=relaxed/simple;
	bh=yWFq+Poe5+N66thnGMSozM+ZhNaYMnx6L/VBZhX+XB4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uPLEh93E8cQY6haMz066owz4qH/yo4kxqGoGMzfyRnWWyQadUC33obnqsuM1kBXsD84N46FuPCYN8a/PAe1/40n1pk9IfjyRmoq5jjnA3pRy0ikiFy2/D0HW0rFRWe/Cu39Aa73X00XStuKVDRx/F0yVc3S8cvb6oUCmT2We/fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oWRvZiry; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 33588A06EB;
	Mon,  2 Dec 2024 16:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=3bEWoIa3XLMJ6jUI1yRMUgzskV81OmI43xN+QSpepsY=; b=
	oWRvZiry1G5GlzcrILbKPxE6z5vdjRr2bCnEOKbtUu7JbLfKC1REfmhCiojfPnn0
	9hvSNZSDiDzvuUUdHYGX6rbJH4ppk0awX0TFCC/oY5IHpIYtD9lng3g7XvgnyC80
	mfvMBIWJA5W1TfBEFrgEzTW0yRRv8ER8Xmoow/zdbPUUlD0fJkCO3LK/q6sWpmbL
	6On40fpgId4UNlk2i+NIccJPgNmQRMQl87sT+YbWMsKCpcrWWe6NTGAAqh6IuXpo
	xNvuIxuPYkemPaVn1hSMOeSo4LEo+LVurGJ1Ys9JIjZ1i3yA1dxjE0KXp3m0COlh
	1U7zHeYH8ak475Yy7ShvAk0KL42QuhokZho/IvMsJpns/Y5DfpALb1Wzuol837Ah
	wnmHt6f642BBHLFPNyqZ0PpwMOTX8pZHZEqdmTYzniP4/EdrSwS52iw2aRyTihQk
	2/ADLNOv10gTRDzWwEXPW3GH4txAb8Cx+lZxnPz31MVMQvbV358YKAoIbXEUqWyy
	J4cAqn1Kx9KcM3YHuP5EKJxjeqrRg4A7BnAVt2Yk8TXs7EuawMQCSi20/8cjqKii
	EonERunHIoDPW8Njsnphn6JE8nG74Rrj7I4UcXHKHPWkd2v5RM5yREqO7DtY4iOD
	lqOvSXXzgXb5AWTrAIADwzuHvL5K9NZJSsxL1AqWTSI=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.12 v3 0/3] Fix PPS channel routing
Date: Mon, 2 Dec 2024 16:57:57 +0100
Message-ID: <20241202155800.3564611-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733155081;VERSION=7982;MC=1767346016;ID=157282;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



