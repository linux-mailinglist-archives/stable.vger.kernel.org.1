Return-Path: <stable+bounces-227040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHnLHFeSumnSXgIAu9opvQ
	(envelope-from <stable+bounces-227040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:53:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E605E2BB212
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 12:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8143300DD61
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AB13ACEEE;
	Wed, 18 Mar 2026 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yyLPE9Vj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A2377016;
	Wed, 18 Mar 2026 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773834836; cv=none; b=jbSfiaV4CrwLx9HxMO3Mf6LmkGmmA68Pur4pCVJbJYfvAxZjbOzvbM6zGf0Ml6ePJeUuyzjRfgHvZCkXVLNkRPk/tHGPp9VjzssL7Yj8LxwG5Ns2NUiR60fAVQ4IG5gyKO1GgbA+oYqTxzVyKbvc4VN7yDHUDvOfyUujwIqNIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773834836; c=relaxed/simple;
	bh=qf0y+W47qNMUkAw3DIKWXqNujQ3TG3crJAmHUqsi0t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ3lXeF4ANXHI4ydSgWVrHqs3C6CYXKOZykP2hGfjZcMVJGLrblmGW1EoqMxWmG5w7vQ603u2+K2/0mvTF1jHx3jx/a4WVurL1+w/73yom4qQCc1sEK8h79CUfo5RRaZwykI2IJvu8JicFiTM577588LRXAAEKEkvCOO34WnCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yyLPE9Vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1D4C19421;
	Wed, 18 Mar 2026 11:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773834835;
	bh=qf0y+W47qNMUkAw3DIKWXqNujQ3TG3crJAmHUqsi0t4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yyLPE9VjtRCLuUkvn6wTYcVIT6YNyJsCJ9Lx2hYB/Wsx1BuSrHhzluOOOtmpx9eES
	 GtjRIbRmrTYdQenvt3Cv0wnL461w81Ev8w647b8eu+MOjbFcnaJNYGX73kVX3me4P9
	 f/F1Am6v9xkEQI/Z4RCj1y9k35A5AKVFizbYXbP8=
Date: Wed, 18 Mar 2026 12:53:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/333] 6.18.19-rc1 review
Message-ID: <2026031840-moody-liftoff-bcf9@gregkh>
References: <20260317162959.345812316@linuxfoundation.org>
 <731ff34b-3967-4a21-83e4-d85009c48f1c@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <731ff34b-3967-4a21-83e4-d85009c48f1c@googlemail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227040-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E605E2BB212
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:03:40PM +0100, Peter Schneider wrote:
> Am 17.03.2026 um 17:30 schrieb Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 6.18.19 release.
> > There are 333 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> 
> Same build failure as in 6.19.9-rc1 on my 2-socket Ivy Bridge Xeon E5-2697 v2 server:
> 
>   LD      vmlinux.unstripped
>   BTFIDS  vmlinux.unstripped
> WARN: resolve_btfids: unresolved symbol kthread_exit
> 
> and git revert 0507972c8244d6454cbfd242157e86bb01971bf2 (kthread:
> consolidate kthread exit paths to prevent use-after-free) makes the build
> error go away, but may keep the original bug the patch intended to fix?!
> Wentao Guan wrote in [1] that an additional backport is needed to make this
> patch work, but I didn't test this...
> 
> Tested-by: Peter Schneider <pschneider1968@googlemail.com>
> 
> 
> [1] https://lore.kernel.org/stable/20260317175812.707723-1-guanwentao@uniontech.com/

I've queued up a fix for this and will push out a -rc2 soon.

thanks,

greg k-h

