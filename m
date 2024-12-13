Return-Path: <stable+bounces-104013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11219F0B01
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C177A1622DF
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268CE1DED4E;
	Fri, 13 Dec 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mNK4SP61"
X-Original-To: stable@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B71DE882
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089402; cv=none; b=jZ6S8m+5cevHdttZIcboX+ZcYUBf9H4qXmJhhjuTlNHqfcf+ZeTBdJP+a1tKgSY8JsHZPTXQ93d4WnLzeSxFJ5lq858w7gCOXj88iECfOORf4Ts0c/AHDoq1MoSgXdPk1P7G7C1FtpyroCAzVn5sEwIUO6CVheuCxnRDmRBsaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089402; c=relaxed/simple;
	bh=tzRBKOi7nYqm9D9vCH+hmN9iYyHYhs0yEmOQ8CA++Hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0zJhiPS04HcoDEbqMYbo6n5iJb5KapT7QHZKgP9ZcGnXYu6yyAd+8s3DMZbvdP+vnNHiFAS9Z4pT/jy2VEisKJPSdf4YH8YCrrylw/nwKEhriLAJy8BtxIauTMN+ktvB0/ANTI9ZONN9FdiYNqTModQNLsa8T5cYTuKdyAo4g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mNK4SP61; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7547BA0B5F;
	Fri, 13 Dec 2024 12:29:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ro+9xHT458y73PBdep8D
	hosoomcfuMfHyp4+zWFlMyM=; b=mNK4SP61BZmOyssgGBZpS2VySCP9WB7LN4b5
	Ed0Z76VHXH6BoOaT7eV0isJKg5FCqfGggEZxu4tebCwuCisHq6C7xOqN6QGwAKef
	AXBeXO621aW/bqxfKgUc970vkiKF7GdPfQUdoP8XozhH7Ke+s1aLXY7Kkrq3iIiE
	NS9kW15Gm4T7+T4JW4+jtzrn6qB0q2x30YZtw9s5R9vT9GUdG3HNWU+ewAVkPNRv
	tEb/+Zh4SncwdEmfv24HVeA+x2F7/ewisjlMGL6eTFUNmBZkt8PUr0Tua51G/jCk
	wVqifH2NI3/x3yPGa0GcKEpihGxogWtuZZuHZakI9wBcTPFLaGWw+Ak86G18QrIo
	4y36TSwVaRVs0FhWHGw+124X+hnYcowryl5r5FtZbzv3MOyr9fZ6vBykLs7nnAvu
	IrsplInJ93qatBLoVDIak//ItryVkrnGAzFPXsiIIMF5GHm2tlsqlLj1d1mzkczP
	K1ga7BniaZK0W34VT2Gc1xEaHiG8ihbFHxrjC3nCJ4RgalQ2AcL8vNZmjnlkeM6H
	nwYTTHNPPBvieHgAJB48XjQKe2QD6MIZarit/2oBs/XeBgVF18QoWq4cwY6Pgh1G
	8nLCbm4p5oJfvT7CySBbL2abD7gCIwRIG/9ZMcNr+FdWhFvxzq70v3ckMxE4YHmU
	cqfB610=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <stable@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Sasha
 Levin" <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 6.11 v4 0/3] Fix PPS channel routing
Date: Fri, 13 Dec 2024 12:29:23 +0100
Message-ID: <20241213112926.44468-5-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213112926.44468-1-csokas.bence@prolan.hu>
References: <20241213112926.44468-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734089398;VERSION=7982;MC=516544876;ID=408619;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
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



