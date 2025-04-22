Return-Path: <stable+bounces-135156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B438A972CD
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324731886A53
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20087291153;
	Tue, 22 Apr 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VkiUewsG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0229114D
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339492; cv=none; b=o3D1H7sjSDQNS4fGvwY/QIjGXRC7YaIDl5no7R6AUYme4SOFUB7fHUsIguW/E2aDm/QjXQ5fbOptibs7b8k1DLnoPHIJEIUCj1h89glGzcE+QubXTxNngXj7JMM21uNBjkhHBNL/j74HQpJTiONnCwODtOZTOocuxwCQqBoqEeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339492; c=relaxed/simple;
	bh=01RwRaQh2BLtw+ejRZ9H4E9ZW1v7UdSVhsHybBtMfto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvazrCcurBftUGE1jouHgq6JJa9sVfBlnyfI+zTq5EihSjWVjRYlxOhzTN/X+PkwTZBgPE0A7l74BCTycD7uLJ8dbs05lqlwUM5ynFzD09i+A/804GC9J4T+vz5Sg5RKzqACKvlNlaZHne8HrejUXBCwUU0v0Ve+fWTtt67lok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VkiUewsG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-308702998fbso4828985a91.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745339490; x=1745944290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=01RwRaQh2BLtw+ejRZ9H4E9ZW1v7UdSVhsHybBtMfto=;
        b=VkiUewsGm4LUDD09ydTx8WlXN9HWM6SRddBkGaMv7NSRaHTi3Dl6AfyTDabkEZsDwH
         L9oS7VMUGSZof+ZXj8JgzZKvNDmzV1GG/nXySwUE/GKbWx+mr2l6TzNdGh/6pYXnvGFA
         DpGPVvSVeMchijconv0mLdRc9P+3Tsy5qXdxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339490; x=1745944290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01RwRaQh2BLtw+ejRZ9H4E9ZW1v7UdSVhsHybBtMfto=;
        b=U9m9v5l9N+ACqeyNjUgD/8H3Eu+0cNZytmhNSrLtXwOFkvFlG/M3nQ/oqBJl+STD+F
         jrbro8YoH9Xp6HMsnM1nXLJjUg3FcRXfpDSGHFNjyM0kgZ7cyWqq5dR8wC7EdeU01/xo
         XY/8ZhfRykusCoTJ/olEL1FN31IoXBgxEncsxf7SM+cHnfRbpYVUKMptS9luHbStrq2d
         0qECVCauHZ97G1cLFDoz6LE/UyWlhX5OnnPpwDxoEITW9022hpQ8zyIwrSfXrgmO61mV
         ufw/qo3aoWohIjVLSwvp2ZgLk5WwBf+Sg7Otj8FVdyo2dnQhpei3xK1E1iRQfScickIa
         djhA==
X-Gm-Message-State: AOJu0YyjpI+5QoHeuFk8VdcNLqwgdle4PZ8OlfQBlpM1wl/mUisI+cB/
	5kf36/sigUwmFrQjA3XGOj+b+oDVKS60rRXBBMW29BvUEJz6J9B8TDYhwgBsxfEEzsDxWdX7hUl
	PtZ/VQsv3x7BeTmdceXhAAwxqZjf9m10XHLS5PWeDlrTDYECToHcs
X-Gm-Gg: ASbGncsy/VwIU4bnuicggRnjlocyVmmWA9/SRbQmgdSqSGQk0W6W59Wp5hLPFo7EYHC
	SMBXPhzumlmOewt/IKPC4ernq2gY64NsH9CwtgSPEYT7dqSpNxfLwuSjWhv/ok69mvSjvH/O2/S
	4G90wZxcdzm4gqtmBf7xYzn9k=
X-Google-Smtp-Source: AGHT+IGhb8C9uuhq/8l0Pb8BCtcBYdEL9EpUMxS29gTVZExb+7E8G2P/gHN9remhZZmdRWut2JdZ1l/C60NHJCkGalU=
X-Received: by 2002:a17:90b:1c0a:b0:301:98fc:9b51 with SMTP id
 98e67ed59e1d1-3087bb3e858mr21822081a91.5.1745339490670; Tue, 22 Apr 2025
 09:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025032413-email-washer-d578@gregkh> <20250324221236.35820-1-kamal.dasu@broadcom.com>
 <20250324221236.35820-4-kamal.dasu@broadcom.com> <2025042202-profile-worshiper-c2b0@gregkh>
