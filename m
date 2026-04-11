Return-Path: <stable+bounces-235704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK/SKCUZ2mkayggAu9opvQ
	(envelope-from <stable+bounces-235704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:49:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 234FA3DF311
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 11:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E48593005387
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDD3368A0;
	Sat, 11 Apr 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuS/CZkp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E533030F;
	Sat, 11 Apr 2026 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775900947; cv=none; b=pM2cRmwyp19ez4YcyqvgVrfp82FeCf2OyCnbGODyHXOAvRU1CgnNq9jUgTJnW5k4m9ZV6dAbokHW/eKxPzjH5FEQ+A89SljwlSazVD1kFgQUgOxx012+CFMxe4T30Naoduomg0GIRK1YJd3QS4nF3dkdzNJndf7c+V1TW9+IbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775900947; c=relaxed/simple;
	bh=8tb5B89ZJnX50rlWAJvkXtWTKTyNnROQsAJGmIcWveY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EezYgS0Aft/y9DnOMZITSBPf2BT9muk6JcTUWnH2CyZMPKk4mvtJavhPbbTkw/FLCrWcuCnAKVuID7xRxZlzhv8p8UggPKRU9dItj2T8NYN8/ivBqDIyoBepEwsSjetM3pBCtp+55FLLBCJowoBXWTjyritse6fm4beL6F7M+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuS/CZkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DBDC4CEF7;
	Sat, 11 Apr 2026 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775900947;
	bh=8tb5B89ZJnX50rlWAJvkXtWTKTyNnROQsAJGmIcWveY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vuS/CZkpkQ3tdhWH9vxV+iQ83O73hVV4bUSV61YOFV2B9k98j0b2VYhHwREqO2Cbu
	 rt7EnzgZRDWqhW48C/8YbxWMulXN0eXaOsibuLmiRckWXVG59zb2dmEB45noO6nCEg
	 d2wtJRnOho7fB8kdjfURTzfmSfzO10FooZsLHX7g=
Date: Sat, 11 Apr 2026 11:49:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 6.12 230/242] drm/amd/display: Reject modes with too high
 pixel clock on DCE6-10
Message-ID: <2026041152-slogan-chariot-c87b@gregkh>
References: <20260408175927.064985309@linuxfoundation.org>
 <20260408175935.705507105@linuxfoundation.org>
 <eee63d31-f7a2-4737-b33b-cfea7f04e960@oracle.com>
 <CAKxU2N-WvGmbG=Zge=C1F6a+pR3kNW6J7uExUGTOxudBDT8YqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-WvGmbG=Zge=C1F6a+pR3kNW6J7uExUGTOxudBDT8YqQ@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235704-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lists.linux.dev,amd.com,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.937];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 234FA3DF311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:20:42PM -0700, Rosen Penev wrote:
> On Fri, Apr 10, 2026 at 12:08 PM Harshit Mogalapalli
> <harshit.m.mogalapalli@oracle.com> wrote:
> >
> > Hi,
> >
> > On 08/04/26 23:34, Greg Kroah-Hartman wrote:
> > >   #include "resource.h"
> > > +#include "clk_mgr.h"
> > >   #include "include/irq_service_interface.h"
> > >   #include "virtual/virtual_stream_encoder.h"
> > >   #include "dce110/dce110_resource.h"
> > > @@ -843,10 +844,17 @@ static bool dce100_validate_bandwidth(
> > >   {
> > >       int i;
> > >       bool at_least_one_pipe = false;
> > > +     struct dc_stream_state *stream = NULL;
> > > +     const uint32_t max_pix_clk_khz = max(dc->clk_mgr->clks.max_supported_dispclk_khz, 400000);
> > >
> > >       for (i = 0; i < dc->res_pool->pipe_count; i++) {
> > > -             if (context->res_ctx.pipe_ctx[i].stream)
> > > +             stream = context->res_ctx.pipe_ctx[i].stream;
> > > +             if (stream) {
> > >                       at_least_one_pipe = true;
> > > +
> > > +                     if (stream->timing.pix_clk_100hz >= max_pix_clk_khz * 10)
> > > +                             return DC_FAIL_BANDWIDTH_VALIDATE;
> > > +             }
> > >       }
> >
> > This is a backport of commit: 118800b0797a ("drm/amd/display: Reject
> > modes with too high pixel clock on DCE6-10").
> >
> > The backport adds return DC_FAIL_BANDWIDTH_VALIDATE, in
> > validate_bandwidth functions that return bool;
> >
> > drivers/gpu/drm/amd/display/dc/inc/core_status.h:
> > DC_FAIL_BANDWIDTH_VALIDATE = 13, /* BW and Watermark validation */
> >
> > In this branch DC_FAIL_BANDWIDTH_VALIDATE is integer 13, which converts
> > to true, so the reject path is inverted into success.
> >
> > So I think we need to fix this. Thoughts ?
> Best to drop.

I'll drop this commit now, thanks!

greg k-h

