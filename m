Return-Path: <stable+bounces-242828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK7oIDEa+GltpwIAu9opvQ
	(envelope-from <stable+bounces-242828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 06:01:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F14734B8450
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 06:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5EF330068F8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 04:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A97156F45;
	Mon,  4 May 2026 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPP04DFz"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F64414
	for <stable@vger.kernel.org>; Mon,  4 May 2026 04:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777867309; cv=pass; b=MF2OaihguhjbJ60yvpxOemjsoFByzptQzIxR882lb3gikMFvWNDDOM5Zg0INHOnnLpFJl86CHHOAI+G244Ofxx2SWlpJimQxU1cJjU6KbbkLJRJ/W727nGVVyUGRLITlH5UKtjpquiDcJ51UcN91nbTyHSeSoTjTm+zKraxhnmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777867309; c=relaxed/simple;
	bh=ZYrEEY3Jzex6XXznt0iI1Eft5x/J7UCL8WIbq2xkqY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHC03jd4b/QVcmk7EH9Tq+cgW716i8p7WYG3kDBvwlWrvJ+Iki58BmAqmT/Rtmb797VVRe0l855FcpR6ioXNcQHfCF7bXC92ZXP9XCO7E1RG8g7VS4W7/1dC3Y/UH8mxE4C4Ddwy6TzAyoY5CDJjUYzIoaaNqoKNyzJrIRpSeqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPP04DFz; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ee63e91acfso280066285a.2
        for <stable@vger.kernel.org>; Sun, 03 May 2026 21:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777867306; cv=none;
        d=google.com; s=arc-20240605;
        b=czt/6fCMJjl+BFPZvlXLRrH3yRJdxz4nBcecYw8+ZEmi4UwOYER8iFULHScOx1JyH0
         jZNqzCWvlV55mH8PJKFz1lJxKF/Rchfza/KHb8drhyHqm2+cQROnhahWZFKME0Ll6A1Q
         Hlkz4E8VFEOu3u/ssmo/XnXNwQK8ziwT6PUov3tSXsxtdklzT32fBcyhmi3pTFHkVfze
         bbGeucsRYicFPLnys8Kf2d3TrHjYGZPIbqikmUBZ0eEO60t7ek5b4zPCWH8qLNXfgOSf
         VMFr+dqPLZ+o922dVEHqBAc36rhQ/LNjOnbT/yGYvx8jzcmVRGbAkcOTRxn6H+S7B3YH
         1RrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oGlVUVNCo7t578SnF0/FJlFOI+mo4qIG1hmcAiuexlk=;
        fh=M9dbtR22YJpxjjKrrHWfrtbzqPsUG8HkTYTaom3Rl3o=;
        b=DaRcBViLr6sN24fKJzKdfCynPhTO924cXNNbGHddZMuopKKe8FodHIDhsWqa5XPoe5
         LagkK7xlrAx3tgm5HVOWeCp0x7CfT7dXR0QtmNR20bsUAkbAp6TTcOwcyHoI6Bvj7kB+
         j4y6D+QFIPNBramclqww0KLb/MwRPQ99O+YidYHS/auAC5yK+xXMn2NRbopR+qZZbXUp
         sXtzV4xtW7tc87jtICGIc+SDRaNTGD3H+zBISszTxS78rqf+UhJwuN1zq0+VwIepR5ss
         jjAuT/65vwfkuACn26roUmRmMDEOl2UsJFV8e3YaWc5WumMTaz7hoXtt0tnCKo7JfxHH
         J9Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777867306; x=1778472106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oGlVUVNCo7t578SnF0/FJlFOI+mo4qIG1hmcAiuexlk=;
        b=aPP04DFzE7PZeXot8IQoDt6K50fMq/D5QcpbQPJgs6ZTkCsboTdAlpcu2YJG5uGRhU
         iHDDiYI2GH2dlSsvDpbcuFeRc9Nk83L4KOhSM4rHLux7IHsHW8uqXGPo6KDd0lHlQDZV
         lEsW5r7uOF7jxmIKmVXbAGddezPfUzPnlyyDL/m81IeBfwB40EpWeb54AFMr6Kl+85ef
         R4qgh0WJPhgd8CHpRm+L9+cBvW3ERwdy/AZ0kfFxgoA09w5qHrQus+be6uBdL6fgIW30
         czIDVM8GSwcTCc891bhiu35mVJshTUvd3S/0qloo8oSba2c2KbM/KY5sJf+QNHCjhRB+
         bwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777867306; x=1778472106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGlVUVNCo7t578SnF0/FJlFOI+mo4qIG1hmcAiuexlk=;
        b=UMm1U7lHHki+sB38JycN3QVICHHsrT5UQHSFzpg8zkDqTLHPGfzqzRz8CmG7kzJX7S
         mcOGz39b1+zvROm1Xr4yKPU6OeTd6LjfrEOgb+QrWCiwgCy4lRfQfE/w7SHAkqYYZBs+
         kFBn3KCN8EuUu3+D8AqJ2MCZ4kbFIqCuFNmZiNmj2UC9vWfkEQtdHaCvs/fayJvVnkHC
         GATiyGHXrW47SGH8RJlqbkAAzGOW7yyxZlMcECXiGCSKchRJYCN9JT4a+d7+TZk+AfRa
         xO8DOisP6ODlVUyB/EbxBAzM/2wEeCbZmMI8040o1Hz6najvkMtIXwPMSWuA9UKnAifj
         OkRA==
X-Forwarded-Encrypted: i=1; AFNElJ+SLSSizleq6hPrXjXIAuzb3q/w3j4VLHZNniJga39AkyRMSctViUwb53qtlprfVLf92+gUUVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHHypc+tEeYxONO0Q/60wnaY6lKXgkP/980DQs+XHbVwZy6e+D
	Dxw7kDW1ZhHvLVE8fsjlGa3Lo+UR/BpDf19jv4EC7dCjXLlp6Vmt3glNZtmRdaQq7yOjOSA8HbT
	BgmJcOCzNSfkgoLXd9Y4nFN+b2T7cK7M=
X-Gm-Gg: AeBDievuA22N9PxDZtZC45Fr8vNfMtczZnCFYPM2VJo+1S8uCABmKbetpehoXzUc2sK
	Y8DascS7uAl8QIouENkfxVEWRQQOBGcxJf7mnq6U8IUMJCPBmAAARvhvdkC/yVMhBC3Gtkq6O3D
	GjnMVCiSYObWWpTI0Ep6UNW79gr6acPLyLRcjuaUmLgwcglfnFrpW3UARUKArfL33nbN8v8IitY
	4ykXr2z6BuZCnVtngNw9+Dyx5m65t073N00jdY5SOjV+YGAZqKo/FfMLn5sWLREXgdrphUHY9l7
	1XJUAZjaDV8SRL7LZ9YPD0zPv0lPxnD+mIjOcbFBYJIe7f/dMww0hcmZYdcaYx3U80rDs+7ZTKe
	EwA==
X-Received: by 2002:a05:620a:708a:b0:8f1:5e8f:fff3 with SMTP id
 af79cd13be357-8fd16c9964fmr1319335285a.26.1777867306422; Sun, 03 May 2026
 21:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501215856.840898-1-lyude@redhat.com>
In-Reply-To: <20260501215856.840898-1-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 4 May 2026 14:01:35 +1000
X-Gm-Features: AVHnY4LmcMo5jkCCXrsqxOpC_hYtr1-nSy7Wtvdm85s7TmkVILKxYJXd3dyZi5U
Message-ID: <CAPM=9tyVOHU4KZxpGeKn=V3zhGnBwq4v5QfXvzdUE4QPQ2zMOA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/kms/nvd9-: Use contiguous memory for CRC
 notifier context
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Dave Airlie <airlied@redhat.com>, Timur Tabi <ttabi@nvidia.com>, 
	Suraj Kandpal <suraj.kandpal@intel.com>, James Jones <jajones@nvidia.com>, 
	Faith Ekstrand <faith.ekstrand@collabora.com>, stable@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Ben Skeggs <bskeggs@nvidia.com>, 
	Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F14734B8450
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242828-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]

