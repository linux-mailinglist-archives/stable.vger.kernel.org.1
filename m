Return-Path: <stable+bounces-253452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SSnxOYmWDmr+AQYAu9opvQ
	(envelope-from <stable+bounces-253452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:22:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5F59F06C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 07:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85A8300F5C5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2295339844;
	Thu, 21 May 2026 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="PAaIZt5X"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171C34E779;
	Thu, 21 May 2026 05:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340645; cv=none; b=CrTueIGlKed4FZRH3AsRspSV4HVqbp5ee1zZUH9TDyM1SYBqtk8lgEDRrU+ZM/LQzsmfTDAcpI0CUO0EdDM84s7K5Lfed2dkp4ymYmSsPKoq8UhrFOwveN5GBcxLY8SaiWhk6jMqe0PuSiqhlV5l7LgCDEFU3G2FXa4ZzaHgfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340645; c=relaxed/simple;
	bh=KWypq1wuWNfbjetIGHZ2YvJVN2wGEZn1av2yZzj9wZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZSe2eCY3tsz7skyhkUCj/tDEYU/SzZIlNC6hlfbFs/hrgajqaUyDY5o4WgGNsFil5k4JHri7tEXl+pBTnntIdwxVl9llw2705PHQriD9mL2SYcxZIXdE5zRgvkW+x1lGIlVLYqDvTjraaO2sJkiftyP9nYBvcdjIMPjYYlw0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=PAaIZt5X; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-38-208-55.ip72.fastwebnet.it [93.38.208.55])
	by mail11.truemail.it (Postfix) with ESMTPA id D916325BEB;
	Thu, 21 May 2026 07:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1779340641;
	bh=DwcnHoMkD13GrbOEpK6d3ihXGUmmXhx1JERPoKzcSHQ=; h=From:To:Subject;
	b=PAaIZt5XienBWURRwcwBnUPBNMWF7o+i21o94xq+73j9lEQvaXOCDDXjg9ElKubgC
	 dK3I+lKGavka5mzYHZkWf4uCcI/HWA+zCA/HBo8UWM2wct8npxYdBaAFF/JbuRd6oB
	 UbDMKFjuEROcbzhoPr9s/11896pOYx04OHnpJ1T8pU3n/cfY5laB+2105/7GdogGdS
	 9ByLcKDOMLVgw2v4fq/M5hfbmG0HYJuYspBhbmWrZxhGZTTa+D/+L7FxLkaMmFA9ar
	 +u0YjbbOeKah6xo2SIK3BBIeGgZAf8TGf0gnnzCWwqyfUV7hFTbCkvOeJxrgi0BiXX
	 JcSk5cBnfceAg==
Date: Thu, 21 May 2026 07:17:18 +0200
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
Subject: Re: [PATCH 6.12 000/666] 6.12.91-rc1 review
Message-ID: <20260521051718.GB6866@francesco-nb>
References: <20260520162111.222830634@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253452-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dolcini.it:dkim,toradex.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 42A5F59F06C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 06:13:31PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.91 release.
> There are 666 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


