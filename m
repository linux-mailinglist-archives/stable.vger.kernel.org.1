Return-Path: <stable+bounces-167145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363DB22610
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF51B60B34
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008832EE609;
	Tue, 12 Aug 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d+ywm99s"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE672EE603
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998878; cv=none; b=BVZd/WxDxu/Xx22JvgyPJcmKjyWKpP++FyXZhI30OJ06/6n4YX61TPxweCOB1vVoYFaOXgajwbBSIM3MgI0Xh/WqNDZ5/xq2GN5gzgwhWj665hmXLSa/BC9bjtl2zlhufZp5zsP97uVAbNgo2YNlm+sLEsdqNlqegL0O37l6IUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998878; c=relaxed/simple;
	bh=nf4GmMUhTAcUQ/k0xXGenSaE7f/W+IAx8q1Pp6ODX2k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k37P/VfC6Hum8GXdMCjnSepPfPjrYPuEcBqRJb41OGMVs1U42IE/iZeMLtZLe96GhfFEo+gVPGIfewLznFA1ZP3vLiPfaYB+S0H2MSQHvVsoUXjUL3g/gZYx83SGCLhpTdHrtL52LBJG8gUmv3NbZGk1ngnkFJwA0vV9CwTd/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d+ywm99s; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3e55b6dab96so1858805ab.0
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 04:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998876; x=1755603676;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nf4GmMUhTAcUQ/k0xXGenSaE7f/W+IAx8q1Pp6ODX2k=;
        b=lhKtNIbLPUYiMQZ7aaoDHDd53zcTRxksA5iPpvV0Bz7i7Hs2pEIVFfpVcSK2AIV5DS
         MbYZpkT6tgWGxz1wW5RrzP2ExRqICaGAK+dM41wJ4HJ4vUlHMMri+/ITUQeV/1SwDD9O
         JufU+WV4Kr0wxvKpajVano9SC23x4QqH6848LbrdJ+RrfbQlFG9giEVKcV2OurTTd8g0
         zpTEjaxjWLItVhmk+2PgTthz48Gpp4YGKahBWIV830ZZhOLH2Y8HqdghJWRw/qqKfhX4
         f11Fz3OnTEMklNXdI1vMxtoV5Nih6xGChoc0dww0AJ9XpeVLw6Ia1cUc4+CxufUaZ0X9
         0/oQ==
X-Gm-Message-State: AOJu0YyJYvO5gxA7FdGyxYfVdn07BPTBjTlOLWE7hWHmUszst6QskH/+
	REn1wELXjrnyW3VZ+NC1ID/MP1DBXRKd2dklWH1gRQihNiFFIFefn2MR8z+mmCol9mCnwvhdxjR
	5+/KLbu5Doj5ZgpfHLK/fy94iTxEha+ZVGogAjuM0jaYpxs/LRNx5Lf8eVPn9aR+zdzXAgi3cmx
	j3PQBef5sGMWfAZtWo7S3tW7iOM6XricfC2/C3ZqRrLDHmYnqVP1FR7jpZ4LwazQ62vgQD9YRRK
	W4FeI8GJEfNz7SvE9tpi0iO6BQK
X-Gm-Gg: ASbGncvj/Py4ObmijaOfoDeOcihT11HuxIn1bQmtnSW2hrM4TALjG6QNt+l+a1c/zbb
	aGCpp5iGXGxT8MkwXHc9EIPSvWDXZFYns/gw7txgJtAGfTuyIruyLiro0dOijbRSgyrLSzu9rqa
	EsFkXzjrwadPOMrCANoVWu5KxGb27sytaZMyNMhSRLSYNcCQmS4LGjdAl2/oSocDbJcBu9xgb4o
	2XFvirkDVavb4b2nxCbkNCtkDIVSUeg6/8Wk5MLe1T3lKRcrkcL/ITIu73bU9XQm8b1uzuEPdsr
	2IoqcA+F/J1hqwEp+dbEvtgOx+qxtgislDBS6gE3XStbGF5NwPJ38zvJsnXkQVw+DAIvRwHlFwW
	d8KlvbR+CzG7Y+JPsfMIHj+ZG5Fsyyqzd7/x9wI2jmo/fKDoox9IhciJG5mp2VA4dD2pfkFwGA7
	Y0hke1lDHcGRwLvA==
