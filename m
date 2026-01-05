Return-Path: <stable+bounces-204874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E4ECF50DC
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF4FD3103A96
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B119633EAE9;
	Mon,  5 Jan 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JqEgRPuQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09233EAE4
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634821; cv=none; b=DflJVpoUxSeRqq0a4SvlyToo4Sph2HHQiMn2FU7j95DDR2Por9ET45uBYtfoyTtz4upIoxwwyMuwPICkWt/TCQioHHkeXWL83ycBosSVcU68lxUGT7sNISlyiuX9+eIcat7QQ/eHy94FDkoSuL9KVNbtxyk1iMsJ4jp8SuLa0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634821; c=relaxed/simple;
	bh=yAo/lDwIl/3kUXRxq91elujlhyZjtidnL8fxRjEnOaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b74EceiL8RgWUR9vgXGqJbh6C+fjQ2G/wkoALIIFwJdHsKi0TpoT1791xxKIij28kJZnQhr12vT8eVJcbuHCKLCXisx8yVrEKmGBPLSSCl406XaMlp57mCu9jBBxq5g18anYLxL6jaEKSlSIk93JuAFftbSS0hGZD7Sgf8Iurlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JqEgRPuQ; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-78fb9a67b06so2420777b3.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 09:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634818; x=1768239618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxZm5PRTgjibSOJc7BYueSd0Zxg0SuU42qz+F8Dhz04=;
        b=O7Nq4TO47qrUjPDTOMcJgbpO1DetldqQs6hd6lv7GH1+nr7EMfDZ5qnb4o8ymKZ9Pl
         N02ySk0esfELUEtLslZOsSPdKeALb8vqFPJ8QBJAdQPWhWQSyujyI4hB7bs5OZfVbfP2
         vinzAw41ZcGK+1jZGiKJIxzvfEzl+6Gxpb69Jg7MZ0mo/2N3Y9kcBfql4qnGWTq1QXg7
         2DfON1tjVFhuCjDlW/a0t5PW7K8iXQ+NbtqE23VWDu+Sqqkvd5+GoqSp4CF30IyEitwk
         DlSR7vvmrEW+vG53RNpdBL1ry58ehccaG9PMSqEgm/i0Duod4wO7DEBWLU8owj9uWCYb
         VQwg==
X-Forwarded-Encrypted: i=1; AJvYcCWY5ZzoTX85NFYrPLPN7Jwkcjrm/PmBf+KYLcelyJGX6xItBoRD+GL6KhoujMyLEL7ZSWTqi+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UaqN4sOgUFuYunx6XWjZkGZDPdgcyIZkHFX7x6s9n1spo595
	jRWWva7GgGvy/HEv0HGxhg8h1abj1PHd9UqCW6N1XHZKTnPDHtrmNK4jOhdwf1t/WhH+49K1sxQ
	6QOrFZ5SFQXI5hES9QwK4VP8d4jJgTNry3gwnBfmS6dpus9LBeC6ddsEQwuPR119uyFqgEeYApS
	iVWiUznmJYpY/qZfChvUgnpsdYjmB/TqKccFDJdwkhIm887cRli0nC22qfnGFfmZxcnzEG+lLep
	FRO79Lcids=
X-Gm-Gg: AY/fxX5jqd2kVTxxlwu7qYLVsq0mPsDC8wucdfxF7f4tUH8iNzHcNv7h56NH1x31jG8
	sE9zd2EJi3LrC0VtXZhzQlA9q5b0XTs+IHVAQ3d4dY2D/fFL4n+C/XOX+D1ixHMA9Vsir3bDPWb
	lypLDzQOTj7Ooq+S00FPa7SyjZ88lUK1DGXY8UMW2z+cC+eHUnJKWX0D74FlDBfKVCjbuEHP4Fn
	QScj9KmZMvje5acfbhf4mJW+6v0FSRjA9AzfEZiig+IeG6RFEcBFC6IgplIhTv/yndODolnv9fY
	4/f3Wzyq9wCUkPfRO3wb7pG6MGfgvhze/MkrA+Q21ZSCViozhOtoZf1Bz86uIk71dyXcfi4rApe
	JPOR1ZlddG2z0T0CQfUr67O2PqzmoU4Kv78J7OL5IW369c2gg/+Ypkc4p5L2QG6SGyHBkNAcfPH
	4oDsChjKxKs7gJLhxejj9cjvXPDuhoxECj5b6iKgJP46Q7rc8=
