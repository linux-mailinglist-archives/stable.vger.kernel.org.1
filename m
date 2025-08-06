Return-Path: <stable+bounces-166682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148F0B1C07C
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 08:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CAB3BC8F2
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 06:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435520297B;
	Wed,  6 Aug 2025 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/wecURj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E957273FE;
	Wed,  6 Aug 2025 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754462159; cv=none; b=sVwbfCC1w+9aYg+g1SMCpm66xP+gaHrpERJLCXB/jWa5ZgkgUrzMiUhjzeld1S9XcITSsQpdeBBbqb7RCtnK25fg9pfrM1qnoBRsIhaORw3NEzWkhVmGww9HeIAzX/Y131OsPkf1RQxXEE1hUL208o3PSgI3qzHohRX47gtp0NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754462159; c=relaxed/simple;
	bh=lDIz63uaKcO7p8UUNaqCHl6wcJn0vDyIcbyU0GUz+xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL9ACCKzPBpNaQcvmJdKErJla6XxAueRP5wyy5oDW6G1XRsCdUnDqyBOIDR/qK6gSvz9a3vCiEroLNfrbfEn6TDbt27dK+lnwC2nMSHPP1NF0PqDNZC9tsrE2lSV7x7WvXQG1A4PlmvsYNS7pCpGC7NgkfNlqmeRwJSYnzgEj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/wecURj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4589968e001so39406805e9.0;
        Tue, 05 Aug 2025 23:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754462156; x=1755066956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8l5lHUNfqL2RL+0bFVfmAyRV1uJAwpE81eiZ+eTwJos=;
        b=h/wecURjKyMlqh8hi2HETJPrXg1KyAnEGjlPJG1iO0Au35ek6IMQa7SmgF+M/QcdOd
         Ss+6Tyi5EKVT1NKZfvCMwKA/EwobaYmG6YpcAP32lo4mNPvysoG4hgR3we6kVkUVmNUZ
         xFGW/TQfZsPPDNPPdBFtJBO0uiCFW/wK69CAwcAG3jjSBCAtcRDkt4t+A8ktF/XIkF0d
         P5l21OvWlOSeI2UuUFQ86s9J30ClWEd54Nn1n2oW+qWjAYi/LMJh3qN+1grpuismzfPe
         VldhgPsdeZZkThpOB6X/bIc+68ITvd42t8sLQOjAqc+DQC/f2Sx/2zmOA5ainLcifT9q
         na+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754462156; x=1755066956;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l5lHUNfqL2RL+0bFVfmAyRV1uJAwpE81eiZ+eTwJos=;
        b=R1pltt3YOO1zFTWXhUmM9zHtIycuHvPmLZ86rnfURwtgRYw+lvGTPUQUTw5DylRMd+
         p8LlpjO2U6biCR706PVRUisWqHj4ViRWtSDuf3O7Goqqs3lWOCLN7Tfg83fJPpw2XvC/
         Yo5IwL5etMN16UwXv5IBdCLknAAFPc+WKqVh/qJyYHoMFUXRaHSLoUDBcItogXcQqIOD
         ihmZr2q0GUos9vbvMZRk57BH2JmgRhG3T9ebDhmoYKOUjj4UOXMqex53UTYmBWd40TAM
         ubodKXhpVEqp0LAHCw3a1aYXHPtXBuo8tkVki0K38FBvD6Da4JkFO8AQxrS3oKa2lB1P
         my2A==
X-Forwarded-Encrypted: i=1; AJvYcCVHnpw9/3WiOwt4EHcxBYF6st3qmA/ecyNOGP/yGm3u8tS025NIclvKBGMmO3ZVr/caeGcVjrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4biW+ZT0q4MbLFABcJi7+725WZkEmmgRjwV/4NKd4bp7P2U7
	VOopLG9pqVx3ouC12EQI9QPV4mho+964WAp9jdEkYaHv96hDNNIYVKK9
X-Gm-Gg: ASbGncvYH91V9tuhPCpPT6NDoy7m6LbN/9PRCp5B0yg9xzm9CtZ7sqRxj/BaF62iVOV
	qv2gU1RdVC6dpxHbFA3pijnaNEc6HKO4o4hpdeEgRwpzwS9AFhEQpDhOa1dLDIbcIrCyj3sO9Dr
	bNdWZl/8Y/ydVcVYl+Jt48+8bMGIqWAiwN18suyWOCXz48O9lu4myy4a2QANpbqB6fI82PsIEHI
	dXRlDd3lv7HgirBsn+E860oIag4iTRu18V/mWpNBvX0K8tF4hXP+krVSdlIjZ2ePt+IoZhguDEL
	/7P48MTQN3ouuoDkVCwgGeGF52daEMEiBFw1zy27B9v00oKW09s7Q+w1sxVmqsETwWVXJB+dhXv
	mToRIC7ybBNy5Z/EXNpZ3HDMQSWZI4wdad0mPveft+KE3Xav6VH7xVrN3xEfN8BPBrEG1T0B7CU
	QR/aBqVYEmJzE6qChSh/PTvUAcK4bMx/YNypWHHXEE1hKZzAlu
