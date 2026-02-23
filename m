Return-Path: <stable+bounces-217736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOSWHNc/nGlLCQQAu9opvQ
	(envelope-from <stable+bounces-217736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:53:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C92CC175BBC
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE903077E7D
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECD364E9D;
	Mon, 23 Feb 2026 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdJl8l2Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC33612F5
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847549; cv=pass; b=GjsvVqTlAVlsHRuAk+NUG9nMZ7y3XVX9iktT8ZiKrsyEnxpUtB2Pkb0A+ambUk9/WRmNUb0D1sBFf9Xo2nOClKDViXpxhb3uoTDZEGC6QdzPfSwrVW+q0fGeLYQ4aqothwxHiNTni8dwZguf213GH6W8h0Q7xdowFyLUfqfTT54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847549; c=relaxed/simple;
	bh=+d1Gsvyn8shZSpEx0gTkDzpXXrDC99n6t6b6nk1CH4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOlLV4DCL+CAV/eN97pbkO+hHPvg6p2Nij408AUyuxSjfG+/l34MkkyRwkcBGdtUofg4B2we/HkhwWLAS6ZjufbXxqAWMCdP/P5NfE74oF1gSlAy5tdM/SWd5HWh3ECeGtqUcfax3fX6rvLF97asUdwbF4sLLIHAqYdEzoSpX/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdJl8l2Q; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5665171836cso5092775e0c.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:52:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771847546; cv=none;
        d=google.com; s=arc-20240605;
        b=RMCA/yMrA104UijH7tYBOVmdeetTbW4ABIFzR4AXOJanMdnCDnmv1FCtbmu1NyU6N8
         r5ovlMDzYzUr9n9m9SDXhWuIFqAw9NnvW/AolU1cCJiPOaR0EwF0WqVWKcxqx8ZfAGL1
         XQZLQtTffsAq0s3Gb3ZjbHrNEYRvbFUWEGIBpHKg/pDBmaZ2+HLm8/cJcvZ4T8LN0VrH
         bbFtppyOOf6ikgII1dV/Qjl9vWQ37PQCTxKj7lP9Nxc9DQVenVZdSbFvRqp0/V5rVKpD
         qdliAx84es69iKX3PX2lGyQzZnljvyVUely6d9hTphwE8N2oyGWIMjBoLCM98iEvTriK
         gzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VGP11KQ2dHKSZizL7MNew2Tz13D8uXvvu4p+lY24KEM=;
        fh=tWjkItap8BCfuwsF0mlP6VUoAtKg7H1/t0Xm4aw5xLc=;
        b=JTFDva+tdoCRND0b5B4qvrmcTqos9d+uJkRNqLSi5q/c3bllMlfBZMvnGiiyH8vLdt
         zNHWUAVqa9nF8mjG9omNt1/f2eMXM3aQL1eqRLymhidD8MPGooBCyWZV3b0h42zXjKFj
         4XOoDwfEfs2Vu9Y7nvHt6wS/Kxis36nCxvU5EKyP5CMNIj+b+zEBTSgzqb4vUEnwM8sm
         gUxmVEYuS3DokKTx8bMQLVoSs+sC9+gmLoZvp5DNw5pnRbrBfR95cOXGpXz4cb4rp2Qa
         mzOFipuXNSGXOD6cnWfa15o4B3s5rn/xtDyC2Z/AOXGy1pUL7zeVpRCy6Yw+98rQt2So
         Nk0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771847546; x=1772452346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGP11KQ2dHKSZizL7MNew2Tz13D8uXvvu4p+lY24KEM=;
        b=SdJl8l2QMJn/VU+mTyUzHNxQy6JuPSh+scKd7W1IfTFQwiE3YjeJ1jbmy4gWvqCeco
         iGVdyh/woxtkDEOZCh0qgb/vJ3O3QFq2B5tBKa8dFLhfvqUabEVfGcGJ4pK2hAsnGBOh
         dMWS81ePtRWe5t4s1tcAuffVJ5/pzB5vONQ8nAl3Axm79NS2ScR1gh0Kjv5C/6eLtayU
         QtJWALveyZYv2fPrBBfmRxvtSR0juoXb3j21C1SVVvwzphUMDBzuPdnJ8YI1/LPSNiPT
         ngqOYR5LgX8IN47IlqL5q1Yjo8mjhGHENxLUfjtZTwNUV1HPWDrNPCpQ6tgO+sdh2q8Y
         atFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771847546; x=1772452346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGP11KQ2dHKSZizL7MNew2Tz13D8uXvvu4p+lY24KEM=;
        b=QT6vYL6GRW3nV3VDaPcQM8x8tK5TOrY1ZcaiY8PSg9nLvnXjfS6KzzxRPd9AOdY6v2
         evgJOPXD3US9o0Hig6r6r5hCrA6m4c8RLnIs9BXR16bq8E/lBKyo+1ROWZ9i4KDIUNIL
         AKXqEGyWWfmQk5h+QqWblH4L759LIZo5Eo5VWs+XqhpZ+2aODxpvq0Gg1/gJ/wQcYkC1
         glQy0N7cUX91ApHwVVFtuqDRjqEeAyzs5Gg+y+9U8jVYKTxoSX17206ZoJjlesln7maX
         B0Fir7EhH62IxOnnaDBacmmwQy4u498lDzETJMT+r8SAcmJ9lzCF0NUoyzSlqMlY8EyG
         u3yg==
X-Forwarded-Encrypted: i=1; AJvYcCX1GKqRT3OLWDPPH+HfnaNJvxWNfmco9B2pl+It2HZb+X7LCPoCwST4bKK2z2gAD8/QmCc8B3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOnosvLhxmXWdbIYc6jHugDfBpKGwyS7XIzdW73w5rQEoRLgV
	Rbld72bznFQGs4vhDPdIqjdABu8oh4JB9mGOOYoz5ORJQ52mHhcz51gzC4iavYJ5dNWBWFah96s
	StoC4QALGzvl+D3YM2WP55mWL0PqaRxc=
X-Gm-Gg: AZuq6aJ2zGdBmNIZeu/VjE2WY5EMillkf5OhK+kwuWLr8P2Zyc4ILikcokiy1JrodS0
	SLvO9BYbLatPT7W337JF1lm00107GEIlpBdvaBolNShBefD+CMpkoXG8TP7U/Ie0VAHRb9N814X
	KoLIX/RAqm64eFdQboyO8BFoHo9Ii8Z5Dgv5jE+b0ZTEke310EWqpEuvjEdKEhQy2Zgz/iq3qi0
	ZpwCO1wmBG31D2C+tKY+mcuvvFAWYktc/L3J9iFsIBZ6mpiabfPXsTnGtQS03drcGPdZBCKYK7A
	K5VU6d8VMT3SPb278WHfc4JSMH5jJsStKsAIVwrVim29QRzQ6aWRWEL6UTtYYng+cfiIER6gQyj
	bpcbmS2aiag==
X-Received: by 2002:a05:6102:4194:b0:5eb:fc32:935c with SMTP id
 ada2fe7eead31-5feb2ea40afmr3964742137.3.1771847545558; Mon, 23 Feb 2026
 03:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD0gVBsyzYNA6ydPwg9mJ9VQzYg4zPAi24JQ13-=0KtdbQ039A@mail.gmail.com>
 <CANiDSCsMVE7qAcjcjbjhYSMoyypkR5Nq-ZA-e=CJVY5CUGAG7Q@mail.gmail.com> <068a5363-de97-4d67-94a9-c9a2baed68b0@leemhuis.info>
In-Reply-To: <068a5363-de97-4d67-94a9-c9a2baed68b0@leemhuis.info>
From: =?UTF-8?B?QW5kcsOpcyBQw6lyZXo=?= <andres.f.perez@gmail.com>
Date: Mon, 23 Feb 2026 11:52:04 +0000
X-Gm-Features: AaiRm53kqVqwYlk73dxvSEeN9WnimirsmxYiC5QcBDjE53JtGAA8jfNwC48NL8s
Message-ID: <CAD0gVBs4m9FpBZ9eVcxRK5y601WPkatGE6e9fi1iK0YA=CiMHw@mail.gmail.com>
Subject: Re: [REGRESSION] Display freeze on VT switch back to X11 since v6.16
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217736-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,vger.kernel.org,ideasonboard.com,kernel.org,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,lists.freedesktop.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andresfperez@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,leemhuis.info:email]
X-Rspamd-Queue-Id: C92CC175BBC
X-Rspamd-Action: no action

