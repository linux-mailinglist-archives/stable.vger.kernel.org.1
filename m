Return-Path: <stable+bounces-214428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GP6AkFWhGlb2gMAu9opvQ
	(envelope-from <stable+bounces-214428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:35:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B78AEFF1E
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1354E30358B9
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A019E96D;
	Thu,  5 Feb 2026 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IBXeozLa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060463382E9;
	Thu,  5 Feb 2026 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280430; cv=none; b=o+vR2/DIsSZethpYhAY7yx9/9dNFodY3jPPH/gRJOAnHiircChfFek3xNNcmPqW+tKn9z5KZuCEitQhNbKVLWJIYFh7LwBjW5YjS3B0mdABoqJ7gz12cHNhst3F6dYMoyWGqjW3U6SFWU8e3KGT9eTeoSKbOKFpIaRNniDOo/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280430; c=relaxed/simple;
	bh=7E+xcLw8148yU3Dc4A7W6euBY4NlkEucNmoX2IfjD2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umM/TaaviV9BDKPuL/vCzmuIv5PqpzoPiAUH/fFRR1NM0QASoeMwzNjq/gpV4zpzA2XX4xdCzHINywsp6I+X5x09ab3nR3XlG3RuYCgHwjmmGw/b4VXnjSLxD+ttnKTNUeSfye8adpwPuGwYvPlE+/HH2DccStWf2fotBy0uhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IBXeozLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DD3C4CEF7;
	Thu,  5 Feb 2026 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770280429;
	bh=7E+xcLw8148yU3Dc4A7W6euBY4NlkEucNmoX2IfjD2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBXeozLaFpMygaon3kRRsZoYi5ZSs2fbMEV6hwjZ9mo1kwOVH3jEoinJpEiJLw79R
	 43rwSYv3q8+mMSIBkdQSgTacFm4AExA9DqeLx7qzwlnTlamUSG1YDrBebA0yxfV/Ef
	 5kBl9KqexfA9DTMi2eFAPfzEedJy73nn3DfHTzuI=
Date: Thu, 5 Feb 2026 09:33:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/280] 6.1.162-rc1 review
Message-ID: <2026020526-frisbee-coauthor-8ca3@gregkh>
References: <20260204143909.614719725@linuxfoundation.org>
 <25910fd9-ecc8-4119-9abc-2ab6baf5ce77@googlemail.com>
 <2026020510-ember-darkroom-37f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026020510-ember-darkroom-37f6@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214428-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8B78AEFF1E
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:31:30AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 04, 2026 at 11:17:38PM +0100, Peter Schneider wrote:
> > Hi Greg,
> > 
> > Am 04.02.2026 um 15:36 schrieb Greg Kroah-Hartman:
> > > This is the start of the stable review cycle for the 6.1.162 release.
> > > There are 280 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> > > Anything received after that time might be too late.
> > 
> > It seems that this time, I cannot even build this RC. When I run "make
> > menuconfig" I get a big serious of warning and error messages; something
> > seems to be really messed up here...
> > 
> > 
> > root@linus:/usr/src/linux-stable-rc# vim .config
> > root@linus:/usr/src/linux-stable-rc# make menuconfig
> > scripts/kconfig/Makefile:215: Warnung: Das Musterrezept hat das Peer-Ziel „scripts/kconfig/mconf-bin“ nicht aktualisiert.
> >   HOSTCC  scripts/kconfig/mconf.o
> >   HOSTCC  scripts/kconfig/lxdialog/checklist.o
> >   HOSTCC  scripts/kconfig/lxdialog/inputbox.o
> >   HOSTCC  scripts/kconfig/lxdialog/menubox.o
> >   HOSTCC  scripts/kconfig/lxdialog/textbox.o
> >   HOSTCC  scripts/kconfig/lxdialog/util.o
> >   HOSTCC  scripts/kconfig/lxdialog/yesno.o
> >   HOSTLD  scripts/kconfig/mconf
> > /usr/bin/ld: scripts/kconfig/lxdialog/yesno.o: warning: relocation against `acs_map' in read-only section `.text'
> > /usr/bin/ld: scripts/kconfig/mconf.o: in function `show_help':
> > mconf.c:(.text+0xa1b): undefined reference to `stdscr'
> > /usr/bin/ld: mconf.c:(.text+0xa20): undefined reference to `getmaxx'
> > /usr/bin/ld: scripts/kconfig/lxdialog/checklist.o: in function `print_arrows':
> > checklist.c:(.text+0x2c): undefined reference to `wmove'
> 
> <snip>
> 
> Ick, yes, I can reproduce this myself here, something is odd.  Let me
> track it down...

Ok, found the offending commit, will push out a -rc2 in a bit with this
fixed, thanks for testing!

greg k-h

