Return-Path: <stable+bounces-242632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FYF0MZWg9mlpXAIAu9opvQ
	(envelope-from <stable+bounces-242632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 03:10:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A34B3F55
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 03:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70108300B9CF
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 01:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AA2224AF1;
	Sun,  3 May 2026 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U0VXgYQT"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8EBA34;
	Sun,  3 May 2026 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770639; cv=none; b=PRAxoxn6pj+OkecbMjqCwJZTnqT8HdzNKkPves4DZy28/NqAhHk23hI9R6EMOuvSwNCY1F1yyVsY2+09Ju/cFj20IM/DZjGGPZvkC/O7yuI2W+7fvWvH4LLeyaPueIFslvnf2RcGsKWEJ7Dd7/GVl/pYBaiJHuwPm5+ePi9zo0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770639; c=relaxed/simple;
	bh=Wpw01WDWUFMnyfc374OhkapxBHY/mVk4KoFrhHOR9+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaJFp8Al8aKhc0RYjqjdNX7W50k1Id90VUrNFIip+WkqEDVxYzpbRbhTl4FZyJC5uxgZwONSThvDipLawsKfn0LeyT0/CFUVOIr34wVitoLAG6jSPiKVmxf32dvB1tFVj7y+q1Ohr4Rb/GPbqtYL0A8ox7xr3vIc7cy++gLYAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U0VXgYQT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5toDuDb8HUCu5NENyASiLGMGq+hqOSYWxghWep45XHw=; b=U0VXgYQTEuZbtLEzdsbPumzqv7
	28BuDEXmSHSm5vntkqHnwlyzpdEHNKvhqq4HMHPAtUPxRLiJaweoFybLJoiBxZO1UnDht9SgNNYn/
	4QJFY62mGJ+6NDAwC9Scwi6Doy7R+1EOlDk/bqZ8tuM1KQOsNEbGz1v04vk+ExmkBb5o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJLLq-0014P4-Ga; Sun, 03 May 2026 03:10:30 +0200
Date: Sun, 3 May 2026 03:10:30 +0200
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
Message-ID: <9ec11642-8035-419c-a896-52f902020bb8@lunn.ch>
References: <20260429150049.1643-1-mike.marciniszyn@gmail.com>
 <20260501134636.GE15617@horms.kernel.org>
 <afXHpPPKhayawr9x@PF5YBGDS.localdomain>
 <f500e75a-5672-4c62-b2b1-04f59bed3368@lunn.ch>
 <afYxULoCOaL3pQkm@PF5YBGDS.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afYxULoCOaL3pQkm@PF5YBGDS.localdomain>
X-Rspamd-Queue-Id: 2A9A34B3F55
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
	TAGGED_FROM(0.00)[bounces-242632-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

> I am working inside Meta with Alex and Kuba.   I noticed the one off when
> doing the patch that reworks the shim.
> 
> As to a real impact, that depends on the part2 series, but before that
> series no one would care, which is why I had in as part of
> the patch 1 series.
> 
> Without the follow on work, I suspect that no one cares or would
> see any issue as I have yet to present the xpcs changes in part2.
> 
> Perhaps the best thing to do is beef up the commit and remove the
> stable Cc, leaving the Fixes linkage?

I'm not even sure you need the Fixes, if you say nothing is observable
broken. Just make it part of the patchset, for net-next, on going
development work.

	Andrew

