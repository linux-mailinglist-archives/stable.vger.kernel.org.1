Return-Path: <stable+bounces-212669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rMAINQBuemk16QEAu9opvQ
	(envelope-from <stable+bounces-212669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:13:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 518FCA8676
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 21:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C0E30305EF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF5374721;
	Wed, 28 Jan 2026 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="RoAJA/NM"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4D36F435;
	Wed, 28 Jan 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631226; cv=none; b=M4uLBE4JinbPVPA4goX1lOMrKpVttWBkpoG+x9/ryww/uU9u/WpvoWYhb6jN3WRJtYa1FRAdHKX90XygI1I4lfqPib8MSXmDwHKbW9N/qytRB6wgUCh8uksyS7NeHvMws8/Bu/HSsoyC41aEu6bzgV8UDFv41o/ecKZhE2khYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631226; c=relaxed/simple;
	bh=UpisuyD4ZalI7kxCN0wYJbdN2N1j5/X+BuhtN2OtOsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBeecKAIo1rBK6iLnEHVnFqMTapiamjA/EP0cSO9hY+bB/eNV1AO5hg+EFNr6bKkbRgkGUgJ776rvZ1Un1TJ6rQppNcxflvYysn8puTrwRUZQmG5EnEP7gEn4e+6OgqQz8rBdgEgQ/cMWXTTX2GrpTiIqdpAMMgHMqyZQDleVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=RoAJA/NM; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AA595327EC6; Wed, 28 Jan 2026 21:13:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1769631214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKDmAErU0lVt4KqWzSITaPblblMjoIdIiQTZKd6O9zY=;
	b=RoAJA/NM6X1/DogJdOVOTbkn0ogTybXEMmXMU7Xv4GXSVTUN632HwpkoK5pIhTki3SiCdj
	ZZwKCpGpkveZFmLCJ/PsBncukTAMrfwAWtmaPKbAjAaeJduj14ls9ks6hKJKAh/C8C8VTC
	7SfKRb7zGxA2h3vTZak/76k5E83o7HU=
Date: Wed, 28 Jan 2026 21:13:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pavel@nabladev.com
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/169] 6.12.68-rc1 review
Message-ID: <aXpt7kUYDovR4Fxo@ucw.cz>
References: <20260128145334.006287341@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ucw.cz,none];
	R_DKIM_ALLOW(-0.20)[ucw.cz:s=gen1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212669-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@ucw.cz,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ucw.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucw.cz:mid,ucw.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:email]
X-Rspamd-Queue-Id: 518FCA8676
X-Rspamd-Action: no action

Hi!

Please update my email address. I no longer have access to @denx
address, new one is pavel@nabladev.com .

Thanks and best regards,
							Pavel

