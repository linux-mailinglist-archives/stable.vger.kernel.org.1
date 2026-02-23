Return-Path: <stable+bounces-217773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDAXMC1anGmzEgQAu9opvQ
	(envelope-from <stable+bounces-217773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 14:46:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D904177339
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A17853007499
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77A24886A;
	Mon, 23 Feb 2026 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhezQN2L"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511924397A
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854378; cv=none; b=hAgPTiGIF6I0yYOCCGAU6Q4E5hFN+e4CgbepJWM62dynNTu2sA5qahCKC4cE7zwlzLsW7s8xwLgNKzQFzffKFRGIwNuJIgtNb0jiyLHe+z+pKEacZS9kjcy8oVtqQc++8aL3KIbmidh64+mTs4kHLtWk74w+CxxLYOZzlMTwqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854378; c=relaxed/simple;
	bh=moj3QcCqGLm4CLDFDzhqpwOR0+qc8ZVyonKyqdrXhMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDnyrxuVim9XmfioBK2+zCpe2C6c/1JyuWNPoeK/67/+KHu1OWFRZtwjJ0CU7P4S4aP7ZO2dBX4lawLp59j1Fw9IMHGGBfa/8al4Bnv32zpV0KAhcGoqJd8aJ8u6677vhz511/ur1oTdUsIw0UcrL6MY/XHqBRq4hD3G+BwoUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhezQN2L; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-4362507f0bcso3086464f8f.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854375; x=1772459175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQQ7lnppDq+V0zgDgWba+T0g0+pMzVEGyZ983+O+pHg=;
        b=PhezQN2LypfTN99J0BsO/WMhkHLSXCBM9MIncUdh37qhlM1/hN7eLdd9/4BEevLliJ
         f+k3NBQBxSYlIii0PxfJk6NTYXJNxGcs2aZMS5EGVuTeV2hef3LW84CioV2iYGxrOLlw
         nLVHeM/dkzQdtqMMbgSz+TOHnJJidbgr/9UMRHS5lEMSCO2/12I9g+TYCZcKvRI6jSw1
         Q0/zQUxjNjtP8MBl8UQigKuowZBibCxsGCPIfnXexTtCPlAtLet7yvhgH1NYwjusj1Bb
         vOv1ln8UtEbK6w7EJp/Gq1TWGjSPvAqq+I4NF7Hpv7q9mS2BQPMxx39DxDLTUCXlVCKd
         UE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854375; x=1772459175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQQ7lnppDq+V0zgDgWba+T0g0+pMzVEGyZ983+O+pHg=;
        b=EgKj43olTWYoktctEShaVRVxXMtEvaNlb/CGLLYGItk370kZEgyH/8cbu6dYYv4qET
         NNF3yzWOz8cmi/e+o0NuuxdRChnZUk6U5BtXWE70FXE0u6laVgYnrusYLjOj2QGouGYK
         x78R5XJG2TP7ysqNLYb71T90QMDVFDbd3qXd/EoBcYdTsU/+qQbGxSwT3uV6syI2FG/b
         bNsrMZZTyt+0diBYH9bJD0Z0C7bLqLd9WdvDhq65Cn4LGhkTVSMb6RKX2dsxhAsumUur
         VOV9FI//Tkj1dmnRSZYOvro6uqlop/lYh2vhHGkwuxT2qCqLldiTUc50NRPLyTEiABL0
         7GRg==
X-Forwarded-Encrypted: i=1; AJvYcCV/U51gdFGMG/ROcYRbuid1pb5OC1/FQNOMmb+oMAoFv7RE7j0K2yKh3lUseDUtOhX/DHMUOOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTiisuPDIr3s3MkLMVrA31Vk6ePdt7JAR0c3kKxB5f5plt8BJ
	nEXl9ZNSwsOcknzScAY+C4ibAbfhzEyxBI2L8oGx4FcESASSuxHGGQ98
X-Gm-Gg: ATEYQzyN71PmBpTX4uvsRm3jPn7y3hUGC86rGzBs1SFJnOaS/c9Wal4RXrQQqVlZenX
	SMu7hef514tlgDajGEAV6O5egbsvLSQvi/9d6te3uC0n1T1VEQ+snDBXG3Hz96Qz8qg863zNuXo
	m51SHWnvcLJkmniHU0irioOuhVtbzV2cztbvRaHfhOa42tA7RwpYK0Q3t8O+yTgoE8OtCYdh8jB
	TiqL973P4hWII7SZ2/sdSOn1sZUfu3J3nI6atHZ3pAlPkeQNva7lRrIfWzd3RfNiddeI8x/hI+f
	JJ5kKKfOwiJmPcNKcS05lHUEbMqgGrdjo8PxyqtvNP3aPPFqOtgRPfv1PZz9cdaWv679GYndQPc
	eRAGmrCTX/np3tIOgFtEseTUqCatHT0iTMW85p002HA0D2PXv7GJ7FGmdMqKFXEF0FZQOxZPq78
	cZjJ/fYyxZiWKLDTAi12SCngi9AodkX0LkUGGq54Ua2R8=
X-Received: by 2002:a05:6000:2282:b0:435:932e:f924 with SMTP id ffacd0b85a97d-4396fd9b8f6mr15083047f8f.2.1771854374934;
        Mon, 23 Feb 2026 05:46:14 -0800 (PST)
Received: from [10.158.36.109] ([72.25.96.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm17069302f8f.24.2026.02.23.05.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 05:46:14 -0800 (PST)
Message-ID: <e24b4a4f-b7e7-4e9e-ade0-cdda06f5765a@gmail.com>
Date: Mon, 23 Feb 2026 15:46:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Precompute xdpsq assignments for
 mlx5e_xdp_xmit()
To: Finn Dayton <Finnius.Dayton@spacex.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Alexei Starovoitov ," <ast@kernel.org>,
 "Daniel Borkmann ," <daniel@iogearbox.net>,
 "David S. Miller ," <davem@davemloft.net>, "Jakub Kicinski ,"
 <kuba@kernel.org>, "Jesper Dangaard Brouer ," <hawk@kernel.org>,
 "John Fastabend ," <john.fastabend@gmail.com>,
 "Stanislav Fomichev ," <sdf@fomichev.me>,
 "Saeed Mahameed ," <saeedm@nvidia.com>, "Leon Romanovsky ,"
 <leon@kernel.org>, "Tariq Toukan ," <tariqt@nvidia.com>,
 "Mark Bloch ," <mbloch@nvidia.com>, "Andrew Lunn ," <andrew+netdev@lunn.ch>,
 "Eric Dumazet ," <edumazet@google.com>, "Paolo Abeni ," <pabeni@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <610D8F9E-0038-46D9-AD8A-1D596236B1EF@spacex.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <610D8F9E-0038-46D9-AD8A-1D596236B1EF@spacex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217773-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D904177339
X-Rspamd-Action: no action



On 23/02/2026 2:05, Finn Dayton wrote:
> mlx5e_xdp_xmit() selects an XDP SQ (Send Queue) using smp_processor_id()
> (CPU ID). When doing XDP_REDIRECT from a CPU whose ID is
>> = priv->channels.num, mlx5e_xdp_xmit() returns -ENXIO and the
> redirect fails.
> 
> Previous discussion proposed using modulo in mlx5e_xdp_xmit() to map
> CPU IDs into the channel range, but modulo/division is too costly in
> the hot path.
> 

That discussion reached to an agreement of using a while loop with 
subtraction. It's expected to be fast, and optimizes the common case.

> Instead, this solution precomputes per-cpu priv->xdpsq assignments when
> channels are (re)configured and does a single lookup in  mlx5e_xdp_xmit().
> 
> Because multiple CPUs map to the same xdpsq when CPU count exceeds
> channel count, serialize xdp_xmit on the ring with xdp_tx_lock.
> 

What's the advantage of this solution over the one we already agreed to?

> Fixes: 58b99ee3e3eb ("net/mlx5e: Add support for XDP_REDIRECT in device-out side")
> Link: https://lore.kernel.org/netdev/20251031231038.1092673-1-zijianzhang@bytedance.com/
> Link: https://lore.kernel.org/netdev/44f69955-b566-4fb1-904d-f551046ff2d4@gmail.com
> Cc: stable@vger.kernel.org # 6.12+
> Signed-off-by: Finn Dayton <finnius.dayton@spacex.com>
> ---
> Testing:
>   - XDP forwarding / XDP_REDIRECT verified with both low CPU ids and
>     CPU ids > than number of send queues.
>   - No -ENXIO observed, successful forwarding.
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +++
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 16 +++++++----
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 28 +++++++++++++++++++
>   3 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index ea2cd1f5d1d0..387954201640 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -519,6 +519,8 @@ struct mlx5e_xdpsq {
>   	/* control path */
>   	struct mlx5_wq_ctrl        wq_ctrl;
>   	struct mlx5e_channel      *channel;
> +	/* serialize writes by multiple CPUs to this send queue */
> +	spinlock_t xdp_tx_lock;
>   } ____cacheline_aligned_in_smp;
>   
>   struct mlx5e_xdp_buff {
> @@ -909,6 +911,8 @@ struct mlx5e_priv {
>   	struct mlx5e_rq            drop_rq;
>   
>   	struct mlx5e_channels      channels;
> +	/* selects the xdpsq during mlx5e_xdp_xmit() */
> +	int __percpu              *send_queue_idx_ptr;
>   	struct mlx5e_rx_res       *rx_res;
>   	u32                       *tx_rates;
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 80f9fc10877a..2dd44ad873a1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -845,7 +845,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   	struct mlx5e_priv *priv = netdev_priv(dev);
>   	struct mlx5e_xdpsq *sq;
>   	int nxmit = 0;
> -	int sq_num;
> +	int send_queue_idx = 0;
>   	int i;
>   
>   	/* this flag is sufficient, no need to test internal sq state */
> @@ -855,13 +855,19 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>   		return -EINVAL;
>   
> -	sq_num = smp_processor_id();
>   
> -	if (unlikely(sq_num >= priv->channels.num))
> +	if (unlikely(!priv->send_queue_idx_ptr))
>   		return -ENXIO;
>   
> -	sq = priv->channels.c[sq_num]->xdpsq;
> +	send_queue_idx = *this_cpu_ptr(priv->send_queue_idx_ptr);
> +	if (unlikely(send_queue_idx >= priv->channels.num || send_queue_idx < 0))
> +		return -ENXIO;
>   
> +	sq = priv->channels.c[send_queue_idx]->xdpsq;
> +	/* The number of queues configured on a netdev may be smaller than the
> +	 * CPU pool, so two CPUs might map to this queue. We must serialize writes.
> +	 */
> +	spin_lock(&sq->xdp_tx_lock);
>   	for (i = 0; i < n; i++) {
>   		struct mlx5e_xmit_data_frags xdptxdf = {};
>   		struct xdp_frame *xdpf = frames[i];
> @@ -941,7 +947,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>   
>   	if (flags & XDP_XMIT_FLUSH)
>   		mlx5e_xmit_xdp_doorbell(sq);
> -
> +	spin_unlock(&sq->xdp_tx_lock);
>   	return nxmit;
>   }
>   
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 7eb691c2a1bd..adef35d06b89 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -1492,6 +1492,7 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
>   	sq->pdev      = c->pdev;
>   	sq->mkey_be   = c->mkey_be;
>   	sq->channel   = c;
> +	spin_lock_init(&sq->xdp_tx_lock);
>   	sq->uar_map   = c->bfreg->map;
>   	sq->min_inline_mode = params->tx_min_inline_mode;
>   	sq->hw_mtu    = MLX5E_SW2HW_MTU(params, params->sw_mtu) - ETH_FCS_LEN;
> @@ -3283,10 +3284,30 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
>   	smp_wmb();
>   }
>   
> +static void build_priv_to_xdpsq_associations(struct mlx5e_priv *priv)
> +{
> +	/*
> +	 * Build the mapping from CPU to XDP send queue index for priv.
> +	 * This is used by mlx5e_xdp_xmit() to determine which xdpsq (send queue)
> +	 * should handle the xdptx data, based on the CPU running mlx5e_xdp_xmit()
> +	 * and the target priv (netdev).
> +	 */
> +	int send_queue_idx, cpu;
> +
> +	if (unlikely(priv->channels.num == 0))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		send_queue_idx = cpu % priv->channels.num;
> +		*per_cpu_ptr(priv->send_queue_idx_ptr, cpu) = send_queue_idx;
> +	}
> +}
> +
>   void mlx5e_activate_priv_channels(struct mlx5e_priv *priv)
>   {
>   	mlx5e_build_txq_maps(priv);
>   	mlx5e_activate_channels(priv, &priv->channels);
> +	build_priv_to_xdpsq_associations(priv);
>   	mlx5e_xdp_tx_enable(priv);
>   
>   	/* dev_watchdog() wants all TX queues to be started when the carrier is
> @@ -6263,8 +6284,14 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
>   	if (!priv->fec_ranges)
>   		goto err_free_channel_stats;
>   
> +	priv->send_queue_idx_ptr = alloc_percpu(int);
> +	if (!priv->send_queue_idx_ptr)
> +		goto err_free_fec_ranges;
> +
>   	return 0;
>   
> +err_free_fec_ranges:
> +	kfree(priv->fec_ranges);
>   err_free_channel_stats:
>   	kfree(priv->channel_stats);
>   err_free_tx_rates:
> @@ -6295,6 +6322,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
>   	for (i = 0; i < priv->stats_nch; i++)
>   		kvfree(priv->channel_stats[i]);
>   	kfree(priv->channel_stats);
> +	free_percpu(priv->send_queue_idx_ptr);
>   	kfree(priv->tx_rates);
>   	kfree(priv->txq2sq_stats);
>   	kfree(priv->txq2sq);


