Return-Path: <stable+bounces-69891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4970A95BA06
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 17:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25E01F23341
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7E1CB301;
	Thu, 22 Aug 2024 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="g51d7RqD"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D22C87C;
	Thu, 22 Aug 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340356; cv=fail; b=eoRrhxed09lmh3Xha0HExHYxlk+0+DBOr61oWaGc1j3wYkt007KtPL8pjkc5TcZhhXEw68ZzCovPJTFANEb7/i+G6oNSlZ9s6XzMQN1ZYnt2tHshmPYl+2QX7PPT2UF4T2AvUiIC/+2ZDQAoMG+N96Wqyz+E1cWahtzByrtIGD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340356; c=relaxed/simple;
	bh=GQX/ybtanwy/zCKjsP6vimBs4eLzBliTPuRthVsxJ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poVzxyEe2LTsyECkwnZ69/JLDT+yG5eLRU5yfXqbbxXvx4KW49wxkGznQQhS2Kuw2AWtgVpcqQjk7lIMd7tTM0HQFipwpu1dPH/C/BM2GoNqbmtTgBzDPUCpu/ufhig6jLXtVbsQW1tiLOcqD/SKj93EypHN9oE+ohpNXA7hiho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=fail (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=g51d7RqD reason="signature verification failed"; arc=fail smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: angelogioacchino.delregno@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724340346; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZVIKW3D0jI3pXHiDjuzF/3Qsfrel7O10ClTVWiviaT+b5ntpoipxlCU5mPIuGoEVV3miX18qoHEtmCm2rdUtvHQ3c9NdgrmqpRJ0CyAl+6HAUxdv1e1dkPiC7p4SRgyo6Ab5qP0IcDv6isu4bqiuczNdr+mKk988amSpZo0UFY4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724340346; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tblG4DXojNvd/Q9ZZ/KwVJ2+BRO+sDaWRSrrd7xNqI8=; 
	b=XUF4RV9FP4IRDS5Z+tmMg0rjTbsXiXjcr+bIuvJDGKzZl1bLNUUGGffCB5EBA3V6960sP0WDQInxdud4ag87ryD845+s/WjJLoaHwvL3Xha2qZv10ISdI8AIxylalSZZTLCWs7CZN7K7R836P+LkN7mmhR8iI2lAiciL9wp1diY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724340346;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=tblG4DXojNvd/Q9ZZ/KwVJ2+BRO+sDaWRSrrd7xNqI8=;
	b=g51d7RqD0veQjp5+KVKELwE+jm750mEPW6lk9pQPkDI/tNQWRXDwApIv3YMtlNT0
	atmq+fEVY6o9uDAjHtvmS9QpmHBG/utJlrJJbdz7kYqeoEI1u4tjR53AoAqYTRC9Lyn
	EGaKf/GVoT3MvcRwnNCAsWvZLPMUesJ2w/BHPU8Q=
Received: by mx.zohomail.com with SMTPS id 1724340344652491.77049766479;
	Thu, 22 Aug 2024 08:25:44 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:25:42 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Stephen Boyd <swboyd@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186-corsola: Disable DPI
 display interface
Message-ID: <00aaa8ff-1344-48dd-b0cb-5e8f4518ff6b@notapiano>
References: <20240821042836.2631815-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821042836.2631815-1-wenst@chromium.org>
X-ZohoMailClient: External

On Wed, Aug 21, 2024 at 12:28:34PM +0800, Chen-Yu Tsai wrote:
> The DPI display interface feeds the external display pipeline. However
> the pipeline representation is currently incomplete. Efforts are still
> under way to come up with a way to represent the "creative" repurposing
> of the DP bridge chip's internal output mux, which is meant to support
> USB type-C orientation changes, to output to one of two type-C ports.
> 
> Until that is finalized, the external display can't be fully described,
> and thus won't work. Even worse, the half complete graph potentially
> confuses the OS, breaking the internal display as well.
> 
> Disable the external display interface across the whole Corsola family
> until the DP / USB Type-C muxing graph binding is ready.
> 
> Reported-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Closes: https://lore.kernel.org/linux-mediatek/38a703a9-6efb-456a-a248-1dd3687e526d@gmail.com/
> Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Would be good to have Alper verify that with this change the internal display
works again in their specific setup, although this change seems reasonable to me
either way.

Thanks,
Nícolas

