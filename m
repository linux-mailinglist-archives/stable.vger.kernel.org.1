Return-Path: <stable+bounces-241181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG6ICTdX7mnDsQAAu9opvQ
	(envelope-from <stable+bounces-241181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 20:19:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84F46ABD1
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 20:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D456D3001D6B
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1570282F13;
	Sun, 26 Apr 2026 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="RGabpgy4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2375E27AC57
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777227570; cv=none; b=VKQAAmg7UjrJwrh42cXjK33MgDnkjVQ/x0ONjI+langUhzLqg1ZHHIwvmcd3+MbrMVXatv1LeP/fCHwuLVkpdICXUNfy6ASJaCe8nlL/PXqD0vgIbWDqdIqPLalkhEuMEYOmlwW3aYfssVK1LMqHRghNJpePvKYLhUI3mD/D7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777227570; c=relaxed/simple;
	bh=Sufa3AUzBRL5ViOeMSGiGywtB+U9gCgOODKUTnVXF6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbgwZcfUIUXWGHvXZpPJw0d7cog5Zu2ib9xAZt6RQcPCoxSPAqjOSmXoEg+EZ699bev0Es+6afRGfbnb8jPkQ8FKt8e0j/ySTjWkPFxgtCIWraJ5A7CRbVtkEildW5z6Plt6WrqbyAideRiVsJpG/QVyIpTv9W3AwYUjlgCSraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=RGabpgy4; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c15849aa2cso12435861eec.0
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1777227567; x=1777832367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6AlhQMcEATZrtdBECRZUj5Ab+JdiBi4ef57n1ZohOw=;
        b=RGabpgy4yFUr4V4b/b0V6ArJwEz9xl+QpM/S7h8j22inE8XhAqYnwbIxMG5+QwTZoa
         8d+my7ngYAeuhazpj4w9TWJSQJEC0RU1iWUtBAHX5n1tFACVWc26C6IeCOyIHBiq4zpj
         /toJ9nRr6Jj8lQFxW3+neYq4bIV6uQX8QCrMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777227567; x=1777832367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d6AlhQMcEATZrtdBECRZUj5Ab+JdiBi4ef57n1ZohOw=;
        b=qXXq1ug7ztGE3HOZGwIOognbasPnlkfBO48torRmgEVhcJ665aghDB6LAPzWUL9HHc
         +wqQH/GDTQND7JXnGzE+SHpNshOADfHYjfsOMG6L5izxIFvSQIQbomnF5tJLP5iwxUHL
         BzeHT9/J0mEBcS4lchOOHFjYCC/BFx/qKlEg3gacubbkANn/AvFhe95zpvbV/EZsZs/V
         /nMrH6xCodyobmR9VJAB6fFalZqjVLWEK1eYEaZiu/T6zCAfFOejYMJCyilpUOTl1idl
         yEOV/lWt4VKALmCjaS9g+qaY4HkwRcgM1FJ/Hx7AQKybCcq1PJZePSI6ZpZKdjf5NVan
         ezlw==
X-Gm-Message-State: AOJu0YzB/svdSpuuFyiJrH1oqiQyizfcN8Ge1SEDur65tlWdoeukleXh
	JZlO3078sTkASmVAqTTDAcfAq+NLQOYYXFnaO+JrIq6E9nPEcaN5ZMEsKPFURpNTYA==
X-Gm-Gg: AeBDiet0MS36ouunKX0DgO1MUT17/U/+K0lhnwPixJbpOWJUEu/IKLJY9kM9/KJXW/R
	9AzzuPziZonHxyxLNTVCISlDo1QY0XQOnUGMkg75bz+UKnSya6xtO6RowtpYb7sz/NlEHGfYHmN
	uoTsViAAsi0/pfKxsJ9W/u4lbRSswD9hDX2r1I8UgNRn2H/4x7Qj1OP0K6MRQ0lfP+sMwHtESGC
	jI/Hj/7N8T2M8aBsHnwyZN/9zF6qVt+3hHaczmTg+23CHjnqb9Tsn0g3DbcSdQ1bSj2Uy3ZSsqk
	ydk4yB3JCuQ/HRlZ+wC6DzVAXdGWJgFYdXew/2NHkZErRR+hb9UJ0Q2MRG/DHDpa3A84+kwCRYt
	No4TvbLTHbpweVKJm9UG3W1d3P4gOo1wZD6SlB1LE2h1AO8OT3vIOMW/az39K0EpfHTQzkuWS7B
	mKu8/fEyAHfnRQee6eQlE8UNaTh6DAgAWAs7Vm5OldLMRqrXqaZKL8
X-Received: by 2002:a05:693c:3007:b0:2ea:5057:a2f9 with SMTP id 5a478bee46e88-2ea5057b737mr12408219eec.16.1777227567098;
        Sun, 26 Apr 2026 11:19:27 -0700 (PDT)
Received: from fedora64.linuxtx.org ([98.97.107.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa6134sm42213114eec.3.2026.04.26.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 11:19:26 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Sun, 26 Apr 2026 12:19:23 -0600
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
Subject: Re: [PATCH 7.0 00/42] 7.0.2-rc1 review
Message-ID: <ae5XK38U30GOx1U7@fedora64.linuxtx.org>
References: <20260424132420.410310336@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
X-Rspamd-Queue-Id: 9A84F46ABD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241181-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 03:30:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.2 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

