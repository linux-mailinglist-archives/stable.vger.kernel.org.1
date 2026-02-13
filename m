Return-Path: <stable+bounces-216303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q4CwNIGNj2kXRgEAu9opvQ
	(envelope-from <stable+bounces-216303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:45:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70A1397F6
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 21:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28C17300CE58
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 20:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139CA292936;
	Fri, 13 Feb 2026 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ocYSIMSD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975D23D7DE
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015549; cv=none; b=WOU29uNPPDlWK0zCCN3EJrEK0IjjjqVkBvDnfh7y2ZRx8IlALd2UQIV5We6rQqWEiSyODiPqGYbVxI1g11TKkQwYqAj1DqtKmsJWgNrnxs2NdSIlSrZuyL/F5E5ejgNxyKAUuQ85DwlDKR+0DC//hU1UHaBP96DMKyRfEz2gbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015549; c=relaxed/simple;
	bh=c2o3xvzaFC1vtmKRDDpssLBV4e9Kpxk5xotqAOeCwO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXKub4A08fGLezNRlJt6WWP3zkWSD6JCM3rYnqAEfnBV9aPMuarc7t9WxjcKLOuLc2D+XC5hixbKFaTRWlpH8IdIDXvQq8Jk1Zb0p3b6be1EBGy6OAs0jOw9uIi44lABbkefieJJKRvcqJGT7DDtNsVI+sYirS7WV8MsrZreJtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ocYSIMSD; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-65a196a735eso2464825a12.2
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 12:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771015545; x=1771620345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjReM9ADg6zhlxMDPHdkasEcLNhY554Cqko3b+W+YjU=;
        b=ocYSIMSD6VN3dRYTgyv33tQ6FyOXBLFA90eHQeTYPY7ksTxyYKPSkIVfY+yu5dZuTJ
         5PLwjsAEcijPePBHo2l8sjbEli1tRvamCm0eRX9bKWF7rO8ZtykRUVbgiwHRtaLh9ZrP
         aMbB1Vg3u4ZXsn8RGqax8PT7SMdtBJHjVjfNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771015545; x=1771620345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XjReM9ADg6zhlxMDPHdkasEcLNhY554Cqko3b+W+YjU=;
        b=lxkgC5nJNZCTv5yRN2+/HPcMEhG4k1osBZcheWYcouSVkkK5vIUNiaEVSI2hlCfwys
         XpFOblbpVjMECfLr+jotFPHNVu12oOYqczVtZcjEPom3tjhe4RXlYik4RREM8WP18Nri
         6WinpQ1mbUhpNY9hAXh4Wu5vnFXjSElsn/AuvDUHih7yufn10HdiTyz5PNQZ+Mm+/p3l
         1wmAkBk3Amurb2fWBpjcsQ/ozIzEJ+wTG4+yxgTiwl72zxPQ7FTAH05E3QMSG5SvNjys
         koK7oFIA5T/azzBJkuKNnE3mhP8MqcX75V8ojCaNPu5dKAem+saXIO2eJUAdXFmhTYWm
         gbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaNeWjPvHc6VHkW0zh9U3Tvt8sVqiRsMMH4+1zWVvm0nMoj67NG+ivk15kQSWyBK14CX58rvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTubmgQ7K83yjP7IsPQnljd3rXpVInnTeRm67FKp9hgTS2x7tz
	3FjtP2SrmUjJ9hFUNhvbOVHRx4/cHWIMe9GjpaLRQBHjL/z1FDfbG4wCiayTgVPGTsZfWTzbHg1
	KOqWe63SG3sY=
X-Gm-Gg: AZuq6aJ9cG3TAmgrMWTun6g9nK8zIFRSwcoHZYf8oogDtNeKqBHevPcW0QDg9Pn1do4
	ilZgPoHqYXu9KKEwRuOy4NVrORmDeO1l5yu8/+l5tUQWhIe6AjJKnf+ftRfpW5WaWGZvqDuXXH7
	hm6G99E3DbhXy14LqIeKzVveW35ttrMLArykvtDv1kMSvLcjB50CfmCDEl+EYf4hQzQJJf0gtdr
	+qtszr078n50C+YE/Xp37ivKefdmgL9FX5q51KfjqrjaDX5IHIhLhgSCbMwFEExJn7OZkfCNgTm
	Wk8qT61I2+rCNwCeGzj3/k0vGJoS43J4VlvNfsnXVaA3xD/yBM/0tSZmOFER6lShR4+KJoJyPIl
	0hnCl/2rNU8G/yIotYlW0UG9D8LnDIv0gHm9bcFhKkCQXvq/Stb+2sTDB7fg+fbZcS0KSHGF2do
	CaEQSouhMP5KZGoLXDOlxm0T7leuZ0S3sNlaFjkdGECaylRUAUxL8h8xLiJNJgUmtVbdWU6O8W
X-Received: by 2002:a05:6402:34cd:b0:658:cbf0:6a08 with SMTP id 4fb4d7f45d1cf-65bc7881b3emr271537a12.17.1771015545020;
        Fri, 13 Feb 2026 12:45:45 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad3e3538sm1074949a12.20.2026.02.13.12.45.43
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 12:45:43 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48379a42f76so1720735e9.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 12:45:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdw2QnTCVPaJIQJvRA+RKsgI35xp3YrhUu/PXyxCxnRGEG3Wh4hLki+LZc81wxeEicP5G/UKQ=@vger.kernel.org
X-Received: by 2002:a05:6000:144b:b0:431:808:2d58 with SMTP id
 ffacd0b85a97d-4379db98611mr1384034f8f.51.1771015542925; Fri, 13 Feb 2026
 12:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206123758.374555-1-fra.schnyder@gmail.com>
 <CAD=FV=UO3wHqGKep67pY04PgBJKgvOgDf8u1qxeXmWkgVMLXiQ@mail.gmail.com>
 <20260206161054.GA101724@francesco-nb> <CAD=FV=VvePQt9LgupM+hW72doRja4UPBj6sBXUh091yHFxcxVw@mail.gmail.com>
In-Reply-To: <CAD=FV=VvePQt9LgupM+hW72doRja4UPBj6sBXUh091yHFxcxVw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Feb 2026 12:45:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VLNXWT2_e=nk2MsQVmFCuJmw9sgDAwntGo0nE0Q3sADQ@mail.gmail.com>
X-Gm-Features: AZwV_Qiw3C9EmV38eXLLKegttFQVVJNwB5dzTwKeOXTHmmgbU3iR_KdDERbJVB4
Message-ID: <CAD=FV=VLNXWT2_e=nk2MsQVmFCuJmw9sgDAwntGo0nE0Q3sADQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is
 not used
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Franz Schnyder <fra.schnyder@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Franz Schnyder <franz.schnyder@toradex.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216303-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,toradex.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dolcini.it:email,chromium.org:email,chromium.org:dkim]
X-Rspamd-Queue-Id: 2A70A1397F6
X-Rspamd-Action: no action

