Return-Path: <stable+bounces-227125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEHNFFbYumkycgIAu9opvQ
	(envelope-from <stable+bounces-227125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:52:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1722BFAB4
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A65E530C10FC
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB2345734;
	Wed, 18 Mar 2026 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="fSqkVT1F"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB333F384
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851517; cv=none; b=mw3SlGBoco2tBWQsW7clUMjlClTwKJ1pIoE8N67MYASnf9K4S2GjoH5SsN2hQEqSXUPrK4p6SWeJSVJa4d2Q5ZU0qvl7KkiwgJYjWw1RewaWhWG3oSoW6x5FBdsO20fejVsP3wYhWlKf6O0IgJTj+qu+rlpfYnv9mvvsAJFtW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851517; c=relaxed/simple;
	bh=UpLXNDCkHulKeE+atXxIvdN4wuosQRXb0v+s/5Tsa1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJdR151u6co+ea7iCnp15VeQh1ajarRrEC+a/C1GQCdcMBSpZ27H18BrwucISorGs31esMAqZQXFI3XTVrX5PGK8Dy1LsNWcrsH53/gXhnow+HWI7oQOhCk4fMf6sDNZ22U00mcX+b60oNI0yvmlyoWQaMA+VXGJziDcS2geK1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=fSqkVT1F; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4b77adso57726c88.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1773851511; x=1774456311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jicqe9EjF0wYf3WWl0C6UzpQQmvQ1pA9LCcV5nPnMQ=;
        b=fSqkVT1FI7oCAzH7duhCkLXKsY1ARjB5K6vNbddi9VtsBQiUZkl6xdEkMPQ+7lW+Cj
         U4dGQmPQRPbOAItAu6slHTmnvxyucNROyRRO3tMs1sgUSfvX9Gu2QERkUzAGry29tI2k
         KlX+F/btYjn6V/yfp7PGV+SKQwnZ8WopWqeRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851511; x=1774456311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jicqe9EjF0wYf3WWl0C6UzpQQmvQ1pA9LCcV5nPnMQ=;
        b=JspqpUwsJU8cmxuR4pYFWohXNyGW9DPltha+5BexxUe63yCVqJFEsaMaZePfVgxX2d
         uwCUmHvjKvw9KNpIsASF3CEOmCEqj1czASCLA3ajYiCVMhaiFot6VuX09+1w48ch2+wi
         ePAhySmPBh2Vm0CUhYYQ9ahE6//nKBuF7kya3nnzTxzM4X+Vf0AZUthQQbR2G/5DkYbd
         UVP4vPiXT2KcxQcf5CzeD/LFh6kbvQLcCEQYLV+sEaL8ZyfqFz4EJNgiLV4P0VrEL30X
         YvocGR8t5qEpw5/UOjk8M01jfAm3pNs6XQ/QotFqfK7qdcxQ5A8qqDOIsbduu8k9HH6p
         /Z3w==
X-Gm-Message-State: AOJu0Yx7TWwmTQQ3RnYfu/A7ldDiIgSDYuFJKYj6+PDebYTEluiu8DtM
	ECLdixm1Fx9oTcvSI9zt0rmgs2Mq3cjV4QYsQ+NYciGAlMEdQGxO+BBn8/g7PvIzog==
X-Gm-Gg: ATEYQzzjqohHMwUbiDJQ+/t/9E6coArb4fc7RoK2/7IYxRfW9yOjti7S9+U1+VVHAO5
	Dw4ikB41kCUt9PrK37cmnc3ZSrF62rxEAIv27PVQrqGVV/PP0QrH0zkyJsUzcAh+HtYH759sOnb
	RN1KFL+GBb/kyz/YbUaJjHTF1bmiAiwwYEbTLiOLbrBNjMBpec5pClldM1qVGD2wOgBe7fBxC+k
	xc67Gd6iTT92x9o/I440Jjb14ehXSlM2A4VEKJZZ/ovaUQzDPXMTD/w0jmm1bUfhmytgT1KClrW
	fGwVxnI+wCnN1jsx8KGtyd/LuTkOzObPupV8W0J1LS14ITEBqi367/Onao11bDo/42AjxMmVMX4
	c/YAPO74kw0aiyy850Y2oDdKgWZ8FAaEsAdh+zSp9skctPHSRtboEqMmDRckNgo4HlYHDX/yl1Z
	c4pZrHbwFOwzNC577qslHw3MxBIV8POYuHs/b5Pe/AqAPhyM/U39S+lMI=
X-Received: by 2002:a05:7022:309:b0:119:e56c:18ab with SMTP id a92af1059eb24-129a7146ee4mr1809003c88.19.1773851511406;
        Wed, 18 Mar 2026 09:31:51 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.125.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129a723e246sm3891956c88.3.2026.03.18.09.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:31:50 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 18 Mar 2026 10:31:48 -0600
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
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
Message-ID: <abrTdL3xp2sqUJWh@fedora64.linuxtx.org>
References: <20260318122547.233850204@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318122547.233850204@linuxfoundation.org>
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227125-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.957];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxtx.org:dkim,fedora64.linuxtx.org:mid]
X-Rspamd-Queue-Id: BF1722BFAB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 01:28:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Mar 2026 12:24:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

