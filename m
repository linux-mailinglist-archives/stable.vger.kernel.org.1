Return-Path: <stable+bounces-217812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDhyGfSWnGluJgQAu9opvQ
	(envelope-from <stable+bounces-217812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:05:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0397517B3C7
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA357303F070
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4890433ADA8;
	Mon, 23 Feb 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/TA1P3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5233AD8D;
	Mon, 23 Feb 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869889; cv=none; b=HVtG7ka91pkPUHS1lORu007FBJ9hFjKWa88qtpk2S021yJ11kFE+v1xTjZ7/yefmxoVX1hSCG1+rO5Zesnks1TpzxzzeZX+oPdHo+K0i5pkaEz/hw4JLp8vcdHhyMqbW6bh+7gxsQRAZYTXgHU2KlYLWleHHgYz3jHXEgA9Qruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869889; c=relaxed/simple;
	bh=jTNz6bghS2vX7fzfSwPt5FmZzzVndnGCUpqd+sS3tW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6mZCdzQHcFm/jymjfwcK5IBZjGFeCkZJEEBdcG5pb7DpQZqTL3enFjFL6Je/UW7AfBeWu7lBFj8aceY1ykE4NOHFFY0FUmQWKg1hhyFGj116yWezL9OBug0SEfsmr+/aYhNRSllZ6JBtEJy/xNJW2MQlnLp4uyWt4n7I/tEU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/TA1P3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532C3C116C6;
	Mon, 23 Feb 2026 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771869888;
	bh=jTNz6bghS2vX7fzfSwPt5FmZzzVndnGCUpqd+sS3tW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/TA1P3LHN3w3k8g53QCbFLrYAMNC5VG74BbSs1JeyUdkVdzipYrmt6+5zxwUq6G6
	 WqMjBmpvG/3GenGZYRNr9lJ66oXruQfrsDKgQakdqzLcU78Fl/TOG+QWefGHvL4PjG
	 mgXMTepUttf7ZrsvIfNJrV/JcpiTrl8NDT3Fm0+e1B0B22tPCUHe/nzvlqTyCM4ZIP
	 pbM/K1E91d02iVvmVJ22CmcS9t5gvmhgDSuPObyUtwcKIaCTKH66hAqAoH6nwSCdNi
	 Q1rYmcGSoY3yD6grut6WiYnhwK9in/0RiR8NPlAqCmlRBpuR20L7bd0Yqdr42z3g8U
	 JvnLsqvpPLs+w==
Date: Mon, 23 Feb 2026 18:04:43 +0000
From: Simon Horman <horms@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Rushil Gupta <rushilg@google.com>, Bailey Forrest <bcf@google.com>,
	linux-kernel@vger.kernel.org, Ankit Garg <nktgrg@google.com>,
	stable@vger.kernel.org, Jordan Rhee <jordanrhee@google.com>
Subject: Re: [PATCH net v2] gve: fix incorrect buffer cleanup in
 gve_tx_clean_pending_packets for QPL
Message-ID: <aZyWu1T4dgF2XKcE@horms.kernel.org>
References: <20260220215324.1631350-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220215324.1631350-1-joshwash@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217812-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0397517B3C7
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 01:53:24PM -0800, Joshua Washington wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> In DQ-QPL mode, gve_tx_clean_pending_packets() incorrectly uses the RDA
> buffer cleanup path. It iterates num_bufs times and attempts to unmap
> entries in the dma array.
> 
> This leads to two issues:
> 1. The dma array shares storage with tx_qpl_buf_ids (union).
>  Interpreting buffer IDs as DMA addresses results in attempting to
>  unmap incorrect memory locations.
> 2. num_bufs in QPL mode (counting 2K chunks) can significantly exceed
>  the size of the dma array, causing out-of-bounds access warnings
> (trace below is how we noticed this issue).
> 
> UBSAN: array-index-out-of-bounds in
> drivers/net/ethernet/drivers/net/ethernet/google/gve/gve_tx_dqo.c:178:5 index 18 is out of
> range for type 'dma_addr_t[18]' (aka 'unsigned long long[18]')
> Workqueue: gve gve_service_task [gve]
> Call Trace:
> <TASK>
> dump_stack_lvl+0x33/0xa0
> __ubsan_handle_out_of_bounds+0xdc/0x110
> gve_tx_stop_ring_dqo+0x182/0x200 [gve]
> gve_close+0x1be/0x450 [gve]
> gve_reset+0x99/0x120 [gve]
> gve_service_task+0x61/0x100 [gve]
> process_scheduled_works+0x1e9/0x380
> 
> Fix this by properly checking for QPL mode and delegating to
> gve_free_tx_qpl_bufs() to reclaim the buffers.
> 
> Cc: stable@vger.kernel.org
> Fixes: a6fb8d5a8b69 ("gve: Tx path for DQO-QPL")
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
> Changes in v2:
> * Moved gve_unmap_packet up instead of forward declaration
>   (Jakub Kicinski)

Reviewed-by: Simon Horman <horms@kernel.org>


