Return-Path: <stable+bounces-95978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB69DFF83
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3815A1623D1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03301FBC8B;
	Mon,  2 Dec 2024 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TO/cV82F"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08117156C40
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137216; cv=none; b=Y3GORBPmuU9F0LOd32Rm7LmqSeQu2Llg1TEMv3SQd6srnUCfDaq8119znBq0B8NDij9OEkkWI1zBF32xzjmbVdT4TXTYOlrfaIgXIUohe71mU0MofOSi2bZhwaT5GhEpVs1we/ERWt1H3g2q+E5gEaIv62ywzv3ibfjiE7iF2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137216; c=relaxed/simple;
	bh=lbIWNYMvSjyfLtOw1mvuOqw21VstXoAYqxbOHR064L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGA/96A7aVQWxZi5Fxj8Sa8+aM2dJtNTwAU1dYrC8uVOn/xwt5Vzj7dEL4Ky0Lq3f1I7fcVzFjs4oLcK6ErXznoBcPcU+e0qjHiYCtTAeMHa4JMytSsh1sUuj+/qKaBHwD7kvwkhJtnAsbLS9r8Wn9FOE0ydVtk7vW4Zcf9w7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TO/cV82F; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8087BA0242;
	Mon,  2 Dec 2024 12:00:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Q6wYDtIQjR5+T/DQDg0D6iro4kbT0EVZiPNUQPiaEF8=; b=
	TO/cV82FAQksNefTmleJL3UveV6C+2byr/zUJ8xewKkkicBmqtYY+o+ZWkMbnONq
	cDKmZuAef+rqr0VbcSq5evqrHpGm7JaJqHY65RwNoMDLDrxQbEU8EoD0uEaqtbwk
	JZYiAlmtVnksHor3nrXlO2Vp7lsMf5+u3C/r6qDNppK32Rj46HyDqzUJ3878UrSJ
	jwFZXEGYk/6pSK2Zn3bEKBobWSHdJrPpoEQJWXzYRBxay9IvBU9S7nOx1u65zjnB
	Vy5+96ZhzWPe1gZuYbsWikuWr2XkZy6iuTfxsfwFDy+7k34IpsyGjbwQPx3ipaP/
	AP5JSEzj3hjhhQ/c7fgJA6x19dehAQwZJWlLU+W7qnjeH5K/4CAIoQlNrfjnkoif
	2d/TPYs+sn5fj1fiX/XUIu8uoqEenqTc4DxgezD3YZm3jGX8Sw+mY3ayvmbG/669
	Mhu5MTf8rKkWe3AQpOcJv+WKpkZ/MAW0HARG8llKZ+4CGWhATHXo7ho1T9gtx0PX
	EI7oIpRZ0E5zMGQfhGjKsRwRwqwkN5Dxwa2sMA17S/1xVtsgUgL8bzjnfdRf6qpl
	kIm9Y2MO02tas9aHnafHC5tN+kK6gSz0TqDqMcRuEvnz8t+N4dXfyJUzqPrLlPdM
	/cTl7Rr8oarrehb/23/c4gnpLkELH6MJRhpXmz35O5k=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.12 0/3] Fix PPS channel routing
Date: Mon, 2 Dec 2024 11:59:57 +0100
Message-ID: <20241202110000.3454508-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733137210;VERSION=7982;MC=1981280818;ID=155695;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



