Return-Path: <stable+bounces-267837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G//CDBLmOWpgywcAu9opvQ
	(envelope-from <stable+bounces-267837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 03:49:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9C96B3627
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 03:49:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aGA9qcDk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267837-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267837-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B51F305BE6B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 01:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D2379EF0;
	Tue, 23 Jun 2026 01:41:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C82E36F8;
	Tue, 23 Jun 2026 01:41:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178897; cv=none; b=UjRcd36pGwkE52fELX69bSoszWjXYhPMa11oDS1QQRvhXbb/6k1p3JavAt2GpUcqrThxOhkJ+vTxkd4RapAq2Zel5TJev3zhAGd3khmepOduX+fpwwXL0Zzuto3xSTFBxuBrZXsPFQ7CtP+2AiVGK+u4CbKa+UpcenlNifPUEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178897; c=relaxed/simple;
	bh=jZJvMjh77n8hdoYT97eN9tBxTe9H0AF2EvpQ7Y+WUH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JF6+HRnDFlkY9HEuS7Yiuhx20Ccv4h1gWwDOX5/w06FD+KBQCeOByvBJjBlULandsvo2V/XI7aRAIcMQuhGNf2J2B55RHzHEcawah9kwYRvT1qV/89Wt6hJbjRWw5Gh6qbtxkH9MDMo5JmrfGh2n+vSMFxybamQ61ae1Cc4n1ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGA9qcDk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122BF1F000E9;
	Tue, 23 Jun 2026 01:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782178896;
	bh=jZJvMjh77n8hdoYT97eN9tBxTe9H0AF2EvpQ7Y+WUH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aGA9qcDkBHeimBJIVzteOPU828olZbgJoFvC2ANRWr2N+AziMo9cOks0ahzS9DdSM
	 pwDZBo1OX7uUNO1GYobIvZ2wybfpKn3DDlhnmnwf6tSd7xdus4NrsL9pHTqmvS2RU2
	 jTJZTKQ4eW1A70C8XNPt+3YLzOmBxXuly/EQd85hcGaIvEYma4Y2htmKo08YYK0U92
	 hwB0ncFKb5wSovB8bJp7Xr5gHduibp0Sa9sP8VjSYo82tX0b36puXx79lyv+AOrQo6
	 uaE0zMS9XqS/QEg46fLpLA7Z3/yd+6LCzXWZ0h6zs9CC8fK3ah+00Oi8N9FHFhWsgc
	 uWbRdM2/dNCpg==
Date: Mon, 22 Jun 2026 18:41:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>, skalluru@marvell.com,
 manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, barak@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH net] bnx2x: fix potential memory leak in
 bnx2x_alloc_mem_bp()
Message-ID: <20260622184135.4f185dac@kernel.org>
In-Reply-To: <20260622130515.GE827683@horms.kernel.org>
References: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
	<20260622130515.GE827683@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267837-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:nihaal@cse.iitm.ac.in,m:skalluru@marvell.com,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:barak@broadcom.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D9C96B3627

On Mon, 22 Jun 2026 14:05:15 +0100 Simon Horman wrote:
> FTR, there is an AI-generated review of this patch available on sashiko.dev.
> While I don't think that should effect the progress of this patch you may
> want to consider it in the context of follow-up.

TBH it seems like an adjacent enough issue to me, but okay...

