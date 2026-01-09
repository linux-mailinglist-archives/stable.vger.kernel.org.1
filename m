Return-Path: <stable+bounces-206450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10877D08D31
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B8093002D29
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E733C1B3;
	Fri,  9 Jan 2026 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QbzY+4yP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DE33B6F9
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957044; cv=none; b=A3DUPgVael9cVt/m5WwEGrFGzukfqqbkAJzfoMK9o9Y/9cdVhlcQdorpoUR3cO/B0yHJGxHlG1uRVydgaW2j8MV5SZRat5AR++Aw/eX+KfC916RixQBN4HvjLYc4C8ra71zOHSFVOb8PbhKl84BLg6AiPFI6TVd0tRgYci15c10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957044; c=relaxed/simple;
	bh=XA73HGCDzbKDxUAAryx4yNZSm1BUXRzsqa0gKcby8Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMoIJVEFteAVDyfydxDhNjJ+xOQQTg4gnTBTbXpstmzPm/VtX45rjaZgs1KMdiDmqD5nqECuXxhre3OuzzyDbG8ElDI5epW4xJcMuDIhwhnfnv45WBuTQF2hc8L7UK7mSanhWe+5iNFXPGTq0w7BamW4pgmFm+ylPv1PmVaQPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QbzY+4yP; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2a0bb2f093aso30779815ad.3
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 03:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767957043; x=1768561843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA73HGCDzbKDxUAAryx4yNZSm1BUXRzsqa0gKcby8Ps=;
        b=gt6+MJp6wosybfjc1INcnhF5rHFCBTobt+N0OMOa3PHAFiHpAOoHOIhdmjA3Lh/8vF
         HYCzT/aZTkGTskXcuu4Q5WytmUuKyg0lDcSz5q/WeqooAVR07v5XEMnXevFCwepJK0na
         IMRmu9nen0wqhJMU7BkKX38afSX5a2ycXx4tw6czmMi9EVv9dH41Vxnxejnf91v4PPaf
         1HCuhUuyoVWmb17tUQTB4JnWcwuzAPqpGos1+QmdeMaGbVMhw30rZVHD8NkLsdEhyuCt
         E9jlYaoaz+1UqUI4ueeBnVrvhXsAc8FHKBwKE249uLjVvweUAHm+srtJsr4QMe5jmK+v
         YiGg==
X-Gm-Message-State: AOJu0Ywb+xKf+IjTfkDXITTFZ6/bEph2pEJ2DC2aJ1S5nIFW4AwFevg/
	EWF/H/aoyKbDH5/litfLOvSs2fOQkiPOsLCefiPN0qwsXHihiNsc8bLous/WZU/5qIp/Qe3rNmx
	AXYHQ8v/R7vqbttMRTZdm/e8imioPpmJ2kDb4rBB/iqIe/OT5BOvv7qaiexSMVaNd76a5A8ifJO
	Oihp/sbWkBcqZ9MaWC6tB48Dne3Vugvjfpqva6fJhMlp8kZw2qZSkg7NFIK5axF/IPNKq6kHU1w
	FHesZURt6vz2ooAbYrfeA==
X-Gm-Gg: AY/fxX6RloD3fDKWatuBiU8mYzOD/m8K1GBpiPh574usv7lTZ3iRz3BAgaK+PXy+yvB
	c9sHSMA14HUeeAe5YwwJaZjq2fFvfABr44HNltQPjHOI2mb8aKMF6so4mYkRnT5s1pLQjlnWGT2
	UjOC3wRkb8m39Lla5I4kcimNMFQ1s7a3eEFvS5Sifrn0sEw5eD6e5cQlkwXzhsLMgDdXAzWv0W/
	ecXTb8PUsRSp2DKttnORWnWAZ6tvHrUx4qI22utVr6PAnAXWkblTrTpnCJ3uYcJIkOt5FbdH4T4
	SsqnnbQxFA5GWGWKx0gcTMM1jU1kuy4NS8tKa+T9KEdJoqi/g9dE7NnpSAlVC7QZp9qlizxTcoF
	1Q33cYEYOHwR8gzth6+3uD4g4k6Wa6k8X+9R0FJT/7rKdW95FKxJibtrnD4w0UGmRUyq8Dc/3q9
	vAwbA4hTULmAJrVhPcU2QYDI1p2LSZlIe8V6p7BRwpP6I3N5x4Ug==
