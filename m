Return-Path: <stable+bounces-241773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGRhOTMe8WlmdgEAu9opvQ
	(envelope-from <stable+bounces-241773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:53:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 422FC48C0FC
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D23CB30A923B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E0535C1B0;
	Tue, 28 Apr 2026 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ba+qhrdP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA43783C0
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409567; cv=none; b=AhxPZ2odWcmJKcv08R2GjlPDsnGRPdSSx2L99GZ7JX6ByZdW/mD0pNpFpKoZP2BcFP4icDOu4By/2qfQkEQlDm9YZDNbckdEU75n/t7/NpzYPJ8p3rwihVwakwrQEbIYwNAKH+MPmOpx8loCpSE+44cDaB6zPr4VjSLDLIGk01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409567; c=relaxed/simple;
	bh=m374ejHVkN8x1TuhNLKUGmcEUyzd0vEuAltwe0+QC9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2O5LChMMnIspuIXM8OxhwwXO+pTCbGTYUn/0UM2DKNo4WjXhrfjhKo7Bxky8UGapsu1X5/q7EITcwEYVJBUvSEjVsgfQ8wQMa/ZyDR5srsLOU9kjvKHcUdDd9DNXH1nJfo1RAvwF+BBPi7sUSoY/ZvElv48KzNBCNsl/ZOov9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ba+qhrdP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so17078224a12.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777409560; x=1778014360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m374ejHVkN8x1TuhNLKUGmcEUyzd0vEuAltwe0+QC9k=;
        b=Ba+qhrdP+UVzmqpyd6qpHbh+pr00R9G9wW4DX2e33QFYo8FrOuqyHde9kAA4+OgbTt
         zxC1ZhsdoaGfPs3CdMz7CyIx5uXL/ZQDCjhvhwvxZ2BPGu6VD/ds+s5/8snmnXaeZzeK
         b1FpyZgVnW0uGdbebQwmLjgymEMT7XDzBTU64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777409560; x=1778014360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m374ejHVkN8x1TuhNLKUGmcEUyzd0vEuAltwe0+QC9k=;
        b=jwHJcXQUz+IQhBdnzYCJC5qndn9S8VvMLNCiTwwafbW4MeJDjPbFe55CnUhsVht0Uu
         Nanzp0AJWTgj9e2SCUZxVF3LCOotvHFljBFopxEZEGxm0qZl3XF2OuhEpkfbZl6Htgfz
         KaRzXzaMh6AW7aJX8ioxH3Gtow/pIkwAmSwz9IefYruwIsdGoHDpnJsp8VYSJhdErZwQ
         GCh4Hct8wg3/nQWNeVGgIWanNTJtsp3mtBXbsA443BYZIqBL/sIyDfWWfZcp9Etvi4sm
         l7uXvHR64SE5U/uFZpcA9DfqGZXkEyPa8XMtc8I4hRcQQiF10GFN8bEnvQXwKUcFu8rP
         qnsw==
X-Forwarded-Encrypted: i=1; AFNElJ/i5zPMOgTDuYrCwmTx4eXZ054EvCXqMFVK0xomGlA+qRDnc3imTJR+6Rqg2rvqq+6RY3MoYPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLiryJH0eiBctkzs1Bvp/RRvc1TVopFXo7zDSP0C+nPPQeDQe
	qqI3Nd6D5o5uNn0DtdzrWZDvolLBfHAkP0RTiFKXxrUFqd77IeIJUKDL0Nwy+eoumTl/VXXIpL/
	ao8jzVvxX
X-Gm-Gg: AeBDietgtFPSB9ClNthPsB0L3dOYX29izrVedbPSiD0NkkX2o9OVgseieipYTs7I78c
	bEO2zrGZrv7NdWJHDo/wcrbY0WDdyMogG2v7SbjGy+spBX5A2kRif5clY7H1+3T+Sf4Cr6snvxf
	/Lgjut0rw143rTVyRVvSPPBamE1o3+KDWliG9s/WlvcSvlyHIhQqTmQrRQrrO19DBIodBE0f3NF
	R7Apyfs/KaVDBWay7G9wjhD62GfxgrcgyQ8OD89R9jLRW946CE4xihyR2dfgc9JGY3NvbN5drbD
	kdA6EmXt7UhWrJVv+bx8YC1K7lqv2IzK7fq8LoF9vQ48etNaaiOPNs3tE2hxP+uS8dOLQ5W9oNg
	IGFsMKu+8YMfwz0c9/O+aRY0GPQEvY8G85Not3PcZ6/lT1OGg8joOOM+TyTQk7SlA/u+koGOlA1
	lXxzKbCirE3mVupHnlVIsT5J2Xdam48KumHEVKggAWV/q2BU/apKXv7ihfdBpTM07OTUlDh+1t
X-Received: by 2002:a05:6402:1f04:b0:672:8ce8:3521 with SMTP id 4fb4d7f45d1cf-679bb04c999mr2364905a12.5.1777409560496;
        Tue, 28 Apr 2026 13:52:40 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22177f30sm49358a12.31.2026.04.28.13.52.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 13:52:40 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43eada6d900so11384976f8f.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:52:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+VBH22nFeFv2/RWUP51L3zAsKr/mAtCMNnGePjs/npw/c+wJ8XW/AMPaZTvBp9CqqiXMDc/zU=@vger.kernel.org
X-Received: by 2002:a05:6000:2f84:b0:43d:1c21:ead5 with SMTP id
 ffacd0b85a97d-4464a16848bmr8613675f8f.22.1777409557072; Tue, 28 Apr 2026
 13:52:37 -0700 (PDT)
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
 <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com> <d349eb9a8632d847eca48ece1e6c88b717dddde1.camel@iscas.ac.cn>
In-Reply-To: <d349eb9a8632d847eca48ece1e6c88b717dddde1.camel@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 Apr 2026 13:52:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=USy4DWrkKrhqbUGR5JWJzcJz_J1PVt0Z=o_LVn_iON-w@mail.gmail.com>
X-Gm-Features: AVHnY4LgWSJRzWB0fzS8RfQGwiEMjDHAlIcbWfHHNuwDg0u8vOyHNSvhg_5QJiY
Message-ID: <CAD=FV=USy4DWrkKrhqbUGR5JWJzcJz_J1PVt0Z=o_LVn_iON-w@mail.gmail.com>
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
X-Rspamd-Queue-Id: 422FC48C0FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241773-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]

