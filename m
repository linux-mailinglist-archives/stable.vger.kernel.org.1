Return-Path: <stable+bounces-216282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NUsNkxhj2nNQgEAu9opvQ
	(envelope-from <stable+bounces-216282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:37:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716B138B13
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BE930333EB
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298FF29AAFA;
	Fri, 13 Feb 2026 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="bBvo43nD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FC21B9DA
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004234; cv=none; b=GAd/qEuGbmoxNcScs3zlwZGNptPvNR862WbMheJhdOMJob6/4n12LkCRPybNUBlj0c3FOc+p3OuPnhK5KMjRWJ9c3lbTKh8HghqenDKpbUnnUVFJeA7F2zb4S/8O0KunaEWDQgkcvZgCuKem+XqanzpH0Kuj5wvjaPEx3xtB55g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004234; c=relaxed/simple;
	bh=29R73EPL9UxPf6QtRUZQnTDpijjv7dxLQiuY82OYvRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlWBhK9AX0Np5Fo31jXVQj2Ckrk0nu/1+BR4BMm1ePZRQJHP6eKU0qU4pfq1giV8euvcKPenrI9sMAlSia5clMsGBSe/pZ9aRqPgiW1HG8SW4Z3/X6xeNZAbfa63mnUwtUC8EBFpCObvuuo2nFvLNEmZWgjehJY3zx9UaSoOx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=bBvo43nD; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124899ee9d3so877675c88.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 09:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1771004231; x=1771609031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eqgz2Q/jJ4BE8Uft+zH7hFPyXLLC6CuA0yc8o+gfno4=;
        b=bBvo43nDpYu8zNGrqPQgY2W5vFmDOoaCCvPDyWFJ+vKYpZuQ8qDgGcpguFQ8FzTOPz
         sGZC9Yc5cnduL/icvWEIwPMoAUATau1nhZOj2ajwPRZDqIueBEz/5PLGCCqt0mQYD5xV
         It3a4mq/9EFJmiAH9QkX4iHuPXyWuw/ep8zjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771004231; x=1771609031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eqgz2Q/jJ4BE8Uft+zH7hFPyXLLC6CuA0yc8o+gfno4=;
        b=CVqh0QVkGW06ItWS5yfUYnhC3cveciNa7aeLV1BuzeGJjLuXeKlindqcVA0x8fLLpm
         b65h2o+DmN0DetGW6e6zVQ7Kwagc99Bf+dd1RGNkRGAolb8MNYz4Z+zOsRr/XLVmdCQ+
         hpTcK1iHqRCjhMzCasv4MrlCqn1RPVt55VDNPoAxSVtoCF5AFutVeI//7SA4G3cty/rw
         yfFApW2qRHSiRlNro1SRmooS05snwXdzIyG5gPCp3vDv76RDuLRzeWS3qjtWzmjHs5ib
         7Bk7xpX5dHVbmq9ph7kytholB4peEHCiitjUAtNWHvSExPVVzKoE8MUuIEd9jOxPki9l
         9hFA==
X-Gm-Message-State: AOJu0YwzeTURLmxajdMFvlgqKF8NZp0s5Py3GrkH/vI3ctAmAG9RWBOP
	Rhe8odFQER12cNS9c6ZcFxG77hHcrJgEvIAds2cp3VeBswRRsjj9XvYa3EAOpl4v3A==
X-Gm-Gg: AZuq6aJGrkvWz2iHYNpXuxpjJ9RuPOPb+C+kEQIrKzSyfYUiYL93tnoDVGjZ3EjmPb2
	0qLTjdWmmVLM5AJlqSjbJjBu8ui87v7f9drfprLK/HkPjz7WMeSbYrZnS/7ERTz5Lt7O8mXLT6/
	EXzPuOLuL+A9OvhzpOqG9UuOwI+l+OvUugkIiAVlm4gvLcfAM7oyG8TpRKBUylsPm7dvmReZjtl
	VW8CIPm1whKSztsgKFFcWhWQwCCcsWq6W0znrICjc/zuZZqHcxBrUNVztAHLcO1FKjv88tFTfQo
	iBEfTe1VKh8ETAB/9OyaeLtcZgymNASS1JXDQN4amL1Zkt5QX7r3Y9d8pNcuk/QvKbleXDsPBEp
	EHYmAJnv4v9t1l/3Tm4oF4FTON8yrvUBSVhpWJ9u87/e8o+Djg3e/xQXM1yJ6ts7s/Sz3WPGdfV
	+xtccJF3nBv6Dayij6OGob6G6ITqj4irwoXOp+AkvTqLSD
X-Received: by 2002:a05:7022:f93:b0:119:e569:f86a with SMTP id a92af1059eb24-12740fce8b7mr343293c88.7.1771004231310;
        Fri, 13 Feb 2026 09:37:11 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.125.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a69cc93sm8392269c88.6.2026.02.13.09.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 09:37:10 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 13 Feb 2026 10:37:07 -0700
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
Subject: Re: [PATCH 6.18 00/49] 6.18.11-rc1 review
Message-ID: <aY9hQzFyYGXgynl4@fedora64.linuxtx.org>
References: <20260213134708.885500854@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216282-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jforbes@fedoraproject.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxtx.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5716B138B13
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 02:47:44PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.11 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

