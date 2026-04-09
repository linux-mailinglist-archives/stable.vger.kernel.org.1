Return-Path: <stable+bounces-235314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJKAJZZE12ksMAgAu9opvQ
	(envelope-from <stable+bounces-235314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:17:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E913C684A
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 08:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F6C93019B99
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 06:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDBD313273;
	Thu,  9 Apr 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d6RrGG4E"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C22E06E6
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775715451; cv=none; b=qxUDiSqP2Jy92pt4KyJiKWwR2CPQ0Xzg8XYYwHJum8uNKCCMpeudz0qNDMvU1XRT1s7sS35nqfAo9u6/nSLffW7A3LdUPtxD2AFBMU7iyWMBvzsGsGWEKPhQILnFARvSK6cBRwRdsZjDwCj2sTgSlSCRoSz85/4bpTQgubxbAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775715451; c=relaxed/simple;
	bh=EWjF2b4rXxKCWu3HaKDT+3RFuI5E/0Jsdwx++BW4dk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsak1nSixNg16fUwHrLSOj5VpbKQSbsJRhT42wnGwIMoRcCQp0fViCoWDidL1I/LTwzhrGJ9Q05L9363BtIQsueyfBX9WyobZ7g2AmZc9ANrLaAM4w/QGopqmupDrC0/JIxVj0IrVZcWk0yNEAYY9RraXKotUNj0sR1ECGtZKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d6RrGG4E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a29e6110so4821875e9.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 23:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775715449; x=1776320249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDrGyPf5KZiGiOwAjBOl/DPFbvx6Itcj9Gvj/s6+2Bo=;
        b=d6RrGG4EDcusMd1vZn1ulWIpQbYi/ksNeTkgbApzdCUHOyHeOO4dPWaxzayF2t1F41
         3PRML9pKKmQL7gUskp/vNmFp2SGfpRRG+PgirNSU5G4ab4vLIoX668tDxu114CYaflCl
         dVjBy7R6qLZPp3TPEwvmvUo6/tdGQugdx9On3lpK8Q3DqzBosUJhTMfqguJOYQbXwuuO
         wbfE1WwfJ18QBf+qPWMehtszLeVjuLl96Nh1B7SRAjpdqazwaufQJI6GJKKnU2cfNbZx
         q+nxqr+VB/kU1IrXXPyP2fczLeVZPEt3JZYcw7N2rqGAQ/pTeGfGv7gJGVjAEY7pzBmt
         Abow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775715449; x=1776320249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDrGyPf5KZiGiOwAjBOl/DPFbvx6Itcj9Gvj/s6+2Bo=;
        b=SC3TWvTaC3pcsus3IpLJpbsirKj7dTE1xxIssDIeFN/HZ2f4KbWkeVLMDgi2rf3kXf
         FbRftA+1eMegSUeo2pbRsiulgJ18/rujeIzKocguqVDUJwEL1QoX7S74Rx3K5FrP3uSC
         DoyJV1rNIR1rmgMpIiLpVdCBQdA7EyVtpAGR2kdMtXlIRKO1/XIuItY+DBbDK1LRr8DZ
         9UdacLngdKnmNPJVG2JM3/sKZ2J5u7b2e7IY4Kwp7lN8XSYyUyV08/MGj5hnGAMCyln7
         R/LtrxAlO0Fa4POegPLy++bTpEjpJjxt8mOiEDAIdTJ7srVwB1ytkyhH/JS7ou4rXU2w
         O8SQ==
X-Gm-Message-State: AOJu0YwA3Tw4F97lipPyNPRUO1Y1Lk+T3HuRIm6LgBbYdi+yLvlUCjI3
	aTRQHLpeUjEEyzjLKxyNJ6U5K/vqXC5sFtRoNbizcAoozjrYfjaz64Vama9I4p1wYMw=
X-Gm-Gg: AeBDietwO6wSNv4p23fOIQK92DFTo0y/ayfxVTP+pPbM9GspzoMejGRfWTlvvjCs9YW
	8WBGRPXvGI3BuvpeHz8oIhemzK2r/vrTmy1Z+Izt+KtUJPR+uFe0HFrS1xBdMuWhKzemy1WMWoG
	XWLfL9+8L8Cx+7U+K45EgjHhMFTc83zT+ba+4Kf2PKV9ncoISOgA4uy3e9njPXYOlX6Czt+mKa/
	5QE9v/jdN2maTD38fO6HBBI7TE/qosKOecwGmjszIDuk6AjTnnpjayoVZmCE4i/OAdnHNxSSsDg
	ZZ6y/zZvCDJC8gvOvvHfY7Q9+msQnw9ptcOtSAPX/IGm1o6uOhrwfgLMJ7bbqHg7umITXstDLVn
	PLRsiczxa2WiRRt915kd4hVLSmieMigOnaIxl3NA7L+B1wHrjZmX6alERVFduVin37N/NEhgGuL
	sHuz2zPyN209lQrXDkqzeMsT7fuYPOvdr8VF1uLmicpEbp8Bj/
X-Received: by 2002:a05:600c:3b99:b0:485:4453:401d with SMTP id 5b1f17b1804b1-488996b0125mr346755695e9.2.1775715448685;
        Wed, 08 Apr 2026 23:17:28 -0700 (PDT)
Received: from u94a (114-140-130-35.adsl.fetnet.net. [114.140.130.35])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6da8bsm17515550241.10.2026.04.08.23.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 23:17:27 -0700 (PDT)
Date: Thu, 9 Apr 2026 14:17:09 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/242] 6.12.81-rc1 review
Message-ID: <rmfosjlqusclu6usquiajpf4rx6ytkimfxao4kpk7pc6vwsoe6@4ocmyszvliuk>
References: <20260408175927.064985309@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235314-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37E913C684A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 08:00:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/24153838933/job/70487760115

[...]

