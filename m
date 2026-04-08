Return-Path: <stable+bounces-233949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJIdADCL1mmwFwgAu9opvQ
	(envelope-from <stable+bounces-233949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:06:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F23BF459
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5043304CA61
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE83845CD;
	Wed,  8 Apr 2026 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MC/lhoEb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEF3537F1;
	Wed,  8 Apr 2026 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667731; cv=none; b=EYKev9yFs8dZLcq2CuWtnqf+MJOJsGd02kH/TRXP3rg8XBtBB0sQCZj6COLk33A0+JcNsd6CZNjRMEYXwcJRSMDU4u4tpGO8vOJ/T6KNPL005HxHDwCtXIT+z8uctjlueNSKxUDDN7K6ug555bwmR51S4VEJl+543ObtwVPMkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667731; c=relaxed/simple;
	bh=7j53ieE8skocjkw6/YxvO5BhfmZzRjD6lGzV/p7kpcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umo+4T+MGhaW8IRtlwFYwm3B2utmaZIflju45ZF5OvvENw8OQhY0wVYvkGXzEdjI6sWrY6lNNcDZCuCKXwGJhI1KrVZ34CmOR+lZae0/Z1GZuDUZHR3HTnyVreS27Vi7vPAa9/WziRNPqLpQfc4Ji8CyxB7V0PwbV6+Z9iywwqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MC/lhoEb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFC8C19421;
	Wed,  8 Apr 2026 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775667731;
	bh=7j53ieE8skocjkw6/YxvO5BhfmZzRjD6lGzV/p7kpcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MC/lhoEb5P2kA8raGgM09BMtvz45r+2z2JXIqTutgRla7XWTx+YgE+POoVFKxxgDq
	 F5BgshIzmgQBJCaz855XVAj5LZWS92re18WWrhKy0ZUMAQ3XcnYZXQJ/DMA1QC+HOk
	 BnYFjP4S0XReOEntjKKheYzt683gDpA5Yrk4ILKCKdSJkgSvEicO+NZmieRlivwX71
	 3uxAKKpFKUIZcYkT2Ze0rHdeVDwW+vK63qdnO1skZYyb5s8Yv2tL6uM2wNOy6mk+mB
	 teSgXjD6/fowM6JjqVb9lKaAaXbopx+eMw+3kI0C2vHY+vVeyb98RI/19/sEsy8eVh
	 7nVV3u/JE7NhQ==
Date: Wed, 8 Apr 2026 18:02:06 +0100
From: Simon Horman <horms@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] octeon_ep_vf: add NULL check for napi_build_skb()
Message-ID: <20260408170206.GI469338@kernel.org>
References: <20260403200732.497307-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403200732.497307-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233949-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 957F23BF459
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 09:07:32PM +0100, David Carlier wrote:
> napi_build_skb() can return NULL on allocation failure. In
> __octep_vf_oq_process_rx(), the result is used directly without a NULL
> check in both the single-buffer and multi-fragment paths, leading to a
> NULL pointer dereference.
> 
> Add NULL checks after both napi_build_skb() calls, properly advancing
> descriptors and consuming remaining fragments on failure.
> 
> Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Hi David,

I appreciate that this is on the fast path, and thus I expect it
is performance critical. But this patch largely duplicates code
already present in the same function. Would it be possible
refactor things a bit - e.g. using helpers - to make the change
a bit cleaner while not hurting performance?

If so, I'd suggest splitting patch(es) that refactor the code
from the patch that fixes the bug.

...

