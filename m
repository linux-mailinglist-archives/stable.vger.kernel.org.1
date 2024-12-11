Return-Path: <stable+bounces-100550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C33B9EC6B3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D11888F6B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23DF1D2B0E;
	Wed, 11 Dec 2024 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1oYG8uDZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E542A95
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904865; cv=none; b=ogQ0JEU4ZYKjdpltU9gay0F9fOJszS3EttwxDY/ZvxCB9caohs2L6pSmRqzNnhXUq4CuR96zHp2Q9iN9sh/tZFfxJ+/GozfANK0+iXqhgogmgTFCGFlH38Hbd5xhvrgfcQ0V+ACPstmOkaca+gQFUqi2Pi8RdtweU8zbM0/njrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904865; c=relaxed/simple;
	bh=pzWEefHH7KNLcVRhVvn6QG84P/MybN1OqDbsaxLw+YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0vWihDi9I2vuTRRJcfU4MiLhKWN6b/IyqTt9WfG93ae5qPXLl1Ss9dSbKzkof0/CP8GesAADUU/Xmi5lxmW3z4OK2sNBLAD/xAzKU9Fjxbrg8hEXtKL3p0H7L4Kf/+TgF1117TICUU/IlOiYH7SyaGWi1tYxx7+PCt7ShHFVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1oYG8uDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D84C4CED2;
	Wed, 11 Dec 2024 08:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904865;
	bh=pzWEefHH7KNLcVRhVvn6QG84P/MybN1OqDbsaxLw+YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1oYG8uDZG1YbD0r4fYJyhMPMgFt8HWbV8VY1DhUJSInBBXjYtFVf7Ejt3GhAVEzGn
	 vQrzig/TPcbWuLGl874LGf4mD+M14UZrgDFqWCD7BxDZFLlip/FuUsoVyzpFwU5AN8
	 MbL/5gT6ZA/BN9SvaEX9NhFE6miXAm9BCW27wo6o=
Date: Wed, 11 Dec 2024 09:13:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org, irui.wang@mediatek.com
Subject: Re: [PATCH 6.1 v2] media: mediatek: vcodec: Handle invalid decoder
 vsi
Message-ID: <2024121140-valium-strongbox-04f6@gregkh>
References: <20241207112042.748861-1-bin.lan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207112042.748861-1-bin.lan.cn@eng.windriver.com>

On Sat, Dec 07, 2024 at 07:20:42PM +0800, bin.lan.cn@eng.windriver.com wrote:
> From: Irui Wang <irui.wang@mediatek.com>
> 
> [ Upstream commit 59d438f8e02ca641c58d77e1feffa000ff809e9f ]
> 
> Handle an invalid decoder vsi in vpu_dec_init to ensure the decoder vsi
> is valid for future use.
> 
> Fixes: 590577a4e525 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Decoder Driver")
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> [ Replace mtk_vdec_err with mtk_vcodec_err to make it work on 6.1 ]
> Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
> ---
>  drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c | 6 ++++++
>  1 file changed, 6 insertions(+)

What changed from v1?

