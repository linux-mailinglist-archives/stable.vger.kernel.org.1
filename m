Return-Path: <stable+bounces-203231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12282CD6B18
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FB56301B2EB
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519012C3261;
	Mon, 22 Dec 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H33/DNw4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12B10E3
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766421705; cv=none; b=orVoHRrOekGQexhUlWtd9F7v+QfnGZzhBIvFl3UqUMHpZKaGyzsi/hZlRdrogHjZ9cSYwMEbbClwQiQC3qlwcUNHtDJFGDrOemkTJqLlvPCOYTPM+HGXMyeYnLyHXMJjT5fcajvZv+0CXcjU/xL55uc4P87ehxUJ411MHYCo31E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766421705; c=relaxed/simple;
	bh=DFkYsh+Jlc7dsNSNlOWrRIWk7zlJ8E6bukBQT+LlV58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFdEyDbNpqteLQGgFfVS+VO0caYBjaJlsPjoRRLegufNpHtkoetjeqG3KTYFbWTwGDtZPyC8yquRZMKnqbMBk6d/fReEkjkm/NItGTTVoWUdIaKuYSxIbDuwUC0irwltvPZZI6tc9CPWWHgKEBDs6VJ2wWzhiIzRYgaHgm+ZgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H33/DNw4; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so45064466d6.2
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 08:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766421702; x=1767026502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1MGVqr2f5q8tiRDB0qtUsR9YnZwkdpIkUEBS9ix8zc=;
        b=Ra4CNeIVDM7BHZIowW4paQGNA/9Kxf14Huli0/XIGgQVUageslBtZoR2hkSlTv/KDx
         /vYPsVQsu/WI942Gu2nXepttmZI3aYT+q4Sirzle/Wmg8mDdfPuL15jIgAjyEayFJfsI
         fKlACgF3k+4KNYmR0vp/HEqigjmovQyXayh7b1fG9q09N4tGEduI1jYBeMd+tLF2KOZ6
         XDMXHyJIdAEo3tYSJ5lO4Q9P1/nyeQuJJnM8HgrgDQukMZCoajstxDWfjuGOfI2pvFqy
         Ga8L8z7066vzkRiCb+4FbrzGBelPc+ImqXsK7v0e6I13c7kgEBleBYCOIiG1b1YCXttn
         mzXw==
X-Forwarded-Encrypted: i=1; AJvYcCUi1MiXUbNthGOWWPi3T5FwvAyxJGSSuRWziWvwYj/fAlrn5poRNMvJuDJziQioGUrEqRKMeqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3jBsgJB4w7G2nxeaIOiXQkp511mDevmTbckT19WnPxEjehlY
	gyRmAiaiVe9nTb7iwnsy4fKLcexw5ZG9HL45eKDoZrtpOFei025V98lgSp7HjqyD8ZB0jg5v/GS
	xXU/LMVhK81chySJiGY0IRpHCT+V1T2wrjWgd74ueCO2P8kq98KaOjIpzT2hQTZJ5OruDf++eGS
	1GC2oHg/2k+nfoSHLERzsazoGCSirhzqdOwKJY8+hUolvDO+oOGzwa9lfRqqqH9CZBlmDn/cOGv
	tpFgjeMRIOYySs=
X-Gm-Gg: AY/fxX41S+f06B9F5mwSeed4YbClIKkFX4FeVKK4pLYc+xu0r9Fe7FqAZ6/P7w6+uDl
	p1XLEMBGXoJA5SZEzi3mVYcKV4KiPv+I0oTAQgbM8Jj/J38azdYnvyHs8yKxlcBtsVKy3T4swo3
	kNoJOSs6Z/hPj+bIFbDd1yxbOy8uDpRdV8zDygtcJFyGAp3sPqXkjZS8LXDCe54DNlUvPDFJdz2
	/fXIcN3+/lBDVrJQHrUCVWQT+G6STvkEsxk9mBFK63medFfVqbsXEkX/8oEe8JiTl3a6IkgINNn
	WJoh5Dfwm8XeVAVLEkIhWbv6B/klngWFLTXAf6lGZtzv5zpokxaf7vxcog16FnYeGt1dr2wkj4W
	rvUVgQBKi32TTO951mlGoDj2bvsfgUHWumaU5LDwUdR+EGU9m430JR2p6cehk1+783z7gQP+kXR
	s6B4DelIQi9dqp0i9L0l+ZyaJDT4vdupwbzvIb9uQCdSU=
