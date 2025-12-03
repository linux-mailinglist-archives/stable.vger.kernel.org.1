Return-Path: <stable+bounces-198207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB12C9EE6E
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A92244E16B5
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA72F39DA;
	Wed,  3 Dec 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UXS8zNMy"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D9D2F1FDC
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762801; cv=none; b=uBEqjKchlK0wYGv9X66epqet58rmYNF2XEi3Kb+lWSxhWFKrivtCPJTBIsxB4+gAV5DhIa5rJsZQd2Mf0rdAGc7kcen/gRxc5W7fSCitNSRMYHnJ9Xdb+mMgeEZOds8jdmL0i0Hf69A+Cma+0um2cZ4xO4JWvl6cxQUBwBRjtY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762801; c=relaxed/simple;
	bh=WZOdGWfH4LKXJ5cVXzx/uyaiecWwye3ybYtoF6oqlow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGNcqyYxvM1BsUWrLFjP/aaOgj3dP6xYbehwaThxV1nWWeFoyLfkA5kBM/jwKo4Nxiuj7ptKzJcPy0aoSVvHzzZSG/7+5ZtBzw9F2Jl+9UWp22y0Eysuz7PDOhu7ME2SgrxjBWj2n75OvdB+NBe3PyTfYXpaB27Najvn8XWpyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UXS8zNMy; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-786635a8ce4so48705737b3.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762799; x=1765367599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmL2MkkhVxnGzWV860YapQsJUkXB6mj75lU56+/nhI8=;
        b=XOJSIPH7XaB6+br9AREur2xd7X/WSaiwqj6L3qRiTp08UjeV0qklCjV4Vk9C5Uac8v
         JFvXI7hXaila+eAoeDxRhnn2hm9Oy6r0MWuUi0qVI//hadeVxA0Tdga/zbNCvmVv8A2D
         qpR4iYoYHdyJz3CfB1TAQIrWyz3VnFRReVQMY+HZCCCR/1WwtDRpv2ouDW+xEVo5Q3xs
         Aj7eaq2yihuQZ21wVz3Yv7tN/cmkB6K+w2gRLeskF2b91V53gVL65bdkRGoEO/sxvUm+
         VEKliTSmviRN04aZeTcchb4Q77Kh2Qv0Pb/2dTpCTUg9xpBNd/vqk+GIOMkoGxMqb6Ef
         7pFA==
X-Gm-Message-State: AOJu0YwvZ4gWHUBBxMRjmznc9R8OV/G49KRO9bVsWAlQbUWwpp/OD5U3
	glnSGqfdchy2EPPK+RTTloiFTnjp/XkZEmk2nlhKOyp2dSm0uXVIBPbopT8SnwF+KuLPKzUJ+Se
	CJRWmYnoFlL3BjuNblWI2fzc9v0icNl1H9iA7DqUu/j/9fxxGGOEi9qO5hiwvtpmxIzdf9aLHLP
	/Xx1inqkccVZoZId+kkwOexA/1cfzEeNQU8wbBFAqElDpOCVlZ8fUI+ltydGwqFddgKHnjLultl
	N9pDm2bQn8=
X-Gm-Gg: ASbGnctntZrPYCqdZHnG7N59b0FIz1452ae08jYKHn1la+7Vmdr2LQp+qhn4BdkQE88
	SZpqnEKMbppl1gq4lKN6JVbYQu6NqSWzHzU+HFvyZGUBhTmQk5vsPlb5UAyGrZitywFxFpAqWw7
	rGe4poJv7BDU3TYOwBOyv7jJDQdUmaSKWXsjuzj3Q1CRQlzMhf+6SkRbikQF66VSs7PbP2vODZa
	ErD5emiw9Io2qWm+feQFQ8mB8GIcY7X2jjKp6Lljzbp0dq4CIV2FVTm5lVQRiuA5/eAJOdueFb1
	+Y+bhD0GDkppxHEMQU8qhZp+7UM9MqfmU0fvrwfVLoDruGcGyQzAWkpcq2tOK+uwjfCKcSuBH7T
	zHml79CTZXbhFn7w831ayG7dmcKdLbrafFJdYW0ObG2EUAQNKT0CpRe0GpddSqd55S5VilXqA7m
	RiFWoTt1+G4VShRVEBm6Nbok78wwRpMIStQg+/tS0yZA==
