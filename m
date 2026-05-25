Return-Path: <stable+bounces-254111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ5bLTUNFGo7JQcAu9opvQ
	(envelope-from <stable+bounces-254111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:49:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AF15C807E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E6C13056956
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CE3E51FA;
	Mon, 25 May 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SEPybhqM"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0929A3E5A0A;
	Mon, 25 May 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698769; cv=none; b=kHEy0Xu9Gs3g7HSN1xOI+0bCVpfGh1gOKBpIYbm9zY7MDMMZbRtTDK28UFQ1oU9TKBtX67KfRquuDGFAIOGLKTaKG2HdLmuq/gGBLDfCE7T/ZdXgOgS+iwblVu9pifFXhy0T1lNiHwiG7eO7hhUHDTGF4pw0gmYVziM40z25HVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698769; c=relaxed/simple;
	bh=G9Tat5XVlt3hSUrqlBT9oU7ZJpYohFdZokySMUaIDIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI6UuqL7pVAxsfQthq0ZPwoeBQbXzcDCJmftxVDdpYhGMXy70Mv7sxDG1Fzng4CwTjNrU5EXEFyGz1FpbJa2bzOAJKtrLsEG0q2Yey9u9sfugxjo6VyE2XvpkxCid3Gc7TGbdg/FxWEJbPmxr+RgtE088lYnrR5dyPXhcLdyRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SEPybhqM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779698766;
	bh=G9Tat5XVlt3hSUrqlBT9oU7ZJpYohFdZokySMUaIDIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SEPybhqMb7/lv52S+LVmFGv3hBCKyhqYfsnBmONXkFqYIKPvVkvPRNQoZFL8anlzV
	 Y1hqBJfSyYsfNSip+7BJcmK7QwaG9JNPVIFb1Gq5J09QVYcTaAk/j7lNw6KPUpwuet
	 bbeQl+oLDTDknbl7Muy6sKCicTMGsU37K02KFBSv+gH7TosQytPRmtFpb+xIVfpUqJ
	 vP3lmlMtv60LT9/0DvIC+SDzDgUUBBnEBgH5QEP/MEoo2tNLveve13CXErtmo1HQqU
	 EVqP+9ICWwy5blUa9i3EPrJzDJ9NWgKgq/G3gJmFnLxAE0iUK5cH/nrmAfyixovqa3
	 cJVia8ZjQdtgw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E05D17E0CAC;
	Mon, 25 May 2026 10:46:05 +0200 (CEST)
Message-ID: <1b430dea-6d84-4ba5-845f-bdea1c0fa569@collabora.com>
Date: Mon, 25 May 2026 10:46:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt8196: Select REGMAP_MMIO for vlpckgen
To: Akari Tsuyukusa <akkun11.open@gmail.com>, mturquette@baylibre.com,
 sboyd@kernel.org, bmasney@redhat.com, matthias.bgg@gmail.com,
 wenst@chromium.org, laura.nao@collabora.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org
References: <20260522133023.355404-1-akkun11.open@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260522133023.355404-1-akkun11.open@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254111-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,baylibre.com,kernel.org,redhat.com,chromium.org,collabora.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 70AF15C807E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 15:30, Akari Tsuyukusa wrote:
> The MediaTek MT8196 vlpckgen clock driver uses
> __devm_regmap_init_mmio_clk() by devm_regmap_init_mmio(),
> which is defined in drivers/base/regmap/regmap-mmio.c.
> However, the driver's Kconfig entry does not select REGMAP_MMIO.
> This causes a linker error when REGMAP_MMIO is not enabled.
> 
> Fix this by selecting REGMAP_MMIO in the Kconfig entry.
> 
> Fixes: 2f8b3ae6f0cb ("clk: mediatek: Add MT8196 vlpckgen clock support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/clk/mediatek/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 2c09fd729bab..fd8440122ec2 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -1006,6 +1006,7 @@ config COMMON_CLK_MT8196
>   	tristate "Clock driver for MediaTek MT8196"
>   	depends on ARM64 || COMPILE_TEST
>   	select COMMON_CLK_MEDIATEK
> +	select REGMAP_MMIO
>   	default ARCH_MEDIATEK
>   	help
>   	  This driver supports MediaTek MT8196 basic clocks.


