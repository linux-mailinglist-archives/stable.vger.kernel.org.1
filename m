Return-Path: <stable+bounces-267070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hQiTNPy1M2pqFQYAu9opvQ
	(envelope-from <stable+bounces-267070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:10:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6969EBED
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 11:10:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UgoBVbxz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267070-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267070-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F284F30974C1
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C141388386;
	Thu, 18 Jun 2026 09:10:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A52E7F0A;
	Thu, 18 Jun 2026 09:10:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773811; cv=none; b=ouhnjSr1LTtrqD7ODzImORJRh9ASsySab4SFyxZWVMabe/WDzvMfEzrCSEGndltmLdTpItd2XWBJ8YC5yXtIijacrNRTXjg1lVtzei31YZi0IyIiq8ieKaf9cv1JXKvxcaP6gEnzvx9XhsUL0IbYyS+WLtClSOY11QuKzUnaGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773811; c=relaxed/simple;
	bh=seytXUg4OafjTMKgU/OCHFXz84Rva5yGTpWWmyGvRGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoCE5eVtt74RPaGNp5IMpD1LHDPwTF2ti/zE0ad06TqR65xV/yKKplYZ03VlP/uXEgQhcYcyTKFOdmZhS6iSswvxZWvIzIvz1BOLm03+UJnjxq6nYt9Zzld+tB9msVTfgVP41GB0abmW6T0Sm1PpAPp9HpA8SAJB5dNfx3ZwtZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgoBVbxz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EFF1F000E9;
	Thu, 18 Jun 2026 09:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773810;
	bh=qxHls+mvYMga7q55+aIvfUsybLdFRk1lb/ASdVVdilc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UgoBVbxzGIUUQ6cAtRfdVkrJ2rsSgVY/ScZtJ7SG+5Aafgevh00svnwfE08ooiOjX
	 b49oxw1IR95axsZQiIl1Xhf4+KaxY8OZnF/su7GVVAPWVaSS/TvEKyM41LCbwVhY8U
	 XvAXyTBeHdB9EcbARwAEP/A/BtaqPRoE3dMSxWlFZrwk08yjveqPEyYVZWF7iVDQs6
	 OPUNKTXf8KpafqXbtfE1TP0juYfjDmF6He9zX0hXzimvu8e61vQuCP80ZcTwpuQ/TM
	 6Z3r7x+4QiYtP/ofsEGQ0D8WlCH6BMS8lfQdRQgxzdjM6bAzY+TJbReMXglfuDggVN
	 t9qprRxmJWM6w==
Date: Thu, 18 Jun 2026 10:10:04 +0100
From: Simon Horman <horms@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org,
	Philippe Schenker <philippe.schenker@impulsing.ch>,
	danishanwar@ti.com, rogerq@kernel.org,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Carlier <devnexen@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Kevin Hao <haokexin@gmail.com>,
	Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: icssg: guard PA stat lookups
Message-ID: <20260618091004.GG827683@horms.kernel.org>
References: <20260616143642.1972071-1-dev@pschenker.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616143642.1972071-1-dev@pschenker.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-267070-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:dev@pschenker.ch,m:netdev@vger.kernel.org,m:philippe.schenker@impulsing.ch,m:danishanwar@ti.com,m:rogerq@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:andrew+netdev@lunn.ch,m:devnexen@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:haokexin@gmail.com,m:m-malladi@ti.com,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,impulsing.ch,ti.com,kernel.org,lists.infradead.org,lunn.ch,gmail.com,davemloft.net,google.com,intel.com,redhat.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[impulsing.ch:email,infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ti.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FF6969EBED

On Tue, Jun 16, 2026 at 04:35:34PM +0200, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> icssg_ndo_get_stats64() unconditionally calls emac_get_stat_by_name()
> with FW PA stat names regardless of whether the PA stats block is
> present on the hardware.  emac_get_stat_by_name() already guards the
> PA stats lookup with `if (emac->prueth->pa_stats)`; when that pointer
> is NULL the lookup falls through to netdev_err() and returns -EINVAL.
> Because ndo_get_stats64 is polled regularly by the networking stack
> this produces thousands of log entries of the form:
> 
>   icssg-prueth icssg1-eth end0: Invalid stats FW_RX_ERROR
> 
> A secondary consequence is that the int(-EINVAL) return value is
> implicitly widened to a near-ULLONG_MAX unsigned value when accumulated
> into the __u64 fields of rtnl_link_stats64, silently corrupting the
> rx_errors, rx_dropped and tx_dropped counters reported by `ip -s link`.
> 
> Every other PA-aware code path in the driver is already guarded with
> the same `if (emac->prueth->pa_stats)` check.  Apply the same guard
> here.
> 
> Fixes: 0d15a26b247d ("net: ti: icssg-prueth: Add ICSSG FW Stats")

nit: no blank line between tags

> 
> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> Cc: danishanwar@ti.com
> Cc: rogerq@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


