Return-Path: <stable+bounces-217872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NF6KQ5VnWk2OgQAu9opvQ
	(envelope-from <stable+bounces-217872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:36:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A41831B2
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 08:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1C9B31203AF
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 07:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4418364E90;
	Tue, 24 Feb 2026 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7ER1Y2k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C8349B15
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918441; cv=none; b=NDbifkSFq8K/RXeVmAIUgiU9e8DhDNA3nUmMqexKihU0XGOu5FfIg4opMd45Ye39T44K6aS6opHLiiveWvtMB5WyZVhkaPdshXsOUX0R5WmP+COlwsJ+z+i/in0tfPv0cqsvweyY7uIKXkYN20xD+nwu9AnNNOPSzlccFU4xkQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918441; c=relaxed/simple;
	bh=pSbPEmIMY+2pRtvOV6TAkJb2+K52O5PHlhbKRZdqGVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2f+QpbpM82flwBYdyV98aMBi0HoY32Uler8TKOewIEYDXoWh2+CpSzvLeTWm6SAljYOYzvN4N9YLVH37uATZg46qBmCMuGX7xvDL9wYQ4CnA+dOz2XsBLBwKt6N0sr1LXBNzb1HwjzBqymTEi8sM/MgJcoUYGFdWKwXy0d8lYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7ER1Y2k; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43638a33157so4804612f8f.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 23:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771918437; x=1772523237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSGD0+cknqp5fLNAqiZuYxrSk7G1iqyXqllEHurRYm8=;
        b=j7ER1Y2kUxTGtTXhXcROCOROmnP2VNAqqITwAqnV5ToyltUwOI+HJSmQ/eE/NBbrO/
         GKJkFwSntSbQsAuuadbabgSrHaSjuMfZhKcDJ+mjW6gjAf29Qk4BIzF9zG636QHocPUz
         S4BM+cU61KwDosN+EPY5z0cMZJTvUVmfpsszsOA+qa62bif8aH1BENFuOG1MfM1SLvtz
         Xq4pQNw0TKdSpZijp8sFxEf7AjvH2c3PzsMUkC2+52gpph1n5UwcOiDuQ9Mu4BNp/aPM
         HcJwxfUC+pr28W4Q56soudHqfA/i7pbvqGoKfipNYcAisuG1Ak2JPHlnXaaLpSemtuyg
         POrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771918437; x=1772523237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSGD0+cknqp5fLNAqiZuYxrSk7G1iqyXqllEHurRYm8=;
        b=XBrQXSVVajg/JD/Y7yp/sqhmx0OG78ub/o9oaKIoOPX3/k7CRXN3nZ58nh80JBUuyO
         5nsFUyetQA/T4o7AS7DIhJsf9U0i5RNU3YJp94Fo1VYk9XiUmXhEHs8QVygCNe5kwp2l
         czw6Wo0dmLfJcWpOQGYvPFxCC22k0yXzRH1Zpz9rZGIJIYIjWWFj/ua6t5y81ZUfXpKc
         7kyzlmWiwQlP4vpY48f19f8PYKE89BgBnLsljEv+gHV1hd30lU5co8B607yH1KOPjfhq
         aOhmw/+vrNl7/RVkLwbgdVGoYN6He/OvVeXO86x/wcc383BwP5M4qWBNLn+cEHhCsOIs
         x9ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpf01tuzMa7Bu1ci4BI455uVRg0O2iQs7RIEL4FBvXcqh4FUh4B9GheYrnEY4QR3TiR2Yuh3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0WP1HMRcejaEiK/pKZYei4ODi/y7EWAmiqFGdyW9k4KW1ic8k
	H4cK7iBL7blvrVp4iDSnaP3VWfZ6rSLu4gdvVHdeKG4rjyj/CJ3lbDz2
X-Gm-Gg: ATEYQzz7mr3yqT8ivRGtF0N8gmK99WaCTn8LRulltTB81CLY5Mi1khnhMeisGFkYzV9
	zdU/JBd6DKE+bFIO4hm4WVZ7fX+8A5ZQrSLjJMrT61Oi5oHdukA+hr8iWVB4rugAyiQFA+62N3a
	eXzfWSHU6/o9wj5LpHn3nFNJ1V0mDikE2mo9BF3/3I5cNxzY59G7IPSL2EdLgdpLfwrJ6d83AzG
	+n1AS4F43XNXreKQ7hCdHbBbjXMBte1zY+1yYrDGy8CZ+gSHLqNtY1cfR3cXQfj9Jd3ScqiHnFe
	gFG07wYYITqU+ndZD0qvLHnzdTDGF5hSGg0qcm1lyAJJBt0XznU6UjEXf1TskzHwzrr36actjmX
	5pXdD2cdE7qQA/pqy2BSsgCoqSR/7YQrEcmUjS/8r3+Ph9pQlaT5g0s9I009SyUsC2YFKrbYzCy
	SEAp21od0aebLV04mE9QZvak47+OvrCq9PWBJ3NevHP9l88hk=
X-Received: by 2002:a05:6000:2012:b0:429:c851:69ab with SMTP id ffacd0b85a97d-4396f181b46mr21671771f8f.55.1771918436863;
        Mon, 23 Feb 2026 23:33:56 -0800 (PST)
Received: from [10.221.199.249] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54754sm24943473f8f.36.2026.02.23.23.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 23:33:56 -0800 (PST)
Message-ID: <08e815f1-5c50-4bf9-8289-71c0202ee674@gmail.com>
Date: Tue, 24 Feb 2026 09:33:57 +0200
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
 <e24b4a4f-b7e7-4e9e-ade0-cdda06f5765a@gmail.com>
 <5D5DF105-22C6-42C5-A9B9-14C0DF9685EA@spacex.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <5D5DF105-22C6-42C5-A9B9-14C0DF9685EA@spacex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217872-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[spacex.com:email,urldefense.us:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email]
X-Rspamd-Queue-Id: 100A41831B2
X-Rspamd-Action: no action



On 24/02/2026 6:32, Finn Dayton wrote:
> 
> 
> ﻿On 2/23/26, 5:46 AM, "Tariq Toukan" <ttoukan.linux@gmail.com <mailto:ttoukan.linux@gmail.com>> wrote:
> 
> 
> 
> 
> 
> 
> On 23/02/2026 2:05, Finn Dayton wrote:
>> mlx5e_xdp_xmit() selects an XDP SQ (Send Queue) using smp_processor_id()
>> (CPU ID). When doing XDP_REDIRECT from a CPU whose ID is
>>> = priv->channels.num, mlx5e_xdp_xmit() returns -ENXIO and the
>> redirect fails.
>>
>> Previous discussion proposed using modulo in mlx5e_xdp_xmit() to map
>> CPU IDs into the channel range, but modulo/division is too costly in
>> the hot path.
>>
> 
> 
> That discussion reached to an agreement of using a while loop with
> subtraction. It's expected to be fast, and optimizes the common case.
> 
> 
>> Instead, this solution precomputes per-cpu priv->xdpsq assignments when
>> channels are (re)configured and does a single lookup in mlx5e_xdp_xmit().
>>
>> Because multiple CPUs map to the same xdpsq when CPU count exceeds
>> channel count, serialize xdp_xmit on the ring with xdp_tx_lock.
>>
> 
> 
> What's the advantage of this solution over the one we already agreed to?
> 
> Subtraction in a while loop is great for the common case (cpu_id < channels.num).
> But in worst case, i.e. CPUs >> XDP SQs, the while-subtraction approach
> Is O(cpu_id / channels.num) iterations. With 256 CPUs and 8 channels, cpu_id=255 does
> 31 subtractions; with 2 channels it can be 127 iterations in the mlx5e_xdp_xmit() hot path.
> Precomputing moves the expensive operation out of the hot path into (re)configuration
> time and makes runtime lookups constant. The tradeoff is added per-cpu state that needs
> to be rebuilt whenever channels are reconfigured.
> 
> Given modern systems where CPU count can greatly exceed the number of XDP SQs, constant-
> time lookups avoid a large/variable loop in the hot path.
> 

Valid point.
The while loop solution is significantly simpler.
We can go with this one, but must make sure we take care of all needed 
syncs, for safety.

See comments on original mail.

Also, is the performance impact measurable?
Do you see the regression in your tests?

> Thank you,
> Finn
> 
>> Fixes: 58b99ee3e3eb ("net/mlx5e: Add support for XDP_REDIRECT in device-out side")
>> Link: https://urldefense.us/v3/__https://lore.kernel.org/netdev/20251031231038.1092673-1-zijianzhang@bytedance.com <mailto:20251031231038.1092673-1-zijianzhang@bytedance.com>/__;!!Fqb0NABsjhF0Kh8I!Y83cZX7QBDtN-kWQrfMsOLg2GhV5biqKsT4Dkj0Zk677rm_78pu6_4ij7TtkVuh859B_YQf8n0yDiBMAtI0Caie0lpk$
>> Link: https://urldefense.us/v3/__https://lore.kernel.org/netdev/44f69955-b566-4fb1-904d-f551046ff2d4@gmail.com <mailto:44f69955-b566-4fb1-904d-f551046ff2d4@gmail.com>__;!!Fqb0NABsjhF0Kh8I!Y83cZX7QBDtN-kWQrfMsOLg2GhV5biqKsT4Dkj0Zk677rm_78pu6_4ij7TtkVuh859B_YQf8n0yDiBMAtI0CNvBcoVA$
>> Cc: stable@vger.kernel.org <mailto:stable@vger.kernel.org> # 6.12+
>> Signed-off-by: Finn Dayton <finnius.dayton@spacex.com <mailto:finnius.dayton@spacex.com>>
>> ---
>> Testing:
>> - XDP forwarding / XDP_REDIRECT verified with both low CPU ids and
>> CPU ids > than number of send queues.
>> - No -ENXIO observed, successful forwarding.
>>
>> drivers/net/ethernet/mellanox/mlx5/core/en.h | 4 +++
>> .../net/ethernet/mellanox/mlx5/core/en/xdp.c | 16 +++++++----
>> .../net/ethernet/mellanox/mlx5/core/en_main.c | 28 +++++++++++++++++++
>> 3 files changed, 43 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> index ea2cd1f5d1d0..387954201640 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> @@ -519,6 +519,8 @@ struct mlx5e_xdpsq {
>> /* control path */
>> struct mlx5_wq_ctrl wq_ctrl;
>> struct mlx5e_channel *channel;
>> + /* serialize writes by multiple CPUs to this send queue */
>> + spinlock_t xdp_tx_lock;
>> } ____cacheline_aligned_in_smp;
>>
>> struct mlx5e_xdp_buff {
>> @@ -909,6 +911,8 @@ struct mlx5e_priv {
>> struct mlx5e_rq drop_rq;
>>
>> struct mlx5e_channels channels;
>> + /* selects the xdpsq during mlx5e_xdp_xmit() */
>> + int __percpu *send_queue_idx_ptr;
>> struct mlx5e_rx_res *rx_res;
>> u32 *tx_rates;
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>> index 80f9fc10877a..2dd44ad873a1 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>> @@ -845,7 +845,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>> struct mlx5e_priv *priv = netdev_priv(dev);
>> struct mlx5e_xdpsq *sq;
>> int nxmit = 0;
>> - int sq_num;
>> + int send_queue_idx = 0;
>> int i;
>>
>> /* this flag is sufficient, no need to test internal sq state */
>> @@ -855,13 +855,19 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>> if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>> return -EINVAL;
>>
>> - sq_num = smp_processor_id();
>>
>> - if (unlikely(sq_num >= priv->channels.num))
>> + if (unlikely(!priv->send_queue_idx_ptr))
>> return -ENXIO;
>>
>> - sq = priv->channels.c[sq_num]->xdpsq;
>> + send_queue_idx = *this_cpu_ptr(priv->send_queue_idx_ptr);
>> + if (unlikely(send_queue_idx >= priv->channels.num || send_queue_idx < 0))
>> + return -ENXIO;
>>
>> + sq = priv->channels.c[send_queue_idx]->xdpsq;
>> + /* The number of queues configured on a netdev may be smaller than the
>> + * CPU pool, so two CPUs might map to this queue. We must serialize writes.
>> + */
>> + spin_lock(&sq->xdp_tx_lock);
>> for (i = 0; i < n; i++) {
>> struct mlx5e_xmit_data_frags xdptxdf = {};
>> struct xdp_frame *xdpf = frames[i];
>> @@ -941,7 +947,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>>
>> if (flags & XDP_XMIT_FLUSH)
>> mlx5e_xmit_xdp_doorbell(sq);
>> -
>> + spin_unlock(&sq->xdp_tx_lock);
>> return nxmit;
>> }
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 7eb691c2a1bd..adef35d06b89 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -1492,6 +1492,7 @@ static int mlx5e_alloc_xdpsq(struct mlx5e_channel *c,
>> sq->pdev = c->pdev;
>> sq->mkey_be = c->mkey_be;
>> sq->channel = c;
>> + spin_lock_init(&sq->xdp_tx_lock);
>> sq->uar_map = c->bfreg->map;
>> sq->min_inline_mode = params->tx_min_inline_mode;
>> sq->hw_mtu = MLX5E_SW2HW_MTU(params, params->sw_mtu) - ETH_FCS_LEN;
>> @@ -3283,10 +3284,30 @@ static void mlx5e_build_txq_maps(struct mlx5e_priv *priv)
>> smp_wmb();
>> }
>>
>> +static void build_priv_to_xdpsq_associations(struct mlx5e_priv *priv)
>> +{
>> + /*
>> + * Build the mapping from CPU to XDP send queue index for priv.
>> + * This is used by mlx5e_xdp_xmit() to determine which xdpsq (send queue)
>> + * should handle the xdptx data, based on the CPU running mlx5e_xdp_xmit()
>> + * and the target priv (netdev).
>> + */
>> + int send_queue_idx, cpu;
>> +
>> + if (unlikely(priv->channels.num == 0))
>> + return;
>> +
>> + for_each_possible_cpu(cpu) {
>> + send_queue_idx = cpu % priv->channels.num;
>> + *per_cpu_ptr(priv->send_queue_idx_ptr, cpu) = send_queue_idx;
>> + }
>> +}
>> +
>> void mlx5e_activate_priv_channels(struct mlx5e_priv *priv)
>> {
>> mlx5e_build_txq_maps(priv);
>> mlx5e_activate_channels(priv, &priv->channels);
>> + build_priv_to_xdpsq_associations(priv);
>> mlx5e_xdp_tx_enable(priv);
>>
>> /* dev_watchdog() wants all TX queues to be started when the carrier is
>> @@ -6263,8 +6284,14 @@ int mlx5e_priv_init(struct mlx5e_priv *priv,
>> if (!priv->fec_ranges)
>> goto err_free_channel_stats;
>>
>> + priv->send_queue_idx_ptr = alloc_percpu(int);
>> + if (!priv->send_queue_idx_ptr)
>> + goto err_free_fec_ranges;
>> +
>> return 0;
>>
>> +err_free_fec_ranges:
>> + kfree(priv->fec_ranges);
>> err_free_channel_stats:
>> kfree(priv->channel_stats);
>> err_free_tx_rates:
>> @@ -6295,6 +6322,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
>> for (i = 0; i < priv->stats_nch; i++)
>> kvfree(priv->channel_stats[i]);
>> kfree(priv->channel_stats);
>> + free_percpu(priv->send_queue_idx_ptr);
>> kfree(priv->tx_rates);
>> kfree(priv->txq2sq_stats);
>> kfree(priv->txq2sq);
> 
> 
> 
> 
> 


