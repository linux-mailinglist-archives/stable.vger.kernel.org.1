Return-Path: <stable+bounces-271917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+LFFJVsSGqtqAAAu9opvQ
	(envelope-from <stable+bounces-271917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:14:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BC706792
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:14:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VPCsfIIo;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271917-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271917-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3834F30156C4
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B752D0620;
	Sat,  4 Jul 2026 02:14:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720E2E65D;
	Sat,  4 Jul 2026 02:14:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783131280; cv=none; b=Ls9F8iw7hmJL41aN4BdF+QHdDQN7LZsUcotd8hmOFQkQiFqADiXKIGvAaa95UCKQO6mfydA+38BQtJSFfML41UWPQSzvOZ1WAZwrdt+VlqBcdoY7y6fdi+LpvD/slKSzfqbW1SGVt4UdjRkKsygXGzesssAM39GJWkXXgupIdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783131280; c=relaxed/simple;
	bh=iAiDKQ4iSgz2XTfPLnYtaB0LborPCTmDt2NXeiKNruU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDGJYdCGcpk30XLRjl29ZPlanoaNH/cFpqhhN33GI/WC2vHu7QM9DrzZ81TrG7bCOkE3rMILI/D/bnq/1pa3Vayl0KRqijsnvZ7LDEVGZnXepppUqGaJ9WQzPH4fLul6N0PVLsjw34YeedCJwooGG6VTKjLYDBhFb+3Jo8YZPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPCsfIIo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500231F000E9;
	Sat,  4 Jul 2026 02:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783131278;
	bh=Q8awLyWEvNZ8C5VKMUmfBo8/3zR/FfAfrSD1vAOn6jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VPCsfIIoFzBTxJ/8UWSemNXuZPFHiOX0hfpb1D+wuhjcDdIm48U3azZnQ5uw0ejkx
	 AicQYfC0vpG8dnked8aqWuguVU3VnHTkTxVQcWvCM7PII2CemgCcJ9V4s8kbCaoEef
	 7eRTqjphIovVRdOMbsF+SjhKmA7MT8z2cUxkBopLZ5VgT/VXAJWnvcTSSVeyHfFdOL
	 WkR2EcaDHIrjy/k708wj0NzzRymYr8js4a3huN/N+JhcjmG4sGooqy7coZ+W5uXuN7
	 P8R2mueat4G6xFGmS/rmdZFqeenRm6dOo9ENTSBp8wKhvPXJpHREBFOymjvEfxGI9v
	 iRjxLHmpufNZg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
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
Subject: Re: [PATCH 7.1 000/121] 7.1.3-rc2 review
Date: Sat,  4 Jul 2026 04:14:28 +0200
Message-ID: <20260704021428.56685-1-ojeda@kernel.org>
In-Reply-To: <20260703072822.817328079@linuxfoundation.org>
References: <20260703072822.817328079@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271917-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:ojeda@kernel.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A30BC706792

On Fri, 03 Jul 2026 09:35:59 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.3 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Jul 2026 07:28:08 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64 and arm32:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

