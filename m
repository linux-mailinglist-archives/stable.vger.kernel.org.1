Return-Path: <stable+bounces-166700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CCEB1C65F
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E2518C1935
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7228C031;
	Wed,  6 Aug 2025 12:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dLQqBQkt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACAD28A40F
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484537; cv=none; b=LKAoB0VJKsaH3jRNgVkoKMT4qcE3j9LsvV9RFTXZavMijceW2EctYSXl+7njWaPGNZbAknHCg2TsB86v3A8DAsuFN77rLf6s+uPYbiTQ2Fsz/rCLEduDUmZgr8d+ycEyEs2T6kEsRxkOoE53hGod8kwZLY5KSslFcKnViC/wIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484537; c=relaxed/simple;
	bh=VHnja3Z1b+/9xZ19E6S8S/uI9EAnkRgfWaXhJ0CUTog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9e0dWrLncTG6o/tMTFT1LTzzX4aoL/U9CA/UJ8m3VEVLvjGw6ZW7dj3NpByLjZRGOe/FNDJP9KW93di40kOLSheDePBf9dq59HeQaeoXJJHWhEvi/Ux1M2t4npuTJelFPp8hF8IeIMqJhM/7yHsaJDKl/55/kL6UH6jKD/FPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=dLQqBQkt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bd050184bso7887351b3a.2
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 05:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1754484535; x=1755089335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWAPWbFqFkbVgwaf/9ufVNYR+iFb3tbDB5R4GuWH31U=;
        b=dLQqBQkt3j2QZUvqSUxWutoKsJsqLjL0nfLkJj8A8RLeTYwmJmAbhSOdgrkiXY1tGN
         kGA3tHaWmCt5lw15SBpO6JuMBcrl5juYCBQCPpAtrnIv5McxkUkjZr30Y1nJzi9Wj1Sc
         1+v8g8xHa/hZUlOjpUWcqEhJI8Mr0V0z7mCfAlxppnmgRCSOBjYkK43Mcz4/0h9K1PX/
         IPQHON6UTbF1BCXHo7MCVCkmWA1nj4FmfeefY8uzY+BP7F36h5zLOAYxprsGH6bo3S+4
         dbU6D/eUth15zxAaDJvfjOhfYu7mSHOtLr20xq6nUWG+eU0X4xHbXmSE5xGNMT2clftE
         rTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484535; x=1755089335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWAPWbFqFkbVgwaf/9ufVNYR+iFb3tbDB5R4GuWH31U=;
        b=NLrpyA9dwqJ74vSg6lTsGPAITbJYJOB/VvdwWDf9xm2LatHa16mIOW6SnhVnbKruCI
         oVRa6HFeYoTlqWLETBfIBa0roaZ3tUcmuwSc6PIaSjBkGxS9Iwa0A/CddC9xZJHTYuRw
         OsBtLtxWZy7Co2Mns5zSNfX5uw0MsntuXrckHpMPwZvY7SvuO+QpOfpsvjno3Te23wz2
         eyNsZOfum/XMrRzYlG02pprT4GVQEYMoFZkub0j8ppvZLZ9xItVhqDPeBzyzL4JWu7uh
         28TXn/rADeqP6K2NozimuLHcUdM/BwwZ1RXAxAF4pl7EMc5J+xQ+SwYDSjvkWYHvjb2p
         NNQw==
X-Forwarded-Encrypted: i=1; AJvYcCUiVGhCYEyHMdvJGBYCEe4saCxD97Yw8Aj+K/wLepPsFUELdZehlU4mSZhvuUr3rQi/Cyd5PA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi5B5+IPDfpCFJYvjtKI7QwCRUAUVagwiLva+E5fQ8O0tZdJxb
	kj4lZOmB6r2NDIjyHO9BkIi8afmEXxCh8EDdp+aXxmzzCqxGmKDNBFDkTVvVHoie2vR+nxy0IIp
	JxmzfLNzK4oA/ZB4Zarzm6iQuFHVxeKZ9CPWvBsop
X-Gm-Gg: ASbGnctc+dXJ4OgGbgyViE6JtaJX9gnPqGMOmIhCAjPEQxsSFovQn4e02He+HsoYL8o
	H/U2H+JQKw6kjTcOKrgiMHI8PIBXsVho+9rRKtW8z1ETlcaUv2FAfdejADGB1nP29z+5qqLMb9i
	jnOwoS1v4tRufp6dwdGjCXqcCG3aSB0rztL6JLq/0rcEMfiIUHo/yP1K95Y7EcgxVjshRW5zVus
	KvZQuq79ykY7KHpVQ==