X-Google-Smtp-Source: AGHT+IGY6kxmh8b6wTHa7O88QoFjOklcsfIM2LP9JAMhGTQ9NiILSHRukVuRS56W+J/XfjbQwjpZtRfKOK1g
X-Received: by 2002:a05:690c:3803:b0:790:4bcd:dec6 with SMTP id 00721157ae682-790a8a755b3mr2999517b3.26.1767634818202;
        Mon, 05 Jan 2026 09:40:18 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790a88d625dsm173207b3.31.2026.01.05.09.40.17
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 09:40:18 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8012f5f7a3so17956466b.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767634816; x=1768239616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxZm5PRTgjibSOJc7BYueSd0Zxg0SuU42qz+F8Dhz04=;
        b=JqEgRPuQAwIkE0GmmVsRTh190NtT0uA8l5Q7eoFulFTPff96bZHVFCBpp8PXWClokV
         A09WgvUiaDiYf/1lfyEeGIAW695KEYxfSCzCZKnfNP+blp9kb+8TOxzjCsbSwSZGYMjA
         raRrL60gRYmeUG5cZtFNHpS8ym7JEyBy+Sep4=
X-Forwarded-Encrypted: i=1; AJvYcCXam94TaQTKfjbXEQEoMnKU9FTU3lssTdg9Cp8gG3GenSJQOZsGlUrNKMwJOlOFZJqGjXeaRM8=@vger.kernel.org
X-Received: by 2002:a17:907:7fa7:b0:b83:3294:979c with SMTP id a640c23a62f3a-b8426c1fd46mr61307166b.58.1767634816639;
        Mon, 05 Jan 2026 09:40:16 -0800 (PST)
X-Received: by 2002:a17:907:7fa7:b0:b83:3294:979c with SMTP id
 a640c23a62f3a-b8426c1fd46mr61305566b.58.1767634816239; Mon, 05 Jan 2026
 09:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org> <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
 <CALs4sv0s-cJqyK3Gn9X95o82==e8zGcaEeuLHns3VPJCo7v6rw@mail.gmail.com>
In-Reply-To: <CALs4sv0s-cJqyK3Gn9X95o82==e8zGcaEeuLHns3VPJCo7v6rw@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 5 Jan 2026 09:40:03 -0800
X-Gm-Features: AQt7F2oxTTAyuMJj_Ku_CWE58RXVPhYudT9UueEynJkMIEEysAk_tdHXFr-tAGc
Message-ID: <CACKFLi=WycRNcVu4xcxRE2X3_F=gRsWd+-Rr8k1M4P_k-6VwZg@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Breno Leitao <leitao@debian.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005b73fd0647a78d7c"

--0000000000005b73fd0647a78d7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:51=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadcom.=
com> wrote:
>
> On Mon, Jan 5, 2026 at 6:59=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >

> > Second, __bnxt_hwrm_ptp_qcfg() calls bnxt_ptp_clear() if
> > bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5_PLUS(bp) is true or
> > hwrm_req_init() fails. Is it really possible that we have the PTP
> > clock registered when PTP isn't supported?
>
> Right, this check may not make much sense because we call
> __bnxt_hwrm_ptp_qcfg() only after we know PTP is supported.
> Michael may tell better but I think we could improve by removing that che=
ck.
>

Some older FW may advertise support for PTP using an older scheme that
the driver does not support.  The FW running on an older class of
chips may also advertise support for PTP and it's also not supported
by the driver.  In the former case, if FW is downgraded, the test may
become true.

--0000000000005b73fd0647a78d7c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAGhnsL
E6SR/rimW4TwDHV7YlwiTUhmrXg+CNW863OtMTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMDUxNzQwMTZaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB7Z4HsYo/mp3GPtCCCOnN1WkXf2sfxfp7qUHKCNGcr
Lq6Tth3nGT3u3srxSC4vIFi+hGEMi3WTvDixHAwrSCfRWctnZFbexuY/KugsIN96Pu4X2teiSnvj
cdmLAAmJTEKKaGhyFKwYGpTOC4X1EgjDh66U79vOLjZ1Glitn7IRSfOOOLMppERgpii4e59fo5V6
SNqO4/43dGDK1eeVAcMXzAAA5CI0/UVOF/XjReIYrRc3jwr41qe33FOyVnMcRmLQQoZfWzCwvFD9
ZTdUNjz9/f7i094uE/+c0upplCWHgHERyXYb31ll2kRJNPLShdw66qQ7WNYr9htN0EKNGm3I
--0000000000005b73fd0647a78d7c--

