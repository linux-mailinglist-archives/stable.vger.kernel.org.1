Return-Path: <stable+bounces-232655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WODCMW6KzGlXTgYAu9opvQ
	(envelope-from <stable+bounces-232655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:01:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09E37418F
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AAAF30173BB
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 02:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE036B071;
	Wed,  1 Apr 2026 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejXd3Alk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9822364EB8;
	Wed,  1 Apr 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012370; cv=none; b=gyNV6dUItcu7MQW7BmUM6st8lQljUFW47XljdpZeA3C9HL27a59HVEl4+Lh2F0X5KPp10EuXdtrlKU6f1dPtiSUsoEpWFsmu4ODoOeoMgLRmtltLh/3t353eIX1yGHds1rkb4a68sPo2MM0cKV8PTBK5yFZs5HJ8XEI2lh1C5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012370; c=relaxed/simple;
	bh=BGtOrxnlk6f59RvxLQ1mRseOThrers00WBWsCD6tbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJ57ymuy8Bo2YQ+MBoMu9zvwWYzN+FoQvoQwDzBI0uRXk9+i9oQyAMOoO/+Fsf+mALQO7VN2q+H2Viw/pnMAwjrEVIWD6YXlkzOaQusJPnxEwaNsHQ57nhnQFDPyxIjODIGgN5X3E9EaBefee6QL0zoTL6ZiBXuzHwF9pc3Ikx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejXd3Alk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C17BC19423;
	Wed,  1 Apr 2026 02:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775012369;
	bh=BGtOrxnlk6f59RvxLQ1mRseOThrers00WBWsCD6tbDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ejXd3AlkjyQFOWvztrRgWHqY/UPe86R9tWibU5sjEoiuQCymqVwOnESxxYPVptFqD
	 ThXvk7uvuC4ujZ0GITitI/+iZWCpcj++s7cmpooq2Ss+Q4ZKYK6Kxdx69dKKcNVhe/
	 YjqFAUrkyChYsqYNhFsR+7P91nxQu00+ckDA0jtk2v69WC5JfCHMWi5oiD8w06SrzM
	 aMvJvsiZ7xO6FkPyefRv5Qa18RhJJrTcaU/Aiz/ZbhcGgShtNyqOZBGOebd91MZxlT
	 BlNVA9JbFLP2PkK7jnIbn0j3rjHu0lBiKS4KfKpTSjESBJBpgc2SOV5nDMRq6NqEtB
	 9AEbFlhiX6mhA==
Date: Tue, 31 Mar 2026 19:59:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [RESEND PATCH net v3 2/2] net: stmmac: Prevent indefinite RX
 stall on buffer exhaustion
Message-ID: <20260331195927.3353cc6d@kernel.org>
In-Reply-To: <20260328192503.520689-3-CFSworks@gmail.com>
References: <20260328192503.520689-1-CFSworks@gmail.com>
	<20260328192503.520689-3-CFSworks@gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232655-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E09E37418F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 12:25:03 -0700 Sam Edwards wrote:
> @@ -5870,6 +5871,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  	priv->xstats.rx_dropped += rx_dropped;
>  	priv->xstats.rx_errors += rx_errors;
>  
> +	/* If stmmac_rx_refill() failed, keep trying until it doesn't. */
> +	if (unlikely(stmmac_rx_dirty(priv, queue) > 0))
> +		return budget;

If the system is OOMing having ksoftirq busy looping indefinitely is
not going to be very helpful. 1) only react if the fill level is below
some critical threshold, 2) try to add some delay (timer)? before the
retry
-- 
pw-bot: cr

