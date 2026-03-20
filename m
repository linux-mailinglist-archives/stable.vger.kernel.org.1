Return-Path: <stable+bounces-227406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB9cH36bvGlS1QIAu9opvQ
	(envelope-from <stable+bounces-227406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:57:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D870D2D4873
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C066301E7EF
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFAD254AFF;
	Fri, 20 Mar 2026 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGv5Wgaz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2724E4C4;
	Fri, 20 Mar 2026 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773968248; cv=none; b=o5WL8lqEE/SbkEUar7IF/cp1AvAWVFbkGG/ypbxzGVrp0MRb4VhM//qmhZO2TVRUOACE2K+GA0A5bsyrksSjrXYfZkPFC1QYhDy+ZEYuW/eB8ImX/LCSkoDW9NxA8AKqqdq8Wf1Ugr9QgiRVp0Lf5TV1e7CMiN4HlYI+0sH4V5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773968248; c=relaxed/simple;
	bh=W+9HJfJPf9wqFCI6oCCSaTyhBlCnoUFnn4yggbcrPKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXG9WwsqBGpq+OmaowxmpTiyHxGsyj+0iC8uX3Ss1k0RbqHNcddn9/k1R1e8PWqv/Z31mofMahQHGv+mvn3QLjICyGt9mEvjthnfI+n8vaDdF2XbGX60NYRU4exeCF/FNiT9GmhiFqR5Yjy6PybmgVt8diwx1dq595pDDtAxi/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGv5Wgaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758FBC19424;
	Fri, 20 Mar 2026 00:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773968248;
	bh=W+9HJfJPf9wqFCI6oCCSaTyhBlCnoUFnn4yggbcrPKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vGv5WgazTcd1qYIK2AbTYeUb81oyFzxTh2hUxvCMCKhvyiWkBFvqtdgZC+hMYlu/l
	 wjOLWEnR3i3d+LDfVHihpwGJHuFo9V2Pj29yYCXobcn2LXkhTuqagY68RKk3mRj3DX
	 JRpMLS7VXuh2bjVsfRmneEFeEtI6Jz0rJ/8QfEH7cF1kA8tVgECQcyOcFP+OOtPdd+
	 0HTDry5ZVWs8F4HfLVegxdkTkvY/ocjCUTBkUdiNw6mohe6Pl8JeOtBJwWncCxWcdJ
	 hOoPPDUStEYwDhmEkjJgygLgMl/OjvoKhDW3FGqDUrFcBIO93AEwt7HHUyVZx+5j/l
	 8zu3N0yHJ3cYA==
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
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
Date: Fri, 20 Mar 2026 01:54:39 +0100
Message-ID: <20260320005439.10312-1-ojeda@kernel.org>
In-Reply-To: <20260318122547.233850204@linuxfoundation.org>
References: <20260318122547.233850204@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-227406-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.837];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email]
X-Rspamd-Queue-Id: D870D2D4873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 13:28:05 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Mar 2026 12:24:39 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

