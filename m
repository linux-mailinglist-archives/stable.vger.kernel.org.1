Return-Path: <stable+bounces-222733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJZjC+sLpmkJJgAAu9opvQ
	(envelope-from <stable+bounces-222733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:15:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE411E5154
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1356B301980D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 22:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BD631E823;
	Mon,  2 Mar 2026 22:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="IPFZb4Tg"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886E31A06C
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489700; cv=none; b=lswnOlntX4yPYSeL67nQgT3BCsybnuz2Duu5CZC9Nq8li4GOh0nAXXl9t4JEzS+e5HZta0bFVmjEupEpPWHhm0lolfPdNevitEY7OEFY9TXVlChHvmZdgoPhU76PzVE6zGmUy7dF5xSQy+j2T1ZK0Hf87CI7iP7rqilCrx1Gx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489700; c=relaxed/simple;
	bh=7tUyLlF5oSfxEFoTpeVKj6AEeiuw6YGNR5YAq2t1Tm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNRbzZuiGmfz8Sat4w2O1CUKCJ5g591jShxjvbK7GiRxLy8UwMOSRRgnDMw05ulsgtxrVeCG+fWXmvdFr8F+nFq7lefYY6EIXqHvJtyfLa7fNnyb5Gqw6AwC6oH+1vZHnbswm3yuZNL2ZMUVqMyQauiIrlfjpEfVEFhfzuzHg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=IPFZb4Tg; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso4679613eec.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 14:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1772489698; x=1773094498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXt41I/9ZWGWF2H15Qu2+W0y8hiMFnOM4RdPPak0JGs=;
        b=IPFZb4TgrzKpQJmj1imJsIq+SCd0b+pXJpn3UGac8uZsdEl/fmyxiE9+YXLp3Gr+qU
         xgVhhcb6UhcEPRcdV8vT7QX5gUMhPCUtkxDhnJt3/a26JWw8CoSphQCEKLIJe6cacfZr
         Q7riYA/g7K9LkOlqV1Q2SK/LxzLUGwyGyL6Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489698; x=1773094498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jXt41I/9ZWGWF2H15Qu2+W0y8hiMFnOM4RdPPak0JGs=;
        b=taWnOiSidy1sR+OkCi5pRAlxf3BC2cu2/Q/zvdY7cXFe3jY6uH5pybd03mkPFjg8O/
         uoqyM8Xt+eT7Uu1Z4aTnUQAtzeY6tLkwZeN0Qi2PxrwTZIbUVrLwwXzK93eJFI4YlVHU
         NErYOtMHmp6xI+Uv97vle4RFZOKts97Cw8Dyf7aHf81vEZWQpS5g1aWxuq66Yv+AwjJd
         PWNfOliKBtm6YWg3xi8r46cTaTf7OP+MoP6fv8CZEPEN+TZGf1ItuOS42ACKV0f6cjbH
         Ze8Prl1unoS3nxlT1DETZdnEQFeZdigtIFVEfihLU6CBD95gJEx6tQ4+7ELscTRt+wtx
         hrIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8XRWPhrvsOBo5W63ahVZ5s0pynnZTLLRI3fRJZCPJ52SYcBPpuDhb6XliEjU9kNy76q0ExwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHy78zQ/gF8xGjMtA2DuLap9+EELLag7IUl7BqdhUMDZs8ywrM
	8UtMqFejge/bnyK8Se8zHFtYIxhM/a4Lr+S++K984FTbgoCiLFNHd7e53S7dLQlutPtd7ro5/nu
	3gfiNaA==
X-Gm-Gg: ATEYQzwK42qQy6XOtCfkumSgNIeLmAL59YOmd8Q+zL9J/UwYwvg7PFZ+l1st97aNbdv
	Q+QZP4b9GlO4nV546cwQZ96Vgqp1Z1hFIduzEzN89jMQYQcdzQLF5mmd5g60NN/l0pqT5NRUzL1
	9VLg8QwmUH5yigrNx4u7PJG2byE2KjnrW3zqvzw+jhfnb725fFBsiewEKajSeIkYu3tnYMLX8jv
	uPHJTusThh6kHUUiKMswE1HC2mUNsXElITGNwIMtleR0HCLeaMvTkKvXNv+IpqQHeZgqb4XjJyH
	sp8zoq7rBeEVFkh6GXujb3Ot0l+nPl+2FLZm8ptCl7ueibuuwfi9W59UAhxZwSpN09iz8BVMJWh
	p16dgEnf1shU+pC4j7CKC1XpQm7ubgJ0TPci3W+kH9DvBqrCqJSgKxOJinUdCOJdl102kwWrmE1
	kgmU98B2kZqe4v7QQq+0qzVbJq9Spaw7OH0wFBBFuiBvvE
X-Received: by 2002:a05:7301:9f06:b0:2be:171c:5048 with SMTP id 5a478bee46e88-2be171c53cemr1383663eec.5.1772489697595;
        Mon, 02 Mar 2026 14:14:57 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.124.134])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfb3f898asm6594316eec.29.2026.03.02.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 14:14:56 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 2 Mar 2026 15:14:54 -0700
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
Subject: Re: [PATCH 6.18 000/757] 6.18.16-rc2 review
Message-ID: <aaYL3gXI4Czb_Q9I@fedora64.linuxtx.org>
References: <20260302160853.2519610-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160853.2519610-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 0CE411E5154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222733-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fedora64.linuxtx.org:mid,fedoraproject.org:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:08:53AM -0500, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 757 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:08:47 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.18.y&id2=v6.18.15
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

