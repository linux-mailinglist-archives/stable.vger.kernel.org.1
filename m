Return-Path: <stable+bounces-217837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PolCQXinGnCLwQAu9opvQ
	(envelope-from <stable+bounces-217837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 00:25:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F817F577
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 00:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A27D302D9C1
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 23:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8A737C0F7;
	Mon, 23 Feb 2026 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="KYwpBIMA"
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9AE37F754;
	Mon, 23 Feb 2026 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889152; cv=none; b=Rz3yJc/gBbQmFbvt5a8vScylD4sai0ttBIieIg+0UZ2FqC+I3uEuuB6use3O/v3E+iLQxjZxWMbaMRWMrO10q/GTM8i4ZUSs35xkabEP/tkojD5zJsOlIHAcn+xrg153VcE3H2bd3bTQUwRpHV+LRjL492QaI4grHQyMYpmrPY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889152; c=relaxed/simple;
	bh=xRhWMBJc69H7kSWKh+9yxb7RfL3YJCE6ag8m7utF3xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUIObWjPq4uNxY7b0macbc/3OzJIekQz5/gzeMI324/VQgr5UZJiXQ66nuWOOjfbPVz2Q1u5LspJMMu17vp4xGiL/7re0JCb5vSzskM6Qtep5AXhI1Edz614dUxrV0h3Sq3uQ7UOe/lRawFzc5KjoP87xqBgSIqG0uB73txtX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=KYwpBIMA; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C8A7560551;
	Tue, 24 Feb 2026 00:25:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1771889146;
	bh=tafzOtZHTxptFE1I7lT6iV4uK0bdXcdtrOiJabPtAK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYwpBIMAjsd7AF8JVRtCIOaxrV2iqk8pRkvtK4FfDXBC27r90C87DP+XfV+oDp6zU
	 fQL2tM/uPbHcfKBko/FEQFJ/HlDfl5woD5fidba+PwaFjPfLN704WIlssS8eeJ0+L1
	 jvRtMxKWB+yVDIHOecQfaphvOvBbCjqrQEEI2B/9LuJbENTWl230nq9TM6s6J+AzFv
	 XMIEsqa16vus7vXjeoBZusWmRAoV9NpSlc+wY6DHbc0pC4WAH583NlKWobU4E0dJ45
	 t7p8M/0WvqmKqhsZ14A9VCH+nTTGQ5aSo5LQelGskyHcxuCR/lX6vCauF9AapfqnKd
	 wR245p9CgUkHw==
Date: Tue, 24 Feb 2026 00:25:44 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: Patch "netfilter: nft_set_rbtree: check for partial overlaps in
 anonymous sets" has been added to the 5.10-stable tree
Message-ID: <aZzh-PW5D2BMcOmL@chamomile>
References: <20260221170938.4180389-1-sashal@kernel.org>
 <aZnqvIqXf-XTipeO@strlen.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZnqvIqXf-XTipeO@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-217837-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B63F817F577
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 06:26:20PM +0100, Florian Westphal wrote:
> Sasha Levin <sashal@kernel.org> wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     netfilter: nft_set_rbtree: check for partial overlaps in anonymous sets
> > 
> > to the 5.10-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> I'm curious, why was this patch picked up for all te stable branches?
> 
> Pablo, whats your take, is it worth the risk?

I would also wait a bit for this fix to roll over the newer kernels.

No rush to get this to -stable IMO.

