Return-Path: <stable+bounces-238481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCoFCx4f4mlX1wAAu9opvQ
	(envelope-from <stable+bounces-238481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:53:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F3D41AF4B
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D451301843F
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BB938F95E;
	Fri, 17 Apr 2026 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWWhQdIW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3E12B94;
	Fri, 17 Apr 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426689; cv=none; b=g/2P6wO0zrSRubwwgTgrTqyziUJddpL5GIHaaX3SxUjvNu6N4o1HnRyOv4Dj5fH1pAFpBSqYo8O/BaFHB5ATCgkA6GGMg9WG4pHKU6vbTasZG6Puh/m/RQEWARJBBlrIYB/R44+ZZeZk61ZoDDuF2T94FKw+1ECZOr29+7pY0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426689; c=relaxed/simple;
	bh=rAXyLT5RLfyphcv1d83h3XEBAAHlPAV0dBZp35OPm0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duLBSuOXHDRv0Sc5DlG0e/d5TAYgRs9tDOHLWcHrgQuBFCqyfNJkOrwc+GOUTFcLswRkzUr7pjdEuCdxkANBkTuqt/NxHwDHYYl4+fepdW9C1/iLYm+TsFtH7+oszO48yiho6hiIQ8E3+LSlGPQUTi7dkC+ZgF2FDpm1vQ23ocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWWhQdIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92BCC19425;
	Fri, 17 Apr 2026 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776426688;
	bh=rAXyLT5RLfyphcv1d83h3XEBAAHlPAV0dBZp35OPm0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWWhQdIWdYicGc8rjEfFApwQQ+vyljQ7WmK9K7RlPn9NGJURPJ1tCWClR1V7WaZ6U
	 owzPnxJCDENKSUiyrTS1zBbuELUUCKMVQQmlB114vq85MFkzdOHJ5QeVuJWCXShi9g
	 iDNg3Uy+B4ptYuzKAeIwn/V4v7UMxODwIl2GHDAQbevpBVa3WumJREEh8XVuKjEUel
	 d5NhrPviXJrtSgqBxxVWLWg5T0ZVkKcdNXJWZyYwapcyLcjhYxUwOIwEZ369YTKOZX
	 U5elaBkIoufQN7a/nGJY+QqERUq2fj3Lqgf4YGrdBNgftZax8/3UCrP1ckDYq7rQ/3
	 vWUHcLTk8YJ7Q==
Date: Fri, 17 Apr 2026 12:51:22 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	kohei.enju@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] igc: fix potential skb leak in
 igc_fpe_xmit_smd_frame()
Message-ID: <20260417115122.GA31784@horms.kernel.org>
References: <20260415025226.114115-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415025226.114115-1-kohei@enjuk.jp>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238481-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8F3D41AF4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 02:52:18AM +0000, Kohei Enju wrote:
> When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> allocated skb, leaking it. [1]
> Use dev_kfree_skb_any() on failure.
> 
> Tested on an I226 adapter with the following command, while injecting
> faults in igc_fpe_init_tx_descriptor() to trigger the error path.
>  # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on
> 
> [1]
> unreferenced object 0xffff888113c6cdc0 (size 224):
> ...
>   backtrace (crc be3d3fda):
>     kmem_cache_alloc_node_noprof+0x3b1/0x410
>     __alloc_skb+0xde/0x830
>     igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
>     igc_fpe_send_mpacket+0x37/0x90
>     ethtool_mmsv_verify_timer+0x15e/0x300
> 
> Cc: stable@vger.kernel.org
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> ---
> Changes:
>   v2:
>     - change to idiomatic style with goto (Simon)
>     - add Cc to stable (Alex)
>     - add reprodunction steps (Alex)
>   v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has comments about a potential existing bug in the same code path.
I'd appreciate it if, as a follow-up, you could look over that.

Thanks!

