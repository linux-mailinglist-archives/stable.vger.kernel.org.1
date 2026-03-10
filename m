Return-Path: <stable+bounces-223845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBsEDXXpr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:50:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4334248D66
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D278130470F9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E940279907;
	Tue, 10 Mar 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6jOYhkN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294536921E;
	Tue, 10 Mar 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136114; cv=none; b=umMUP2jZrWa04v24lx1uLFfwaJEg2kpW9pT3xY0F9mDdgV1euq5bfTrSd165GWIY8GsKe3cVRNCOxspCD/Tuyj9ZFxVm/LiEprqnBoTvZaaN6iFT3tpo0QG4T7kM0bGPU3VCjXQL3TzI6rxL6QUxvZIJDvDMD3oL4ufkefNpJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136114; c=relaxed/simple;
	bh=L1yvzOSxU9NCf04mh5XL35W/zpGczWoYGgiPaoSk1Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2i+sO4rMqZkCGdPdyY71vZ0b8TCfGsIUhRMMLGncN+P8fKP5UEyQ/z2aOP2x0VlshalJElffMrCMN9gHXZA7S9SepEa2XVeoVTD1S91tYKEDLbdXawMsLTeb/uFR8M4iTkoFsUoUdgstOR1ApJ5Y+MXIWsC/Co3CnKqaZ3QaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6jOYhkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E06C19423;
	Tue, 10 Mar 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136114;
	bh=L1yvzOSxU9NCf04mh5XL35W/zpGczWoYGgiPaoSk1Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6jOYhkNNJZz9jOIJ30JvKt+vBnQZTS4tAr6Jl9xJ558Yr+lzj0i8+OXoNZl57bOv
	 KGgqi28y9yy/EyhH+AiIYnLfMk8qcnCW0184y6o4m66Hp6ygXbgj6E2P2QWAqrpjjv
	 cvkt9N1o3yRBTfrsGds2O4Zv9WiqB4cj08TQHTiCfjTVOUgucs+tb0NQDwPwO3eFls
	 BE9kex6k1+/yZDkiwYnTQC2GaRym+ZKE+dCWssCeOuePasA8GNDB/S3cmkRX4xFg2a
	 h+HAT0fBHEI2S24vCw4nOQtVl468+ZjP9FnMSGNKULDmgH8ByJecZJmzoqbVjZhRav
	 0n08xcC7M6b5Q==
Date: Tue, 10 Mar 2026 05:48:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: Patches not posted as reply to stable-rc reviews (was "Re:
 [PATCH 6.18 000/757] 6.18.16-rc2 review")
Message-ID: <aa_o8WKGFjhRUPgx@laps>
References: <20260302160853.2519610-1-sashal@kernel.org>
 <iy7dogrbld3h5ygezzkhp3sebokfibu5suegpidlsrmp2ibfwd@fvstv7j7dcfm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <iy7dogrbld3h5ygezzkhp3sebokfibu5suegpidlsrmp2ibfwd@fvstv7j7dcfm>
X-Rspamd-Queue-Id: A4334248D66
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-223845-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 11:16:37AM +0800, Shung-Hsi Yu wrote:
>Hi Sasha,
>
>On Mon, Mar 02, 2026 at 11:08:53AM -0500, Sasha Levin wrote:
>> This is the start of the stable review cycle for the 6.18.16 release.
>> There are 757 patches in this series, all will be posted as a response
>> to this one...
>
>It seems that patches were not posted as response. It was for 6.19, but
>not for the rest (6.18, 6.12, 6.6, 6.1, 5.15, and 5.10).

Yup, they ended up going only to patches@. I've fixed that.

-- 
Thanks,
Sasha