Hi,

On Fri, Feb 6, 2026 at 8:27=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Feb 6, 2026 at 8:11=E2=80=AFAM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
> >
> > Hello Doug,
> >
> > On Fri, Feb 06, 2026 at 07:46:10AM -0800, Doug Anderson wrote:
> > > On Fri, Feb 6, 2026 at 4:38=E2=80=AFAM Franz Schnyder <fra.schnyder@g=
mail.com> wrote:
> > > >
> > > > From: Franz Schnyder <franz.schnyder@toradex.com>
> > > >
> > > > Fallback to polling to detect hotplug events on systems without
> > > > interrupts.
> > > >
> > > > On systems where the interrupt line of the bridge is not connected,
> > > > the bridge cannot notify hotplug events. Only add the
> > > > DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
> > > > otherwise remain in polling mode.
> > > >
> > > > Fixes: 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add support for Dis=
playPort mode with HPD")
> > > > Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for Display=
Port connector type")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > It's weird that you have two fixes, but upon closer inspection, I see
> > > why you tagged it as you did.
> > >
> > > The first commit that landed, commit 55e8ff842051 ("drm/bridge:
> > > ti-sn65dsi86: Add HPD for DisplayPort connector type"), was still
> > > using polling mode and just using the HPD line for polling. That
> > > commit incorrectly set the flag "DRM_BRIDGE_OP_HPD". So the proper
> > > backport to kernels with just that commit would be to take away that
> > > flag. Unfortunately, I didn't notice this problem during the review
> > > and I don't personally have any hardware using this bridge for DP,
> > > only eDP.
> > >
> > > The second commit that landed, commit 9133bc3f0564 ("drm/bridge:
> > > ti-sn65dsi86: Add support for DisplayPort mode with HPD"), actually
> > > added support for the HPD interrupt. After this commit, your fix
> > > (which makes the flag "DRM_BRIDGE_OP_HPD" depend on the IRQ) is the
> > > correct one.
> > >
> > > Unfortunately, I think the above will confuse the stable scripts.
> > > Since your patch applied cleanly atop the first commit then it will
> > > picked to any kernels with it, even if they don't have the second
> > > commit.
> > >
> > > I think the first commit landed in v6.16 and the second commit isn't
> > > yet in any stable release.
> > >
> > > Maybe the right way to look at this is to just call the 2nd patch a
> > > prereq? So this:
> > >
> > > Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for
> > > DisplayPort connector type")
> > > Cc: <stable@vger.kernel.org> # 6.16: 9133bc3f0564: drm/bridge: ti-sn6=
5dsi86: Add
> > >
> > > That will cause the 2nd patch to get picked up for stable too, but
> > > that would be preferable to having just your fix without the 2nd
> > > patch. Alternatively, you could try to add some other note to the
> > > stable team to help them arrive at the right backport.
> >
> > We had some internal review before sending this patch and I am the one
> > that suggested to put both commit as fixes in the end.
> >
> > I agree that your solution is the correct one (I am not familiar with
> > the syntax there, but I agree on the concept), assuming
> > nobody disagree on this, should we send a v2, or are you going to amend
> > the commit message when applying it?
>
> You can see the docs at:
>
> Documentation/process/stable-kernel-rules.rst
>
> As long as you agree with what I came up with, there's no need for you
> to resend and I can adjust it when I land the patch. I'll still let it
> sit on the list for at least next week to give others a chance to
> review / comment.

Pushed to drm-misc-fixes with the updated Fixes / stable line.

[1/1] drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used
      commit: 0b87d51690dd5131cbe9fbd23746b037aab89815

