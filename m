Return-Path: <stable+bounces-244020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNoYL6mx+Wld/AIAu9opvQ
	(envelope-from <stable+bounces-244020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:00:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A94C909A
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7212930A5F0E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269C3A1A3B;
	Tue,  5 May 2026 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="sizCkQzj"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B9220E702
	for <stable@vger.kernel.org>; Tue,  5 May 2026 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971312; cv=pass; b=KmvjQBvzHbkk2hUzblh5LU6XCUVRZbPDqRPsiF7cirrtciKSMaUjPHbCQ67hsAcZxwv305pnsO5uH5ulyp2plZJcoFxIowi4H8EMkeV6VV62772S1Vj9JhlZoPxcAPzYYGh2rvUa2fUjEU4KhzCvHQ6JgkCbDm2/ps0zgFGTUVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971312; c=relaxed/simple;
	bh=t+FMbcuVa5aduuOi421G9VqUnAx036UMxEU4MndVA0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=md6S/GPeKa8qEfqfEjgO3zdizxXLKb0zGn/L0FZtE7TG+KEN50qQmuVveykURugbhq3G+Y4oPRcxiAwvOn6RW02cv39epawBqVuqbFlRzaYRe22euU4chJUvWtXdxCWYI8mdK0G526PBjrRC7n+TU4Gmumic75aesj7M79Dycl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=sizCkQzj; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79827d28fc4so43460967b3.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 01:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777971309; cv=none;
        d=google.com; s=arc-20240605;
        b=MtQCCCyCmyiaQhlld7feOymjRu5/0grCrwuog4stoTVBWNum6Ee4Q9VRtkB3QrkOXw
         GxUdBcA1h9LyKvxKG3HTW/7agSWmRan5V6zk31nsEVq/x8y4z/fZRBjZXRswR+i9qtvG
         KoM+rpOmYTyjcppTLI/P3MW/t++4O/ytzEuer4RnjKlBcD4ZD+50J/7aDooti/wg3v/w
         ugk2VYpE/sdEl4IboNmHTIb/94rSjHQevfX3x3mXzb0tyGC6oDqbDN15TjmiV1c6jtYg
         KsgS/Ft02opDG8yZwXU60zHBs1orjg7kV5pddoycvkkKLGAJVR3X1Ev4hk338lyCPQX8
         Cgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5CJiKZ0puXIp3Q1auWZfkkziQVLi6lqLtkGVw6xnCsY=;
        fh=eQvg5kc4i1dly7PzAkX9dxpv3D1YZEMOwe3r1epMwYs=;
        b=iEX1V3KoiOnlMuP7J4gDDiLV6+ALbDdd7U3/mIJ6si+6pftXKd5UQBy/009clxD1TN
         VMViufY7N198OJu7wcVWYEr2s00FIDzxefIbWFHj62DLcebbCvPjCM9Oy+P6X2eJs0kR
         RcK4RCcmqcu8V9/5efBMGeBKV7mRK6p/1u2IoMBuAc0tWkpvOuF5l1MULNTDLX7dx458
         OKwdkqYGCunQB3qIsr1NdplCp3pjdq11dY/OLEE77mDvuEp+Z4ijQHsQq610/hHRsOp3
         CRRfQf3yYkd+jixfWfVSVtZalqrFEvOiMuB8MG5IBPJDJAfGxRZsJoy9GSvjZQyaLE2J
         YWzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1777971309; x=1778576109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5CJiKZ0puXIp3Q1auWZfkkziQVLi6lqLtkGVw6xnCsY=;
        b=sizCkQzj+FJufAIMJVDyvOhnvn3snykHMX8oUYYGuNwG+QNyMK+JJOGo8MYswE03WO
         RaIKPB9sSGHa3o74/laM2cwF75Dl8aqN7297flxHbql3Efrbsl0LAfmzo+npOYqhNLaW
         MI0VdK+RR+qkzoOAS7HUcPlctm4Q7RtNbfzQvya9AUlIGsL25LGlYYo24w/9DNwcrSPH
         nf8CBdfuwWds07skkPtxSTYER4x4J8E7XOoyX25yYNwU1WuTpcJ6mDSLqNmfH89XxPTh
         g59Cf6LsLXR+0vWvfgYX43qwo7HTSbmGPiKMFeLyop9xNd+y0auguryHDmR8VoKAWl3p
         WD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777971309; x=1778576109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CJiKZ0puXIp3Q1auWZfkkziQVLi6lqLtkGVw6xnCsY=;
        b=CxwRkz9WXBDISmtV1j/kU/l6yTxb7n0nqnkebCkviSMRd4TXMOFUsy66Oro4rol/eu
         RxFEIPXePdSYWLBaqeKNPkGefDtHvj7T9Tn47VbGglhpL7pZZHrz4B0h3vPGp4ZyLG0v
         fYGBGkhxB3YC6HfOfmS+XGYFT4ksFs4mtEM7eiwW+J6EWv8NQa7oVdRrqmSjxlvKN4JR
         qiY0qwnvmbADsUBaV9R0HvZjoPt2+WMGvid4Jqc9Xn4Yz7FU0Z8dgszBYlnGDIfRItRB
         LmDfmkL1rGqZ3exmP7d5j9H5HUHpUyD6JGKxvUHTUdFkA2q96difk3xYTCFX4SxfnCn3
         EpSg==
X-Forwarded-Encrypted: i=1; AFNElJ98RxJY+ubVdfqCgFfky7DCaSU1VKpge9Yg3Xb9O8cMv9fghlKHQgTFZj/to/e3+98LB8aDt/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG6yzk01q0r/WVWsBCdx9xvW/6PeQfnDfObNFGaIXU2nXvurhO
	TWP46EIA/efD4rUG0G5tPib4S/SMQqunZooahfyz2tFFWH+ebI6v+RBde2DHp4Ad+XkwVNZKOCh
	YFyoGRJbmQPMR4+gAKRPxuYrAKCEUMaJ7UmkwBy6hhg==
X-Gm-Gg: AeBDies2dM9GKDCYnJdamjkottSLAvjgTASDVnB3Pdu1/bafypvkZ4I209+oQZjwwRN
	vuvPwfj30TwidVpLFl9jBWtFXk0bFvL2FODFwt2iicH7oq2WyCXVDyvjCC+wlEQoJ9VCG3Uw1dx
	tFgsYGUbdbi5OUR1vBd7lO/xLNvyKwBDJPfr1bZs/I3JKyKioqUDbhzo2qz/txr3DqxwU9fMrV4
	HsWQ5lPOd9L/j9+PIaS28foxJcsl4duVBvhqBJz0w5jDiGb583s5LkEdV1E1VAy0d/paR+uibEr
	IZqFQ0vddGqS4FtdgqAsFSnfF7wP4RnYLsGBBvpbotclYA8=
X-Received: by 2002:a05:690c:319:b0:79a:c40d:b701 with SMTP id
 00721157ae682-7bd76fa3ec3mr146040217b3.13.1777971309131; Tue, 05 May 2026
 01:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502121251.39206-3-thorsten.blum@linux.dev>
In-Reply-To: <20260502121251.39206-3-thorsten.blum@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 5 May 2026 09:54:53 +0100
X-Gm-Features: AVHnY4JHEMwCFYtgbgcAbs-cm6Q_iZoV4kpejbmHYNcZDwD-WyLuqrs2o_jiYpk
Message-ID: <CAPY8ntDOEjAHFF_HxFoVEmrgQ8okm=8cHQEfm2QUU=MuB77d_A@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: fix NULL dereference in vc4_hvs_unbind
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>, 
	stable@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 110A94C909A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[raspberrypi.com,reject];
	R_DKIM_ALLOW(-0.20)[raspberrypi.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244020-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,igalia.com,raspberrypi.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,anholt.net,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.stevenson@raspberrypi.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[raspberrypi.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]

Hi Thorsten

On Sat, 2 May 2026 at 13:13, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> With 'dtoverlay=vc4-kms-v3d,noaudio' and 'hdmi=off' on Raspberry Pi,

Mainline doesn't use overlays, so this description isn't valid.

Which generation of Pi are you using? Whilst they all share the vc4
driver, the functionality associated differs. If you're disabling HDMI
(and HDMI audio), which display outputs are you using?

> unloading the vc4 module calls vc4_hvs_unbind() with
> dev_get_drvdata(master) returning NULL.
>
> Return early when 'drm' is NULL before converting it to 'vc4' and before
> dereferencing 'vc4->hvs', preventing a kernel oops.

That leaves things allocated and clocks running, so bailing out isn't a fix.
I'll have a look to see why dev_get_drvdata is returning NULL.

  Dave

> Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/vc4/vc4_hvs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index ee8d0738501b..9cb66f696fc7 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -1753,10 +1753,16 @@ static void vc4_hvs_unbind(struct device *dev, struct device *master,
>                            void *data)
>  {
>         struct drm_device *drm = dev_get_drvdata(master);
> -       struct vc4_dev *vc4 = to_vc4_dev(drm);
> -       struct vc4_hvs *hvs = vc4->hvs;
> +       struct vc4_dev *vc4;
> +       struct vc4_hvs *hvs;
>         struct drm_mm_node *node, *next;
>
> +       if (!drm)
> +               return;
> +
> +       vc4 = to_vc4_dev(drm);
> +       hvs = vc4->hvs;
> +
>         if (drm_mm_node_allocated(&vc4->hvs->mitchell_netravali_filter))
>                 drm_mm_remove_node(&vc4->hvs->mitchell_netravali_filter);
>

