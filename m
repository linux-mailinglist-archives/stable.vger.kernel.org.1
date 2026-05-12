Return-Path: <stable+bounces-245403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ld8HmjPAmq7xAEAu9opvQ
	(envelope-from <stable+bounces-245403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:57:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CF51B5CD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30EC530189B1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 06:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8463368D79;
	Tue, 12 May 2026 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9kNbjTW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B83357CFA
	for <stable@vger.kernel.org>; Tue, 12 May 2026 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568991; cv=pass; b=d1qWr/hHhu5HCPBX1WV+ZwaiKF/kc5eN2ka56/oRHM+ZiukfxAzlCyTav91mCXPza/MK+y14z2m9o+JISv3iuM7IapEie9jbbWWUap3OIWstxdshg6w1F0nMxJzwiLy1tAdTckA0i8JhRqOHMD9Q2ozuKkQdv6tglBE/wf8qWIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568991; c=relaxed/simple;
	bh=FVo5J963BO3uFs2vA+x3FGGSmphsslKBoP0bTriEptI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGM4kSW66gry5tnNyAVnseyoqCQnx/zx6kmOsd0XAhNLEo25cqEaNJ0GGoN4PcVTFGEYALblYrQ5YQxyBKqorFiIwaJ6bmukOuLMm2knaPtQ9LaRdftrwtCpG94GyvpjpdP4/fRiGIY3TkFHRmD5zbu0D0UzKW5DW/sS82Xyj4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9kNbjTW; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bcff2d08ca8so256464966b.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 23:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778568979; cv=none;
        d=google.com; s=arc-20240605;
        b=T/XOZYVrUVAt5zzkzonWIRZReXymzLN+wC+n50n9zJamOVPyZBkuc9mVXx1YtEEVTN
         HGFweQ3TRRJBTho+g+JWUzDa8YHJgOwxw6vkFG9zS455uihO59inZmce8cuWU0kB4uuj
         bX++vvvuN2BnWod2FqiPeeBOxrAZyo0wwiX4xeSLeNdlG2WRFS1dSsQBNA8oNpKZCN8F
         f97RcmBXG437HYDKVgIvI2N5qkziZPHJwNClpLN2E0LT/TI5ltTyI4QyHe1JkczNp+P5
         wSmCYQsJIwKppBVuV3QsoeGjFScV+Qj7Ur89gHDxhKcrJ5SN8yxRPaec6glGmdx8WmSv
         X5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PcRJD/2KrbXOyU9n8vUeVZ+ZFPiSsT4NRjDMaC2zai4=;
        fh=TaZFprOkrBzJHancrHAdWKFmsk7VW6a8+dwJNya/9Qs=;
        b=LUPjjdX+ohy1PnQrvEt7/jucEmSMsLAW9lCzbcTNtQpU1HuptP1b8tNR/2vlf1/n0S
         1TrsMv9Bj5M2DslS86lW0lAkqmeVvGwhdvAE9AAK5cSWRMWbcfacpCw56/O/lAYTNZmK
         z+aeN+2PYgFxuoMJvni1cGgdpEfFG3yuzioLj773y0ErNAIoNBWcTT2sB3Xp05Vntcxn
         3pmgdcy/ZKmkicjN25vuTsBeBkCuopkFOLyoNvBDh7eVRXYDxKKOv1wpBiRZFalA9zqm
         Fi31rZbocpA9cZctr6Q8cdros2/Mj7/2AvC57o47KH5fklQmXBCdRC+coPyLAu6zQibE
         VwIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778568979; x=1779173779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcRJD/2KrbXOyU9n8vUeVZ+ZFPiSsT4NRjDMaC2zai4=;
        b=c9kNbjTWE2loF1Ir/uFAvfE6IGKVwezfjNIcT3vKgB7Nz9lRzHGZbt599uWDZb70We
         1BOuCeNOk3l/Uztn+bYoxgIPMU5mPeJbnyT3/bksHGYOcV0NA4Vt9Ho6XmpiFPwS5s5S
         cF4EGu5Dx5YLaOh+C2jOYLZf4K3622dqIgi3kdSR6LC+9ry8DNlJd892wvhFTN62zWa4
         vvY9saAww6azsOhzrICs+IuOMhiDiV3sl8qhA6hHmhfAKfYhhnyo+jx81BNYlGhPfzzq
         H9VORexiBf/NUG/A3pCWbkxV18haNWQTNSNuOfRwoNIlI5jqzkfiLtnXcvCH5ASfUD/N
         ZoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778568979; x=1779173779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PcRJD/2KrbXOyU9n8vUeVZ+ZFPiSsT4NRjDMaC2zai4=;
        b=GIBxN5NkD1xeeGMYO2fPmMZah9p0QleotO1HHSZ4CICaCocuZvNfac70cMjVqVJ1nL
         226mAILMzchAEFlqWJWAKRseGG215bhBLGCWr0AXpDiGZyWNbooqiTqQ13jW9dhLnnGl
         nxWbldRE60wrhZAsfYxfZpIsHfRMlQi/XEyjvFUy6PhFB4gANLT2rbppAmuAqvNtapLA
         gZtq3dWN676AL3GVtKa0p+TvEua836ko+JfQsP1SSfCVSXlnn6aek2SlqgM/RTd2dwQC
         bjbr4Zlbt82GNlvR1AQ38yWYNhSlPrgyQHyPVgY67LO5jBp7e3sZDPqcYcoCsGTXxNDq
         U4Jw==
X-Forwarded-Encrypted: i=1; AFNElJ/tbruiP/bZoOu/Sc+lxoUd0PJSY1LTnVKCpcw1tt82Ea+2KApa5Xo/Lu1RDhmex+NgpXBU0Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfw7m61LYDx5RaAa1ovpFLEOvmqubzvV098Rubo5Rh4iblWRzV
	Ux4T/Zf/fJFFAgpiYJpe7FGOLESU7jKkTlctneUQHlKYG6UqNDLqeYefJIQDKPjJBJPfGhv22pl
	J5OtvSSb/p74rjlJEJOWBQUWrc8vGhw==
X-Gm-Gg: Acq92OGuQSpRFV0wXDz/px7LoXptcFlKhVEnzyBlqggM4Mc5TKHq16+86e5ZuMJD6/O
	5hqU8Dv/V5rXSXGbkLFWVwZ3H2WiOFTst8Uh7gjJnaqZ1ogUljGc+xJVFFsn6BkulPSexKnMbzn
	siUGJA5tumnxsGCdFpi5NybF03Jj7psH3WbOBs9/WxekICScNlGJblDdpiq2zsuVMSM4o2kuLsy
	6mR2Frlj13ooG8VF2mqXAv078kX5y95HI4HZhTkgOx3fUhyMW3fX/uo4F81pwwuQZccRpTJ/f+Y
	EXNl2/IWN2P2HghBiwQi7S9F8Ms+V6/9GH2aHrU=
X-Received: by 2002:a17:907:970d:b0:bcf:1d87:11be with SMTP id
 a640c23a62f3a-bcf1d871b7dmr522910766b.19.1778568979088; Mon, 11 May 2026
 23:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512065436.74729-1-mhun512@gmail.com>
In-Reply-To: <20260512065436.74729-1-mhun512@gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 12 May 2026 15:56:06 +0900
X-Gm-Features: AVHnY4K93hHdbZPZVPL3TVOHCvpPLydK2RIIOIY9b5J-khG9lMURvKKo9bEL9_A
Message-ID: <CAGEsz8Fe6jSvHawbq1owQ5TUm1YprufHf5mLU4t0FdYD_UykBA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/loongson: use managed KMS polling
To: Tobias Klauser <tklauser@distanz.ch>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dri-devel@lists.freedesktop.org
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Sui Jingfeng <suijingfeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
	Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 824CF51B5CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245403-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iscas.ac.cn,suse.de,loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,gmail.com,ffwll.ch,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi,

Sorry, I accidentally sent a duplicate copy of this patch. Please ignore
this one.

Thanks,
Myeonghun


2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:54, M=
yeonghun Pak <mhun512@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> lsdc_pci_probe() initializes KMS polling before setting up vblank support=
,
> requesting the IRQ and registering the DRM device. If any of those later
> steps fails, probe returns without finalizing polling. The driver also
> never finalizes polling on regular removal.
>
> Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
> lifetime and automatically finalized on probe failure and device removal.
>
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
>
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller=
")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Changes in v2:
> - Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
>   and Thomas Zimmermann instead of adding manual cleanup paths.
>
>  drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongs=
on/lsdc_drv.c
> index abf5bf68ee..4b97750897 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.c
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
> @@ -292,7 +292,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>
>         vga_client_register(pdev, lsdc_vga_set_decode);
>
> -       drm_kms_helper_poll_init(ddev);
> +       drmm_kms_helper_poll_init(ddev);
>
>         if (loongson_vblank) {
>                 ret =3D drm_vblank_init(ddev, descp->num_of_crtc);
> --
> 2.47.1
>