Hi,

On Tue, Apr 28, 2026 at 9:12=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 08:56 -0700=EF=BC=8CDoug Anderson=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > On Tue, Apr 28, 2026 at 8:53=E2=80=AFAM Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > >
> > > =E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 08:48 -0700=EF=BC=8CDoug Ander=
son=E5=86=99=E9=81=93=EF=BC=9A
> > > > Hi,
> > > >
> > > > On Mon, Apr 27, 2026 at 10:49=E2=80=AFPM Icenowy Zheng
> > > > <zhengxingda@iscas.ac.cn> wrote:
> > > > >
> > > > > =E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug A=
nderson=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > Hi,
> > > > > >
> > > > > > On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> > > > > > <zhengxingda@iscas.ac.cn> wrote:
> > > > > > >
> > > > > > > When preparing the panel, it seems that it always expects
> > > > > > > commands
> > > > > > > to be
> > > > > > > transferred in LP mode. However, the disable function
> > > > > > > removes
> > > > > > > the
> > > > > > > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> > > > > > >
> > > > > > > As the unprepare function contains no DSI commands, re-
> > > > > > > adding
> > > > > > > the
> > > > > > > flag
> > > > > > > just after disabling the panel should be safe. Add the code
> > > > > > > re-
> > > > > > > adding
> > > > > > > the flag after the two commands for disabling the panel are
> > > > > > > sent.
> > > > > > >
> > > > > > > This fixes screen unblanking (after blanking once) on
> > > > > > > mt8188-geralt-ciri-sku1 device.
> > > > > > >
> > > > > > > Cc: stable@vger.kernel.org # 6.11+
> > > > > > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out
> > > > > > > as
> > > > > > > separate driver")
> > > > > >
> > > > > > This "Fixes" looks wrong. The bug was still there even before
> > > > > > the
> > > > > > driver was broken out. ...and it looks like the driver that
> > > > > > this
> > > > > > was
> > > > > > broken out of (panel-boe-tv101wum-nl6.c) still has the same
> > > > > > bug?
> > > > >
> > > > > Yes, but I think the fix shouldn't be propagated to the other
> > > > > driver
> > > > > because of the same reason with breaking out the original
> > > > > driver.
> > > >
> > > > ...but doesn't all the same logic apply to the other driver?
> > > > Nothing
> > > > ever adds MIPI_DSI_MODE_LPM back in.
> > > >
> > > > Even if you don't fix the other driver yourself right now, the
> > > > proper
> > > > "Fixes" tag is when the problem was introduced, not when the
> > > > driver
> > > > forked out.
> > >
> > > I think the Fixes tag should point to where the driver is forked
> > > out,
> > > and if I'm going to send a patch for panel-boe-tv101wum-nl6, it
> > > will
> > > has a Fixes tag pointing to the further commit affecting that
> > > driver.
> >
> > You're free to have your own opinion, but that doesn't match my
> > understanding of the Fixes tag. If you can convince Neil or some
> > other
> > drm-misc committer to land your changes with the Fixes tag as you
> > have
> > it, then I won't object, but I won't land it. Best of luck!
>
> I checked the forking commit, and the forking process doesn't involve
> moving a `dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM` clause from the panel-
> boe-tv101wum-nl6 driver to the panel-himax-hx83102 driver, which means
> that this clause in the new driver is new, and shouldn't be trivially
> backported to the old driver (because this process will affect other
> non-hx83102 panels in that driver). Even if the unblanking issue exists
> before the forking point, the specific code fixed by this commit is
> created by the forking point (just by copying), instead of the previous
> commit introducing the starry panel or the initial addition of the LPM
> masking code to panel-boe-tv101wum-nl6 .

In general in Linux drivers support more than one device. If you have
a fix for a driver, then you make the fix. You don't couch your fix
with "if (this_is_the_device_i_tested) do_my_fix()"

Said another way, if we hadn't forked support of this panel into a
separate driver, then you'd _have_ to be fixing to
panel-boe-tv101wum-nl6 driver, correct? You wouldn't add a special
case just for your panel--you'd fix it for the whole driver.

Another argument here is that someone could (conceivably) still have
an old kernel built from before the driver forked out. Maybe they care
about supporting "panel-himax-hx83102" panels on their old kernel.
They'd want the fix tagged so that they could find it.


> In addition, this isn't a regression fix, so Fixes tag is only
> informative for backporting. The previous paragraph has already proved
> that pointing it further isn't meaningful for backporting.

Sure, it's not a regression, but it's still a fix for a bug in the
panel driver. I don't know why someone wouldn't want to backport it if
they were using this panel.

-Doug

