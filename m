Return-Path: <stable+bounces-242607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCNHDe4D9mlPRgIAu9opvQ
	(envelope-from <stable+bounces-242607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 16:02:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63364B23F1
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86E803010B99
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719BF2820AC;
	Sat,  2 May 2026 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EIEQCf3b"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE240DFB4;
	Sat,  2 May 2026 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730535; cv=none; b=EI3cALZyoH/VsVEtnJ37kkWZNswFy/ahOV8gTJEMPQtVraDmmE7l3kJYDYDh31vgrC/YqXbXyUv2AwBo3j+goqE9TgDWmwJwSi5oKEo4HMx5wcZnQ8w27Jed2qlXZGvOb6i/nJdwuQOLKvrjnKfDkJ/yMB9F/cA6oald8bL6Ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730535; c=relaxed/simple;
	bh=cirj1ddnU20WqCrWdv1zrMcJEt2pW1gAHp0yC91SgQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkXVOWKTDWL0CI5g48ZIdZQd8lgHIyrJHE82F6B2gFk2d8WOY4pCIxaHfr2COtGuEoT4ifuUk3guzA9RmoYzLMHaEaZLx5yxsTh9SuztnAJG4nbtyFcm8XcC9IQcgUYc5IrQRPQ8y1743twikjz+IHE6DeLdpm+eBx4S6I23Hmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EIEQCf3b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gqvEv/u/9z1TkZqcxPXmNw5jEVBk0gQlqWKUdqt6vqQ=; b=EIEQCf3bOgksFvcf12AIijm4BI
	ikMzxMjGJJq6GnibuQiI4qJTAjcgP+aTu6php86K2z0B2q1ESmacpSY1iarbf436YKa47RJeiRibu
	Q0JqSMBA21ntWqowdVsOeSF5I/aNN99grE/tR2x7y9JJS4HlsMpBbuDIbwr+YpGlC4zs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJAuy-0011SS-Ld; Sat, 02 May 2026 16:02:04 +0200
Date: Sat, 2 May 2026 16:02:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mike Marciniszyn <mike.marciniszyn@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: eth: fbnic: Fix addr validation in pcs write
Message-ID: <f500e75a-5672-4c62-b2b1-04f59bed3368@lunn.ch>
References: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
 <20260501134636.GE15617@horms.kernel.org>
 <afXHpPPKhayawr9x@PF5YBGDS.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afXHpPPKhayawr9x@PF5YBGDS.localdomain>
X-Rspamd-Queue-Id: D63364B23F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242607-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, May 02, 2026 at 05:45:08AM -0400, Mike Marciniszyn wrote:
> On Fri, May 01, 2026 at 02:46:36PM +0100, Simon Horman wrote:
> > On Wed, Apr 29, 2026 at 11:00:49AM -0400, mike.marciniszyn@gmail.com wrote:
> > > From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> > >
> > > This patch contains a fix for addr validation in fbnic_mdio_write_pcs().
> >
> > Hi Mike,
> >
> > I think this warrants a bit more explanation: Why should addr 2 be
> > accepted? What happens from a user-perspective when it is not?
> >
> 
> The DW IP part has two distinct PCS address ranges cooresponding
> to the C45 PCS registers.
> 
> The shim translates the PCS mmd/addr/regno into specific CSR writes
> to one of two zero-relative addr values into one of those two
> ranges.
> 
> This patch fixes a one off in the test that could allow an invalid
> CSR write if an addr == 2 was called.

Stable runs say:

It must either fix a real bug that bothers people, ...

Can this bug be triggered with the current driver? Are there any
noticeable effects? How would somebody inside Meta know they need this
fix? This should be included in the commit message.

    Andrew

