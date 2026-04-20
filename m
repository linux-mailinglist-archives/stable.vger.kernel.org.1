Return-Path: <stable+bounces-239234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCo2NJJV5mkDuwEAu9opvQ
	(envelope-from <stable+bounces-239234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:34:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F442FA58
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2E9332CA7F7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604B2E8B71;
	Mon, 20 Apr 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="OndlmNgn"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99E37266E
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694395; cv=pass; b=T7Cl7JNEhOT7gBVlZlSL/JjuXARNxRYWamNpIrO1lS3jfyalF2g67ZST721U3Yt3MFgaxB4PFH3Jf8D4Bs3PmULKkXnUdXE28TahRBOtB2pGXZJfLuc1IqeNIxgeLwKFqo4v9UECZoUaoagVehPfAFBvRkIEDgY3RUAdEkUxomo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694395; c=relaxed/simple;
	bh=wyFN4EfyT9jkbRHQzJ1vfkEIN/Sr0RbUF279Vtcb9Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXHIXqcjwfhzeZePhKRw4k7TMTdbXZOHfoGrp4ccTwiRrMIU0O90VsdjFiAvR9V+o/zILZX6a09KsYb4CrHx63IPinLIhePvmAkWkkkqFcqtTZBic+LcdFx32JuKLyKs/EgIZWxVmCFrGHz8+jWC6wBvPfxOAdFj0LxBk9TTCOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b=OndlmNgn; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c726f46baso3571686c88.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 07:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776694393; cv=none;
        d=google.com; s=arc-20240605;
        b=N6xwWi6s/bwcpWDuSlj4hGnaeQNHbNWAcghDdbuI6Qj4WbC1Lh/6PIkPC4ZscXs9yN
         kYRg61w26kic4IGfIBiDoV/MrkkN0OWMe8Y2j2Wx/FXethxr0hk1Na895A9vpBlb+Ntp
         4Lt53a7ABrFpxSgnpZQI7WvLrwri2dWUwLlm40q10IcbtqCX6ob2csFZJfDSU4OEoDwN
         OOxrW3jN2+XL/UGdNCBYv0TVHFAY6siTCdQ40HMVGDCg3JGKOV8uKsHlceSvFolwVjv3
         3KAeJGo7Szq44/2PH2VzrEoDcn4xUnD/V01+xj8Ky5KarGFjibeI2Fa1mgdIU835Tv/N
         TWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RY55dkbCNBUBL969VO5sT1O2XMpsnPH2PC4wwUHFnnE=;
        fh=SvQScIE2HiwoZ/ZeL8QIr7rEt1k4fNqob1WlVWa7oCU=;
        b=V+OXgoCra1Ki7aDSJDjVLd9dYnWszxfjEvoXYzjXq22e6+CrUmWddChk0qJK5dasUY
         gRqddXE07uuAWapewf+SAIft80Pf5Y7HdZ0n9YbIkfKV4L/iR+4muiM5uDqYOBO6IHl3
         /2O5O3Fku1MENimJIsmYJbsRRGmxvczioBlE2muIFuBGF6cZX6KGOSCi2thfQedd2Lvc
         q/iNLHbvWi1dSdIstmi9eYa/lueUuOnXD3dw3aewyoR49taI8t6XkSWIWpIyO0bpGxQe
         Uq3ix+yXeF4rfdiRwuQnX+VkVda/mwOt01U9atKykOEv5O5D30SCGlng48IL+B/w0iDZ
         jL7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1776694393; x=1777299193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY55dkbCNBUBL969VO5sT1O2XMpsnPH2PC4wwUHFnnE=;
        b=OndlmNgnPezTXTXCmCF6ITcjTmQYPRPibDXPJc7h5M+gqnjboPUDHAPpOvv2/CxoNV
         P5jcTVS6jvSe7oWmXg7IulJvHV8UkkPQSUaUb79gZF3MC2/DOj+uUyWivtAHxfk8ftZQ
         mKm+yU7WdfKLT48VdZbx2GlZUEENVPgOOxg1/s40g55zOEpvEmBA13YYenUJTNMEBmbr
         fD1CbdXjCKLdMR1lMLDaE8H4tW6f8QGO6ZYUw5M3MEXgA+nBSXdcwByORqCiFoUDvUrE
         YetV76AH95RjXbk+Vf0qAHwOiedxJKk1d8SJgpa81lbndDVQDHtD1Kj5TYFzzBOX/5IF
         BvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694393; x=1777299193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RY55dkbCNBUBL969VO5sT1O2XMpsnPH2PC4wwUHFnnE=;
        b=V/oJUpDilbNQNp1OX3si/rRxv5ZCcV1FIuemnjxraYqlEc7vyi7vxyCXZa79ecVETn
         FkEjybxLqTsjsL2hwGN+MC1zEZErjSfHssRQDkPLKOyZkAc3i9r5K3HqQr3yxeBLYlW3
         DREJvy9TeiOiDzPndaijFdz6ANteA7MQbzEvJbDIkU50yndD5ZKoh1auD5EY3453ggUm
         iafSsWR1BgWRetSHM+Spw9lA+2aOczs6F3IUJcZiUtdjjzivWyvKEGUa1qVuNbKrH01n
         kOIp/T3iQQBPbaCceZlnW8hwQNi1XgxOkw7Zci8F6/N8luGFQLpieCDExVobKIg4KvFr
         ASOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/d8QzenxuVck51Hio+7d8WkupwchbWGxFa6eCqQDec5kgu4dqB05hAWkJdtIEmLc3tVWS7FJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8wZMVLToaaPliMbnEXN1qSwv8u6LInDWnKMq07/7+RcXErxkJ
	WNxDArxt9oOb3ODlwslg/0KQXGOALjGSmPoSoYzsDF5jXGKzFRWuTkIm51+RQ5D7IpeKBdpKvg7
	sijXkEZcZMw0AumUBl5CGBSPJMaip4caxoko6VsIt9g==
X-Gm-Gg: AeBDietjM/cWz7WFwlxD9mMsEpb8hYele6VX9TRf81BFFVPz1ss4RedzrMNJ6K4Owvt
	3cykOhm/yFWh5GxHhsaZPE8AOm1c1qjT6SkmbwJ/q9sYUF35uNms6/w6EMzlQMAWua/2krA6Ro0
	MUrAyNjUNLMR5ZL3/A+a3G5Y05Cs+/bjayapcXiHtdTisVw4QVDPaF/HirgOCNkTveg1M4AGQGR
	7IBT1MExpQwuJ1saGo6tGPtVDhjyvsfC+HuUUWse06sfju3RV7X4Fhi+z8wzg5DdWz5WaIDrELx
	6GeZ7n8olbU2u6/H
X-Received: by 2002:a05:7022:2602:b0:128:d23d:81a2 with SMTP id
 a92af1059eb24-12c73f9ae5cmr6646930c88.29.1776694393074; Mon, 20 Apr 2026
 07:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776581974.git.gye976@gmail.com> <c0ebf83b345721701b22d8f5bc41c52c0ecf5e16.1776581974.git.gye976@gmail.com>
In-Reply-To: <c0ebf83b345721701b22d8f5bc41c52c0ecf5e16.1776581974.git.gye976@gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 20 Apr 2026 16:12:59 +0200
X-Gm-Features: AQROBzDs4_XjqT-9GndbRM_zOc4QlFRBoosVudK8gwq0qmMTzSwHuryuZaTsSJc
Message-ID: <CAPsqS2Q_p+_+XDstWworSL=Bdg=ENtDxaVTcxpchF4qm4WwWEw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] accel/rocket: Fix prep_bo ioctl leaking positive
 return from dma_resv_wait_timeout()
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Rob Herring <robh@kernel.org>, 
	Steven Price <steven.price@arm.com>, =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[tomeuvizoso-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tomeuvizoso.net];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239234-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tomeuvizoso-net.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomeu@tomeuvizoso.net,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,arm.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,tomeuvizoso.net:email]
