Return-Path: <stable+bounces-96222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138B9E16D8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3EE16479E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309A1DED53;
	Tue,  3 Dec 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MjzWsLPZ"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D11CD204;
	Tue,  3 Dec 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217087; cv=none; b=aiGR/7Fk7+6Trj3EwUzDVhnfLM8rIBLCXf4anrcUsp54KakwRqAr1A3/Why4eLOEzJVplmQUttp1hfKoiFYrV+C8bYxAXXGzJC8flRo3GLEEu/vqE+/NcHhuQ6j9mhKF+dapIx+BLA06WbJpCn7l0q2/zdOxOXg8ASVamDIS1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217087; c=relaxed/simple;
	bh=JeOaPTPE3XyoYu5PdVQ2W1gB197DwY27Ozt4mP2oI1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ad8FaeeDeKaXGGP6hnddJDAZFA0L/ky+ZxgPz6OZExEXxn0ORj1oazU0y08OKwKbeqpPTtwFITFzTyKpJWo5ZUcg2Gfx11BAAAW9eR3yUKv4S/CTWnqU8bBnRXG01Dyj/6zaCG5cVVQaR8XvcyZOM2L1WmRunsJ8oFrEpHqJDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MjzWsLPZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733217083;
	bh=JeOaPTPE3XyoYu5PdVQ2W1gB197DwY27Ozt4mP2oI1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MjzWsLPZ9awEQUPLnw7uptgfrVQdttYqvZWBxTx0f/yC3kM5ZSZZt1B7kYi+hKDqC
	 PFjTN0miZUadRd+Lj4cc54gzLNXRH7TFCvoORAcRirowLT6f7SShqmHtwROoq6sbBb
	 5pgDuifRd7jdNEi6exDnnE1qLZw2feo5/ipR7TpiFqP64kd1BdTsFJMPVMIWpRt5Bo
	 xJLWzSOJniT+H0fMtGzSbPX4O6mXCggZCBVGUACqkGvhvkxW40fuUImsMBkCszqF22
	 0sFrtQ3F/BxWKntAKbgOIDO94jbXILugzshUX9On67A6cR99UK5wa2pDZ6LQCqu9qT
	 Z7FMktO8m1f5A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 050B717E14EA;
	Tue,  3 Dec 2024 10:11:22 +0100 (CET)
Message-ID: <c87a8f9b-56fb-4b4d-9ba6-07f322faf061@collabora.com>
Date: Tue, 3 Dec 2024 10:11:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 1/2] Revert "arm64: dts: mediatek: mt8195-cherry: Mark
 USB 3.0 on xhci1 as disabled"
To: Chen-Yu Tsai <wenst@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Koichiro Den <koichiro.den@canonical.com>
References: <20241202081624.156285-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202081624.156285-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 09:16, Chen-Yu Tsai ha scritto:
> This reverts commit edca00ad79aa1dfd1b88ace1df1e9dfa21a3026f.
> 
> The hunk was applied to the wrong device node when the commit was
> backported to the 6.1 stable branch.
> 
> Revert it to re-do the backport correctly.
> 
> Reported-by: Koichiro Den <koichiro.den@canonical.com>
> Closes: https://lore.kernel.org/stable/6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw/
> Fixes: edca00ad79aa ("arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



