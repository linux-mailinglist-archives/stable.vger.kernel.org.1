Return-Path: <stable+bounces-227041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGSrHyiTumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:57:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78772BB2AD
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB35230EA37B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587CD3BA24C;
	Wed, 18 Mar 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugjzPJgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE26383C8E;
	Wed, 18 Mar 2026 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834850; cv=none; b=NggIRQ6ySzYHIE4TBi6HzYocnA03JeC6eTYQBtq7R3PEdGpjkig21uWbYpAcETx7T2dkgCv2BFNAEbdPBnv9qRAtSu1kgMAbFWVlr/36HjPloXws5g1pGR9yUAYvC7thFAJQE40aON1lqIMXJF6OXhs6DMk9N95BHiQzBTA/SfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834850; c=relaxed/simple;
	bh=xna2Qv5/4+vYiNyKiIvdpy6Tz/hk4ZsegI8AL++TUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFqCGPEda1Cfyo7XS2y9eHbYpxDza0Xvny6/wJlsIt2X4vkIOO9Zx+FU+HlkiSBbNlUi1W0piDxUPF+7vYP9HdhjZE/O1FBRE5xGlh6xEfFvi3/A1+9clpGSB65Mwa3M8fmRUgqwZhwSa4NrXQppRDmuiWTRwsm4q/oS0ZyOPew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugjzPJgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF4BC19421;
	Wed, 18 Mar 2026 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773834849;
	bh=xna2Qv5/4+vYiNyKiIvdpy6Tz/hk4ZsegI8AL++TUYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugjzPJgQ7DRRP69RVdAJY8t3Uv9V1CwLtCVR84vqoLFGvTEVGID+/auVpthB2WT//
	 4Hb1EPt7hvDSeO/SU4dm/KzNOYS6fxqBY7knlmTrEijR1Pr6UCBbPXuqWhFFIWeVZv
	 Iy1lR4e46ibvP6zprKdttsvdozU5zTGbxyW30tYM=
Date: Wed, 18 Mar 2026 12:54:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ronald Warsow <rwarsow@gmx.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, conor@kernel.org, hargar@microsoft.com,
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.19 000/378] 6.19.9-rc1 review
Message-ID: <2026031858-ungodly-corrosive-37eb@gregkh>
References: <20260317163006.959177102@linuxfoundation.org>
 <10df8843-67e6-4830-955c-befc783f25df@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10df8843-67e6-4830-955c-befc783f25df@gmx.de>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227041-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: D78772BB2AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 06:47:30PM +0100, Ronald Warsow wrote:
> Hi
> 
> compile runs in an error:
> 
>   LD      vmlinux.unstripped
>   BTFIDS  vmlinux.unstripped
> WARN: resolve_btfids: unresolved symbol kthread_exit
> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> make[2]: *** Deleting file 'vmlinux.unstripped'
> make[1]: *** [/home/DATA/DEVEL/linux/Makefile:1277: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> 
> if I do:
> 
> git revert f5ee297b23d843d4ae690595aa29e8f5baeaecf9 --no-edit
> 
> see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.19.y&id=f5ee297b23d843d4ae690595aa29e8f5baeaecf9
> 
> 
> 
> all is fine here on x86_64 (Intel 11th Gen. CPU)
> 
> Thanks
> 
> Tested-by: Ronald Warsow <rwarsow@gmx.de>
> 

I've fixed this now, thanks!

greg k-h

