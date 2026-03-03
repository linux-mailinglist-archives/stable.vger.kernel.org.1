Return-Path: <stable+bounces-222948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICU+HRhRp2nKggAAu9opvQ
	(envelope-from <stable+bounces-222948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 22:22:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B91F771B
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 22:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A40330292C2
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 21:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071B48122B;
	Tue,  3 Mar 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V22ooqGf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE73D6CD0;
	Tue,  3 Mar 2026 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572930; cv=none; b=Sk7KmvbacUGlFRkGpliJY7zeO6O6Rt2VszuvEwNh0WsNQL5bRa4gnOngilZVkRECgHw3T597z+842G40AgBqu+joOS+1lRpzL/vspTS/axGuKxCVyNgqBo+5zxQAFbNsdKLo+At+gRdt1tYos+GEVgMBrbjkkSJFAlsewZg5k0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572930; c=relaxed/simple;
	bh=cfmRqDYupL0nIYZh7Gpxr3DN9OmWZZhVopkUo5vbjdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sl0aTagIY+c3G4OQuRZvTEIaC86lMEtoZ45oTSlMyzGRWWS02CmhIuDMXumavcjX+CxaU3+NUq8yd+/eO2s32b1ZLKILDs1VcAMRNsgazpmigQZ3nenWM0NopT966yduQOgbl0WSiC565/W/MVKXbGQ3rfOHu0U+pY5hpW02Bus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V22ooqGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE924C116C6;
	Tue,  3 Mar 2026 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772572929;
	bh=cfmRqDYupL0nIYZh7Gpxr3DN9OmWZZhVopkUo5vbjdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V22ooqGf+IhIT+l32sFICfAtXhpaDvXskNA8sN5wcHE62onIMu0pYW5iJ17OYvPcs
	 kln9M7bWC/VTG0Tx7WGnTF5zhUBlq3CYtP0beKiDswXG7LD8snDLipapplbEl8sWpx
	 2zlymcdKgYPGAks8TgRnbQj11VOqGs/n0N36E+kzCFiCdDqqQJPmWRSLQ1AVQbTxDd
	 KdfwJD84yUZOGtECP9zdz5nYsiWmtQTxfHXxT7ZDfpqX4I+AAizXrjpoB6fp5pAfdj
	 o6Y5YZxEdTO64o2aWjDgFGswhqUvUcvEfa5hvQyzGR27vcq7gHcZL/Ghm9S+nGQ3vV
	 yLJ7m0i//vc2A==
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
Subject: Re: [PATCH 6.6 000/684] 6.6.128-rc2 review
Date: Tue,  3 Mar 2026 22:21:57 +0100
Message-ID: <20260303212157.109234-1-ojeda@kernel.org>
In-Reply-To: <20260302160934.2521545-1-sashal@kernel.org>
References: <20260302160934.2521545-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC2B91F771B
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-222948-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 02 Mar 2026 11:09:34 -0500 Sasha Levin <sashal@kernel.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.128 release.
> There are 684 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:09:32 PM UTC 2026.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

