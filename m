Return-Path: <stable+bounces-254418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL7YNZTnFWrdeAcAu9opvQ
	(envelope-from <stable+bounces-254418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:33:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2DC5DB61D
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06462302F7FC
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA2421EE6;
	Tue, 26 May 2026 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXx3ydIL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAF4421F17;
	Tue, 26 May 2026 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820430; cv=none; b=L+dSmmnt9QgzWEVQs7kydqMynNPkC2gf4HVjvZo4qM4Vwzzdzf08SMl/hFXap8yMZV7pcCxM9WD1+c/t9u+6QC6KJWZrXxMi9j6ZpvoLacKb9D+BsIE7m2RWv2CJSEcEtCzAsknOBPNTVT0aRskDKKAkq7Kzo536FjzdN3O1qNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820430; c=relaxed/simple;
	bh=LA/AM1XVU1zZHWIGcZtmjHyfCOja1Yd2PIb79QCaIYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAdBU7Q0ruAYqIE5AUePlqPXK26mKXNAUtJvsRsLgnv8914D4QiZxs8WgQscTZsOl3FKbqDTZNCcg3HHI0DbrXjyngOgf7DN5nXsLdGOUC7Ivo7em8C+jjESuJnycM6CBZpGFfNQntiEujXcNXLs9FyH9Ht73UNtT/fqv/jHZEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXx3ydIL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB9B1F000E9;
	Tue, 26 May 2026 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779820427;
	bh=YRqyNA83gZxe0q1w7lVPcn4myC9qzt6H1egBiwSE624=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mXx3ydIL1qb31vY5nGb9Md20EL5FCKPj/RIeJ0RM8ZmF5CIIPX5i2yFpBdm9mQzXP
	 9w6O/rp3/Pe3MTMshZTVsL/L8kpPYrnU+yCtVgGnDDG6nrsFQY7rTbFjwBoGlPVZpW
	 wYawH20gOgS3dSIgIUaVzKWV8XD1utfFMME35QlT+C60H4P87GMcYKFHlrPULyBdac
	 UMQSds3tqUY4DX9PUJAk57Z8fEbfJXmAjDCCMej+iwMZVpVQi9ZzNgjzgibQI4c5Pb
	 LgzBQRT0VYk8O0zRC0fT+2np2KyOn1SvzoMHrwVhryggAOfaH09AZrEthV2p+vCQLM
	 iwwmf0mndB0BQ==
Date: Wed, 27 May 2026 03:33:46 +0900
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
Message-ID: <20260526183025.GA1285841@rocinante>
References: <20260521052241.GA8766@francesco-nb>
 <20260526180537.21223-1-leoreis.costa@gmail.com>
 <20260526181726.GA1093069@rocinante>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526181726.GA1093069@rocinante>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254418-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E2DC5DB61D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

> When you have a moment, consider changes from the following series:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=sysfs
> 
> Test, and let us know if this fixes the problem for you.
> 
> I would appreciate if you could test this for us.

I realise that 6.6 is a bit of a far cry from changes against the upcoming
7.2 release, so you might have to massage the series/patches into sensible
state, so to speak.

Let me know if testing is too involved, given the need to potentially
backport a lot.  I will think of something.

Thank you!

	Krzysztof

