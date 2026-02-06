Return-Path: <stable+bounces-214673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHbeKJoXhmk1JgQAu9opvQ
	(envelope-from <stable+bounces-214673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:32:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8D1004D5
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 17:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850C0305E316
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA3329C40;
	Fri,  6 Feb 2026 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YCgRF+KS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E832A3F3
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395244; cv=none; b=VQLM5KEdJ6wXdy3Y4YTFsWMyLLy9ByE73u83TdXaD73J9JU4EgvP9wBVUYObq+v5YJAfUyp0d83OnKccY2xiP8pQxJg8sZ/nqvRwnzJGQave6pXcPfFIwD1Of8DmB31EoVnRlLnYBZnP5yR3NyMoPaj4iaELDg/sMtENK5U7HwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395244; c=relaxed/simple;
	bh=dYZTjgA9JdpCffrdYTTuAdue8ybBgkAVNbTbes9jpTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMVN8ffMNJvT/pAvhybS0IF+zd0SuF+1yLoJ67QyApzvtbdr61wxCdf/XgwNl0D26JyXLR+uhk7QNSxoHN//d7tH+KZZt8pQ0O8GmJiVu2vIgZ+W0MrK+bpZVrnVnc50hJKlhjUxK0G50R5/ABgx2y/3B/IVOzTV3ksIyng1Tw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YCgRF+KS; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so1433132a12.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770395240; x=1771000040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEqAwzXehbVzchYDAND90vGdwFH8r/bqM6A6cnJ3VvQ=;
        b=YCgRF+KSoSzD/0i/+9SOzA4BQ9rrOnfgS9wZUP23k4ZEJ8YXKIDx2Iv0DaPpD5ABSm
         aCShbOH1bgLsKAhwD98ohiuiu+K6vqrn2jiyxsXmFG/Cx+FVlQEkf3E0YwbliLBGHqFu
         97o5C8LJAy1OsGeg680UE8uZaXAaBVKSqE8O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770395240; x=1771000040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lEqAwzXehbVzchYDAND90vGdwFH8r/bqM6A6cnJ3VvQ=;
        b=SOVnrOfEQAjTH4QcfIqfQxdziHjRbmTtDrLIsDnEuKQCfsft4F71ETb7WGqA3xIdzN
         DUOoOPTTrZyJ3O8zyZ1sjF6RioFC+pbsN1MbJZaTy/wFMHoeB7SuN74j7cnaJQM12/sJ
         y2rhlXPVZWCk4edfwTTjRxUTKjzS6skKn0QFLHpHVmMb25zXFulmt8490c7xCbSEXyOb
         Jh5Gd9rJNmKw9Cz8/3QXEpgcs5sqX8fSibijHMT6Liwryifqo3smPt539j/96Of6VY8F
         nty1B9m5anvtHSLxpYuLoHfqlzeZ4JGMUtSfVXHgV7sMK29jrOY3YrV5KEkzu9zwfh19
         9DfA==
X-Forwarded-Encrypted: i=1; AJvYcCV+mzXDMdiCfkTznJ8GRLH2SXv68DwMF7TszQGft1z42/vA1GEGJBwsygIPQQS6my2e93H88Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwegXPxC3gz2crl4TiO3Dml3NKEBzeqy3GdwXvLvQM3/p6ZCA64
	RWkPeDX9z6wyBW2oTNbaNv3GJZoF6W9a74guulsosZ+lgfVnKM4jS+bnWEJh3yz8seVxxMb26os
	4Qhc9eUko
X-Gm-Gg: AZuq6aIHs33oR6vbJngX34FqbBrgCCB2daAjSvonGKtbMxPwtSmexWCBGu+HhumHU7G
	aAYfyN+61AXzUiHz/JWlq9r0IGDEatJvabBWnB5Tk857VfnB9LLmJAxx6lx41FemitOYo8J19eR
	OpJEJ5fXL4CFkSI8Tct44R+fAJ3F+lWskodPrKAZshZdx9t86GXc5Ej/ueUGrP4ThBWle1dAPa3
	6p93Byz8MGt7Lxou4YEYrPN8YL4Q2mu/Az2tJ9Q8Ldz2rOmDwJXd/TzU/aRsHx9snkBcUkhRTRY
	VBbq+4PMNEjUilo06HH39bljJSvLlcFaMnfzbNH7FF8yMTIOBuGxEzKq1qXPmbO3JCWGsAeIYAW
	Kww02tIF+T5qs4Ii72WLV0QBqzvlrtQ5UiF1UMjOt8H/7qM+1XEWP/YU2Jq1w+7c2HJHSN9ib+G
	7pHCbSunYz2Ch4dyFSFEBPz2DCSI+mvz2cCY6pADl0/i82VHYkhA==
X-Received: by 2002:a17:907:3e13:b0:b87:716:8b15 with SMTP id a640c23a62f3a-b8edf3a676fmr188316166b.60.1770395240335;
        Fri, 06 Feb 2026 08:27:20 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda748254sm92212766b.5.2026.02.06.08.27.19
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 08:27:19 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359228b7c6so647462f8f.2
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 08:27:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeWEZHd+uhvejjMeMVws+YpaumsA8bzIEQu+Z1T3RHG3S79w6Qs29MK5nAiFvkMCc1VYJh+AE=@vger.kernel.org
X-Received: by 2002:a05:6000:1848:b0:435:aaba:b8e9 with SMTP id
 ffacd0b85a97d-43629017c58mr4513452f8f.0.1770395238489; Fri, 06 Feb 2026
 08:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206123758.374555-1-fra.schnyder@gmail.com>
 <CAD=FV=UO3wHqGKep67pY04PgBJKgvOgDf8u1qxeXmWkgVMLXiQ@mail.gmail.com> <20260206161054.GA101724@francesco-nb>
In-Reply-To: <20260206161054.GA101724@francesco-nb>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Feb 2026 08:27:07 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VvePQt9LgupM+hW72doRja4UPBj6sBXUh091yHFxcxVw@mail.gmail.com>
X-Gm-Features: AZwV_Qgm-zXegQuSpVm1x9sbLixy4tTG3qVrk--0qkuaZQnLYdiCiKMrx8LFrHU
Message-ID: <CAD=FV=VvePQt9LgupM+hW72doRja4UPBj6sBXUh091yHFxcxVw@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214673-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,toradex.com,lists.freedesktop.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,chromium.org:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dolcini.it:email]
X-Rspamd-Queue-Id: 0BD8D1004D5
X-Rspamd-Action: no action

