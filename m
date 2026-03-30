Return-Path: <stable+bounces-231146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEdCAlxLymmb7QUAu9opvQ
	(envelope-from <stable+bounces-231146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:07:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0885C358DCB
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 359D53015EE0
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FBE3B6BF6;
	Mon, 30 Mar 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="SQyUQ7R3";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="SQyUQ7R3"
X-Original-To: stable@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F1382362;
	Mon, 30 Mar 2026 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865076; cv=none; b=YP/Lp8lKjp7jD1xgyw5hiH8kSFfeFCB9/twfkzRd4ziVz5ACjZF/3wyos22Jr9FTxBEC1qfDeCn2tJpgCkAmOKT5cD5M/E0NUHB1jz8O4CVgZOLP7SFhgZHobI6zY+UfjquA1LKaer6w3OQ4PIo891l0eptkFAJJcfkDQfbU3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865076; c=relaxed/simple;
	bh=+CtOxgKYxsJ3uTzGDmi74E4tq7U00KOjS3BRbExPvD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYpr3LTeVP1vvO6gefhYDVphpx9+ixsJiQ5rLtEhmoKNzlyCilrrMINBLuL8iS0swQBW7XiwvFzXjE9cSvItaYmspIwM89AzDDoHSPL/1OKQLAqiQT8ez3nPt7t6bAjfbFpFxQVWjwJc2G3xXyyga0TopK1vghifnl+50GHTnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=SQyUQ7R3; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=SQyUQ7R3; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1774865067; bh=+CtOxgKYxsJ3uTzGDmi74E4tq7U00KOjS3BRbExPvD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SQyUQ7R3zzQDzXjjIJOxZss+2xKc1KGE4CQW6JMZP/xiKxWsHoa49NihFXTJMA6sf
	 fABwKN+s9kx2jcS9htIN7fKtHfNGyI3Th+MjUPsY7fhNFVIMqsLOHzVnTA4RMZ4Le+
	 uogz39NptGA3koolo4pNRRQVB8YmG7JrI9B7LvNfHhdqU+AbcNkY9xL7isSPf6BFFh
	 FHCtnTlkOzsPw7eOTBsFbFyYXIYxIjwMlo8mlDF4mQY3YWwuMavxXvIDbnu86S5owy
	 XyQ1BY3QAmohyiSvE5s0eS7xPij8jYgz7sCC7OUVADWcoSu2odKcfsqOe8xnb9FgDP
	 XV7O47RJfeneA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 784D9380C00;
	Mon, 30 Mar 2026 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1774865067; bh=+CtOxgKYxsJ3uTzGDmi74E4tq7U00KOjS3BRbExPvD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SQyUQ7R3zzQDzXjjIJOxZss+2xKc1KGE4CQW6JMZP/xiKxWsHoa49NihFXTJMA6sf
	 fABwKN+s9kx2jcS9htIN7fKtHfNGyI3Th+MjUPsY7fhNFVIMqsLOHzVnTA4RMZ4Le+
	 uogz39NptGA3koolo4pNRRQVB8YmG7JrI9B7LvNfHhdqU+AbcNkY9xL7isSPf6BFFh
	 FHCtnTlkOzsPw7eOTBsFbFyYXIYxIjwMlo8mlDF4mQY3YWwuMavxXvIDbnu86S5owy
	 XyQ1BY3QAmohyiSvE5s0eS7xPij8jYgz7sCC7OUVADWcoSu2odKcfsqOe8xnb9FgDP
	 XV7O47RJfeneA==
Message-ID: <b44db9e6-f820-439d-a7ed-c1e2514579a8@mleia.com>
Date: Mon, 30 Mar 2026 13:04:25 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lpc_eth: Fix a possible memory leak in
 lpc_mii_probe()
To: Ma Ke <make24@iscas.ac.cn>, piotr.wojtaszczyk@timesys.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alexandre.belloni@bootlin.com
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330081636.2887980-1-make24@iscas.ac.cn>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20260330081636.2887980-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20260330_100427_510496_A481DC0B 
X-CRM114-Status: GOOD (  20.58  )
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mleia.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mleia.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231146-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vz@mleia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mleia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mleia.com:dkim,mleia.com:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 0885C358DCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Ma Ke,

On 3/30/26 11:16, Ma Ke wrote:
> lpc_mii_probe() calls of_phy_find_device() to obtain a phy_device
> pointer. of_phy_find_device() increments the refcount of the device.
> The current implementation does not decrement the refcount after using
> the pointer, which leads to a memory leak.

this is correct, there is an actual detected bug.

> 
> Add phy_device_free() to balance the refcount.

But this does not sound right, you shoud use of_node_put(pldat->phy_node).

> 
> Found by code review.
> 
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> Cc: stable@vger.kernel.org
> Fixes: 3503bf024b3e ("net: lpc_eth: parse phy nodes from device tree")
> ---
>   drivers/net/ethernet/nxp/lpc_eth.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
> index 8b9a3e3bba30..8ce7c9bb6dd6 100644
> --- a/drivers/net/ethernet/nxp/lpc_eth.c
> +++ b/drivers/net/ethernet/nxp/lpc_eth.c
> @@ -751,7 +751,7 @@ static void lpc_handle_link_change(struct net_device *ndev)
>   static int lpc_mii_probe(struct net_device *ndev)
>   {
>   	struct netdata_local *pldat = netdev_priv(ndev);
> -	struct phy_device *phydev;
> +	struct phy_device *phydev, *phydev_tmp;
>   
>   	/* Attach to the PHY */
>   	if (lpc_phy_interface_mode(&pldat->pdev->dev) == PHY_INTERFACE_MODE_MII)
> @@ -760,17 +760,18 @@ static int lpc_mii_probe(struct net_device *ndev)
>   		netdev_info(ndev, "using RMII interface\n");
>   
>   	if (pldat->phy_node)
> -		phydev =  of_phy_find_device(pldat->phy_node);
> +		phydev_tmp =  of_phy_find_device(pldat->phy_node);
>   	else
> -		phydev = phy_find_first(pldat->mii_bus);
> -	if (!phydev) {
> +		phydev_tmp = phy_find_first(pldat->mii_bus);
> +	if (!phydev_tmp) {

I didn't get it, why the new phydev_tmp is needed above, please
restore the original code above.

>   		netdev_err(ndev, "no PHY found\n");
>   		return -ENODEV;
>   	}
>   
> -	phydev = phy_connect(ndev, phydev_name(phydev),
> +	phydev = phy_connect(ndev, phydev_name(phydev_tmp),
>   			     &lpc_handle_link_change,
>   			     lpc_phy_interface_mode(&pldat->pdev->dev));
> +	phy_device_free(phydev_tmp);

This is plainly wrong and has to be dropped or changed to

	if (pldat->phy_node)
		of_node_put(pldat->phy_node);

>   	if (IS_ERR(phydev)) {
>   		netdev_err(ndev, "Could not attach to PHY\n");
>   		return PTR_ERR(phydev);

Is it AI generated fix or what?.. The change looks bad, it introduces
more severe issues than it fixes.

If you think you cannot create a proper change, let me know.

-- 
Best wishes,
Vladimir

