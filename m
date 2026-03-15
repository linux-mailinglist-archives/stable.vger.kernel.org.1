Return-Path: <stable+bounces-225474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ByZDEXJtmn6IgEAu9opvQ
	(envelope-from <stable+bounces-225474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:59:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994C52911A6
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 15:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA80C302DF9D
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F109370D52;
	Sun, 15 Mar 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF8IPf7r"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DAE36F421
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773586707; cv=pass; b=u6iW02HpsbTPx1bIkX6zY/SniuOGD0oSadDPin2dkpN2tBfR36DJ+H1u+zOY9GJX4IqXOLluxx5cCnSj+6wIGSq6z+4STnCHCiQUgwiL3LkWYr6hJeNjFGwQzOtdGBv6wgI+oAd3dApjuz8ZLf+OG58tzHqCgjHxy1wEih1nxtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773586707; c=relaxed/simple;
	bh=hbw3vQ0T5BKBBqs7TYv+jXHj6gNcypGmek9kczs9ZvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpJCmz1X34FjcjTvt07WOgdtqL0NM2XxzvBq5rIE1GFBEHFOCcl2N3J7FcBrcyt7QkNJLggtWFe2Vd5Mlhiw2KzC7MgnPgLxGEPtKErwC/8+n7X8WDrlCZOi5MkH9SfBR3PkbpSixXMB6PGDywwXEK6rNt7BDo6VXzeW+075Dak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF8IPf7r; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so818675241.1
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 07:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773586704; cv=none;
        d=google.com; s=arc-20240605;
        b=cEf1LE2qzk+B6YOdWGWk1QtZHkeFSGlMMzv74ANFmRg7Uzg2kPkSZbfiWo7wwdW05j
         YwdrnLgqkA3SBr7Fmkr3/p7kTPs/X+4pmKgygV7Wzt6gBmmp0XRIif+F8mH7KZGhmbMv
         BguqE01jrQsgqXDFZzAteoueTNHTfgvoX6rfPHgUvFCD5Oj/jHXRdaYS22mQq4oZKEoh
         Z3Up9uKhFgQtl65XmhxhhCz1Lprn0Fu0qDJjtcgMrAuiz0Xq6hHMExwXLMMRihSbs/jB
         lLrGcVehDPqaYmQzA+7Rwpq/Xq/cl9iveyTj4jfkr0eL/NPjMAGmk9QJk1cJqAM1p2Wd
         IbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Zt9O9F4MckQFkyMpiwV8gz1R1wfXWraqpMa+gKy50Y=;
        fh=5P0FcKbZBKfGnUEpYBgc96vse4RKupVPCvivjj70X9s=;
        b=bra38D9dp+jKDYdKkesITRjOxVxQGwEX0nrxupIh+SQtszqVd9o0wKjo1hhcPZKIqj
         /Nz9eYTLdBAJLfSpFE5+TM9Z7Uh5ypw+mOrb0ZK/opP8t6wJBbXxvLrEPzNBhWOiuDRk
         mPJRySpT6MVvgePTc5/mMjazMdq+rSJQ/M8sz49PDB6T1YcuNXp+8Zm6h9nmM9cGlScz
         pEv5a4lEcB+ioMotogB8AWR0fGSz6W09/YzXgGDfBrN9hub2Xk2nacpA9x0ydcKQUK2i
         YntTj9ZrNow6pj6sgLTrb0xjN5azYc4YNnxGSNSMD2afWJYmOM5xVSgUDSlL/KNgwsJZ
         4//Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773586704; x=1774191504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zt9O9F4MckQFkyMpiwV8gz1R1wfXWraqpMa+gKy50Y=;
        b=BF8IPf7roCrqEdrjJszdSUDnhn8TKfL63Zbgbi6fhgIzdWI9ihkcfFNmUqLfdQLCh9
         zW0jcZ+UpwfxWczkpQ8o7F9GjOiUxHqScCz+qsaAweb6/+SUniUvmBjtGU91OKWzWqJH
         oIsjmU4zTJbwgPMk2VTv+PCwZ8xDVfwXZ/4aeUB5GfLWgJGNrvSKuxa/FnuX+mbzQmGu
         MoFg/n4HWMw3D+yRBZxMnfEjA+jCxWd4jXu6b4LeaZEWblV2iz+dJSF3ooLGfeo8fwNj
         PV2dBkatoUUpAzQkvH6bc5HecPpfhPTAwufLL+POyOjWjRmLA5cl+E9lOghO60aMNqN0
         1bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773586704; x=1774191504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Zt9O9F4MckQFkyMpiwV8gz1R1wfXWraqpMa+gKy50Y=;
        b=rqSz5n7ptJpYIY3vfhgjUW/YR+C+0Oygq2QDyc+qD7NloA+bhC34lMrbe6utl6zMbe
         1ySJNgXE3zcAkII04VDctz8TTBLMNQXU/ums/zsaJQsHaQaJFzeUvsHRhtWv29XPWLMW
         wwRY9MUmqekYSndA8zdD2RZm5TZqh71WflREyuAqpM3dMRiBw/tW9YjZAIuKu9A/KOWz
         nvUkFpiZciOxvgCFP9RMhKbrg4tPpSUMK3wBM1JjNOoGXa8RPTbUjQ+jpaZ95xQ22jwN
         sLfeOwDDd8UAmGwlLYBjt641dIKTWJV5OSipHm9LTalzqXvUSuG+oqqbi6d3Oq5J7PA1
         Gp8g==
X-Gm-Message-State: AOJu0YxNLwzmqIIUzt7rhrkSxPT/kA7D+RDfP+CV7MKdjAgooV0iRdc5
	68MuwxUMRsFY3ItNMiA4OmBgcFr+n5tJjbr1bfxcHFzY7O8xYiAB2BjCfprZKivAAHEgoRX84fo
	kVtKixGSOKYZ8rEGh7DnCT/p7jUuQYaGwGTL7XbE9LA==
X-Gm-Gg: ATEYQzx9FnziL6r0FUWGUJW7x+Ml2dL2+K8NqGYNe5rBVEITpJMtze4FLeX76abRZee
	Uwuhw0nya0f0MVOfSwhYp/77n9qzt+X+DCXHVgMGDdz+3M+69ADar2HeEaEqD52MFt8TAUkNBeU
	k0gpU01PbV2WH56JmRf7aGWepSda+OTov7IilAa0SoEKY2tKUyhUNh0tyogpvrC6ei91RTeAz+z
	2h2AGapc7jvkCSk9r4s78WpJ/F02IQJAqN/CCMA2FM2W2hAqK/W4M3lWGSIRSadZAjA457Zphqg
	Un1YMH0u
X-Received: by 2002:a05:6102:3749:b0:5fe:626a:a51b with SMTP id
 ada2fe7eead31-6020e27c2c6mr3485193137.14.1773586704419; Sun, 15 Mar 2026
 07:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315143921.23136-1-sashal@kernel.org>
In-Reply-To: <20260315143921.23136-1-sashal@kernel.org>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Sun, 15 Mar 2026 22:58:00 +0800
X-Gm-Features: AaiRm51xfTRBuYxxGzmaYnCBdHX4vJZbjnkGMvc7qxiy4KVsSzFWtIB4w4UjVno
Message-ID: <CAH2e8h691mMOC=3FgmvT4QnwynYb8JQ6VM+x17m4xuUHNbOtkQ@mail.gmail.com>
Subject: Re: Patch "drm/msm/dsi: fix hdisplay calculation when programming dsi
 registers" has been added to the 6.19-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225474-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mitltlatltl@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 994C52911A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 15, 2026 at 10:39=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> This is a note to let you know that I've just added the patch titled
>
>     drm/msm/dsi: fix hdisplay calculation when programming dsi registers
>
> to the 6.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      drm-msm-dsi-fix-hdisplay-calculation-when-programmin.patch
> and it can be found in the queue-6.19 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>

Please drop it for all stable trees, this patch has an impact on CMD
panels. Fixes have been submitted, but not merged yet.

Best wishes,
Pengyu
>
> commit 5c8236c2f2cd9998509b0b2bb7cff4c7098dcaf6
> Author: Pengyu Luo <mitltlatltl@gmail.com>
> Date:   Sat Feb 14 18:51:28 2026 +0800
>
>     drm/msm/dsi: fix hdisplay calculation when programming dsi registers
>
>     [ Upstream commit ac47870fd795549f03d57e0879fc730c79119f4b ]
>
>     Recently, the hdisplay calculation is working for 3:1 compressed rati=
o
>     only. If we have a video panel with DSC BPP =3D 8, and BPC =3D 10, we=
 still
>     use the default bits_per_pclk =3D 24, then we get the wrong hdisplay.=
 We
>     can draw the conclusion by cross-comparing the calculation with the
>     calculation in dsi_adjust_pclk_for_compression().
>
>     Since CMD mode does not use this, we can remove
>     !(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) safely.
>
>     Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
>     Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
>     Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>     Patchwork: https://patchwork.freedesktop.org/patch/704822/
>     Link: https://lore.kernel.org/r/20260214105145.105308-1-mitltlatltl@g=
mail.com
>     Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
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

