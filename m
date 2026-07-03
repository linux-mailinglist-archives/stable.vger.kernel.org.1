Return-Path: <stable+bounces-271665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6PFDAldkR2p2XgAAu9opvQ
	(envelope-from <stable+bounces-271665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:27:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7296FF888
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 09:27:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qTjZHPYW;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271665-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271665-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77916300DEF8
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 07:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1B35675F;
	Fri,  3 Jul 2026 07:27:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D83546C1;
	Fri,  3 Jul 2026 07:27:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063633; cv=none; b=DaPk/pvaaLW23VBIJcqNFcIv7f6CHolYYMFIMGjJaPyaZrKyXXTgK2aT0o99/hGFrymaRadG5M/tGOyzDPmLhYvJaOBrz5f70oBkF1NE5/s3SK/lKqZ3I7EKSuZy+I1j/Ghrby8FOnefRV6YmM+OyAWEwZNoEsEzWsAGE0Ox9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063633; c=relaxed/simple;
	bh=s2Y5DFhew6+eWyE1hdcqWKC0jWo2nMlFQ1mt2zA8eW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrfOZv3GC5SAxXJhzgwc/e/gH6wfL9LGEoavZ1L/EafzNzCTk8sIPzBz1vMJ3fTRPqH4sAMyWRuDrtUjhD354eycDvhs7t0f0hRsTOy/tB/BJNCwzKTm4dKewdnlPgiMI4Dp6kyoT9d+6xvb3T6Cndz4MTgTNHPLN161zz3wUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTjZHPYW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92E81F000E9;
	Fri,  3 Jul 2026 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783063632;
	bh=VQ4rm3CbhGnRni3n8WlgLFja3FI/3wJNCIkaYVdupks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qTjZHPYWG8TMG7MoAyIZ3cpVZAPWc3V9sadU08riAJVxTnmPiq3gQ4ZVSzkLeK7LG
	 sCYGeGaEL/bZttFIVm8773YzAdeowf56CoI1CH+0QQedxlvSHA6FMNuJy14dU7WHQs
	 6+NODPyA9rLinP0E3krxxZU8SBcDkVNiqHEw2y5o=
Date: Fri, 3 Jul 2026 09:27:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
	conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, lkft-triage@lists.linaro.org,
	patches@kernelci.org, patches@lists.linux.dev, pavel@nabladev.com,
	rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.18 000/108] 6.18.38-rc1 review
Message-ID: <2026070304-desktop-hypnotize-d0e4@gregkh>
References: <20260702155112.110058792@linuxfoundation.org>
 <20260703031347.544577-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703031347.544577-1-guanwentao@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271665-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:guanwentao@uniontech.com,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC7296FF888

On Fri, Jul 03, 2026 at 11:13:48AM +0800, Wentao Guan wrote:
> Hi,
> 
> Build failed in riscv arch, log:
> In file included from mm/kfence/core.c:36:
> ./arch/riscv/include/asm/kfence.h: In function ‘kfence_protect_page’:
> ./arch/riscv/include/asm/kfence.h:25:17: error: implicit declaration of function ‘mark_new_valid_map’ [-Werror=implicit-function-declaration]
>    25 |                 mark_new_valid_map();
>       |                 ^~~~~~~~~~~~~~~~~~
> In file included from mm/kfence/report.c:23:
> ./arch/riscv/include/asm/kfence.h: In function ‘kfence_protect_page’:
> ./arch/riscv/include/asm/kfence.h:25:17: error: implicit declaration of function ‘mark_new_valid_map’ [-Werror=implicit-function-declaration]
>    25 |                 mark_new_valid_map();
>       |                 ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> You can revert ("riscv: kfence: Call mark_new_valid_map() for kfence_unprotect()")
> commit a8818008680a00a86c080a55e8842c714e9a62ba to solve it.

I'll fix it up by including the missing commit.

thanks,

greg k-h