X-Google-Smtp-Source: AGHT+IGwPClVOxmltFC/l1FWscj40M4l/49SMYNufRec9SHjtcc7c2tBreoK2iHexK/Ycngxe4OAbvvxKF36
X-Received: by 2002:a05:690c:25c4:b0:781:4b2d:7261 with SMTP id 00721157ae682-78c0c053ca3mr14413907b3.41.1764762798615;
        Wed, 03 Dec 2025 03:53:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78ad1043fb1sm15295067b3.19.2025.12.03.03.53.18
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:53:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-55b26ece522so3275440e0c.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762798; x=1765367598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lmL2MkkhVxnGzWV860YapQsJUkXB6mj75lU56+/nhI8=;
        b=UXS8zNMyjbkum59iATygtgdrVD9sByWioEwiLVtqzkdN5Lt7QuaZmxB0i3MwbLX4f9
         C9JmK7Q38We+KNaf1Ee5U77blR3wipVcRaXrclEgbX5IACd7IlQqhwDxCyIxSq2JrFyk
         ejO5xfVKIUDPRksHKdRMpbe1+v4ulwt/K7pjc=
X-Received: by 2002:a05:6122:3407:b0:559:6960:bdf9 with SMTP id 71dfb90a1353d-55e5bfaa8e0mr452477e0c.16.1764762797854;
        Wed, 03 Dec 2025 03:53:17 -0800 (PST)
X-Received: by 2002:a05:6122:3407:b0:559:6960:bdf9 with SMTP id
 71dfb90a1353d-55e5bfaa8e0mr452465e0c.16.1764762797507; Wed, 03 Dec 2025
 03:53:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
In-Reply-To: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Wed, 3 Dec 2025 17:23:05 +0530
X-Gm-Features: AWmQ_bkg0tWD3dbEBTxJFNjBXSdcAG6ij_sONJXahdDf8Ku3zPPtI6NftDkcsKI
Message-ID: <CAD2QZ9bGLRL5NyUak-=dDPyTkmrzu-22Q2tURfxUmM9Rs+c72Q@mail.gmail.com>
Subject: Re: [PATCH v6.12 0/4] sched: The newidle balance regression
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com, 
	yin.ding@broadcom.com, tapas.kundu@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b3538806450adb3d"

--000000000000b3538806450adb3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg, following upstream patches will directly apply to v6.17, so I am
not sending for v6.17:

https://github.com/torvalds/linux/commit/d206fbad9328ddb68ebabd7cf7413392ac=
d38081.patch
https://github.com/torvalds/linux/commit/e78e70dbf603c1425f15f32b455ca148c9=
32f6c1.patch
https://github.com/torvalds/linux/commit/08d473dd8718e4a4d698b1113a14a40ad6=
4a909b.patch
https://github.com/torvalds/linux/commit/33cf66d88306663d16e4759e9d24766b0a=
aa2e17.patch

-Ajay

On Wed, Dec 3, 2025 at 5:08=E2=80=AFPM Ajay Kaher <ajay.kaher@broadcom.com>=
 wrote:
