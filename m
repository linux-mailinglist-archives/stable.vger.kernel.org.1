Return-Path: <stable+bounces-17437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BEF842A80
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 18:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E0DB2523B
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1331292D0;
	Tue, 30 Jan 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG+jkKcV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EF129A86
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634622; cv=none; b=Y2HBwwLdTqmC1WAOnK0dSE+ZrkF4pfSXslq4V6mzDJrPn9Pwwkr7UPP+isC7enp7fRvhJzs7J283cljRexOX0AMfAYLW0yqBBPGhWMnM5V7WQTfXTvK5ebhCun8U5H72f7In46WFISN1gd2ijAHkyX84/wrqjagE6eB4YuSjkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634622; c=relaxed/simple;
	bh=qs3bHzLttFydFy/a7bg3wwRcc02Xlp3EA5qTNS+OYVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si5+gF0Xj1xkUAkAOslmq8gDJZohmbQgw/mcannI1lJ2U8TL4t1BPrtSwojrRP4AcbVMQ05PZZb3oEv9N2RYS+6vw1b4n4m21QwfklO1opcGDJhX2uTr83mdD7+GuMiYKeslIGR2zM02hMPWOn0wUruvplxxDWJI0q2hxHu+i0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG+jkKcV; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d043160cd1so30878471fa.1
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706634612; x=1707239412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAf6tgblhFk5SS7xF/05maRRLfXRqqg0AmAUe2SVN0M=;
        b=iG+jkKcVhjbmODFCp84d6WI1w3cewQ2Cn+ViqoLwUVZLAN8B3kLWJ6WXm0cpF7hCJP
         GI6hB6k2AUYUIQX4nfxECx7fyqzdXJHBZKGnZRlFpWzUAMhXP7HINd4PStyggmkxlVV6
         OAGX+AwmHnpTUaw1Gk4qPWIhuasYugC4dtVXEoaqozPzvBiqtkcu/G72kCJMC2RcRPA2
         zgxZstCc0IEwQuqLdK1akc3bA6sZ+H6Anf3ebg2nxAnujjbkgxGxPQs5uAUkCY01vUQk
         igMyBWp0TRPfysq+NGw6QDQrPNWfGBXoDl/luoTK14rNj6oLbIb+KsnAoEaBXTIAE8kq
         3FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706634612; x=1707239412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAf6tgblhFk5SS7xF/05maRRLfXRqqg0AmAUe2SVN0M=;
        b=B7LBRad0TL7JKSBtiCLf8YRIGFVvDvoygEEXLwMBcdHcOVSIKsEbfH3qrQzZ3rTWUW
         bNE/PHeK2UEUCRLVtKDbkvS4CnHKsXRBjQA/KD5A4CsEc+i1Dn7LhK3w8HkwBQanrXET
         ZYLX7SpeHGvugf6Nu4u9Na7W6Sa1vJbMXbv/1OFTQ2BVSP01ixkzTF1p1/DQ9ojW2Fq0
         y9U4drw0utNDi3fB0anSlDyJ3Wg6QNkTaSrDUzGp5hdbyGM3s9Ud5GdXZVI6oBMrQSFE
         xKtASp8hfFYfBKe1bs8Lj3Db+VhWNhVpUUo8C/DyhlkmBIIQVuBaedH+/MthcGCaBMtG
         ixFg==
X-Gm-Message-State: AOJu0YxkYFpmcs/XXQ0qR/i0sRJ2mqj71T9yo5W0i6jV+VI8mZxK866x
	YrFhpshOaibGdS5gI+q0HlCCcuOrBPw1mSQR/1d/tsy2zWEX4iiI
X-Google-Smtp-Source: AGHT+IFSUK1TGC/xVKTkhUtyOB2SQ2m2OaxRok6eqOPvn4/MIrrR1kxT9lIoa2q+QUSu0YbJSWLoGQ==
X-Received: by 2002:a2e:8e73:0:b0:2cd:9503:f91 with SMTP id t19-20020a2e8e73000000b002cd95030f91mr5533320ljk.15.1706634612059;
        Tue, 30 Jan 2024 09:10:12 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ds8-20020a0564021cc800b0055c9280dc51sm5046118edb.14.2024.01.30.09.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:10:11 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 6359CBE2DE0; Tue, 30 Jan 2024 18:10:10 +0100 (CET)
