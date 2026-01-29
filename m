Return-Path: <stable+bounces-212722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UH1GGeC9emnw+AEAu9opvQ
	(envelope-from <stable+bounces-212722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:54:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1148EAAE67
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F145B3024A46
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 01:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DC02F3624;
	Thu, 29 Jan 2026 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gvuIh/kd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DDF2309B9
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769651669; cv=none; b=VZE/PDqkWkRQtSpgHpjZJDqXo9BWHB0S7tj65kA0c3NR/VhJyEpd6NhI/Q2bQ8ZqCkMCDSmAWma7bMuHU9dazPaM4NkVq1SGII/35XnNy+CTptHxdCAXWLK9dU+iWW+dBMdEzm6ZRXaQGjftrhjZAVqRWGmparSEFpvbGLEFYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769651669; c=relaxed/simple;
	bh=7Bv5MXAF54AT/TX8b27fHhixrRhstAtaoxlfbglQOt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H56sbr1vpsZCmHbDPjfB1y/+gqq54UiNh8LW1iQaneN7ZkOfvNY8nUOth7q5bTMGOgj7FDQJz1H3gR2pL13bKo0JzCwjsl3MUtAzIeFNEMWqdihRR0uoUzPslLrPXuTS/Vqbk0ACDLE/ZRBb1fogemy0986/TcQ9fm1gGAAGQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gvuIh/kd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee07570deso3430745e9.1
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 17:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769651665; x=1770256465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+/pdda4yJPhKCs4dndz1QQHrVODMArj4piI4Sx0+Qk4=;
        b=gvuIh/kd0DcE6pDUIX//WNhBwsmDyk7JNIhBWGRL2LwZfmp4sxR8JBUJbst4paVqON
         yhxz610EdlMu2wI6XAjd/cNZMebqprbKPcwAF1z2mh44SAr0kT0QAt9OkHMvnru+9DMT
         NBkb+4kQpSWAb6VNWyCcjqQLXR1a78JGO7laTKTDqwJRVb3HWq5wuVNLL77Nmf8/1FI5
         vzdw62ZRxAPgJuLlQpqtqPnZAEsWzOrV4/gbR+PCrPEQM6y3pLvAEQirxdgSFXW+98/T
         KGTQn9qfeturb0AjHFW9h4S6OlHghKukBNsMghIY8pxQ49N2Pxf6npL47pndiDFIdMsx
         zpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769651665; x=1770256465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/pdda4yJPhKCs4dndz1QQHrVODMArj4piI4Sx0+Qk4=;
        b=t4PPPTrZQg1VxoUt9g8bpMNzMCDIvKMXgZnKlMQejMgVGfUdQc3lTQS3njH2gQvyRZ
         eFqEl4mDvSrc+ZZ+0Irk11ERtmEaMK3ksivEJt6h99E/8CrHRRjqAS0HRO5FLUtLPd3y
         3i2XHhjAwdIL/ZZi0wb4vSR/+leygy+jLwuw7yoRKDCJOgQmXrrU/DgeJnK1AlgbLvdT
         iSQgy2WwcAI9wNwiqHXWh9NrBiJBntjrK9bBzODlJ6XtrD60lyYVoxaIa7niM3hKCqJb
         P64sP2gNuVbf0TAOiqNYMoo12ocxnw3lWJb5G4ttvzjMhvhH/7ZYBZVEhgkfBMtNomTg
         3omg==
X-Gm-Message-State: AOJu0Yy0Ymn9U7BJ3nK7M3fAK2WJo9xjKVFcugu6xK3n/QtzBVRVJOzF
	QwccLgG945jFCJMz8ec9c0NhhvEfEJK7AO2JVbzh69CrqGzPYcSt0QxORNiQmsmlGsE=
X-Gm-Gg: AZuq6aJJ+zcbrtlpj4X7hh9I8NRVhfblEdmKMWXFpVppV3/ggGwbfVb2XVmukujK1eH
	zUc6N9nYsQDq5RkO7DwcmBk4vCREQusCTTdn5q/+0l7kyzL70Gt0a63J8Gz/empi3ux9dpV4B0e
	IYwN2pPRwCOlKy4z29WCEpy+E4mlCLQWXuupxFf1Srt7rkEofBAMiSu9GWroVv6g42jbmi5hr6T
	BVcL1HJxOwhF1PW9AC5IH5Xtw7/ZRTvihu3ZS24W+LQ7Ma7hj0XrJk2rlVkSAWT3Vgepg0O/wAR
	U8WHpHNB3AdthD/ROFXA8CUjhJWxU2gcFaVIDjlH3jYiqxV2R3U3nX/T6qjrXMGzgEBDulmh3hd
	uYmSHAtoq8e8iTkJbqgxTHuIuJvUwddy99ZxsWdmFdXlUE06aZ7xyDUjEnkc8Gpv6zTEm9wAekm
	Rknv+gZw==
X-Received: by 2002:a05:600c:45d0:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-48069c7887emr77995955e9.19.1769651665413;
        Wed, 28 Jan 2026 17:54:25 -0800 (PST)
Received: from u94a ([2401:e180:8dfc:3cc3:8fe9:e99:6cdf:244e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8bd76538esm6139395ad.76.2026.01.28.17.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 17:54:24 -0800 (PST)
Date: Thu, 29 Jan 2026 09:54:17 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/227] 6.18.8-rc1 review
Message-ID: <mqy5kxqjgc5ec46hkh7ddn5japl6623no7uo4ks2k4w23grxdr@3stxzreu523o>
References: <20260128145344.331957407@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212722-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1148EAAE67
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:20:45PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.8 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/21450963930/job/61779347640

