Return-Path: <stable+bounces-222734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEYbMQEVpmnlJgAAu9opvQ
	(envelope-from <stable+bounces-222734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:53:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D359D1E5F64
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FB17301DD22
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0043101A8;
	Mon,  2 Mar 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="F2kxvZ2M"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537B1DE3B7
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489755; cv=none; b=SFZLQojiUcvQgBeu1LN2ReBdsh7aS+tfqKmPPucqvJi0V8vGk3M8MuXbitQWlvyQt3dBeoaBjhesdHPTBFwbRureTGeIWqqgYVA1jM8EhiCHox4uE7+RMuOz1TIyBRADFbIO8tRTaxjRbyeED+0FIuoBz0/PGuC5e3X5OGQJFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489755; c=relaxed/simple;
	bh=3PWGNQWyNk/t7DuU6EFalPDiWOaZR6qb0ZgKj5rQyP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSC4glCIa0lMyMbFRahat1cDxwdfwwXk7lacvdUUXnHDYkeLhCDfu3O+vME3lhIn+pKSjnRECFaPTWI2IBlfN6QucAc+9m20fdBcePLYqDiAg0bYcYAmyDyYeKz6SskiSyTfqaIUoIJAd/c4hIPD6TweeBO1uSNwByY2nQg3io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=F2kxvZ2M; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1275750cf9cso3987725c88.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 14:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1772489754; x=1773094554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztIYWooLOO1cwWd3Kc3iHmLMLIi+yIAsGLzg2kuGjrw=;
        b=F2kxvZ2M0YuGbNxWeLB+3pf/wqYPXqQF5++L5WS6aznEBYZTMtlnpryXNXItqVgD2l
         wdL2r8ME9TanDtRR7LV2jeS3DbimOxOk+V/c5kSb/NtnTL6XxM/7QMCE75ZcmE0/3gS6
         l5WwQCfNcV7Ssvd5mPL+TAuswJW/YI/KISPLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489754; x=1773094554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ztIYWooLOO1cwWd3Kc3iHmLMLIi+yIAsGLzg2kuGjrw=;
        b=lN4Q5xGyhqZMpQgoM52cOFMGc32qfDJYcOkZr4QUWdWXRhMJZF++I5i/RGfMkw79JN
         0ylc9zTON6q4gsiQLF4yG5aE5c2QE87MRs9JXumtgoJ9Nsvyods7498QKbsXQgfR0m5P
         Pmyt67inNDFA4520o6gVwoN5OzRmYERJsM+87HwiwNaoMgXOxNtWiood5ddK/PU1I6gw
         xpmcTjhTlSlK9aqGwCoSEmlUMK6SJLA2p6pxgEOaWxiWxHzF+r/n5faTBkPTbKBiicYc
         h/AMkLEr/XFidsQP+PHt3tR0WvgHeK3qTRqp1YbaNW2brTrxlJbQKpoaEw/V0NnwpZTi
         3x/g==
X-Forwarded-Encrypted: i=1; AJvYcCV7ceJSxcweqUBgrPRo/teXl6vPMOcmghULuVj/1etatHklwKnCVdAhDB6GCmApgD+7a+mq1Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+4hbzXkJ7E7pmVfHUYumUXlquOuXnqWFInIAQA5kLKEIBS/M
	WCUczPRVAilghC/gJDSI+/E2K8UEMZB1z6WhaE+78oc+68gM6w8/7Mf76gQeoTGiEQ==
X-Gm-Gg: ATEYQzw6HZw4lgzqtKCHHP0pTYdDVAkrRpinbA2pRMsrOW4CJCVINnM/nK0+TUjLdd5
	MBeoSJumHSz0NrXgEQVimUffCszpjQqlWnSvEW03AINxtGYvovuB5VSjk6AcT0rnqfpfyiv+W7n
	I8SXfu9Mxh2SXvIAi0720QILpaIvNobb6q4I5bEdsJO++M1FQWi9XQdeAKvbXBhqAcpuZaa65Xp
	TFB/IpN3AP98iP97VT6VzDvFS2wSFhnIhnAPk83LsJMNerlGADjJNbu0SJxN93DW3IO+p8y2YUW
	O3yndcKeujSOrQ5VeQ5yXaqp0n5GrO8H1IO78G04OkHBi2nEIXcWYNurQTmqyU/WEm8OgeTCcOF
	gSOnSiGB6BEbWNRno4UVrTK26wuhXvkvnsWQnbwnmk8iUbywTwozUSm+Z2vhxiXmw8Mlwzj+LIo
	9Gn/8V09N/JajSidmseBEi1s5xUCFmN7YXl6/8+yuJI5VIOS7BK0auEiU=
X-Received: by 2002:a05:7022:4591:b0:123:3488:89a3 with SMTP id a92af1059eb24-1278fc24c3amr4689181c88.24.1772489753735;
        Mon, 02 Mar 2026 14:15:53 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.124.134])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43a18sm19182815c88.13.2026.03.02.14.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 14:15:53 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 2 Mar 2026 15:15:50 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/850] 6.19.6-rc2 review
Message-ID: <aaYMFrii2n0ZhkeR@fedora64.linuxtx.org>
References: <20260302160834.2518716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160834.2518716-1-sashal@kernel.org>
X-Rspamd-Queue-Id: D359D1E5F64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222734-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fedoraproject.org:email,linuxtx.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:08:34AM -0500, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 850 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:07:42 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.19.y&id2=v6.19.5
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

