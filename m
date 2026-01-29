Return-Path: <stable+bounces-212723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONr9OoHBemk3+QEAu9opvQ
	(envelope-from <stable+bounces-212723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:10:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B07B8AB07F
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F9A3014103
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF4433A008;
	Thu, 29 Jan 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gGDsA/nm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652532C929
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652605; cv=none; b=DLlBKwsdh0ChpK7men1y9zmi5qaz7WedAF8us9Z3dQ90q9Co+F1vJ7Q9TwAd3wgYW8GGBDkmuYGmrnG3kfzcK8unIW1BqqJfKZBp5P545C87Z9F2PEi7owOsuGV5m99JNEKgh5uqZ+zcuTED8Gg63o4BcW1kqf36ahRGCcQMC2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652605; c=relaxed/simple;
	bh=DdisuJYQPCAap3IIi+qFKZXxHQf9hAWBIV59WhcPkYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7/qdZKXwSg3cDzOme90kkM8j55y/e+2+XJwqYk24NJ7bTQFy1YXQPdFa7gbkGonOjro8akm5MjILcgveqII0zxFqm/vKijlznsPaBRtdbA5TwPR+UVbV8YkM7DxUigpHn7nZ3iHrETevwV4ImZd55rEEOwJMK/ooXNheJXAVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gGDsA/nm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so11109235e9.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 18:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769652596; x=1770257396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqjMtN7GBxYjxl0g8AFWei+r0EcmP6xP0hMaaJE3YQ8=;
        b=gGDsA/nm9F+dUFeH39XpqhN67Uod2wbYXrwmvoyb7pdeoN024KRaJZexO2Y21VYzJ+
         lRP7PolKQSBwzpaLPT22dpfng9M3mtXzYp70193wI29t6Mg3TUM5GJYL2qXq7ZmOQtCb
         Fb31CE3mBikpmQzoiBlUAGNaJQcLQ4V4Ce+zjR0vNVA9al/8UiyomWVuTBq3GoJ9wloe
         ybL4lYLu2tUGQjUejcYeWIiPq9a9iNbgJdeAOzcHR8jOYRBNmKku9MWCoYLtD06UPZzg
         XvAqgTj3uSqcV17CcuOCARABvvxwan8whWKM9XzUwfCJltOkAApGSJupIMMa19Ygjae2
         c5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769652596; x=1770257396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqjMtN7GBxYjxl0g8AFWei+r0EcmP6xP0hMaaJE3YQ8=;
        b=mZrGmMJXsq5GRlGcomaDCkLeRbIR81WbTOZxwPPmV33AvnBqHa8JpHSGNfsC9hZD80
         UX6cvpeITcMcCxYcJrkLPYqzaIe1KoLgnRU2laaCMHahmSuOuf9+UbXsE4bJnNimzuIl
         oCUvvMnltajjHweseWngBPkIub7yp/o/VSsHVgBPnj2EAMvKfD/pEFmVffesE3sxi/XG
         D4214GiYx8J+o23dSrcG0FrER3fAQfVpqgG+GEdV0WqYM96OgjUTAUlua7gh2Zy4C0h6
         nenBdOv/BaRvzglloHtacnUT7zfPK1UvPmEs1d9RO8Z0a2JU/G1DEK0p9BRu3luCI9P4
         0r0A==
X-Gm-Message-State: AOJu0YzZgz92ZlieBxopyjHx15llrcL0AtnYgFZbuLKJv/wCxpSFWZ7Q
	f3pQVb38Dak6SFUcgoLUp2g3uScCeyWyn1VGxeHDpTkvuRcuLGZh26aPq9l6VwUNA2E=
X-Gm-Gg: AZuq6aLUCoBjUhYHIjzlVdhR1SHR71s1FW67uKLOjmZOBf7gsisv/ib2qZ062OPXYEy
	CP5dgRnSVY5S3eOFLEoG1kPoL2R80HFTuA/TkYAwI1ZcuOhaXr9kLBPD8iaCyXSvKakMBCXI36Q
	kxmAhQMkJ1brbOzP6Fp1bX9y93u8g30Bd47y6luF9LBvBrATn/JxFxEdSf8Va13LIIQshuRcNPW
	0DlZvw1353fis9Y8ocZzR4L03/R1MItJ6hKgP5Rn5WwVrlECiaFjV+wGMC5nhkUq1cv1v1YREE/
	THpWKWSMsVZgs3coYp+BjEFpr66uXvaM4nAK3B3YqbIVbeC3EdHffg4Z2cbJ6QdF8//0HxWptC4
	2WVr2BDuLRq3zBqOgKpQxxrz+0QUzI5OOp5oBoEyEEqj0plaKZfls2gPZNJhtymwom7vDvma8WH
	wBt0ZzLw==
X-Received: by 2002:a05:600c:559a:b0:477:9a61:fd06 with SMTP id 5b1f17b1804b1-4808289208cmr11692625e9.8.1769652596348;
        Wed, 28 Jan 2026 18:09:56 -0800 (PST)
Received: from u94a ([2401:e180:8dfc:3cc3:8fe9:e99:6cdf:244e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e55efsm33397185ad.89.2026.01.28.18.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:09:55 -0800 (PST)
Date: Thu, 29 Jan 2026 10:09:48 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/169] 6.12.68-rc1 review
Message-ID: <rnmchlhjn2tq225wyh2kxk3cfjlp42dcwmwtp37t675odwwwjp@4ncop4un3neo>
References: <20260128145334.006287341@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-212723-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B07B8AB07F
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:21:23PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.68 release.
> There are 169 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21450963930/job/61779347559

