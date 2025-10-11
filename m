Return-Path: <stable+bounces-184050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B174BCF027
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 07:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77F8F4E1698
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 05:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B91F63FF;
	Sat, 11 Oct 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3cKBFZ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13D1E0DFE
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760161250; cv=none; b=fI8XcK3Qu2VL7Mw2qKYEo7SpUyFTZhdwBz/+rOZRWOUck1uGviWZFSuo7HLLVFskioFAOJY771HM7YwXcl/QQ31xWsCubDltbsih1PniRfK1IRJ7Xp0pUUmljSBDCsfPoyuONCn1W0WEjt5kj/w64XFORN4wvXeDPS544vM6JTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760161250; c=relaxed/simple;
	bh=T/OaJx4B2ofWilBB1mLklxLkAldO5M4FQFGMkHFdTxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMQJFMhVW3ZfaE2hjy3P+OeP1iKw3KAAZj1Mf06PYLtmITBBUVcSry6tS0Tl8EO2yduvKXO9/anz0noQtMO73TikV+aFeJWiiy+NvwVFGxe31Zo+EQXTwJQpQJt6g8ULyzXWLkpSerVI9PlQjCIL8UG7IGKGQ15F3JtwQBnxliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3cKBFZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48D6C116C6
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 05:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760161249;
	bh=T/OaJx4B2ofWilBB1mLklxLkAldO5M4FQFGMkHFdTxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e3cKBFZ07hVB1BlmhR+xPWewcZDpmINGh8tqggNfG1FNoEo8QAN3Cv9yp4HZd+ctU
	 vkdwRoE7CCyetGjNzkZnIrRBFBOW4j/0RceYNKlxpsal9oasToji+kdIy20ch1ubzY
	 /6sT77S0NPA5IzVJIuJte81EKelproUOCIMk7iTTWnenVY8Rnc30iznY5ihTEqCmcz
	 vCbtTjBd9Xr+Z8y0f/s+5h4mzBzMc3uqxWUwVQBNMnbS6A4L4B50qKvH/nA+C4+sEI
	 xWwHXSgl+dArQzaZ9JKbw3XoEyzfG5m0sviZC7ajGj2idCp68zx7mDXXdpHzXHoYa2
	 3dz9SryHzxy5g==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b4736e043f9so404182766b.0
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 22:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsQY0arCT0/qTO+bIS6rsqSyjPeStmQH5lb+YU5RkkslVeBxnvHbfRHb6hbZWD68tyDRt/vD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFoalZnDCNI2dFLrYmmJK4trfqYVevtoG1NsOEHFofM+cjMa/
	/aPlSlrhaq9osly5OSQrBlMZyGgpqR7tzfx+mqyNi9NXyLrM/C0fDjTe91dgE4RDBJ2Csb3mUj+
	lj74OlbZLoVfeaYDbYFR1CouUdw26py0=
X-Google-Smtp-Source: AGHT+IHGFXcBh1CoyxVP4/hzKESUFhziOwWatSeeN63Jf10cafnamrVulEc/CTbph30JLZDB0UYefY2NTdg+f+nHvRw=
X-Received: by 2002:a17:907:843:b0:b40:98b1:7457 with SMTP id
 a640c23a62f3a-b50ac5d0901mr1322157266b.47.1760161248247; Fri, 10 Oct 2025
 22:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010050329.796971-1-aha310510@gmail.com>
In-Reply-To: <20251010050329.796971-1-aha310510@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 11 Oct 2025 14:40:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_2VUniUHgstfATfdjDfLokqfjCGm+P=_72EPM2HEi0Ew@mail.gmail.com>
X-Gm-Features: AS18NWBP7_cWe4oXpv4egI6drs7CniIntrFvTm1Ghw2MALfSovJDtjjgW0l3WRY
Message-ID: <CAKYAXd_2VUniUHgstfATfdjDfLokqfjCGm+P=_72EPM2HEi0Ew@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
To: Jeongjun Park <aha310510@gmail.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, pali@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 2:04=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> In exfat_nls_to_ucs2(), if there is no NLS loss and the char-to-ucs2
> conversion is successfully completed, the variable "i" will have the same
> value as len.
>
> However, exfat_nls_to_ucs2() checks p_cstring[i] to determine whether nls
> is lost immediately after the while loop ends, so if len is FSLABEL_MAX,
> "i" will also be FSLABEL_MAX immediately after the while loop ends,
> resulting in an out-of-bounds read of 1 byte from the p_cstring stack
> memory.
>
> Therefore, to prevent this and properly determine whether nls has been
> lost, it should be modified to check if "i" and len are equal, rather tha=
n
> dereferencing p_cstring.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D98cc76a76de46b3714d4
> Fixes: 370e812b3ec1 ("exfat: add nls operations")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  fs/exfat/nls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> index 8243d94ceaf4..de06abe426d7 100644
> --- a/fs/exfat/nls.c
> +++ b/fs/exfat/nls.c
> @@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
>                 unilen++;
>         }
>
> -       if (p_cstring[i] !=3D '\0')
> +       if (i !=3D len)
>                 lossy |=3D NLS_NAME_OVERLEN;
As I said before, the core problem is passing an incorrect length in the io=
ctl
FS_IOC_SETFSLABEL call. While your change may fix the symptom,
it doesn't fix the root cause.
Furthermore, NLS_NAME_OVERLEN macro is unnecessary.
That will result in different errors when creating a file with trailing per=
iods
with utf8 and the other iocharset.
Please remove it and make the same error handling for maximum length
consistent with exfat_utf8_to_utf16().

>
>         *uniname =3D '\0';
> --

