Return-Path: <stable+bounces-214495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GbeEYy8hGnG4wMAu9opvQ
	(envelope-from <stable+bounces-214495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:51:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C00F4C98
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84403304E308
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A137242980D;
	Thu,  5 Feb 2026 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT8oAQQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B15429801;
	Thu,  5 Feb 2026 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306541; cv=none; b=b7KKx0t+kKauIvH5Z4c70QvwanARDSa3nVeHjVVAtapa6S6LTID2qs9FDRtty9uxRym27z0RoWHyuwjzOhRBS09IsWyYlJcEiQexK7zpddsuEiiI8SpYux29H6o7TIZEp10YCuUlG4lT5cWn1oFgAtG28041KituJnLoJ4lZ4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306541; c=relaxed/simple;
	bh=t8Qq7n3GBnTkkcRxUptPvkwYXSftlw+UTn4NgWQJVRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3I5i7WPZvor1Sn2SbMUOj2MeuK2dPN5oIZ6IaWAgtIk8HdWKpXc6txyvMcHqWrvVizZK8kMPlEqCJ+HqiMj5GDBnt/qemIKPf7VrD3ok1yV3P5IcJJt/b+IJUWuGzFrHNKjQ8rF3Yud1+TFhlVZs51hGt92RgywTVcKI34o4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT8oAQQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605DDC4CEF7;
	Thu,  5 Feb 2026 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770306540;
	bh=t8Qq7n3GBnTkkcRxUptPvkwYXSftlw+UTn4NgWQJVRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dT8oAQQjBRumDKEXiaiAXR9ZiL6YWgA9SGoPGAvrz54iDCRk5ChA17Xz4x/0mIMWc
	 HyW42z/+EOLSUcXT/H66ZKEvz1uiHY8XgxeSC/ls9LQvsC2wQ9w096drncwG+vWKcz
	 S2W6C7yZQMhuWCE8QgavFGrWQahdmFAuoBjuewpuBmh2t0OjrXY7NT+y4Dmp/O9voo
	 Y9o1wfhp9UP2rA/+9JuJyXdU1rc3Mu6hIRe1KkV5qNHaixiuyhnK2fmA+IYqlmwj+N
	 QQSdgERFM7reK8lmF+4bpOkabKoXRUcYtyCfdlzJsWFyeUztpN60iuRLsNLhYnKwl7
	 YMPeHWtI/VapQ==
Date: Thu, 5 Feb 2026 07:48:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bo Sun <bo@mboxify.com>
Cc: pabeni@redhat.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/1] octeontx2-af: CGX: fix bitmap leaks
Message-ID: <20260205074859.27392792@kernel.org>
In-Reply-To: <ba2c3143-0761-4903-ac0e-88ca502b4e50@mboxify.com>
References: <20251020143112.357819-1-bo@mboxify.com>
	<20251020143112.357819-2-bo@mboxify.com>
	<20251022182226.00967149@kernel.org>
	<ba2c3143-0761-4903-ac0e-88ca502b4e50@mboxify.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-214495-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62C00F4C98
X-Rspamd-Action: no action

On Thu, 5 Feb 2026 21:35:29 +0800 Bo Sun wrote:
> >> Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Bo Sun <bo@mboxify.com>  
> > 
> > Looks like rvu_free_bitmap() exists. We should probably use it?  
> 
> Apologies for the late reply.
> You're right that rvu_free_bitmap() exists. I stayed with direct kfree()
> for consistency with the existing code in cgx_lmac_exit(), because which
> already uses kfree(lmac->mac_to_index_bmap.bmap).
> 
> That said, I'm OK with either way:
> 1. Keep kfree() to match the existing pattern in this function
> 2. Switch all three bitmap frees (including mac_to_index_bmap) to use
> rvu_free_bitmap() for consistency with the alloc/free API pairing
> 
> What's your preference?

3. do what I implied, just use rvu_free_bitmap() in this single case
for the fix. Follow up separately with a patch to remaining sites if
any to convert from kfree() to rvu_free_bitmap(). We want the fix
itself to be small, the cleanup should be separate.

