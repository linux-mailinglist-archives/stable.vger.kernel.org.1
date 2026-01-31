Return-Path: <stable+bounces-212961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKvbNv1ofmnnYQIAu9opvQ
	(envelope-from <stable+bounces-212961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 21:41:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F18FC3E8F
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 21:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFDAA301B71F
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745437881F;
	Sat, 31 Jan 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9wfntQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93101E1024;
	Sat, 31 Jan 2026 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769892082; cv=none; b=SGSWWqE8tnalFYWa1iRNqPzopx/Sjh3cT85GLhVgZew2g8KN4u8zEAnF6OBufndvgbyozyLslPm7wLkRr7RneIhuS1Vuch1oK8ANltSkHDBzvKPfeTDcgKwWo50/7mVZ7UK6QIpWPFIoXjJBAlApBPgGke9MU9o05gvN/DmMjyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769892082; c=relaxed/simple;
	bh=0L9KHIRomV4Jf/gGMn8eAxBc1vQow6EnmR9i9GB45X8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smoXNIgiq0UeF+8z2Jx/2IXhTnVLgyzu4E1PVDvod6ulUwgYEAXA/ElPFH3Q3g/x39kYO0i3I9vtwXXNT4ac98BhKD6e9+ViEpegfNqiow45OvBEeU6hijV//MqSMTxnlyEv/Vi4zyjvLDXDqrnZ33Q6U0xTU40/rfFT2BAUcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9wfntQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0D0C4CEF1;
	Sat, 31 Jan 2026 20:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769892082;
	bh=0L9KHIRomV4Jf/gGMn8eAxBc1vQow6EnmR9i9GB45X8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s9wfntQV4G/S6o0H1SS0WjOXHPLfqyfakQr52mFSxxf9YnVifL+OnZlm+RBTK/Lo3
	 tTef/j3HOyWcyLM2/32Rcj7B/BsaeKwRcVid1BJ8E/xVwXbWcOJGoJQxtLc7JMq1Nb
	 S++LeiHWawD8rI9dv383XRRVJySmDjzZdic2qF5xGAjMQIQINcqgIYt40F7LHphoI+
	 nP+czU+BscUZITDR/KpIDCycZNDeIWewB9wQxA2Kp+LwryBfdap8SAxHBkrzrixl+b
	 NyJnQBbna9/YeEwYiz6SIgK1tXJteoDseT92oU7fb57uQcroVjRL55kIqMFIdyKxM6
	 NJSSbtOYJ2GGg==
Date: Sat, 31 Jan 2026 12:41:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH net v4] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <20260131124120.744bd931@kernel.org>
In-Reply-To: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
References: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-212961-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7F18FC3E8F
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 13:34:07 +0800 Kevin Hao wrote:
> --- a/drivers/net/ethernet/ti/cpsw_new.c
> +++ b/drivers/net/ethernet/ti/cpsw_new.c

What's your plan for fixing drivers/net/ethernet/ti/cpsw.c ?
My preference would be to post both of the fixes at once,
I think this version is quite close, just a couple of nit picks
below..

> @@ -248,15 +248,25 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
>  	return 0;
>  }
>  
> -static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
> +static void cpsw_ndo_set_rx_mode_work(struct work_struct *work)
>  {
> -	struct cpsw_priv *priv = netdev_priv(ndev);
> +	struct cpsw_priv *priv = container_of(work, struct cpsw_priv, rx_mode_work);
>  	struct cpsw_common *cpsw = priv->cpsw;
> +	struct net_device *ndev = priv->ndev;
>  
> +	rtnl_lock();
> +	if (!netif_running(ndev)) {
> +		rtnl_unlock();
> +		return;

since the "undo" logic is getting complex you should use a goto.
Replace the unlock and the return; here with:

		goto unlock_rtnl;

> +	}
> +
> +	netif_addr_lock_bh(ndev);
>  	if (ndev->flags & IFF_PROMISC) {
>  		/* Enable promiscuous mode */
>  		cpsw_set_promiscious(ndev, true);
>  		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI, priv->emac_port);
> +		netif_addr_unlock_bh(ndev);
> +		rtnl_unlock();


		goto unlock_addr;

>  		return;
>  	}
>  
> @@ -270,6 +280,15 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
>  	/* add/remove mcast address either for real netdev or for vlan */
>  	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
>  			       cpsw_del_mc_addr);

And place a labels here:

unlock_addr:

> +	netif_addr_unlock_bh(ndev);

unlock_rtnl:

> +	rtnl_unlock();
> +}

>  	for (i = 0; i < cpsw->data.slaves; i++) {
> -		if (!cpsw->slaves[i].ndev)
> +		ndev = cpsw->slaves[i].ndev;
> +		if (!ndev)
>  			continue;
>  
> -		unregister_netdev(cpsw->slaves[i].ndev);
> +		priv = netdev_priv(ndev);
> +		disable_work_sync(&priv->rx_mode_work);
> +		unregister_netdev(ndev);

I understand that this is safe but I think that more logical ordering
would be to shut things down _after_ object is unregistered.
-- 
pw-bot: cr

