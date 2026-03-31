Return-Path: <stable+bounces-232584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SISCEOlCzGm+RgYAu9opvQ
	(envelope-from <stable+bounces-232584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:55:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B206D3723CB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA43030B140C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634704657DD;
	Tue, 31 Mar 2026 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="fg/Xy0LL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DC372685
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993966; cv=none; b=bfiQ4bu3VYdsSs244KiIlgtswqzlfmcl4aejmln2AOM4kizgwoTwx5ETejiA8OVRNvHIug07rq6q5PKPnNR0LyELxuqfH/SVsJXoBTFevcOKtvWv4i9nz9NYBEEM1MwEo4I1NQoeT6vBmjhB2fou+mA6PfjTTW359pvOH/ASgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993966; c=relaxed/simple;
	bh=y10E6H4r7pQB73J7o1hu6oOKr0ve6Q859QkrRIrAwyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhqODLFkE4sHXeO1Je2kBFZ3+Vj4ZmHN2lrhmsOm+MiQH3AtMZzbvUm8LCWcBm18nO6QyEjemgB03he7xIG22ihvH/bKtW5+H6YZVxC4i6YFz8jdlzfjphZAkU/uHiXSes69G8iWrk9OgFZKBQgpGidWA1bfQ64a17c8mg8iQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=fg/Xy0LL; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12a693cdf29so346288c88.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1774993962; x=1775598762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+nCOzje0Y3eH3B+Z95VyombtuPnwAQxZrx27WvHq8=;
        b=fg/Xy0LLVpOFftoWu/Jhwp/7iITCOWM2ymB9aTDvUl5OL/KXYT4yVu3X96w7VoSwO5
         /vENuu4voHkXI+1j8mTKY1+uj9iclCcfBmlz4mlAKBa/1HcGCPs33b0o7HC25/TX6dJK
         ehWUoV0deLCkRcC+JQvVG853ZXIzB9eBvcouw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774993962; x=1775598762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pr+nCOzje0Y3eH3B+Z95VyombtuPnwAQxZrx27WvHq8=;
        b=pKIHqdWoeDaU8IvG/IeTBBTvToWDXtUc5VCeDAXsp8+zrYn0uDIPp5pbvNW18nr809
         hLplj0HTHM+AuoR7Os97+Cj8pBQnR5LMUZOxyYpzEMmGiX3XiTvSZnkHTbKFDsDyvGWK
         Rb63CU41Pjl9s2H0KjY7Lxmgcq8TS8RM6mTiUNfiIN5kQTzoJyFA3AoapLnO8rS3zFhp
         YFc3bP4FDIc1gQfsbpYKIqg8QwdV0r9XBLl0tfddl4hBEhWzXaAia+sNngDBtrD9EkFV
         uK3TCjbwc/2nkHMLx777xaQB9I52ZnpExvyIslZgNPAwFz1PQMwb5menqG/OGX2mbgRc
         qvwQ==
X-Gm-Message-State: AOJu0YxVfj3zZmrjIwFnmVOZPiBYYaVB5NMqFWZyGEGNDZJpSWrUeNXM
	I2HsfC+3qbie1hm8dEhEJ3gP4MFXuWMf8odd9YuLuO8fMiwOQXHVxCyeyWeZ31kVVA==
X-Gm-Gg: ATEYQzzrURxszxF2OH+4EqVnR9DWynKYFZLUpuaRhsmxRW9sVRSRi4M+Dmgf2goLH7n
	F5YHm0Nz9UgH9PCoTxTdjDsv0W/XV4npUp5MWmgl4pYlw7ByzOMGnIBUSveO/rM5r9koGpJ8T9C
	aXLBIQm4wFQ0MantaYZvirDKXRTrE9t2wE3O8edVDcMcffYLUvn4gqMrovPNFG6NVHpUDsrs15o
	Ub0xkL+Fv0e4VvzBO1qgvFO8Fr70dnQmK3IoPLnfjzDpql/rVLPHIfSiImR2uwegwvDcdcQa343
	lji0Q5Q+aUxP6AX2aJFkh8B+FCXf3gfJDSXgmQCASo2Umw9I0ubwvEu4UAsNv4ve9kDOTP2S8kH
	OoUkn8GH6o3KuOihmyPt+SYBTh1qjNAJPqBd1X/6DWEPELc+yBcCze0I1B3wmw0A+AxQKwnHTdB
	oKct3wrSLIxfRr+SlVY6wYAEq6LCri/Gww3IT14Xr5eg==
X-Received: by 2002:a05:7022:307:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-12be687e353mr498165c88.19.1774993962313;
        Tue, 31 Mar 2026 14:52:42 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.124.7])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97f6994sm11172991c88.8.2026.03.31.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:52:41 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 31 Mar 2026 15:52:39 -0600
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
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
Message-ID: <acxCJyyBSuje85Cw@fedora64.linuxtx.org>
References: <20260331161758.909578033@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linuxtx.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[fedoraproject.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232584-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedora64.linuxtx.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fedoraproject.org:email,linuxtx.org:dkim]
X-Rspamd-Queue-Id: B206D3723CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 06:17:13PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