X-Google-Smtp-Source: AGHT+IGoPhNUyljVKOP6xE+5VH8meknP3WMkzkJszlDfB/05+G6sSFJN6M2gVB4WLKQZPx7Y9JXCwwd9R6EY
X-Received: by 2002:a05:6e02:1565:b0:3e5:4816:8bab with SMTP id e9e14a558f8ab-3e55ac60210mr51426555ab.7.1754998876229;
        Tue, 12 Aug 2025 04:41:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e533cdca47sm8513625ab.51.2025.08.12.04.41.15
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Aug 2025 04:41:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-af95bbf26a8so439876566b.2
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754998874; x=1755603674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nf4GmMUhTAcUQ/k0xXGenSaE7f/W+IAx8q1Pp6ODX2k=;
        b=d+ywm99sxOimRzuKBhS4sJBsF73u+o085U3owFwsbAd7MD1zE2LasnRoDB+vG7oqgS
         OqsiG3mscaPjlwY/bwC6G/Cy1X7WNpl6nU4lpq+yhk9U2qX1BWpf+xYktSTt523/gDOB
         fHiwbq1nLnDZy9A300JOzDtaD3B/x0K9hokM8=
X-Received: by 2002:a17:906:9f92:b0:ae3:5ff2:8ecd with SMTP id a640c23a62f3a-afa1e06dd64mr270664466b.20.1754998874090;
        Tue, 12 Aug 2025 04:41:14 -0700 (PDT)
X-Received: by 2002:a17:906:9f92:b0:ae3:5ff2:8ecd with SMTP id
 a640c23a62f3a-afa1e06dd64mr270661566b.20.1754998873556; Tue, 12 Aug 2025
 04:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Srinivasa Srikanth Podila <srinivasa-srikanth.podila@broadcom.com>
Date: Tue, 12 Aug 2025 17:11:01 +0530
X-Gm-Features: Ac12FXxlhJP1Z3vMi6WVactvzqgW1uzB317UtaRIvqqG5Om59dOYKSLkL3V47-k
Message-ID: <CAGhJvC47-ku9-72pDwVu_2iuROfLGchZVtmofWeJoN0wV7yBPg@mail.gmail.com>
Subject: Regarding linux kernel commit 805e3ce5e0e32b31dcecc0774c57c17a1f13cef6
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vannapurve@google.com
Cc: Mukul Sinha <mukul.sinha@broadcom.com>, Ramana Reddy <ramana.reddy@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007e6651063c298434"

--0000000000007e6651063c298434
Content-Type: multipart/alternative; boundary="00000000000070b496063c298471"

--00000000000070b496063c298471
Content-Type: text/plain; charset="UTF-8"

Hello,

I have come across the linux kernel
commit 805e3ce5e0e32b31dcecc0774c57c17a1f13cef6 merged into the 6.15 kernel.

Kernel Commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=805e3ce5e0e32b31dcecc0774c57c17a1f13cef6

Currently, we need this fix into the latest 6.8 based kernel as our servers
are all based on Ubuntu 24.04 with 6.8 based kernels. Please let us know
the process for the same.

Could you please help in this regard. Any help on this would be greatly
appreciated.

Thanks,
Srikanth

--00000000000070b496063c298471
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,</div><div><br></div><div>I have come acro=
ss the linux kernel commit=C2=A0805e3ce5e0e32b31dcecc0774c57c17a1f13cef6 me=
rged into the 6.15 kernel.<br><br>Kernel Commit:=C2=A0<a href=3D"https://gi=
t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D805e3=
ce5e0e32b31dcecc0774c57c17a1f13cef6" target=3D"_blank">https://git.kernel.o=
rg/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3D805e3ce5e0e32b3=
1dcecc0774c57c17a1f13cef6</a></div><div><br></div><div>Currently, we need t=
his fix into the latest 6.8 based kernel as our servers are all based on Ub=
untu 24.04 with 6.8 based kernels. Please let us know the process for the s=
ame.<br><br>Could you please help in this regard. Any help on this would be=
 greatly appreciated.</div><div><br></div><div><div dir=3D"ltr" class=3D"gm=
ail_signature"><div dir=3D"ltr">Thanks,<br>Srikanth</div></div></div></div>=
<div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_sig=
nature"><div dir=3D"ltr"><br></div></div></div></div>

--00000000000070b496063c298471--

