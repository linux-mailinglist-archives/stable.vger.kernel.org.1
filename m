Return-Path: <stable+bounces-226246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEz3MxSHuWncJAIAu9opvQ
	(envelope-from <stable+bounces-226246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:53:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDC72AE979
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21243163DBE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08E3ED5BD;
	Tue, 17 Mar 2026 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxjZRirn"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74DD12B94
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765884; cv=pass; b=a5eFwF3AFmgY+GPozz/1/Dv+XQhLTJvc39qOqU7NPA7MOupBP9guvYZuqLNDlYOpLOJGohve8vyAWNtvOB++1g35UVmXRi7qZXrAwP1xJ50ZCGfofXR6CpicFvCv7cB77ovcFyqApkW2Nv6YWla1qAQqsAE4m23QCERegBLuWW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765884; c=relaxed/simple;
	bh=xMcbKpknbNB3wXIMOBId0nSf8GMAY9SSAcNgv5qCF8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiOooOxwJaZ/JTdtPiThwfabOCGxd4l/xlhCuFAY92gScRmpA32YpDODpGMjrJ8+3VbBMITy+eJM6MFPOBXvXV5HTD/zGH/szH8wZqqi354qoe9lrIAuS/ebJUULZQ+tGmlRmxlqynalZGVq484XvCHwiLt/VEOV0vVNN3vOBqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxjZRirn; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5ffe68892efso3734810137.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 09:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773765882; cv=none;
        d=google.com; s=arc-20240605;
        b=H0PgWyS3/KB/alHefcQo5pMlrt4ZCxE3L2eyx/eSULdVgFO1+HR+XaevK5stETz/op
         qM7SHisZ9rHBWCUW4eOay1jWMQzQG4uPUU3jaSHAtcKZj28pywfQ1eyYC7GeXtaOqSNI
         PDPv3fcnlgm1RiMX4DCcNIUF1E2MbReXYTVwJarL/+QEt0E3j7nDEJz71drT+ScGp608
         HI48NfzInmcQcSA1re84zTAsT5a+PehF9eYWcZ2KDcaBH+Tc8xsCzjfmIt9W1pjrxFfN
         Gr0DJqhzRt8tqmfeFHXqDL1jfRbKc+RdLLD5AO2uKAjTZLY8D6yXQ+ojiHwOOjD854vF
         twpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H/R+aloGVg+DrEMGpfDHhX37OuxXGn9gF9e/LxkmK1o=;
        fh=WRz4vpaSSMH0eALkmgUwWN6CmUMRcF/Ub7t25Pt6LhU=;
        b=FQazdyKhfbm0A0KF8M3AQVNdDdZ9h/tT3hRAJvIjiS46NrlODGS25tUYnn3GKqzjz8
         QL5S9f/SnHy/dP2Nri/iKyuLwmb2r8ArPENLYncK7m/d8XLVOpAHGsbpzOLlPFw9O0UZ
         z6c9fQOOohu2V02dwJAuMP81xXhlfY2AgGvssQs3aH4XJ7TDOSMxm1NDiKo68zm9unpm
         nf22fjhqPCgxxRUnXlk8Epj83qEB1ORti/KTcgvV1GZa4R80YLPgEiPIlDZEMAJq2c9g
         ngBh3Oo6FemfFg+gNAZgBktKnCTne7vb+DS684rAFN3OK09TVZJjuRVMznITECvs8kwW
         wFdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773765882; x=1774370682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/R+aloGVg+DrEMGpfDHhX37OuxXGn9gF9e/LxkmK1o=;
        b=OxjZRirne7rYpYIdTAFZM8tNuCjsxhQNbaq1LBydR2Z47tWy3agCOoIyWW11nzQ8dT
         XOrcH4i1+vpI1dt0qDRlyL9FxErQR9rPUFRhqOI0durOi4PeNouijE4m1+9lGgCHDWDm
         hyFpZF2qvur7m0MZUx6RDaM7Mxcijh0aujBDs5sXtiGBkg5Y125X5FYnmkvhx2BNIVS1
         zX7g1RUz7ktlAXhQidnoenJphLbFqaa5cwb73UidVofk72zy+irMVd3xGxfMV10kYCB/
         U7yUhv9W8jdLynjPNxf0dRiNm2pO7PLLcVZpnrKUCjCVCqJ9yOkeyQsS0gEocxpK9X8l
         TCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773765882; x=1774370682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/R+aloGVg+DrEMGpfDHhX37OuxXGn9gF9e/LxkmK1o=;
        b=DuMyv291uN77D4+/Yn/yYbzKon9eFWcUsYY1RtjUKNBmKWi0x0sUdnKIA1bc+4BB6C
         8x/wgr19hcc75kVY4cuwuyCTF7Dp+b7FXgSogvvu4MkWWhBBVoYZV4mO2FIOefis5ATq
         qiNbNKRkWSBI3CYGt5Vj2FG8hktH7wJKXiL3OMQ0+9u8kGvLPqCyidW7cVlrw+cfouyF
         B9rFLS/Y60U0ryJonXtBAN84IpzWT9EvcRAMxt3L6uVQr1eC+8AdFhtDvtRV/sBa89Rd
         zUSSYNipYM8zw7p2MBTZhUFccZwz5yJoNdh/X3v66danhM/z1khrePAawhj8he5rUfM+
         yJXw==
X-Gm-Message-State: AOJu0YyA4PbvgTMEw7cWlOIE9noYtTEQ7wFKYw+1/wmfMFF/zzAUTt1E
	+04RfyTDQ6xAJamwuniTZp5f8fNuTr/OvAF2lEOfMS4y4IIm0/TOs4NSRounofG2arp3n1NZ/XB
	5il8kPmAzd4GQ8GxCbTph8aJOTFSoJzlnCsy4Xtxz0Q==
X-Gm-Gg: ATEYQzxILaZrdNsXomizcn0piTjO/sYoJweS8aZ1OPVlegSHrmcbvQxo+CqW7R08ppA
	tgRrTJJV609U9fz5srBIiEpAOSNgYtibfgiupa6tsSqip7jtmSJTAjPFBNhkcPsxLGwu1HUT9+t
	gXxqR7YMzWSzm3MT+HaOFDEtxfPV6d7FYopKqxZAQY1aq/i+MOkdxBNAOhSDwPIMqJm1yxU47/H
	3iQjHs7/NOuENnO71OYfXfwyeGfPycIgdRFlmbUTmHRKKxYUoC3l+7GBhmNFt7iqAtSjZ0WZ4kG
	d/F/wGmN
X-Received: by 2002:a05:6102:38d1:b0:5ff:d192:ff22 with SMTP id
 ada2fe7eead31-6027d2c1358mr229683137.19.1773765881800; Tue, 17 Mar 2026
 09:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317163006.959177102@linuxfoundation.org> <20260317163008.013706115@linuxfoundation.org>
In-Reply-To: <20260317163008.013706115@linuxfoundation.org>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Wed, 18 Mar 2026 00:44:16 +0800
X-Gm-Features: AaiRm524OytN7slxZeciId_g8UhvL034v3qBbAQcxH7-KpElWSyfYcpzgxFm_6I
Message-ID: <CAH2e8h7pAR5M=P=5Lb2ZgfWd=J9fj3yJanVrqmOTgXRmO4Roag@mail.gmail.com>
Subject: Re: [PATCH 6.19 028/378] drm/msm/dsi: fix hdisplay calculation when
 programming dsi registers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226246-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mitltlatltl@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid,qualcomm.com:email,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: 2FDC72AE979
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:40=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.19-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Pengyu Luo <mitltlatltl@gmail.com>
>
> [ Upstream commit ac47870fd795549f03d57e0879fc730c79119f4b ]
>
> Recently, the hdisplay calculation is working for 3:1 compressed ratio
> only. If we have a video panel with DSC BPP =3D 8, and BPC =3D 10, we sti=
ll
> use the default bits_per_pclk =3D 24, then we get the wrong hdisplay. We
> can draw the conclusion by cross-comparing the calculation with the
> calculation in dsi_adjust_pclk_for_compression().
>
> Since CMD mode does not use this, we can remove
> !(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) safely.
>
> Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Patchwork: https://patchwork.freedesktop.org/patch/704822/
> Link: https://lore.kernel.org/r/20260214105145.105308-1-mitltlatltl@gmail=
.com
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Hi, Greg. You just told me you dropped it. Please drop this patch for
all stable trees.

Best wishes,
Pengyu

>  drivers/gpu/drm/msm/dsi/dsi_host.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi=
/dsi_host.c
> index e0de545d40775..e8e83ee61eb09 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -993,7 +993,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm=
_host, bool is_bonded_dsi)
>
>         if (msm_host->dsc) {
>                 struct drm_dsc_config *dsc =3D msm_host->dsc;
> -               u32 bytes_per_pclk;
> +               u32 bits_per_pclk;
>
>                 /* update dsc params with timing params */
>                 if (!dsc || !mode->hdisplay || !mode->vdisplay) {
> @@ -1015,7 +1015,9 @@ static void dsi_timing_setup(struct msm_dsi_host *m=
sm_host, bool is_bonded_dsi)
>
>                 /*
>                  * DPU sends 3 bytes per pclk cycle to DSI. If widebus is
> -                * enabled, bus width is extended to 6 bytes.
> +                * enabled, MDP always sends out 48-bit compressed data p=
er
> +                * pclk and on average, DSI consumes an amount of compres=
sed
> +                * data equivalent to the uncompressed pixel depth per pc=
lk.
>                  *
>                  * Calculate the number of pclks needed to transmit one l=
ine of
>                  * the compressed data.
> @@ -1027,12 +1029,12 @@ static void dsi_timing_setup(struct msm_dsi_host =
*msm_host, bool is_bonded_dsi)
>                  * unused anyway.
>                  */
>                 h_total -=3D hdisplay;
> -               if (wide_bus_enabled && !(msm_host->mode_flags & MIPI_DSI=
_MODE_VIDEO))
> -                       bytes_per_pclk =3D 6;
> +               if (wide_bus_enabled)
> +                       bits_per_pclk =3D mipi_dsi_pixel_format_to_bpp(ms=
m_host->format);
>                 else
> -                       bytes_per_pclk =3D 3;
> +                       bits_per_pclk =3D 24;
>
> -               hdisplay =3D DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_=
host->dsc), bytes_per_pclk);
> +               hdisplay =3D DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_=
host->dsc) * 8, bits_per_pclk);
>
>                 h_total +=3D hdisplay;
>                 ha_end =3D ha_start + hdisplay;
> --
> 2.51.0
>
>
>

