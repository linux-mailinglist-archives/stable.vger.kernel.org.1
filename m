Return-Path: <stable+bounces-206194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF962CFF23D
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 18:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2462C30012F0
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEBB3A7F63;
	Wed,  7 Jan 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GAxvwSy9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF63A784F
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807441; cv=none; b=WJv2vi7Wn0vDJR5KCe6zxmlbuZFkQVNflV9dCAEfGmZVmLGSyZzdx8VqLqGm91/7J1hnJFNIX25ad7hdYEFC3a/Wualbl4GqujCygGaHGooMRtbu85USthKz9jZwVg/deyPu3v14cGom2fyhdWOjgEPRopXMo7r9xSedvjfuMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807441; c=relaxed/simple;
	bh=lsu9ozbyzJ7icRjqAIJkI5NpAYD/owkwH+GkJfa0T+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r07g6KQ5Y32VKirxtWMBQ/cE1geCKWOtzt7wKIDA5o+DcrYfxb21lnR51PB9tOu5xTkEvwvYsHWfX6xRiXMiFp75vZiqftLUWDiApVFGt2/NyrfDtvNVElEsopJEuemi0QiBL0wyeJlkW58+Da257Tpn4aawSVCzfgPszI8BZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GAxvwSy9; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a2ea96930cso19218235ad.2
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 09:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807437; x=1768412237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkQ3+vx0zsnpPRWkNu8u2/zK3I8xPe5YlD6+gGamTW0=;
        b=ZmJR/1ZrjQ9uoJjgDWUBONeXrcgVNgkzrrPeJ+nMEpoXeassE+uNF0pBAsIG8TGg2v
         Ip6DFtwrQEgddvHtpWheR3rLmjeMukEY+mm5Z8wi6/ZXyOJizlQpjhzS5sWjjYSMKIec
         2pBVKloZfPhKcm9mZfehux3rt23rnpuvIw//72qECwwvJT1qBRJHpnR4QPVdPLvj0Ovz
         PWBd82TfKEXpKJ5S3Qitvxgj4R+5gu5cX4APR1OiQMR+V3yTCYNS7MjpzwlwQCpmdd9D
         25XbLSARfN/vKGbPfrSk0WTofSMcYTuubEa1ZDmmS1R2+85IS5+OwUjDvY7UTP1IgFH9
         O52w==
X-Forwarded-Encrypted: i=1; AJvYcCUxTG39597BFh8cUCz0C+co39gSoTikMeEobKCDWCCSBomw/xI1Eq7pdsnguXDDc9sROx7oFgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXnuUmPYbxqn19taarDD0tZIbpbNpx2t7RAnJlrKBiFPf4J/J
	W9DzPNPKGfU5wFoLF/JNVxME1ptRHIHTW9jKn04FyZv6zmicYDE25O1pJLKh+2R5Ik5jX9lwMA0
	KgKENvd2Fv26qxt3isFvtuBUXCbalfMg5dY9wjwZAqQf35CZfsknKTOljkWflftXV0oc9InDkp3
	Bi1Uf9ZBl7iU4sc8CgdHsL3ZVxiguw01qKOntJBL1y0GwdyjesLgSWi4xUnlEtNFavgreC88XYt
	AdH21/O
X-Gm-Gg: AY/fxX5LgR2wUTV3+kL58vf9pyzkqHgRv7Qe86pJ/kthC6Mk1Vis/VI7KtKYXniaGgg
	SD5Pi59IvNvxwWD8WTQxoZVVvaGf5H1cm3yb6GPEYf6W5g2MbxUFT2QKz9Yp4bL4ORDABkOHh6N
	SgDzwUsYS5n2B+gZuy/xpw9oO31sim9sNDi9EkhILFMKDGL/wAXTdqHVpJamteDqzCea3h2ifsM
	IykBT16tNHftTryY2xovID5hsdHK7WcgtqzMTL7EMjDg8g6EQxo8aiBq/gfg+R7kPWGH08rrGCc
	HEjBXb7iNLwNqQL2dkrX5fv103WlvAg8uYgvtgcXSIUG8jsFmCD9QsTAM2V1worPmajWcuO8J0x
	Rg6cP9guLQeH9vshcdgBJp1u3Gn7z/DCIkFie6MsXaQaN3p2qGJJbGGIwlgIR42UVbWVl0Uh/LW
	xf0bTNc7O5YJ7zKxvgMWFczVjUVRFlgv/dTBLVaWA=
