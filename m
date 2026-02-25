Return-Path: <stable+bounces-219194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GH0L72QnmnTWAQAu9opvQ
	(envelope-from <stable+bounces-219194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:03:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D81923A5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D55304A319
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FA2F3614;
	Wed, 25 Feb 2026 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cWXGeDVj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF42C21C2
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 06:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771999403; cv=none; b=m/CBKtVLtGHxkWt7/QqvN4ekhWUFg8qzjSRnqKfqq3lkHpw17Su7IEyxF7s28NG5lNoPpfXVu3rifw5Qwq2oga5Xfau2QeZldY5xMhHn+kiEQ4G6gkKXIVOXObs693Kb+yWJQ3820GlCFrin9k+A8cGsY35Qc/vZR3TIdVWq/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771999403; c=relaxed/simple;
	bh=L7v49LM4lCsZ+L4lXv5UKTamNxG8cMhiIDrHbw4AA+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AED/2BlJ+EP/kpWBkHsSiZT4mFOOpUPrOAmkvNr3Vv6Mt7kPw0s/nbYf4YBueIjqJibDqOBHRKRK2qnHTvlltOs07OR/MpR3VMQ2qoXi1p6cyXRo8IzXPfkqJsDjmpgAQRYTuWof0ps7dmFoEHi3fWPhQOfPTHPDsS+eY65AvdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cWXGeDVj; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48336a6e932so38245485e9.3
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 22:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771999400; x=1772604200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWLAwkGbf7uUhd2DqbFT3Eii2hgXjNWXQkU70sx9YHs=;
        b=cWXGeDVjko9n4Ykfkxo/iVbjN0Ch+BNYpU6B3M0yntmhFHHkUbmjImsyzca0icBk/2
         Xbu1InsYfDSFjk5XmtPUinVrL1GpQBNYe6ysA2Jpe2qSbZ/O5uMxkA8ASV63nR5qLV2B
         s066Pr46qgH82rW6D2CiuVJnYhtnOGh/7+B3WQ01S19oTLjfioB/f0tDkMU4VgMuGvI/
         1En1v7frmGE59ERujY6fEwR6XEgFawd7iuWncGpuYn0cLPj0nVxo1KdXLsEVqdnkHBp7
         L9Pue0GHGldPJVH+wGvx/nucEfGEpY1v50lhdj9kGpzloFODwKBwRL69jHIJebLcx66y
         bFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999400; x=1772604200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWLAwkGbf7uUhd2DqbFT3Eii2hgXjNWXQkU70sx9YHs=;
        b=LntfNTFCstz8WdWO9H+1jTF0IIe45SdEw2le89ymR0Kzk1P+U4rvwy0kEEyJfIIWZf
         6DnJvNEpAfNh+4SFoTyeHvaoC5e5Sp86K4ZIBvqIwSz6pSh1XAQsXzyoIIqZhIAhT/Gy
         sFDhN32y4lG4Q+c6vL51LkkgL1P2Vu7McPaHapOnU/J/35VaZUmxqQGYdjcwMv3wk9cL
         Xu59/CUMbMp0oPulMlTkcCcAjJ5n4CO1XZZHfGhlF7lwRAlWnemBLQzI1aV21et/CKr9
         VvHDflDdEln7nz1iha7f0heeqfmfa4Q/YpxuFLAyaWPynxXfH+bts/VP+NpiIS234ZS6
         FWuA==
X-Gm-Message-State: AOJu0Yz5aow4s1NkUDGICY/ExAsvaYFDGkiK9+bpNoDbfVk3Do0mSbjX
	ZXqUzHPyyE/Ag1xN+d+vRnwegV7SpCYHD0uw/2UV/Po9sN6pUrlFoCA2URPQk9lYuaA=
X-Gm-Gg: ATEYQzxE33ZO/inMOWr0cIISIrAAk0JRgNtO7EkHQIaqQRlsrmCsSehW2TPjQBSIsT1
	zUgKXzfFsi8g3mbmp0Uc7FI6TfLSyJ0qt6UDBOBeZ+YXRmSxgxl+y3q+dD4R9j3j3sYVPfML01v
	vu2zP8C3qUdpKuKiThGYsERS1KJx8pZqXz9oPlHjw0DCf9EWhhEYrso7+9uX6Scz2TlinjGU8jm
	r2OAi0X5JYB3U8tGxGhJebmgDIHQw/Gsl8thlPlq2lkNoEUSjoyc9ouztrL1SjeTsgl2/VFrSuc
	jMA1MLtSRd3U1Mm0bwHvGm8ulzm4A4cRH+IoMPWcwbhCss9XdGYkXT+nXx2YRUTmGCfbw34RGXi
	h3RyqSKXiCKOs/r7ppobsAF2sEeBRIUDOXs0TgwiKizFvg0T8onHEoCjQn4HJbCiKA87giAppwU
	0hJeJ4luim4WRTCMg3Hmy1xYuJu5G2Lmb4Twkg/PS22Ya9P8ZX4h4LJBsJGtGb/BDbkgig3xGVe
	53z2ihezZOAvt10m7ZY
X-Received: by 2002:a05:600c:4e4a:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-483bef2c0eemr23684675e9.14.1771999399921;
        Tue, 24 Feb 2026 22:03:19 -0800 (PST)
Received: from u94a (2001-b011-fa04-7b92-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:7b92:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5dae6sm131631065ad.21.2026.02.24.22.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 22:03:19 -0800 (PST)
Date: Wed, 25 Feb 2026 14:03:11 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc1 review
Message-ID: <xidiil74eoo2ivxxekipdwi53slry3naevkmeee4zsuxl7iw4u@nd23dorketj6>
References: <20260225012359.695468795@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-219194-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 275D81923A5
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:11:49PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Feb 2026 01:22:34 +0000.
> Anything received after that time might be too late.

test_progs, test_progs-no_alu32, test_progs-cpuv4, test_maps,
test_verifier in BPF selftests all passes[1] on x86_64.

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/shunghsiyu/libbpf/actions/runs/22381308704/job/64782419806

