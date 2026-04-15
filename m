Return-Path: <stable+bounces-238021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLcmH3cK32n3NwAAu9opvQ
	(envelope-from <stable+bounces-238021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:48:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B154001D9
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC70D30918D6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D43B31ED68;
	Wed, 15 Apr 2026 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FJgjLILX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11613382CB
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776224883; cv=none; b=S2m8l4SEGy1UahICuR0+p4W88ha1TBgcY4OaxcIHEayYYmdMJBzz66b6Dgn4cQaS02Vg5u68yvDQONIKQT6Frk3sfjRExbyoMbX/+p4dlcUk6IH92kerDf+C67XDdFaHZL3K81zDx7v/FRw9soJRQbe0pXetZ7gzHuBWIHkIlH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776224883; c=relaxed/simple;
	bh=WNzLf4fzSkYbBrCWrcCLK4C43z17fYCHhgs6scvVfzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhRE5/hGnmYDq8o1/QXc4vtvxXw364ZsGuIhYLdx2Y7BU9DQ5y8XCQMAAuqUnzPqoepmd8txBJOlkkcGP1C56KSsXNUsoi9nM96q+qAMScPGUzC3hqBjXNHsFCLlbVkOmcEfDouFLWBiqcxRBb1wJMb2zfVbporc9AzqewmDYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FJgjLILX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so82883825e9.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776224879; x=1776829679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1RuLOTXQPaCNCdRlFZU592xjC6rgmWgeC9PPu1OpTk=;
        b=FJgjLILXch+5YEtfLT+w23wLpm1D6/YEpRjGMJbqy8u4dIr1T9Lmw9JhYjvp47hfmM
         BMD9Lqju7pEkziWO0qfm5BN1kORJkfTtxqzT5lMDTBs9RSOZO8IdJBzV5SwQi5SNpCSL
         xp2nl6CovZVzYWMEzvjz/TnBQL4F+yMbklFNTK9nMoUzqeKJTPV4KMzKR+gu4HOQ7KXl
         sNQZOOpiIbsFzJXPPPMctJsxtvKHJ37YDF0e3NMgmLR2+tfq1tJ2h7tYJW6gGFMLjPyJ
         Yat0hDHYLazq4pilqJTR/7KFEurirtMQGGSMSshuBZTso3HyNDeiPET1tyGtX7RbBSaz
         xHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776224879; x=1776829679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1RuLOTXQPaCNCdRlFZU592xjC6rgmWgeC9PPu1OpTk=;
        b=PthmaRQF814QA3Em9I4zdOTLr0vY7x7C6RslWTQG1WQNe9XvfCTF+cKsZbFfM1HGEK
         M/UVXB+ujx7j6lcQboaCSKaVmIMLiJP5FT/M9F/gWZOIIAbHfdhRJbQyEZ/N+Zdp7UfH
         pdCPf7372ww1i/waqWiYIh4DmjLvpL6xrpy0HJLZxOMyYLSA1W4+7e76lpZCA2CAInct
         mSwLVJWXV+F5ygAf8bXP0Mbc2YAmk1BD+WG/m8Y1/9cJAa53x2m5dO1Ps0QdLuU57KcL
         xDI2FsLlC10+RvDaDe2fZUqwWhiTfSmx017Hmzij5l+th0z2PcYf+addGQo8iY7mNVSV
         7QXw==
X-Gm-Message-State: AOJu0YyiFT4AlXl7mBn7oEq8BR1Wr6LDta6klFycj2grykEs8x02Ujtt
	sr5x7naGjnwhAhZD7GtpzIvI15o1LgNArK3DcGvnMvFAKaZMoUCJDD7viPJksvmIIXQ=
X-Gm-Gg: AeBDiesYsSSEnSjAHxXxg+adqU2KYxzLiDsnL4OkzNwEhzB4uOAuqO0qCV4ZY7w9zFw
	3k9YDyRHG7cIlsjP7lr/ty+Ll00QsXHc5XxJe+PDVnLqv7T7FbOZ1htii0qX6q7wEPFbdL8Dcbz
	8MamEGovY41T4+Gy0HcnViqMPg5fJO7L6onyPMwfPgn+Vrs6aOK6zEWyYSwN8mjvk3f3duYc9MO
	76Akr8DATM+EPwBfg1WgTZktH5SVHMWqpZl8UHbySfnJ547AIH0sar+7Liy8qA8fh4Er2ptN3zx
	YIXffZ953EWhNTRE39+DOteN5EnvQp/VabOdnsku0yCrVTs4Nq5X072wWSo3qOQ0+SPwh+IHlMh
	Qsx7Vto8hppH606ZxrzEyJpy1I0vEdhU/8d1HP+kWFJi6QVOMjmPOpe9FSDornJ3XJ/VWzmcC2v
	4lpB0ldeACkbnttXBiQxOM1tGsgzQfzjpTZMDGqjYOOu5NJ/iBqF0=
X-Received: by 2002:a05:600c:c084:b0:485:4006:960c with SMTP id 5b1f17b1804b1-488d685b86bmr196803845e9.16.1776224878665;
        Tue, 14 Apr 2026 20:47:58 -0700 (PDT)
Received: from u94a (27-51-0-223.adsl.fetnet.net. [27.51.0.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f65f9bcsm1050289eec.22.2026.04.14.20.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 20:47:57 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:47:45 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 00/86] 6.19.13-rc1 review
Message-ID: <3nreag3thlhdth46opxzaae2glgj5kvul3o52sizwvupgapl2g@rmhzbsozkpv2>
References: <20260413155731.568515178@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238021-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 21B154001D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:59:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.13 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/24418242274/job/71333106576

[...]

