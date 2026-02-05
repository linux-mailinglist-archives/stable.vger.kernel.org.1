Return-Path: <stable+bounces-214424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKVfH2tVhGkx2gMAu9opvQ
	(envelope-from <stable+bounces-214424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:31:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E7EFEA4
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDC5E300F18C
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA25B363C4D;
	Thu,  5 Feb 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HdT4LJjI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475733E344;
	Thu,  5 Feb 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280293; cv=none; b=UL0hv/jFUJJ6FYMduzqkhIiYDUS18xMjLPGtgfnySrRTXHzBnQa1tQ9uKgQslTfjrKiPhACS+F1crzB5Z38sCe2dAbq+NdbDp0NmLME7JDvrKf5dmFJ/yiYKUOhE8+q3zfxr1y3BdDnZsXwvbUiQWI1DViVdNJwxziCgSI8/dgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280293; c=relaxed/simple;
	bh=LzE2CbGQ44rF/dPgWkFwHyWZ14a31tKrIJ7EQ0lk/x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBquAPWELc9ro4XBq4PbVCp99VOwnS1IYPyyOTGPNMhur/S1wohmpyF1eTTZNO3UnnHENR605CLpBUox5UihKFE1dCkXHjIuE2wosKVXnSvO/5kqKFLhOKHqTGrFqjNSV/Coa5PdtqUoBqX/jGskRtc36n0XxmjAt407BZ2jHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HdT4LJjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897F8C4CEF7;
	Thu,  5 Feb 2026 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770280293;
	bh=LzE2CbGQ44rF/dPgWkFwHyWZ14a31tKrIJ7EQ0lk/x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdT4LJjIVBY334YkFNpE8DHcCeDxmruVrnC7GWGahzYIzd0DDTr0COi66jel7CDvU
	 Jh5ealm9QqQomh7wFdH7bsIcCvOsYAPaAlb82S7k5zCALjhcJWnCVc/7Q0+zfd69fz
	 axzx/uOR529WfQOTstAzUcA41euWPseO3pa0g//Y=
Date: Thu, 5 Feb 2026 09:31:30 +0100
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
Message-ID: <2026020510-ember-darkroom-37f6@gregkh>
References: <20260204143909.614719725@linuxfoundation.org>
 <25910fd9-ecc8-4119-9abc-2ab6baf5ce77@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25910fd9-ecc8-4119-9abc-2ab6baf5ce77@googlemail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214424-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E93E7EFEA4
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:17:38PM +0100, Peter Schneider wrote:
> Hi Greg,
> 
> Am 04.02.2026 um 15:36 schrieb Greg Kroah-Hartman:
> > This is the start of the stable review cycle for the 6.1.162 release.
> > There are 280 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> > Anything received after that time might be too late.
> 
> It seems that this time, I cannot even build this RC. When I run "make
> menuconfig" I get a big serious of warning and error messages; something
> seems to be really messed up here...
> 
> 
> root@linus:/usr/src/linux-stable-rc# vim .config
> root@linus:/usr/src/linux-stable-rc# make menuconfig
> scripts/kconfig/Makefile:215: Warnung: Das Musterrezept hat das Peer-Ziel „scripts/kconfig/mconf-bin“ nicht aktualisiert.
>   HOSTCC  scripts/kconfig/mconf.o
>   HOSTCC  scripts/kconfig/lxdialog/checklist.o
>   HOSTCC  scripts/kconfig/lxdialog/inputbox.o
>   HOSTCC  scripts/kconfig/lxdialog/menubox.o
>   HOSTCC  scripts/kconfig/lxdialog/textbox.o
>   HOSTCC  scripts/kconfig/lxdialog/util.o
>   HOSTCC  scripts/kconfig/lxdialog/yesno.o
>   HOSTLD  scripts/kconfig/mconf
> /usr/bin/ld: scripts/kconfig/lxdialog/yesno.o: warning: relocation against `acs_map' in read-only section `.text'
> /usr/bin/ld: scripts/kconfig/mconf.o: in function `show_help':
> mconf.c:(.text+0xa1b): undefined reference to `stdscr'
> /usr/bin/ld: mconf.c:(.text+0xa20): undefined reference to `getmaxx'
> /usr/bin/ld: scripts/kconfig/lxdialog/checklist.o: in function `print_arrows':
> checklist.c:(.text+0x2c): undefined reference to `wmove'

<snip>

Ick, yes, I can reproduce this myself here, something is odd.  Let me
track it down...

thanks,

greg k-h

