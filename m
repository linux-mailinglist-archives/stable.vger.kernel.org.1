Return-Path: <stable+bounces-233374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD9CImqn02klkAcAu9opvQ
	(envelope-from <stable+bounces-233374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 14:30:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E17613A3493
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04ED4301DCD8
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293332694F;
	Mon,  6 Apr 2026 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="exUuEimw"
X-Original-To: stable@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36AB3368B0
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478596; cv=none; b=Vx15sjPAR8l5IzA1u0lBJOZplAYj+g+0hbmA+YZEqzFrp5OWgEC6RoLRp9tFVFVg1nI3GtYXoOFdOUGlBUvtLN6Fshw4H8mzmVK++yNBMyZSYgi++AerqzZeLd8KoIWbCNZNikhRGAz3LJH32jmwUTDRUsplekIpqLHp944Wl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478596; c=relaxed/simple;
	bh=emRCJyacTnSloKRUbPyqntMfWZ5pD3jQ3P79nsNsgmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN8G2+7wJBM3Q8QxPfpCGzNGeQl4stD2ZNRUSEXnjVEqmhfwWzvN2M2FCQQuQNilPw1n5tB3e5nuAg/EbpJgLVDNTXkQm39P7OCHFZ/Nd07RgSGIo5qw3XgSya3LOW4oN+KB1sApaEHbv32pCWfvK/iD+7qRvjKSaX9dxkPERqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=exUuEimw; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 636CTo3j080947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 6 Apr 2026 21:29:52 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=3OLGYuWueXpAxw4Xwkb7rNrd6HvEWShajiH3l89z4JE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1775478592; v=1;
        b=exUuEimwu+3LRSzYhW/E37U5h2mO6GNiVvGmtd5dpgX/MBhWFIRJCLhZbiiqOJDa
         0qTY6LkjTmVPE4ycnrw8xHlErDa4Lvy/wPiI9NPbZmm7QLuh53Ji8h9boEEkZZrY
         +8bgVkBfITYXHXECH6t6DfGXldKysJhXceZOAdcFCR5B3sNyXYkf2vTTYTwZZXKg
         yhR6XtxA81mCXQqIQ1iN0W6C9XTvQhqs14dxL4cnl8XI13cHGjwWN0Jk954uLN7L
         TjoH7yRrykcjXmbrOW1BOFKavYCawN7taZrMrAR7Siup5IhIzBBQWWOwHAPTl3e8
         CvTnHpqFoo5nVy8PO9RyUA==
Date: Mon, 6 Apr 2026 21:29:50 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 3/3] iavf: drop netdev lock while waiting for MAC
 change completion
Message-ID: <adOjGCms-5PBuNte@x1>
References: <20260406112057.906685-1-jtornosm@redhat.com>
 <20260406112057.906685-4-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260406112057.906685-4-jtornosm@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233374-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E17613A3493
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/06 13:20, Jose Ignacio Tornos Martinez wrote:
> After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
> operations"), iavf_set_mac() is called with the netdev instance lock
> already held.
> 
> The function queues a MAC address change request and then waits for
> completion while holding this lock. However, the watchdog task that
> processes admin queue commands (including MAC changes) also needs to
> acquire the netdev lock to run.
> 
> This creates a lock contention scenario:
> 1. iavf_set_mac() holds netdev lock and waits for MAC change
> 2. Watchdog needs netdev lock to process the MAC change request
> 3. Watchdog blocks waiting for lock
> 4. MAC change times out after 2.5 seconds
> 5. iavf_set_mac() returns -EAGAIN
> 
> This particularly affects VFs during initialization when enslaved to a
> bond. The first VF typically succeeds as it's already fully initialized,
> but subsequent VFs fail as they're still progressing through their state
> machine and need the watchdog to advance.
> 
> Fix by temporarily dropping the netdev lock before waiting for MAC change
> completion, allowing the watchdog to run and process the request, then
> re-acquiring the lock before returning.
> 
> This is safe because:
> - The MAC change request is already queued before we drop the lock
> - iavf_is_mac_set_handled() just checks filter state, doesn't modify it
> - We re-acquire the lock before checking results and returning
> 
> Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
> cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index dad001abc908..6281858e6f3c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1068,10 +1068,14 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  	if (ret)
>  		return ret;
>  
> +	netdev_unlock(netdev);
> +
>  	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
>  					       iavf_is_mac_set_handled(netdev, addr->sa_data),
>  					       msecs_to_jiffies(2500));
>  
> +	netdev_lock(netdev);
> +

Hi Jose, thank you for the fix and detailed explanation.

I don't have a great solution for this issue, but dropping the netdev
lock taken by the networking core in the driver callback might not look
acceptable.

FYI, Petr reported the same type of locking issue in
ndo_change_mtu(), and the v1 approach was really similar to this one.
https://lore.kernel.org/intel-wired-lan/20260202155813.3f8fbc27@kernel.org/

IIUC, the issue was eventually fixed by completing the reset
synchronously in the same context as ndo_change_mtu(), instead of
dropping the netdev lock and waiting for reset_task.
https://lore.kernel.org/intel-wired-lan/20260211191855.1532226-1-poros@redhat.com/

If that applies here as well, maybe iavf_set_mac() needs a similar
approach, e.g. progressing the relevant virtchnl request/completion
synchronously with the netdev lock held, rather than dropping the lock
here?

>  	/* If ret < 0 then it means wait was interrupted.
>  	 * If ret == 0 then it means we got a timeout.
>  	 * else it means we got response for set MAC from PF,
> -- 
> 2.53.0
> 

