Return-Path: <stable+bounces-254415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH5AHQPnFWrdeAcAu9opvQ
	(envelope-from <stable+bounces-254415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:31:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7405DB5DF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE6A302352F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B194218B1;
	Tue, 26 May 2026 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDaSvrat"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35540DFAF;
	Tue, 26 May 2026 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819952; cv=none; b=mSDEF/w/wC7bu3qnI+H+zUT/bAv3sMfyWaqx+eda2lnEogiyCD7elOg423I/6yeRMMRcZsSmUrJ5+L3eL35c5kGUN6h/cBmAs6JuHvS/1BdR6kxvRfz381p1TjVASpnud25NAxyQqP/a+Yqb57FotGqqPwykqbBmKF5/aagA0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819952; c=relaxed/simple;
	bh=67tQz1ww2uVkxA7fDT6q9VsJs7oKLBvslktaHppy58A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLcFAm34kt2xK+BOm87WDo1E/7q6JEBUFKGRI3QsKAJLTCP4t5YTUCQvuIj1F0x83Xd6vLseITJ68RF08jSutu1E1unnk4n/yj3uGj/3Po7WMoRZjojcFS3JKEwQxcOzdr1WbF79V02HgU0VcmvOGbE6dJznAPkaX9XUz8E7nxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDaSvrat; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A49C1F000E9;
	Tue, 26 May 2026 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779819951;
	bh=rY3T3gOGSLhQrYpmpzrMh90U3KgwCUTQovs5ZLJ6Uws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PDaSvratjk91U1V1ER2kixgozYliBIieg9u429EnJGogZz4947PcnK3qolj0OYTKo
	 ufFaRFCqvaBS4iM1sYv8e6yD703fOeTzKAGApOdFtgHX885sticzU2gwmYIf2zjCTK
	 2y9IqBzteNoELOlZJsbJH/XUMLensaVZzXdqA0ZzHb7cRefU4kXWUVTIpDki9I/ho5
	 mH5FAiHz6Y9Sp5fkOhAP9XBz1oKK+CZFCdI16nv+Eg5jXkf1dJvxzrGDf5bBvgk0ZE
	 oQ5YigaldjjDXDmh4NypITtl7VCu+ImWWIkWskHGmbgpsglk38LC8pdoF/ep+u1EZx
	 LoAkfXf7hNbYg==
Date: Wed, 27 May 2026 03:25:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: ryanmatthews@fastmail.com, hongxing.zhu@nxp.com, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-imx@nxp.com, francesco@dolcini.it, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	gregkh@linuxfoundation.org, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, lkft-triage@lists.linaro.org, 
	patches@kernelci.org, patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, 
	shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org, 
	sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 6.6 000/508] 6.6.141-rc1 review
Message-ID: <20260526181726.GA1093069@rocinante>
References: <20260521052241.GA8766@francesco-nb>
 <20260526180537.21223-1-leoreis.costa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526180537.21223-1-leoreis.costa@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254415-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kwilczynski@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[fastmail.com,nxp.com,google.com,vger.kernel.org,dolcini.it,achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0B7405DB5DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

> > kern  :info  : [    0.593597] pci 0000:01:00.0: BAR 4 [io  0x1000-0x101f]: assigned
> > kern  :info  : [    0.593629] pci 0000:01:00.0: BAR 0 [io  0x1020-0x1027]: assigned
> > kern  :info  : [    0.593660] pci 0000:01:00.0: BAR 2 [io  0x1028-0x102f]: assigned
> > kern  :info  : [    0.593692] pci 0000:01:00.0: BAR 1 [io  0x1030-0x1033]: assigned
> > kern  :info  : [    0.593722] pci 0000:01:00.0: BAR 3 [io  0x1034-0x1037]: assigned
> > kern  :info  : [    0.593753] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > kern  :info  : [    0.593767] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> > kern  :info  : [    0.593781] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
> > kern  :info  : [    0.593795] pci 0000:00:00.0:   bridge window [mem 0x01200000-0x012fffff pref]
> > kern  :warn  : [    0.593856] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/resource0'

[...]

This is a known issue you are seeing here manifesting itself.  Given this
specific error message.

> This warning happens on our tests for Apalis iMX6, and seems to come from the
> imx6_pcie_probe function in the pci-imx6.c driver. We found some instances of
> this happening on as early as 6.6.129. This went unnoticed until now, we're 
> not sure when this started to happen.

Sorry you are having issues with this!

When you have a moment, consider changes from the following series:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=sysfs

Test, and let us know if this fixes the problem for you.

I would appreciate if you could test this for us.

> Do you know what could be causing the duplicate file here?

The series cover letter has a bit of information about what is going on
here, and why, see:

  https://lore.kernel.org/linux-pci/20260508043543.217179-1-kwilczynski@kernel.org/#t

Hope this helps.

Thank you!

	Krzysztof