X-Google-Smtp-Source: AGHT+IE4DLjVtAZv8ij8N2X1gbvGyq9SrpGtvgfhm9nqeEx9WehJ1vduGy+tmNYyxdK3ChlqgXk+UQj7cOxJ
X-Received: by 2002:a17:903:a8f:b0:2a1:3e15:380e with SMTP id d9443c01a7336-2a3ee4aae30mr85932995ad.34.1767957042581;
        Fri, 09 Jan 2026 03:10:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3ccfd38sm12864215ad.62.2026.01.09.03.10.42
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2026 03:10:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5eede4bf7beso1523564137.2
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 03:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767957041; x=1768561841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XA73HGCDzbKDxUAAryx4yNZSm1BUXRzsqa0gKcby8Ps=;
        b=QbzY+4yP6LKFYhd6Ts7vTmnt5ZNi+TNUyhXnauLKRoy0N8x6mnnMGp2DnC7TquRkHp
         Vxo8p5seCOQHQxw2m3Ky40vssQ6tLi/VQZKtxBjg81i0pSg2XBnLQ8PUAbfAbCBB8joj
         Ub2kC+5qYG8J2JQfYrJJeH8UpVf0eD2T7M2dk=
X-Received: by 2002:a05:6102:c87:b0:5dd:8a21:4abe with SMTP id ada2fe7eead31-5ecb6669206mr3450074137.8.1767957041164;
        Fri, 09 Jan 2026 03:10:41 -0800 (PST)
X-Received: by 2002:a05:6102:c87:b0:5dd:8a21:4abe with SMTP id
 ada2fe7eead31-5ecb6669206mr3450049137.8.1767957040743; Fri, 09 Jan 2026
 03:10:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212035458.1794979-1-harinadh.dommaraju@broadcom.com> <2026010808-nearby-endurable-8e19@gregkh>
In-Reply-To: <2026010808-nearby-endurable-8e19@gregkh>
From: Harinadh Dommaraju <harinadh.dommaraju@broadcom.com>
Date: Fri, 9 Jan 2026 16:40:27 +0530
X-Gm-Features: AZwV_QjkwIyywQuTbfsK3c2NAbxdEm_U_AmfnidErBh1EZkXAz0O60GGvgFW-ec
Message-ID: <CADOamyvTXyyg51_Pc1mjJRJsyAY9vb3GOLZ6XsGt7p0c84VskA@mail.gmail.com>
Subject: Re: [PATCH v5.10.y] bpf, sockmap: Don't let sock_map_{close,destroy,unhash}
 call itself
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, john.fastabend@gmail.com, daniel@iogearbox.net, 
	jakub@cloudflare.com, lmb@cloudflare.com, davem@davemloft.net, 
	kuba@kernel.org, ast@kernel.org, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com, 
	alexey.makhalov@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com, 
	yin.ding@broadcom.com, tapas.kundu@broadcom.com, 
	Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000072c9e20647f29386"

--00000000000072c9e20647f29386
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:24=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Dec 12, 2025 at 03:54:58AM +0000, HarinadhD wrote:
> > From: Jakub Sitnicki <jakub@cloudflare.com>
> >
> > [ Upstream commit 5b4a79ba65a1ab479903fff2e604865d229b70a9 ]
> >
> > sock_map proto callbacks should never call themselves by design. Protec=
t
> > against bugs like [1] and break out of the recursive loop to avoid a st=
ack
> > overflow in favor of a resource leak.
> >
> > [1] https://lore.kernel.org/all/00000000000073b14905ef2e7401@google.com=
/
> >
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Acked-by: John Fastabend <john.fastabend@gmail.com>
> > Link: https://lore.kernel.org/r/20230113-sockmap-fix-v2-1-1e0ee7ac2f90@=
cloudflare.com
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > [ Harinadh: Modified to apply on v5.10.y ]
> > Signed-off-by: HarinadhD <Harinadh.Dommaraju@broadcom.com>
>
> Please use your name for your signed-off-by.
>

Thanks Greg.
I have sent v2.

- Harinadh

