Return-Path: <stable+bounces-224828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMNvI3WAsml2NAAAu9opvQ
	(envelope-from <stable+bounces-224828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:59:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABD26F4B3
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BED3302DE69
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D01D38B153;
	Thu, 12 Mar 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmEFtmWg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E1377545;
	Thu, 12 Mar 2026 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305959; cv=none; b=htbLeSsHd8oggoV6PSh5UHkjBZaaggvpR7oYMWdZjpNWz4yDEMqyx3KL4ZL9t9gUaTXOrHk2e+PMqjWmBkKskGEaUS/IuWHBQtDxxj46AYKtgK4YjYBWlO9RBf3WfoXCqXCXv5ykZXqc3oPSWkalXq4MuVkITMlh/rKu1ER9ClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305959; c=relaxed/simple;
	bh=VxRh3Gi+LKeQFzsewJZK8KdO+sEs+EFmTJ3fvwePi1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxGsG7WiCqYr1Z/QwYUHfoVmp7FZSzMHI1o8dTy7k9l38OgRlOagEUUvFZtmeI4+xiPNz+HOdVizVRMoEk3bDPxoBuDLshZTETbIUwmizzdub3Fx3mkcp/hBluKGEd9ErvLCwJZX3UZw8XoY9vyvEVtPLYbFyw5HiflzIr+Bpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmEFtmWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCE4C4CEF7;
	Thu, 12 Mar 2026 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773305959;
	bh=VxRh3Gi+LKeQFzsewJZK8KdO+sEs+EFmTJ3fvwePi1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmEFtmWg4M1vh3rZQA9sq7FHkYIe73gK9zzzE9kqoYIy0O7XxAcjftIHj4yOsYrML
	 LgomzMMsS7017/TE8hUFAfuQcVfmHK4w/Ui12OFO+GyvXBydrPk/3yVbs5E7Fucn8B
	 RoKHERJG7kQGFCKiBwn5f/6vGuH/YKJ4r80oTKsodIVdlBJHbXOzieDGSoGb1dVi58
	 H0v9DUnVszdAA5h9381ptC7xICGmsSoBuCTiPC4tStOvY8Q/jbqZlqi9NuIJlNLfIZ
	 E5ruKYrORoNQ09fVMGyvyvpkRDRkYSY3LGfHSCyfzB97pko+HxH4IwSGkxfG7bNKsP
	 GoscN2z1OBBVA==
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
Subject: Re: [PATCH 6.18 000/314] 6.18.17-rc1 review
Date: Thu, 12 Mar 2026 09:58:58 +0100
Message-ID: <20260312085858.56396-1-ojeda@kernel.org>
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-224828-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09ABD26F4B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 07:19:29 -0400 Sasha Levin <sashal@kernel.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.17 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:19:16 AM UTC 2026.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

