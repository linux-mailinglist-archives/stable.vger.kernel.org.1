Return-Path: <stable+bounces-73127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9396CDFC
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 06:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEFBBB211BA
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 04:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24286142E7C;
	Thu,  5 Sep 2024 04:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="p1gmb6Vy"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F852F44
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510595; cv=none; b=Zgm6Qnshx6bmnh8AnO7Fuke7uEz1lZ4KcaWF4CZlOWwJJb409LrsPR+6WCaFE0B2vm75EBygZnEqYRWFCtMS2lF4PZyKbLm+Qj261huKCOloBqa+15HHFhn2AZ8rVReV4409w9zVFylyYISmMzOEbD2uHs9EI3QQPxw0zIjFOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510595; c=relaxed/simple;
	bh=IqNgGp5LH4F2TBnsMw7LvK32VyAc4U0SAzUDXcPwXyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Z2BxkGB4nbHLxxAVWJZ63Pd6+Dy8rJDQqvKXfqA6I5vqYBA+uNhRsP6H2OwxfLJor2IfbgEk9vK3UT+Y+45nM3x0ok6fH7CI8uagBX+1+tmeD6ooNzN4NtftU9cvrtts7PHwpzeGLCgFhI7vXFyfTOFhJRR4FLFEwfysY/t9nyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=p1gmb6Vy; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1725510062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmpI6wNpZyEU8UYj2/1lJG1Am1PTaoR/B39Jd4Um0ls=;
	b=p1gmb6Vypw3RNgxMvO270Sb8WMZnzwjLEE/7ZLgi+BLD4CRnbbaOGq5XQ/AEuvZyqlOwZw
	hm1IMnXss6wm8QAQ==
Message-ID: <3f2c3ed8-bbdb-45e0-9463-ffffdad0f37b@hardfalcon.net>
Date: Thu, 5 Sep 2024 06:21:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "drm/drm-bridge: Drop conditionals around of_node pointers"
 has been added to the 6.6-stable t
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20240904175026.1165330-1-sashal () kernel ! org>
Content-Language: en-US, de-DE
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20240904175026.1165330-1-sashal () kernel ! org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-09-04 19:50] Sasha Levin:
> This is a note to let you know that I've just added the patch titled
> 
>      drm/drm-bridge: Drop conditionals around of_node pointers
> 
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       drm-drm-bridge-drop-conditionals-around-of_node-poin.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 74f5f42c35daf9aedbc96283321c30fc591c634f
> Author: Sui Jingfeng <sui.jingfeng@linux.dev>
> Date:   Wed May 8 02:00:00 2024 +0800
> 
>      drm/drm-bridge: Drop conditionals around of_node pointers
>      
>      [ Upstream commit ad3323a6ccb7d43bbeeaa46d5311c43d5d361fc7 ]
>      
>      Having conditional around the of_node pointer of the drm_bridge structure
>      is not necessary, since drm_bridge structure always has the of_node as its
>      member.
>      
>      Let's drop the conditional to get a better looks, please also note that
>      this is following the already accepted commitments. see commit d8dfccde2709
>      ("drm/bridge: Drop conditionals around of_node pointers") for reference.
>      
>      Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
>      Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>      Signed-off-by: Robert Foss <rfoss@kernel.org>
>      Link: https://patchwork.freedesktop.org/patch/msgid/20240507180001.1358816-1-sui.jingfeng@linux.dev
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 62d8a291c49c..70b05582e616 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -353,13 +353,8 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
>   	bridge->encoder = NULL;
>   	list_del(&bridge->chain_node);
>   
> -#ifdef CONFIG_OF
>   	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
>   		  bridge->of_node, encoder->name, ret);
> -#else
> -	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> -		  encoder->name, ret);
> -#endif
>   
>   	return ret;
>   }


Hi Sasha,


this breaks the x86_64 build for me.

AFAICT this patch cannot work without commit 
d8dfccde2709de4327c3d62b50e5dc012f08836f "drm/bridge: Drop conditionals 
around of_node pointers", but that commit is only present in Linux >= 6.7.

This issue affects the 6.6, 6.1 and 5.15 branches.


Regards
Pascal