Hi,

On Fri, Feb 6, 2026 at 8:11=E2=80=AFAM Francesco Dolcini <francesco@dolcini=
.it> wrote:
>
> Hello Doug,
>
> On Fri, Feb 06, 2026 at 07:46:10AM -0800, Doug Anderson wrote:
> > On Fri, Feb 6, 2026 at 4:38=E2=80=AFAM Franz Schnyder <fra.schnyder@gma=
il.com> wrote:
> > >
> > > From: Franz Schnyder <franz.schnyder@toradex.com>
> > >
> > > Fallback to polling to detect hotplug events on systems without
> > > interrupts.
> > >
> > > On systems where the interrupt line of the bridge is not connected,
> > > the bridge cannot notify hotplug events. Only add the
> > > DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
> > > otherwise remain in polling mode.
> > >
> > > Fixes: 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add support for Displ=
ayPort mode with HPD")
> > > Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPo=
rt connector type")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > > ---
> > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > It's weird that you have two fixes, but upon closer inspection, I see
> > why you tagged it as you did.
> >
> > The first commit that landed, commit 55e8ff842051 ("drm/bridge:
> > ti-sn65dsi86: Add HPD for DisplayPort connector type"), was still
> > using polling mode and just using the HPD line for polling. That
> > commit incorrectly set the flag "DRM_BRIDGE_OP_HPD". So the proper
> > backport to kernels with just that commit would be to take away that
> > flag. Unfortunately, I didn't notice this problem during the review
> > and I don't personally have any hardware using this bridge for DP,
> > only eDP.
> >
> > The second commit that landed, commit 9133bc3f0564 ("drm/bridge:
> > ti-sn65dsi86: Add support for DisplayPort mode with HPD"), actually
> > added support for the HPD interrupt. After this commit, your fix
> > (which makes the flag "DRM_BRIDGE_OP_HPD" depend on the IRQ) is the
> > correct one.
> >
> > Unfortunately, I think the above will confuse the stable scripts.
> > Since your patch applied cleanly atop the first commit then it will
> > picked to any kernels with it, even if they don't have the second
> > commit.
> >
> > I think the first commit landed in v6.16 and the second commit isn't
> > yet in any stable release.
> >
> > Maybe the right way to look at this is to just call the 2nd patch a
> > prereq? So this:
> >
> > Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for
> > DisplayPort connector type")
> > Cc: <stable@vger.kernel.org> # 6.16: 9133bc3f0564: drm/bridge: ti-sn65d=
si86: Add
> >
> > That will cause the 2nd patch to get picked up for stable too, but
> > that would be preferable to having just your fix without the 2nd
> > patch. Alternatively, you could try to add some other note to the
> > stable team to help them arrive at the right backport.
>
> We had some internal review before sending this patch and I am the one
> that suggested to put both commit as fixes in the end.
>
> I agree that your solution is the correct one (I am not familiar with
> the syntax there, but I agree on the concept), assuming
> nobody disagree on this, should we send a v2, or are you going to amend
> the commit message when applying it?

You can see the docs at:

Documentation/process/stable-kernel-rules.rst

As long as you agree with what I came up with, there's no need for you
to resend and I can adjust it when I land the patch. I'll still let it
sit on the list for at least next week to give others a chance to
review / comment.

-Doug

