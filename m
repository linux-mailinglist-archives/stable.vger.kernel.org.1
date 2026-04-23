Return-Path: <stable+bounces-240489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG/eDKcf6mntuQIAu9opvQ
	(envelope-from <stable+bounces-240489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:33:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B51452FF9
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F60230A4327
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450543F074C;
	Thu, 23 Apr 2026 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ8PqxLx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvpbjnVb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9503E6DCC
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776950745; cv=none; b=RN8WyFGRG6sz5UI/D7dTuJZBDqA3lXWY79FExtgKR8FlhPGu814dUys+2RvEmuFkhiGCJBv6NuyPMlT79h23rKdgooKQdq7NWp1VfrjjGutCFZjPixt2Ai2hJWwninTJUIIhwXu4UCC1bAtcGQhaB0cqNpYtBU9W/RnTPn4bspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776950745; c=relaxed/simple;
	bh=iOXfUH/WKbSJ54eCml+PUDIc87lDn2jGS2P0fNvnefg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IbwPMAINGpumyacAB9oPWRef8zA/CKWAdk1uN+m8txG7XrvTS6x3jnNVwKRIZeGqLEfgm5VdN/2AiTJ17dQ4l0xJ0FuU+jkJkpsgiCWMbP4iIdiQELnuhbL6Dxc2hpn61avpVgrh7mWO1ia6sLl6vVUBW9ajtITiJZMRBc2VgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJ8PqxLx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvpbjnVb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776950742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/awxEPfobPlUi3oYvFkWwqE7rb6OhetiFwQnKox8Xc=;
	b=IJ8PqxLxzSe5tG3W5A/6HTe96crAnvz4qJxhbK5Dqe6atfqX0XyzYpxrDzDx7d4KVDaZDF
	Fwd1U2YTkjbk/pg0dC2TAyM13gzeCiEB9sQ4uLOKDpXGcCADre1bSb8HissPm7LZdqviyw
	7MT2HkwBDua+4nT1XEI+WdHb8pGApEM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-q4Ts6SyoOECNXGTHl1wuzg-1; Thu, 23 Apr 2026 09:25:41 -0400
X-MC-Unique: q4Ts6SyoOECNXGTHl1wuzg-1
X-Mimecast-MFC-AGG-ID: q4Ts6SyoOECNXGTHl1wuzg_1776950741
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7973e22399so2674729a12.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776950740; x=1777555540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/awxEPfobPlUi3oYvFkWwqE7rb6OhetiFwQnKox8Xc=;
        b=gvpbjnVbDSJTeroOANZHyALRrLwU0Kd6h/EnfAXiuDgOaloYciuVhAqLeozdaQWPt+
         o0HRYMI82zgbKgA984k3qwsxSXJzO18cRSpGUiC89iw8hDzSsbJduDR7xNBXaIjoy9Xc
         tP8wqvaUsiMGxJ8K4H2J3cZdQrO+ws6BeuqsL/k1jZb8F298VpEHJ5aZtpBF+k6Tg/nQ
         kX2RaK2P1xWfsSh0m8fR1jSV+y9FgpN+EouIYD8okCymF4kVO6hgp08vxXMqc9U4clEX
         dAaoHd7HICw2Eim8eDaXQ4IWVm9TxgdeoBjXygaiyAavHNOIFBg4bTyRDQZn5XWit5Jw
         Q6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776950740; x=1777555540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/awxEPfobPlUi3oYvFkWwqE7rb6OhetiFwQnKox8Xc=;
        b=Ho9Mm6Uw1/Izep8aLvJ6lnegOcrmA/uygMgBb9TXAUq+83sq5dqEgC3dqV35SodTzx
         CtJTbqBg9I/SSfSvURZjWZ65Wrd4UZQ1MYTBq9901OXvInyEEmNo0UidzqIyDR3WC2r9
         Kw4ASUFJC94Ym6lNdKVN6Y82sJlhwPsTUpKpNU2JkI7Zb264J9mYxP9TxXO8sZzwsmoJ
         VmUchxMBX/vW+ADNmZfmM3TLE0jLHIWmx3Pad5NbqdWTkegeScdP2x3clEpHBEy9XzuG
         xbZyBpkW87p1AlUkW3mP4sBNkskxNCzTPYCyC6qv17IZGrS7V4SG/PD0aEBafCinIevD
         Fqew==
X-Forwarded-Encrypted: i=1; AFNElJ9u4H3d26fb0GCYYT1Lc/n7nyShvgIfCmsr/p0pHkNsv7vMGluEuoUCJ97IdzQvwVfBVeSUQUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7axFx00QlGniTfIVuvBRsXmv4KYW/SSHEX5Z9mh0/Y4SiNCX
	gFzh0fliK2vn/jkgW4QOmiZwUmIBAIZYoQ7Bws8GPJ5f0K/E/etT/QpfNZJZcJWfqeDd3S12j4h
	7ly8z6TnQromoPfxqEgeWE5HftkEKSa0Z22If4a5ECkFzbuGB5ecBaVhPPg==
X-Gm-Gg: AeBDiev6hrik2tjEr2pb6Mz3/mDlr+cJwjo0JctPkVjnoumUL/d+aaf6Pz6P8rSKu1E
	jZ1toC631y/tav83C82zilj43ruolRcl7pu+wMbZy8GIkD08PdgBRnnZZwHB5a7jqr4NPhqDX09
	n3cMniHMbbWQ6/QGO+CHu0mYIq9X9L5ubh1Qla8rzl0DCF4ulrwZx9AJcJVuX0Ni3H9JgA2bUPJ
	0EbjIaEbbezL1siNj6m6YKgFe0dULEsulHHr9vuSxPm2kl1HWjRPCtTjwkQyKqTa2pjAURU+Y++
	EnrqMinV3tX32tAK8111QPbq0mAzL81wnkgWrEsBv4z8pSfh7N5Of3fJcVzDwZAnCpjRDEfsCus
	LWQkNLJjU3MAIm6vXAcKgAf4TF1hBF4OWE+GY1qiJE+PytsUCuWbcAEdNQtlCqbmPRWQ=
X-Received: by 2002:a05:6a21:9992:b0:398:7769:f869 with SMTP id adf61e73a8af0-3a08d73bff1mr29058686637.20.1776950740236;
        Thu, 23 Apr 2026 06:25:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:9992:b0:398:7769:f869 with SMTP id adf61e73a8af0-3a08d73bff1mr29058632637.20.1776950739551;
        Thu, 23 Apr 2026 06:25:39 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7991ca66dasm8652747a12.26.2026.04.23.06.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 06:25:39 -0700 (PDT)
Message-ID: <d0981984-b55f-495e-848b-6e9611f0c2ff@redhat.com>
Date: Thu, 23 Apr 2026 15:25:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] gve: Make ethtool config changes synchronous
To: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, willemb@google.com,
 maolson@google.com, nktgrg@google.com, jfraker@google.com,
 ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com,
 shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pin-yen Lin <treapking@google.com>
