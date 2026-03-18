Return-Path: <stable+bounces-226950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBC0IooPumk2RAIAu9opvQ
	(envelope-from <stable+bounces-226950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 03:35:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E61CA2B5391
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 03:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFDF3037142
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81B266576;
	Wed, 18 Mar 2026 02:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzmk9G0l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE01C3BF7;
	Wed, 18 Mar 2026 02:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801350; cv=none; b=RRiMu4SHhA6+NPjvKwUvYJSBnlXlukQ9bsSKjB6kzKl6Ps9qeXk+C8fZtLCo8efr9MxUonNdt/6sty0UuaOxsxHLl/lk6vd2899cusQaOmbLDIZV9j5KSgC6HPJbft2erAiBVTmVmvt+FqL1nL+f/d6dE544knaPosVgFebgQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801350; c=relaxed/simple;
	bh=YgYEbGMcgKDMjKUJ5LpHCqN6k+Uq7poYrxFG+RkjWm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSLYpICiHVFzE/bCj4TCtgILMbsNi4zV3Txk7VuRkIM1GBAXzfzmwv42QGJYjSBU+5yxwdM9UJIStgcubzscHy1FPpNhG0v3J/r/hMF1BPXbqNQuRxB1D7nkwRUkkh6fdPpVcwaMU5BKvjz313hYE1LAJnbf86VEtyTKgrGGICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzmk9G0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8971C4CEF7;
	Wed, 18 Mar 2026 02:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773801349;
	bh=YgYEbGMcgKDMjKUJ5LpHCqN6k+Uq7poYrxFG+RkjWm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzmk9G0llgQlaQqfyrxVdjUyaXpurAyq84qLh2H86Qypp6I+X9mN7r3UJeQkcAMjg
	 nJYdXNWe8KcYrZ+gmK50cgJKh3vtPsgWBREW3qd2Drn6o3ANszyElc7UgiK4VM19J2
	 j3Bpq9dEnVLgzlm3kB/4NeLM+soaPTQoxqO9hdpFOkHHC8BIohN8EkcWj/Jwggbew5
	 xU0R1Lx5Pjyi/3VP65AN01XQI11iAei9OjDBidIqkIqPKWKEvUH8yszGLjrHQ68lRC
	 Y4S5gT00PpC66pChYd9PesHJcX/+OuRm3+brq5E22XqaeX2I2gLqjd309ZU5/oojIJ
	 AH9jl19FTiJAg==
Date: Tue, 17 Mar 2026 19:35:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 5.15 000/410] 5.15.202-rc2 review
Message-ID: <20260318023542.GA2596820@ax162>
References: <20260302160955.2522727-1-sashal@kernel.org>
 <20260305220801.GA3148061@ax162>
 <20260316220533.GD1329928@ax162>
 <abiuxFzZNLKbhz6F@laps>
 <2026031738-glade-glamorous-eacd@gregkh>
 <2026031714-undusted-rambling-c2ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026031714-undusted-rambling-c2ae@gregkh>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226950-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E61CA2B5391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 08:39:16AM +0100, Greg Kroah-Hartman wrote:
> Wait, I removed them all, as that should have fixed the issue (I removed
> the offending commit that was originally causing the build problem
> here.)
> 
> Nathan, what errors are you seeing now?  None of these changes are in a
> release, and I don't see any i3c patches in the current queue.

Right, you did drop those changes back in January. However, Sasha added some of
those i3c patches back in 5.15.202.

I see

  $ git show -s --format='%h ("%s")' HEAD
  91d48252ad4b ("Linux 5.15.202")

  $ git log --format=oneline v5.15.201..v5.15.202 drivers/i3c
  cde3d9035e8afcb3b54aa233c51a0babb5013c67 i3c: master: svc: Initialize 'dev' to NULL in svc_i3c_master_ibi_isr()
  6cae2af141da60a68f9e733f69821c3ea457b0c0 i3c: Move device name assignment after i3c_bus_init
  acbd89719cb195143b5fc610c82e18f887631eaf i3c: remove i2c board info from i2c_dev_desc

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper allmodconfig drivers/i3c/master.o
  drivers/i3c/master.c:2203:3: error: variable 'i2cdev' is uninitialized when used here [-Werror,-Wuninitialized]
   2203 |                 i2cdev->dev = i2c_new_client_device(adap, &i2cboardinfo->base);
        |                 ^~~~~~
  ...

which is resolved by commit 6cbf8b38dfe3 ("i3c: fix uninitialized
variable use in i2c setup") upstream, a fix of commit 31b9887c7258
("i3c: remove i2c board info from i2c_dev_desc"), which was backported
in 5.15.202, as you can see above.

I merely brought up what happened in January because that patch was
already flagged as excessive but I guess it was a stable-dep for a
different i3c backport back then.

Hopefully that makes sense, let me know if not.

Cheers,
Nathan

