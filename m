Return-Path: <stable+bounces-116685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DB4A396B5
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 10:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C7D3B7DA4
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1709822D4E5;
	Tue, 18 Feb 2025 09:03:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C743231CB0
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869435; cv=none; b=hYY7jQbcmqQWSGGQJu7e7hk/XhE7uh0ufZQWe58gSV8ceZUwXNvf8gfD7kEPBmrTxC3IfQR6p6wf7ivC/+kmsWlIAPzh8nqXhM7OUArdbeV9DN1ERF5fkXlXsuZH9eUxKFPJyOGDOlyCAkoluap+HTLWYVBNUgMsjn8r+4foM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869435; c=relaxed/simple;
	bh=Rb/oEzPquB0AN3zNExVOUPkHhu2SKGcn8YilK2l8ikA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ufo4KsEQVsNodcYG7B6bL369Kt+8TFEaMcPCa/WVVgFQ9u0S78FWQtQlY0riZySqsqBaUOQhJOoC7j85q3LlRdhh9RXuzv3OREIkUuvU/8vqjYkePNKtjuRM8tcDUQv6jToNuELZJQyaK0N+Ha9zGo94MK0kELY8zvCmGBgDNrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tkJVw-0005iJ-9J; Tue, 18 Feb 2025 10:03:36 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tkJVv-001YXQ-2k;
	Tue, 18 Feb 2025 10:03:35 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tkJVv-0002g6-2W;
	Tue, 18 Feb 2025 10:03:35 +0100
Message-ID: <15bbca6567ff640fdcfbe1a9525989887a94732c.camel@pengutronix.de>
Subject: Re: [PATCH v2] media: verisilicon: Fix AV1 decoder clock frequency
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>,  Heiko Stuebner <heiko@sntech.de>, Hans Verkuil
 <hverkuil@xs4all.nl>
Cc: linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, kernel@collabora.com,  stable@vger.kernel.org
Date: Tue, 18 Feb 2025 10:03:35 +0100
In-Reply-To: <20250217-b4-hantro-av1-clock-rate-v2-1-e179fad52641@collabora.com>
References: 
	<20250217-b4-hantro-av1-clock-rate-v2-1-e179fad52641@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Mo, 2025-02-17 at 16:46 -0500, Nicolas Dufresne wrote:
> The desired clock frequency was correctly set to 400MHz in the device tre=
e
> but was lowered by the driver to 300MHz breaking 4K 60Hz content playback=
.
> Fix the issue by removing the driver call to clk_set_rate(), which reduce
> the amount of board specific code.
>=20
> Fixes: 003afda97c65 ("media: verisilicon: Enable AV1 decoder on rk3588")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

I was going to ask whether there might be any device trees without the
assigned-clock-rates around that this patch could break, but the DT
node was introduced with 400 MHz clock setting in the initial commit
dd6dc0c4c126 ("arm64: dts: rockchip: Add AV1 decoder node to rk3588s").

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

