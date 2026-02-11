Return-Path: <stable+bounces-215743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HZqFnAFjGkeewAAu9opvQ
	(envelope-from <stable+bounces-215743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:28:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9E12136A
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AE293054D2D
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 04:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33CA353EE6;
	Wed, 11 Feb 2026 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T74vgk1W"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7810FD
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770784019; cv=none; b=lrOCHygMIq/JdHgOn4ZMVreEWx+s4C5eeNMPQ/+F7JH8YzdYlhuatSbQT836uiKdR+1iFSg5klI57yiu4sictlZOlvLM5hZTsSllbXlRYfMwvrxssGL/e5xcHIlizGs5vcg0dduIMXnkaeIwp+87bdubgcRERjxvZlqfVONhFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770784019; c=relaxed/simple;
	bh=el2MolEaYsa13hzRlQDP2D2L86JXqf6CUr04VZbluyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBDbcyXb9pE/oR14GC6/mpMfyHBPkNEgxEgQe7mCnVAiyYPrHsR2CM1d/YCwZReqxSwM3dp0jg+ny7c0pcRhCb7QDrCj9NJ2Sb29Ol8JwcIeTKbrxNLQRfVWjtIyG6OuimM2c6TCKeSw7qeZPwB3kV94YUu0EXEqkoCR723xTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T74vgk1W; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436234ef0f0so3682212f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 20:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770784017; x=1771388817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3/DZy8o0V1z5fy+JBWeGhUBVePIm2Ww+y98BjdrjoyE=;
        b=T74vgk1W45VmqJPscjVAUpvJMJLdSJPa5fxjk7jSAuVKrKbNWjABpNnP5AN6mFloJv
         FQlRsYTxaQsZNG8f2p4FDtiKveuskAdpDPzxgyuFNKegcYTxgl/jbKxeEclf1ySTkpPA
         MCK55RvYnzLrxc469CNGsMDfjANxMcjCXtOfTLdITs9vNDPXMj4MQyoa9CZMjzGWOTQW
         87VNfrd0Wtx/tBYLwRo6bWuYD5yro8qLeCKDWMKUM5mlqk5gL87yiwViV4Rz3YfQT9zS
         LkR5oyDIgt2rlBF8FqRPfW82tLL/C81lGdmdf95j+hlP/WievEh5ID52tmoIm5Nw9aHN
         2DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770784017; x=1771388817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/DZy8o0V1z5fy+JBWeGhUBVePIm2Ww+y98BjdrjoyE=;
        b=S1jpM8vSjXJiUfj6Oz2EqRMLSRPIEMPmQ6vghjZj6Srs+qNfxuE0nJ6AgTdjRSCDcx
         aG1pfrfDPKNjFXCVZPb9kD9KtqkzIUgbtOBVV2yKaHQt9sFzSrYff82hTa5yXNzDOM/p
         Lef2Kw5l3kLR6bzF4ObaVgz/5lWN8ruTUlv0XKLcis0cPt+XACHkJYxNTZEVXMAbDidB
         GDmzIvcRP+cVR7SC9MJK490++tiAfKCiIjjd/BgwQPw5xl6Dr/kHmferQ28ieAH+z+4u
         Ylz5gjaJ7yRtmLLTRYFqt9NJ2SU7y9vHTWxrkTOEaewi+v4p+jlgXyOdpC8XLATG1hjV
         uGTw==
X-Gm-Message-State: AOJu0Ywj1snQvpdQZ6/pUh6CjALwTHnqXIuV9ZPZkLKEfMYIeFts7DTj
	Ivjn5254Ga4Xu68SKZcFGhdZ6ggOmHkyCkSxZ72wwx4IrGx8R1e0SsI5ipqAFE0UvWo=
X-Gm-Gg: AZuq6aKmr0vRLSqdWOyqzkdUkAbmv5IeDEUVX61JlWpjlYZHbYwZbxlAmkmqJLLPM7k
	l4jwoKpjRwvZukOQlzRGckeUGdfwTyXH994tYiQMwvKmqHIsyCm4w3h4aUgVA5qAOeC3j3DovEu
	QCt/aYrBIZACvaZri6uqtBAaR1xP664LhcTB0/Ok/3tZ5K03Z3RkkSs8oY3P7gfZz73oxvmwDKq
	BOhZ3wQ2GkHtwEyxUA2IumARB5i3ROHePn2w/DgcoXZbAMHJa8XF78VvjJaUHeIIpxsBQueeGxx
	mpbJJa1Xv6GGBEj14tE/ottgIB0ahqL8pcxMkzZqm8oTQ7barLWtzxYCJ39BtJyVS+CRZ/bqMF3
	Flv/gZymHQ5LSEqoC5LuEiarXYhBSLdRvxz6bLvmE42S8/Dy2IY29C8kgnVxu/waBBvPK+u0x0a
	wbSqslGyqR1Q57+de1Ss2vsoIJ7848KPvNNmp/YsNK3jc=
X-Received: by 2002:a05:6000:2dc7:b0:436:1872:63d0 with SMTP id ffacd0b85a97d-437845219ddmr669410f8f.2.1770784016940;
        Tue, 10 Feb 2026 20:26:56 -0800 (PST)
Received: from u94a (110-28-16-35.adsl.fetnet.net. [110.28.16.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d46f9csm1642034f8f.10.2026.02.10.20.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 20:26:56 -0800 (PST)
Date: Wed, 11 Feb 2026 12:26:42 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.6 00/86] 6.6.124-rc1 review
Message-ID: <pnekjfboals6uzxw4yb3oi5prykptikz6vhgcnyky5urfl27hw@4yagi7xv6q6l>
References: <20260209142304.770150175@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-215743-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C9C9E12136A
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 03:23:23PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.124 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21880634049/job/63161819172

