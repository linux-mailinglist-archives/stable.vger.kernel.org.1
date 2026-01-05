Return-Path: <stable+bounces-204889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BF1CF53EC
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 19:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37ABA307B3A4
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4071340A57;
	Mon,  5 Jan 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Da7JJbvf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A56338594
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637790; cv=none; b=Ffa6AeB4aHM1Juq3oBCMdli0V0i37YBHvYv2bO+u/P2wV20Php8ZaWJm5iwqlKcT27eM4AtbSvxq8dHabcS315L87hipNVjN0yDLEe7H1U0OVpsMRf6agHWGo3kusXG+eepw2qi73WQ4I2Pms0AphSxN3KljiV8mzRMwaS5xZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637790; c=relaxed/simple;
	bh=5ljV881FTMUIZp1WIX/PXNnXCSxMfbxwkn5UnHDqJNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kopQWCmu8QLhOKvFFR54w6MHFTu7VATWiBGHF5L9sCZExLnK9qa2uAtc7m8PlgW4s6nNhbdT/F2nev+iFzfbi/v9pE6wsD/r4LO6ZIKa1fmXvWFdLs7Sawq60r32IYDueWk6nkEpDp5u3OEKzrZbQ3+0Ih3g7kw+C1k8WrIgFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Da7JJbvf; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a0bb2f093aso1759225ad.3
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 10:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767637788; x=1768242588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8gvrILIHW2IVShCP54d7SN9Eaq4ahqXaEC0p4GKgbo=;
        b=ljticBEQ3ZzPo65A9O7J0LFd5J9sQwTj+E1tRurM2EDTuGCfK43OPzE68sQPFhenND
         igUWh9E7vXy/iIBF6ce5D1VsmltBZhANTJLMmvVACfFjKijq+rPyUHEfhATYgs/HfXYd
         lgM1YhZt/RqPXpz+nA6kxzZXTxhS1tLy/+q3eTgRm1cRMCibp/IRvi8JnVR4v/DLsEKW
         CVenAEaq+rMUQ3vTXGc+Eq6stJCTgMVjonTBy8rhvw6KDLJnpV7BoIvbRyDdulxCfw1S
         bYlVaGB/8yRKnhsh+PMQON4SdAHDt9tniiTVAyNq6tb7loUGqYWWdcwADow/brzpELmr
         C4dw==
X-Forwarded-Encrypted: i=1; AJvYcCXBv5QjiLdJfb0hYqN3BIaGGMT4zNTEBr4R9RbaoUWihIZH15DrGEk+9cbVXS6QnuwHj/1SGcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIo0l+N/8ZNxAFiR8BSB0s47esOYCM2rjdLFuZlFSFFzLBghiR
	xRJPAf9BvUoDtGjTuvmIyq/jjj4iWAnINWGC03YIZrE8LswgZFUbK50ULwnocClXiOxVC2IHEV7
	QMxBwhojMQHcKC61zGXgeiUV28ZdzJKlaTFmpvyRtdO729mFsQ+Ug8wq4s+Gj/YVfJJPz/TB0j5
	Gio+nSWcm0ySNY0rUEjqOmke8IlBzTe+mBkAs8e1NRwZKn0OLtYLCmiExsNg57zbHDoBfFGOQ+C
	FhITR15QuE=
X-Gm-Gg: AY/fxX6PC9kGOo8aoVPOQ02Va1ggLr+q/FDXVq1Iv2rCKR82rSmypR5DgKFHhcKRO8+
	FKsN7FxxndR/xR50lakba6AZcDE0bc0hzZq3HZycE3UYdQoUTcWjaA6VvkFeXnwYOg/gx+rLQXt
	PRerH1J4wbClhcTo6QmA9AnQisk9SfUiyuryCjLQ9TcmstN4mahlaAr8JHPPV6LTRnuNX3SHI4S
	OS+PCNJ8h6AHhb6BTWco4QJcm+HFIf88IGIcVzqaUxp+OI0uRl/T2i3jXCmyVlwqB5+keOAKb8S
	UdxtB/pDnkOVkz4adNIlZ9rC/NrBWU7ljMYH+m9SjLhICHGrtMa3dKmOiuv3UaCY5+o+2UTG5+T
	b+Obpcc88Ok+4dO9Z/BeUXJ1chTmzYWBZtqrsd0q8KgjAZzJXZNGroelfC8yPPd2aKmeOr1QxU5
	9mh0NQ80JexhyHSna2mEom+DSA/IoelZCBIQtINBYpcQ==
