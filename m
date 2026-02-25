Return-Path: <stable+bounces-219720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA+AByJzn2llcAQAu9opvQ
	(envelope-from <stable+bounces-219720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:09:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 395F119E2A0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0123011F12
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B50826FA77;
	Wed, 25 Feb 2026 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Pw3e922t"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30BE4315F
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772057353; cv=none; b=CeP8IAKtqaMbgaS7FfvSo1Bg95TQcvgF5xFvqWe3RvqtnZdsTdCqwP02bAqB1iJh0Q6/XAQ9ilZsL7rk0gA3iaDzsqzUfQSj17za6JQMuw2sgiawRBE9pD5fO92EGd4tR6YA54BxwtYI8JHAH1Z9y3UFb8nRKQ8S97qszw1QDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772057353; c=relaxed/simple;
	bh=N5lPeBLKGbKQWMabsoM/JPAxUBL569P1GsdOUpDyp/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKltlGtBRhAblgOEFHU0Sl9Z6S/rzE4Y/xWJvFAZ2Ihc+rK3klkvRfvoXV+psJLXqxK8/rPFIo80vBoPyqu53W3JfIp2BErpEQMRa8eGf7YdTebeRvN6bOCi5luTmGcz2S80qnaaxNyBqOtN+p3lR1q+W3DearzsP6lEQYcJ+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Pw3e922t; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b6b0500e06so211357eec.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1772057351; x=1772662151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ds0gipBRoW/ThY/jgKHJB5YMw8DYTRgz2R2rwxq8d60=;
        b=Pw3e922tZRHBDCeKkJIsdQex8seGLG3nmUc+9gvrfWh1OY0lVqGf/mk3eLCKxmSgMD
         nXYUGn4FowuSik07592pS9JisFtl5bXRV3BFducQINxfrO4+/VXHeWhcVNsDhcnuwdXQ
         PF3ROhcyO5OgzupBGOABXRtvPAwUo8xpN/ir0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772057351; x=1772662151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ds0gipBRoW/ThY/jgKHJB5YMw8DYTRgz2R2rwxq8d60=;
        b=XhcTncyPRL9pPyk27yXXM4YmWt0/9aKqCNCb9tmkBPYlmL6OWzzwpC7KrHNhaJOUKQ
         ZtqdupizEQPF4Qsab/CeGxzUHyoHGeoeAZlCFYZS5M9aY5an37jtAHJ2t1RmorLYi2fT
         iKRg7Tro3KuDR4XRD/jc2bWezMBjY9EDswMgZZO4tFvmWyjl3KW7oLGW32ZhB8VZJYvl
         hO5ohmz3yRhSCKR4vr5AdgsaPWF/m6++Mg7mPXKLOmFVt0jCQ3OOiU21ZUCdwJEjX5kI
         OJA2qZZ/xkQ46F1KGW7PmWOfognyQpXFf+mL9OfNOkCQF/v8YmytwQ9r64X+K5hdWq8u
         wY9A==
X-Gm-Message-State: AOJu0Ywlx83aWNYgcE5MkqLpEj0PPLMEIUOMeUooBKlpok17MYrU5vzK
	rSFyjVT0FieSfZrBC48dvsuoqL2XBf938hYNlBtSYdLnvUwfgxPBybBAhsrK5li3nQ==
X-Gm-Gg: ATEYQzwTrWl53W3IwycItLan3FiYZzdetrlsaZEh+crdksyn/AwoN+/FGSGnk/34ezC
	F02jqlP+hMJS+o8Dv3y5Lw7Mbd3tu1wVgjKOcq8CifDkropa++HioYis9jBwy/nrBoJnGZXHXk9
	tfE1KGC7/PyN5NrJAiMK29R9ggyBjEjMkdcAmYU5eYBvLm+G+707wzWZu+XWVwfP8sD5Q7kpOwC
	bBFJ7e61RqHyugJhAuv1zLC6DRpdbkf3wIxPFPmsu51VhC7uqIsYk7KI9hKYwnTUdog6WutkYXF
	x+5mRmAEMLga1Rpx6VLq0vLIbP3thCGFyF79t4HvCvq2+2gjvyCOBPepKOilxcLR3M2rDR3tOcj
	5+m6IGK/UpPQtDjUBfbHUI0DX59GuRZuEQbKKDRTLjskIrGI1vPCktbqXffPBwrsayVrdka9zHg
	iWnhc7AVUdVzMwLVF/2BWrlKjEePz5GCnrvCM7Xh+9oFzjQzf5tfn/vdo=
X-Received: by 2002:a05:7300:190a:b0:2ba:7617:eeb1 with SMTP id 5a478bee46e88-2bd7bafb2bdmr6639953eec.12.1772057350581;
        Wed, 25 Feb 2026 14:09:10 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1f23c01sm268892eec.16.2026.02.25.14.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:09:10 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 25 Feb 2026 15:09:07 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/641] 6.18.14-rc2 review
Message-ID: <aZ9zA7wkXn86cj8m@fedora64.linuxtx.org>
References: <20260225151847.709818960@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225151847.709818960@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219720-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtx.org:dkim]
X-Rspamd-Queue-Id: 395F119E2A0
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 07:51:50AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.14 release.
> There are 641 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Feb 2026 15:17:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.14-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