X-Google-Smtp-Source: AGHT+IFLNhkswz5FzrpIQuwb8fhtPSze+81OYDu0gdd2nmqMUml09MFUUObwJ/GxX9CfxHJ1zV0nrA==
X-Received: by 2002:a05:600c:3b0e:b0:456:1560:7c5f with SMTP id 5b1f17b1804b1-459e709122cmr13030135e9.14.1754462155459;
        Tue, 05 Aug 2025 23:35:55 -0700 (PDT)
Received: from ?IPV6:2003:ed:7749:cf55:4244:5eb7:c63c:b96? (p200300ed7749cf5542445eb7c63c0b96.dip0.t-ipconnect.de. [2003:ed:7749:cf55:4244:5eb7:c63c:b96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5879d76sm35500525e9.24.2025.08.05.23.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 23:35:54 -0700 (PDT)
Message-ID: <8a39dece-bf6d-4012-b214-1a4371c422b7@gmail.com>
Date: Wed, 6 Aug 2025 08:35:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel warning on 5.15.187+ caused: net/sched: Always pass
 notifications when child class becomes empty
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, stable@vger.kernel.org
References: <97c607e9-516d-49b2-b7a5-4a2b7903c0b8@hauke-m.de>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
Autocrypt: addr=nnamrec@gmail.com; keydata=
 xjMEaGy42hYJKwYBBAHaRw8BAQdAJHK3N0zfW98bW+Yr3auVGhEXzUbKwQ1aYcF3kLkvpQjN
 Ikxpb24gQWNrZXJtYW5uIDxubmFtcmVjQGdtYWlsLmNvbT7CjwQTFggANxYhBIS3qJ48X2dy
 WA7N3Vs1Wq2MoV3EBQJobLjaBQkB4TOAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQWzVarYyh
 XcRtTwD9EcyesQgadqME6QtxC6nMqcUSD3VCpU9pGfly8v3hS/wA/imY06jXHw0Y100jt6Im
 j4Q2nUfZy5b8lgJTWThSCfIGzjgEaGy42hIKKwYBBAGXVQEFAQEHQC8W3e4AvNFS4XELUb/s
 Gy5DayvUBvToZ9NkcDwnym8bAwEIB8J+BBgWCAAmFiEEhLeonjxfZ3JYDs3dWzVarYyhXcQF
 AmhsuNoFCQHhM4ACGwwACgkQWzVarYyhXcQkKQD/SzIKxPGhJf8GSt5OU24yJP8t03n1na36
 mor58hKCBsYA/3y5jEuyGNI8DFKwfI9zwNJtGynaLjGA3+H1qlNFlcYN
In-Reply-To: <97c607e9-516d-49b2-b7a5-4a2b7903c0b8@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/5/25 10:28 PM, Hauke Mehrtens wrote:
> Hi,
> 
> We see a kernel warning with kernel 5.15.187 and later in OpenWrt 23.05.
> 
> When I revert this patch it is gone:
> commit e269f29e9395527bc00c213c6b15da04ebb35070
> Author: Lion Ackermann <nnamrec@gmail.com>
> Date:   Mon Jun 30 15:27:30 2025 +0200
>     net/sched: Always pass notifications when child class becomes empty
>     [ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.189&id=e269f29e9395527bc00c213c6b15da04ebb35070
> 
> Hauke
> 
> 
> Warning:
> [   90.429594] ------------[ cut here ]------------
> [   90.429929] WARNING: CPU: 0 PID: 3667 at net/sched/sch_htb.c:609 0xffff800000d1b5dc
> [   90.430561] Modules linked in: pppoe ppp_async nft_fib_inet nf_flow_table_ipv6 nf_flow_table_ipv4 nf_flow_table_inet pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_objref nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_counter nft_compat nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack iptable_mangle iptable_filter ipt_REJECT ipt_ECN ip_tables xt_time xt_tcpudp xt_tcpmss xt_statistic xt_multiport xt_mark xt_mac xt_limit xt_length xt_hl xt_ecn xt_dscp xt_comment xt_TCPMSS xt_LOG xt_HL xt_DSCP xt_CLASSIFY x_tables smsc slhc sfp sch_cake ravb nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mdio_i2c mdio_gpio mdio_bitbang libcrc32c e1000e atlantic sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_route cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_gact gpio_pca953x i2c_mux_pca954x
> i2c_mux i2c_dev
> [   90.431030]  sp805_wdt dwmac_sun8i dwmac_rk dwmac_imx nicvf nicpf thunder_bgx thunder_xcv dwmac_generic stmmac_platform stmmac rvu_nicvf rvu_nicpf rvu_af rvu_mbox mvpp2 mvneta vmxnet3 fec fsl_enetc fsl_enetc_mdio fsl_enetc_ierb fsl_dpaa2_eth ifb mdio_thunder mdio_cavium mdio_bcm_unimac xgmac_mdio pcs_lynx fsl_mc_dpio genet nls_utf8 nls_iso8859_1 nls_cp437 pcs_xpcs marvell10g marvell macsec sha512_generic seqiv jitterentropy_rng drbg hmac rtc_rx8025 vfat fat ptp realtek broadcom bcm_phy_lib aquantia hwmon crc_ccitt pps_core phylink mii
> [   90.435728] CPU: 0 PID: 3667 Comm: tc Not tainted 5.15.189 #0
> [   90.436003] Hardware name: linux,dummy-virt (DT)
> [   90.436306] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   90.436578] pc : 0xffff800000d1b5dc
> [   90.436736] lr : qdisc_tree_reduce_backlog+0xa0/0x120
> [   90.436930] sp : ffff80000b73b6d0
> [   90.437053] x29: ffff80000b73b6d0 x28: ffff000003d81030 x27: ffff0000033bf800
> [   90.437335] x26: ffff0000033bf800 x25: ffff80000b73b8e0 x24: ffff000003677400
> [   90.437576] x23: ffff800000d1f5e0 x22: 0000000000000000 x21: 0000000000000000
> [   90.437816] x20: 0000000000000000 x19: ffff0000034f6800 x18: 0000000000000000
> [   90.438054] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc7ffd278
> [   90.438299] x14: 000122a60001216d x13: 0001204400011f1c x12: 00011df300011cca
> [   90.438548] x11: 00011b9100011a68 x10: 0001194000011817 x9 : 0000000000000000
> [   90.438794] x8 : ffff000003677e00 x7 : 0000000000000000 x6 : 0000000000000000
> [   90.439037] x5 : ffff0000029df000 x4 : 0000000000000003 x3 : ffff000003684000
> [   90.439277] x2 : ffff800000d1b5a0 x1 : 0000000000000000 x0 : ffff000003c64140
> [   90.439629] Call trace:
> [   90.439859]  0xffff800000d1b5dc
> [   90.440021]  qdisc_tree_reduce_backlog+0xa0/0x120
> [   90.440184]  0xffff800000d1dd8c
> [   90.440302]  tc_ctl_tclass+0x15c/0x460
> [   90.440440]  rtnetlink_rcv_msg+0x1b8/0x320
> [   90.440583]  netlink_rcv_skb+0x5c/0x130
> [   90.440715]  rtnetlink_rcv+0x18/0x2c
> [   90.440841]  netlink_unicast+0x214/0x310
> [   90.440975]  netlink_sendmsg+0x1a0/0x3dc
> [   90.441120]  ____sys_sendmsg+0x1b8/0x220
> [   90.441257]  ___sys_sendmsg+0x84/0xf0
> [   90.441385]  __sys_sendmsg+0x48/0xb0
> [   90.441509]  __arm64_sys_sendmsg+0x24/0x30
> [   90.441647]  invoke_syscall.constprop.0+0x5c/0x110
> [   90.441811]  do_el0_svc+0x6c/0x150
> [   90.441929]  el0_svc+0x28/0xc0
> [   90.442039]  el0t_64_sync_handler+0xe8/0x114
> [   90.442186]  el0t_64_sync+0x1a4/0x1a8
> [   90.442408] ---[ end trace b27ff72c6be40920 ]---
> 

It looks like some of the "make class ops idempotent" patches are 
missing on this stable tree (the patch depends on them)?

    sch_htb: make htb_deactivate() idempotent
    sch_qfq: make qfq_qlen_notify() idempotent
    sch_hfsc: make hfsc_qlen_notify() idempotent
    sch_drr: make drr_qlen_notify() idempotent