X-Google-Smtp-Source: AGHT+IHU5y+BhP6bLnIrRPty/hEjH7W5NThcaHo1a54bjwrfvW/kPBOERSfOLaNKx08hB57KyyE/VkgDeQVZ
X-Received: by 2002:a05:6214:5911:b0:81c:96cc:f7ec with SMTP id 6a1803df08f44-88d8203edf5mr182424726d6.12.1766421702180;
        Mon, 22 Dec 2025 08:41:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d980505aesm14683096d6.23.2025.12.22.08.41.42
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 08:41:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78e778d774cso37727317b3.2
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766421701; x=1767026501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1MGVqr2f5q8tiRDB0qtUsR9YnZwkdpIkUEBS9ix8zc=;
        b=H33/DNw42euHZcpsxbDdnQvO6YLz8RtNbJKUnQ9SRcn/I7tP7vVcKj6sa/z4BrULQX
         NjjHsqFE0mudUh5HWzYHp8F19Jqx+VY42MjP850LpLCBjfZpwkPYKcEHwZE48y4hIFAz
         lAiR+40UvLv4lpcZSJpntm7IN8O4naepw603c=
X-Forwarded-Encrypted: i=1; AJvYcCW2rpwvrSW4qQgqPVlGai0QgMeIPxBdmZVApOtXkvmecyqOvCUlb4Cmym1tbsYPNmy9inO86wU=@vger.kernel.org
X-Received: by 2002:a05:690c:7483:b0:78d:6b8f:bb40 with SMTP id 00721157ae682-78fb3f48f06mr83953497b3.30.1766421701381;
        Mon, 22 Dec 2025 08:41:41 -0800 (PST)
X-Received: by 2002:a05:690c:7483:b0:78d:6b8f:bb40 with SMTP id
 00721157ae682-78fb3f48f06mr83953357b3.30.1766421700996; Mon, 22 Dec 2025
 08:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219141157.59826-1-lgs201920130244@gmail.com>
In-Reply-To: <20251219141157.59826-1-lgs201920130244@gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Date: Mon, 22 Dec 2025 08:41:28 -0800
X-Gm-Features: AQt7F2oEmpZA_DiC7FZL4oCogE9cAwT_KXfk2qBQ9CUZSTWiiIWqCXHpaw-HSw0
Message-ID: <CA+Jzhd+FtvomRV39pKfqUB040D9L08XH4eY=WQF2ZzTsEbNepg@mail.gmail.com>
Subject: Re: [PATCH] misc: bcm-vk: validate entry_size before memcpy_fromio()
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Olof Johansson <olof@lixom.net>, Desmond Yan <desmond.yan@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000010550006468d1a8a"

--00000000000010550006468d1a8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:12=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> The driver trusts the 'num' and 'entry_size' fields read from BAR2 and
> uses them directly to compute the length for memcpy_fromio() without
> any bounds checking. If these fields get corrupted or otherwise contain
> invalid values, num * entry_size can exceed the size of
> proc_mon_info.entries and lead to a potential out-of-bounds write.
>
> Add validation for 'entry_size' by ensuring it is non-zero and that
> num * entry_size does not exceed the size of proc_mon_info.entries.
>
> Fixes: ff428d052b3b ("misc: bcm-vk: add get_card_info, peerlog_info, and =
proc_mon_info")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/misc/bcm-vk/bcm_vk_dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/misc/bcm-vk/bcm_vk_dev.c b/drivers/misc/bcm-vk/bcm_v=
k_dev.c
> index a16b99bdaa13..a4a74c10f02b 100644
> --- a/drivers/misc/bcm-vk/bcm_vk_dev.c
> +++ b/drivers/misc/bcm-vk/bcm_vk_dev.c
> @@ -439,6 +439,7 @@ static void bcm_vk_get_proc_mon_info(struct bcm_vk *v=
k)
>         struct device *dev =3D &vk->pdev->dev;
>         struct bcm_vk_proc_mon_info *mon =3D &vk->proc_mon_info;
>         u32 num, entry_size, offset, buf_size;
> +       size_t max_bytes;
>         u8 *dst;
>
>         /* calculate offset which is based on peerlog offset */
> @@ -458,6 +459,9 @@ static void bcm_vk_get_proc_mon_info(struct bcm_vk *v=
k)
>                         num, BCM_VK_PROC_MON_MAX);
>                 return;
>         }
> +       if (!entry_size || (size_t)num > max_bytes / entry_size) {
> +               return;
> +       }
>         mon->num =3D num;
>         mon->entry_size =3D entry_size;
>
> --
> 2.43.0
>

