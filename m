Return-Path: <stable+bounces-47519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628B88D1062
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 00:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC842823D8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 22:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C986A33A;
	Mon, 27 May 2024 22:52:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4B1DFE4;
	Mon, 27 May 2024 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716850341; cv=none; b=rwx+oOlzQMZKxY5DE+L/UeybWwhRT0+mBw3HGdX/w9mftzpoMwRu7wYdh9/ovg1UktYqXnApRgZgpwPdSC6X8hjzPA9JdohxMlyuGzjNWGGfGcZJet2S4tlVMwrgYJQRWaEJ+DmkV7ijEO2hEndhpB/+ybgGRHGvMD6A8IYe/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716850341; c=relaxed/simple;
	bh=B/ujHKF4cYcDAPAD7yF5zk3E89zp7t8vYX9ezPn+xZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCoFCEAG3vEL69rcZUSo76bBUKgKHs3qvgEuoqrehVNqG0bGlT5V9WS7jWKVu9YHnSY674gfHVS6xJ0ZgSTWKcx4QIa/7/HKVDUQJKDjYSDGJTD9oHbWmbnuxx2xta6iWfAv08ZbickY8CQoTUExTn+ZS2XlKnIpj/Mx1Bpm5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193d.versanet.de ([94.134.25.61] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sBjC4-0005YB-Ez; Tue, 28 May 2024 00:51:52 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Val Packett <val@packett.cool>
Cc: stable@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/2] drm/rockchip: vop: clear DMA stop bit upon vblank on
 RK3066
Date: Tue, 28 May 2024 00:51:51 +0200
Message-ID: <2972856.VdNmn5OnKV@diego>
In-Reply-To: <BF06ES.TD22854ZPLB92@packett.cool>
References:
 <2024051930-canteen-produce-1ba7@gregkh> <1817371.3VsfAaAtOV@diego>
 <BF06ES.TD22854ZPLB92@packett.cool>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hey,

Am Dienstag, 28. Mai 2024, 00:13:59 CEST schrieb Val Packett:
> On Mon, May 27 2024 at 22:43:18 +02:00:00, Heiko St=FCbner=20
> <heiko@sntech.de> wrote:
> > Am Montag, 27. Mai 2024, 09:16:33 CEST schrieb Val Packett:
> >>  On the RK3066, there is a bit that must be cleared, otherwise
> >>  the picture does not show up
> >> on the display (at least for RGB).
> >>=20
> >>  Fixes: f4a6de8 ("drm: rockchip: vop: add rk3066 vop definitions")
> >>  Cc: stable@vger.kernel.org
> >>  Signed-off-by: Val Packett <val@packett.cool>
> >>  ---
> >>  v2: doing this on vblank makes more sense; added fixes tag
> >=20
> > can you give a rationale for this please?
> >=20
> > I.e. does this dma-stop bit need to be set on each vblank that happens
> > to push this frame to the display somehow?
>=20
>=20
> The only things I'm 100% sure about:
>=20
> - that bit is called dma_stop in the Android kernel's header;
> - without ever setting that bit to 1, it was getting set to 1 by the=20
> chip itself, as logging the register on flush was showing a 1 in that=20
> position (it was the only set bit - I guess others aren't readable=20
> after cfg_done?);
> - without clearing it "between" frames, the whole screen is always=20
> filled with noise, the picture is not visible.
>=20
> The rest is at least a bit (ha) speculative:
>=20
> As I understand from what the name implies, the hardware sets it to=20
> indicate that it has scanned out the frame and is waiting for=20
> acknowledgment (clearing) to be able to scan out the next frame. I=20
> guess it's a redundant synchronization mechanism that was removed in=20
> later iterations of the VOP hardware block.
>=20
> I've been trying to see if moving where I clear the bit affects the=20
> sort-of-tearing-but-vertical glitches that sometimes happen, especially=20
> early on after the system has just booted, but that seems to be=20
> completely unrelated pixel clock craziness (the Android kernel runs the=20
> screen at 66 fps, interestingly).
>=20
> I'm fairly confident that both places are "correct". The reason I'm=20
> more on the side of vblank now is that it made logical sense to me when=20
> I thought about it more: acknowledging that the frame has been scanned=20
> out is a reaction to the frame having been scanned out. It's a=20
> consequence of *that* that the acknowledgment is required for the next=20
> frame to be drawn.
>=20
> Unless we can get the opinion of someone closely familiar with this=20
> decade-old hardware, we only have this reasoning to go off of :)

Actually that reasoning was exactly what I was hoping for :-) .
And it actually also makes perfect sense.

I was somehow thinking this needs to be set only when starting output
and not as sort of an Ack.

Could you do a v3 with:
=2D the findings from above slightly condensed in the commit message
  It's really helpful when someone stumbles onto that commit 10 years
  from now and can get this really helpful explanation from the commit
  message.
=2D sending it as a _new_ thread
  Having v2 as reply to v1 patches confuses tooling that then can't
  distinguish what is actually part of this v2


Thanks a lot
Heiko



