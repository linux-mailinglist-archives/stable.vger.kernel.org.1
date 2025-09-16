Return-Path: <stable+bounces-179716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20DFB5959B
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 13:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04CA322C68
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 11:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD72F2902;
	Tue, 16 Sep 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="atM7F/NV"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EB4307ACC;
	Tue, 16 Sep 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758023707; cv=none; b=V0lNAjm8G8Yn/scuIW/GFWpGTtc+nTfSZMtWsP7V9GP46QXTrDz5y/90AxRrNUbfhRjaPmEyNs2TVXhLtg/6HYyr8NWWXE1o78LqnU+SiPI49u/k0Q05PJ9N6m/DdihNWMIhqP/81txZ64UcWAzguFeffreAgWDLkU+SZ9O6eAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758023707; c=relaxed/simple;
	bh=Fdt+WsydTPvGmJTKMBjBVMdXBGFU6PliCLKixaPKnhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7QYAWH8X7d4s9520hz5+xTk0Og1Mlnh7fBle+NDxCjKzeP30+ierq13gCzHGhyTQyJTRYyE30isvKzh0H/GXxWU6qGojtiuB2I0BMGSFohTKYyc8PvsKJzrHfJPf4/8Qz0qb09S/sF12B93VwPrudm7XVXNELTVxRpFAp4z4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=atM7F/NV; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9BnqEj9RHHv7quzPDQGpxHMHL8zNwveBfzJJlOw44Vo=; t=1758023705;
	x=1758455705; b=atM7F/NVIIO0hza0cynMotMSb/unPJXwkn9roSteflcxTXv35nsCzp5Ps52Sz
	cJUWPZqGa8PxTvsufuiN/KZ67i/ch7E/irNSvkQchWsUgTDkvSrI9B4syA9umW7rr5WaUcB0FfmFF
	uLML3/vb1Ire+gjqpHzyNTlWnVY3nj6YB4PdkjzjtG3+pRZvhnWBOqY6YB1vMpWFmKAVPS1IoMskK
	PogmVYJ0lY6Z4v8N1KSFMSuViLKWbdA7YcmRKu73P67I2oc2Nx3x1WANBxE/rXBdIHOwWfokExj2B
	3AqQqqH4qZf8CQmlPukK32RytftNXneZ1UmmM90K4Z0CMRrP5w==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1uyUGt-001mgL-0H;
	Tue, 16 Sep 2025 13:54:55 +0200
Message-ID: <26bc2a33-2a45-468c-a3c1-6ef2ed414f44@leemhuis.info>
Date: Tue, 16 Sep 2025 13:54:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.16 fae58d0155 prevents boot of google-tomato
 (mt8195)
To: ninelore <9l@9lo.re>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
References: <QwcOPAuQZfqo0I9EwUu4tVCuhXRvtfAgFZ7Hq896xRKosseOz3wvuKJFV1YLUTTTwMANMW6bZPUfLwXQPPgBFiYEzKUjMGZ5D56349pz4m8=@9lo.re>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <QwcOPAuQZfqo0I9EwUu4tVCuhXRvtfAgFZ7Hq896xRKosseOz3wvuKJFV1YLUTTTwMANMW6bZPUfLwXQPPgBFiYEzKUjMGZ5D56349pz4m8=@9lo.re>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1758023705;dbe6d3b8;
X-HE-SMSGID: 1uyUGt-001mgL-0H

Lo!

On 16.09.25 01:22, ninelore wrote:
> 
> starting with the bisected commit
> fae58d0155a979a8c414bbc12db09dd4b2f910d0 ("[v2] drm/mediatek: Fix
> device/node reference count leaks in mtk_drm_get_all_drm_priv") on
> 6.16.y my chromebook codenamed google-tomato with the SoC MT8195
> seems to hang while initializing drm. Kernel messages over serial
> show CPU stalls some minutes later. I am attaching the full kernel
> logs below.
> 
> This issue is present in 6.16.7, however not in v6.17-rc6

A problem caused by the upstream commit of the change you mentioned
above was fixed for v6.17-rc6, see 4de37a48b6b58f ("drm/mediatek: fix
potential OF node use-after-free") or
https://lore.kernel.org/all/20250829090345.21075-2-johan@kernel.org/

I wonder if that might fix your problem. It's currently scheduled to be
included in the next 6.16.y release.

Ciao, Thorsten

