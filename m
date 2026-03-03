Return-Path: <stable+bounces-222951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHW8AVtVp2lsgwAAu9opvQ
	(envelope-from <stable+bounces-222951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 22:40:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFD11F7A9E
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 22:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0C4430C99BE
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 21:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F993932CA;
	Tue,  3 Mar 2026 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKcvcdNp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1403932C0;
	Tue,  3 Mar 2026 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573941; cv=none; b=UpIdmEqJrwnKCBoyNnakQW+clGHjIHhFQj0YeNTg3Hhey5R+shxOUa9IQoJIinsggPpVGM9w5owSWJNKHAZzmw9gokvb1+uGDVqZ+Ow6sJuLoDkzpZMFmMChC0d7PL51NXcyET2aov8ZT+6RiaA9YjzEZmG1DDdpY1yWDsTaiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573941; c=relaxed/simple;
	bh=U7ZFCbxawuRe+hdYIuarUL2nQMmYvnzS5IzPDFe0a8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QraY8TVSlH7cEZtWkQ/TnWF2WBHCNJPioFDxo0zaCAfNhcf3v9jvGWYYA9tXfDx4QQPIMpnlABXXXGmOEI6+06vmFZy8IG6Q8l0LqiJfGRWD/bUjz+qt6E5B2/pth+LiNVE6gZeMv3UdqBuP0KFpaqOmKyw4yOOECMfdTTwJh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKcvcdNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35ADC116C6;
	Tue,  3 Mar 2026 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573940;
	bh=U7ZFCbxawuRe+hdYIuarUL2nQMmYvnzS5IzPDFe0a8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NKcvcdNp95/c8/BD5c6H7TYjOVNKR9DSCBJQdfprqGL6hjZuAUUb+ohv/7zuV3zE6
	 UjqovkD2gk/tl1k0Khq1LVuNwlr+w8aKDwELNnFnjtl1g7OlXYgZmFB55KFfu8dw2l
	 5+JpaVZMMlRLxOibwCyE0VS4ydEr/YWC1BRKAwJv5g1yGONBIfWjH4OYCbYx/A4i8Q
	 p5oQ2cS7u5rxhnLba4IPAeZrfnYaoyTeduQK4gApEoRzZy4fd/7YWEH2DbQc1xp42E
	 N4i1kDn03QZJq/iLFMlhiuiBBlQV5IIXdOyRrpI+VgnZXobMlQmqQky278TH5S114v
	 VChD9ywiWfy9A==
From: Miguel Ojeda <ojeda@kernel.org>
To: sashal@kernel.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	gregkh@linuxfoundation.org,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.18 000/757] 6.18.16-rc2 review
Date: Tue,  3 Mar 2026 22:38:50 +0100
Message-ID: <20260303213850.111796-1-ojeda@kernel.org>
In-Reply-To: <20260302160853.2519610-1-sashal@kernel.org>
References: <20260302160853.2519610-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FFD11F7A9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-222951-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 02 Mar 2026 11:08:53 -0500 Sasha Levin <sashal@kernel.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 757 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:08:47 PM UTC 2026.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

