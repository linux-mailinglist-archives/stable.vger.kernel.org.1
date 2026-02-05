Return-Path: <stable+bounces-214464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPf8NhGkhGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:07:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF92F3C47
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32D2D302B834
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E0C3EF0B0;
	Thu,  5 Feb 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmQprvlr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4293ECBF7;
	Thu,  5 Feb 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300086; cv=none; b=rprCGFFwxLGFClf9N1VOYlQBbWmeTdLmIOPAm48WeXhn+RKX9pVA9IacJ9KM5m4SKWNu0fdwsi+UKVCNMPMiuViO0laBUjR/EUlgkSvfeQm5SS7TPxB3tdwj1NM+6W4M33AZ8dFOsi0XjqyQjwvukqegkvF4k1H2Y3kHFNIBYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300086; c=relaxed/simple;
	bh=zQqDDHO3edTEQV6rHB9E0a7k1wOd322d2OJc0Fxsd0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+ErEJE76S3gEOYfI+L086d+7lRq6jYAvzMOmx993Is2lRLnl5Zspcf0taSyPHrx7jCfHFFO0B6VenHUl+LIc9TdDQxVdLOhpp3O/X0IGjRJLay5nmiVdfaaq4GnrXP6csPnbLHk/yAMAvGRnyquLpaRw8G0Uj8+NexKnkqpcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bmQprvlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67341C4CEF7;
	Thu,  5 Feb 2026 14:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770300086;
	bh=zQqDDHO3edTEQV6rHB9E0a7k1wOd322d2OJc0Fxsd0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmQprvlrTF0WrZej/9Hn2XF/OmZ/Gsuf1bzLoyPuCLrNeM8w2ITACvf2PislTnQQK
	 f/9S5WqwfSktzFzzvCs+/ost5iaHuYhg7gGfRikZw/1WRvrPkA35bb6EUKDGtsTIKi
	 6RudoavmxCweBPH4Hn3DE05G32SygvlSYCJmQ1j8=
Date: Thu, 5 Feb 2026 15:01:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, sr@sladewatkins.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.10 000/161] 5.10.249-rc1 review
Message-ID: <2026020553-dazzling-quack-dd44@gregkh>
References: <20260204143851.755002596@linuxfoundation.org>
 <f6280336-4e59-47ed-876a-bfb62252ae52@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6280336-4e59-47ed-876a-bfb62252ae52@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214464-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9DF92F3C47
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 07:54:47PM +0000, Jon Hunter wrote:
> Hi Greg,
> 
> On 04/02/2026 14:37, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.249 release.
> > There are 161 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.249-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > -------------
> > Pseudo-Shortlog of commits:
> 
> ...
> 
> > 
> > Johan Hovold <johan@kernel.org>
> >      dmaengine: at_hdmac: fix device leak on of_dma_xlate()
> 
> The above commit is causing the following build error for 32-bit ARM with
> multi_v7_defconfig ...
> 
> drivers/dma/at_hdmac.c: In function ‘atc_config’:
> drivers/dma/at_hdmac.c:1323:34: warning: unused variable ‘atslave’
> [-Wunused-variable]
>  1323 |         struct at_dma_slave     *atslave;
>       |                                  ^~~~~~~
> drivers/dma/at_hdmac.c: In function ‘atc_free_chan_resources’:
> drivers/dma/at_hdmac.c:1583:9: error: ‘atslave’ undeclared (first use in
> this function)
>  1583 |         atslave = chan->private;
>       |         ^~~~~~~
> 
> 
> This is also seen with linux-5.15.y and linux-6.1.y branches. Linux-6.6.y
> and newer are building fine.

Ah, looks like the patch fuzz caused the variable to be declared in the
wrong function, let me go fix that up...

thanks,

greg k-h

