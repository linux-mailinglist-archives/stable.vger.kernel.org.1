Return-Path: <stable+bounces-243928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DyDAbwi+Wmz5wIAu9opvQ
	(envelope-from <stable+bounces-243928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 00:50:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3364C4929
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 00:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA1F3301808A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 22:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84115370D4A;
	Mon,  4 May 2026 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jo9+Mzyg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B83806D1
	for <stable@vger.kernel.org>; Mon,  4 May 2026 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934860; cv=none; b=lnm//+yX79kAgetrMIo9h1yUZNNFKosltgWnBgMDWPS9bnO7DGJm8BhtrtVKWDl60JpfzCdNkOkUyxapyZZZwtAKCAgm3DaO1GquKCunFNYKi5U0pB+rr+yITQN0lDkNHPMD3dRl8GfX1GwJutl1zYP0M4iZsZGhQygjPlkgO20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934860; c=relaxed/simple;
	bh=7EFLAQZTvZr+bNwaBPn0b1qZPFp/QiS7LgKDiG9a6TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If+hIbvLPbl8a0TAJw1h+SKsM14o7VoJodAQrEeyOkICM+CU0mGU9GeL2DnVniN2BA2njJk2LaKZB4Hrwy4vmGJl/5QA5I/pa2Ot87FUsG6kbp7D6k5NQ2RMtKVpJ5wzxVAib+egb0I5FaOuaFmxXVlV8CFCNScJgWM/zaPVkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jo9+Mzyg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67be41d5eeeso4340945a12.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777934855; x=1778539655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EFLAQZTvZr+bNwaBPn0b1qZPFp/QiS7LgKDiG9a6TU=;
        b=Jo9+MzygyZfuytTETIiuEtOH4dCVDD+9EDp8Wa6vjlhpzXkWKaYmB0KrOm5IIbnoCS
         ft+pVolmYpPpXkqlQU6FKR/YOLixOZkJpcqKB7Q6q6zvXhfePucnxVtTLuIsLX6LnTH3
         nksBtMsRt03GNPYF6GGXBsjUVqDufRHztbuhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934855; x=1778539655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7EFLAQZTvZr+bNwaBPn0b1qZPFp/QiS7LgKDiG9a6TU=;
        b=hXXOOHsLf0S3lzMyoPVqNN2GTG2YkurPoUuSTB5kuNq+J+ixUK5z9oWpeceTHwjhQH
         C5gpsO0KbBGWlIWijv4UsLwgod9dCjWZNlI561vITzt3PDETfRmtum9t+CAO2KPIpIE5
         1Ubg5uJTMA6AFuXw7ouL4kRsVXjcP77wmWu/sVNVjfUC+YFCQMDt5c8M2W/ipGSVa7m6
         eMNmhNFdz5h+xOBJfp/WcecUmMQVrhhtFsMc5UX9A0+9wz/cBi5GW5++K73cQDafxWUO
         bpabEwLJm4t8wO/MoXoW1ZuQbipzUDDKo1FjXXE2vVCCbo4cNaQbX+XLr3BXSRoMIdGM
         REbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jy91lBd2o62ALGBn0eaH66yNnT/yAb6AVAlb8VYMlO3VKvYCdXeyVszXY+zk2ziczp5PRU88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ZT+TIBDyjDl/bRCC+DH/M//UIb+pwwEVpQQp5TRFd2Ni2xy+
	EOelEOKmsShH2PgIbZK3TtpClkXNq/FeMDG4EiJ+HB4I0kwpWzSRaYLPP2bfUx8lgD3YXtQHGlJ
	fVuqgIQ==
X-Gm-Gg: AeBDiethZLt5j6A6TnUiZ/lwaFAS/3JvZ89unzqr1qCwY7dJ74TBKUJWmOjV0wP9A5F
	+E7+tS2RDcx3z0QXWxPNql8Hev3lUFOGiWJzY5geG9BElUYpovUN7k4l8V/5l2puHmTuXv3hVCy
	W5K9o1CnoKVbCNZ07YDeihJow+i3l06hGBJxtTNfFlXBEzJWyFUWHWG3+KduxCnvgJpo4IZue5c
	7ZB6pMz4FjcfwZQONCc5o0XmOLYfL9kEQA/92lzXha6h5cm7pE41BFQF9tD7/vZWkem7z2BLpdD
	Z8fL6xCL21ZsVhzZ1s4Mk2/qwVntSzs1oacRU3ldaxT1R8DANF2ux0OpAbdzq2+N6OuXIrLP+uL
	toQGCqhNWani5fgoMOK8x4azMxr9vFTCG804ydVkdk/XSDGTSdyxK99/S4j4NDQ61M58duofwMf
	yINL5fwoQV1uXMDP2HvPoG5zTkhTvGpUiN6GhjT9eq1j9zf7lUdruP7Q2iz8fEa0AvzUGyWFLTN
	pAN1g8Y3fs=
X-Received: by 2002:a17:907:742:b0:bad:ad5:300a with SMTP id a640c23a62f3a-bbffc689a52mr651373566b.26.1777934855475;
        Mon, 04 May 2026 15:47:35 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe69f6b7f6sm434857766b.3.2026.05.04.15.47.34
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 15:47:35 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso1583492f8f.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 15:47:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/bRYAet76hYUB2wyCvkq1rldTa7DPVTOSFQoW90vJVjycnvt5nodBvzHari6ohlhkESMD7KCU=@vger.kernel.org
X-Received: by 2002:a05:6000:44d7:b0:44d:821:1a0b with SMTP id
 ffacd0b85a97d-44d08211b96mr10576224f8f.29.1777934853301; Mon, 04 May 2026
 15:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
 <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
 <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
 <151c1c1d52fce8c3b1dac3a919be3086ce3426df.camel@iscas.ac.cn>
 <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
 <d349eb9a8632d847eca48ece1e6c88b717dddde1.camel@iscas.ac.cn> <CAD=FV=USy4DWrkKrhqbUGR5JWJzcJz_J1PVt0Z=o_LVn_iON-w@mail.gmail.com>
In-Reply-To: <CAD=FV=USy4DWrkKrhqbUGR5JWJzcJz_J1PVt0Z=o_LVn_iON-w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 May 2026 15:47:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-LPUGyuEYS1fj7N+x-bHExVGQb+K0Y+BghSTALFCXXg@mail.gmail.com>
X-Gm-Features: AVHnY4ImODE6ejb7j0AN2nutpolTGLLLL7T5afsRsY5Tf0sxdNKbt3HVLiqE74Q
Message-ID: <CAD=FV=U-LPUGyuEYS1fj7N+x-bHExVGQb+K0Y+BghSTALFCXXg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5E3364C4929
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-243928-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi,

On Tue, Apr 28, 2026 at 1:52=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> > > > > > > > Cc: stable@vger.kernel.org # 6.11+
> > > > > > > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out
> > > > > > > > as
> > > > > > > > separate driver")
> > > > > > >
> > > > > > > This "Fixes" looks wrong. The bug was still there even before
> > > > > > > the
> > > > > > > driver was broken out. ...and it looks like the driver that
> > > > > > > this
> > > > > > > was
> > > > > > > broken out of (panel-boe-tv101wum-nl6.c) still has the same
> > > > > > > bug?
> > > > > >
> > > > > > Yes, but I think the fix shouldn't be propagated to the other
> > > > > > driver
> > > > > > because of the same reason with breaking out the original
> > > > > > driver.
> > > > >
> > > > > ...but doesn't all the same logic apply to the other driver?
> > > > > Nothing
> > > > > ever adds MIPI_DSI_MODE_LPM back in.
> > > > >
> > > > > Even if you don't fix the other driver yourself right now, the
> > > > > proper
> > > > > "Fixes" tag is when the problem was introduced, not when the
> > > > > driver
> > > > > forked out.
> > > >
> > > > I think the Fixes tag should point to where the driver is forked
> > > > out,
> > > > and if I'm going to send a patch for panel-boe-tv101wum-nl6, it
> > > > will
> > > > has a Fixes tag pointing to the further commit affecting that
> > > > driver.
> > >
> > > You're free to have your own opinion, but that doesn't match my
> > > understanding of the Fixes tag. If you can convince Neil or some
> > > other
> > > drm-misc committer to land your changes with the Fixes tag as you
> > > have
> > > it, then I won't object, but I won't land it. Best of luck!
> >
> > I checked the forking commit, and the forking process doesn't involve
> > moving a `dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM` clause from the pane=
l-
> > boe-tv101wum-nl6 driver to the panel-himax-hx83102 driver, which means
> > that this clause in the new driver is new, and shouldn't be trivially
> > backported to the old driver (because this process will affect other
> > non-hx83102 panels in that driver). Even if the unblanking issue exists
> > before the forking point, the specific code fixed by this commit is
> > created by the forking point (just by copying), instead of the previous
> > commit introducing the starry panel or the initial addition of the LPM
> > masking code to panel-boe-tv101wum-nl6 .
>
> In general in Linux drivers support more than one device. If you have
> a fix for a driver, then you make the fix. You don't couch your fix
> with "if (this_is_the_device_i_tested) do_my_fix()"
>
> Said another way, if we hadn't forked support of this panel into a
> separate driver, then you'd _have_ to be fixing to
> panel-boe-tv101wum-nl6 driver, correct? You wouldn't add a special
> case just for your panel--you'd fix it for the whole driver.
>
> Another argument here is that someone could (conceivably) still have
> an old kernel built from before the driver forked out. Maybe they care
> about supporting "panel-himax-hx83102" panels on their old kernel.
> They'd want the fix tagged so that they could find it.
>
>
> > In addition, this isn't a regression fix, so Fixes tag is only
> > informative for backporting. The previous paragraph has already proved
> > that pointing it further isn't meaningful for backporting.
>
> Sure, it's not a regression, but it's still a fix for a bug in the
> panel driver. I don't know why someone wouldn't want to backport it if
> they were using this panel.

I see you've now also got a fix for panel-boe-tv101wum-nl6.c [1]. If
that patch also lands, then IMO this becomes fine.

[1] https://lore.kernel.org/r/20260503091708.1079962-1-zhengxingda@iscas.ac=
.cn/

Reviewed-by: Douglas Anderson <dianders@chromium.org>

