Return-Path: <stable+bounces-237909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBWJOHRe3mn+CQAAu9opvQ
	(envelope-from <stable+bounces-237909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:34:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 588513FBEED
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15AFA309A837
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810173EAC68;
	Tue, 14 Apr 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEkDpZrR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E83E9F72;
	Tue, 14 Apr 2026 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180584; cv=none; b=a3uqwiz3OxhJoAFyz+6r8E7+4Un0v6VY1jQoHeazvYuf/Jcr34Nx1u6/Sx5Uvx2Rj/YSRazLnOCJMC3+gawjKbNtUApsEg6aV7T0PP3ztkTgcInJDQfWwxmwypqEkCR/E4td0HMyhF3IndkHvBckGizQlBUjn714m2TPHggmY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180584; c=relaxed/simple;
	bh=xNRBWWbIZxhUCsZYPkiOoWGps5Il08Hs7/oKEp/LH4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xe8HA2MffV5XV3hNgehW8Y+K7Cx1rpDbcFdFVD17Fjo5ASbja5XjLg02LitwQzqK66/r+bX3s3VtkWRs8eFhBxKpvipnG83OyP6Xc/45SGfneXZ0o4W0pjx5DJ0Jk/Y7WqBCL4SGon6ftwAuRMERheduguSw6nr95RXgvjLVvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEkDpZrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C90C2BCB6;
	Tue, 14 Apr 2026 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776180583;
	bh=xNRBWWbIZxhUCsZYPkiOoWGps5Il08Hs7/oKEp/LH4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lEkDpZrRMbgWTwJRmD5987Iujt8rUwqUZHmndxeFvAZEnPOviqgtPf17nUbDaxSql
	 YbqAWYNGyfwoTwAuVNjJyfk9KPheZhi1g7iCeiBYMxJ6anBqj7fAjTnEhQmZyPO8id
	 ercFca3fytI6Il8qmBBfeGJ+xNV+OgK/c/3WLecW/M+9lVMRNgQXhTKfU1VMB9C+Eb
	 q81RmGzANfavcVR0PxGg+c26dekCVLf12RPMoU7dJWdVIpc05Xgn9ZnCtdeuChikKx
	 XW1+fTkHAKJRPI2zE/75pKXccxw5Nidw9gu3PBaKpO/qxTOaBhTzWPMwFr9UOta6Fb
	 0LSiuYB1cN9cA==
Date: Tue, 14 Apr 2026 08:29:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Vasut <marex@nabladev.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Nicolai
 Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>, Ronald Wahl
 <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs
 around IRQ handler
Message-ID: <20260414082942.2c61b427@kernel.org>
In-Reply-To: <20260414080931.3aef9df4@kernel.org>
References: <20260414103327.113500-1-marex@nabladev.com>
	<20260414125753.Im6GAIHn@linutronix.de>
	<20260414080931.3aef9df4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237909-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 588513FBEED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 08:09:31 -0700 Jakub Kicinski wrote:
> On Tue, 14 Apr 2026 14:57:53 +0200 Sebastian Andrzej Siewior wrote:
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>  
> 
> Maybe I'm not being forceful enough.
> 
> Putting workarounds in the drivers is unacceptable.
> __netdev_alloc_skb() must be legal to call under an _irq spin lock.

My bad, only read your reply to the old thread now.