--0000000000007e6651063c298434
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
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGhTCCBG2g
AwIBAgIMb8nIUMeKYCnZQneeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyOTA2MzAyN1oXDTI2MTEzMDA2MzAyN1owgcMxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjEiMCAGA1UEAxMZU3Jpbml2YXNhIFNyaWthbnRo
IFBvZGlsYTE1MDMGCSqGSIb3DQEJARYmc3Jpbml2YXNhLXNyaWthbnRoLnBvZGlsYUBicm9hZGNv
bS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDDNbEriwEaloGCny1+OPWSbbIk
wWF3v7K6oVgqedeUIaE4PPXKCDIsh0gaQMPeY8a2g7yuZLFHtlyqpco2325Aapx5NkCbsJVezIIn
Bf7arJVcwl1Tpw3Kq4dspUQX6pMi35RjNRQaUtXakdYv2BbXKpLa2nMwu21gn/PvzU+rqG6JrDPz
yeWQq/Xyu4yUeua9rjdEPR8aXyeGZolkp+GsboLqiPY3L8hw61wfp2PxjrLvJo581jBJCChbjMwq
3cHKcWEjcmnsDtqtrePY8copU4rw+JEzwJR2oJNxygXh8Q/o6vrXxoerqO40uaQpB5esrOC91NbR
KyLhyXczBfmBAgMBAAGjggHnMIIB4zAOBgNVHQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGD
MEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2
c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9n
c2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgor
BgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9z
aXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWdu
LmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMDEGA1UdEQQqMCiBJnNyaW5pdmFzYS1zcmlrYW50
aC5wb2RpbGFAYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAAp
Np5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBRN465ckGjrhEe19Bejdn0W53l3FjANBgkqhkiG
9w0BAQsFAAOCAgEAgb2uVFeWXvkg7LnTZ33KzNofOqiRMDalPoY0fobp72Ul87LOi+EPCkaOvAd6
WDLHIIckXspw7WUPoystlRNBBo+LN87lioKh/42/UwQQu+2ciaqtJIdaMHyzoQEcbRCwTnDRFuOR
IOfGg3QDlXpSBKvX30EmliCynrArLuNPAegZMjbcrCBTUOelR0IMEtJ2Y9e/5H2rPNONA8u/akWu
LAk+LC2rj8GkYZj3mWYA++fr1Qzh/ZQQXI0mLMzbjzGTvjEtjrmchNHZuXvO2s92RCrO9X7qLx8g
6QviTa5Hai0OgjvkljKAU+2WGXiexb5p8GiwKuY/oz8ERreD+1pyUyBZ/ZRow+i5/zV84uvgvHfJ
h1SfynW57CCutqlt3UIC/uxqRqnWGnZNE1HuvU8Siv8Hkzn7GjjH5MXUFxg/sOosTbagrl65o090
b/CQWBbg0QFpujJgLOl0V1JtTkhZK6scekDw+gwLYNqok0g6QTBDe9N/V+hhg8PYJOKoRxIbpdcN
W2V8I9iVh1SZagCY4014+xAzPdQ1lFOHZDT3o2mSRlEGxb6S0ozYLTwY/13nDU5voY7y9w+d0AOD
4AU8cU+8mwNpiFCqJSKBaCTgymcOBsqEl37x/LsVT+akqeEIXssxqlJ8wViN4d5ohWXD1Ba3/rj+
Nf63Pmdvyu9dC7YxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxvychQ
x4pgKdlCd54wDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIC0ch4xxtymjHaAH1zxX
w9fOIQuWJ+ZOcDJbcwFfH+/IMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDgxMjExNDExNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAK317Mjy7o9fjiRf3T4nMUlPsZOSAM5M6dNB4zTB95wD9kMdTRj66ktz
6wCulotQP95OXgKfjqmj6XZz4coijeYKAvRr4UI4FpwAKrLTx0BlO0Irx4oRoD2HXTYS48Q8sGHS
W60H8oaEJOhQiQqJC3HsdL2Eidlixc4AvyHg0FBOvvXe1yv240KXoUyBifwz3lBEnV9aH4GDW8+K
6enaTNX1xUZg5f+/p4t1Xpge5YiWDWlQkVLQbnLCKiYuIivCNzA6h3YFznwGVhKgqVcPZkI6iidR
iIw5rpq672HygVOoBnSg30YG/eFvZj/ctX+aeZt/xiH6MOscWLF/icVa5co=
--0000000000007e6651063c298434--

