Return-Path: <stable+bounces-217706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIm0NaMLnGlL/QMAu9opvQ
	(envelope-from <stable+bounces-217706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:11:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8A3172F41
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A74300A605
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E4B34CFC6;
	Mon, 23 Feb 2026 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gN5sxjFt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05634CFAD
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771834267; cv=none; b=h+0JRQGLZGZPQEWRWm+bwXWXmkRpyyU/afaAg9T1B/ZYbJz6JSiF32BuosORsQHrVXJYecJatcWLq+t9UqnvvxuxnE/XKwivg8SxwlG+o/0w1hlD5dVPp/sO34b95g4MgWy0B5MUxNepd3L2TjDBvhNoYpsHh6kyZIYPsPEZtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771834267; c=relaxed/simple;
	bh=QLIG/cvAGKHL/QsPZAk+8/0vWlzhWoHy3RyVHMRjPY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYN3lbIaivsTjSEoTHcIX0JTDPDBAZ2vz+z6yRd+jN9hhS9JaAOSbHtkdxtUIeKVI3NsoKG0SSWVt5cMM8hhL8VydoYW6pWk4VEScF53xnwLmm9wS1L8ZBatiPmUY/KqUi4b41G+OVkiIifSqxT9gQZl7wBa9r+xou7Rfrx4p40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gN5sxjFt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so7020557a12.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 00:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771834264; x=1772439064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPcLFGqvXQ/TrcZMbc9zEuLscnPpwUEKK1FNGlp3euE=;
        b=gN5sxjFtWbIVi2Q5Q11QttZo1KKAjedKe32bHdDSHtJ/zHm/tuJoblxJfJEPw6EX6+
         BZ9uXHWwqXezbueEWS57r5cRpc4rjDW1l+ByLKKYri3Vd5NJdv625IfIC7WTogoph03b
         tCkZBIQwUCz5GDpuRmU/vuI91YzUtJw+l1miY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771834264; x=1772439064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fPcLFGqvXQ/TrcZMbc9zEuLscnPpwUEKK1FNGlp3euE=;
        b=ZS1+LJo5d7n2dA6XeVLZCtpUon8Y9t+gNWH1dE/h1lVDPFdJvbq0v3kMrLB6yTD1ru
         LIROfeAGZuUTTWsRcM2GnmgoRqWkuPhCCN+fAVdhwJjovebwWg2oRQPAxMtfbWrdEXsL
         WdOKfBh9J/o7E4zJJuO/Du6S0W5+AVUxe22zF4kicx5ayN1o9/TB791jNHaAc9pq9+Rg
         OULBW0uD5FhJHVj7sFOCqmugqpNUEzcVwztkXqkk+iWmMBgeS9hplG7QrjQ9PDXzaNxz
         zJwRX7+T+0gR8+goqjaf9uyHhklGuH5plQnVdS+RGedpUouY/JyUXA3C3Az13A/f52QK
         UDEw==
X-Gm-Message-State: AOJu0YwwkA7FZEAHbAMuIn9aiJonphywR9VsAbExbOXPUatcWO7nOvqc
	3VDgSbS6M27GN0gJBpYBbPIlPJp+OI0mPpxF6+T+t/LbaKXCynlZjoQ/QPsUD/39ljXr3CTeWPT
	v1vIHBg==
X-Gm-Gg: AZuq6aJkSnb0sBN+mJEMst9MoRqaAKE+sl15NhdQ3w2XkkNBQ36PM/GoFCkAHz13aMd
	80C0h5h5m6nQ0bhj6/tNFgn/GVIFxsOHqlxN/YQ1FBS6BqbnWMIc7vGZjDgFBLjefxC2lJ/ESSb
	MUz+sV8eF13W3mCh6hFF5ySYwvhvFZmpw+QFZDK+SsM1tdpCa8ogn9+o5M8fyCln3CZToi/paOP
	64ZTPJauB5N5mTPq7g7qJ05mRjV5wNgH+2MvlZ6ys7vY9wOrX0KqNhe7Gf0Nj0ElXhTqM2FXykT
	/jDFFhnurOZ7/jhwQDdkqAuDS4cEk0IWk5XTBMNLbdpEDuZy/FmgQxnitfXE31QTYDGHk5tgVjm
	ScGkM2gcKWqsBFMZsQCPcMr0X0gzYEWrPpixEF4cfqH6kXcO+2iC9wAzoc4fjsK//6Xu4WtGUZV
	vE/JinSVHymjph0ZZq1IeiSO7e3mx8lVKCbOEx9WCCXg4z5uDChEI1Rkigo8t61LP1SaAdvd0=
X-Received: by 2002:a05:6402:f18:b0:64b:7b73:7d50 with SMTP id 4fb4d7f45d1cf-65ea4ed94a5mr2530823a12.1.1771834264303;
        Mon, 23 Feb 2026 00:11:04 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9aabb2sm2342431a12.8.2026.02.23.00.11.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 00:11:03 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65bfc858561so7777807a12.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 00:11:03 -0800 (PST)
X-Received: by 2002:a17:907:94cc:b0:b87:12d2:fa1a with SMTP id
 a640c23a62f3a-b908191f1d6mr445251466b.12.1771834262096; Mon, 23 Feb 2026
 00:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD0gVBsyzYNA6ydPwg9mJ9VQzYg4zPAi24JQ13-=0KtdbQ039A@mail.gmail.com>
In-Reply-To: <CAD0gVBsyzYNA6ydPwg9mJ9VQzYg4zPAi24JQ13-=0KtdbQ039A@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 23 Feb 2026 09:10:49 +0100
X-Gmail-Original-Message-ID: <CANiDSCsMVE7qAcjcjbjhYSMoyypkR5Nq-ZA-e=CJVY5CUGAG7Q@mail.gmail.com>
X-Gm-Features: AaiRm53F0LIMOe6xezXE30KkDM_p2uBY1AB8eOErFcvfTTb2PhOgsWveImx1C0M
Message-ID: <CANiDSCsMVE7qAcjcjbjhYSMoyypkR5Nq-ZA-e=CJVY5CUGAG7Q@mail.gmail.com>
Subject: Re: [REGRESSION] Display freeze on VT switch back to X11 since v6.16
To: =?UTF-8?B?QW5kcsOpcyBQw6lyZXo=?= <andres.f.perez@gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217706-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ideasonboard.com,kernel.org,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,lists.freedesktop.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim]
X-Rspamd-Queue-Id: 3C8A3172F41
X-Rspamd-Action: no action

