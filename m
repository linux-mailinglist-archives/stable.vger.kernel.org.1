Return-Path: <stable+bounces-214463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QECwAb+ihGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:01:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEFAF3AE0
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FFF630106B7
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3193ECBC1;
	Thu,  5 Feb 2026 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z70YqVEz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185A3E95B7;
	Thu,  5 Feb 2026 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299980; cv=none; b=bML64U523T6n2u40S+i6MXPKsKmAMC8lHD+X5m4LUAb4K2JstflE4vpd1lHo5KzAIQnjqtX+ws6Ur+Qh+IVPODsc9k4OETiIneHK3AKhWyRy+vCN2HL7wWhk5QkqnyMXKeKKvU3PgnAhfAuftyRDwV+VpODtlGjeXftwWZkH8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299980; c=relaxed/simple;
	bh=ZoZxGJKEcr+rDLNuV6CwT7p+enyxHKL6Ly9DF2grNc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgTug+H5Sx2emYaIOUfgkUQ7tNmiO9MESY1d+BmUKxGWjzgS3GKWvNrsLzvvvqU7ijZJoHzhBglZwIhiCCUFxYi6QtdQsrxOBvcdrVu6SUFwLwCxySaKkzqRSYDlymbKlihOSeVr7vgwjb0A5F8RoKZ5JrTXLETljLJ+ZYAl6uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z70YqVEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20937C4CEF7;
	Thu,  5 Feb 2026 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770299979;
	bh=ZoZxGJKEcr+rDLNuV6CwT7p+enyxHKL6Ly9DF2grNc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z70YqVEzFyvGxPzb/SrIN8T0K2SQdwf7T264WU3xGPw2j1Py0FXx4oBWS63XTlL62
	 g0SvDjwzrNMUe98Xqmpm1XTMENDzr7Eo3d1F6tx+zOFqy2KTwZl7ubAyIrnu+keF6J
	 4XAJGmgaqdyAlDmKxjYRFe15uTPPCpQavcURiTg8=
Date: Thu, 5 Feb 2026 14:59:36 +0100
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
Message-ID: <2026020520-trustee-implement-f17d@gregkh>
References: <20260204143909.614719725@linuxfoundation.org>
 <25910fd9-ecc8-4119-9abc-2ab6baf5ce77@googlemail.com>
 <2026020510-ember-darkroom-37f6@gregkh>
 <2026020526-frisbee-coauthor-8ca3@gregkh>
 <8bb7a822-2643-4511-9c14-c3bc2d1bfb07@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bb7a822-2643-4511-9c14-c3bc2d1bfb07@googlemail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-214463-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	RSPAMD_URIBL_FAIL(0.00)[linus:query timed out,linuxfoundation.org:query timed out];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linus:email]
X-Rspamd-Queue-Id: 5CEFAF3AE0
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:35:37PM +0100, Peter Schneider wrote:
> Hi Greg,
> 
> Am 05.02.2026 um 09:33 schrieb Greg Kroah-Hartman:
> > On Thu, Feb 05, 2026 at 09:31:30AM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Feb 04, 2026 at 11:17:38PM +0100, Peter Schneider wrote:
> > > > Hi Greg,
> > > > 
> > > > Am 04.02.2026 um 15:36 schrieb Greg Kroah-Hartman:
> > > > > This is the start of the stable review cycle for the 6.1.162 release.
> > > > > There are 280 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> > > > > Anything received after that time might be too late.
> > > > 
> > > > It seems that this time, I cannot even build this RC. When I run "make
> > > > menuconfig" I get a big serious of warning and error messages; something
> > > > seems to be really messed up here...
> > > > 
> > > > 
> > > > root@linus:/usr/src/linux-stable-rc# vim .config
> > > > root@linus:/usr/src/linux-stable-rc# make menuconfig
> > > > scripts/kconfig/Makefile:215: Warnung: Das Musterrezept hat das Peer-Ziel „scripts/kconfig/mconf-bin“ nicht aktualisiert.
> > > >    HOSTCC  scripts/kconfig/mconf.o
> > > >    HOSTCC  scripts/kconfig/lxdialog/checklist.o
> > > >    HOSTCC  scripts/kconfig/lxdialog/inputbox.o
> > > >    HOSTCC  scripts/kconfig/lxdialog/menubox.o
> > > >    HOSTCC  scripts/kconfig/lxdialog/textbox.o
> > > >    HOSTCC  scripts/kconfig/lxdialog/util.o
> > > >    HOSTCC  scripts/kconfig/lxdialog/yesno.o
> > > >    HOSTLD  scripts/kconfig/mconf
> > > > /usr/bin/ld: scripts/kconfig/lxdialog/yesno.o: warning: relocation against `acs_map' in read-only section `.text'
> > > > /usr/bin/ld: scripts/kconfig/mconf.o: in function `show_help':
> > > > mconf.c:(.text+0xa1b): undefined reference to `stdscr'
> > > > /usr/bin/ld: mconf.c:(.text+0xa20): undefined reference to `getmaxx'
> > > > /usr/bin/ld: scripts/kconfig/lxdialog/checklist.o: in function `print_arrows':
> > > > checklist.c:(.text+0x2c): undefined reference to `wmove'
> > > 
> > > <snip>
> > > 
> > > Ick, yes, I can reproduce this myself here, something is odd.  Let me
> > > track it down...
> > 
> > Ok, found the offending commit, will push out a -rc2 in a bit with this
> > fixed, thanks for testing!
> > 
> > greg k-h
> 
> I was too tired yesterday evening to investigate my build error and poke
> around deeper, but today I looked into it again, and I found that when I
> revert the two kconfig patches in this RC
> 
> 7c177eca9e7af1f0a56171b7718a1b05aaa0f237 "kconfig: fix static linking of nconf"
> eb5defa1e8284b8b79653beadc92c273c170db7d "kconfig: refactor Makefile to reduce process forks"
> 
> then my build error goes away, the build succeeds and the produced kernel seems to work fine.

Yes, those are the commits I dropped, thanks for verifying.

greg k-h