X-Google-Smtp-Source: AGHT+IFPu8URe1MShnqFdjtTGpbq1k9p1uWpS8NGc2xfDPneyVlk/lnOhUKDnQ5ksq8Oz9beVji2BDer0Sco/ah4kpw=
X-Received: by 2002:a05:6a20:3c8e:b0:23d:45b2:8e21 with SMTP id
 adf61e73a8af0-240313f5dbamr3998577637.37.1754484534613; Wed, 06 Aug 2025
 05:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <97c607e9-516d-49b2-b7a5-4a2b7903c0b8@hauke-m.de> <8a39dece-bf6d-4012-b214-1a4371c422b7@gmail.com>
In-Reply-To: <8a39dece-bf6d-4012-b214-1a4371c422b7@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 6 Aug 2025 08:48:43 -0400
X-Gm-Features: Ac12FXzqyw8H9BRLCecsnfIOnEzjm6L0gH3biSil6udrs96klaQbJCfBGrtl4NE
Message-ID: <CAM0EoM=fw=gx3UD4Z5WE7G-D3oj7T5SUDmN1jBZHrtCw8N2aaw@mail.gmail.com>
Subject: Re: Kernel warning on 5.15.187+ caused: net/sched: Always pass
 notifications when child class becomes empty
To: Lion Ackermann <nnamrec@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 2:35=E2=80=AFAM Lion Ackermann <nnamrec@gmail.com> w=
rote:
>
> Hi,
>
> On 8/5/25 10:28 PM, Hauke Mehrtens wrote:
> > Hi,
> >
> > We see a kernel warning with kernel 5.15.187 and later in OpenWrt 23.05=
.
> >
> > When I revert this patch it is gone:
> > commit e269f29e9395527bc00c213c6b15da04ebb35070
> > Author: Lion Ackermann <nnamrec@gmail.com>
> > Date:   Mon Jun 30 15:27:30 2025 +0200
> >     net/sched: Always pass notifications when child class becomes empty
> >     [ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]
> >
> > Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
commit/?h=3Dv5.15.189&id=3De269f29e9395527bc00c213c6b15da04ebb35070
> >
> > Hauke
> >
> >
> > Warning:
> > [   90.429594] ------------[ cut here ]------------
> > [   90.429929] WARNING: CPU: 0 PID: 3667 at net/sched/sch_htb.c:609 0xf=
fff800000d1b5dc
> > [   90.430561] Modules linked in: pppoe ppp_async nft_fib_inet nf_flow_=
table_ipv6 nf_flow_table_ipv4 nf_flow_table_inet pppox ppp_generic nft_reje=
ct_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_=
objref nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offl=
oad nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_counter nft_compat nft_cha=
in_nat nf_tables nf_nat nf_flow_table nf_conntrack iptable_mangle iptable_f=
ilter ipt_REJECT ipt_ECN ip_tables xt_time xt_tcpudp xt_tcpmss xt_statistic=
 xt_multiport xt_mark xt_mac xt_limit xt_length xt_hl xt_ecn xt_dscp xt_com=
