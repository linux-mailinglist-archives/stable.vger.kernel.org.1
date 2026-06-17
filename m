Return-Path: <stable+bounces-266670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZXP9KTNgMmrOzAUAu9opvQ
	(envelope-from <stable+bounces-266670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:52:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F925697AB2
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 10:52:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DuxFI3dC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266670-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266670-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D43D630A5620
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804853DFC6A;
	Wed, 17 Jun 2026 08:47:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5523D2FFC;
	Wed, 17 Jun 2026 08:47:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686034; cv=none; b=hA5TXxUwf8bIEIUrb6gzOYPhtKIj7yh5InPWOmSKZuqm8IIppKixYJhJb9lL6Z0lSchvP33ZvkXKR8h3BGBgKgBYOodjT30OJJq8fbCLpfIOZaO45WVwg6N5wsLdafBbCv52G7smWnqT38Pp0yHj1J3P/VfzhEk9C62NkbI4qPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686034; c=relaxed/simple;
	bh=S6mSooM/vtyjoeK/caPdDRvpomij9YUtS8I+hppAXPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGBQrpeGcN2Hcfj7vG5asWQTCKamt/Etj8bUHCjEa8BfO8exMC5Ve2ma8Un24TTVR9KDquHs5ogA189Q3UfYB6cJlNxMhAvOxsH74Y11YW1I+GUObaqg/lFccb8zj5NujDSZSgw8W/Ahlrb4CU/H1GLIt4ROdhSC4/kI4uBz8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuxFI3dC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB421F00A3F;
	Wed, 17 Jun 2026 08:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781686026;
	bh=htuQhUa1HfSLqmSf+a4aGM2L9LirqJSYUGKvORQmPkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DuxFI3dCysid9xJBJTERwWsTGfgg74K3i4Y+T0uvGz+gjHYu4R5MZbHNjglDc4BNi
	 nV/lwjA8n0qbbpt38AVe835BqANxZ6BsFQPgNIw2X4JN8CqnH8+++HJZ/4L7EThdZQ
	 L2YR9q2MCF3Zm4l7TRPTNDZccOuCrYyNLZ77G7UK1KKXrqQdxmHxOVj69Y6HxhywCM
	 oCtxeDe8EHLcCDdx3+yFsRKpLXRiuhfRm+MkQt1pekWrWzm8rPBh2AK1ZDR59aWwyI
	 ERvV994c8jW2KZ2KSR9qo3Os7KFZEKl8kOsfzMg1q1cv3ZZmCTyXdN6QSvF+d5BqJQ
	 R1M7SHYWx8pZw==
Date: Wed, 17 Jun 2026 09:47:01 +0100
From: Simon Horman <horms@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, piotr.raczynski@intel.com,
	michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ice: eswitch: fix use-after-free of metadata_dst in
 repr release
Message-ID: <20260617084701.GB827683@horms.kernel.org>
References: <20260615140532.52676-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615140532.52676-1-doruk@0sec.ai>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266670-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:piotr.raczynski@intel.com,m:michal.swiatkowski@linux.intel.com,m:wojciech.drewek@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,horms.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F925697AB2

On Mon, Jun 15, 2026 at 04:05:32PM +0200, Doruk Tan Ozturk wrote:
> ice_eswitch_release_repr() frees the port representor metadata_dst via
> metadata_dst_free(), which directly kfree()s the object and ignores the
> dst_entry refcount. The eswitch slow-path TX routine
> ice_eswitch_port_start_xmit() takes a reference on this dst with
> dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
> is still in flight (e.g. queued in a qdisc) when the representor is torn
> down, the metadata_dst is freed while the skb still points at it. When
> the skb is later freed, dst_release() operates on already-freed memory.
> 
> Replace metadata_dst_free() with dst_release() so the metadata_dst is
> freed only after the last reference is dropped. The dst subsystem frees
> metadata_dst objects from dst_destroy() once the refcount reaches zero
> (DST_METADATA is set by metadata_dst_alloc()).
> 
> Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
> nft_tunnel: fix use-after-free on object destroy").

I think that the commit cited above moves the code in question around
but did not introduce the call to dst_release. And I think that this
bug goes back to when switchdev support was added.

I would suggest:

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")

> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Otherwise, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


