Return-Path: <stable+bounces-246763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMa/MsAgBGrcEgIAu9opvQ
	(envelope-from <stable+bounces-246763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:57:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7455752E540
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73F9930540AF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C53D5254;
	Wed, 13 May 2026 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPsQ+SEB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F62D12ED
	for <stable@vger.kernel.org>; Wed, 13 May 2026 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655411; cv=pass; b=P2ELlJT4H9BO8XxQ7WlIfaMDXx3QWESPjgqA2P9zHW+tIxkrqvnldqFqsBTmhDPqfMbPhTA7mhupvb+AHdpwxjlCd2vEDPAJaWylciHx+TjZq+vXVMNcMQ+AI4ZgLnnxLfBsYQAV2R38q5hK4AuJBjYbKnLN0x0mSwbucHZ+e84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655411; c=relaxed/simple;
	bh=1t4DjqSfZP+/0pJE5yYlixrxRfv2mAGSc5zNtd2C43k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFrfjoN2qWEDOpdX4AtSu0rjZThO8uLitff1d4hoIx0HOp6QdROmQyGjxbIfE6ZjC0/yJWDGb3u0eYNEQsHLEq7A03Vs9wpw4WKL3CdJO3Epsa/rFnC1eO3/6WW/YPcLDvepXr1wBESRVLxBVXW/WCe6Ed3hoOXgvva9j6WuE0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPsQ+SEB; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67f7caa33easo6016147a12.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 23:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778655408; cv=none;
        d=google.com; s=arc-20240605;
        b=R0h9StU9/btkl/AUjxA3FcQS49oK3qOQdESyBAiDpqIwYfJVTXI7YDEvQT0EH11qzR
         w4//uIFODP5X10S3aE/zpkbmUjYP1aLdl0espVU+/f0dHefmoFfJmy+BVSJq8JfUESlw
         oGyH+egSE/g20/w0iG0vVSE0ddx2JlkhRqAEFTsGCFQDgkIDBZRxqV4dmLDt0arEucmf
         NZF9o60smEkk4QsNLUTMv8MCz66zjBPMUEF3Hoz0yfLKfmOCkUroEo6XS+eX++4H/bp3
         UkuZEOxh62/3UxLjiwcDs7j24HywU3v8IBeZ+R59v/2yh2vW19W0TDFE5856i9yejtBz
         R5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PhQrfUdoCB4sAIkMNxghhrLtB7UyCZQhzPzKjzBTkvg=;
        fh=nhtByegdTJCPEGPG3qSFotk1PDiXmS8IHXTumTnwN/g=;
        b=ZOO2MCkz5I/Qqxk31SeVsve0insXK5YHHd4TrdrOjCuRCczaZVSAhOsWVMnjuQ0XGW
         +OIYuBp+AK3C8p2L3k94l8LZ7KBGuglAyVtbaOZ8w9SCNOX5cmoP8fevkflR1MRGVTjL
         UhfSpvGsKM5gRB/tDixl8PzYDwpmASOyxvr5qk4AGCNkMf//qyXseSqZmuyVhvzsrlAU
         oa4ALLKkMMwXzgYQSQvVAg7VWtWlFLabJeerMimoILajJfNAP3tRf8XA6e9fkGjUmQUH
         lgRAMZGLPUTh2Kf1EFVTUJYnYUG0YwQEcL8m0inyrpKlwPRSJ54RC4wCLEOYn4sKnOGa
         7OQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778655408; x=1779260208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhQrfUdoCB4sAIkMNxghhrLtB7UyCZQhzPzKjzBTkvg=;
        b=mPsQ+SEBuOvYpPLv7kNdSJFJgePDlCQ7gdc8Cq//VUvbBHeFA18O/kJIto+R7sgn80
         jEZcuMxsoYBcVQP5yFixcZx/apRGYhgMqEbsML2f/zZZiguadmCEh04hkF7AmHS85BYc
         GPDeX6TyPI1sHMoMJ/UW0S6Tubv9z5qaV/clc5oSpMqi93lxX+X9ndF0i7nYDIvBJITt
         nA00KgMnkX1OP/IYE50BOtRsNmKy9IQCdrDvgIr+wpV4M5Xpsw+cdsWVK5Rijryrf0Nu
         +Ty4buMWCaAJiNDgE01kcODNKmw2t/nzVtFwpiUU8Ln0CQjbWmX1yaDHMuamZkn2CwIc
         ZQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778655408; x=1779260208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PhQrfUdoCB4sAIkMNxghhrLtB7UyCZQhzPzKjzBTkvg=;
        b=gx3hq3E8FDG97REo4bAFbZEudcKIwBuAqHrHGlmeUSw25g9sdEHRQg0q3Yls+iKHo5
         pQiS4eedAneJpRMY6sJIy5jfB6WnrCvws1a6sHLZDIWwOuOmXdpA18TD3ouIoT98W+96
         g5d7Z7QoTSUoyqw4KnCFgfYsCOY7YjPzi1q1LR7lw66uidXMXMCSErDVpg35UV1gH7kQ
         BGPsuOZXmT+Hx/QR5jIVss49/92ceiCNwQyLoTiAszb82Gu3PBxDjTv32Bge57dj4Pjx
         F14xpZGUuHxxY8XEmr32tG6VczWHrU+2RkBXMaesu+KfD3FbK4rij4+I5V0uDCKFNSxG
         A/Nw==
X-Forwarded-Encrypted: i=1; AFNElJ8xQkmp5zOUXVhGW5lmjrdB6JTefeCa8aFiqz7oikq8aJywvZhXjV40s/wKZa0Q1xZRpXYA2ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQnSvvHxHb9xbIX7Z54sj6wZbMLaKYhZGmm57RAOOE23u3cTNv
	hVfPO4d45KO/ZDId2+poT6iJPcPzhVDK3nk1E68L5n5tOsGvt3yskwKK+P70xtTzUYJc7yFzHXF
	SRF0ZtO4dXDSs0b0qaPvONZ4y6VanJA==
X-Gm-Gg: Acq92OHUMAz5yzatrcYfRDutQEmhxZvCQ3vpxJbU7lDoE7aWpFBB27R/s4ukBZFgoIg
	CPoR6bA8lS9s0CUf9uUxVSlNZBQHsv7gp6a2Y1+nFibcwnT4TNdu+qxwh7+aK+KStZK+gEBqsMA
	MtZq0Hh81bn9ziAHoB8ytLcxh+Z4wG8sPKP/cQiTggFCqgfRWnX0xml9HzT2j2pegc9Fu9csBPe
	LOclcb2aZNwS5cvglHWrhhvqgoGh0tMyOh8MJzwSBd7ettV8QgGxoX9HzqAvPeXmJeLPFCFN6II
	9z3IFIjmm5PXCKc7leh0INkkm3j1TI19Q5VuLeVw/nesRwNcHQ==
X-Received: by 2002:a05:6402:540d:b0:67f:cefc:e55e with SMTP id
 4fb4d7f45d1cf-682a6ffc412mr700461a12.2.1778655407946; Tue, 12 May 2026
 23:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512063657.53100-1-mhun512@gmail.com> <CAAhV-H5Q5_xgi8WDgGGYLo4ivXv7tKeK2i97sZng2LzncsmgTw@mail.gmail.com>
In-Reply-To: <CAAhV-H5Q5_xgi8WDgGGYLo4ivXv7tKeK2i97sZng2LzncsmgTw@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 13 May 2026 15:56:35 +0900
X-Gm-Features: AVHnY4LvdNuNmbwJChRYGIk5bqxuPH0-UHkrhalvT-vYknhkMn5VdF1AEOsEtMI
Message-ID: <CAGEsz8E37y4+sk4kMVsZ1nHJ4e_qLbCWx=a5iK6-stG5KwtB0w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/loongson: use managed KMS polling
To: Huacai Chen <chenhuacai@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sui Jingfeng <suijingfeng@loongson.cn>, 
	Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
	Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7455752E540
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246763-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,iscas.ac.cn,suse.de,loongson.cn,aosc.io,xry111.site,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Huacai,

Thanks, I sent a v3 with the subject fixed and added the Reviewed-by and
Acked-by tags.

Best regards,
Myeonghun

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 5:11, H=
uacai Chen <chenhuacai@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, May 12, 2026 at 2:37=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com>=
 wrote:
> >
> > lsdc_pci_probe() initializes KMS polling before setting up vblank suppo=
rt,
> > requesting the IRQ and registering the DRM device. If any of those late=
r
> > steps fails, probe returns without finalizing polling. The driver also
> > never finalizes polling on regular removal.
> >
> > Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
> > lifetime and automatically finalized on probe failure and device remova=
l.
> >
> > This issue was identified during our ongoing static-analysis research w=
hile
> > reviewing kernel code.
> In the subject line please s/use/Use/g, others LGTM.
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>
> >
> > Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controll=
er")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
> >   and Thomas Zimmermann instead of adding manual cleanup paths.
> >
> >  drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loon=
gson/lsdc_drv.c
> > index abf5bf68ee..4b97750897 100644
> > --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> > +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> > @@ -292,7 +292,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
> >
> >         vga_client_register(pdev, lsdc_vga_set_decode);
> >
> > -       drm_kms_helper_poll_init(ddev);
> > +       drmm_kms_helper_poll_init(ddev);
> >
> >         if (loongson_vblank) {
> >                 ret =3D drm_vblank_init(ddev, descp->num_of_crtc);
> > --
> > 2.47.1
> >