--00000000000072c9e20647f29386
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGcDCCBFig
AwIBAgIMXioQ8asZIY746p7DMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDY1NVoXDTI2MTEyOTA2NDY1NVowgbUxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEbMBkGA1UEAxMSSGFyaW5hZGggRG9tbWFyYWp1
MS4wLAYJKoZIhvcNAQkBFh9oYXJpbmFkaC5kb21tYXJhanVAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxTPq0C1enQl/ai2KoN6nMUXNdhVVWJDtHUZnLrV43nmK
5TGC6PSJPwwHNDaknaJhvioP6FttmX+LqL/uY2HyPB7h7AeMYNfPJOGHZxSFs425VbiA4BjthyIl
HZvYr5tNbRetNdBxVMcXRZ9fNHRNq9vPfJKgDaRFsAf1s4lcHZvu6+d2aDhsxuMKzu7w/OCQAskh
A69nSwtRZVYPlf7EisJLMKtUBp9ZD5ky00ULGG3T2eFCS1am0nSJI6DcndZa3ENgxqXD/21SWYiw
04zSQlaCuwzUDx9fWJpUjpSrvVctjNJ0ESE3CcTL3TjZQ6cRAdaT3S9BzYEkpWo57rE68wIDAQAB
o4IB4DCCAdwwDgYDVR0PAQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNy
dDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2Ey
MDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRME
AjAAMEEGA1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNt
aW1lY2EyMDIzLmNybDAqBgNVHREEIzAhgR9oYXJpbmFkaC5kb21tYXJhanVAYnJvYWRjb20uY29t
MBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0G
A1UdDgQWBBT8ratZ18E3Gz92yh7Xmf0hXRKATjANBgkqhkiG9w0BAQsFAAOCAgEAG42h4qIOQ1Bp
2WuwN1bMjNZprlY4v5UBYGbNTCwr2tRcQtSI/PZvDF4sdzpK5iZe3zUx+n/Zs0wy/lfJ/VhfxXAU
NSUtE4Ne0pW5qiZHDIPGP800R1Sv6s/gWnIVB0SZxe2MWbuHu6BaLF+deYWbskX46LeZJjQ5w1Cb
m+cXRM1+f/UKjA/Zr1CgLOwGOdp5HTGQ24XUDnbR5nv+Zlc3UuzKywq7e7/lQNFIDA2hUCCoZBgv
44BaqY8EK5qe18lLH8ofM7xeAtn1UFSl1mYTnlPWOXzNgCRX/ZTCYdPB6RYH+y+tr7gAd/gVHNF+
fy7i96fCHQoJLi9iKmFF05osxQQdSsy7QqdTnGZAX5oWVgWfxZc7/hJW2FcaD2AFZgEJv+bC9jvv
P/jo42ozV/gpmA/cZlYZ+aUE7Awgp24IVbj8yJqO3+Xz1mylowHe6qfc+O8sGD1VImeqhWBORj5e
wKPeY+2MdXZSB1phhZ6uvlRSear6xFVWuSXKa+0Ni5GzOtDKJvTrJAcgDnXKVNVNrSjUhZJXGZm8
7FrL6o1MWJYw7zXH2UR4UYMOR85kz3IDGiYhY+oEt5GqpVu/zbdZYyi9W0aRSMEMLrRhmyE2f9at
aBuIEoHp3sHGH46NHubC7VOMxYAdhCunJv5To0hjCcAqcJiN59HUIL/sfhHhhlIxggJXMIICUwIB
ATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9H
bG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxeKhDxqxkhjvjqnsMwDQYJYIZIAWUDBAIB
BQCggccwLwYJKoZIhvcNAQkEMSIEIEvKSd76sk+yb1siCtyvGfOIWV1Seh5vQlDQ7b0/EzvSMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDEwOTExMTA0MVowXAYJ
KoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHGumOpU
ZTCmHVnfE76m7Ia7M/KotNLXqWfDOVFJMsSqNl4mgg4BZ1Ao6wpkI26lGe/7ICB1gy9m6ick4U+j
5gZuh1L91z5xPk9KWoLj4I+KOlZ75eFAfLkfw0QPSJdM8sAceViwNwUCTxt4F9FCLZj19ZvgnmJU
aYEf7yCBbT3sv2N30HW+c0ADfPNX+KInlWN9oCpklwehbc7AMMaFOa9eQwuqoI0aiWbUrtFgCpyu
2YZNKszHloD9Ag/B36sugxHDvxP45F3yDc2VHuELRPjKTbum4KUL3/KMVFCsZN95CRGcXM+b8xlD
hiW0SsQF5DNZ8918ez4orp9SFQC9NTE=
--00000000000072c9e20647f29386--

