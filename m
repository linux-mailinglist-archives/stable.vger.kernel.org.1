Return-Path: <stable+bounces-219673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHByBW0sn2lXZQQAu9opvQ
	(envelope-from <stable+bounces-219673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:07:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A219B407
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 561F4300B2B2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2553E8C66;
	Wed, 25 Feb 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="0uwzxaA9"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE763DA7D9
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039270; cv=pass; b=C0H5iahlZ8GQlcZ+1xYYkmpjqkXJGXSUhoRfSLx4KrVhh++UtwGU1CLIk6WeRL7+fz5ZHXT8Fzd6SKBJPEN2lnXRWmZeEoNySityg1a2M4aP5cB3kq/VyMkXEnMQx3FP2mjeYCOUVUq5b5+a5VhKFD5I6fjeHMWLtIRpVqioiJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039270; c=relaxed/simple;
	bh=BHt6OhKSRIG7K0eCwlhqf9/pM6TuVhjVuDYDu9/5bnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXnDVAhuZ/nkpu7ws+i5lqc+Q9CW9ATt3ba+rKydVA0/9mFpdhgDxYDc/o5GMQPvSdfToQNWH4ZE+p3/H7Ib8Jkq3sMK1m08rXmQ6/Q63SGP8NjJq5luvh/9f5MtXKDs0LeuGKLRNDMg9vRSSw9ffjHbXjNE3FeyT9eBrB7VFKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=0uwzxaA9; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so1134251866b.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 09:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772039268; cv=none;
        d=google.com; s=arc-20240605;
        b=DOHi8UTMLcXWtOfpQttlQSLI9j04OjHNIlpqZWg8yP4JNpQmZX93pyyrwq7aWThnaw
         Wo/0gPrmXcahLDSAXDksgVVSJkT+QonPrKILZTEzMO8LlCpTIF7+LCxjC0FWBTHbnePW
         Smo1/eBdpFerJTv01uRBlelo1AC6cblNuXIVU4vORhgu3xPMz1nWl0Hot3M4FI4RFJ/z
         icxM6SsLDh2lOfzSorBIxl7TLh9YV+O9N38JSbNooQlPcUFCryrhiIppMnv1MtGVODHC
         kUeAL95gRe6sSAaQ1pkDKSbtLJ/xPxqrjkJKMBcZuLg2vZMeSbs30y0BOKRyPdBd2NJF
         6U/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0mMGJPyNubjSi/gW1GVHGktA2Q5Zc/kPJnBbOwa9/Vs=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Tub3nwHpAYmJlE6ZSJjCh3qVQmPY55LPcm5fPFSpbUn15UTVTiYwjxdi+cskdS7SqH
         Kxob6Ux8Zv70mRwGY+CXtWKJxK8UrzB1nPo2b6tVxDvqnTlcxIAHatWLEg9ZAa6KOFag
         G4LuMpMblEBLcy/gMrLCeRYxf3SZ2XV/JNNoO1Dv96I/cKLU8678Q3IR9LMdn1EW/uug
         6M7645RjscOas6AW4NfRs2ox5biZv5TPTvl9m8P10Kpav/VzEQ30EkiLrzhT2oyh9+W9
         ehrWkxxVuJRDpSL9QqDoWaFk/G1Y57Sx/Jh5Sblx4oY4LdB++uK89iydgwyCAIsWDJiU
         Wiug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1772039268; x=1772644068; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mMGJPyNubjSi/gW1GVHGktA2Q5Zc/kPJnBbOwa9/Vs=;
        b=0uwzxaA9avtvbNU8XmEtB2SReV6ImxQegUbE4/OHipb6fhsaHWdZbtD/B/7TLObLHt
         Mj9ZGdocPfLz4tYSEkPsQuaAwzgo2m3LNW5YnPkn8EYrpdQnK++YbbxTe7TEOvd3AxXI
         XBTXzc3GbjsonjRvINZqo+xsIMwbkbQfeWARsTFruGzGbONM1xUzVo5A8E5ouFmGu41D
         SuTKPuHWbgPsDDh9qlbEFA7AxJnmu1pwB7ni8P01y9j4qvFihL3gR+fvKu8xehaTfzhr
         lmiQUlsn44as857vR01qg5IYzXcIyQbkA2aejei8jnPaUSG2eivT1uPyacUMoJjoXgxR
         coqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039268; x=1772644068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mMGJPyNubjSi/gW1GVHGktA2Q5Zc/kPJnBbOwa9/Vs=;
        b=TMNp84cxb67yMa8FeCDpDfwh+XZIxWmeQwIjrOQgezTK9bw3jtj8ZmwT7YMDtjEc3C
         tGqQ14PnrEcG1/NJNhpPyxkyNDOjbEPOIBzbU8vRShAOWzINZJSgmf5O3DkKJCJAeDsb
         zH2lKWqoykLWUgRFc1n+wYTT4APanfRGrJGwHHxKJebRnl/cxaLhx/uYGPrOaBrc511q
         rrQ3QcSAOBpjV0YYG1jgrfdqamBjRasJg1gaBiPaP1tBMYtPzY+qHhB7WmhUafFsV4/v
         3n8d4Alh0pyYKOeVVkZzFU+g527NEppufM9oXvMV8rZc8va646E7f2AeFwoUATyVSkPR
         P1lQ==
X-Gm-Message-State: AOJu0YyYftwmEo4DyDOdFkXopF/4BbzztbSS4kHiEIVN8yKJFfCEqyIg
	I8PKtJV1JFbO/rRi70WmbawrcgR5cf5aPYStBreK2qVry+tMcmgXaHUFgUB1xG3XCsacoCkemQG
	bPo+vkb4W8KS0aWD1ytGDXPPFpcvzQtjTVBbmvmyLjg==
X-Gm-Gg: ATEYQzwMkUYMPtEARcgcbn41ovtG3N/9xYeZ3Lz6JUQIyLkVAYM5jOzHR79Zj5sU4HQ
	dXEdP2WlQaF4MhcaoznVXTutEcxRwJkwFvdGWuu3B1/T0CQrMOrrGafcKZgAeLrcymqRD/wPHL0
	YSl5GzA4HNwhEBEtF9KKXehGTduVlRAal+YQc4ACkwQXTJ8sa/Xxw3fQagS4Li2q51v5HTLGuOA
	pi9BedUAVRBuAZxsqulSs5YVMOiG92E2rMU4AEaB8bT7YT6m35UzsekKQRm7/X+OB/R+QCgDFdI
	P4pw7j6a+rHu9SPbgNiTvYl2wS6wQeAZFmiCYNRB0vV6QeyV3raU4xgXSYmFwgHpokxCDzA=
X-Received: by 2002:a17:907:db03:b0:b8f:f6c5:3f3f with SMTP id
 a640c23a62f3a-b935172f984mr63678366b.28.1772039267527; Wed, 25 Feb 2026
 09:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225151847.709818960@linuxfoundation.org>
In-Reply-To: <20260225151847.709818960@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 25 Feb 2026 22:37:10 +0530
X-Gm-Features: AaiRm50gCERmHyy5gDJze0xWRxS2ihcgUJwcE5zXm4dDX0vxgKBXxMTZRU4-MwE
Message-ID: <CAG=yYwm8kPbrbFExgW43q9NNv3jzBMF9OtdpT+S7k+DD5eOc_w@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219673-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,rajagiritech.edu.in:email,rajagiritech-edu-in.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 163A219B407
X-Rspamd-Action: no action

hello,

Compiled and booted  6.18.14-rc2+
No new typical dmesg regressions
.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology-