Date: Tue, 30 Jan 2024 18:10:10 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Sasha Levin <sashal@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 098/185] net/mlx5e: Allow software parsing when IPsec
 crypto is enabled
Message-ID: <ZbktcnbWiq14DiSX@eldamar.lan>
References: <20240129165958.589924174@linuxfoundation.org>
 <20240129170001.745906693@linuxfoundation.org>
 <ZbgFoW5DV4dQxliM@eldamar.lan>
 <ZbgGrgeP_Wwrrb7C@eldamar.lan>
 <2024012926-dagger-bazooka-b7da@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024012926-dagger-bazooka-b7da@gregkh>

Hi Greg,

On Mon, Jan 29, 2024 at 12:43:05PM -0800, Greg Kroah-Hartman wrote:
> On Mon, Jan 29, 2024 at 09:12:30PM +0100, Salvatore Bonaccorso wrote:
> > Hi,
> > 
> > On Mon, Jan 29, 2024 at 09:08:02PM +0100, Salvatore Bonaccorso wrote:
> > > Hi Greg,
> > > 
> > > On Mon, Jan 29, 2024 at 09:04:58AM -0800, Greg Kroah-Hartman wrote:
> > > > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > > > 
> > > > ------------------
> > > > 
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]
> > > > 
> > > > All ConnectX devices have software parsing capability enabled, but it is
> > > > more correct to set allow_swp only if capability exists, which for IPsec
> > > > means that crypto offload is supported.
> > > > 
> > > > Fixes: 2451da081a34 ("net/mlx5: Unify device IPsec capabilities check")
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > > ---
> > > >  drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> > > > index 29dd3a04c154..d3de1b7a80bf 100644
> > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> > > > @@ -990,8 +990,8 @@ void mlx5e_build_sq_param(struct mlx5_core_dev *mdev,
> > > >  	void *wq = MLX5_ADDR_OF(sqc, sqc, wq);
> > > >  	bool allow_swp;
> > > >  
> > > > -	allow_swp =
> > > > -		mlx5_geneve_tx_allowed(mdev) || !!mlx5_ipsec_device_caps(mdev);
> > > > +	allow_swp = mlx5_geneve_tx_allowed(mdev) ||
> > > > +		    (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO);
> > > >  	mlx5e_build_sq_param_common(mdev, param);
> > > >  	MLX5_SET(wq, wq, log_wq_sz, params->log_sq_size);
> > > >  	MLX5_SET(sqc, sqc, allow_swp, allow_swp);
> > > 
> > > When compiling 6.1.76-rc1 this commit causes the following build
> > > failure:
> > > 
> > > drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function ‘mlx5e_build_sq_param’:
> > > drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error: ‘MLX5_IPSEC_CAP_CRYPTO’ undeclared (first use in this function)
> > >   994 |                     (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_CRYPTO);
> > >       |                                                     ^~~~~~~~~~~~~~~~~~~~~
> > > drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: note: each undeclared identifier is reported only once for each function it appears in
> > > 
> > > Attached the used config.
> > 
> > Mailserver from leonro@nvidia.com, saeedm@nvidia.com rejected the
> > message due to the attached test.config.xz . Resending this here again
> > without attachment so that might reach Leon and Saeed as well.
> 
> This works for me, I don't know why it's failing elsewhere.  I'd like to
> drop it but I really don't want to unless we can figure it out.

There is an explanation and a proposed fix by Florian Fainelli
<f.fainelli@gmail.com> in https://lore.kernel.org/stable/8c178bd1-e0c9-4e29-9b63-dd298298bc7b@gmail.com/

Hope this helps!

Regards,
Salvatore

