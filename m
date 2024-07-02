Return-Path: <stable+bounces-56339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B32923B90
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 12:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA6728561B
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E6158A3D;
	Tue,  2 Jul 2024 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LMU8yjF3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qC9IOtM6"
X-Original-To: stable@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037F158A17
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 10:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916559; cv=none; b=XLLnK5toguGnJYPJcbqGUpIQv2updEklhn1jhaS/G9re5T3V83y18itle2xjzuP6wLIN4uzvzKaiO60H9fzae/LNKZAd6FTKScA0WVd2sogHPOlkAxdYMxIQoolZ0WuXffep0VKrouZtyvLl2rOha8Xvt8Wvh5E3QaWZzE5maLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916559; c=relaxed/simple;
	bh=c3u6YuTYU/BMSsGdp3v01wj142ezhZzArVPd5/1SH+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBHEE15sJZ2rvaKUadQ622rS5PsP2c/FdODe694/ECKQz0dA2Ai5yhH+IEWs0dV5x9BKwmIRY/Eb+egTpan/Nja85bamIg+nHMnBHsd05moolPIvx1vlEOgbNvBjjze2kt4ag0sFEis/BxfozlFO4UH42VQ3ki4/bmy7eb4kv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LMU8yjF3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qC9IOtM6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4005D1380487;
	Tue,  2 Jul 2024 06:35:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 02 Jul 2024 06:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1719916556; x=1720002956; bh=duCbWC7XJ3
	4XZdZF3NzsQNdk8ujDcqaKzSQD9UJw9+U=; b=LMU8yjF3K0q2Pv8RtdBBF3KAWH
	4jmqOyq9R7z0jMFkWOpJt6teOK07XmAK8SnRyM2P2Nxie0Y8QlAGkLJzEYBT4nNk
	bSEq8VrzdhhZgGYJbPEBJdx6oL2qcPna0o2B1pCRXhhbp8NQWtMM5Tyw/WGxetyE
	ke003Nu5kXXBpLR5iYxEyrF62NIZ7Jog8zswN4SR1UdCXwlARfpVuSp3wPPJSuFd
	XbG/YoE14wsZeh2RCCKFW04MYAjS37ENdOsyR2IOSU6C1jPQYnxKWnwBVnNHvLLj
	Raz4Sx4YoF3I9xB4A89Wi8sZFHMBXYTXm678rMyx1sNqw2GrxZiKUSnF7Xag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719916556; x=1720002956; bh=duCbWC7XJ34XZdZF3NzsQNdk8ujD
	cqaKzSQD9UJw9+U=; b=qC9IOtM6kJYoVuEbjZL/M3OgUxA9LInxVTL7h8jp8vTy
	J6yvy9+QqFubsReJtGEl5FzJIzhqFJuxlGgHcDRh62ba2w3zjw+PbTaZ9dAGsFAS
	vdtVVxj+rzXbKbEx30nNKg7pF+mBylH2REiOR/LzTveFPMkaCJ2ROI18MqWEcXiq
	lOmh+AsWWgok875kCaHMbONuM52EUqve0r+i/sF7kdmLgV2rVUBSA6AxZn3ZIVF5
	zt7CfzLekF7VfEwZKMs8ppTR6eT39kPHipK6SwRi4oqmpWCn1mAbg47WwSvAVXvz
	ItvoGBMGfB7nE7Ab7HhHSffHvDaFDrGIGBKJ7G190w==
X-ME-Sender: <xms:C9iDZolfwsHpAF5EmaFaTrxlMPTpfzTyD0VKWTe_NWpEDN57FziTmQ>
    <xme:C9iDZn3f2UkvPqh7QtfnyThQ2ascVn5lrkyfoPcczNtwf-DUdgYtLMAYr4ztvCCES
    jjx-BKZ_EnJ-g>
X-ME-Received: <xmr:C9iDZmrOKpUocrpSrN6MlPt_niQtm_5JoJ1uHQ7PShpNMQP-qRD-Jz5tZDeI6q6L3YRKdBwUmy-kBY4ttgrDsdDEaCE7m6U6hKdBKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejue
    fhtdeufefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:C9iDZkmLSHPdOsjkKJGr2EtqraG-oFOtlfx8ORx74gsXGB1h1_HP5Q>
    <xmx:C9iDZm2oljTzCC6B0477vwuY-N1mecxEDgO90cgkLn29QT9IprjMgQ>
    <xmx:C9iDZrtA2gozOIL_Hp9FXA_dkzMDg3y0WFo3QU3-HXmaZJtjf7TVTw>
    <xmx:C9iDZiUjF_7h8GbS9Pdevwx-L5JDDJwl9dKmBpXzgGIvOQ24gPSQlg>
    <xmx:DNiDZpQRGoRWxX3VTn3KQ_n2q0apa9gtYvQdsWHrGM547M6h4noGgG9r>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 06:35:54 -0400 (EDT)
Date: Tue, 2 Jul 2024 12:35:37 +0200
From: Greg KH <greg@kroah.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 1/5] drivers: fix typo in firmware/efi/memmap.c
Message-ID: <2024070232-virtuous-uproar-21a7@gregkh>
References: <2024062455-glazing-flask-cf0c@gregkh>
 <20240629151357.866803-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240629151357.866803-6-ardb+git@google.com>

On Sat, Jun 29, 2024 at 05:13:58PM +0200, Ard Biesheuvel wrote:
> From: Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>
> 
> [ Commit 1df4d1724baafa55e9803414ebcdf1ca702bc958 upstream ]
> 
> This patch fixes the spelling error in firmware/efi/memmap.c, changing
> it to the correct word.
> 
> Signed-off-by: Zheng Zhi Yuan <kevinjone25@g.ncu.edu.tw>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/memmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 2ff1883dc788..b4070b5e4c45 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -245,7 +245,7 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
>   * @range: Address range (start, end) to split around
>   *
>   * Returns the number of additional EFI memmap entries required to
> - * accomodate @range.
> + * accommodate @range.
>   */
>  int __init efi_memmap_split_count(efi_memory_desc_t *md, struct range *range)
>  {
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 
> 

All now queued up, thanks.

greg k-h