ment xt_TCPMSS xt_LOG xt_HL xt_DSCP xt_CLASSIFY x_tables smsc slhc sfp sch_=
cake ravb nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_i=
pv6 nf_defrag_ipv4 mdio_i2c mdio_gpio mdio_bitbang libcrc32c e1000e atlanti=
c sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_route cls_matchal=
l cls_fw cls_flow cls_basic act_skbedit act_mirred act_gact gpio_pca953x i2=
c_mux_pca954x
> > i2c_mux i2c_dev
> > [   90.431030]  sp805_wdt dwmac_sun8i dwmac_rk dwmac_imx nicvf nicpf th=
under_bgx thunder_xcv dwmac_generic stmmac_platform stmmac rvu_nicvf rvu_ni=
cpf rvu_af rvu_mbox mvpp2 mvneta vmxnet3 fec fsl_enetc fsl_enetc_mdio fsl_e=
netc_ierb fsl_dpaa2_eth ifb mdio_thunder mdio_cavium mdio_bcm_unimac xgmac_=
mdio pcs_lynx fsl_mc_dpio genet nls_utf8 nls_iso8859_1 nls_cp437 pcs_xpcs m=
arvell10g marvell macsec sha512_generic seqiv jitterentropy_rng drbg hmac r=
tc_rx8025 vfat fat ptp realtek broadcom bcm_phy_lib aquantia hwmon crc_ccit=
t pps_core phylink mii
> > [   90.435728] CPU: 0 PID: 3667 Comm: tc Not tainted 5.15.189 #0
> > [   90.436003] Hardware name: linux,dummy-virt (DT)
> > [   90.436306] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   90.436578] pc : 0xffff800000d1b5dc
> > [   90.436736] lr : qdisc_tree_reduce_backlog+0xa0/0x120
> > [   90.436930] sp : ffff80000b73b6d0
> > [   90.437053] x29: ffff80000b73b6d0 x28: ffff000003d81030 x27: ffff000=
0033bf800
> > [   90.437335] x26: ffff0000033bf800 x25: ffff80000b73b8e0 x24: ffff000=
003677400
> > [   90.437576] x23: ffff800000d1f5e0 x22: 0000000000000000 x21: 0000000=
000000000
> > [   90.437816] x20: 0000000000000000 x19: ffff0000034f6800 x18: 0000000=
000000000
> > [   90.438054] x17: 0000000000000000 x16: 0000000000000000 x15: 0000fff=
fc7ffd278
> > [   90.438299] x14: 000122a60001216d x13: 0001204400011f1c x12: 00011df=
300011cca
> > [   90.438548] x11: 00011b9100011a68 x10: 0001194000011817 x9 : 0000000=
000000000
> > [   90.438794] x8 : ffff000003677e00 x7 : 0000000000000000 x6 : 0000000=
000000000
> > [   90.439037] x5 : ffff0000029df000 x4 : 0000000000000003 x3 : ffff000=
003684000
> > [   90.439277] x2 : ffff800000d1b5a0 x1 : 0000000000000000 x0 : ffff000=
003c64140
> > [   90.439629] Call trace:
> > [   90.439859]  0xffff800000d1b5dc
> > [   90.440021]  qdisc_tree_reduce_backlog+0xa0/0x120
> > [   90.440184]  0xffff800000d1dd8c
> > [   90.440302]  tc_ctl_tclass+0x15c/0x460
> > [   90.440440]  rtnetlink_rcv_msg+0x1b8/0x320
> > [   90.440583]  netlink_rcv_skb+0x5c/0x130
> > [   90.440715]  rtnetlink_rcv+0x18/0x2c
> > [   90.440841]  netlink_unicast+0x214/0x310
> > [   90.440975]  netlink_sendmsg+0x1a0/0x3dc
> > [   90.441120]  ____sys_sendmsg+0x1b8/0x220
> > [   90.441257]  ___sys_sendmsg+0x84/0xf0
> > [   90.441385]  __sys_sendmsg+0x48/0xb0
> > [   90.441509]  __arm64_sys_sendmsg+0x24/0x30
> > [   90.441647]  invoke_syscall.constprop.0+0x5c/0x110
> > [   90.441811]  do_el0_svc+0x6c/0x150
> > [   90.441929]  el0_svc+0x28/0xc0
> > [   90.442039]  el0t_64_sync_handler+0xe8/0x114
> > [   90.442186]  el0t_64_sync+0x1a4/0x1a8
> > [   90.442408] ---[ end trace b27ff72c6be40920 ]---
> >
>
> It looks like some of the "make class ops idempotent" patches are
> missing on this stable tree (the patch depends on them)?
>
>     sch_htb: make htb_deactivate() idempotent
>     sch_qfq: make qfq_qlen_notify() idempotent
>     sch_hfsc: make hfsc_qlen_notify() idempotent
>     sch_drr: make drr_qlen_notify() idempotent

I think you are right - I believe the following patches somehow are
missing in 5.15.187:
https://lore.kernel.org/netdev/20250707210801.372995-1-victor@mojatatu.com/
https://lore.kernel.org/netdev/20250403211033.166059-1-xiyou.wangcong@gmail=
.com/

5.15.189 seems to have Victor's patch but for some reason only one of
several in Cong's patches was ever merged in stable, basically:
https://lore.kernel.org/netdev/20250403211033.166059-6-xiyou.wangcong@gmail=
.com/

cheers,
jamal

