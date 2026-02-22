Return-Path: <stable+bounces-217681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAHSIYp7m2n00AMAu9opvQ
	(envelope-from <stable+bounces-217681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 22:56:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7B170864
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 22:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 477F93011592
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 21:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C335C19D;
	Sun, 22 Feb 2026 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuUmUTQB"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F959352926
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771797376; cv=pass; b=TQzJTBp/L3k33SLk7HT8z1k1GmxCo+ACNXiqfSEHdgUudDYVgQXiHPwM+Rr2I814IrQA1u2FiRBvLco4rBvLVxCjBSKFQ6kzXIH0YlHQ+99TYEtMvnnNAVcPXekmjxckmFXR1rCYvaIgz8kkHeQbdrMy85v6HV5VnPGlZZ9a77o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771797376; c=relaxed/simple;
	bh=JmSvQO5XqyT6TdvcO2hqlfP/xs6Gk//750J3WTyc8u0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MLKSn4Hke5B614LQ8u2Ex3rUK3BwUiAKVsjcXkve+CKidznHPjIDot7ZvF7rnYvc7sm3ZXClmi9C4iBjzrE3aRNpuEXu3euLjdcHz7/5pXxMVLVpXsJunZ4kvlX1AaIeuX4I66rBAzDwxMgR30xIjbZaCF8Yr3yQql/D+rWac0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuUmUTQB; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5688c221fd3so1615703e0c.2
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 13:56:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771797374; cv=none;
        d=google.com; s=arc-20240605;
        b=L0UZGitwOi4AjO2b3OT7LZZy4CrPmAQ4dPxPh91rOdSnZxgKOzNokcbmIsC2wVzu4P
         Rzo/H6jLwaY2CHxCpGshcoeBFn+WWWdb6yp21SVD8Mxrxue60ZT9y/o2dtybl+4UrQpm
         SVR/4rUi6XhhpryVV8UdUVGxyOf1XvzzxdSlyQC1DnRN+OkKZGOby06GLjrBwxdH0wbs
         eKBzfxxz/UReqND9pjcZA7YhO2eqnle0OwL7muycTsdFKzqiDQqKNMGmpKr9QEkfbGdC
         mRXHBbjmw7VOu/i2632ebe4O6yLWT99ypCIAdAFdmEx7O4q4WQd1tCgKMJdBKAaWNwp9
         yPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=fvZFs6ZWQcArHoivTdoRPMVBttlGZZKU4uro3YAyvz8=;
        fh=E5g3maHsnyUMAiwVmwUyq6VP4zbCj1sjpTAtNm8Z8AY=;
        b=SQUdTu4OhXfYGmy5gL8t+4L/lFaDW/kNYO5/3sGFlWQG73FWQxRYAn3KzFgi3wEiI/
         +s8BhotstCwERfQDjZcqdAEZJvdx6CWQN/8LBy+NAsV9TM2e0lyjur54m57nrtpQs7UO
         f/VyjLb9RYBeQfvJ1v/2a2X/HZXTXpVQLMVryko1jkJO1eJWTED6QatLlBanpe97ZFXp
         t4akXY849HITLpuuWb5CIg730d7OunCuwzIxSE8aWOvthdlyw/P3te1S7Vl39voDQWVW
         nXOw7eFN6AvsXuMhiHPU4sJpNTnUw1PKfFhowKBIYTuWEjdh3vonrkQPrlVll3mSLLpW
         haUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771797374; x=1772402174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fvZFs6ZWQcArHoivTdoRPMVBttlGZZKU4uro3YAyvz8=;
        b=PuUmUTQBb+Mb558N6vMGiEpSEsrP9fJKT7Yd10sPSRpeznTjeAmClndE+ROruMPtY6
         coIfG5XhLIYEpBgWdUKVm/qMOI2HaBVc/gz8RKSwVUK13g6kiPpL/3eVe/+tQgRrTrVQ
         Ez9f8FKMJPfvpeoHqU5X5trewXM4nQVr/1sttBiuF9eIZ7efTk+UcVgTB7N+ucixgaTs
         wzNHELCG3Jqq+w8MD6RRB32eRn31+kBete7k6qrsYZpR6IuRXh78xpsuOD71o7DK3Epi
         5TEMHk0ku1B8Gi6WL/wRv+cPVFcU/1As7KPc2yl3fByO73mc3GNboxakUUhNsJ4vj64k
         QMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771797374; x=1772402174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvZFs6ZWQcArHoivTdoRPMVBttlGZZKU4uro3YAyvz8=;
        b=Z33+HzWxw731CjnQkStpdps2UkC6wakXYT71ewXD9qv6MTgPwQ/QeaMJxwh+gyLmyJ
         +ey5kniVUY/rV3feEJemvbSPgHcbBVx87KOTpdcFL/5WTxLGk/uh2/Bug+0rSx8J6EPT
         EjmGyFoqhRtSRlyFqYj5WzQUNPTDX/RLixcjiBPIqkFUaNZvhDt0OCX3U/iYsPyhycTQ
         GPs8EUxILijUjLCKPbZTCmG+kr6hZ6M6ajT0po8zNzsxmboHDFZ5XWWVY9GwZO7YDhVc
         2rGjpjgRFVB09wOWe8DO977xMFgOcHwWBo4F50+w+ZGAoLnV+ntmYnbfNvK3bms6uHqy
         DnBg==
X-Gm-Message-State: AOJu0Ywhf6kZhwsxKWjS3yf97MvdEG8eRKVUf7IVoDm0tGkqFHGWkymC
	Igt8zS4+AtSEgK4REsTxJNAFKG2Tqd4vtW4LuH5e0ZhfRRgx6G866iO9i1IhhdFVRx403zeUWaC
	7EyXITQ/W80HI2E5VtuuZpP2yXJO6LTIjma5hjvqn8Q==
X-Gm-Gg: AZuq6aJQDP8Bi3RmktG64vOIesu3gI9JcYNSF0o7DH21kVlEcYnddzo8BvLnSKsOoyz
	AcEyNsyhxrk2LySVNeIZMkx6auGRj43gJ/r696Y6VZ1tOM6xKmM+0dm0wbaQwDnkFi76quy+Opq
	xH8CWWczCNqqHk9USr98w4M23a2hh2HiOgll1rhPpBnkPDAzXBgpS4Rohh2bvOMay1FButd13tE
	yNwdYdZweie0eWc4CWoAqEbGZwUgSq89ga5qkPdCj93fGxyFc6roHpeDm1AwOGF7j6GWwvxJh/d
	3LtUyJf2YOWSyHpvu/4qiDN04Qx/SvKPqLzSDMifrJcRLgtvckVfOC+y2A0DMsSziCR0R14srdq
	/XmV+Dntz/A==
X-Received: by 2002:a05:6122:469b:b0:55b:1a1b:3273 with SMTP id
 71dfb90a1353d-568e47abec3mr2195110e0c.6.1771797374061; Sun, 22 Feb 2026
 13:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?QW5kcsOpcyBQw6lyZXo=?= <andres.f.perez@gmail.com>
Date: Sun, 22 Feb 2026 21:55:54 +0000
X-Gm-Features: AaiRm50d7jLgPyD4kdVKiyrm9CHXFWwo9PDyCMT5qvyZh7PMRFS6zqm3NMkVBvk
Message-ID: <CAD0gVBsyzYNA6ydPwg9mJ9VQzYg4zPAi24JQ13-=0KtdbQ039A@mail.gmail.com>
Subject: [REGRESSION] Display freeze on VT switch back to X11 since v6.16
To: stable@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217681-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[vger.kernel.org,ideasonboard.com,kernel.org,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andresfperez@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4A7B170864
X-Rspamd-Action: no action

# OVERVIEW

Since kernel v6.16.1, switching from an X11 session to a text VT and back
freezes the display on a ThinkPad P15 Gen 2. The system remains responsive
over SSH; only the display is frozen. Bisecting identified commit
d1b618e7954802fe ("media: uvcvideo: Do not turn on the camera for some
ioctls") as the trigger. Reverting the logic change in that commit
fixes VT switching
on v6.16.1, v6.17.9, and v6.18.9, but that is not an actual solution. Wayla=
nd
compositors (e.g., river and sway) are not affected.

Last good:  v6.15.9
First bad:  v6.16.1
Bisect result: d1b618e7954802fe media: uvcvideo: Do not turn on the
camera for some ioctls

## Hardware:   Lenovo ThinkPad P15 Gen 2i (20YQ0031US)
CPU:        Intel Core i7-11800H (Tiger Lake-H)
iGPU:        Intel UHD Graphics (TGL GT1)
dGPU:       NVIDIA T1200 (not involved in eDP output; driver: nvidia-open)
Display:    15.6" 1920x1080 eDP, 10 bpc capable (EDID 1.4)
Webcam:     Integrated Camera on PCH xHCI (Bus 003 Port 004)
Firmware:   LENOVO N37ET61W (1.97)
OS:         Arch Linux, Nix home-manager, X11 + xmonad, no display manager

## Symptoms and reproduction steps:
1. Boot, start X11 on tty1 (startx).
2. Switch to tty2 (Ctrl+Alt+F2): works.
3. Switch back to tty1 (Ctrl+Alt+F1): display freezes.
   - Frozen on the last frame shown before switching away.
   - System is fully responsive over SSH.
   - Other VTs switch normally between each other as long as X11 is
not active on them.
   - Killing X does not recover the display. A reboot is required.

# DEBUG ANALYSIS

On v6.16.1, the VT switch back to X triggers a full modeset due to pipe
configuration mismatches detected by intel_pipe_config_compare:

[drm:intel_pipe_config_compare] fastset requirement not met in pipe_bpp
  (expected 30, found 24)
[drm:intel_pipe_config_compare] fastset requirement not met in dp_m_n
  (expected link 269484/524288, found link 336855/524288)
[drm:intel_pipe_config_compare] fastset requirement not met in dpll_hw_stat=
e
  (expected cfgcr0: 0xe001a5, found cfgcr0: 0x1c2)
[drm:intel_pipe_config_compare] fastset requirement not met in port_clock
  (expected 270000, found 216000)
[drm:intel_atomic_check] forcing full modeset

On v6.15.9, the same VT switch shows no such messages.
no pipe_config_compare runs, no modeset, no freeze.

# BISECT AND VERIFICATION

The bisect converged on d1b618e7954802fe in the uvcvideo driver. This
commit adds a switch statement to uvc_v4l2_unlocked_ioctl that allows
certain V4L2 IOCTLS to call video_ioctl2 directly without first calling
uvc_pm_get/uvc_pm_put. Prior to this commit, all ioctls called uvc_pm_get
before video_ioctl2.

## VT switching verification across kernel versions:

  v6.12.74 arch pkg:   WORKS
  v6.15.9 arch pkg:    WORKS
  v6.15.9 from source: WORKS
  v6.16.1 with d1b618e reverted:     WORKS
  v6.17.9 with PM wrapping restored: WORKS
  v6.18.9 with PM wrapping restored: WORKS

  v6.16.1 from source:  FREEZES
  v6.16.1 arch pkg:     FREEZES
  v6.17.9 arch pkg:     FREEZES
  v6.18.9 from source:  FREEZES
  v6.18.9 arch pkg:     FREEZES

## Things that do not eliminate the freeze

  - module_blacklist=3Duvcvideo on boot
  - CONFIG_USB_VIDEO_CLASS=3Dn (compiled out)
  - i915.enable_psr=3D0
  - Bypassing intel_vrr_transcoder_enable/disable (no-op)
  - xrandr --output eDP-1 --set "max bpc" 10
  - Xorg config FBDepth 30 (No effect on pipe_bpp)

## Workaround patch

Reverting the optimization from d1b618e to restore the unconditional
uvc_pm_get/put wrapping for all ioctls. This is not a proper fix.

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v=
4l2.c
index 9e4a251eca88..15057b47ec4f 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1199,33 +1199,12 @@ static long uvc_v4l2_unlocked_ioctl(struct file *fi=
le,
  unsigned int converted_cmd =3D v4l2_translate_cmd(cmd);
  int ret;

- /* The following IOCTLs need to turn on the camera. */
- switch (converted_cmd) {
- case UVCIOC_CTRL_MAP:
- case UVCIOC_CTRL_QUERY:
- case VIDIOC_G_CTRL:
- case VIDIOC_G_EXT_CTRLS:
- case VIDIOC_G_INPUT:
- case VIDIOC_QUERYCTRL:
- case VIDIOC_QUERYMENU:
- case VIDIOC_QUERY_EXT_CTRL:
- case VIDIOC_S_CTRL:
- case VIDIOC_S_EXT_CTRLS:
- case VIDIOC_S_FMT:
- case VIDIOC_S_INPUT:
- case VIDIOC_S_PARM:
- case VIDIOC_TRY_EXT_CTRLS:
- case VIDIOC_TRY_FMT:
- ret =3D uvc_pm_get(handle->stream->dev);
- if (ret)
- return ret;
- ret =3D video_ioctl2(file, cmd, arg);
- uvc_pm_put(handle->stream->dev);
+ ret =3D uvc_pm_get(handle->stream->dev);
+ if (ret)
  return ret;
- }
-
- /* The other IOCTLs can run with the camera off. */
- return video_ioctl2(file, cmd, arg);
+ ret =3D video_ioctl2(file, cmd, arg);
+ uvc_pm_put(handle->stream->dev);
+ return ret;
 }

 const struct v4l2_ioctl_ops uvc_ioctl_ops =3D {

Andr=C3=A9s

