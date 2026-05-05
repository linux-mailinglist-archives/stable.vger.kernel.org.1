Return-Path: <stable+bounces-243957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNXoF014+WnV8wIAu9opvQ
	(envelope-from <stable+bounces-243957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 06:55:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B932A4C6985
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 06:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB3CB300B9E9
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB0A3B6C16;
	Tue,  5 May 2026 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="olvMa/Pc"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890D3A3E6D;
	Tue,  5 May 2026 04:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956936; cv=none; b=rQyjCZLtIvxJ9wgN/yYe8G2yZ9fqfrJ20dN7+nKkoIyQYmxAuoFNCUbYX6jWkd2EAZvMPwI/EzG1NSfrHEaGtvSkYMBfCjmWsa/Fgo9ZwKxdLkg0eloqQFnd9zlMzo6xdnrauF/K+BiQqqiTYAvf4ZpbjhAy0Pko43DK8sM7J3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956936; c=relaxed/simple;
	bh=l3ZY0xZux9Q1HvWi2sHUzTcTUS1zuFCOJkABS+gmnH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWPz/FLYmy85hOMqrWR5nxzSN7QWIEiIm9tPKAzkVcMCB3vizApgYniGUyDEwwBMvfpZvfgyTSU8y/2jXOA07jmil1NqjsU+nwMDh4i6SgCtz1oFFJVN8S/ozBPYZbfGJLqoem4QXx5zpTaj2RcusoImoHlD4G4rtJS3rfxXYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=olvMa/Pc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-38-224-205.ip72.fastwebnet.it [93.38.224.205])
	by mail11.truemail.it (Postfix) with ESMTPA id 9073725542;
	Tue,  5 May 2026 06:55:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1777956924;
	bh=mO1TMsnvzR5lhmOyZ4mTG7H0z9kzmib0UoUE3JUq9ow=; h=From:To:Subject;
	b=olvMa/PcGYmVTtqeLB9P3gmhXjDWJA2KI54qn49NBbgQXJU6y/ODsCO9Yo6DybPa5
	 twph//4Pxfv/MZonY2U/+t4RUFrQKlcl+OQUjcDZU6SfpNXa4EY36RPCYa1kt4L8ch
	 MA9Dh6XASAi77cgJZAeN7BRbBskkmxNktPqU9RAah3SXqYoyLHdKLmQ0iPKrD7Jqsd
	 PCk98Isy57gLbE2ZyBExr0IJ8hUq7viyHB4K5vRSCyZSjS0qHnrUY/bWkjZyN5gYqk
	 W1sYQcbGZ9kIRCDb6C0P0CZt25JPpR27SqGcQgG/D1ZdsIrXhd+E2RXdRb9J3aQm1z
	 enmoTVee1d0wQ==
Date: Tue, 5 May 2026 06:55:17 +0200
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
Subject: Re: [PATCH 6.12 000/215] 6.12.86-rc1 review
Message-ID: <20260505045517.GA5559@francesco-nb>
References: <20260504135130.169210693@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
X-Rspamd-Queue-Id: B932A4C6985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243957-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,dolcini.it:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 03:50:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.86 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

