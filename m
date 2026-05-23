Return-Path: <stable+bounces-253863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AERTE5vyEGq2fwYAu9opvQ
	(envelope-from <stable+bounces-253863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 02:19:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E06925BBCC3
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 02:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC4F1303640C
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 00:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3621A5B90;
	Sat, 23 May 2026 00:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A58oLGn4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C473175A8B;
	Sat, 23 May 2026 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495384; cv=none; b=LKlUNMV8OjGyNNNgSHYacb/3JAWTD2YDwJQ0GA//xjVnKjYUVuQFJC/wpy9Ut7CfFWffiDDLpqycJ2zOChBD3IG7M1BnszXZMNc4N3CVC3qYAJx+UI5YQ3voJSpI5lV0rLp/Cncs7PqT9ZZTHKoqbVqhDegtlQ4r8hg+XfJUPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495384; c=relaxed/simple;
	bh=1tERu9VlmALWIQ2FM0VAjLCfgiVWlPXJPwZJG/AjHkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GB6wHBLse/KAzTGucYtZRLxTVFCRHmx08YnzNYGJ+DAkgnf34mUqmq5R2Ea/wMyvonicG/QI6xdHVNXH2/QK8O2T1XPCzIsdmZmCehtGfBj+sDuQ6OB/AH7gAb+X3k41kaDMnWgN8xUfDC9y6ZS8kCMEvaDDXBxiOa782Jlkv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A58oLGn4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1741F00A3D;
	Sat, 23 May 2026 00:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495382;
	bh=/agO+vhmTs8bzNDqmBYtjsDNNh5+aDOL+28p1MBtxEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A58oLGn42131EY6ETFP/43XQ8+idexyD5WNBU5ieJPQKYNBowIC36g95wdY8otXxT
	 FHRdsB+nnA98RGnqkStJlCBOYd0y3WfJjSmfWMkymWEi+B9CRU3o7KmomF3u7ZJp9A
	 +ITezwWA93EdZuvkQuZ4TMgayezCbHo9Jj+ZrwU86/O2JjjRouS6QRlboRWl2GnKJU
	 pMXeQOjZcj8xreIieLUHZmOu2OmRoYVeF3oOobyGqF/c/IiW9cZm5tmpj8W3yLaLeo
	 fj3TXGzphzM4A8GlT6qH2AQn+P9x/UZjF9Ga2oG2jVPxgEFtHssJJNwYVx3HHyPMQf
	 VGAc5CXEfk2TQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	vinschen@redhat.com,
	alexander.nowlin@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 5/8] iavf: send MAC change request synchronously
Date: Fri, 22 May 2026 17:16:20 -0700
Message-ID: <20260523001620.1757312-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520183501.3360810-6-anthony.l.nguyen@intel.com>
References: <20260520183501.3360810-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253863-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E06925BBCC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
iavf: send MAC change request synchronously

This commit implements a synchronous MAC address change operation that sends
the ADD_ETH_ADDR message directly and polls for the response. This avoids
deadlocks involving the netdev lock, watchdog task, and adminq task.

cc: stable@vger.kernel.org

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 78c59a58e0b2b..ed790dc3de6b7 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
[ ... ]
> @@ -1029,6 +1029,48 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
[ ... ]
> +static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
> +{
> +	int ret;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	ret = iavf_add_ether_addrs(adapter);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Will this reliably fail with -EBUSY if a background operation (such as
VIRTCHNL_OP_GET_STATS sent by the watchdog) is already in flight?

If adapter->current_op != VIRTCHNL_OP_UNKNOWN, iavf_add_ether_addrs()
instantly returns -EBUSY. Because iavf_set_mac() holds the netdev_lock,
the adminq_task cannot run to process the pending response and clear
current_op, resulting in a spurious failure rather than waiting for the
background operation to complete.

> +
> +	return iavf_poll_virtchnl_response(adapter, iavf_mac_change_done,
> +					   addr, 2500);
> +}
[ ... ]
> @@ -1049,25 +1091,21 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  		return -EADDRNOTAVAIL;
>  
>  	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
> -
>  	if (ret)
>  		return ret;
>  
> -	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
> -					       iavf_is_mac_set_handled(netdev, addr->sa_data),
> -					       msecs_to_jiffies(2500));
> -
> -	/* If ret < 0 then it means wait was interrupted.
> -	 * If ret == 0 then it means we got a timeout.
> -	 * else it means we got response for set MAC from PF,
> -	 * check if netdev MAC was updated to requested MAC,
> -	 * if yes then set MAC succeeded otherwise it failed return -EACCES
> -	 */
> -	if (ret < 0)
> +	ret = iavf_set_mac_sync(adapter, addr->sa_data);
> +	if (ret) {
> +		/* Rollback for local failures (timeout, send error, -EBUSY).
> +		 * Note: If PF rejects the request (sends error response),
> +		 * iavf_virtchnl_completion() automatically calls
> +		 * iavf_mac_add_reject(), ret=0, and this is not executed.
> +		 * Only local failures (no PF response received) need manual rollback.
> +		 */
> +		iavf_mac_add_reject(adapter);
> +		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
>  		return ret;
> -
> -	if (!ret)
> -		return -EAGAIN;

[Severity: High]
Does rolling back on local failure here cause a permanent state mismatch
between the PF and VF?

If the MAC change request was already sent to the PF by
iavf_add_ether_addrs(), but iavf_poll_virtchnl_response() subsequently
fails (e.g., memory allocation failure for event.msg_buf, or a timeout
occurs), this local rollback deletes the new MAC filter and restores the
old MAC.

However, the PF might still asynchronously process the request and
configure the new MAC. Later, the VF's watchdog will send a pending
deletion for the old MAC, leaving the PF configured with the new MAC
while the VF uses the old MAC, causing a complete loss of network
connectivity.

Should the buffer allocation in iavf_poll_virtchnl_response() be done
before sending the request to the PF, and can timeouts be handled without
rolling back in-flight requests?

