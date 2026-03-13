Return-Path: <stable+bounces-225319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKPTCrEctGlLhQAAu9opvQ
	(envelope-from <stable+bounces-225319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:18:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B999F284C88
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F392304BD26
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76410397687;
	Fri, 13 Mar 2026 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebfoib8T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F01223336;
	Fri, 13 Mar 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411138; cv=none; b=LiNWBEkO5KxEpMJbi4MFmpCjM31liLsbeegdGhADediRBClNuaY/pFXWBC8eMn5uy0613GSPS7wLXasCTi7QSYzrYoRMRb0wJ+2o+VqwPLz09TOPyxr6qbkfMHiIYR6JwFWoumYg0ezGDTCLVbgvsN3b92BnJdSYbZJFnBJXC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411138; c=relaxed/simple;
	bh=7RyJSShws5Uu3ujZ1vfuxdMl01N4V8cBhwRth/airEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7JWG6h/u3rnMkGClED+AVg/f3kwGpDb4OyctC+8bXRbOl+b9Cwi0vqyFvWdfyV09tcKZtaVDydeedyGuTtra0fIUN0+qdgxiFePcxdA7HGfCyEXpMijZi27lD3nkSpqoCD53DQJlbTmIpIWYfnlJgf9WboGhWJHgniLrS2RjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebfoib8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F5C19421;
	Fri, 13 Mar 2026 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773411137;
	bh=7RyJSShws5Uu3ujZ1vfuxdMl01N4V8cBhwRth/airEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ebfoib8TAfySeuLoT22YQlXeMFmIUiufjpYKEKt4j7irzxQFZFthWvtAXZ33GQXvG
	 X22zluzZOvUNvVfyDAdcrpG6CNuiJInd3upqUEWVryOVn3fY5Hc2LpFmL0xq4Nmq7M
	 VX7KbvfNB1hAZWT0QEPtVsaaeEDSsmtlFWSl+3i9DhpBEwBykxjjJFYsytAHMDAAoJ
	 EQNpDdrbAFKc0UMEYeRg765oAr2YM/fkm9wDzogycbqaTMSV8Uz8Iptb7oZl9hy6tK
	 O6Ma9IoACaooMXpZjD5/kla5ke/MnTtuqD5h5BRhbufWCxt2qXutwCTEcRs2DeN551
	 +IEKqErErfpQg==
Date: Fri, 13 Mar 2026 14:12:13 +0000
From: Simon Horman <horms@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Quanyang Wang <quanyang.wang@windriver.com>, stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: macb: Fix Ethernet malfunction on AMD
 Versal board after suspend
Message-ID: <20260313141213.GB461701@kernel.org>
References: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225319-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email,davemloft.net:email]
X-Rspamd-Queue-Id: B999F284C88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 04:13:57PM +0800, Kevin Hao wrote:
> Hi,
> 
> On Versal boards, the tx/rx queue pointer registers are cleared after suspend,
> which causes Ethernet malfunction. This patch series addresses this issue by
> reinitializing the tx/rx queue pointer registers and the rx ring.
> 
> ---
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> ---
> Kevin Hao (2):
>       net: macb: Introduce gem_init_rx_ring()
>       net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume
> 
>  drivers/net/ethernet/cadence/macb_main.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)

For the series,

Reviewed-by: Simon Horman <horms@kernel.org>