On Sat, 2 May 2026 at 07:59, Lyude Paul <lyude@redhat.com> wrote:
>
> It looks like CRC read back has been slightly broken for a while now, in
> particular on GPUs using GSP. On my test machines, it's worked normally
> when attempting to use it from fbcon. After gnome-shell gets started
> however, attempting to read /sys/kernel/debug/dri/$CARD/$CRTC/crc/data just
> returns -EINVAL.
>
> It turns out what's been happening is that since we've been using
> nvif_mem_ctor_map() to both allocate and map the CRC notifier region - we
> haven't actually asked for a contiguous allocation, and simply ask for
> whatever type of memory allocation nouveau can find first. This doesn't
> work because the CRC engine on nvidia GPUs doesn't support non-contiguous
> allocations, which also causes us to fail setting up the kmsCrcNtfyCtxDma
> object on pre-blackwell platforms since we don't have a single memory
> address we can point nvif_object_ctor() to. Instead, ctx->mem.addr gets set
> to ~0ULL.
>
> It does however, seem to work when fbcon is running. The only reason I can
> think of this is that before we start up a display environment, there is
> pretty much nothing allocated in our VRAM that wasn't allocated by nouveau
> itself - making it dramatically more likely that we end up finding a
> contiguous allocation by default.
>
> So, fix this by manually requesting a contiguous allocation when we
> allocate our context notifiers.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 12885ecbfe62 ("drm/nouveau/kms/nvd9-: Add CRC support")
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: James Jones <jajones@nvidia.com>
> Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.9+
> ---
>  drivers/gpu/drm/nouveau/dispnv50/crc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> index deb6af40ef328..5817f39934a8b 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> @@ -10,6 +10,7 @@
>  #include <nvif/class.h>
>  #include <nvif/cl0002.h>
>  #include <nvif/timer.h>
> +#include <nvif/if900b.h>
>
>  #include <nvhw/class/cl907d.h>
>
> @@ -499,16 +500,24 @@ nv50_crc_raster_type(enum nv50_crc_source source)
>   * notifier needs it's own handle
>   */
>  static inline int
> -nv50_crc_ctx_init(struct nv50_head *head, struct nvif_mmu *mmu,
> +nv50_crc_ctx_init(struct drm_device *dev, struct nv50_head *head, struct nvif_mmu *mmu,
>                   struct nv50_crc_notifier_ctx *ctx, size_t len, int idx)
>  {
> -       struct nv50_core *core = nv50_disp(head->base.base.dev)->core;
> +       struct nv50_core *core = nv50_disp(dev)->core;
>         int ret;
>
> -       ret = nvif_mem_ctor_map(mmu, "kmsCrcNtfy", NVIF_MEM_VRAM, len, &ctx->mem);
> +       /* The display engine requires a contiguous region of memory for the CRC notifier context */
> +       ret = nvif_mem_ctor(mmu, "kmsCrcNtfy", mmu->mem, NVIF_MEM_VRAM | NVIF_MEM_MAPPABLE, 0, len,
> +                           &(struct gf100_mem_v0) {
> +                               .contig = true,
> +                           }, sizeof(struct gf100_mem_v0), &ctx->mem);

I don't think you can just throw gf100_mem_v0 in here like that, I
think you should maybe make nvif_mem_ctor_map deal with this since you
want a kernel mappable vram region it needs contig.

Dave.

