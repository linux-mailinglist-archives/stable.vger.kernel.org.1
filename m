Return-Path: <stable+bounces-104011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B970E9F0AFF
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D677B162219
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F051DE4E5;
	Fri, 13 Dec 2024 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="sP9BYBcf"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F721DDA39
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089399; cv=none; b=NmGbu6lJ0znr8zwdF85FwAYkPMAdgi4pPCIwLFLd0yWuR12w7CybvjmWGq9eJhXTo7XGUfWyOzSwYe/c68a5jlv2FIv/osMhccTCGC2Yo7hMLdnbMSNIAAsC/RFY3CjWgkEV+tIjKGE5xmGQai39nWKlwAYb3VKnZCQS9Ef5WHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089399; c=relaxed/simple;
	bh=lbIWNYMvSjyfLtOw1mvuOqw21VstXoAYqxbOHR064L0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+w5KpQAtbxKrA23lHMh7VKCEHlUFL+6qAGp7aQXJJNeoFzElpO4d7bxEmjiese1RzCQMbCWz4DwIjo6gKi9oTPU3t88xyVEAfafcZEOQiLRssOub1EsngH+Lb3iuLjuXnKb0YQI3pyE6/lD8jQmJicAWuFWI3+1JaUPNrRPgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=sP9BYBcf; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 98018A0580;
	Fri, 13 Dec 2024 12:29:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=Q6wYDtIQjR5+T/DQDg0D6iro4kbT0EVZiPNUQPiaEF8=; b=
	sP9BYBcfCIeZgfMgbxXttELaWU63rpIrJhRcGDZonGNwc0gujhSoLMs/K0gdtXL6
	u9g85sOINRQjkw00sANRD+2DyOWRU7OiUVFQSgMCFzTbonNo+6QdJHQp4RdOhy3+
	TTWw+D0SZH4M+K+xQ/22nTz8PrsVs2aERtOrGVbxSiTpWZjAL3Sxy2vUrVo8sWTQ
	9KZpVTJzpwQyfVvDuCj86yZMtDExmmDLvIGtVBbn5Fa+yvtxEAtkXu2CJ7yJyymn
	oXqq8cJa/0B7MUynTvdnJjMdo/oAnQ1MD7zoKLf2po3Jgzeod1bf6TyyFI8OkBDC
	zPWRqNLYuPm+zV6v3TIyXpzznB1A3aBlThfNzXl2nzfVqxocJokFFOWO134/4jaj
	7DM3UUfCa9TCkvDwKrGvJzWSovSl/PWn84bYzr5QESbvr0Fd2WxX//upnqM//1RF
	x4PjCXqkPf4YypEVjkUP03dsoS7N+WSnED9821GIX+TGTl3MwYFUafOtJ38ranry
	F2Lxdj4ouAa91tfSvjkC3F7T2Xe8KHOe65q4U4fcQ3w0Odl6oplREs1XrS6XGxs0
	cB8l0RMckkJJ6Or8NEa6FsuMRKoLEnAkXyysLTeC+e/3kBqxHPH6dRIBxhen1xBz
	oSSqB1fJxaG7pUVZt9d/eVbXBUMX6crlLQ+IbOF8RdQ=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.6 resubmit 0/3] Fix PPS channel routing
Date: Fri, 13 Dec 2024 12:29:18 +0100
Message-ID: <20241213112926.44468-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734089385;VERSION=7982;MC=2178798899;ID=408615;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855627C65

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