X-Rspamd-Queue-Id: B10F442FA58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 9:19=E2=80=AFAM Gyeyoung Baek <gye976@gmail.com> wr=
ote:
>
> dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
> on success, 0 on timeout, and -errno on failure.
>
> rocket_ioctl_prep_bo() returns this 'long' result from an int-typed
> ioctl handler, so positive values reach userspace as bogus errors.
> Explicitly set ret to 0 on the success path.
>
> Fixes: 525ad89dd904 ("accel/rocket: Add IOCTLs for synchronizing memory a=
ccesses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Thanks!

Tomeu

> ---
>  drivers/accel/rocket/rocket_gem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/roc=
ket_gem.c
> index b6a385d2e..c80847192 100644
> --- a/drivers/accel/rocket/rocket_gem.c
> +++ b/drivers/accel/rocket/rocket_gem.c
> @@ -145,6 +145,8 @@ int rocket_ioctl_prep_bo(struct drm_device *dev, void=
 *data, struct drm_file *fi
>         ret =3D dma_resv_wait_timeout(gem_obj->resv, DMA_RESV_USAGE_WRITE=
, true, timeout);
>         if (!ret)
>                 ret =3D timeout ? -ETIMEDOUT : -EBUSY;
> +       else if (ret > 0)
> +               ret =3D 0;
>
>         shmem_obj =3D &to_rocket_bo(gem_obj)->base;
>
> --
> 2.43.0
>

