Return-Path: <stable+bounces-230052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DfDGEcdwmlvZgQAu9opvQ
	(envelope-from <stable+bounces-230052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 06:12:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70183022AF
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 06:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81FDC30B47A0
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 05:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1C242D70;
	Tue, 24 Mar 2026 05:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="HZQAAmQQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EF1DF261
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774328990; cv=pass; b=sanDFxyud5eALF2e8pHHaxHoPF0ofVSbrAyS6XjKPmZt+9sLHECLq95rOzlJOWCFpSqH2SsBWZMCj3OjWQWwjbyOMT9DHRPL8fWWm5pBvf/LfgjP3ij7aVmnvmyetktmDXR1hZ/DMo6gJMZckZ9k8JPMepXyN2rzrMQSUbnDk68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774328990; c=relaxed/simple;
	bh=IfqcTmHDAWE8rS1BtGDDkbjcR8fgsXNjMuHL1a4N0zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hez8IKZPuRTaXkQChBUOw+vfK2vY78Dy3s8yYUt7nMbl4JZLzj11xrquez8Z6e0dfpErik+o6sAfMxjDioKQrWIcSbcBeKi6B5BiYOHY16e+dzmp6n0Vik2rTMOXrmXvAsRkdkbdC12KWhDTNhgED46/SeYugYEl8TpH73Bd9oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=HZQAAmQQ; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9358bc9c50so137038666b.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 22:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774328987; cv=none;
        d=google.com; s=arc-20240605;
        b=cCTZIwr4bko5eF4soAsG6ZnoItqco7+D+B4ktEoJBJMc/4s7e7dYjqtaYSHd6+ngQd
         lJQFCq37vumzZy50Gs2bN4sCc0MiO/VOJh41fg1eBOPbUKeq5IJ61gRoCoWJnKQ/Pwy+
         NOZkJLjQMexyUe1dovj1kre9F4o6v7han1rivoTFfFlMY7MQg686xkU/9H5k5gXvu0HC
         kKwq0fOKu8jW1XE9SnZtB2sD6lgwMsyyFYR35xy8D47PjL6UpS916auaSvxqEjicncFW
         ppyrpltiuPVnCJmc4IJyvbwKR/LxwK8oiLkRK7n6Jn2R82zQLv8puXnL/VDLkHhmZ59i
         jCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MI3TsyI/afRVwYVxFYP2teMBdppIdDJRMOYMsQlLkN0=;
        fh=ltapmLRMzyKZTRFlV4NGQgGz2bEART/PBuc1EPz6pE8=;
        b=dj+A68XoAGi+hT6FfICx0QzvhI+sS4JF9cfyE8Abzljc5HIRmu8OkOzTiTefU0tvcn
         MDr7JE/PVxp5JMUxexbTjSZA5JcacbrJPcazVuc6X4lPEd0n10ZZ7i2qgiCkrd7fWMIL
         NLIcytsB/koERDDQVerifbBiKFg0hdYQepgHGff1etRpgPLmQc995yrbo30l4jp8j4Yw
         ly+3N3J2Hbpk7Ch7syu/7MBOsvWZ5+aB7GrxEau3Wj/0iMJdiS+saaV3v/+2Jmguf+6a
         GYaS3yv4ri5elRlGNTBsY7+skUOyvm7gJqiaMY4RHDfygviSx6BKNo78k1wpat7k11Rc
         WozA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1774328987; x=1774933787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MI3TsyI/afRVwYVxFYP2teMBdppIdDJRMOYMsQlLkN0=;
        b=HZQAAmQQNrgwWqwAHACBQBIYyk1SByUANqeIMOk8xP0Eg6c5sRewwxzQNQzhFIs1zm
         WWiFVGc24lloBP/OV4e3ur1BQiDcImlcsdGkvC7K0XVSsXgM+alxyC4fWexBOaRlA5W3
         wYB81RC2FZNKITYrA3+0qOMausGwz1k2a6m47l7p4OcIrRdCVNdFSlnRBHHnjISIayoo
         K8FUOUT+7DJu7gqwAdlozG7Mx9vnxTXCXarqNl2irgPghxPwlrnotZ42EoqBxEjgKNW1
         FwlPwq7ukvmQV9kuNWiQfzbYCdqpfT1vAPSm3XuRBE59EEHhC+dgKrRDqEAJQoXkARi7
         sgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774328987; x=1774933787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI3TsyI/afRVwYVxFYP2teMBdppIdDJRMOYMsQlLkN0=;
        b=PXF5LF03hAgSrpRiqIAYc7BObSeVPZOYptu8aEqIn18ORGVqUSkOuBFBwObYDoPXNA
         ArTLGh3A0xcFWw7Ry0CpTMWtDmWBT2ZdJTNzyqXEQuXgAjfOdSVypZk8rXnueuh1769n
         TMFt5bHBWB62qDibx4MGXXqocCAmi/z7SahP7Hyh5lyz8dm9y7zAZPhVmtarH57Gx8kt
         XLnCnfUf9UFi2IPcUsJLWH3MdA3OI8GMPjY38xIWLkj250QxH/Aj4unC9qVkSp7SflMm
         xZ1ZP0eCQAIPyIKXBa0tgqzTFzdy9udaMcyyZIVj6Y9fa2PMAZ4hd4nat0Ha62Y0CJAz
         W3Nw==
X-Gm-Message-State: AOJu0YwOnMSp4ZdiKyF6VsqFY0vNxI3sjpXBZEwaWvTqjRSHVtrwc/8H
	OvCmKyzIRdNcb40AGLEIquKcvQ/hhjkJPJ3dDQAXmF6zzfDTeOtwN+KdP1VxtWGhAIGaHBvJibd
	w5L3aDNR4kIvVMnONJxSqxuQLK4bZT82M37+R8I2WSg==
X-Gm-Gg: ATEYQzz3G77LB+JMqpjZhGuR4jfk6jrxMEA6wQ/Vy+cFdRgFa63E2FRGkoaUuSJBxbl
	t0hkw7UX52APICjfQaSDbm792vaBESGHxDERj38O3eJUpbEZxfqzTlZTIcYlDuhnoRwSbBEdGqG
	C4kswxrGLs68D8uT+liv77OGvrg5cj8HbKRBs+4bplLrO4tlk39IgbqOf5Ux5juVYckvsEOYcM5
	bTILmb4w/Qj8TsZqaQJ35Koa4zZugbLIG+dFAD2wpUdFHh0xZ22quMbPhzTMPwjSEa7u8It3Vlb
	Dj3rsuXgIrMGB9c34w4cCi+jplQqSTeRheu070d6jcMxNRrLDPayxhYo3bwJHZ3ywkQXbgo=
X-Received: by 2002:a17:907:3e1e:b0:b98:57ab:3c44 with SMTP id
 a640c23a62f3a-b9857ab3fa7mr543257366b.7.1774328987437; Mon, 23 Mar 2026
 22:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323134503.770111826@linuxfoundation.org>
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Tue, 24 Mar 2026 10:39:10 +0530
X-Gm-Features: AaiRm51ycle4Dlzbyh1AtKW1eSsjfY-4H5rWphYFfb47-MTxxAPUDLCeC905FS8
Message-ID: <CAG=yYwmCMf3konCjMAL2rE6-q=CHHLtouV7C5aDPHnpKqKLUkw@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	lkml <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Shuah Khan <shuah@kernel.org>, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Slade Watkins <sr@sladewatkins.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230052-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rajagiritech.edu.in:email,rajagiritech-edu-in.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B70183022AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hello,

 Compiled and booted  6.18.20-rc1+
No new typical dmesg regressions
.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology-

