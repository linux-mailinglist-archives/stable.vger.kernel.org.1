Return-Path: <stable+bounces-238603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGzuDHTF42l1KgEAu9opvQ
	(envelope-from <stable+bounces-238603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:55:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4717421E11
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A57DE301FA87
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 17:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B43358AF;
	Sat, 18 Apr 2026 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byRpm4Lh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CB23203B6;
	Sat, 18 Apr 2026 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776534894; cv=none; b=Ok5lnDW8x1e3WedSlkFSA6WpTDZ1XQ0EghQaJyJL0ZH6eAe8LwCo5/5DSWMDPyk1cj8exzrrF1jRVeo5Z70CaCfKGFBoDJZ4sHm3mEDxqpmkgKqF0CPF4EGD8uHzW5Alg5ZxF2oPy6frDFgk4RjJr07cUQV3pZHkirFgdCCZ4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776534894; c=relaxed/simple;
	bh=JdtPqroOunoZJu87mhf+doIJHBz2KVjK3UTYJVQ+Dx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4uupu0zNL59frx3kuJPIphQJ2F9EAJg3yH8SHpQHBk5PMzjFTDMbN7ZzGVpoafjmZwavpgcZ9giX0WIveA3pLPHi59gQ5FP63D4hOTC2lOcD3n/X7443T86V9WjF3VjqV2T2/SHUV6DObYWdJZYJSmds04qH5IEDx9oZADupYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byRpm4Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C4EC19424;
	Sat, 18 Apr 2026 17:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776534893;
	bh=JdtPqroOunoZJu87mhf+doIJHBz2KVjK3UTYJVQ+Dx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byRpm4LhvpTnr4z1ujO4rvTYg14RRwjOPCtVBK2ePT6tNfd2XetfFVMOqVNpdyo3k
	 85Zn4Rn/GxNywlyeYkZ23LgYxOnemg8Ao32+2+/WiLNgRg9tIE+RFepAjTsVo1u4e8
	 MkG9hxLzN8eRSS2exa1EdrQRHMw3N7AbY58HSoFLy6vl4JfuGVQkJTNzr6a2PkFrpz
	 IaznN6CWkWej/KhEjU4SemcsL476+UpkhGzJYPFDeVtmjUXMZP8TzZvVCNy+1kQ6tP
	 nYCa07ePIXyNIAKvnIRGV7PLkZTf+Js9zFnFU11IBmLN7T8SpKmR1RQACLrAXhShnt
	 OPxq38yEmLbXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mmc@linux.ibm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bjking1@linux.ibm.com,
	haren@linux.ibm.com,
	ricklind@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	stable@vger.kernel.org,
	shaik.abdulla1@ibm.com,
	naveedaus@in.ibm.com
Subject: Re: [PATCH net v2] ibmveth: Disable GSO for packets with small MSS
Date: Sat, 18 Apr 2026 10:54:51 -0700
Message-ID: <20260418175451.122193-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417172910.81433-1-mmc@linux.ibm.com>
References: <20260417172910.81433-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238603-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4717421E11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ibmveth: Disable GSO for packets with small MSS

This commit adds an ndo_features_check callback to the ibmveth driver to
disable segmentation offload when the MSS is less than 224 bytes. This
prevents physical adapters in SEA configurations from freezing when given
small MSS packets.

> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c

[ ... ]

> @@ -1756,6 +1756,25 @@ static int ibmveth_set_mac_addr(struct net_device *dev, void *p)
>  	return 0;
>  }
>  
> +static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
> +						struct net_device *dev,
> +						netdev_features_t features)
> +{
> +	/* Some physical adapters do not support segmentation offload with
> +	 * MSS < 224. Disable GSO for such packets to avoid adapter freeze.
> +	 */
> +	if (skb_is_gso(skb)) {

The commit message mentions this matches the ibmvnic hardware errata from
commit f10b09ef687f. That commit disabled GSO for both gso_size < 224 and
gso_segs == 1.

By omitting the check for skb_shinfo(skb)->gso_segs == 1, could a
single-segment GSO packet still cause the adapter to freeze?

> +		if (skb_shinfo(skb)->gso_size < IBMVETH_MIN_LSO_MSS) {
> +			netdev_warn_once(dev,
> +					 "MSS %u too small for LSO, disabling GSO\n",
> +					 skb_shinfo(skb)->gso_size);
> +			features &= ~NETIF_F_GSO_MASK;
> +		}
> +	}
> +
> +	return features;

When implementing a custom ndo_features_check callback, netif_skb_features()
will bypass the standard dflt_features_check() function. Does this mean
vlan_features_check() is no longer called for this driver?

If vlan_features_check() is skipped, multi-tagged (QinQ) VLAN packets
might retain GSO and protocol-specific checksum offloads that the hardware
parser cannot handle.

Should this return vlan_features_check(skb, features) instead?

> +}
-- 
pw-bot: cr

