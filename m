Return-Path: <stable+bounces-222821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AAjAFabpmnfRgAAu9opvQ
	(envelope-from <stable+bounces-222821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:27:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842F1EAC31
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8086B3127A1A
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864238756E;
	Tue,  3 Mar 2026 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FinJL5ZS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803735B63D
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526085; cv=none; b=S1q/rjZIhpOqkL3TwKmatd79Aaga4X1QprHltg3SN5lFFfNn0RuxdYROb1zXrcjTH2yBdsdzRqZb0VT8H+zHw2ju3EQOET5sXpmulWBIrjVnRrZmK8zrOmOyPqs3mQCqs1gE8dYbJepzvoaYsWAark7yFjldFu9dgASOlK8V8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526085; c=relaxed/simple;
	bh=HMjix7nn+rlLHJ+Xqy2CBH+I9ChBHp1MJ/cHxYoi9Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lozjH3sEWcDocjIxv76WuosgGm4k6w5KuLakr86x8djACj3S7WxzvEvtljeZ05PsZM+m5/mk1hhk41IjGxlcOiIGsysrorUBtTLAxgfRNJzqBHqnt3qVo8VH+Adpo6ZEhcSvlAis9wl866f1fseH4+utscISFwafENJ+SVJLYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FinJL5ZS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48379a42f76so43312995e9.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 00:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772526081; x=1773130881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7saHVIBjA9v1GsKN8+JTVIr11TDoV8ZDa1PdETlNag=;
        b=FinJL5ZSxVgrWjZrDtDuJVrNw0r23Tee9IJqfMbxpPzDFbMoftys1YWOhzT1yJGqEh
         A48YkUDnncmvoJAoI7FV8EBPQBXip4Z5F0NBkHr4EM+hrUkq4/eSuQbwANEcfFfXv1SM
         nWq9kXEstUtbyIffLL+Hl1G41+n+q9FU/10rKr0eRoY7PK8N3Lvx9LAR9jRbKYtNDH9l
         /FxDo3nfy4MlznXfSi7/grvlpyQQJzEZk9iup8/FD5TK47i/nA4G9dyR+PkP2xGtggIQ
         af3F+Ru/kCRSqCowszD0zngG/5xctdHJqaBOoNJAT0/OjU5CkIZXIKVs0FQRzkDZOqdw
         SECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772526081; x=1773130881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7saHVIBjA9v1GsKN8+JTVIr11TDoV8ZDa1PdETlNag=;
        b=N5PtmQKODPycIs7SmGioyGZYEZpQN6NFFRXIAvv4G+mW1ybmOwHh96b1f+aJdmGAIM
         jNWsw7A/l5WsPU5MfUgg8EDuRHwdsDsmZndb7aAO9NjwLmUv0qy8vHDNSJ4Tmw1Ukm3S
         sTYhgYXZcvw8cmvbqcuzvmCXLpIoQgXL7LlxOHEeaRFKlACNONfrXnGXq67lA3CVvjta
         LoFX18CQvaRep3Y/TkqCZRu9aiI/4wGfEnH5XQ0rmRETVeJdVe+8eTnSHVX9VPmtiTXt
         VJzkuuW1EdIPUOplfU2Ucv12tO890ferZnE1fq+mmOyH659/jIes4jm8CYnnG3qWyldP
         1hwA==
X-Forwarded-Encrypted: i=1; AJvYcCVD3TvMis/4oyxTv+C4RysSm0PnnRFPAu0SrRrqurUY4Ey2nQrk46JVOmNgktc0wKDHq7ouJ48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8p9o44qU6zac//UmovGJf0WiYEbqkY5L0YNXLN5zHjrbt5yIO
	j9qeSIbDmwJvkhNhCsID4BFFa6OtDoR7DjaG5MU91fPmQ9pfmSt00js9x5p5Mdk9L/gsNdh76sV
	Od+T8pCA=
X-Gm-Gg: ATEYQzwAcCBgj2zVst/CO/QU/kZUw7zYZMRW11zd1syg+P1vZLYPEzSWk27OWOP3Rp7
	TyhB7+ZGEWk47Jr6tgY2jMr/1ZWlEYx2p5m1Yiv1R9juOUarlkE/fCd84n64WjxjlgLFYFryf32
	beN1KSroAsxYw6gfAlTLMBL7EcKjRFrIiwUTcRxXu8I/+jSsg7UK+xifmZ6TJrfanxiMJO5ydr7
	ZCsJCjPUTrNXCOglMWtToZqDhpEkD7lq4VYZnutZI/KjP+RVxe9Jr/EXQD95207uSOpSFEzgKyB
	wf1quxFOrgn2wiR87uFVddpAaxjnEU+A5rM0pt7wg9Vzr+5JpeQimmcu+D10RkTYWFYU7J8vG3d
	Q9diKYSPuqNZ/fC2Z/eHc3DGYgWrBFnt4L/iiQQdFWQZTnTfjhoV1nd31nuPUCZSXOQCH3xAM+X
	AwGz9MshygNfKp1E3JhBY=
X-Received: by 2002:a05:600c:621b:b0:477:9b35:3e49 with SMTP id 5b1f17b1804b1-483c9bb1e1fmr246792445e9.3.1772526081319;
        Tue, 03 Mar 2026 00:21:21 -0800 (PST)
Received: from u94a ([2401:e180:88b0:32b4:4c71:af95:b813:9623])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01054dsm19898230b3a.43.2026.03.03.00.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:21:20 -0800 (PST)
Date: Tue, 3 Mar 2026 16:21:13 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/757] 6.18.16-rc2 review
Message-ID: <qarpj22ywzvj7pwqz4xgey5nyi3adxv2q644xsbbipnziqlt3z@wwovneujmibe>
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
X-Rspamd-Queue-Id: 5842F1EAC31
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-222821-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/22590800040/job/65447954911

[...]

