Return-Path: <stable+bounces-206120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 759AACFD5D2
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 12:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9362330DC321
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 11:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906D309DDB;
	Wed,  7 Jan 2026 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T7Ip54GU"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD632FFFB5;
	Wed,  7 Jan 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767784382; cv=none; b=ckn2gbeYnxVbVBAX3/VDgUn0w0weoDpnYAy6TpkUJfKBAPROIQav3yyBN1nMLW1FYWajHQi9zITSKJa7As5v+tbufPtwy+6D9HtQDCJmpjMGNMrcD0a/nye76m7PxgpzoX2lnwMEJE39U4JVq5ZMQ4nX5es7f2ejJPCzF9YCchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767784382; c=relaxed/simple;
	bh=tRXiOfA7dWZ+z0O68giSqWYtkx5S1jkN9DmnV3vzdbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+8DDFBaMsmgK4Vg760ZTSEzJxVKT3PlWXjrwQCrR7YAwpX1hGGBvEV1A6MY6olf0fqBtdVnatxTHA0I21gRbJNy4DNMlB+h5x7JGeDAll4ev3OFMqvc7snx+DBWGUxYfrJuLMdbMjYKWxFJ8/W2dRD5AYCjbNGZtM+fERzJy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T7Ip54GU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1767784379;
	bh=tRXiOfA7dWZ+z0O68giSqWYtkx5S1jkN9DmnV3vzdbg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T7Ip54GUBPEchIoObBEd3RD5bp27C7PVo9puP+fCDWsihgk74uvlFkRHbA3KDRXZr
	 jkUswTcYI7H09p0FDjzBGX2VTMuBowqvTQFY7EWCdfMkgvQ+BvTOymUHv1XBx1u21P
	 vvj5D4wXqiYEuC/ByCtxMK0AQvFh65yDIr6+YjTmDtOwEma5wOCpK4CMdrUSjg2rzS
	 fMYRtE0HCwRgUAi5L/c1U6ztaGgCaCwg5WqhfaL1yo0IOR+kGAx7AlXypFtvnaevOo
	 51wn+wMj7a7HJMFbIkABid6rTJSw077ivNkdkwpbRrSkhm1lfbKDJAGBYTf2dP/2S/
	 T8mcaolYV4edQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C045517E1534;
	Wed,  7 Jan 2026 12:12:58 +0100 (CET)
Message-ID: <c3a8ab2d-5c38-4e1c-b13b-b34517c337fc@collabora.com>
Date: Wed, 7 Jan 2026 12:12:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: Drop __initconst from gates
To: Sjoerd Simons <sjoerd@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Laura Nao <laura.nao@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, stable@vger.kernel.org
References: <20251223-mtk-gate-v1-1-e4a489ab33de@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251223-mtk-gate-v1-1-e4a489ab33de@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/12/25 12:05, Sjoerd Simons ha scritto:
> Since commit 8ceff24a754a ("clk: mediatek: clk-gate: Refactor
> mtk_clk_register_gate to use mtk_gate struct") the mtk_gate structs
> are no longer just used for initialization/registration, but also at
> runtime. So drop __initconst annotations.
> 
> Fixes: 8ceff24a754a ("clk: mediatek: clk-gate: Refactor mtk_clk_register_gate to use mtk_gate struct")
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


