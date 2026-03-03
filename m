Return-Path: <stable+bounces-222811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGx4AHOPpmnxRAAAu9opvQ
	(envelope-from <stable+bounces-222811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:36:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5411B1EA3A2
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BF143058721
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 07:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5230C63B;
	Tue,  3 Mar 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="kLXSZbKe"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760992FF641;
	Tue,  3 Mar 2026 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523302; cv=none; b=Wqkj0lOl8MeDm6Kl7klj7ZpNOh4VeOoX1loEtKWXI1Hb384Pjjts7o+L25E12sloj0rAPFjQVt26VgHjJ6OAtPQiYKFvuUhvIkPi3w1WpF9tFAygHNoV/Y4jA62SgX7l/6VJiH9tD5+C3TrQNlI0Pgmd7pru0xD8uV06ncpUGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523302; c=relaxed/simple;
	bh=eJBSjWKAqcnbs3vFYL0X8iwtAQ3ADuUvpnMXo30FNNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keE5pkOsH5vbXjv96zJHwjLcO9Qo9RRVXCfC9MBz6+J3LyOfMOfJ68kSxU0xYCeTp5fB0TgqZ2cEL2glO+m2qES1JiM3VZXeatBB5492fKHbbrzOb5CnTX53ITO7CjdVgCP6cbkdf7Fmo/wiruW5CSvxFwLIn1TaAhhbTCV7MRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=kLXSZbKe; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 6ED392296C;
	Tue,  3 Mar 2026 08:34:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1772523296;
	bh=1n7XxrIbIP2ml68QkCxkal5P2o3ZuWEH5CDWcKf7GAU=; h=From:To:Subject;
	b=kLXSZbKeGYBbDlPZLE6ss5L9RK6AoAR3J+1G/F+MPCyi4Pq3k5aO0wxShsYjxM3fo
	 womo4vZTlpZdVDnyfft92b7R7pZxx60bycrt8qRJInewdn907uxNxVLfFE3x9HPtAB
	 Bdu3nOUTYko3zp/m/8MRSNPQ/PSkoWkBWG9+V/DkCxT5l6COey8aDp+9qv/OQFB8yp
	 CkQ60FpjaCPDSCK1su95VcHm1SO5X2pjLtmPre8nlJzinEbQ/mgunjqjtKCAqtbl3J
	 kjdSSgfdovplzho57SBXJbv0lHUD5QJ5NKmEDZfLA8fOkVMa/sMxbisj7FDhUx/2aK
	 G4s/qRqAVoNbA==
Date: Tue, 3 Mar 2026 08:34:52 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	gregkh@linuxfoundation.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@nabladev.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Message-ID: <20260303073452.GA9569@francesco-nb>
References: <20260302160943.2522184-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160943.2522184-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 5411B1EA3A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222811-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,toradex.com:email]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:09:43AM -0500, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.1.165 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin iMX8MM
 - Verdin iMX8MP
 - Colibri iMX6
 - Colibri iMX6ULL
 - Colibri iMX7
 - Apalis iMX6

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>