X-Google-Smtp-Source: AGHT+IE9lwH53GssTqYOI2c/vxE3DnjebbjM3ZXoHN+vR8qkchza3ioMWbIx0ALfB9M+0MIvC8NujZ6xKqMz
X-Received: by 2002:a05:7022:220d:b0:119:e55a:9be6 with SMTP id a92af1059eb24-121f188ed22mr209621c88.2.1767637787577;
        Mon, 05 Jan 2026 10:29:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-121f1397903sm95292c88.6.2026.01.05.10.29.47
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2026 10:29:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b73599315adso16230066b.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767637785; x=1768242585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8gvrILIHW2IVShCP54d7SN9Eaq4ahqXaEC0p4GKgbo=;
        b=Da7JJbvfcXtZTz36kjek2bNVZyvBO1Jn9bx92dNeJUFMFJFOozY7CKZXBM9PRJLK4w
         MhKHW+XdNSsVQxKs4gviYg4Kzvm0o7emRa31Y/f4ahP6bguXy3vJOFjs+rXvw+/r3gkC
         fW/QhB/BUz7tgviKEZKn/IaWMq8d8kaa5F40c=
X-Forwarded-Encrypted: i=1; AJvYcCW5uq4gL56w/CRnKwfbg5aEAmehfrukBc+fPHLJR5TBdRMHHuPV+zfV97H8nfSALXjcLPFh1ns=@vger.kernel.org
X-Received: by 2002:a17:907:3e9c:b0:b73:6d2f:4bb8 with SMTP id a640c23a62f3a-b8426c223c3mr71179766b.2.1767637785374;
        Mon, 05 Jan 2026 10:29:45 -0800 (PST)
X-Received: by 2002:a17:907:3e9c:b0:b73:6d2f:4bb8 with SMTP id
 a640c23a62f3a-b8426c223c3mr71177466b.2.1767637784967; Mon, 05 Jan 2026
 10:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org> <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
 <CALs4sv0s-cJqyK3Gn9X95o82==e8zGcaEeuLHns3VPJCo7v6rw@mail.gmail.com>
 <CACKFLi=WycRNcVu4xcxRE2X3_F=gRsWd+-Rr8k1M4P_k-6VwZg@mail.gmail.com> <aVv885DfEfngQuZJ@shell.armlinux.org.uk>
In-Reply-To: <aVv885DfEfngQuZJ@shell.armlinux.org.uk>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 5 Jan 2026 10:29:33 -0800
X-Gm-Features: AQt7F2q36z__1kYCrwIwIleuJJL4DBeYr3FDFz4vF5Ok8w4sYfyZoM7OCQPK2As
Message-ID: <CACKFLinXhq9G1nn301OEjTH+E_31RmnDPwQ=VSEMD=+FVGiuaQ@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Breno Leitao <leitao@debian.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004f741c0647a83e34"

--0000000000004f741c0647a83e34
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 10:03=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> I'd like to restate my question, as it is the crux of the issue: as
> the PTP clock remains registered during the firmware change,
> userspace can interact with that device in every way possible.
>
> If the firmware is in the process of being changed, and e.g.
> bnxt_ptp_enable() were to be called by way of userspace interacting
> with the PTP clock, we have already established that bnxt_ptp_enable()
> will talk to the firmware - but what happens if bnxt_ptp_enable()
> attempts to while the firmware is being changed? Is this safe?
>

I believe we have code to deal with that.  During FW
upgrade/downgrade/reset, the BNXT_STATE_IN_FW_RESET flag should be
set.  The operation that needs to be avoided in this window is reading
the clock registers.  A quick check of the code shows that we take the
ptp_lock and check the flag before we call readl().

--0000000000004f741c0647a83e34
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCHI9u9
MrqX23VtIiLIPQxdl6ZgQuuZFRzfgBNIanGUKzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMDUxODI5NDVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAbN08uOJZmzKPjOenKwY8xBXa61kV/svOpsT0pM6CW
FF0ZvJqJwK+7U0jNAyj0zlZ3Y4pqwfpzSd8fFsmtzvViL3JucCyKe3n1qpfr/ob+2guD/Q8UaDfY
oVnazYEPL1/L7B9u6aV6XfKqp9WFkaTY66U6jxrS53+xSDR2HKfEPHMn20S4UKJV8eKF30nXcRQ8
VdGUsufB59aYhyyQez6Q84GY8gN/9B6NAn0gjj6Vj2808LPM7xbP5XHNKwpevNrC4pYyyjhJ16Ix
G+5PhIjLTqyftcMFJAtX4H0PV8Ep+DpRa3lul9JyrfG5Gt7Cvt/biWpof++ZLh70EBugjSdP
--0000000000004f741c0647a83e34--