>
> This series is to backport following patches for v6.12:
> link: https://lore.kernel.org/lkml/20251107160645.929564468@infradead.org=
/
>
> Peter Zijlstra (3):
>   sched/fair: Revert max_newidle_lb_cost bump
>   sched/fair: Small cleanup to sched_balance_newidle()
>   sched/fair: Small cleanup to update_newidle_cost()
>   sched/fair: Proportional newidle balance
>
>  include/linux/sched/topology.h |  3 ++
>  kernel/sched/core.c            |  3 ++
>  kernel/sched/fair.c            | 74 +++++++++++++++++++++++-----------
>  kernel/sched/features.h        |  5 +++
>  kernel/sched/sched.h           |  7 ++++
>  kernel/sched/topology.c        |  6 +++
>  6 files changed, 75 insertions(+), 23 deletions(-)
>
> --
> 2.40.4
>

--000000000000b3538806450adb3d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fEfjRz/Z5b6J+pnCj2dzb2Wir3qx4rt1/aShjQasncmTZ0r8rOk2G3RmKolDmTmWPMeCgzL2KeQs
QRXTsKFFi0np4iUyWo+MDCofsswor1HkoXwlmoIAdrFL+cw3qvOowpOB0pe3+G1rWNvJvYsOAzG6
2a8X0kwMSTEGjJgAX+jQjqwdP8C4ZxmE7n236E9GiM8kfhFFAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF2FqYXkua2FoZXJAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQkdXtSp1Dzqn1C33ctprG/
nnkbNDANBgkqhkiG9w0BAQsFAAOCAgEAQbg6h5rEci8mKF65wFYkl7cvu+zaAia4d24Ef/05x2/P
WAuBmkkDNwevol3iJzQNwlOuR4yR0sZchzw7mXSsqBhq1dgSNbReQ0qJU0YWze48y5rGlyZvCB1Q
Z8FbyfrHGx4ZQJcjB1zeXJqqW6DPE5O8XOw+xTEKzIQxJFLgBF71RT5Jg4kJIY560kzMLBYKzS1f
7fRmy20PR3frP6J2SwKPhNCsXVDP3t0KC5dUnlUf/1Ux2sVe/6G8+G7lBCG3A1TaN4j9woYHN7Y/
U0LCVM46Gf7bFsu7RzwcrKtSOnfJ3Fs7V+IWCrTMvbCSQylAy3+BMkMGFZ0WwtXNLxbYIEhKAZmH
npugOtDKS6j4LkLxkHr/dTYZvfdOXZXTIlz8qTfkTKw4ES4KW3EGzfnRZCL2VD27/GAtt0hwPWrY
HL087+VQLA9RUVdfnigRjZOPWo//78ZaDd9PPWbLKqa6EIboR2nSV5miF9fQinDnxToBGplQEcXG
WwCF8syc/0n0xzLlb/IOwxmkzMizN/3/vVp5eGh64OGdhSwzZDBQuVS08Wgfd3nVHT6zh1F0jBgZ
ACv82jjjtABB+Tg1VZ0vcRr5ZzTC1WylB7ik6soemgWAgbrQfhNh0uHr9jq+NAbTA4wqUK6gA5LP
kPwzH0/UqVP+eM3EQII1r4Uiee8YifwxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgwc6GO95nPh0DhXVGYwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIDZn
aJc2fyb916muuNAdQrrY3NVYukH7fzDICc4CyPKqMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI1MTIwMzExNTMxOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAB6MVDAiVt2NyjqgCtZgpycIsVuHiYgtgt+LbNYR
dG9edJBatfEs3JogKD8IsFqbeBurDysjSKdsl33wnS8ZaBfLWoumvOJtgSr5y0U4nYlzBowQy0Rr
JfuPXGNDuAfg050vNM+Z4HjhW7GwfCgD45I9hH2rFXoov+28L3t8MVDnw/uzkhR6/OsHRdZ/qZnz
kpSiRXIr0zlWMYewIVMTCeyJ2WbnTHXmjw7O0H+F0EInpm9PZ5trAtKc3x8Gto0wRmbaRcAC7xfd
AzvPssjVWnb/YB1PISat0RT5WX3EnZgS+QdnMIYCUDZodJoQRblycYr6Ca2inTJYcNHJsKHs0uc=
--000000000000b3538806450adb3d--