Hi Andr=C3=A9s

Thanks for doing the bisecting

On Sun, 22 Feb 2026 at 22:56, Andr=C3=A9s P=C3=A9rez <andres.f.perez@gmail.=
com> wrote:
>
> # OVERVIEW
>
> Since kernel v6.16.1, switching from an X11 session to a text VT and back
> freezes the display on a ThinkPad P15 Gen 2. The system remains responsiv=
e
> over SSH; only the display is frozen. Bisecting identified commit
> d1b618e7954802fe ("media: uvcvideo: Do not turn on the camera for some
> ioctls") as the trigger. Reverting the logic change in that commit
> fixes VT switching
> on v6.16.1, v6.17.9, and v6.18.9, but that is not an actual solution. Way=
land
> compositors (e.g., river and sway) are not affected.
>
> Last good:  v6.15.9
> First bad:  v6.16.1
> Bisect result: d1b618e7954802fe media: uvcvideo: Do not turn on the
> camera for some ioctls
>
> ## Hardware:   Lenovo ThinkPad P15 Gen 2i (20YQ0031US)
> CPU:        Intel Core i7-11800H (Tiger Lake-H)
> iGPU:        Intel UHD Graphics (TGL GT1)
> dGPU:       NVIDIA T1200 (not involved in eDP output; driver: nvidia-open=
)
> Display:    15.6" 1920x1080 eDP, 10 bpc capable (EDID 1.4)
> Webcam:     Integrated Camera on PCH xHCI (Bus 003 Port 004)
> Firmware:   LENOVO N37ET61W (1.97)
> OS:         Arch Linux, Nix home-manager, X11 + xmonad, no display manage=
r
>
> ## Symptoms and reproduction steps:
> 1. Boot, start X11 on tty1 (startx).
> 2. Switch to tty2 (Ctrl+Alt+F2): works.
> 3. Switch back to tty1 (Ctrl+Alt+F1): display freezes.
>    - Frozen on the last frame shown before switching away.
>    - System is fully responsive over SSH.
>    - Other VTs switch normally between each other as long as X11 is
> not active on them.
>    - Killing X does not recover the display. A reboot is required.
>
> # DEBUG ANALYSIS
>
> On v6.16.1, the VT switch back to X triggers a full modeset due to pipe
> configuration mismatches detected by intel_pipe_config_compare:
>
> [drm:intel_pipe_config_compare] fastset requirement not met in pipe_bpp
>   (expected 30, found 24)
> [drm:intel_pipe_config_compare] fastset requirement not met in dp_m_n
>   (expected link 269484/524288, found link 336855/524288)
> [drm:intel_pipe_config_compare] fastset requirement not met in dpll_hw_st=
ate
>   (expected cfgcr0: 0xe001a5, found cfgcr0: 0x1c2)
> [drm:intel_pipe_config_compare] fastset requirement not met in port_clock
>   (expected 270000, found 216000)
> [drm:intel_atomic_check] forcing full modeset
>
> On v6.15.9, the same VT switch shows no such messages.
> no pipe_config_compare runs, no modeset, no freeze.
>
> # BISECT AND VERIFICATION
>
> The bisect converged on d1b618e7954802fe in the uvcvideo driver. This
> commit adds a switch statement to uvc_v4l2_unlocked_ioctl that allows
> certain V4L2 IOCTLS to call video_ioctl2 directly without first calling
> uvc_pm_get/uvc_pm_put. Prior to this commit, all ioctls called uvc_pm_get
> before video_ioctl2.
>
> ## VT switching verification across kernel versions:
>
>   v6.12.74 arch pkg:   WORKS
>   v6.15.9 arch pkg:    WORKS
>   v6.15.9 from source: WORKS
>   v6.16.1 with d1b618e reverted:     WORKS
>   v6.17.9 with PM wrapping restored: WORKS
>   v6.18.9 with PM wrapping restored: WORKS
>
>   v6.16.1 from source:  FREEZES
>   v6.16.1 arch pkg:     FREEZES
>   v6.17.9 arch pkg:     FREEZES
>   v6.18.9 from source:  FREEZES
>   v6.18.9 arch pkg:     FREEZES
>
> ## Things that do not eliminate the freeze
>
>   - module_blacklist=3Duvcvideo on boot
>   - CONFIG_USB_VIDEO_CLASS=3Dn (compiled out)

This is puzzling me a bit... You are saying that if you do not build
the uvc driver, the freeze is still happening?

Am I understanding this correctly?

>   - i915.enable_psr=3D0
>   - Bypassing intel_vrr_transcoder_enable/disable (no-op)
>   - xrandr --output eDP-1 --set "max bpc" 10
>   - Xorg config FBDepth 30 (No effect on pipe_bpp)
>
> ## Workaround patch
>
> Reverting the optimization from d1b618e to restore the unconditional
> uvc_pm_get/put wrapping for all ioctls. This is not a proper fix.
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc=
_v4l2.c
> index 9e4a251eca88..15057b47ec4f 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1199,33 +1199,12 @@ static long uvc_v4l2_unlocked_ioctl(struct file *=
file,
>   unsigned int converted_cmd =3D v4l2_translate_cmd(cmd);
>   int ret;
>
> - /* The following IOCTLs need to turn on the camera. */
> - switch (converted_cmd) {
> - case UVCIOC_CTRL_MAP:
> - case UVCIOC_CTRL_QUERY:
> - case VIDIOC_G_CTRL:
> - case VIDIOC_G_EXT_CTRLS:
> - case VIDIOC_G_INPUT:
> - case VIDIOC_QUERYCTRL:
> - case VIDIOC_QUERYMENU:
> - case VIDIOC_QUERY_EXT_CTRL:
> - case VIDIOC_S_CTRL:
> - case VIDIOC_S_EXT_CTRLS:
> - case VIDIOC_S_FMT:
> - case VIDIOC_S_INPUT:
> - case VIDIOC_S_PARM:
> - case VIDIOC_TRY_EXT_CTRLS:
> - case VIDIOC_TRY_FMT:
> - ret =3D uvc_pm_get(handle->stream->dev);
> - if (ret)
> - return ret;
> - ret =3D video_ioctl2(file, cmd, arg);
> - uvc_pm_put(handle->stream->dev);
> + ret =3D uvc_pm_get(handle->stream->dev);
> + if (ret)
>   return ret;
> - }
> -
> - /* The other IOCTLs can run with the camera off. */
> - return video_ioctl2(file, cmd, arg);
> + ret =3D video_ioctl2(file, cmd, arg);
> + uvc_pm_put(handle->stream->dev);
> + return ret;
>  }
>
>  const struct v4l2_ioctl_ops uvc_ioctl_ops =3D {
>
> Andr=C3=A9s
>


--=20
Ricardo Ribalda

