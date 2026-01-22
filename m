Return-Path: <stable+bounces-211206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IY1HBzWcWk+MgAAu9opvQ
	(envelope-from <stable+bounces-211206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 08:47:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBC862A3D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 08:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F61F569D97
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 07:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B9F2C3768;
	Thu, 22 Jan 2026 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dsGEfRmR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A348165D
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067422; cv=none; b=oz/PWsKl0e8/g4e/xtOTF6ADBb67GcxRflL9Vfrw+5HlaX32oDewc25r/uBwdv4bEaaWWf/apBom+EaEAdZYrdPS9yg89Ji2Z7hb8MbjCvPuitBmOR37C6vbuuY+Y3+vEIZludYRMAkAJ1zBC9XE/THPD3h9DOiPtvXiHLydrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067422; c=relaxed/simple;
	bh=9lIu9NHGurOlG/hSLVW0gSCpdD5JPseXMmJZfF0LySc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd7Q+QVZu6moVuGefOoaCiTgaz/eN9GnI4D4EDQx4sJTzTD2BK+pBMuzQDXvBAvzUnbqpMivRV+BAGjEtWkWQ2q3o+2Y8Kw3yxNCuT6fTekZ3PLO4imbuHPftoLZM9DpgPqggAToe+mKs275ssLNKZQkRtP3WvxDLzuXhGl9Rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dsGEfRmR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-480142406b3so4339255e9.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769067419; x=1769672219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxWADrBS3oTdGLPh7T5lz54vVgDrPBRzG4Uz4lmhzII=;
        b=dsGEfRmR3QA5jKyCGdHlajFlwmWA7hgZezer+f5tCw0MyTtne7B+RYvpMl4168cIUX
         64phe6GFtrnoTXarvAOvNXx6KlEL5paTMamh0phCVnorijxUd5zGXNZDuumAgAuulmCc
         64VTkyHOPS84g6V9CA4HQnDIG/MUydOAXKKEt8PGGU6jnyTwG6+yvT1QiFehEvOj6igM
         6GWbnK0pnElV2G8l/V/p52gl770VgQjpHB6w7CP7CPmP5UHvUve8+3HIfIg9jeSc+TEZ
         AhFYzOJA4brhWTIaxeUrL3cWv8MqfY3gTAxpKFh3B3Scs/Q/k/wJQh6FREN9SGEc9wtk
         RfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067419; x=1769672219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxWADrBS3oTdGLPh7T5lz54vVgDrPBRzG4Uz4lmhzII=;
        b=mO/RvvQ3h7ZWTo3/WecJqELWZ1gVhV0anEnY30gbAcjIxajadEgdRRj2hGsJnasj3i
         lb022+fZqPZQK1NGTQ3UDD5NvXEHF2jpKuqRHVfgtBupgyA6vMEC1u1RpqKxKhap5SL7
         WM29ZE4DtduHNeoNthgEiqUqbHDLM4figFBzNv8+rKe82lUitzrOBZxt7xh+mL9nZgEs
         viMjq5OthEwVDLvM7rXm2xylh2ZAnIURr/ST3VLu4mtPPBqSdQa0Xlnm672NW9R9sz5e
         UpJ6FgprMRUoDO+QHphKZAfKzxZY7I/P5XyghF/nu9g2lNStg8tjSGGl3t0arF7R2KoI
         cowA==
X-Gm-Message-State: AOJu0YweWRM5J59aUOwoG99Me9Y9lT7xWYZh8Alow0JfsuwBaU6F6zNj
	ldW3XEPSkVpRRts7z6u45/shpZFEI8SqmONiGhkuhHqNmKFhSdTtOYzwKGtJ+eOQiK4=
X-Gm-Gg: AZuq6aJ4XdZ5usbGF23wGksWIfnR2CdK1IiP3o9RPJWqz2sAwLBGyJjsMarEfLiguxg
	trM5zGUA60LxTvBlVu6bdA8ZQOgahyPnJRSljeTJB/ctpXhenihRuYETe7T69Nx9O9y0hXwZtJS
	CKAVCwU3+qqkBHWuppKa95Vhi9zWwl1cKQ6mpEPyMX6ddWVODOVhWe247fYWp+L1SjmfBV1PwtF
	p2Q3AonmDU216xxA27sGRJsFL95z2rShspZV/jlKq/gNR4Ye/jwyqJTSD3Y4zrEoL3w1q5zVfd3
	6gRtYfS5LZUO30sUeLCA+D56Tdz8oco1ZO+77Z8DcOTR09m6uxZ2HuFnEVt+tV+HgtY59ap+oid
	cxG9e5g24BztDU2VeobPZv5wz2D74AgMCEeUOUrb/v/juEWFP/PmTrg+wRQG5/pa2G7nADy1Vy4
	SVSN2vl7Q=
X-Received: by 2002:a05:600c:8a1a:10b0:480:1f6b:d495 with SMTP id 5b1f17b1804b1-4801f6bd602mr218900255e9.32.1769067418656;
        Wed, 21 Jan 2026 23:36:58 -0800 (PST)
Received: from u94a ([2401:e180:8d84:7ad4:271f:53a4:d001:6caf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190eee4fsm172585305ad.42.2026.01.21.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:36:58 -0800 (PST)
Date: Thu, 22 Jan 2026 15:36:51 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/198] 6.18.7-rc1 review
Message-ID: <xpdd2zw4ckw2xfrpti6iif3qmf6syaalbhtcktyqg6spklcoyu@rtthiv4wvcis>
References: <20260121181418.537774329@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211206-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 1BBC862A3D
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 07:13:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.7 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes on x86_64.

Link: https://github.com/shunghsiyu/libbpf/actions/runs/21221602824/job/61107573538
Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

...

