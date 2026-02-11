Return-Path: <stable+bounces-215741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNrXG+QEjGkeewAAu9opvQ
	(envelope-from <stable+bounces-215741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:26:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 176301212FE
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156D4306E80C
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D0D3542C9;
	Wed, 11 Feb 2026 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aqv//1ho"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7283542CA
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783950; cv=none; b=QiiPx/wcEiHjzMB+UI+7dgwDwnu5dgS/He8oxoUR3VIDG2MZAWmG7Q7RRyP331tFS2Crv1VIShDMLiG1l8e5f3yD902W6CX5Nxa/TVj6qXlGc+fSbxmFv6EcZJQNt4x0KVjo212sS2Ir26tUZc3chMd0Hi6tMcZe5GBiHHIRetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783950; c=relaxed/simple;
	bh=JkYZnGYN+fOYzCkm7zRvBQ33rZs3x38+fabyBfvTu8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZu88UxdgDfEDFwTe+kJ4CB1oLYJP38y5MG1mX+qtoooibzov5gjAvJ0NA0CypEE11IQ5EaMWRDomhYvq438G6yX1qre7jJtH+L7GcTeB1dILvTgB+116Sttx4IMNhvIBaaCAS51gdlBotgbHzLfLsLlTPwoLptRSB6xfo/xvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aqv//1ho; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso54972015e9.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 20:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770783947; x=1771388747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=adNnsUk/Ue+Ehcij4plZQHtF5jZOHNgjtF43mnMTFj4=;
        b=aqv//1hogg33WKRpJHY5rNYCUiWZj0xe27FiV8Z3uAl3pYpR8BsJnoe20HR5LwsLC0
         EVUkMTb1iXUQZ9x5DCGD05xmEzYU6nQbDNnmroFE0Ni6EGPvFFasvgTn8t31+Hi8jUJO
         ZPEUDTui6ZjmC1CBNPEb67P7D1aMGWWQMR5PoWmiTSwVDsROV+wR0k7CWjJpFr+Hl0jz
         bcfXVTS1eehq3Qa4xwHTdSlGHIp9XVnJ4YH8HLCfNfC8Xzt7502iN9tDx07Rk4WjSRR/
         PWbjMYtzfwEM3L/FsdC2/XS3biUy9HCym9PW2IMSKZ99KJLmE8RzwxJLl1SBrjogoVzc
         YuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783947; x=1771388747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adNnsUk/Ue+Ehcij4plZQHtF5jZOHNgjtF43mnMTFj4=;
        b=C33BJ5ce86F9iNzu0mEsL/Wm6bADTblomXLcEVc+n1AzhxhBf1bqSoSsGMDk3OuQV0
         edBtwgK557Fq7n5/AJjW0g7BZ8YRbnqegx4RYGwJslgIwtB9AeGy/ApvVQ2YGfjbdM+V
         RUs8qyom88KmsTS90Xl1YW+uC8eoAbFkMAiKZRXYpunQKO8tgi5tMgVJyllrobgWuv3R
         7AZBScetUx6zRU2O4Y4KX2yimwIFDSefPqc26aZMhCMcpoov7wXRo6m6hJUccEtjeTBm
         9eT2jmCKOzKo/Ks0CKcvBETlIn3nEZW/hO2CrY4ZOuNTnGKFhvFAr8ytxcj8XUQTEgLR
         u6mg==
X-Gm-Message-State: AOJu0YzzvkjGhc/xo/Cc4ZQ2SwlfRDS2ZclwcRWr9qE6sTJalUAV+C1B
	0iFvaEwuvdcYAK30JlpLC6d2WpJn5dGyCc1+8HF5HcOfrEgiR8NwoI5n/vwQffBKMTY=
X-Gm-Gg: AZuq6aIwFB9/rhi1TwzN+mLBAlOSFEjGA13Inn46n1AwUBcsqs4xQPHGoqowK511xn/
	5/wBJckeQnqplyAx088Gb+E4LNelN0lOx5ntzJPxfztSeLxs/6kiVZKyA/4RVe++tV6RrDNxD/S
	ynNQvZFr25076URBfCxxK2n8SwthFgXe3KJ2U33ZVeNXzNOfq7G/7UHC6Po5ypmulIWVuCxk68/
	FdnP6fEeSwl31NvC2TVgHPRERB6/0PF0DrZDj25X1L/S5U3+gLdTaCHfTB3LfN6zsV1AJvey7EB
	1jacTC9EeQoPY1H3FtV3AzZq47C41HEyZZHH7mMb/a/h4oxTeZBLR4xsK0aPxgieanULmGhC3qa
	IdZxRAVM4bdx7uq87sVEajz9JANguKTCHQn35FJ2TXAvcTk0labXjVgPc7BaIHtvXtvwxWv7JeD
	toL7lZ/zjwUVjnv6wSBWBEhaQLM5ljfUX+fU3nJKq/SI4=
X-Received: by 2002:a05:600c:a015:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-4835d54f8a3mr8337815e9.30.1770783946952;
        Tue, 10 Feb 2026 20:25:46 -0800 (PST)
Received: from u94a (110-28-16-35.adsl.fetnet.net. [110.28.16.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a1c2sm153656175e9.9.2026.02.10.20.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 20:25:46 -0800 (PST)
Date: Wed, 11 Feb 2026 12:25:30 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
Message-ID: <ac43ns3voofd4lgs6fi3zhuar7n2gy2jbn5icvio2bgytu2df4@auiowpkrgnwp>
References: <20260209142320.474120190@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215741-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 176301212FE
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:21:13PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.10 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21880634049/job/63161819185

