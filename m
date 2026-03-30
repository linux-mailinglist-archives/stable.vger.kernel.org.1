Return-Path: <stable+bounces-231286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJJYItLtymkkBQYAu9opvQ
	(envelope-from <stable+bounces-231286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:40:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0763A361885
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4969B3022F68
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A593A1A5B;
	Mon, 30 Mar 2026 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfWpSTbn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF073A3E78
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906734; cv=pass; b=N7ToJ5mPwBd8+RWQYHhd4gwDLg+InxnJPEn4UcZMd6yptfsCZu7/0ABXpVqqQ3vAltyVAUc1da6jffIAT6YkI4/WdxZdfMNBUkhMiHEBr7EEsmGCWHQN/EaPbi3ePjkOkGfB+CUaFweiB/+EtBlMG4f8jghJj8Yco6OaohP/BQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906734; c=relaxed/simple;
	bh=vAf6JRwaS0nLIvwGyADIdn5Vlj6jq+46aU6jlvEA3Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrSCTIx/G3nP2/gJ/7IhTYW38A+Wo2yVWpZwS7Y8m7sofZiasdQ5DRbKUUll4iSoz0oAW6BpaYMT+jXYEVn+bVvwHlx48Wi7uAMAMTG3waNd25OXDKLdo5+NeXro0XrdoIc9DvTbX6+MuGKyxPyZCIAciVIFWB7UCcvaWHMGr+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfWpSTbn; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2bb0fe3bbso258960e87.3
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774906728; cv=none;
        d=google.com; s=arc-20240605;
        b=IHPVv5b2BcHBh5ZJgVk1beZFtoLyGFZC5SmI1NHd9AWKU+9EaGJbaXwPqe/w4hsBwV
         Hwa9YgFQG4ld+dA1NPOh2X63AmRsEERMBpKZDoZi6PbmZELKn2kTGZIJs+mD6mAOYs1Y
         5T55ebRaNk5LGsclJ5sU7GK9IFaKMu/11Wpsp5Z3d+eKj/hFvAh/w7JWQB+Wy42j9mmM
         As4H6NTjJHD/DbXDi+m33DkwPdlSnrPS0T1WmmbHDUUtknbuHmT74TqnAJmw/XUzTl23
         eM+204u/goGWbRMTfarXwyY46vXu6Z6gXL2g0ZPDjKq67ngL2eq2RbZfZNulCu/WU4el
         be1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
        fh=oXAPCvUYdy7+3UE0W44cNkTC4OVu4YthK67407U77Io=;
        b=Q+E6eVsAiK35+eoVKF5Z0xI6YHI12dPd9TU+OKcyykPE4YZbl7Cqk0hGkzGJykw7X/
         dwsvWQwK2vMBZ/3soxblzwDLZO/81ZW02o84MAq54GtOqJKupfKKE4j6JvmPmSfnfpSS
         b03nUdnA1jYOYle6lcqn/CE5e3mrR9Pe4TsGpTSm8qv3Lf7A1pueSt35oa/cie7WV3cp
         pjIefKYefZwRc80/NjZdB9E7yg3hHnYjir3Iebt+uyn5K1dVBdWQF16NM+MzwNRok+av
         3YIiK6tzesTenTG3UAmL/MRj5gv4zaiSkWG3ftFpssiz5zu7Kafukh+0XbgVnpjgbGms
         +4dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774906728; x=1775511528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
        b=kfWpSTbnBAd2M31Uy4WVyysouPdqZ5RTUdIUfdObibAiC4WK7rMIahd0MvdT5eaYjF
         kg3fZcPLnNqnpY1xh2QGCip+XJ+B9e8J6J5hIDS/cY6GYpraMleWE/SQ6rJmSi3oSFr4
         tSoH3436XlCtH3b55Ssxfx4GiAX0xydW3t8F9Wj0OR7LFoJ/tFOoU/IjqTdC2rVnRtXe
         Dqqiou86J6jQwIJRyFes4531KOgjRG1RRumFMAwD+IVQrQZXlF1RtkVSud6saGkcFZyz
         VTvTb6souFP2svHJdz5fiq9xkdb4a9Ymm48cNAXmjoJKXzrRV11HBIR76RyxCLxoBFC4
         xncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774906728; x=1775511528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyXWT6CZTRjvrBzjlgkYqR6hvQZ/LcLxcXjlYxt3yys=;
        b=jXe9/ryoqmeEd9DriW2pO2B/c2ya+eBNHzsVonzjmxNhlmmGsBUyWaJ7QR+AaG6JHo
         maXoX27d2X30rz+38d4E4j7VZjBWBaGjz7crOW0cN6nsosV3of41KtMLGG4QPcDG3W+f
         y8n/S9oHzLzs+4c5i49a1BodPuzYoLsH+LwGXQuLNjPu7O926Ho08nhrwagBdT2Gaf1T
         TGnKPOSfub2yvFdbXN0VPi01Ma0y6OwX2IoR8w3X63VLKatIXWnH4mrbKG7woGduXii/
         MMVq28ddKlEQ64ybdzKPtR4+oMar/Y3UMVzBMEfiex0PA29FFnlBmFBpJmZ/WDHXjNRv
         cm/g==
X-Gm-Message-State: AOJu0Yxuq8a2p1elgfVviCIVt+IvFZIq8ykz+i8ROZwXSz2VYumEDaxK
	jSu232HP+vG4qEaLicbQNM2D6nINCV7hLOPCWI1ajvY3c86Iq2tCvhPoVUne8C+/PvbSwKD3Orz
	cXm0a+2vZEB+G1VJS+LasDmWZns0XgAQ=
X-Gm-Gg: ATEYQzwYf+tYi6jo3xlhnQEoMJhciKJdEZQ6cEjDDLGZGdf00aPNNuaLAqY6pAUE0Hw
	dBA/IfpLFIi0FclM5RlSemlpqrx4kYR+b2boYvVG/Gsc2g7RFMIttxrg/iW8XoYTXu2aJxpDUs+
	UyY2GND6wvNLoO1fzsw3HTeFc/8dZ86fiQOqr5gTR0CwrxYfi+U/mK3baXVs8TgOqktTqpXxsR1
	pHF4jhlbTXjsYpXRS8EAH1gKVxyq3taV8Ch4FBtRSJAhiTJY2/d3R9OtNMXJzEcKRDCCHNwd2bU
	FBEkWWhc16QNERDqwDUkn5+kaZTBZefR/9r/qgARxdyHtIpeLaou1wYF9kYM6BPfXGfTMxCIk0t
	qUODGrw==
X-Received: by 2002:a05:6512:1084:b0:5a1:4473:bb44 with SMTP id
 2adb3069b0e04-5a2ab92d9e4mr5216280e87.33.1774906727539; Mon, 30 Mar 2026
 14:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326234716.16723-1-rosenp@gmail.com> <2312151.9o76ZdvQCi@timur-hyperion>
 <6b15401c-1fdf-4d3b-84aa-dfc47f430895@amd.com> <7351746.9J7NaK4W3v@timur-hyperion>
In-Reply-To: <7351746.9J7NaK4W3v@timur-hyperion>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 14:38:35 -0700
X-Gm-Features: AQROBzClHbQKYMQEBk1N37wHNV8JfR61-qIixPaDukv245DWUjEWx7ElX5PJJLU
Message-ID: <CAKxU2N-CRua=kMVm8gdf2AnbCFyLsLTbf=-9NZHAkhL3sJC-tw@mail.gmail.com>
Subject: Re: [PATCH for 6.12 3/9] drm/amd/display: Disable fastboot on DCE 6 too
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: stable@vger.kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
	David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bin Lan <bin.lan.cn@windriver.com>, 
	He Zhe <zhe.he@windriver.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
	Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>, Eric Yang <Eric.Yang2@amd.com>, 
	Tony Cheng <Tony.Cheng@amd.com>, Mauro Rossi <issor.oruam@gmail.com>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231286-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lists.freedesktop.org:url,amd.com:email,mail.gmail.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 0763A361885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 7:21=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Monday, March 30, 2026 3:55:55=E2=80=AFPM Central European Summer Time=
 Christian
> K=C3=B6nig wrote:
> > On 3/30/26 15:16, Timur Krist=C3=B3f wrote:
> > > On Friday, March 27, 2026 12:47:10=E2=80=AFAM Central European Summer=
 Time Rosen
> > > Penev>
> > > wrote:
> > >> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >>
> > >> [ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]
> > >>
> > >> It already didn't work on DCE 8,
> > >> so there is no reason to assume it would on DCE 6.
> > >>
> > >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > >> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> > >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > >> Reviewed-by: Alex Hung <alex.hung@amd.com>
> > >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > >> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > >
> > > This patch is incorrect and should not be backported.
> > >
> > > (Note that the error is already fixed upstream. For stable kernels IM=
O
> > > it's
> > > best to drop this one.)
> >
> > Is there some alternative which needs to be backported or should the ol=
d
> > kernel just work out of the box because we never enabled some feature
> > there?
> >
> > Apart from that the patch set looks good to me.
> >
>
> This patch had a typo and does the opposite of what it should, ie. it dis=
ables
> eDP fastboot on DCE10 and newer instead of disabling it on DCE8 and older=
.
>
> The upstream fix is here:
> https://lists.freedesktop.org/archives/amd-gfx/2026-February/138577.html
> which disables eDP fastboot on DCE10 and older.
Not sure what the process is here. I make sure everything can be git
cherry-pick ed. In that case, both should be present.
>
> >
> > >> ---
> > >>
> > >>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++---=
-
> > >>  1 file changed, 2 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq=
.c
> > >> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c index
> > >> df69e0cebf78..7dc99c85b8ea 100644
> > >> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > >> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > >> @@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc=
 *dc,
> > >> struct dc_state *context)
> > >>
> > >>    get_edp_streams(context, edp_streams, &edp_stream_num);
> > >>
> > >> -  // Check fastboot support, disable on DCE8 because of blank
> > >
> > > screens
> > >
> > >> -  if (edp_num && edp_stream_num && dc->ctx->dce_version !=3D
> > >
> > > DCE_VERSION_8_0
> > >
> > >> && -                   dc->ctx->dce_version !=3D DCE_VERSION_8_1 &&
> > >> -              dc->ctx->dce_version !=3D DCE_VERSION_8_3) {
> > >> +  /* Check fastboot support, disable on DCE 6-8 because of blank
> > >
> > > screens */
> > >
> > >> +  if (edp_num && edp_stream_num && dc->ctx->dce_version <
> > >
> > > DCE_VERSION_10_0)
> > >
> > >> { for (i =3D 0; i < edp_num; i++) {
> > >>
> > >>                    edp_link =3D edp_links[i];
> > >>                    if (edp_link !=3D edp_streams[0]->link)
>
>
>
>

