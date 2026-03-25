Return-Path: <stable+bounces-230312-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HytFMnAw2kRtwQAu9opvQ
	(envelope-from <stable+bounces-230312-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:02:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E85F13236FB
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BABFD303F54A
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1953AE1BC;
	Wed, 25 Mar 2026 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eRj+18VL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8F330D22
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436163; cv=none; b=ax83k53Y1DWFBogVL9xj9LleAeqisOMDLHQZ/4dYLyBJlJ4BompnuldJO8JShs7UqYJxqkNpoTdRRUBkbyNF4KQsO65AT4QxifJmkR0/bhRCgHnqbSMo4N/C7c4seTtfFu2WCvG77RqWylaeIpTmYrM1DxuvRRvAvzX/ByerpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436163; c=relaxed/simple;
	bh=m4571C4KsP5S+tvy3v4ajwODfqrsP5H3SzYFjB/0vtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyUmYXwa3BMYnsQ3lIdXZcc4mcAKSCnHqfckQoB+NWEDnwBrk1DbvC8+RgtxXPwu192rOCvnrr/AFWj4bNbMIB1FAWlH+PEUZ6zPL1VOMfO+ca/RRH65WC3Z5vvNZ+uRNSFyIaVavlguGHhJfjy1i6kka4eWceLlZQk/DWpt47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eRj+18VL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48704db565eso40824465e9.1
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774436160; x=1775040960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cS8MLONKqJ5qnXkc4uPkwYfi3bzAQ6aZbhxWDuF/ZQ=;
        b=eRj+18VLUS2GkzRySvXJDY9Q5NGOE5wEPTHqwltU+9aj8Gcm+EJiKA1FDjGy7sYN3p
         OtHZHPAwR2qFOU1fkpa60A7lk8p6kj55+WBg+UazzF4s+sgOO+UOEGcI/+Nekno6FKfG
         OLjWITS+QpdzMc73lIWwCpgRyNTGUMTsJ76HHlSPef5pAS77+fmjWYJIBpckEvNsSkU3
         RInwn0878cA9KeVB6BTKMqnP6NMgj5pKd10J4f/TjaVJX+Js3I3sj0p+Co9cn7EtQRaC
         DYt+z0AkUYkwakhBJCTweuAosKV08Oe9OLo9a6Z++SHHEyg4JUquWJmgtTIVvS8bQWca
         /jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436160; x=1775040960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cS8MLONKqJ5qnXkc4uPkwYfi3bzAQ6aZbhxWDuF/ZQ=;
        b=VkzsNGupWTVFC5GZ0sPu2n+eKOUt7qOMhNq5LJwxjgAUkHwUMlIkNjxsB1uoFHhmba
         Sg/Ebu2msuM6CXdGa9WGL/9sZnGMQUpAdktNnjvhGnjk1n5IrKFV+UP7PnCFegr0rAV4
         Mx96t7njQw3iyJMn93ln/K+ffSYjO8GvWpb3t0hqeic11+EbJxSvFO8eqFIcwGibg9TB
         Ja9F9RmmViQbowKH2/p66wCncWApDhx8rHI20Y8cStuUOm+sNQQccBmpygzK5VaRo8A3
         oWbn0a1Rm3U4OjZ+2zysMrZnHOoPcJc/DWSSuMq2YUkywGGF6ZNeT083eqGT2hetL91L
         hl1Q==
X-Gm-Message-State: AOJu0YyhWJxsvbQoKe4wDO84/5fXUfXVd3WQ38ok8sOX4vsH4OCSNC7v
	XWaHzktD040p7G0KuGuiTfe+cozHeY03WDI6HnwCAb6I2V3j5ZEXG/oDcwVyjsZPMfs=
X-Gm-Gg: ATEYQzzj6Y3oxbgZnA1l1kNfrafUAkCCh3XgGMC5jfEnmYFxpTZmsrZ0lfrzqsJDgz8
	Vc3hw3WTYlll22Kk1YryOwCjXQsybiMR3qkWWJjW3j+O2pAUN25SNDNuYUZ4gvAvmFpXzMY+8R9
	MusyQ3BLLJElS5Kqzj+O2xfm44x8BDA0XOEIlktKH6IQbRglxHnUyY1U5h1AoApRBu0fHC+Jn6V
	fDz2kioLgYMgy8igs9LaY/XEKNw3ErphQUSVaJYDPKPcCa4idm5VoND/8gWRLgJGIcZ6LTDLfWW
	SveiUsGEadJ4aY+H11b9gT1VIoLHHqN0tDGNJU1cOBfJSIRIdfZ0pRKwyOi0pLTaeGiZJy2fK3m
	gPIVA3fjLpbBucCHCavwgdxzOYT/Wcg/Gp+1pxGNX211z8TD7n7hUurYDrm/8GCyTBMWFPutz9e
	FKC9dzk7DdorLYliWU0A==
X-Received: by 2002:a05:600c:4f53:b0:485:531d:28b9 with SMTP id 5b1f17b1804b1-48715ff74dbmr44190865e9.14.1774436159850;
        Wed, 25 Mar 2026 03:55:59 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:92ee:b67c:a5bb:13e0:f6f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0e919be5sm946775a91.3.2026.03.25.03.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:55:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 18:55:48 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
Message-ID: <v5jifek56gr5vuh2x62uwq6eqxercf4ntfoil7bgwkcyaph2ay@lrgoyh2c6r4u>
References: <20260323134504.575022936@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230312-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: E85F13236FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 02:42:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/23507388452/job/68418868804

[...]

