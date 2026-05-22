Return-Path: <stable+bounces-253730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB26COEiEGqsUAYAu9opvQ
	(envelope-from <stable+bounces-253730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:33:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D155B13F5
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FA5D30FBFB6
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607E3BED78;
	Fri, 22 May 2026 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="X6vF6cKX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC5346E7D
	for <stable@vger.kernel.org>; Fri, 22 May 2026 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441894; cv=pass; b=fHX6By7DGU857isCg0Hzy44Z/WKq/q9YNTQDmo07cfbcY0o1QfhxoUiT7mFtzkw2BQxScgcQJ+MrEQBN5qANG5T6NKptRxwOk2frNZaMXgoXKJ61C3mV82h6A8+TwebZcs5RPJ2MicFP8lVCrOmC3BYBA5CD+VvXKVtXQj4iQEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441894; c=relaxed/simple;
	bh=IZF7VWTEkxD+pJZjqgXH9QW6HzII5dJLvwjpAdoSmuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kW7IAb3jIr5n6YH7pr+nS2yGSCJHTZ6lldFpyDbMbYTX7rpXv7r+S/ZMwVk1yPAGxdly4v+vw57XXwFQkc3hoqtDfzun56Gx6an2Wheh+5mKOsW2gnG0KYzUw4Q1KeTqq7Q8jJsZ+pHIwAFaa9KP9BmMjg0O6kqvCFn90LE5TUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=X6vF6cKX; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd56d108454so1349398966b.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 02:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779441892; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4g5w6zPRfoXvj0JUuupRTKZ0OSMIJH92AagEyVWY8Jsr6v49+QhVZGkMUd1bTPN7g
         Dc1XpJ/a7M7zVpZoUUa2wIPszYPEKDNLI5rYuuIXIHAU8Uv2YSTV21FHou5ibjzIcgep
         W4xhaEChjdFCfbCRPIdYreIcVvgc2xlGz/m+qVDLlyVIIubpDrJICaH6H+bOBcUyF+HR
         Cxc0WiErKBTyeudJEfKr6Dc5NY1qNbx7EoAXp3BaRcbvR8XuY+E3blCUvegI2NbuDVYJ
         ZEsIpLhfCBjag11QJavLCkJLstqb+4EfYu9SQ91GU4OeiN2hmII6QJ/npXTnjQ4PbRkE
         IdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mGl6OXIZjtxEF7piXmOH4UUqJJTESaRkqOGGFe/ZsnI=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=WlopGwnt30kKGgzJIqpDK/6Ti4XnQwGdX/qgiyxGSf4/RqNI93o60Ap9qpTT4jCGl5
         nW70BGFjiu4U7hBB8eYA/gv1czW/DwURUCRMx4eLrQKfC0uIRUmhr+GdNowjyP+YQgMN
         WEeEvrZaeIk09b0UqGwe/zvOqzS69K7k949LAJ5pfiHIORUKprrgsm0IKVA6ue7dFKuB
         8amfDDhGd8oAx49OCUyFBDpxmcen1NGbc1Bp8/6IJivW4vR0OSM1k+lByWneu0Hxh7+c
         Yy3F+z1K6KdO7Gu9/C7y0Ttbdx3sMdTGo9Lsy0EZiB0n/AbBeWeEcAjKPh1i4RWUi1wd
         VXFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1779441892; x=1780046692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mGl6OXIZjtxEF7piXmOH4UUqJJTESaRkqOGGFe/ZsnI=;
        b=X6vF6cKXHfz1U79+RVULo4hJNLSuz22/vcBotNJJfjIpYTr7ms5pBxJ2LDCblLrUPM
         PuHl21pLel8qara9XEJIkajHzLOw+6EJLmyQUsLrZnFWlC447VgIqoQkkVrLu4//RAWz
         dQdasD0NpD7CX0bntBLX0Us52R2HiOS3gMUtDHHmTtaPTdsTLnKXBf4AihbmZ+gr4Mxb
         U3oZYkGQ3HCamyS/90xz+aDUkQLZQDwYXc7rmC2kYTw/ooZN7XiK56CtIkmSrLiigicM
         l/8aj0Tz5QZXQ0URZ4FOTnXCaz77EBRSJhdzMkkWgx42rotFjnmQkQeuqO8z/Bfmn8GL
         Bdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441892; x=1780046692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGl6OXIZjtxEF7piXmOH4UUqJJTESaRkqOGGFe/ZsnI=;
        b=cZaWFt2sPEDf1AUJidLFngVmPHZVvCxuR10xCknaG/rqtO3Gtv/b9reII8W/eCRsQc
         p2IafcwhSHHdDMlsB3cs8neDbFhgSC3yktnFS3mezdlI2jC32//NK6jIFkYof9sB3mwT
         0uWMB5fK8D4xWhFUW03iUCxi8LcihUdZ2/q0Y69XJzJ9JDCZaNe9Jnl2AhirNJf6k0/2
         lJN2e7qw1QfUkp0DDVSKmImuZ9/YHSezJzAcotLLHB5ZD6P8njgDGavBa8hf89n7eisC
         Cf8fILo2w+tkdK0wiX6v89iuBkOr6NJzhxGL96/kMWXx9i1MAXoYTFwRHFcaJfYZfiAj
         BulQ==
X-Gm-Message-State: AOJu0Ywoh3M0WYdfK+agf+z1wK0JwG/XMza9Pd8OpgnhskMcLHKL3ebR
	qeZnDLhjgljtEb6eh6hhbAWLp3Cq7p/mpNZej45HYKttd3Gi1xGZ+2pap9uncnCX5uKwdFoKS2l
	YOoOb/GeVNQ8FwjrW47ONBFYW4oP138Ozh8ZcH113Lw==
X-Gm-Gg: Acq92OHCYYFVqhDvtabjgqwgVximrW4v1Ppbus55C0PeBvwTtUzZwBduXYOMcgt7znP
	dMdnsRlo+0tZIIpwTGB9ZTgbTgl+P2/s7MUtPE8aM5L99pAiG7bRKAmIezKKiML0dWclcqCuCbt
	RrufOKMKDYNtwQnToYo/moZHUEFAAXUFMlffFM7oWPG4Adn0XMkeqAzJ8CwL3//qhRHq0YZPMkj
	YtgfPvBlAP4LZo7G8JYkWrCMMSFGndahxLQZFYUbtqDxTXOrTfw3lJlC0GVSGFSTiJDgnyFb8Tp
	rvtRZpY+EKRyXXtgzm+4k+LoERCm24Rx3zQ3JBztIlRFV6M++SJ1k6q2nAJZaIlqt6gQVaKzawe
	NXgccrA==
X-Received: by 2002:a17:907:60cb:b0:bd7:bbae:2002 with SMTP id
 a640c23a62f3a-bdd22a3d558mr171790466b.7.1779441891775; Fri, 22 May 2026
 02:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162148.390695140@linuxfoundation.org> <CAG=yYw=zUeUFxBvLhAvhbhaSv=H0qUi+CFkcN1D+Oxxw6fW58A@mail.gmail.com>
In-Reply-To: <CAG=yYw=zUeUFxBvLhAvhbhaSv=H0qUi+CFkcN1D+Oxxw6fW58A@mail.gmail.com>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 22 May 2026 14:54:14 +0530
X-Gm-Features: AVHnY4JkxCN04TKCulppq6Xi8XeZ872LpbUc0lIeILi89vXoCyM1TV6E1paAoTU
Message-ID: <CAG=yYwmZExpLR5DY73s4c2iQ1cQq=7UcTWO9W2saaad_fzu1UQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 0000/1146] 7.0.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253730-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 79D155B13F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 hello,

when i  did " make install "  for perf.
then rerun  "./perf test" have changed output.