Thorsten,

It's worth a shot. I'll give it a try and report back.

Andr=C3=A9s

On Mon, Feb 23, 2026 at 8:26=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
>
>
> On 2/23/26 09:10, Ricardo Ribalda wrote:
> > Hi Andr=C3=A9s
> >
> > Thanks for doing the bisecting
> >
> > On Sun, 22 Feb 2026 at 22:56, Andr=C3=A9s P=C3=A9rez <andres.f.perez@gm=
ail.com> wrote:
> >>
> >> # OVERVIEW
> >>
> >> Since kernel v6.16.1, switching from an X11 session to a text VT and b=
ack
> >> freezes the display on a ThinkPad P15 Gen 2. The system remains respon=
sive
> >> over SSH; only the display is frozen. Bisecting identified commit
> >> d1b618e7954802fe ("media: uvcvideo: Do not turn on the camera for some
> >> ioctls") as the trigger. Reverting the logic change in that commit
> >> fixes VT switching
> >> on v6.16.1, v6.17.9, and v6.18.9, but that is not an actual solution. =
Wayland
> >> compositors (e.g., river and sway) are not affected.
> >>
> >> Last good:  v6.15.9
> >> First bad:  v6.16.1
> >> Bisect result: d1b618e7954802fe media: uvcvideo: Do not turn on the
> >> camera for some ioctls
> >>
> >> ## Hardware:   Lenovo ThinkPad P15 Gen 2i (20YQ0031US)
> >> CPU:        Intel Core i7-11800H (Tiger Lake-H)
> >> iGPU:        Intel UHD Graphics (TGL GT1)
> >> dGPU:       NVIDIA T1200 (not involved in eDP output; driver: nvidia-o=
pen)
>
> Could this be caused by nvidia's own driver, even if it is not supposed
> to be involved? Might be worth ruling out with a proper vanilla kernel,
> ideally really fresh, so 7.0-rc1.
>
> Ciao, Thorsten
>
> >> Display:    15.6" 1920x1080 eDP, 10 bpc capable (EDID 1.4)
> >> Webcam:     Integrated Camera on PCH xHCI (Bus 003 Port 004)
> >> Firmware:   LENOVO N37ET61W (1.97)
> >> OS:         Arch Linux, Nix home-manager, X11 + xmonad, no display man=
ager
> >>
> >> ## Symptoms and reproduction steps:
> >> 1. Boot, start X11 on tty1 (startx).
> >> 2. Switch to tty2 (Ctrl+Alt+F2): works.
> >> 3. Switch back to tty1 (Ctrl+Alt+F1): display freezes.
> >>    - Frozen on the last frame shown before switching away.
> >>    - System is fully responsive over SSH.
> >>    - Other VTs switch normally between each other as long as X11 is
> >> not active on them.
> >>    - Killing X does not recover the display. A reboot is required.
> >>
> >> # DEBUG ANALYSIS
> >>
> >> On v6.16.1, the VT switch back to X triggers a full modeset due to pip=
e
> >> configuration mismatches detected by intel_pipe_config_compare:
> >>
> >> [drm:intel_pipe_config_compare] fastset requirement not met in pipe_bp=
p
> >>   (expected 30, found 24)
> >> [drm:intel_pipe_config_compare] fastset requirement not met in dp_m_n
> >>   (expected link 269484/524288, found link 336855/524288)
> >> [drm:intel_pipe_config_compare] fastset requirement not met in dpll_hw=
_state
> >>   (expected cfgcr0: 0xe001a5, found cfgcr0: 0x1c2)
> >> [drm:intel_pipe_config_compare] fastset requirement not met in port_cl=
ock
> >>   (expected 270000, found 216000)
> >> [drm:intel_atomic_check] forcing full modeset
> >>
> >> On v6.15.9, the same VT switch shows no such messages.
> >> no pipe_config_compare runs, no modeset, no freeze.
> >>
> >> # BISECT AND VERIFICATION
> >>
> >> The bisect converged on d1b618e7954802fe in the uvcvideo driver. This
> >> commit adds a switch statement to uvc_v4l2_unlocked_ioctl that allows
> >> certain V4L2 IOCTLS to call video_ioctl2 directly without first callin=
g
> >> uvc_pm_get/uvc_pm_put. Prior to this commit, all ioctls called uvc_pm_=
get
> >> before video_ioctl2.
> >>
> >> ## VT switching verification across kernel versions:
> >>
> >>   v6.12.74 arch pkg:   WORKS
> >>   v6.15.9 arch pkg:    WORKS
> >>   v6.15.9 from source: WORKS
> >>   v6.16.1 with d1b618e reverted:     WORKS
> >>   v6.17.9 with PM wrapping restored: WORKS
> >>   v6.18.9 with PM wrapping restored: WORKS
> >>
> >>   v6.16.1 from source:  FREEZES
> >>   v6.16.1 arch pkg:     FREEZES
> >>   v6.17.9 arch pkg:     FREEZES
> >>   v6.18.9 from source:  FREEZES
> >>   v6.18.9 arch pkg:     FREEZES
> >>
> >> ## Things that do not eliminate the freeze
> >>
> >>   - module_blacklist=3Duvcvideo on boot
> >>   - CONFIG_USB_VIDEO_CLASS=3Dn (compiled out)
> >
> > This is puzzling me a bit... You are saying that if you do not build
> > the uvc driver, the freeze is still happening?
> >
> > Am I understanding this correctly?
> >
> >>   - i915.enable_psr=3D0
> >>   - Bypassing intel_vrr_transcoder_enable/disable (no-op)
> >>   - xrandr --output eDP-1 --set "max bpc" 10
> >>   - Xorg config FBDepth 30 (No effect on pipe_bpp)
> >>
> >> ## Workaround patch
> >>
> >> Reverting the optimization from d1b618e to restore the unconditional
> >> uvc_pm_get/put wrapping for all ioctls. This is not a proper fix.
> >>
> >> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/=
uvc_v4l2.c
> >> index 9e4a251eca88..15057b47ec4f 100644
> >> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> >> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> >> @@ -1199,33 +1199,12 @@ static long uvc_v4l2_unlocked_ioctl(struct fil=
e *file,
> >>   unsigned int converted_cmd =3D v4l2_translate_cmd(cmd);
> >>   int ret;
> >>
> >> - /* The following IOCTLs need to turn on the camera. */
> >> - switch (converted_cmd) {
> >> - case UVCIOC_CTRL_MAP:
> >> - case UVCIOC_CTRL_QUERY:
> >> - case VIDIOC_G_CTRL:
> >> - case VIDIOC_G_EXT_CTRLS:
> >> - case VIDIOC_G_INPUT:
> >> - case VIDIOC_QUERYCTRL:
> >> - case VIDIOC_QUERYMENU:
> >> - case VIDIOC_QUERY_EXT_CTRL:
> >> - case VIDIOC_S_CTRL:
> >> - case VIDIOC_S_EXT_CTRLS:
> >> - case VIDIOC_S_FMT:
> >> - case VIDIOC_S_INPUT:
> >> - case VIDIOC_S_PARM:
> >> - case VIDIOC_TRY_EXT_CTRLS:
> >> - case VIDIOC_TRY_FMT:
> >> - ret =3D uvc_pm_get(handle->stream->dev);
> >> - if (ret)
> >> - return ret;
> >> - ret =3D video_ioctl2(file, cmd, arg);
> >> - uvc_pm_put(handle->stream->dev);
> >> + ret =3D uvc_pm_get(handle->stream->dev);
> >> + if (ret)
> >>   return ret;
> >> - }
> >> -
> >> - /* The other IOCTLs can run with the camera off. */
> >> - return video_ioctl2(file, cmd, arg);
> >> + ret =3D video_ioctl2(file, cmd, arg);
> >> + uvc_pm_put(handle->stream->dev);
> >> + return ret;
> >>  }
> >>
> >>  const struct v4l2_ioctl_ops uvc_ioctl_ops =3D {
> >>
> >> Andr=C3=A9s
> >>
> >
> >
>

