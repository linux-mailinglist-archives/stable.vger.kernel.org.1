Return-Path: <stable+bounces-233203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJk1HXHiz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:53:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E124B395FB2
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7035C301DB45
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD983C6A43;
	Fri,  3 Apr 2026 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV0zjIzf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9AE19D8BC;
	Fri,  3 Apr 2026 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231523; cv=none; b=Qvc1EoIgcbYN7drRiOYxC0dO0lvRlv0aKXcJMQVvweXJjLTnFCJxdxa1CqyJowxGEBCMHvIEeD6u76uYj4GnDAvhcSL2W7Mcuui17HjCU+ukgpTYxlivMN5cMNCFhYWxc28uE2QFVaaGLkRTOtSP4KKc3VIITZ7sMWBA0ksj6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231523; c=relaxed/simple;
	bh=T00enF+tM+c3R9+3ciB5lD7rT69eMH/mHt84kQyP3QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca882d6bBJj2tsu8NaHyzGiwK7zF0eRIuyF2XUGhoMUkudrUtAiyTFpHVKfNUJ6YIHNHGWNdtytS8UgPumTXH/uBaTS0WOl+4DHYBVy3cY0zevXa347PPOfO8RJQlBY2SfWpDQvkilmzdwNhF+AFZzjRDyfvgKAsJvgt/6W0bnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV0zjIzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40515C4CEF7;
	Fri,  3 Apr 2026 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775231523;
	bh=T00enF+tM+c3R9+3ciB5lD7rT69eMH/mHt84kQyP3QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bV0zjIzfe/iavTQdfE5UAE+Gsfr14/+sMuDBcihv/dvGBrPtIp2qSZ0kNpXdSxd2V
	 ks5kicS7WSz3xTF+S9isD9P3XVisTWHdtneJaDoCNyn9go9NY8ivpmkQEUJoWL4Mcl
	 D964E7JL9ewFBX4OJqC9Xbf7JdhHLGsfNcVf1EzDTMc4cbRXmVK+1IILSOHq/F9GTv
	 O5q8/93m0OTJ0im2LrHW2PX36/PPH0MaJ0nNAiTeR212VLGbYoE0FyjqvvdLefQhD1
	 vLy4NVzES1/5BasAAKKkjll317u5cHCh9B41ZIO9uy64e+MDUiW4dG62Frs83ek00o
	 LLYnYYcJZMfOA==
Date: Fri, 3 Apr 2026 16:51:58 +0100
From: Simon Horman <horms@kernel.org>
To: Oleh Konko <security@1seal.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jmaloy@redhat.com" <jmaloy@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v3] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Message-ID: <20260403155158.GL113102@horms.kernel.org>
References: <41a4833f368641218e444fdcff822039.security@1seal.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a4833f368641218e444fdcff822039.security@1seal.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233203-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1seal.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E124B395FB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:48:57AM +0000, Oleh Konko wrote:
> The GRP_ACK_MSG handler in tipc_group_proto_rcv() currently decrements
> bc_ackers on every inbound group ACK, even when the same member has
> already acknowledged the current broadcast round.
> 
> Because bc_ackers is a u16, a duplicate ACK received after the last
> legitimate ACK wraps the counter to 65535. Once wrapped,
> tipc_group_bc_cong() keeps reporting congestion and later group
> broadcasts on the affected socket stay blocked until the group is
> recreated.
> 
> Fix this by ignoring duplicate or stale ACKs before touching bc_acked or
> bc_ackers. This makes repeated GRP_ACK_MSG handling idempotent and
> prevents the underflow path.
> 
> Fixes: 2f487712b893 ("tipc: guarantee that group broadcast doesn't bypass group unicast")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleh Konko <security@1seal.org>
> ---
> v3:
> - correct the Fixes tag to the commit that introduced GRP_ACK_MSG and bc_ackers
> 
> v2:
> - make duplicate or stale GRP_ACK_MSG a full no-op via early return
> - place acked in reverse xmas tree style

Reviewed-by: Simon Horman <horms@kernel.org>


