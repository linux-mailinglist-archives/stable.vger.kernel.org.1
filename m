Return-Path: <stable+bounces-214422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDJ2DQBVhGkx2gMAu9opvQ
	(envelope-from <stable+bounces-214422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:29:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE0DEFE45
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61284300EF9B
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AAC36214F;
	Thu,  5 Feb 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Gp+MXe+O"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C433F37D;
	Thu,  5 Feb 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280100; cv=none; b=iIgVQqHdBaongnM2h1AJtwtCF9qrIsZF2U0eOOHVBC6K4MIsLag3c2XxOkHUM1rj3KqzEYXrG/ClSICvxo4E29LzLbTrA096qvfAUeQGwB39I56lrz9dtYqxdCLDfB+EeYRFuVYBRMf0i+mqHxqkWOe/3u+R4wyMK4+bi2YaDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280100; c=relaxed/simple;
	bh=A3awokezcYpQ/7ZWlgrcbLyfe5jVoyACpijvArVvveg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3F3crbxhke8SjqYqKIPl24rGUmtDptJV8VUbAH/8o4DDXXYKfolrR3eDe+8RK7eVophHYTpdCXMsPOCW9jaYBgM8JykxmDhhZeviEEbqv4gkfRlNiDnfA/x4GtGfzqwgA5RhiPWbSOswbY3DRzw0XFlYwWAl4zsmu5/RQK96gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Gp+MXe+O; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 208861FA94;
	Thu,  5 Feb 2026 09:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1770280098;
	bh=6xeO6HF+8wKyfdj5hCH5AaPvV0doI5eKSqCsZeyclX8=; h=From:To:Subject;
	b=Gp+MXe+OeXr/iTBnZRm69fTJnmvdmgQ/LD1tNEfsML00HQEKfXEQnfspIl7usP0DL
	 DWt5NH6jR+IajAxN6ShVIU+RP2wcIBL1kX48Pc4reTht1vYQEBJ4ksSVowa8dcLIGY
	 XXd+94hSTgezNuZK016E/qc08KQGegdSG1cTNhaiJGwxJe3/6e1rYAgu67qWVeVqdd
	 nQQl2mY91cNVYAdzeZLATFww0S7TOEVWDiZ11Z/nTU1Xjskvp1PeRgbipJMuy6QOmX
	 PfbAIlZtrTKd/zvXXUW5l+4m8TL20vqGhT/Ss7IcEc9Uvp9zhosqJFqsO3RyLGwDLI
	 qKJbwOZCoOcNA==
Date: Thu, 5 Feb 2026 09:28:14 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.6 00/72] 6.6.123-rc1 review
Message-ID: <20260205082814.GA16405@francesco-nb>
References: <20260204143845.603454952@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214422-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dolcini.it:dkim]
X-Rspamd-Queue-Id: 8AE0DEFE45
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 03:40:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.123 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin iMX8MM
 - Colibri iMX6
 - Apalis iMX6
 - Colibri iMX6ULL
 - Colibri iMX7

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


