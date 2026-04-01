Return-Path: <stable+bounces-232703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG0qAm2/zGmYWQYAu9opvQ
	(envelope-from <stable+bounces-232703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:47:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 738FA375624
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1944F308D7C0
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1725E33B6DF;
	Wed,  1 Apr 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXizZcbm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6533B6EF
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025991; cv=none; b=FpkOBtptnzxoLjUALVO9hQCMakgyZK4kSlWzizpC3tA6UX5pysDuRbvlqL1f27qfapZz0A2SQgZC3RhhLldTjnKnJDJgT/f/aTgE9HP5KmsMaKweDR2XM9fDZNj+afdTqisRgRJChnXt5WgeitpiL/XzEkX6PduakLeMafHWmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025991; c=relaxed/simple;
	bh=xXzW+65AUtNVhFirsNyqNF1LErcC8Sn0eiTM3AesVx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVzytRRD0v6kYuoWVBhrPqu7cg1TuQ6ApgNe2DcJqW0LPtN2zWJeSY/5p3Xjq/wtXWO3WoDdy5NK6hyetbjidgPoAJhBUI2Wbonytrl8WxKkbwWnuwY3WPZOb5djwMhL9DeZSPrsooXWDa7PS4K+BjKzJm2Vfn6lNw5ngSpDfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXizZcbm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483487335c2so69008095e9.2
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775025989; x=1775630789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m8lYhF7PdfMApbjhxZ68ZX7eTs6X6qz1n2+1EZqNXEk=;
        b=KXizZcbmdZ3fZ2eo7/wOvkpHkVS6QpR5Rrexsd+kCxZR4m54V7tu//44pKyYzmFsYn
         89fiEGgz1tmlxI/woXzQ0PBIbh2JhUE339bsqEfKSXgD5z25cYJNEpCQfm7+AnQMitLd
         k3PkluionXwI4CIRZs6dSsLyUiWK91ljQH79h4Apk5YDM9PEU09F601iAhijqlMeK5FA
         yGiVTr/Ef6fhmcnbNTwX0yXIKRvW+M60Shgfm9g98XI/jpZGJrh2jCB4exyIJCLgFDXH
         MNV6DyM7aSIIKT6c66n4JGNeN2L+7WpFgMFq2Pgj4nETZp07A43J5XqZWVcG/94rNyxU
         QtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775025989; x=1775630789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8lYhF7PdfMApbjhxZ68ZX7eTs6X6qz1n2+1EZqNXEk=;
        b=mYkjhnDBbT7dgike9Le69vtFSEAmv8iDjsNCnY5mk/Yz9owM2g1McTEYWTLMSHB2z8
         RgZ5wvR7Rh5QFbhGTZDwbDfAJSsX4wCEtKPhtqw3OkGiyuJLbLSayyFwCjxDVwjBj3X4
         Pthsohta6bytraO0rsTH4uvUr1rbsIr1IMT0TLad2eIDWCSs4Tt9KUGy58V/cDV2fqN5
         kOjPaBlOWp1NIspk2mdIsZ8RcZDyebDqhS2sqpVK5U/3Js8YiWb0MoU1lVXtIKcen3Rh
         gSOn9QEEgAq2s7atGjYN3M19/auNIOjqZ1JpFRTlEGe0JjeaR+oYCP5zeZ7zCA0zcnUe
         eUSA==
X-Gm-Message-State: AOJu0YwHv8DUsTsNWczebBqOe1dNELhxV533LY5pM1Fo9ULiWdDLjo0y
	w4ju4LTCqIcVnH6xK3VVT3p5hZhaRWof+mfTuiHv0VkpcJw4EMu/JnqAy5K+SpVZ5sf2et5jlK1
	EzGJY/ug01g==
X-Gm-Gg: ATEYQzxZwfCHUoJTgpjv8vJ0MTng9mThMcWAXPwU9JSQFABX7qBH8TwR0zGi/eg1gFC
	GspXEOfK/AQSKRP4RG+48zMpfQCXRh7CKqllzIxRWrq5bby+k9Kw7cYYBXTrBwBcRJbE31N3zNc
	2XEvoVRhIyVOLVnRpoaf2ETMwB2lon4n1kXzaj3/7QALMavOZXHOYtID579Sa/ZELoaZitSwMLu
	T+M2PTrD9zGzmgL9hjI8pYzxK5KPDRMsTBHChOITgAlNeZuONSHhg/WZl1SXcmtglCy5ifPAysJ
	4tUe4vOqdBeX2AqvrF73PajwMqTUgt0pwhWKOvmnciOucOoZbvu7HbDatb0ngClUvhYc6rvesD0
	S1VNKssksqaf+DA7/Ji5Fx7Pi20h/+s3mRi5GazfYrgj61VGYbG4u77iXm2Wmib+aXrIV+fq9KD
	uL0ocONLndfypXKNgUOR/upZoc8fMQji4o7XC1e6H0W3kkqQ8S
X-Received: by 2002:a05:600c:354d:b0:487:386:3714 with SMTP id 5b1f17b1804b1-48883597e29mr34288005e9.17.1775025988963;
        Tue, 31 Mar 2026 23:46:28 -0700 (PDT)
Received: from u94a (114-140-80-217.adsl.fetnet.net. [114.140.80.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm183118535ad.67.2026.03.31.23.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:46:28 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:46:19 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/309] 6.18.21-rc1 review
Message-ID: <5m7e37jxpt3wpvw2hcmnfwztpawc5jxex4eesw7tqta7khqm4o@nzoltl24l7nw>
References: <20260331161753.468533260@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232703-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 738FA375624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 06:18:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.21 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23814574909/job/69410511555

[...]

