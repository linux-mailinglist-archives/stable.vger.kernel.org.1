Return-Path: <stable+bounces-244895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uECNKbqn/ml9ugAAu9opvQ
	(envelope-from <stable+bounces-244895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:19:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F35494FDD95
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 05:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20758301B933
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 03:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B8381B02;
	Sat,  9 May 2026 03:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk2gofUl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F71F5858
	for <stable@vger.kernel.org>; Sat,  9 May 2026 03:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778296751; cv=pass; b=g1D1qtYIlKQeZKG4YWoCboS3mtkK0aomdmuGwZvIkXpv7MeQkIXaSN/ViiUg4yoZoaUK9yTJqrD+xfOv454X2dbwspsJDomUk9K6PS4x7yHBC+HC16/F1TQzDuvPuXQ3t3mLK2BM+A+BMGKTB6uOLIUH8YXxfTCfBiTOw+2CFQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778296751; c=relaxed/simple;
	bh=imwWy0lbsvvUOznltD01Fcz8X/bVX4K7bYpSYkB63sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyT2oxEMiO8xmRCYL6/6rOIMtTPWK1lvM8V5VG7b/cnE2Rb/5xfZiI/AlFVv2PxwAGjtvNDXKoiwWiNE551iikB7ASRg0D+82THSYDIpa5q/ylPp4q4+RVlil1LBlJtEKBDYAaAUAH44AZJpLIwI3Ct+ht+ZxKsruRxV0PRxWaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk2gofUl; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d736211595so186583785a.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 20:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778296748; cv=none;
        d=google.com; s=arc-20240605;
        b=C5BFgAAxxNqaMs2lFr4duM12GJr98H7iICVBCwRYmLxRe1gr7BYUXvEoGX96Evw5Je
         fC8t7nfjLIVnWrAY4lYokseecs72hN8ErIb1RA36xhAHV3bq1jALojY2l2FkykXqTfme
         KnUIMA6iX//Oa9LQMnSfwX/7v03RNbbMpeXGW9lUam5EGMzhTqoB8ND7tnXqRWgIuJjo
         CDER0BMVDkuv7VFeepq0r/lWRlpJ8838Oopg7reNFRluE4X3pwxP+Yo5OXM11ZtpumlQ
         rpwIZkpfXXWSsBqNfGaxjslrG5gs6VVdslCkXZwkDtClPk5JUQInO2OSPIzetiRAZuPm
         BqTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CxMznwGJOgjrL67SxyQcq86ofqmaCMHw/Ooho7JXCtI=;
        fh=/EULUUuUzRQOi+lrV+aurLgayD0Cg1Wkr1eax3lElsU=;
        b=kIsTE5Id0dXk1gwE5u0eGMXeco81BCOHecsBA1QSPbvvptkxBDxy0edLBWIpYhkMbF
         b+ZSJk2O+XWwUs76Gl8JlmdVKIyz5go9jg/KP8DggcI1vI3dNeExxWx51mEEha+CYg3g
         0eUG7LL3PDwnXf8ZZrKfkfJ73py+yuurY5j6pNkv0JfpBV0/zZtmRkuykxmTVgmt5kmB
         0upc60Dwxz5PYJN3epVNjM2EveDZxNgg/eZ2DikcWFkSigUhdm+DFGpzgB0P8ekPrNS0
         yUOtdIez+uJsplmzh8jCC9O9ilQB51JLCTpAXidpk2PppOd7+cgv2Mp0e5uRSxy/X29E
         7Kiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778296748; x=1778901548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CxMznwGJOgjrL67SxyQcq86ofqmaCMHw/Ooho7JXCtI=;
        b=kk2gofUljcjeSvduWdWPfHbVA4SB1ypLWbdldDl7RYKPis2sX5wkFgMrt+fEGdp2Zu
         ahnlTs4D/ILcqq3C8G1XdvWOLUJyBwAyBf7w1JJCiKWtiBNjpss/Ru29f2yRpqdTzEQH
         f1WnEJlBbU1ZTRwVC5JlEYAAAkyD9UPbvOZBWt4b8gh8ZLfJD6E8SjU7QQ4kC2gJl/lv
         HmHodC1RfcQ4te0jSSUHEKV4zp9qm3hboiBOWK4U3qNpTmnje2jDyDJDjILZblcLwMyc
         cMd3mh/fvZq2rhQSQWvDTL48vMJ/5w7qrAd/6ufWQmeMnt84zh159Jb9tzBhq02AFw2i
         mo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778296748; x=1778901548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxMznwGJOgjrL67SxyQcq86ofqmaCMHw/Ooho7JXCtI=;
        b=IfBmEDWSEEIiEAA/a6h8O/bpD0sA5d4p3je+xSo4687tnwmQhdRABCXGDwGABrbguM
         N243WduZPH/J4+s3rrNrEjv2L4X31SGauMj4Ut07xvywz23I68fleVQ2JGTdTBqLtnMU
         Gl0zPYlXQ/nJhV61Ylyi5JOZYM//lIk8xcquFg4z+7TJvZBJUzsOc73UziH9ARIkfqvJ
         xcwJZ9+ANWudauVUs155s/jdmNDcV3r2KTBY84CfBbW8TPV5qsUpd4eUeuuMofHnpr07
         /Fyh2Q7cIVRs38RsSsUU++0j2JFpthaTUfvbV25sx1vMryAibDQYmXPeK1pfrfmeugW8
         6LQA==
X-Forwarded-Encrypted: i=1; AFNElJ//Ah7/WmwcFo6lJjxFDm5YI+fU4hbCkiXDdVKJ8+mG5qdAnLayIxFH89b+JUqVnyoGzpPPEWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaj24HZ722uOSz2jMMDySHV1Ya7LigmMbOJQsn8gwILKHY4wBE
	ZYohf0ECKwDIgHCtdD+wyODghw9psHbD+gnUjCqKxO/3bXR8qO5a/k9cCdWha790GAtpjSSGsBy
	QAT4Fowz0JIpptFOf4CsTIchZ6FFsnoc=
X-Gm-Gg: AeBDiesWdPyjztzAqH9jPX5vShuDhYZoIfacCU7heQ9yEUwGWrwyeWVfj4LJv4za0sf
	ZuYwIgOhBt0ayI5TBleO0lIKVol/9lkHGf5i24d615J66+AjtOYrVqxPWmLFquNK0nzf056eIa8
	WABqR5HM49yc9FG64GFqqWIZZjGgWodhYV7iw0LOAL6Cyy6GkvpD4v3iJCpVBAja89zLDWvwvEX
	9S/HUSdTeTObXL0kkNfGcd5rD6vOeEKn9bF5Jo3Sn2J0z9ekNAXg8qAwkKTJNMZPCiweQUqoLxE
	WSqVeE9XG/vbz6l+EiQCUqnmuchccFylcGvDVIjaF3Lw+pZxF0AMrQtgcYsgbZgoqbximbd32f8
	kXUmh
X-Received: by 2002:a05:620a:f0c:b0:8dd:7422:6934 with SMTP id
 af79cd13be357-904d68dee8bmr2359167685a.44.1778296747959; Fri, 08 May 2026
 20:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429030348.3930866-1-lyude@redhat.com>
In-Reply-To: <20260429030348.3930866-1-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 9 May 2026 13:18:54 +1000
X-Gm-Features: AVHnY4JKAYfBzEvcCazoWW39EPzkIq8d6VGfmI7CrPBmf49am2bEWNkv5j3ODv4
Message-ID: <CAPM=9tyeTxS+Dacc=YdXKrqC1OrrVG78EOkFv4x8f9ykcc3TFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp/r535: Add scanline position support +
 head state support
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, 
	Dave Airlie <airlied@redhat.com>, Timur Tabi <ttabi@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>, 
	James Jones <jajones@nvidia.com>, Faith Ekstrand <faith.ekstrand@collabora.com>, 
	Suraj Kandpal <suraj.kandpal@intel.com>, Aaron Kling <webgeek1234@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Zhang Enpei <zhang.enpei@zte.com.cn>, stable@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Kees Cook <kees@kernel.org>, 
	Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F35494FDD95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244895-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,redhat.com,nvidia.com,collabora.com,intel.com,gmail.com,kernel.org,zte.com.cn,linux.intel.com,ffwll.ch,suse.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 29 Apr 2026 at 13:04, Lyude Paul <lyude@redhat.com> wrote:
>
> That's right! It looks like this never actually got finished, something
> which I just noticed today when I saw this fun message spamming one of my
> test machine's kernel logs when enabling display debug output for nouveau:
>
>   [drm:drm_crtc_vblank_helper_get_vblank_timestamp_internal] crtc 0 : scanoutpos query failed.
>
> So it looks like we've been falling back to DRM's core fallback for a while
> now, whoops.
>
> So, while it seems that we do have the option of doing this through GSP -
> that doesn't seem like a great idea. Mainly because reading this from GSP
> would involve a lot more latency then we should have for vblank handling
> due to the RPC communication. So instead of implementing that, just use
> gv100_head_state and gv100_head_rgpos for implementing .state and .rgpos.
> It seems to work perfectly fine!

Does the open gpu module do this at all, I'm just mildly worried that
blackwell might have moved stuff,

If you can confirm by looking at open-gpu.

Reviewed-by: Dave Airlie <airlied@redhat.com>

Dave.
>
> Fixes: 9e9944449023 ("drm/nouveau/disp/r535: initial support")
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Ben Skeggs <bskeggs@nvidia.com>
> Cc: James Jones <jajones@nvidia.com>
> Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Aaron Kling <webgeek1234@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Zhang Enpei <zhang.enpei@zte.com.cn>
> Cc: <stable@vger.kernel.org> # v6.7+
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c       | 4 ++--
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h        | 2 ++
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 8 ++------
>  3 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
> index dbd984da75014..0608266188d3e 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
> @@ -253,7 +253,7 @@ gv100_head_vblank_get(struct nvkm_head *head)
>         nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000004, 0x00000004);
>  }
>
> -static void
> +void
>  gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
>  {
>         struct nvkm_device *device = head->disp->engine.subdev.device;
> @@ -263,7 +263,7 @@ gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
>         *hline = nvkm_rd32(device, 0x616334 + hoff) & 0x0000ffff;
>  }
>
> -static void
> +void
>  gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
>  {
>         struct nvkm_device *device = head->disp->engine.subdev.device;
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> index 856252bf559a4..b642729c254fe 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
> @@ -53,6 +53,8 @@ void gf119_head_rgclk(struct nvkm_head *, int);
>
>  int gv100_head_cnt(struct nvkm_disp *, unsigned long *);
>  int gv100_head_new(struct nvkm_disp *, int id);
> +void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state);
> +void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
>
>  #define HEAD_MSG(h,l,f,a...) do {                                              \
>         struct nvkm_head *_h = (h);                                            \
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index 6e63df816d855..49a1eef9bdf14 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> @@ -625,14 +625,10 @@ r535_head_vblank_get(struct nvkm_head *head)
>         nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
>  }
>
> -static void
> -r535_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
> -{
> -}
> -
>  static const struct nvkm_head_func
>  r535_head = {
> -       .state = r535_head_state,
> +       .state = gv100_head_state,
> +       .rgpos = gv100_head_rgpos,
>         .vblank_get = r535_head_vblank_get,
>         .vblank_put = r535_head_vblank_put,
>  };
>
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> --
> 2.54.0
>

