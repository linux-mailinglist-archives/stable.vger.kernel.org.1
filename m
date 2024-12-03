Return-Path: <stable+bounces-96223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6359E17B7
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCE09B397C0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB501DF976;
	Tue,  3 Dec 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mGEs87q1"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCED1DED75;
	Tue,  3 Dec 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217089; cv=none; b=lgEcl/UW6bqzcJ+ASfqQq/piKFpA2JODs/SiH+QVAMe7jJyovXybAQtmscMMHXneDFe3SALfxkVk8OuUXXNq5ujmMv/iMU7+U4eHXCDMmtXHUexkDoKNlPUjZiMzWvSfYiI8GOYsfdxmxQRPCShDf8XpcXfUjGpnTeyz+DDgvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217089; c=relaxed/simple;
	bh=dpObWXpZ7p2t1DkUkX1XSldL6Hubf+emdmqzZJsu1lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2FXms02YQXCmohUthGdzfi0JKfKD/TUhP4H/UVqjweX+tRcMVxDoiaIMSLWY759TXVxnOS3OCsduFoKNcyHVbrKUII8Fqug5yRAK/VBd9oHUnkP25QytiZmYj6eAJZ5HglX7cuEF/4udEtrwMq14u03FmfomZhbD787w3OUAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mGEs87q1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733217085;
	bh=dpObWXpZ7p2t1DkUkX1XSldL6Hubf+emdmqzZJsu1lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mGEs87q1wVNvZKeqVer2Da0vnX/ygXCpdkPWthXdXpyjpfytoXtbESuhX+pUtH8T6
	 lAatLMX5wmHyTSIi76i3WIBKZqPd9X56yf8shM3wqEuw+pt02BSmzeWzwgjaSh0LLy
	 qstAg8enqn58xXhKyu11gvB/GJzAcMEbFysg+anU9gdFMSyqw3XYQ5PB4kmDm+k0s8
	 6KnYPsMz29u5kqSJf1O54ebzGZQ+/vc8HQFhtG6S3WRmTHwiOUDn49nnp6wDBBLrh2
	 4ASRv8LHLkzhQ94bjthjR7EBWCl7J9fhvuxpaqutN661sRHqZ+RWSd+w+PwnYE6R9i
	 1J4UCQlxCEQRQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C343517E35CB;
	Tue,  3 Dec 2024 10:11:24 +0100 (CET)
Message-ID: <b1f2944d-5c11-4842-a2b0-02044ebece98@collabora.com>
Date: Tue, 3 Dec 2024 10:11:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 1/2] Revert "arm64: dts: mediatek: mt8195-cherry: Mark
 USB 3.0 on xhci1 as disabled"
To: Chen-Yu Tsai <wenst@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Koichiro Den <koichiro.den@canonical.com>
References: <20241202081552.156183-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202081552.156183-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 09:15, Chen-Yu Tsai ha scritto:
> This reverts commit 090386dbedbc2f099c44a0136eb8eb8713930072.
> 
> The hunk was applied to the wrong device node when the commit was
> backported to the 6.6 stable branch.
> 
> Revert it to re-do the backport correctly.
> 
> Reported-by: Koichiro Den <koichiro.den@canonical.com>
> Closes: https://lore.kernel.org/stable/6itvivhxbjlpky5hn6x2hmc3kzz4regcvmsk226t6ippjad7yk@26xug5lrdqdw/
> Fixes: 090386dbedbc ("arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