--00000000000010550006468d1a8a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
RgzD22UbOw0Zc0KK6oEqIJEAlIrv24IqbfpBvv9ihHsCuxWYJ8CSpLe8QjayPrn+axqd+5Dszeq1
e2Bj1RteOLHZmVZON3GXCP9UEW81tcGPWzRrQecRrMsteaNZrrEEYkJfZzt11fWe2Asq+jIqsL1/
Cy2haJfVcTI8xOl3Rvo2awEudgucwkNJMqNaHA6x7foZr+nopW8H/mbCFMWeuZTvpHy/ckGL/T2j
Yh5xQM8hlq62Mp//bt7EVK5o0HRVhZ54EY4QK/n/ovMCAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2NvdHQuYnJhbmRlbkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJEzKwZUjRbcpvkjk7tk
h02Vb3haMA0GCSqGSIb3DQEBCwUAA4ICAQAIie4RmMGexhzDlGHzd9NieUPgI1AMnB0ZdRUFkXcm
5UxItAUgYBpEZKCf3/ofAzfzjhiOtwT+tB85U0kNZrkctXOYsGbpbev5HAT7nYtTMN74WQRUcDCB
hIOOBywH9JHH9/nV1v+oOVDFaIg1foYRzas77gQ2CFLVrTkSqyDD/844LAREi/HfYyo5g4m72Rae
tEGh5DNGimduSBgpLlL215XmqpcD7o0lcif4Mpk79yQ+wx/dik8bnY3a4bJTU4Qak90xo98l42l3
iVVzHIvycGGS+WtXlCkenQ3QWMlrM5s4htoRatVpbmFCZI/i5nnKx9UDTasTeCi4/VJdB81tP8X6
6cNYFYoD9K7nA5NMOyW6Ytyqus/7x4fJ9dpLClUxu6CLpsNgvEKgdbn4PhXqpfyS9co/8xrZhWWw
KFClxU8qJ/EFYtnkCsWRIIaoYoZ83zacdRmydf7u/4IpGVNSTBhfNY1EKPvWhhsT8FvyTHiCGQAd
LpQZhJAuAmPv4bY4r3dijWYK4OI0jygHmS1rqjVo0oOtO17ILX7MdKYUlzg/qxoU+VChpC9/BTCF
5eORxrQ/1u2guYvZ+6W5C93W9vbI9YxmbPgaHsN66ShGZ3RxMSalF1omvREH+hW760MPcbt4tuYw
wW2Dt9mzgwY8jt8iUXWlCdh4R+V/at4kLzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDEPyf5H382Xt9YLzOzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
CfO/wd66jqp/dr1rENIKFB16rzYo4zpbbPqFMPyG3wowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjUxMjIyMTY0MTQxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAL8BwE3/VScPWomMae/TSzTyF6P0DexJ+UXV/
qg3firi1oyiVLFFnbnl8tJ8hOGnNbEvJ3PlVmYhPiNxwZfgA1zLW2g0RsX528E23axfkKVtZTVQv
2cBdlJQtiQHG+qk5x0gJ3ZhHh8yinGVIMqsnzSDtvsY2jzgNxAMBxyeC/b8jSw6RBbbepRcI/iia
7RnVXJQK6Uxv/nAAkAwziFh9sjL7Hdjcz+Tn7gsU/ghiXIFGq5P0yZkPTCiPhKptV4eYHw6MkJKY
+oBtbyVgJpXdhuIa4hUmupgYG34oQQPU/svSNPqV5oYG+6pNHYCHj2/06VihWo848ygQTjXSvGQ0
qw==
--00000000000010550006468d1a8a--

