Return-Path: <stable+bounces-256526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GwFJwwxGWq9sQgAu9opvQ
	(envelope-from <stable+bounces-256526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:24:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 408925FDE41
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3FF230404BA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE78343893;
	Fri, 29 May 2026 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="FvwMJtdi"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958B30DD11;
	Fri, 29 May 2026 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035850; cv=none; b=AstoTlOuIh11RK0uZABkkjnjVkZYo1el9/1Eu8srhS0oGwbuyFPlML8uGlO829+b/q/m6q8nnG5bdcrcFcddwwIfiRybCpLra9w+kax6vTKMmyfHakjoFuN/hmaHs1cFTY85bLkMT0eRCRfnTss7JnfbAYlhU6lL8hWFspuh24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035850; c=relaxed/simple;
	bh=1JOI+3y2uqmOtZnu1DdMFSgEWHL3QlW19+aaQiOk+lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCzrK52N9drK126AdAPGYUjvo1rXVyhWQ7cN/CoIbWUb3cjR16SDWoFRddaSXYDy1DZDQZrm+vmOon8H1AsSwgZOQq4IYlgENhqrEPb26wPnzJt14a3Jnvxi06ubCOn1/7+T0PsKCXv61uyV4D6NUDwXgKhsNf1wQwz6/93Hr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=FvwMJtdi; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9BA3220E6D;
	Fri, 29 May 2026 08:24:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1780035847;
	bh=shdz+nSJkLsEyJpagL5UyHS+phwwSIXwadhsYEdVxmg=; h=From:To:Subject;
	b=FvwMJtdiKC7brOo1ewJnWuQYImq8bLeDdLm7mk+OftqtqbGNalljAzIzPzeT0oqpc
	 t9X8CUEzq46ph0YPi37f38ERN60Ughunj6I2kmmBUOvw91/XnmPPk6d2wKKjbmbQO8
	 0YQ+SPshJMnJ9n2sjEHnSbXvwadPHW/Mj6CoVucgtXKqji1M5/rcgaiTWfx0XQ//oU
	 b301jg0cbD2jtnygknu/dmrXKG5EF5ywV4r0NbtEaddQgzVnvgsJHFdMJ2MdvUsc1Y
	 8xrfrxm+PODJmrSwm3Xj601NfcUuLl87Kc4T9AeDTn4mBiB6Ua0gvVZa+TpoqcNMLn
	 iS0W+Jo8cAFTA==
Date: Fri, 29 May 2026 08:24:02 +0200
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
Subject: Re: [PATCH 6.6 000/186] 6.6.142-rc1 review
Message-ID: <20260529062402.GA11571@francesco-nb>
References: <20260528194928.941004471@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256526-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,toradex.com:email]
X-Rspamd-Queue-Id: 408925FDE41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 09:48:00PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.142 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


