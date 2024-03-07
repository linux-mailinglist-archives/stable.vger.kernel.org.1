Return-Path: <stable+bounces-27112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A787573B
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 20:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B1E1C20F2B
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 19:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADA31369A4;
	Thu,  7 Mar 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L0lLEfIo"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550871EF13
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839895; cv=none; b=JEijI049lfiDjMrCAzKo3gLy+i0D6OglPRZYX9Z7ZvRJSsGcrRSGXaVbqE506VcMUSFg8/2alAf3qFlzhdxdujX13rYoEhVGXdj7JYjSBkd7mL3LVtgtiIcfLTEVDBtXKWoaJ+CYGISuKEhzDsv/76HbkrQeA+PGOPkWy1ZMy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839895; c=relaxed/simple;
	bh=tULaC2SQhleWoaZEgI2k2os0D13fLsMJxodRSZkgdWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma+yvbZmtEM6WGfPAn8BDpWR5BcdvAw2nQdl6FoAbfgwxvOxDcf8l3whknK2Fk6fBIlyKaC7YCddlV2IpfAhJsS5Vo5lY0MOosGDtMt1ferrQxvsgxJ9SC274y+tZipNss+FYCCHHDmvC3s6IxGB63f1BTbu055YBr2Zx3im5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=L0lLEfIo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=claNfNCNdwAuVVdEjxNgaXfvtJQSA+bqs4pghfSbMek=; b=L0lLEfIoPnq8trtY1uMDGCNMBd
	Jq4cp4z1fj+YfkSg5eb5wrs482LxyceAh/8yWNYtB6gTjMltpTPX8xNg3njS5Tf67QlbkEh36eNnQ
	Yt2+EQGbYKJ5oN9+g2EKttsu+zbGN0pDjuxKSEr6Zpx1w/4LUv68gFZdrS2qB90dlJSOCH0W/4erM
	HzzuvRE+aWS7Oz82cnc/2LkeIC/JUcdye4vfkIZ30IIqqOsxaUQl8goFhJuS5HyTi7DH3d1hgxCkX
	Nxmi5eGsgLV/vmyv8F3AmRboy4/S3pbB+aiOuNr4TRB4q0OU51oEXULqhVP7WrHpvMyUsbScwW9KA
	lFmHLXqw==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1riJSf-007ObZ-9p; Thu, 07 Mar 2024 20:31:25 +0100
Date: Thu, 7 Mar 2024 16:30:28 -0300
From: Melissa Wen <mwen@igalia.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org, 
	Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, 
	Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com, 
	chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com, 
	Muhammad Ahmed <ahmed.ahmed@amd.com>, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org, 
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH 25/34] drm/amd/display: Set the power_down_on_boot
 function pointer to null
Message-ID: <xuprblokiyqlelwnt5bcauyphsaafvb6hfnbkvodsg2wjp4xjr@renc6bbhfdv6>
References: <20240228183940.1883742-1-alex.hung@amd.com>
 <20240228183940.1883742-26-alex.hung@amd.com>
 <54c3aa20-f041-4843-b4b5-362b7ff77844@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c3aa20-f041-4843-b4b5-362b7ff77844@amd.com>

On 02/28, Mario Limonciello wrote:
> On 2/28/2024 12:39, Alex Hung wrote:
> > From: Muhammad Ahmed <ahmed.ahmed@amd.com>
> > 
> > [WHY]
> > Blackscreen hang @ PC EF000025 when trying to wake up from S0i3. DCN
> > gets powered off due to dc_power_down_on_boot() being called after
> > timeout.
> > 
> > [HOW]
> > Setting the power_down_on_boot function pointer to null since we don't
> > expect the function to be called for APU.
> 
> Perhaps, should we be making the same change for other APUs?

any follow-up to Mario's question?

I wonder if this can help solve other "black screen hangs after suspend"
reported for other APUs...

Melissa

> 
> It seems a few others call dcn10_power_down_on_boot() for the callback.
> 
> > 
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Acked-by: Alex Hung <alex.hung@amd.com>
> > Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> > index dce620d359a6..d4e0abbef28e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> > @@ -39,7 +39,7 @@
> >   static const struct hw_sequencer_funcs dcn35_funcs = {
> >   	.program_gamut_remap = dcn30_program_gamut_remap,
> >   	.init_hw = dcn35_init_hw,
> > -	.power_down_on_boot = dcn35_power_down_on_boot,
> > +	.power_down_on_boot = NULL,
> >   	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
> >   	.apply_ctx_for_surface = NULL,
> >   	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
> 

