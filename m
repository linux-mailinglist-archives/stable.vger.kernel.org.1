Return-Path: <stable+bounces-230575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAx5Ep/xxWkkEgUAu9opvQ
	(envelope-from <stable+bounces-230575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:55:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3A533E980
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 03:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 492AA3041942
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4D830DEB8;
	Fri, 27 Mar 2026 02:44:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD03090F4;
	Fri, 27 Mar 2026 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579465; cv=none; b=guIZe9EPGK/uxdpMZ2U0b4rdIgnK4PvVbw4kcoY0u18JEgf+3wSsAmBV8UqrEFF0NezaFDkl8bb7rsi2fcNs4Cbi3md7faPrcCbeoObD1s1w1R+3Y0cfSQu+mWF2WAF5kcHL0SofT+FGQqb2uE7hXSz+sz/9rtCPOC8T3MDkrQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579465; c=relaxed/simple;
	bh=peJJaHsjLqEK05OjKSP0jF59iOfq+EQDL41e+emQEio=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFFky/jATR070casXM4D4t6ELsuGz3veQodtttZ0AyTsikuKJD+LPuLPGnW9VadfrV5UPWsxDut+qhWVLo43aoIMEVyGT6thqxzXXLWxLdNueDGver8Qgz6sFlJ/FweZ9NypXuuRggDd+9snlc3Xq7fFG5sl1eGATQx6yi4phFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: lnsJvOpWTqyzRzuc4I0aMQ==
X-CSE-MsgGUID: kceDxBe3Q8uNdUy5CiXOiA==
X-IronPort-AV: E=Sophos;i="6.23,143,1770566400"; 
   d="scan'208";a="144766630"
Date: Fri, 27 Mar 2026 10:44:13 +0800
From: Dayu Jiang <jiangdayu@xiaomi.com>
To: Kuen-Han Tsai <khtsai@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: u_ether: Fix race between gether_disconnect
 and eth_stop
Message-ID: <acXu/Vr/+OAq2jqU@oa-jiangdayu.localdomain>
References: <20260311-gether-disconnect-npe-v1-1-454966adf7c7@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260311-gether-disconnect-npe-v1-1-454966adf7c7@google.com>
X-ClientProxiedBy: BJ-MBX04.mioffice.cn (10.237.8.124) To BJ-MBX03.mioffice.cn
 (10.237.8.123)
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[xiaomi.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oa-jiangdayu.localdomain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiangdayu@xiaomi.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230575-lists,stable=lfdr.de];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 7B3A533E980
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 05:12:15PM +0800, Kuen-Han Tsai wrote:
> A race condition between gether_disconnect() and eth_stop() leads to a
> NULL pointer dereference. Specifically, if eth_stop() is triggered
> concurrently while gether_disconnect() is tearing down the endpoints,
> eth_stop() attempts to access the cleared endpoint descriptor, causing
> the following NPE:
> 
>   Unable to handle kernel NULL pointer dereference
>   Call trace:
>    __dwc3_gadget_ep_enable+0x60/0x788
>    dwc3_gadget_ep_enable+0x70/0xe4
>    usb_ep_enable+0x60/0x15c
>    eth_stop+0xb8/0x108
> 
> Because eth_stop() crashes while holding the dev->lock, the thread
> running gether_disconnect() fails to acquire the same lock and spins
> forever, resulting in a hardlockup:
> 
>   Core - Debugging Information for Hardlockup core(7)
>   Call trace:
>    queued_spin_lock_slowpath+0x94/0x488
>    _raw_spin_lock+0x64/0x6c
>    gether_disconnect+0x19c/0x1e8
>    ncm_set_alt+0x68/0x1a0
>    composite_setup+0x6a0/0xc50
> 
> The root cause is that the clearing of dev->port_usb in
> gether_disconnect() is delayed until the end of the function.
> 
> Move the clearing of dev->port_usb to the very beginning of
> gether_disconnect() while holding dev->lock. This cuts off the link
> immediately, ensuring eth_stop() will see dev->port_usb as NULL and
> safely bail out.
> 
Hi Greg,
Hit the same issue during NCM switch stress test.
Can you take a look at this patch and check if it¡¯s ready for merge?

Thanks,
Dayu Jiang
> Fixes: 2b3d942c4878 ("usb ethernet gadget: split out network core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> ---
>  drivers/usb/gadget/function/u_ether.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 338f6e2a85a9..2c970a0eafd9 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -1246,6 +1246,11 @@ void gether_disconnect(struct gether *link)
>  
>  	DBG(dev, "%s\n", __func__);
>  
> +	spin_lock(&dev->lock);
> +	dev->port_usb = NULL;
> +	link->is_suspend = false;
> +	spin_unlock(&dev->lock);
> +
>  	netif_stop_queue(dev->net);
>  	netif_carrier_off(dev->net);
>  
> @@ -1283,11 +1288,6 @@ void gether_disconnect(struct gether *link)
>  	dev->header_len = 0;
>  	dev->unwrap = NULL;
>  	dev->wrap = NULL;
> -
> -	spin_lock(&dev->lock);
> -	dev->port_usb = NULL;
> -	link->is_suspend = false;
> -	spin_unlock(&dev->lock);
>  }
>  EXPORT_SYMBOL_GPL(gether_disconnect);
>  
> 
> ---
> base-commit: 1be3b77de4eb89af8ae2fd6610546be778e25589
> change-id: 20260311-gether-disconnect-npe-5861d9831dff
> 
> Best regards,
> -- 
> Kuen-Han Tsai <khtsai@google.com>
> 