In-Reply-To: <2025042202-profile-worshiper-c2b0@gregkh>
From: Kamal Dasu <kamal.dasu@broadcom.com>
Date: Tue, 22 Apr 2025 12:30:54 -0400
X-Gm-Features: ATxdqUE1kO0xtm_Jta1U-Km-YwMfc0QJHBb9eW8s0ogdQxIeZNy1hXeL6ZCK99E
Message-ID: <CAKekbevHy0v78=3QmDeOWTXCX+oj5zxixw19Wz8VKLByA+MygA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 4/4] mmc: sdhci-brcmstb: add cqhci suspend/resume
 to PM ops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005f46bb0633608436"

--0000000000005f46bb0633608436
Content-Type: multipart/alternative; boundary="0000000000005ad74f06336084e0"

--0000000000005ad74f06336084e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should be

commit 723ef0e20dbb2aa1b5406d2bb75374fc48187daa upstream

On Tue, Apr 22, 2025 at 8:14=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:

> On Mon, Mar 24, 2025 at 06:12:36PM -0400, Kamal Dasu wrote:
> > commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream
>
> Not a valid git commit id :(
>

--0000000000005ad74f06336084e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Should be=C2=A0</div><div><br></div>commit 723ef0e20d=
bb2aa1b5406d2bb75374fc48187daa=C2=A0upstream</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, A=
pr 22, 2025 at 8:14=E2=80=AFAM Greg KH &lt;<a href=3D"mailto:gregkh@linuxfo=
undation.org">gregkh@linuxfoundation.org</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Mon, Mar 24, 2025 at 06:12:36PM =
-0400, Kamal Dasu wrote:<br>
&gt; commit 7116ceb621274510ccbc7e9511f44ba6c3456ff8 upstream<br>
<br>
Not a valid git commit id :(<br>
</blockquote></div>

--0000000000005ad74f06336084e0--

--0000000000005f46bb0633608436
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DxuNuBlySpn/GYqPcDcRZd8EENWqnZrjtjHMk0j7ZfrPGXq8sQkbG3OX+DOwSaefPRq1pLGWBZaZ
YuUo5O7CNHo7h7Hc9GgjiW+6X9BjKAzSaDy8jwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdrYW1hbC5kYXN1QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUcRYSWvAVyA3hgTrQ2c4AFquBsG0wDQYJ
KoZIhvcNAQELBQADggEBAIKB2IOweF2sIYGBZTDm+Hwmhga+sjekM167Sk/KwxxvQFwZYP6i0SnR
7aR59vbfVQVaAiZH/a+35EYxP/sXaIM4+E3bFykBuXwcGEnYyEn6MceiOCkjkWQq1Co2JyOdNvkP
nAxyPoWlsJtr+N/MF1EYKGpYMdPM7S2T/gujjO9N56BCGu9yJElszWcXHmBl5IsaQqMS36vhsV0b
NxffjNkeAdgfN/SS9S9Rj4WXD7pF1M0Xq8gPLCLyXrx1i2KkYOYJsj0PWlC6VRg6E1xXkYDte0VL
fAAG4QsETU27E1HBNQyp5zF1PoPCPvq3EnWQnbLgYk+Jz2iwIUwiqwr/bDgxggJgMIICXAIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw89WX2Pp7ue922QVkwDQYJYIZI
AWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEICU6HQrchJx+01T1oUCNL72sOrVDUmqmb1CpnAkW
NxC4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDQyMjE2MzEz
MFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIB
ACVH3EfIcBdt41e/cu2P5+JSEDDn+voCDDrf2Mp9j+hphTJQ5sZssKHNLBHltjU/NedPrWe1hSVQ
wmx5GKNY4uaLHVsThgWodLUNvuewaTytIJI63YrGpTRrXXzVwtyOLeCcR8YWOW20gXPx3D0Dna/a
K0u8wrIDuoBpV1LieVhymUGNndnj+3vm6Jo/mDYMBzABop9KsVnzd60mHkxyOy/CFSQWffI8edVp
1qvEJmK7MazlBURRnJdw/2dJ472kliJsRKsqINHtDiFb7bypM4/RjlEmAGM8lBX4MudIeYNuu/cO
6B+J+ZcFjsTPCxXUwRYDdNyBUy+3umwDaeBSAlI=
--0000000000005f46bb0633608436--

