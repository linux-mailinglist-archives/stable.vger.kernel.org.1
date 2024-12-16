Return-Path: <stable+bounces-104326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898069F2EEB
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF827A1A67
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533D204561;
	Mon, 16 Dec 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z9xq+i5x"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187B204587;
	Mon, 16 Dec 2024 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347494; cv=none; b=aX+LFYzLSWSbz4Ym1TzZaDFqWj9HtqoE5ICNifUIpxHOSdA0JIW9BqYvX9sO+gc5gmV8XM1D2NqQ1o2K2e0YjD7N/JU0xJkSBdSOwfgQzF1rAtxZyXS3gZm+8hb0+CZfnbihUGGoRaQUZYwxVROxTofruY3ko01fMLupTxTygf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347494; c=relaxed/simple;
	bh=9FtWM9F33hvv9T4AE+nNxA94QLDsh/3495wx1tvpwyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZTShbfv3ScXllfLnrHCJWB94nXKCFs8HR97YhdnC531uo3oNLji74wFbvgL9i2KozXMyN2ZOL6cVCWYA2C2WWflVyjbUIxvWrJBrLS59X/fEhMJ38P11NRFmVkXRjlJhitIcLY7EELOT6wnl0Fau4YDxPfDrE4BOB3JLHWC99BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z9xq+i5x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734347490;
	bh=9FtWM9F33hvv9T4AE+nNxA94QLDsh/3495wx1tvpwyI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Z9xq+i5xhImHLW55YgRgyEM7IxDe+HmaSOrf0Zsc0OGHHFQUa0zpFwMALNHsBpZvx
	 fW3WVEjFFWkfTxL4yAF0SBxbn+Bv9U6GjmnTtRACleNMQFr+7yrKBZI1M2uvfvroap
	 KlhtHqNj4Mjar6nNVz2TGvz/MT7HEuqOiHXj/3Zqg9ho4Pqwr3/G3C2CyyNJle4Hgn
	 YhpxTsAddiSSs3Zc5WklrygwBJUEf2i4dAIlfWbGcXOnAMqIJhdNZ4hXh10YKH96PD
	 QovxEt34OTdZqKkMRsrM/xtqCC97tt4FMHjsHRvi8BunwIbL/HjFN/rEDWQ+KA+aQy
	 C/Ao+3IuatAzQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E3BF817E3634;
	Mon, 16 Dec 2024 12:11:29 +0100 (CET)
Message-ID: <adb6356b-19ea-4350-a691-3487d42c9fe2@collabora.com>
Date: Mon, 16 Dec 2024 12:11:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: only touch DISP_REG_OVL_PITCH_MSB if AFBC
 is supported
To: Daniel Golle <daniel@makrotopia.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Justin Green <greenjustin@chromium.org>,
 Frank Wunderlich <frank-w@public-files.de>, John Crispin <john@phrozen.org>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <8c001c8e70d93d64d3ee6bf7dc5078d2783d4e32.1734300345.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <8c001c8e70d93d64d3ee6bf7dc5078d2783d4e32.1734300345.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/12/24 23:09, Daniel Golle ha scritto:
> Touching DISP_REG_OVL_PITCH_MSB leads to video overlay on MT2701, MT7623N
> and probably other older SoCs being broken.
> 
> Only touching it on hardware which actually supports AFBC like it was
> before commit c410fa9b07c3 ("drm/mediatek: Add AFBC support to Mediatek
> DRM driver") fixes it.
> 
> Fixes: c410fa9b07c3 ("drm/mediatek: Add AFBC support to Mediatek DRM driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index f731d4fbe8b6..321b40a387cd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -545,7 +545,7 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
>   				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
>   		mtk_ddp_write_relaxed(cmdq_pkt, hdr_pitch, &ovl->cmdq_reg, ovl->regs,
>   				      DISP_REG_OVL_HDR_PITCH(ovl, idx));
> -	} else {
> +	} else if (ovl->data->supports_afbc) {
>   		mtk_ddp_write_relaxed(cmdq_pkt,
>   				      overlay_pitch.split_pitch.msb,
>   				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));

At this point you should just move the block over a new function....

if (ovl->data->supports_afbc)
	mtk_ovl_afbc_layer_config(ovl, cmdq_pkt, idx, is_afbc);

static void mtk_ovl_afbc_layer_config( .... )
{
	if (is_afbc) {
		.....
	} else {
		.....
	}
}

Cheers,
Angelo

