Return-Path: <stable+bounces-253738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNSOOjMsEGphUgYAu9opvQ
	(envelope-from <stable+bounces-253738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:13:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485E5B1CA0
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EE683015485
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE53C5528;
	Fri, 22 May 2026 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="FhrDI8Yn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FEC3B8955
	for <stable@vger.kernel.org>; Fri, 22 May 2026 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444391; cv=pass; b=DNKPObo+NzFUDyAs9G1FS5DQ5Gr9bk0m6psHY/vSyY7Fsux+mt5W7EuP9uwmzl7JRNYNWe09wWfZiCyBz1oBGJkwPgB38WO5mWENIgP93ydLVnJebEfyS9rI13pDi8ThpOV5sVcKgS07kQ6KPGHEeQfTjuQVieqCRnMTQrY86jU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444391; c=relaxed/simple;
	bh=Kk3dpWi4X7WdsgnppTwI9RI+M9l0h+1R6joOKnG15oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tn5Y/BJpaKVvVnkj/EOTEBh6GmbHrkTVRMV/UfPyyzZ9r5Wqt5kas7COxoKopC4eyCuAC28vFZHScuQDXtpZIKrJJ0t75oiGnayPZfEQBEW4xAtsvqYquCxGmD5fHABrfWca3oW7RIaERYXUIgcbVvj/xzY4GSiQD7gPNTSlMX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=FhrDI8Yn; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd3eb594960so854422666b.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 03:06:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779444388; cv=none;
        d=google.com; s=arc-20240605;
        b=YUkggKwhUayNRzpjxP+pQy2tz9Gm/kUrfDotbYWBlNL3AtAInZJPIR4YagTp1H1QhT
         LtK6vt/8Hs77C1wjrlK+zivRLw4QOzZQdSCV/T1FijrKpBIoz04EPByBDF6xkWKUVLeb
         FEkY3KqoQkqVATotiJ9sz31HAzQM3fAooebFg2vtXIHzSFMthZORxr+Nmm60i5B8m0FH
         blZ6i9MBg+jhZ4dA55lGKwSOIl8jeO7M0FHvhomcXG4AMGXC4oHhZXlgRiqlUNLQdACR
         REzZcrONkg8puws0lH5h4Og1Kwwfu6WEH1bJPn69xPvn3wodU5roFQe1F3VBwBOFe9m3
         sqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WN1ZLeuQim+cd0ClPrYAYFvTUVyk/+NH9mbV5cz9Q0Y=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=klo8lH9NXF3jRlS1R4zHEfVOHhQ8blnwf/0p+U0px0+hqG9EUayQUUK9AWuqRsNl3Q
         V1ALmIR1NodOPzQ2CANAtIIVub28sAojFwVDdNFhELqHa79nL2jD9mb7Wce03KvIB3XJ
         9UVL2zmrGKDlkNFRPGWrHcXm4GJmVu94KQm9t5Q89IWWycHUYLGiBnXzKMODjbrs7ZnA
         xR8e9gW9RLIGSGbSD7njbEMofWKxZD6ETpw2/lndPNl/YS1QWI+Z0+KIO15Y1Z/n+yPS
         NdAwBwQweajG3PmbNNbJaIMN8jiV1cIL6p8zzqMn3+gFZrFHfSq4lH+iDPieq01hVvZG
         GhHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1779444388; x=1780049188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WN1ZLeuQim+cd0ClPrYAYFvTUVyk/+NH9mbV5cz9Q0Y=;
        b=FhrDI8YnovTV7QwgaWm7Yt9c1TD2n4KOe3+PEuZn/CmGqxW+aPFa6DtRFt/UqhQHou
         76OFFNWawd7U5Op8Uywozt1HAoJ+z/Ts+1+PTELrkL4+1jOM56TIubuR0tnTMTIiTf2I
         WXAn18uqdHHNfisee/kEPmRTkL/sylQ4QdOO6HlLtdmTr/jgctJepOjnEOsMid3y22G1
         HI20wPAPYZZeZtPnZMwujeBf9urDt80l0XvtzPADwWsv0bJ+4Li3xmcpFyilr3WoXCZy
         jqRGHXQrOmVQAO8PU2IcPQ9xwUD/b8jzgOJpIVobPCupw+PYZh952MTpMeG3+W72b87y
         +yMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444388; x=1780049188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WN1ZLeuQim+cd0ClPrYAYFvTUVyk/+NH9mbV5cz9Q0Y=;
        b=eltjbTFs8mH7tO2NlpqQVmndCqacWU0HX1EOgdelNI/G0aLIWRZnZWJYnzYR0UMNqB
         Siua8CdHCs1HPReZGm8EleLp4egmhC0Y8HKGHPTVWXI1n9P528UJD7V5xR+5HAABIEQk
         h7kofiZ7PqMnMQLMUds/dRVoafyKeZ6eb6+TtvQ+ujalAAeug3yyb0Po3D1GSbp5yBXq
         jzMws+y/bhweSfYcLR8PAcgt9THKK8vl7CY/yfintxSVgFfrxnbGDy9uodQchrCnfTyY
         NxSb4NPrjJq27/IOJMQ5uczO1GXA+d/LRH7TmlLRuiucuaBGJQhTdG7+0SqQ4HiVHWMZ
         dYMg==
X-Gm-Message-State: AOJu0YwIJU6ybA8pmDfKqrbFp8CMMeuE4IHVYqMaHb9RCR1si+xe359b
	UM8OhVBIeQmhli/5gtucJFy3SiJeOzxzRPp3rwTEyJ0xxf+dM4C3VNtmiYaezCCR2AICDt8TRtg
	ycScIJN+MuCekFwMt+O/uchbyvyjKZbLSJdh7tHLxog==
X-Gm-Gg: Acq92OE4aCKYGvQUCbQwJXarUQblK3xoipfDZrRPXIulH76pF2Gga3V8ps/Rdv0p6WQ
	W3NWaCtGk6JdwCn5E+Ir7JG8P4rWm/ycpC1jk3V+fd32aeK4wXSQORNKwkvOGmI6Ej4+jEJHjRX
	UYmkfy2r2LyTpqm8LTwEKwzsnM4Ji2fYk8UyK8gagzkyx8aFyX6LGpJWJe9VDtXKsjHoh5vB3bc
	nDqOb/mYqkq0gBUD50WFe8OpN1qjSCcKutOkg/1awj5tYcM6wsN3ygqghorMqfWe5Q1K0mD1YWI
	AOazoo1+GrL4InEwZN5a5dA+lwmNkbqGjGfovwcMz1OV9lEvf7JbNrRD0YxEs/r9Fr/6hxqPTfn
	m1nQTag==
X-Received: by 2002:a17:906:844b:b0:bd4:7b7c:a4b3 with SMTP id
 a640c23a62f3a-bdd25cee487mr140755566b.32.1779444387877; Fri, 22 May 2026
 03:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162148.390695140@linuxfoundation.org> <CAG=yYw=zUeUFxBvLhAvhbhaSv=H0qUi+CFkcN1D+Oxxw6fW58A@mail.gmail.com>
 <CAG=yYwmZExpLR5DY73s4c2iQ1cQq=7UcTWO9W2saaad_fzu1UQ@mail.gmail.com>
In-Reply-To: <CAG=yYwmZExpLR5DY73s4c2iQ1cQq=7UcTWO9W2saaad_fzu1UQ@mail.gmail.com>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 22 May 2026 15:35:51 +0530
X-Gm-Features: AVHnY4ID28TrN8CamZY6sA-EtlC_WOxEUP9oa3eKcZVeit1b0iyeIJkQr5nI08s
Message-ID: <CAG=yYwnRRf_=ivjChTxsFdFYXkV+mOURjxJB6U3mXSFTX-kPcA@mail.gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253738-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6485E5B1CA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 final test .

$grep FAILED! perf_test1.txt
  5.1: Test event parsing                                            : FAILED!
 22: Object code reading                                             : FAILED!
 96: perf sched stats tests                                          : FAILED!
113: perf stat STD output linter                                     : FAILED!
116: perf all metrics test                                           : FAILED!
122: BPF metadata collection test                                    : FAILED!
144: perftool-testsuite_report                                       : FAILED!
148: perf record tests                                               : FAILED!
159: perf script task-analyzer tests                                 : FAILED!

/jeffrin

