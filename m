Return-Path: <stable+bounces-217643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLjTEfrqmWl6XQMAu9opvQ
	(envelope-from <stable+bounces-217643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:27:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA66C16D637
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A853009158
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DFD2E62D9;
	Sat, 21 Feb 2026 17:26:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DCD299927;
	Sat, 21 Feb 2026 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694792; cv=none; b=rQEtZxDDnEDih/dNQaUfRJnM2WxTZPXurH8dGi8vwEYppRRzz9mpubQb/g9kx8ziFhUGns41E19+/qYAvwrWqnvIc6W6NvtJy13/bntI9EV/QRUo9Q+a7ZtBZwUS1qFqzigka6FhWqbckdlSMM390ddCbtqNRMQYDGAZD05j8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694792; c=relaxed/simple;
	bh=W1vI2LOtEquL9nyz4qcSLKreMS5n5/1pJelyhtdpmy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMydXsVVlnGp+NOUwXKKNtAAIapwZ4kfutZg9SPaIPw0SU9gG22ETbLiAdQT3dzBjEVyIELrIvf6ouRospIp00WldWj4TK1fdFy6Ll4+YLu9oyiNFRlU7AeFnNORSi25D2bUJEmgBSn9AQrcFZtCudnw2TEnYb81dvNq2YwP80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D303860499; Sat, 21 Feb 2026 18:26:22 +0100 (CET)
Date: Sat, 21 Feb 2026 18:26:20 +0100
From: Florian Westphal <fw@strlen.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, pablo@netfilter.org,
	Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: Patch "netfilter: nft_set_rbtree: check for partial overlaps in
 anonymous sets" has been added to the 5.10-stable tree
Message-ID: <aZnqvIqXf-XTipeO@strlen.de>
References: <20260221170938.4180389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221170938.4180389-1-sashal@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217643-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.960];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: CA66C16D637
X-Rspamd-Action: no action

Sasha Levin <sashal@kernel.org> wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     netfilter: nft_set_rbtree: check for partial overlaps in anonymous sets
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

I'm curious, why was this patch picked up for all te stable branches?

Pablo, whats your take, is it worth the risk?

