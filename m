Return-Path: <stable+bounces-219856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF6ND96ooGnilQQAu9opvQ
	(envelope-from <stable+bounces-219856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:11:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA91AEE7F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 21:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4488E300D349
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853638B7BB;
	Thu, 26 Feb 2026 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubgQco5k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6B36492B;
	Thu, 26 Feb 2026 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136665; cv=none; b=BSDTLTEYUR/2S/0RZKv1dssWkTRdcrVlySITARRn3TrAdwIGpBsXiH9f6q00uY4lzob7oHw4xDnMVlq48Alh3PvwNBLsiCjTV5hxz//blkU6ARVXOldzKQ/H0sRuzVZ7VBYv0f0SjBLMNjtJFCis8xC//KXf1OOfPzhYiyINVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136665; c=relaxed/simple;
	bh=s34e0Wjb0ayP9vCKMroZlUYMDH9ud56Kx7tEGJQ0BKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf2ymXSzzttGoKUavCvMPldfEH4Ii6YYF7JNhFymQAJSrcv4sUK20qFLNK78JzYjAEHZRd5NqdjBjOHIw+9eD54gbOJEC2GeHYi9lcmTMLVv50KOgzdt0JEp4ifJn/bxjoK5VMhCXxwzYKnKUXPrMhRACODbSIU1zPl9Qw2jsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubgQco5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A0FC19424;
	Thu, 26 Feb 2026 20:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772136665;
	bh=s34e0Wjb0ayP9vCKMroZlUYMDH9ud56Kx7tEGJQ0BKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubgQco5k+UidUNzHA31BijpSGMTRZld89UTdGaotCoClE9sULQdYBKDJUjonODWYg
	 SY/08h3Ptxe30qYDehpnZA8tZIfy5bfCd8XOF1zE2PWWXSmuq8DUDz1h7tQfk49zlZ
	 WCd3mOkPvk0WSIhigtbqnhl0euzLz82jYuaGa8p8wQWsVGuJBtFcd4ch3VXz/sNfyD
	 xTFnys0PXAcYK0UC803HMa703oFn/lp9HxukH9qUTxjhFqHLaCJpJn5NBZ08XKSb6H
	 b8dXPxKrg8Zap6dRoR/ITpVMClmhdL4JmEpcz+ebsM+WOnJdov+rAP8H3NKNMId+Ps
	 x01ozKVxVoCMw==
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
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
Date: Thu, 26 Feb 2026 21:10:56 +0100
Message-ID: <20260226201056.28728-1-ojeda@kernel.org>
In-Reply-To: <20260225155341.094945851@linuxfoundation.org>
References: <20260225155341.094945851@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-219856-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: D5FA91AEE7F
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 07:54:11 -0800 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Feb 2026 15:52:18 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

The drm/tyr build error (`COMMON_CLK`) is now fixed, from 6.19.1:

  https://lore.kernel.org/stable/20260215023627.56245-1-ojeda@kernel.org/

The fixes for the other build error (`COMPAT`) and the warning
(`unwrap_or`) have not arrived yet.

Thanks!

Cheers,
Miguel

