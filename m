Return-Path: <stable+bounces-244285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yoXoK3WD+mn8PQMAu9opvQ
	(envelope-from <stable+bounces-244285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 01:55:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6C4D4D09
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 01:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF483048F0F
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6DF3382E1;
	Tue,  5 May 2026 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dC47WXe7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1B3264C2
	for <stable@vger.kernel.org>; Tue,  5 May 2026 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025328; cv=pass; b=f43AwFMqBDfrz+pTvAiVHm6h0HCn16FxFOwz/KFaZyKfI2d8W2t+yEaShaTqT6+Gn0FOnDkVCx3hYuXZQ6Dfye3v6at83AX/2oB/cb8/Uwn3/CTdtDCxxsr+FkmTRrbkY0QI+zkFar+e2NrpOaxW0H/LP1vCHBfH6inGmo60eug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025328; c=relaxed/simple;
	bh=p9RTItwZyHq1mhEJKcU/RYptdB4ZGVQwb0UzSfyhVEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnQ5cDOQO3kSRMyfUEamUlC5mOKJ9ZDRGlM0O1P6b9YIaOmtsu7RxxtLBmv37xNtBYMGfCOAaE/ui2q1zjQ/4K2O8Ed3KOKUBV0LDEUJli2zmvf1xA5Wzi1dvRzt5oufVdqwwmcVV1EeyMWQsiWflvEh+EQFcIZeNy42gwH/pPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dC47WXe7; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e61648f10so181721cf.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 16:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778025326; cv=none;
        d=google.com; s=arc-20240605;
        b=cMVh72otXy1ADwsB9br9f4sWvgub+v7t7EhA1D/qCkm8wzLGGZ3l/bF0vBMu0i+GEp
         Qzkj3ChM1B1cvmxlW7XwflC26A0IqJeGx2FoD6MOtUdpGyrRSawq8Dd6PxnqAIyEw0Vq
         AXeLPDMLpPBEhD3ZHmvQLkqpd6O0X/kmq7KKFOTy/XNoGn2TISfZa7sLFwOOacRDczCA
         +5pIMs4AnUxFAcsFrjQ7A+iSzmvV+rhwkKAfC+kxVaRE5RzRAlwb0FPQp3VidV7ABMGm
         ZB/FFVz2K1GYtSY/SO63WSSvezDszZIvq6GDP8BbahqzSvVwPsVaNfHhue4nBJeNn8iV
         vlug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wuhyBcGWDRHeBIJeFOOXO2Zi58tk0CDv7lN3uv+zGa4=;
        fh=58ht2JmeNyA9dejg0wNVrbiEcZjBZtlzISi/0XCRD0A=;
        b=G5HxTDsq+MvjuJg/toIfO61/rFqirAQddxMgtT2HX0rfmfv4S6PGFlN8MFakhBjfJo
         xd5M/3+k7KZgN+s0ZyR8ERgP0+KjwGgoUsHGTsKxh+PclNmladhAkHj9ZO4FB3PxArAP
         x9MBdExfoV/Y3ZXNDsHu63lIYN14ii1itUxnsozN/cWj3WKGs7JJOSqelDSI/FB+/jE5
         pnWbpDL7TnRICoPZXK99nT2p0fGX95PGnlZ8srTs2yx92C7mc7bn9aIws58oQknA3Eu5
         OAVjuPrKYGGh/vcvuAJWojduwO+7lPSCsOBxfrI16p4M5jS6lCVTH92T0TMyDzePOeQs
         xmHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778025326; x=1778630126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuhyBcGWDRHeBIJeFOOXO2Zi58tk0CDv7lN3uv+zGa4=;
        b=dC47WXe7sfFq8pexxxVCDK45MNdKCom35/2Wd2pw5owa6zfxAet/zor+NoLzDOtfKl
         lT0Cd5+5Wfgy3NBsx+fuEoxDM9kaiUEymGuXFnjfPxBfXhHoIFdH7r5gRCJo4Me4pwU1
         q0PvvVX/nSnqhZHdpybP9pSNaaCO1Ww4u/rlTBaP7TH1Pz0VuyBmUeiIlzlNlicZdNbL
         R+DWclYHE5hXHQAWDex1VHP3/xRCC+19o44G4LvIs9qyYx6I3VSgMzEZ59U4nl0JpAdS
         xVgUF10OIFv4iz/92aod9b1AAcsioZeZNqcXCpIoCfiZSzlSFrRx9g53+2fNqlg1F/c0
         aq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778025326; x=1778630126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wuhyBcGWDRHeBIJeFOOXO2Zi58tk0CDv7lN3uv+zGa4=;
        b=D3wyM3mW7RpCbSJ1Th5L0YGJy0XlYo2JokCaU6Hpj3+iCydS/d8eN3/N97NThrHdAJ
         DIorweePiKygDGMt1nP6P7bmjX1CNFdHkCMAiG2zUPYPVwJ9Js/6DQvcrUqHt4GVpcmh
         iALddGV4l9g7phC5MO64xWoKBTdKbfr1M1w+n3ofqEOcE9nKuK/wK0h/s7YrAirukvZm
         BO1cCzPtCS9z6CVfYgAA6DmDIbTaSEcUBwMNCrwoDTjtyGBdW9zj6Eh4aIh4ZYkXeMBG
         +kThK4+zc3JwEnLJdyyEHwBJr8HT5QXCkerC/SmoXRpPJJU0crrgD6y5JJ+r4r5iTJWb
         S61w==
X-Forwarded-Encrypted: i=1; AFNElJ/yPJdl31GkMOGj2mDNiMLuwWem+uhS0QcC4qx8dic3FS1SB60MrfmwbbIfobiRGy+ecKByfH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvTjMigri0vqkfcwdMgeus1MVpzuFNwmsSAwPlArhqPYpkwc/
	mmKi3JIPd37JI2L0BX6t01e0qw3oUe3u+ZhR1q7jgySs7OnzGxVJ7Yfhka7KYgvnlS/gGcgmL/r
	xmPJ1EcNElUJ5q+mpHyzxJttC1YGT1o3mm3fIUvqV
X-Gm-Gg: AeBDiese/MrNzEbbjgYGP2kO4KizWJPk36pZIZ9GMvKBgOYxkpDomK+OA0KeU5Yma5A
	4llOZayOe4D/hgCeREsJdov73dAckhne5y6R3g+pNOv6IHNputZcfCv3y9LMmh8u6o5XHjxMxPj
	RmZi9aRZXUGJu8So6JQUZ/7TkdriR6ztZ2FP4I0uNaDne+gzjj3Yb4viCXJ9ufj1GH7rjyv8OUv
	x6U+W0Q4Ij/LygN1UQoHER0IxJK6gwJP4dn9GEvyzhEMHUrOupskkWlIoojTY8fkjtm0oRYEp0n
	XyW/ovwxtQSX7GeuMtdVrhXxWvrF8FVxXxmaRvX7MiEB84R+uspeDVJrGwA8j8BZBFl6JTTzAB1
	uP3GFPjQv8mysdP1GGtoG5q7I6HTaJc/Gz44ELOtIPZw2N7X5kYvB
X-Received: by 2002:a05:622a:5886:b0:50e:6360:96e with SMTP id
 d75a77b69052e-5145fc87da2mr6668431cf.0.1778025325921; Tue, 05 May 2026
 16:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505133922.797635-1-pratyush@kernel.org>
In-Reply-To: <20260505133922.797635-1-pratyush@kernel.org>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 5 May 2026 16:54:49 -0700
X-Gm-Features: AVHnY4JEDWD2VQhA_AgqzBkBpPQ2cvl10s0XbqhfOlUAb7igg2Kifeo9-olJJYY
Message-ID: <CALmYWFvb1aN4-+e6wWEDrv509ELdTwC1tOzPmbCagoZYuBC=Xg@mail.gmail.com>
Subject: Re: [PATCH] memfd: deny writeable mappings when implying SEAL_WRITE
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Brendan Jackman <jackmanb@google.com>, Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 18E6C4D4D09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244285-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffxu@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Pratyush,

Thank you for fixing this.

On Tue, May 5, 2026 at 6:39=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> When SEAL_EXEC is added, SEAL_WRITE is implied to make W^X. But the
> implied seal is set after the check that makes sure the memfd can not
> have any writable mappings. This means one can use SEAL_EXEC to apply
> SEAL_WRITE while having writeable mappings.
>
> This breaks the contract that SEAL_WRITE provides and can be used by an
> attacker to pass a memfd that appears to be write sealed but can still
> be modified arbitrarily.
>
> Fix this by adding the implied seals before the call for
> mapping_deny_writable() is done.
>
> Fixes: c4f75bc8bd6b ("mm/memfd: add write seals when apply SEAL_EXEC to e=
xecutable memfd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Acked-by: Jeff Xu <jeffxu@google.com>

-Jeff

> ---
>  mm/memfd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memfd.c b/mm/memfd.c
> index fb425f4e315f..abe13b291ddc 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -283,6 +283,12 @@ int memfd_add_seals(struct file *file, unsigned int =
seals)
>                 goto unlock;
>         }
>
> +       /*
> +        * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
> +        */
> +       if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> +               seals |=3D F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_=
FUTURE_WRITE;
> +
>         if ((seals & F_SEAL_WRITE) && !(*file_seals & F_SEAL_WRITE)) {
>                 error =3D mapping_deny_writable(file->f_mapping);
>                 if (error)
> @@ -295,12 +301,6 @@ int memfd_add_seals(struct file *file, unsigned int =
seals)
>                 }
>         }
>
> -       /*
> -        * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
> -        */
> -       if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> -               seals |=3D F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_=
FUTURE_WRITE;
> -
>         *file_seals |=3D seals;
>         error =3D 0;
>
> --
> 2.54.0.545.g6539524ca2-goog
>

