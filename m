Return-Path: <stable+bounces-235666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IcUHjFq2Wn5pQgAu9opvQ
	(envelope-from <stable+bounces-235666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 23:22:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 118763DCDC9
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 23:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FCC13064EB2
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 21:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E7037B3F7;
	Fri, 10 Apr 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkYIy6h9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D573B38B7
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856058; cv=pass; b=ihKjZbB6eZyXaDPaXUrKErardbhpGrmy5jzWrJLN6CtJKobkHxBAsgcPb+wmBUNEMGH3BCxNVJZ5Gvp3+0+UphRRFTECOsLQ1SznWdMOEZBc91+jLKyO/gKuJsNoih8qWX56GKujJlwALaPHN89GHgPmtvQeiiTq4Cn2JvjG+r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856058; c=relaxed/simple;
	bh=Ss3l4fQSrxu+4aX5Y3uEpQN7nCCMUS3AsDLwQiEMG/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f10xp2YCeMR62RyCQIhI/H51GvqX8+7Lx0ALnB9DpF4uDRrrs8NR+o/wqGyETHI9CNfXeF3AHWWsQc9XZg4DG4usQDW6d2KZ8B49odRJ+zAFK1058FRClGkbLO1/pzg8D20CEvE3VMv2mYGnU0fmG0w+9FZ91XhcILOZd6ofAR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkYIy6h9; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so389727066b.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 14:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775856055; cv=none;
        d=google.com; s=arc-20240605;
        b=OXrZcsC8uuCpwAEafKCu6DoEcyvnE3tMdqaxEyBh5fqN5uVc2CVWVFphQG461dyYga
         z1XGI+20oiZds5zYwMkTVVykKDhTT9axkaCS7db2UtsjPiXbTCnUj2eiwxnAcHiCKbZg
         5E9huHUAwk1FYyEbJSKXI4NSLVuC6qQEIomLgcoVa8HJwrQgWHpFrs7DNU2Rbbu8M2Kz
         xHbPtmHvm1uFuqhcnvmLorqL0WQsHF9892I1Y0YVRweQC6ukip5IGHwubpRlG75QU6t/
         49LmpNGUlkJBkzebYVV0jr5Gja1J1pRHLXuHy2HoLsQHQ+1V+utS8tXmFRJqecQ6jJ1G
         ELDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhaJJ8eoOLYXc/7WgoEtcKV9TdCM7BV5ydK19zk2ja8=;
        fh=Jb5ucGTwpT65GKalfKiZRkBf8CfRnLxEg3QE7jXvn+Q=;
        b=XLLo0vh2zUiLm26UVmcBopEWwQVsopJ4EwEwwfzX5yD38DyMd3oS+tXClU/dcDzR7+
         XJwOfbBAzz4J3Hw0/+i0i7euy9loeeVsxDuOCmdHYbGpth0+SdaGHYhKYLan8MozINMY
         yb09G7+pv9RwEPIhe1kbC+31LhQvvU9TrW0mjLVGvNFc58bxTv9gYzy7XDRRjh9n+/1F
         VSH037ULZCCZHOw/nWPq4fVc8857L/Jv6gfspSrt3QA1OhOsWpBbC1us9vS9qJpgtSyb
         BPgjkyw8HrlzOU0Q3VF9PuLAVmLaT4YDgyzzjhvl7SEd9ATcFv7+Uc3yAPCCVhAEe2Ld
         yoXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775856055; x=1776460855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhaJJ8eoOLYXc/7WgoEtcKV9TdCM7BV5ydK19zk2ja8=;
        b=PkYIy6h9zK4odMS7FxUCQLUmJ+sp6mjVHBuXOIHSJxHiwvSOnQL+4eme0BeyBG+Cm9
         tZ4rplQNEPbe/Fyuc3CGTk46G6a5/Y5KpQu7NAPiB4F7THuLxmJ7Nsk2t3OaMF+2zPLU
         K2qXVNI3nGq4ElEncfts5nrckE4gkP6ksr9EvCmj17yqhmPX7sTUkfgkn0AVNWImcmVz
         UfxH5zqAHdp4Fnybqk7CBlpMTJ4O6GhO7hAv+YWR1Uzy2H4F6Dsv92cKlSaxLUY2ZtM8
         OUZ/8Nj5ZvLtXwZq06rzwRisG+LVW9ojXocFviT5ZGKqr+YM+V3C6fePpb87f8kCoy7+
         xWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775856055; x=1776460855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhaJJ8eoOLYXc/7WgoEtcKV9TdCM7BV5ydK19zk2ja8=;
        b=FFh6yaxLVWLn4+2hAwQsx0VRZbPap+WplIfVxoncDIz9fTsdgXEtPESstzDkOlzRYb
         JaMxMuuRcR4f6Pz3e8iLMK8I8Asv/KDy3eODyPpVsn5PU7x9qwmsMEOBSZEWYh4dhLjv
         /yPxom5BXs/LghC/cBTmr0E3Xq8S3Vn8YAvftrXG6GixlxSe4QGobSsNUv11HP+FrzTe
         lSONoi0RljAw248NbPs1ox2j6JrAvM2nyUrQzF4RlpCLcR4d2yC/Ht7fEtOPeZ9CnDcU
         ws456Qmvupv7fhNEj55DUN3unYtq5nGLCcNdpbzWt08LhLN1N+C94HUvbH4gcaCeQEje
         KpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWirSq9JUlP5QwDEOvp1a6L4ULUY58hYrx844PkWaHBEMXOPVUwsJ/1ZWsKKNpctP2LsF8BPpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAHA/nk0Oso+D8H45U9djJX2W+uaw4oDU6aq2i87IlGoV4Hdp
	DLbYhtizLtT0KAMZvgN7u5zyM1H/en+lBKL1VcfZThgNFZESugWjR3USCII/6VlWe8KERmgqW7n
	hAIMAdL76WJgKRWc9iJfDZiR+JEO9pM0=
X-Gm-Gg: AeBDievRCpAk+cnMYtFJrZQJWtTMu8NaSTV1qncEDirZJ+Y4UvBJfSL4qL37wqvh1lo
	XrAdahSdgwEMs+dZ5y82+wdJ1aUx1ax9u/ey7iiPTPnIyf7qhAc4RV3XfZk844mTZFYwFYfGrCV
	T0GPqijKzPKTre41ZoUsj0T69hgmSrTl7jjiJ7nbQubaz6wcyFxuYtWWGM94T/YkH80hyu41ZWU
	HgNo34iX1jxARkiPX6RvTvoKJhPc9CDqpgLQMNNCji/UQrZ/2/lGKA1LR/cRggwrjVL+ONO3B25
	124SIgE8sayqFoi5axLXWsBIwYH3kBUyNk7ByPMQnSH+rwtymlDtnfRHMDKsf9lyuaBw3MVbU/L
	ZhOptXA==
X-Received: by 2002:a17:907:c908:b0:b9d:3b68:954c with SMTP id
 a640c23a62f3a-b9d727aa0cbmr220907566b.24.1775856054482; Fri, 10 Apr 2026
 14:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175927.064985309@linuxfoundation.org> <20260408175935.705507105@linuxfoundation.org>
 <eee63d31-f7a2-4737-b33b-cfea7f04e960@oracle.com>
In-Reply-To: <eee63d31-f7a2-4737-b33b-cfea7f04e960@oracle.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 10 Apr 2026 14:20:42 -0700
X-Gm-Features: AQROBzDc2Nu5LoD9cVK_3hSpGRPzX5o7HU6msz-Juo7W2QvQF2OvoWhA9GmtpqY
Message-ID: <CAKxU2N-WvGmbG=Zge=C1F6a+pR3kNW6J7uExUGTOxudBDT8YqQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 230/242] drm/amd/display: Reject modes with too high
 pixel clock on DCE6-10
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235666-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,amd.com,gmail.com,oracle.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 118763DCDC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 12:08=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Hi,
>
> On 08/04/26 23:34, Greg Kroah-Hartman wrote:
> >   #include "resource.h"
> > +#include "clk_mgr.h"
> >   #include "include/irq_service_interface.h"
> >   #include "virtual/virtual_stream_encoder.h"
> >   #include "dce110/dce110_resource.h"
> > @@ -843,10 +844,17 @@ static bool dce100_validate_bandwidth(
> >   {
> >       int i;
> >       bool at_least_one_pipe =3D false;
> > +     struct dc_stream_state *stream =3D NULL;
> > +     const uint32_t max_pix_clk_khz =3D max(dc->clk_mgr->clks.max_supp=
orted_dispclk_khz, 400000);
> >
> >       for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
> > -             if (context->res_ctx.pipe_ctx[i].stream)
> > +             stream =3D context->res_ctx.pipe_ctx[i].stream;
> > +             if (stream) {
> >                       at_least_one_pipe =3D true;
> > +
> > +                     if (stream->timing.pix_clk_100hz >=3D max_pix_clk=
_khz * 10)
> > +                             return DC_FAIL_BANDWIDTH_VALIDATE;
> > +             }
> >       }
>
> This is a backport of commit: 118800b0797a ("drm/amd/display: Reject
> modes with too high pixel clock on DCE6-10").
>
> The backport adds return DC_FAIL_BANDWIDTH_VALIDATE, in
> validate_bandwidth functions that return bool;
>
> drivers/gpu/drm/amd/display/dc/inc/core_status.h:
> DC_FAIL_BANDWIDTH_VALIDATE =3D 13, /* BW and Watermark validation */
>
> In this branch DC_FAIL_BANDWIDTH_VALIDATE is integer 13, which converts
> to true, so the reject path is inverted into success.
>
> So I think we need to fix this. Thoughts ?
Best to drop.
>
> Maybe we need to revert this or backport commit: 4465dd0e41e8
> ("drm/amd/display: Refactor SubVP cursor limiting logic") to stable branc=
h.
>
>
> Thanks,
> Harshit
>
>
> >
> >       if (at_least_one_pipe) {
> > --- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
> > @@ -32,6 +32,7 @@
> >   #include "stream_encoder.h"
> >
> >   #include "resource.h"
> > +#include "clk_mgr.h"
> >   #include "include/irq_service_interface.h"
> >   #include "irq/dce80/irq_service_dce80.h"
> >   #include "dce110/dce110_timing_generator.h"
> > @@ -876,10 +877,17 @@ static bool dce80_validate_bandwidth(
> >   {
> >       int i;
> >       bool at_least_one_pipe =3D false;
> > +     struct dc_stream_state *stream =3D NULL;
> > +     const uint32_t max_pix_clk_khz =3D max(dc->clk_mgr->clks.max_supp=
orted_dispclk_khz, 400000);
> >
> >       for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
> > -             if (context->res_ctx.pipe_ctx[i].stream)
> > +             stream =3D context->res_ctx.pipe_ctx[i].stream;
> > +             if (stream) {
> >                       at_least_one_pipe =3D true;
> > +
> > +                     if (stream->timing.pix_clk_100hz >=3D max_pix_clk=
_khz * 10)
> > +                             return DC_FAIL_BANDWIDTH_VALIDATE;
> > +             }
> >       }
> >
> >       if (at_least_one_pipe) {
>

