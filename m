Return-Path: <stable+bounces-266614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e8I0JVD9MWrUtQUAu9opvQ
	(envelope-from <stable+bounces-266614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:50:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990F8696004
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:50:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="U4m7t0r/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266614-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266614-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0F3B300531B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 01:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C562BEFEF;
	Wed, 17 Jun 2026 01:50:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8822848A8
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 01:50:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661003; cv=none; b=Jf6o1H7oGyCE/wbvfEU+3YYjlMf5nO72pB4w/A+IxZhmGnQvdN9PqgKddxLG43OzUuw/XhoVqJESIm5763a/8nBsOO6CaGOBEMIZ3mTskDsx/qhR+cIJnRdbIKpJ83CPJ1lp8tkjfQ99hjfcapvXsDFULr03fWlfUb0isLmpjNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661003; c=relaxed/simple;
	bh=dCx5V185N3HE1JGlnEfJqL5fuNQagz0zMOkZsszboWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlvSmt8LVmmFpma2P0eVR5jzqG+9aAX0IU+7c1VxgUKhgW8Tw8u788Z2N5DRNjumRssngJqteBYI5Vocv2+3X4xjhY8U3i4Q/C7D8ar7rWr60ELBh2QycNU4VSNGmrY/a/8kMG0tvYexQ8IBkU2yMz98GfGhKB/gkiLSIL8/MOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U4m7t0r/; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bebde89cfd3so663781266b.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781661000; x=1782265800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1JL9JOfxvhQp0InJJKfTeQK1sxHLgnnGK+RyeljDlI=;
        b=U4m7t0r/IcwOjHGyZ95D6O76GIoFra3yslZeLwwgfn0A8c6PLl5WS2G846eR4rjNWa
         VM9SoaJDtcE0Qx1lutzIMnYxDAWZStAWZ6UCUTVRqwkCNwcAfPI+APb2jrrZ7tZ+xHVv
         B2acdLVsNAWqiibqplunLV7RkU5ap3hPQdRnzPINbNclzQNyE9X9Qp6R2yajuxCxAYD+
         cpk/cofXivZgepWqntsSrUswcWZn87cPCHTqzBlxMbO1KvVcXMNad2EhYcpRTvi9elK+
         qRR6tfRUSvNXZQxQMr1URAH8cVuCqcB3MWqxG9uMwgpNsKhKt0lbE9GrSU+NUgSDOY/A
         y2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781661000; x=1782265800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1JL9JOfxvhQp0InJJKfTeQK1sxHLgnnGK+RyeljDlI=;
        b=lvwmdWvD/DyY62u+tuzWCgGDCVpLF9iiEphwohkuxahV6SkYsmzZpnsrCaz0mchPYa
         HCFPSV+HC5+56Swo7e0uucZXvVu6ZGI2E9wQ+vtvhBcrXVp84SHZAntRqSwnoxb5GI7f
         pZOBoHR9kZ+iglcCs5cJJ/Zkb6wS+kSYR3KARUJuK8z9gkidaWU0SLuN/e23xw6jyLAi
         ghtb+qo76HxE/gXzZzWAB2+SOhrvVmHj+dG4D4PlDmzQwLm6tbtbnjpE4CGUKunQ8Kdt
         apqyuXM507w9YOXMmEQgWIzq5H6PClb6gsGCyHmGvuJkHuIrR/W/mEBnXGRI+5YFAKXN
         F5GQ==
X-Gm-Message-State: AOJu0YyI0MXX4l2riW9MbF1Gr+u9Ba4nfQZbUjnPhXCBOXYqv/IQf6ba
	lGHWGEJj2esNaCzBCGxes1A3hCIIDY3ATF7ZtH2i4tkp0KVTSvKkOZ6L+oVUoQtcgVU=
X-Gm-Gg: Acq92OEhcSJkboU1bOY7dcnRbykXI4Ci7FFZypDKCSnHEWs0GyRS1/kzcU3NlmfQ7f0
	kilIcdOztlwZkMXL8J79KlJ1EcvhqNTkhZntrqsv5ZmhpPT0lWd9s2kO7/nnlL2XXHdeUlO6qOz
	wsEuxKWzRm8euuhOtqn9pXRN4SUxK0WsQQ5JClYis9jYX7Le2KA5zQy3KWoPjRsTrvlqQagr0Dm
	Z5r1107qpMO16S4UI+fFHTfu1ifBFU3CL7OnuXHGuMd8OFmS3YKjpjrH5f0OQLsMOs6MZPRL6Hc
	Q/BDAW+ENDmdL0y51MmPRciRXjHEuz3qdyvMQIttg6XiCvoOqFeBXUsordao4w3p4+oCz3sEnML
	8rQEe34Bf+yYhAqJH4PA5CaxmrYxwkiuc34PGnGCXZwHosLRGKkLqTWcySEE5nRWDT+Mjqyo1Lg
	sUU8IagKkr5ZnOhtMc3Lj+LdGiGj2iOu9AkCNXpA==
X-Received: by 2002:a17:906:5a56:b0:bd5:2e64:aef0 with SMTP id a640c23a62f3a-c05a4814807mr85815466b.24.1781661000527;
        Tue, 16 Jun 2026 18:50:00 -0700 (PDT)
Received: from u94a (27-240-202-183.adsl.fetnet.net. [27.240.202.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433078264sm144079715ad.65.2026.06.16.18.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 18:49:59 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:49:43 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.0 000/378] 7.0.13-rc1 review
Message-ID: <ajH8jaDln33RIQNy@u94a>
References: <20260616145109.744539446@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266614-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:linux@roeck-us.net,m:shuah@kernel.org,m:patches@kernelci.org,m:lkft-triage@lists.linaro.org,m:pavel@nabladev.com,m:jonathanh@nvidia.com,m:f.fainelli@gmail.com,m:sudipm.mukherjee@gmail.com,m:rwarsow@gmx.de,m:conor@kernel.org,m:hargar@microsoft.com,m:broonie@kernel.org,m:achill@achill.org,m:sr@sladewatkins.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,u94a:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 990F8696004

On Tue, Jun 16, 2026 at 08:23:51PM +0530, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.13 release.
> There are 378 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jun 2026 14:49:57 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/27647340765/job/81762433407

[...]

