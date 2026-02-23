Return-Path: <stable+bounces-217735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJszN00/nGljCQQAu9opvQ
	(envelope-from <stable+bounces-217735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:51:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2197E175B23
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C073B3007AD9
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554E35B621;
	Mon, 23 Feb 2026 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA1G06i6"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E92360753
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847497; cv=pass; b=hh31HqW3BT+H/kgZATFpNBpOsQd/jMF0AcXPMofsYhTsOPGTh/fLy+FvWeqXSfFk5sxfiyeh2Fg1yTi22Vuems5xEA1kRQ+o0iJfi5zUjOuEnQbLP/OfPkz21O313bX4GF2FpTYpdSaRBuYsOkAQgRQOcCCjre6wxOWg144/az0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847497; c=relaxed/simple;
	bh=6iocD9MNSzx4u2ot8rxH8bvtMLCokh3pHlrbgw2W8ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mG0L6fAHKaCCwoKpORRI7GHgAYBkKsZBWW59HrAP6gzcXi4rBJ5PdhHT2UmtzJ12+UXel148AG430odjLHmX+jcgAyVU6QjiMwBECCdiWbVd7yM/EHtz+gZXrvHgxXtRpYB8YCq/lGL237yKINmElL3su9VK1bHUqLdd4Koddls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA1G06i6; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fc41477460so1055203137.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 03:51:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771847495; cv=none;
        d=google.com; s=arc-20240605;
        b=jtu5ezppxMItYu43w+P5JJ1RsWlpKDh9PVzxB+rnqNvjV09WkUidNzTJCV0AEMLmmA
         CZ3bM5o9SYOOkRu5CO1u9hgr0n76Qs9T6l3V2cTvP1HWegQnQruCHj3wvJwtJUxSPUHq
         KHhXwiJG+YY0Qz5s8HgDwhr6uX5pVzAMxGOyeowArZPNEkuPLh4cy3Th6Ix6aSk1lPgw
         Y6aBWvmeqkN6mmGyUPEmoBGbvh9pwOT33rxEMMOxCOQCA/JOlTHsz/NyhpW/pYjsSPOC
         GXO/EY2FL8MGQ9nRmh2lN3fjq0ObUQ6hFxYQkqW/kIOfJfWDsOjRVtfJ6SotHYkJqIZ+
         Vcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rMp9NyS10Y7o5BbV0/n1cd3o9I8LFMg8n5wPuOM1jvE=;
        fh=HhPdB4slcbRohZsyEA6TpYW0sx6GJNp97fLLK+LCd2Q=;
        b=fkn/Ow27ch+v6QFsXtpdV4pf66oHGZtP6048Iuifg/xf+GMnT8DELAoM5nlQbVuKM+
         Ol7Itc79R4fsKSvTIWxee4wSuRHPMZrfzVoH37aQ8tVk0Z1+163j2gk4s1itMGCRHmDl
         EYRHAZ9hvPW1P2npWP6wgsRRE/KewbahdV9IOaCG/jyJ9a/uV4bvfNUHM3YnF4pRE3gE
         VCiqOL5zsigm3rnXo3VnQl+36/VtuuYU0WFmuMXU3UCEOOSTW19KE4+5+OGofwf8u5N9
         DmEnTspt9DyceJ+GT5XYwxtZ4jDQ5lyX/cOy/ekt25tv8hkmnpfBnl7UiGE04QIJRXl+
         zPyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771847495; x=1772452295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMp9NyS10Y7o5BbV0/n1cd3o9I8LFMg8n5wPuOM1jvE=;
        b=nA1G06i6cyzu5cXu8J8mZuLliJ9xeC1xvtVBi6ohONN6T1CKlAcj6tXM7hdSo/vqM8
         +EWfbaaX1/gKWWBN1mjYYtbPTkTgPa0TD7jfKF9a9P+oE3kNx4Brrzt3yxa+Ec7ZpZjb
         2IJh3WyreNBPWeW4VngZwznynpfdqwGbpvOOK564OgRIS41lQdMlBx3Ln0HNnXmJ+5Tu
         aefEcp4+metaECtfTzrhAjnvm+7LLZQzF0VBf72+mIP+ZpmNYSFpDQPmBSVdHeZYk8Em
         X0lzobHwhvSv83cAP8lnZhCx+y4O0AAmeCVXIANlUxwX0dodwK5JsvtXxXgXDH0Xhpkb
         zsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771847495; x=1772452295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMp9NyS10Y7o5BbV0/n1cd3o9I8LFMg8n5wPuOM1jvE=;
        b=P/mEd+fHqQTfD8nVZ/d+2AkKSLUeF2I8Cz5aCqZkatsjlUTKW9iZ/cpBaCnDZ1ei74
         lpj6ljUAQ54LoM4i/87jjaogTPAmD2n3H941gbAft95zS57Lv7sbAeBGj6Y6OmDu+Ym3
         0t8R5MRGKQYPnFon0HWkS+qs99ROyUk1uuD8T6tt8IzV3le31iZnrfOiLgquymyH2ZzA
         +CmT89lBrVFVGqc0/pbLR5lSJZfNC4bER8flTVtz5REcjnpTe+rA6I9te7eBMhyxYLXA
         rg/VpZS76y81dzU3pA13ca3+DL1BzLzxbSuSQVca45VHSd9YMXLpsdQPnCFWlTND16ls
         qpvg==
X-Gm-Message-State: AOJu0YxVLoO+nFhBoDnon4C5Zc39iVuqZkYVUYySLlX9+hxoHHh+VG1Q
	4oEsUn6XYZWDj570wPA4touzyEmce2DeM7GKTXzpfiUSxxo9ksgOvK4TJ32U1h77byg43TbxHg2
	LOBlmNbgzbOzbeH6kulMPb8VoDeTeHH4=
X-Gm-Gg: AZuq6aIVWnRgWOX42mvs9wE87kPxTEEJQvzHKL/v28Cd1ZmAEyzef6NnklnJp9NuXxh
	CcbqryWHu6ciALwgj6bFUsZ5cKYFxqyNM/knltslRj1yzEez6Ryv/SMrufxawKkQux8/wXpDYjb
	mLtIaKE0tkvWg3ZsPvzrww5vqxTYSJjJ11lxQ6HQ/PBf2tyzidsAkiTUWlc6faE9YkG8JenBxWB
	b/sgpERcmormfWWjgQ6aQRlMWy+tEhe/hMh2UJz+xE8hqJV6GuBp7f1MkXZzoFaR+ZBxNhRWG7l
	3vKUarWdl9ZifmjOTYRRraoYc4FpQxpUqucIt062OYSpPuJk4geoXCOBt/guJ754Z25XUdsoD85
	Dy6vdwlg/4Q==
X-Received: by 2002:a05:6102:e0e:b0:5df:8f4:61e6 with SMTP id
 ada2fe7eead31-5feb310b93bmr3236127137.32.1771847494951; Mon, 23 Feb 2026
 03:51:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD0gVBsyzYNA6ydPwg9mJ9VQzYg4zPAi24JQ13-=0KtdbQ039A@mail.gmail.com>
 <CANiDSCsMVE7qAcjcjbjhYSMoyypkR5Nq-ZA-e=CJVY5CUGAG7Q@mail.gmail.com>
In-Reply-To: <CANiDSCsMVE7qAcjcjbjhYSMoyypkR5Nq-ZA-e=CJVY5CUGAG7Q@mail.gmail.com>
From: =?UTF-8?B?QW5kcsOpcyBQw6lyZXo=?= <andres.f.perez@gmail.com>
Date: Mon, 23 Feb 2026 11:51:14 +0000
X-Gm-Features: AaiRm52aszgholXfDNGG6k-0d1fHGX88p3iT8Mn4sxSWllcwfxYwH-T9tRbXK5Q
Message-ID: <CAD0gVBtWhQqnxVt7kvQoQcbazGiLH-rUNrTfnZZpm40-jKvTUA@mail.gmail.com>
Subject: Re: [REGRESSION] Display freeze on VT switch back to X11 since v6.16
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: stable@vger.kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217735-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ideasonboard.com,kernel.org,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,lists.freedesktop.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andresfperez@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2197E175B23
X-Rspamd-Action: no action

Ricardo,

Listen, I'm right there with you, scratching my head. First thing I
did when I bisected to that commit was modprobe -r that module. Easy
sacrifice; I don't use my camera that often. When it still froze, I
assumed that maybe something related to module init was still
lingering, so I disabled it by kernel boot param. When that didn't
work, I just didn't build it in at all. Then I ignored it and tried a
few other things. Eventually I came back to that commit. Instead of
patching any code, I just added a comment to the file, thinking maybe
this is just some build artifact that's causing a false positive. No
dice. So far, the only thing that has allowed VT switching to work is
restoring those PM calls around the video_ioctl2 call. I am not
presenting it as a solution (quite the contrary!), I am presenting it
solely because it's all I've got to go on.

Andr=C3=A9s

On Mon, Feb 23, 2026 at 8:18=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> Hi Andr=C3=A9s
>
> Thanks for doing the bisecting
>
> On Sun, 22 Feb 2026 at 22:56, Andr=C3=A9s P=C3=A9rez <andres.f.perez@gmai=
l.com> wrote:
> >
> > # OVERVIEW
> >
> > Since kernel v6.16.1, switching from an X11 session to a text VT and ba=
ck
> > freezes the display on a ThinkPad P15 Gen 2. The system remains respons=
ive
> > over SSH; only the display is frozen. Bisecting identified commit
> > d1b618e7954802fe ("media: uvcvideo: Do not turn on the camera for some
> > ioctls") as the trigger. Reverting the logic change in that commit
> > fixes VT switching
> > on v6.16.1, v6.17.9, and v6.18.9, but that is not an actual solution. W=
ayland
> > compositors (e.g., river and sway) are not affected.
> >
> > Last good:  v6.15.9
> > First bad:  v6.16.1
> > Bisect result: d1b618e7954802fe media: uvcvideo: Do not turn on the
> > camera for some ioctls
> >
> > ## Hardware:   Lenovo ThinkPad P15 Gen 2i (20YQ0031US)
> > CPU:        Intel Core i7-11800H (Tiger Lake-H)
> > iGPU:        Intel UHD Graphics (TGL GT1)
> > dGPU:       NVIDIA T1200 (not involved in eDP output; driver: nvidia-op=
en)
> > Display:    15.6" 1920x1080 eDP, 10 bpc capable (EDID 1.4)
> > Webcam:     Integrated Camera on PCH xHCI (Bus 003 Port 004)
> > Firmware:   LENOVO N37ET61W (1.97)
> > OS:         Arch Linux, Nix home-manager, X11 + xmonad, no display mana=
ger
> >
> > ## Symptoms and reproduction steps:
> > 1. Boot, start X11 on tty1 (startx).
> > 2. Switch to tty2 (Ctrl+Alt+F2): works.
> > 3. Switch back to tty1 (Ctrl+Alt+F1): display freezes.
> >    - Frozen on the last frame shown before switching away.
> >    - System is fully responsive over SSH.
> >    - Other VTs switch normally between each other as long as X11 is
> > not active on them.
> >    - Killing X does not recover the display. A reboot is required.
> >
> > # DEBUG ANALYSIS
> >
> > On v6.16.1, the VT switch back to X triggers a full modeset due to pipe
> > configuration mismatches detected by intel_pipe_config_compare:
> >
> > [drm:intel_pipe_config_compare] fastset requirement not met in pipe_bpp
> >   (expected 30, found 24)
> > [drm:intel_pipe_config_compare] fastset requirement not met in dp_m_n
> >   (expected link 269484/524288, found link 336855/524288)
> > [drm:intel_pipe_config_compare] fastset requirement not met in dpll_hw_=
state
> >   (expected cfgcr0: 0xe001a5, found cfgcr0: 0x1c2)
> > [drm:intel_pipe_config_compare] fastset requirement not met in port_clo=
ck
> >   (expected 270000, found 216000)
> > [drm:intel_atomic_check] forcing full modeset
> >
> > On v6.15.9, the same VT switch shows no such messages.
> > no pipe_config_compare runs, no modeset, no freeze.
> >
> > # BISECT AND VERIFICATION
> >
> > The bisect converged on d1b618e7954802fe in the uvcvideo driver. This
> > commit adds a switch statement to uvc_v4l2_unlocked_ioctl that allows
> > certain V4L2 IOCTLS to call video_ioctl2 directly without first calling
> > uvc_pm_get/uvc_pm_put. Prior to this commit, all ioctls called uvc_pm_g=
et
> > before video_ioctl2.
> >
> > ## VT switching verification across kernel versions:
> >
> >   v6.12.74 arch pkg:   WORKS
> >   v6.15.9 arch pkg:    WORKS
> >   v6.15.9 from source: WORKS
> >   v6.16.1 with d1b618e reverted:     WORKS
> >   v6.17.9 with PM wrapping restored: WORKS
> >   v6.18.9 with PM wrapping restored: WORKS
> >
> >   v6.16.1 from source:  FREEZES
> >   v6.16.1 arch pkg:     FREEZES
> >   v6.17.9 arch pkg:     FREEZES
> >   v6.18.9 from source:  FREEZES
> >   v6.18.9 arch pkg:     FREEZES
> >
> > ## Things that do not eliminate the freeze
> >
> >   - module_blacklist=3Duvcvideo on boot
> >   - CONFIG_USB_VIDEO_CLASS=3Dn (compiled out)
>
> This is puzzling me a bit... You are saying that if you do not build
> the uvc driver, the freeze is still happening?
>
> Am I understanding this correctly?
>
> >   - i915.enable_psr=3D0
> >   - Bypassing intel_vrr_transcoder_enable/disable (no-op)
> >   - xrandr --output eDP-1 --set "max bpc" 10
> >   - Xorg config FBDepth 30 (No effect on pipe_bpp)
> >
> > ## Workaround patch
> >
> > Reverting the optimization from d1b618e to restore the unconditional
> > uvc_pm_get/put wrapping for all ioctls. This is not a proper fix.
> >
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/u=
vc_v4l2.c
> > index 9e4a251eca88..15057b47ec4f 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -1199,33 +1199,12 @@ static long uvc_v4l2_unlocked_ioctl(struct file=
 *file,
> >   unsigned int converted_cmd =3D v4l2_translate_cmd(cmd);
> >   int ret;
> >
> > - /* The following IOCTLs need to turn on the camera. */
> > - switch (converted_cmd) {
> > - case UVCIOC_CTRL_MAP:
> > - case UVCIOC_CTRL_QUERY:
> > - case VIDIOC_G_CTRL:
> > - case VIDIOC_G_EXT_CTRLS:
> > - case VIDIOC_G_INPUT:
> > - case VIDIOC_QUERYCTRL:
> > - case VIDIOC_QUERYMENU:
> > - case VIDIOC_QUERY_EXT_CTRL:
> > - case VIDIOC_S_CTRL:
> > - case VIDIOC_S_EXT_CTRLS:
> > - case VIDIOC_S_FMT:
> > - case VIDIOC_S_INPUT:
> > - case VIDIOC_S_PARM:
> > - case VIDIOC_TRY_EXT_CTRLS:
> > - case VIDIOC_TRY_FMT:
> > - ret =3D uvc_pm_get(handle->stream->dev);
> > - if (ret)
> > - return ret;
> > - ret =3D video_ioctl2(file, cmd, arg);
> > - uvc_pm_put(handle->stream->dev);
> > + ret =3D uvc_pm_get(handle->stream->dev);
> > + if (ret)
> >   return ret;
> > - }
> > -
> > - /* The other IOCTLs can run with the camera off. */
> > - return video_ioctl2(file, cmd, arg);
> > + ret =3D video_ioctl2(file, cmd, arg);
> > + uvc_pm_put(handle->stream->dev);
> > + return ret;
> >  }
> >
> >  const struct v4l2_ioctl_ops uvc_ioctl_ops =3D {
> >
> > Andr=C3=A9s
> >
>
>
> --
> Ricardo Ribalda

