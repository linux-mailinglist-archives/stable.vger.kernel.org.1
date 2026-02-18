Return-Path: <stable+bounces-217285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF0AHBe4lWmNUQIAu9opvQ
	(envelope-from <stable+bounces-217285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:01:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE781567EE
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80D0B3007537
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3778324B1B;
	Wed, 18 Feb 2026 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LhYRgaqq"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8382FE04D;
	Wed, 18 Feb 2026 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419661; cv=none; b=PAZMv8K/qCrhUiUgiCCQL9IUdPhBhHjuOWy+0Trjhji2EauwO/xqvDDzwvImQhZUayuj8Bcp8RYKU1B94MKdf9iNRhsctnC/iZBj1ieUz6Ub7I8n2/zQY3w/+QMCbGpXmEsTcVzp0AGkzUueoDHUKjaizwQDP6eBWTo53xwsmp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419661; c=relaxed/simple;
	bh=+ZAYQBfpiJrawGTa5s1xCFQiv1Ei0YajxwjNi4xGMgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmTHP8EIQmcCQZEOwXel1cnudMcMITEu1FVCLEcQe04Xq2peLWLKYKVRKbzSbn+1cr7EvO8szShGBTnkOpxVrXPDo7/3PrTBcBkxJibuy86zeVxL+J4dHMTdeGA2JUOvqz/3cu8OAqNiRJXlJxbEX8tpnlbON9fpAr3YZDmbbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LhYRgaqq; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 62FDD1FC2F;
	Wed, 18 Feb 2026 14:00:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1771419658;
	bh=y04Gn/KHwYw25qaEpBuGATv0T3KlBX02x2xxwIuT8Dk=; h=From:To:Subject;
	b=LhYRgaqq+nzH2WNXGoys17rZjc7nrJ6yFwv4QghaoBgzpSUR0PWwrAe6Sovl6pfSn
	 wiTJp3j3+23xcOouHsJ9Twch3LUpdtdSB/zRaCZM4YMGnw8EFb0ZpeJo5MK26lrC8h
	 5V7VqBz6pNb2jGBJJvNbNxifmwGwTbnb4EyobY9Gj70TOxMEmI7yrnKLQWGpGcmxA2
	 aRggYOfgcdZ299RcnkQ5gJ+ZnoQRu1trgcmDHV7/JnlvGZv0eQrFIOqsIp1RuQ8ErO
	 bmT4G6TCS+z207UBmEkQbrMgnekuM8PmUiHHIt9GnNLH01gXvbAWn4pmb14fvbAcnP
	 Y6Bdj7o6CuH4g==
Date: Wed, 18 Feb 2026 14:00:54 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.6 00/39] 6.6.127-rc1 review
Message-ID: <20260218130054.GA93819@francesco-nb>
References: <20260217200004.221651386@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217200004.221651386@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217285-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[dolcini.it:query timed out,toradex.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[francesco.dolcini.toradex.com:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,toradex.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FE781567EE
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 09:30:22PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.127 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin iMX8MM
 - Colibri iMX6
 - Apalis iMX6
 - Colibri iMX6ULL
 - Colibri iMX7

(For the record: something strange - a freeze during hardware video
 decode test - happened on some colibri imx6, but it's not something
 systematic. And I see no reason for these patches to be the root cause
 of it)

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


