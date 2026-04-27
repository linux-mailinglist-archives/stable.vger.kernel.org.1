Return-Path: <stable+bounces-241452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JbgK4j472mFMwEAu9opvQ
	(envelope-from <stable+bounces-241452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:00:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7747C05D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD44D3018754
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 00:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20723E275F;
	Tue, 28 Apr 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPXetWRJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F99374E66;
	Tue, 28 Apr 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334401; cv=none; b=cs5jmy04dVWUZzkIMKQsMT3TJyC01y/cn5OTEZls81lMxlAmWZQr4QDRFHPXyb8tN98Ci2vQMVmfkiZt3b5O87RcVGAWdMgJVwvWAfgpTxHSUZbApqWjFvtHlIibKyXnIZpFq+RYI1xKavwhBggKYvpQUkEumRww3f7HUOHkaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334401; c=relaxed/simple;
	bh=jvUQNJO0CNKdhLWlL+0LO6GCDOg/e6o0Bp/wntZcfU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgfv0IlKaOBWye6POTCQkIvwaK0Gi/R9ad+yvsdf0YLhEqlObf/VUAaRIaWTr/N4kgIAoTOF3xeLXiKHL7Zb+gVToZ/VZ/fA1FjNybbE6A0FrkJW6f6sv4Hwi+FN2bXfuTBETv0M0cqeHZ0CFFt73Ho8Eviigu+ZlDI0eakry64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPXetWRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3880C19425;
	Tue, 28 Apr 2026 00:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334401;
	bh=jvUQNJO0CNKdhLWlL+0LO6GCDOg/e6o0Bp/wntZcfU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OPXetWRJPRC0CVrp70iEZrMRgWaCi1hjG1IVTK4hck+8afVa6mwx3Hvqdg2pkmKUh
	 W09EAnWmfAloaqpqPRGv46LtDIy8DSsj8tXRLCaQFV+lzRJdM+pMoXPTZgQGJ7wkzT
	 E3ZmZtEaOtev6x+OWK35EsMmKLOp4mNVJ2C9gyrGTk5gZHi7TPtH8qeoIoOGBEAaW+
	 fRwlvRpELrIAJTdghIrmNd4XEzxxa3a2M7/C0EseTCWGYINYOT3t9OD8Ll414YfVgY
	 xwKDR7hiAjRlx2uIsyLxaCzFhDCqXMVrzsH/IkNWmfJW5dZgLWL558m1NQBqGcm4Yz
	 HLMuf8wrEzDvA==
Date: Mon, 27 Apr 2026 16:59:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Yibo Dong
 <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, MD Danish
 Anwar <danishanwar@ti.com>
Subject: Re: [PATCH] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
Message-ID: <20260427165959.3a294f1a@kernel.org>
In-Reply-To: <20260425041816.19070-1-enelsonmoore@gmail.com>
References: <20260425041816.19070-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 84D7747C05D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241452-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 24 Apr 2026 21:18:15 -0700 Ethan Nelson-Moore wrote:
> +# This section depends on BROKEN because its only child item also does;
> +# see the explanation below.
>  config NET_VENDOR_MUCSE
>  	bool "Mucse devices"
>  	default y
> +	depends on BROKEN
>  	help
>  	  If you have a network (Ethernet) card from Mucse(R), say Y.

We can keep the vendor as is, this doesn't enable any code compilation
-- 
pw-bot: cr