X-Google-Smtp-Source: AGHT+IGgMQoTW9TyI8tHQhIHekd0EeYxhgnZcSJoaCPyKSJtuUxZ1X/f5HxBn0jNc1mno7Vu6D6TG+0t4hVU
X-Received: by 2002:a17:902:ef46:b0:295:5b68:9967 with SMTP id d9443c01a7336-2a3ee4fffefmr30104465ad.49.1767807437304;
        Wed, 07 Jan 2026 09:37:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cae6d6sm6210815ad.31.2026.01.07.09.37.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jan 2026 09:37:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-595892a3910so1933268e87.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 09:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767807435; x=1768412235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XkQ3+vx0zsnpPRWkNu8u2/zK3I8xPe5YlD6+gGamTW0=;
        b=GAxvwSy9b0gQ1NQW6/GmKvbZwvSCvTVLMh8ZmFDYEl2bMbX4k7/ECUv3eqihItFA6A
         CBUydIG8lr9Cr1+UT9bqoUrpYrQHcbxCFDeKTLZPz1L5y4g3WaRMyUTPM4YngilniYWY
         nn1BkD7IP+4fUXGkAo7WW5FJ3nlMfwvkmjW1Y=
X-Forwarded-Encrypted: i=1; AJvYcCUXl+NNO4KFQbzNKy4sldPrZ+fNwPKLtnetep3ds1wHm11gxcuI+xogWi+DNLuAfUd1Wu5eiBM=@vger.kernel.org
X-Received: by 2002:a05:6512:3da7:b0:594:253c:209f with SMTP id 2adb3069b0e04-59b6f03520dmr1211913e87.39.1767807435096;
        Wed, 07 Jan 2026 09:37:15 -0800 (PST)
X-Received: by 2002:a05:6512:3da7:b0:594:253c:209f with SMTP id
 2adb3069b0e04-59b6f03520dmr1211901e87.39.1767807434659; Wed, 07 Jan 2026
 09:37:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224091105.1569464-1-lihaoxiang@isrc.iscas.ac.cn>
In-Reply-To: <20251224091105.1569464-1-lihaoxiang@isrc.iscas.ac.cn>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 7 Jan 2026 12:37:01 -0500
X-Gm-Features: AQt7F2p2pQ4EPAFR_MwDOyXxaN8jANK3L3neBoRP_4r6aGLu7KL4l-4tmAZz2tE
Message-ID: <CABQX2QNDpNXuF6YhWjtWdcDriFR8B49sr22Yr+GKO-V6oCFqqg@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix an error return check in vmw_compat_shader_add()
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	jakob@vmware.com, thellstrom@vmware.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000039e20e0647cfbe45"

--00000000000039e20e0647cfbe45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 4:11=E2=80=AFAM Haoxiang Li <lihaoxiang@isrc.iscas.=
ac.cn> wrote:
>
> In vmw_compat_shader_add(), the return value check of vmw_shader_alloc()
> is not proper. Modify the check for the return pointer 'res'.
>
> Found by code review and compiled on ubuntu 20.04.
>
> Fixes: 18e4a4669c50 ("drm/vmwgfx: Fix compat shader namespace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_shader.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmw=
gfx/vmwgfx_shader.c
> index 69dfe69ce0f8..7ed938710342 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
> @@ -923,8 +923,10 @@ int vmw_compat_shader_add(struct vmw_private *dev_pr=
iv,
>         ttm_bo_unreserve(&buf->tbo);
>
>         res =3D vmw_shader_alloc(dev_priv, buf, size, 0, shader_type);
> -       if (unlikely(ret !=3D 0))
> +       if (IS_ERR(res)) {
> +               ret =3D PTR_ERR(res);
>                 goto no_reserve;
> +       }
>
>         ret =3D vmw_cmdbuf_res_add(man, vmw_cmdbuf_res_shader,
>                                  vmw_shader_key(user_key, shader_type),
> --
> 2.25.1
>

Thanks, looks good. I pushed it to drm-misc-fixes.

z

--00000000000039e20e0647cfbe45
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMZs
iFMG75yxnYl+nWphOPDTdwfNQJpUGa1kbzEu6ta0MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDEwNzE3MzcxNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAJYxH+cYHe4NLV2YvRHjvav4SsXajx1IMVwOnAaJ
xeg1jqpsHibWkRaIx8FFVN77WB/BUBgBUnIMJ9m6LRYLCrzxvNw34zsy1PFwoE8jIBwGddQK8EbH
jBu+Jt/XaUaJxfn0v4IaDHeuYNif+RyIf5u0fqB3Rpw5ZrQ1MW31oIOj37Ylh+pynE0Ec9Nw0tfq
SVfcujw7CLic7OndvcEzrGn7gOOXt18Jmgyr3moAMbueI0nLumC6QZOJS66taTXk/BitOGW8Ie2m
GLWyJ3Aoa6aEEFv7JCRtto+NukIYQZReKyu097MiXA+VctDSaimaC7rGeBUKeUeMiPbatvYRhNE=
--00000000000039e20e0647cfbe45--