References: <20260420171837.455487-1-hramamurthy@google.com>
 <20260420171837.455487-5-hramamurthy@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260420171837.455487-5-hramamurthy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240489-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6B51452FF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 7:18 PM, Harshitha Ramamurthy wrote:
> From: Pin-yen Lin <treapking@google.com>
> 
> When modifying device features via ethtool, the driver queues the
> carrier status update to its workqueue (gve_wq). This leads to a
> short link-down state after running the ethtool command.
> 
> Use `gve_turnup_and_check_status()` instead of `gve_turnup()` in
> `gve_queues_start()` to update the carrier status before returning to
> the userspace.
> 
> This was discovered by drivers/net/ping.py selftest. The test calls
> ping command right after an ethtool configuration, but the interface
> could be down without this fix.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5f08cd3d6423 ("gve: Alloc before freeing when adjusting queues")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Pin-yen Lin <treapking@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 56 +++++++++++-----------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 8617782791e0..d3b4bec38de5 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1374,6 +1374,33 @@ static void gve_queues_mem_remove(struct gve_priv *priv)
>  	priv->rx = NULL;
>  }
>  
> +static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
> +{
> +	if (!gve_get_napi_enabled(priv))
> +		return;
> +
> +	if (link_status == netif_carrier_ok(priv->dev))
> +		return;
> +
> +	if (link_status) {
> +		netdev_info(priv->dev, "Device link is up.\n");
> +		netif_carrier_on(priv->dev);
> +	} else {
> +		netdev_info(priv->dev, "Device link is down.\n");
> +		netif_carrier_off(priv->dev);
> +	}
> +}
> +
> +static void gve_turnup_and_check_status(struct gve_priv *priv)
> +{
> +	u32 status;
> +
> +	gve_turnup(priv);
> +	status = ioread32be(&priv->reg_bar0->device_status);
> +	gve_handle_link_status(priv,
> +			       GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
> +}
> +
>  /* The passed-in queue memory is stored into priv and the queues are made live.
>   * No memory is allocated. Passed-in memory is freed on errors.
>   */
> @@ -1434,8 +1461,7 @@ static int gve_queues_start(struct gve_priv *priv,
>  			  round_jiffies(jiffies +
>  				msecs_to_jiffies(priv->stats_report_timer_period)));
>  
> -	gve_turnup(priv);
> -	queue_work(priv->gve_wq, &priv->service_task);
> +	gve_turnup_and_check_status(priv);

Sashiko says:

Since gve_handle_link_status() can now be called from process context
via gve_turnup_and_check_status(), while also being concurrently
executed by gve_service_task() on the workqueue, could this create a
time-of-check to time-of-use race?
If the physical link toggles rapidly, could the workqueue thread sample
the later hardware state (e.g. OFF) but see the software state is
already OFF and return early, while the process context thread sampled
the earlier state (e.g. ON), evaluated netif_carrier_ok() as OFF, and
proceeded to call netif_carrier_on()?
This might leave the software carrier state stuck ON when the most
recent hardware state is OFF, because the condition check and update are
no longer serialized by the workqueue.

Notes that there more comments:

https://sashiko.dev/#/patchset/20260420171837.455487-1-hramamurthy%40google.com

but I'm not sure if they are actual regressions introduced by this series.

/P


