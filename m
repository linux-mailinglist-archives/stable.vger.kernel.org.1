Return-Path: <stable+bounces-240185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHAwEI2U52mp+AEAu9opvQ
	(envelope-from <stable+bounces-240185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:15:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3412643CA10
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2345308A01F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203043DA5B9;
	Tue, 21 Apr 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xhoV2oJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26F3DA5B2;
	Tue, 21 Apr 2026 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776783752; cv=none; b=hQE5/VFaX2s8iMT+sERTVeQutU1pPtOdNhIBgg2J9IIkMsX6y+QAr3IODViLwN60UGdZMU4JT2D2AeRR3rcY1pq/kVoYkSryG9Y44dgI+5BwRv9J25hYymv4znPujQRDHffi4JZzYfXJ3rdWfjgVJdD0QgO+gB4W4gJ4CgKUddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776783752; c=relaxed/simple;
	bh=qvAuGgRLIUHK46coKMc1+qO5ZMSNpH4DPMh0ih0C7Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRLroyPUlKAk4q8dL6PpoTFPz/iW1z4yt55HCtuqjpDWmp7fCofg9DhaN+X7zvxaeJXhaC7pJF0hfb4M6UpkHpynQfeRuw1Li69xLlTitr1YruQ79///eU5gRxtNCzLAVZkU97Kq/uAws6rzqgUfa2Y31HdKh4tV47TmtwZLvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xhoV2oJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4906C2BCB6;
	Tue, 21 Apr 2026 15:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776783752;
	bh=qvAuGgRLIUHK46coKMc1+qO5ZMSNpH4DPMh0ih0C7Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xhoV2oJInvEpJHszK8KgLKDDoJGtFVQdIDVHKEJvIk6J80/zMqTcxVSXvcXx1/yEA
	 FLtrG11J66JQZwAY09tQl5ICak8rqUsACOwrVzvJyopvlgzSzi13kIFo7ebJmulIVx
	 sC0OaQ4qJCH/kFsfEIYypAVE633eTe2wp/4UPXHQ=
Date: Tue, 21 Apr 2026 17:02:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/198] 6.18.24-rc1 review
Message-ID: <2026042122-refurnish-silliness-47f1@gregkh>
References: <20260420153935.605963767@linuxfoundation.org>
 <67def94b-6ed0-4000-be08-314f30c7a923@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67def94b-6ed0-4000-be08-314f30c7a923@sirena.org.uk>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240185-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 3412643CA10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 03:04:33PM +0100, Mark Brown wrote:
> On Mon, Apr 20, 2026 at 05:39:39PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.18.24 release.
> > There are 198 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> This doesn't build for arm multi_v5_defconfig or bcm2835_defconfig:
> 
> In file included from /build/stage/linux/include/linux/srcu.h:59,
>                  from /build/stage/linux/include/linux/notifier.h:16,
>                  from /build/stage/linux/include/linux/memory_hotplug.h:7,
>                  from /build/stage/linux/include/linux/mmzone.h:1538,
>                  from /build/stage/linux/include/linux/gfp.h:7,
>                  from /build/stage/linux/include/linux/mm.h:7,
>                  from /build/stage/linux/arch/arm/kernel/asm-offsets.c:14:
> /build/stage/linux/include/linux/srcutiny.h:14:10: fatal error: linux/irq_work_t
> ypes.h: No such file or directory
>    14 | #include <linux/irq_work_types.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~


I'll go drop the offending commit,t hanks.

greg k-h

