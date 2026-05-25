Return-Path: <stable+bounces-254055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBC7FcuqE2q8EgcAu9opvQ
	(envelope-from <stable+bounces-254055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 03:50:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B275C546A
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 03:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB823008764
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 01:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A824258EE9;
	Mon, 25 May 2026 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jj268jkF"
X-Original-To: stable@vger.kernel.org
Received: from mail-m32124.qiye.163.com (mail-m32124.qiye.163.com [220.197.32.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EA125AA;
	Mon, 25 May 2026 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673796; cv=none; b=USSuzp9vuhYBddHxkvmu4+MIOlNC+C1hixH3kHOnx6A0qW9eLP/ZyYQN0iFXtADwFghxckbxjoaPwtO95TV98d/uCTaH/isjRmvxYNNKpJDy3kth4mnbPMsTP7b8t85iUQgJyquGUjHLN7YBnJQXd9nmDST23Of8/FA9y7Ku3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673796; c=relaxed/simple;
	bh=AROHQ9otRzJxsT4N3jTTBbwPHMEc9Bj7pUXaLI+pUCI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mEm8m0hi1INKnpchuW9gl/5uukqI2IConXsHlNApui7DPSRcP/ch/G1JSR2e0iW4zBe5S12ODgCPxuMU2eUVJQrgOPazYpnf5/w3shj/9T2DBSeRowTHIDbwUTSBmr5tgz1+UuSuGuQ9bYz9PpXpDhAi8sydv/eg/co59TDRGyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jj268jkF; arc=none smtp.client-ip=220.197.32.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3fa1a865a;
	Mon, 25 May 2026 09:44:32 +0800 (GMT+08:00)
Message-ID: <41863f57-3911-48b7-8a6b-11f877b982a8@rock-chips.com>
Date: Mon, 25 May 2026 09:44:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Add missing private data for very
 old controllers
To: Heiko Stuebner <heiko@sntech.de>, ulfh@kernel.org, jh80.chung@samsung.com
References: <20260522184307.2979579-1-heiko@sntech.de>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260522184307.2979579-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e5cce1cb309cckunm290c57cce95c2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTkweVkNMGR1DQk5JGUxDHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jj268jkFHMoTIsiOtgqq9u0y0urwFy4t48maGZDE2qh2OqIXJryXcryFPY9s1GioHPCBPkOFsug9lJNJv+Ta9AfaHnrIRjsALv9lwnxqtq0Vr1z0vixqhMogPEYCW6JKwD6uLmtGilMlK0jmhMM+KcP/+bs4/hOCKTkEBLP7OWo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=w7sucLlFPpFoBQBCSVha1cyDgINh3mIbBw2+BnctLfQ=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254055-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B0B275C546A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/05/23 星期六 2:43, Heiko Stuebner 写道:
> The really old controllers (rk2928, rk3066, rk3188) do not support UHS
> speeds at all, and thus never handled phase data.
> 
> For that reason it never had a parse_dt callback and no driver private
> data at all.
> 
> Commit ff6f0286c896 ("mmc: dw_mmc-rockchip: Add memory clock auto-gating
> support") makes the private data sort of mandatory, because the init
> function checks whether phases are configured internally or through the
> clock controller.
> 
> This results in the old SoCs then experiencing NULL-pointer dereferences
> when they try to access that private-data struct.
> 
> While we could have if (priv) conditionals in all places, it's way less
> cluttery to just give the old types their private-data struct.

Thanks for fixing this.

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Fixes: ff6f0286c896 ("mmc: dw_mmc-rockchip: Add memory clock auto-gating support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/mmc/host/dw_mmc-rockchip.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index c6eece4ec3fd..75c82ff20f17 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -441,6 +441,22 @@ static int dw_mci_common_parse_dt(struct dw_mci *host)
>   	return 0;
>   }
>   
> +static int dw_mci_rk2928_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_rockchip_priv_data *priv;
> +	int err;
> +
> +	err = dw_mci_common_parse_dt(host);
> +	if (err)
> +		return err;
> +
> +	priv = host->priv;
> +
> +	priv->internal_phase = false;
> +
> +	return 0;
> +}
> +
>   static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>   {
>   	struct dw_mci_rockchip_priv_data *priv;
> @@ -514,6 +530,7 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>   
>   static const struct dw_mci_drv_data rk2928_drv_data = {
>   	.init			= dw_mci_rockchip_init,
> +	.parse_dt		= dw_mci_rk2928_parse_dt,
>   };
>   
>   static const struct dw_mci_drv_data rk3288_drv_data = {


