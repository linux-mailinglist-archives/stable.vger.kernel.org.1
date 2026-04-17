Return-Path: <stable+bounces-238483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K7WB9Mi4mlX1wAAu9opvQ
	(envelope-from <stable+bounces-238483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 14:08:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DDC41B1B0
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 14:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 169B030E64D1
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727E399032;
	Fri, 17 Apr 2026 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0jNKhVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809F3101BC;
	Fri, 17 Apr 2026 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427368; cv=none; b=aHAI8ZMWTyJqLwpN4KKQXEayKX5wfNK1OUIr2OPHRObphzjrMAiDBKO7wOE+bRcSSy9fRQ27+9CGMV0XY2mUWLHgWkt748rCXJIz/QhDmiwnArmTxtRrPUZfy39j6xyqs5GcjNXvTC0JrRksBhw+cdhf3DdcGs0K5kcvxvAAt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427368; c=relaxed/simple;
	bh=wWaIRV1MIS1xv8UznMgFsqd6IKogDq+9sT1tvV5zs1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExMLIK33Zy+cK0OWz2OJL/m2BXRV94j+QR+Tey9NAuJFxjFkN1OHNtzoAy+rafkXNaJWnwLUnfSDeiqbSz5UW1k6djc0wsOisY60tk+FJ8SYnOldjUMioL8lKpvvDQcUuPaX0RrmTHC5SeWOsQljIcjedgs/XAa4Sehg2LCeq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0jNKhVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F748C19425;
	Fri, 17 Apr 2026 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776427368;
	bh=wWaIRV1MIS1xv8UznMgFsqd6IKogDq+9sT1tvV5zs1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0jNKhVTxtgSdQPTKlNVssTUZIBC5LZhP3I5A65p0MWfzYr5e8Awix7AOv4lqEZQ0
	 9uu6fC4RDNfSHXh4ihKPdpAlsMC35haibUTNe6isOx9p6kA4yX9N7+66h54azRhHxa
	 zD9i5xfRYhCHLQXNXz66JzQQupsCsRDzTAtwypvD7WscEi6Tx27/YcrIxLOwRQ8M+f
	 jZplGtQV2iAZtkmFbwZGYIKlSDKCtaGJ1/oIccx+QCr83T8dN1K6B8Io3dlterQhus
	 EUvfr+6lDeXD8TdezYzx3C903UYDyfxV8u8qE49gh0WYoTh5aOg9ynI+aNOMbpYkFB
	 4dAL8EJm9n7WA==
Date: Fri, 17 Apr 2026 13:02:43 +0100
From: Simon Horman <horms@kernel.org>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] rose: fix OOB reads on short CLEAR REQUEST frames
Message-ID: <20260417120243.GB31784@horms.kernel.org>
References: <20260415055756.3825584-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415055756.3825584-1-ashutoshdesai993@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238483-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: A6DDC41B1B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 05:57:56AM +0000, Ashutosh Desai wrote:
> rose_process_rx_frame() calls rose_decode() which reads skb->data[2]
> without any prior length check. For CLEAR REQUEST frames the state
> machines then read skb->data[3] and skb->data[4] as the cause and
> diagnostic bytes.
> 
> A crafted 3-byte ROSE CLEAR REQUEST frame passes the minimum length
> gate in rose_route_frame() and reaches rose_process_rx_frame(), where
> rose_decode() reads one byte past the header and the state machines
> read two bytes past the valid buffer. A remote peer can exploit this
> to leak kernel memory contents or trigger a kernel panic.
> 
> Add a pskb_may_pull(skb, 3) check before rose_decode() to cover its
> skb->data[2] access, and a pskb_may_pull(skb, 5) check afterwards for
> the CLEAR REQUEST path to cover the cause and diagnostic reads.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> V2 -> V3: drop kfree_skb() calls to fix double-free; add end-user
>           visible symptom to commit log; use [net] subject prefix
> V1 -> V2: switch skb->len check to pskb_may_pull; add pskb_may_pull(skb, 3)
>           before rose_decode() to cover its skb->data[2] access
> 
> v2: https://lore.kernel.org/netdev/177614667427.3606651.8700070406932922261@gmail.com/
> v1: https://lore.kernel.org/netdev/20260409013246.2051746-1-ashutoshdesai993@gmail.com/


Unfortunately this conflicts with a recent commit, which I believe
addresses the same problem: commit 2835750dd647 ("net: rose: reject
truncated CLEAR_REQUEST frames in state machines")

I do, however, note that commit doesn't use pskb_may_pull.
So perhaps you could make an incremental change to add that.

Also, FTR, Sashiko has quite a few things to say about other problems
in this and adjacent code.

