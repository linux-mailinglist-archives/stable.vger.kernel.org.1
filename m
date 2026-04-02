Return-Path: <stable+bounces-233002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONRqKehbzmmgnAYAu9opvQ
	(envelope-from <stable+bounces-233002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:07:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A88388CDC
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 14:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CB4300C01A
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C837C93A;
	Thu,  2 Apr 2026 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfhhyVM8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3EF3033C9;
	Thu,  2 Apr 2026 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775131460; cv=none; b=Qb+NWinNPosWawnCVfhP0Mv69idPwpDYHvKT/PUp5ezXYHDsZGTp7ILMD923jADoiTYaJQlz9aY7Ig0jAJMHIcCiRXtUWRNgurWc8kva0ry2Mqf4jigidWRNKdb3C9TNon4yKsEUpiMYSGpNi294KNHi20SYFlhbNv7Sye8kvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775131460; c=relaxed/simple;
	bh=H/DI+0QnOH85c92H8OUlR+gys18QWjeEFzHofdmAGpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdVnfpL5LVS9NpEalkXRQiK3EzdL5x6kfx9UbHpwmE+0S93ylNF/AiKRvtCf2dv1C2oDg56sMSvs5zElm/Y/CnXP91z2W0s3totj6OkmCs+Wqdjtt7Vc9Swkd2AbegT1b0WeDByGCtkpNuIi+UVVWVHCuzrQwh6s06qSy9Q+mOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfhhyVM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93591C116C6;
	Thu,  2 Apr 2026 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775131460;
	bh=H/DI+0QnOH85c92H8OUlR+gys18QWjeEFzHofdmAGpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfhhyVM89DqswI3M9I2xSvLBBk1ebumAhGGU2JABufqa8g402SaQle+37lzxoAPU0
	 VnehrJS2lz171byVu9fWltAp9w5F2EcFxJ17rs23Ya32LXV8w+Th83B85x74j6OLl2
	 ifHGCbLA5mF2e/dFo8lrw8nj2xbmFMNM04bhGqNGPWIdo2P9aI82VFKGxgoUdlQowU
	 6587Jn56jr8eFM9uJ8ysZDYHnzLst12dIBft6OjTZbUE6R4z0+XtLdQPh/w7eL9x3J
	 wdDklDupl8Co9RSry/prrJbBTXgwVBfO9OH0KBT9K4HPlLWrY6WKr7+6oWTLdWUhcw
	 sUUeu0Ir89HKw==
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
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
Date: Thu,  2 Apr 2026 14:04:12 +0200
Message-ID: <20260402120412.116239-1-ojeda@kernel.org>
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-233002-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E4A88388CDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 18:17:13 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64 and arm32:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

