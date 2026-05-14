Return-Path: <stable+bounces-247091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGBiKe81BWp9TQIAu9opvQ
	(envelope-from <stable+bounces-247091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:39:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378653D1B4
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 04:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F29D303B72E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 02:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAD32DECC6;
	Thu, 14 May 2026 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="u1DzODOy"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491BB224AF7;
	Thu, 14 May 2026 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726323; cv=none; b=qT2Nbkqk69o88cK3wk/mgcwHkkLQnyAPTpaATS8oVlof9wgAkV0keH9F+6cZh3iiXwRS8VwZrJjZJjxCeLDbjQyc7ceo+KTxs3Lg1h+Bd74N5bZrMROBnHIhJPNMYeT2ouOHW63ttEXT+rZB3l17P/QNRPWlpJpOOHFdo7MgL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726323; c=relaxed/simple;
	bh=2mLNfb1HOpvIDrm9DQVOpQ5AkkEDfN++5jxE7gv1PH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUMQjkG5oLV56xixHikop2zRlgDLzRC93ZWSf6tbqFX3qYie0xino0L8q2GJGj8GIKLltM0LVNQUwIoH37EuEu/NfYLAufgZIioK4VfQo7oAbvj7FbLD1565xIsJwQicEZnhaGPn0SOcVB7n75raMAqj+cRLEOvl+A+W/ro18Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=u1DzODOy; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0DBCF14C2D6;
	Thu, 14 May 2026 04:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1778726318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUIYZWrhQEIscq6DViIrphGG7tWDqiFTJqkPYD1d6us=;
	b=u1DzODOydwUvg15PAayRmDriRtkRRBiHbhu2e7Os4524af3NakGq1q5qb4vLwECyiC4Hji
	0FaiPO5L0q7oH5xPsCNf/dlEmMK++rvFNOqLdvIA2sB7zW1IiDJNe+UmLhkNN+lXOTTwQe
	A/xLywT31TUAiOMwg2bOqcaUavU17oNVgViQoWCFNYEU4kBoXOeAXEig0CV7ASj8elsQdY
	PZDy1WDQX/9qhUr5JTFe6ZDdcYuOqLqA11SZBEX5lm1z9LLFhq0JRTVh2/vwl5MJ+kRq4l
	Ia4M9fy3q6RVlnnagNffvxnRtLVvjfE5KT3SY4neH1GorD3RobFFLtTJ1yCSUw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f709ff6c;
	Thu, 14 May 2026 02:38:31 +0000 (UTC)
Date: Thu, 14 May 2026 11:38:16 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/202] 6.12.88-rc2 review
Message-ID: <agU1mMHEwt1PjWAm@codewreck.org>
References: <20260513153743.326058350@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513153743.326058350@linuxfoundation.org>
X-Rspamd-Queue-Id: 0378653D1B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247091-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[codewreck.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,atmark-techno.com:email,codewreck.org:mid,codewreck.org:dkim]
X-Rspamd-Action: no action

Greg Kroah-Hartman wrote on Wed, May 13, 2026 at 06:17:18PM +0200:
> This is the start of the stable review cycle for the 6.12.88 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested 3cdde8c80e99 ("Linux 6.12.88-rc2") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)
- arm64 i.MX8ULP (Armadillo IoT A9E)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

