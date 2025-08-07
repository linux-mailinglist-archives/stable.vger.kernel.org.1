Return-Path: <stable+bounces-166796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A72B1DC7F
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528AA188EEB1
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424AE26FA5A;
	Thu,  7 Aug 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="vscGUz0f"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AA13E02D;
	Thu,  7 Aug 2025 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754588085; cv=none; b=Yeu8aFeqpwsgANSkrqft/bMve5VTAnQ6FdWv/mVU5HNH9z+Zgs/+h6xaBktflU2hClZ0p0EeZIoROJTzFquZKO3HzTdAQPwXibRmoiiASbc8PNL32ojdw2hc5t73e/11zJZmnzehwo6KO5HZayNM3ToP2vD6XV7SwSfME65ehqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754588085; c=relaxed/simple;
	bh=6epUHXcYv/940Q0vIxgQ2cWiaFPfKp+8f2qcNvwt9rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WD4G6g4WwLUKAUSCVXs3N8y7o0QASl7K8YirbNPBD2w+fa0uv+StcAMJrqYNfbcrpz7rb2dhP5CGyaxklWdzi7zQ5pu3kygVTgiALbTtybxL/yUV6QCC9zWSVHjgQg1s4vvDptu8VjvtU3ATKJnaD4jDT/mISnDsCLrEw4/Rd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=vscGUz0f; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4byZ6M0clfz9tNn;
	Thu,  7 Aug 2025 19:34:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1754588075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X0AxMiYSslfY53pvQ5xo83bBpEOaCSq5tJhi1hzwCyc=;
	b=vscGUz0fAnqXp0g/sNSd5D1Tu9Dw7R35TNP0cCCKGKC7VLDOcfrDVogqzNTLeufoCPaqAk
	B69nGIsd2d3Ca0zJRK678b91qoXyTJVBpGTzpIIaNCNnl1ZNee/G1son6KKaTpfeUR0VyJ
	x+LMUyaq4YZrvZv+IrxmK/EdDu20WtZQBCGO+tkxjCRiArkUT10cyGXdfJoYn+OYzj+1hS
	RdLPqwgMlNnw/na5r9JbzCuhsMHPcSNXV4uneVphNeZi1DWjOR1qnVOHTJau+d9vzewLWi
	2HDoRoVjJFOmAKG3Z+E/tk517rCIVm/Wb0/kHI+wj40miqj/Dj7mqc5NtJdXsw==
Message-ID: <779ce04d-2053-4196-b989-f801720e65bc@hauke-m.de>
Date: Thu, 7 Aug 2025 19:34:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Kernel warning on 5.15.187+ caused: net/sched: Always pass
 notifications when child class becomes empty
To: Jamal Hadi Salim <jhs@mojatatu.com>, Lion Ackermann <nnamrec@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <97c607e9-516d-49b2-b7a5-4a2b7903c0b8@hauke-m.de>
 <8a39dece-bf6d-4012-b214-1a4371c422b7@gmail.com>
 <CAM0EoM=fw=gx3UD4Z5WE7G-D3oj7T5SUDmN1jBZHrtCw8N2aaw@mail.gmail.com>
Content-Language: en-US
From: Hauke Mehrtens <hauke@hauke-m.de>
In-Reply-To: <CAM0EoM=fw=gx3UD4Z5WE7G-D3oj7T5SUDmN1jBZHrtCw8N2aaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/6/25 14:48, Jamal Hadi Salim wrote:
> On Wed, Aug 6, 2025 at 2:35 AM Lion Ackermann <nnamrec@gmail.com> wrote:
>>
>> Hi,
>>
>> On 8/5/25 10:28 PM, Hauke Mehrtens wrote:
>>> Hi,
>>>
>>> We see a kernel warning with kernel 5.15.187 and later in OpenWrt 23.05.
>>>
>>> When I revert this patch it is gone:
>>> commit e269f29e9395527bc00c213c6b15da04ebb35070
>>> Author: Lion Ackermann <nnamrec@gmail.com>
>>> Date:   Mon Jun 30 15:27:30 2025 +0200
>>>      net/sched: Always pass notifications when child class becomes empty
>>>      [ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]
>>>
>>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.189&id=e269f29e9395527bc00c213c6b15da04ebb35070
>>>
>>> Hauke
>>>
>>>
>>> Warning:
>>> [   90.429594] ------------[ cut here ]------------
>>> [   90.429929] WARNING: CPU: 0 PID: 3667 at net/sched/sch_htb.c:609 0xffff800000d1b5dc
>>> [   90.430561] Modules linked in: pppoe ppp_async nft_fib_inet nf_flow_table_ipv6 nf_flow_table_ipv4 nf_flow_table_inet pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject nft_redir nft_quota nft_objref nft_numgen nft_nat nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_counter nft_compat nft_chain_nat nf_tables nf_nat nf_flow_table nf_conntrack iptable_mangle iptable_filter ipt_REJECT ipt_ECN ip_tables xt_time xt_tcpudp xt_tcpmss xt_statistic xt_multiport xt_mark xt_mac xt_limit xt_length xt_hl xt_ecn xt_dscp xt_comment xt_TCPMSS xt_LOG xt_HL xt_DSCP xt_CLASSIFY x_tables smsc slhc sfp sch_cake ravb nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mdio_i2c mdio_gpio mdio_bitbang libcrc32c e1000e atlantic sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_route cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_gact gpio_pca953x i2c_mux_pca954x
>>> i2c_mux i2c_dev
>>> [   90.431030]  sp805_wdt dwmac_sun8i dwmac_rk dwmac_imx nicvf nicpf thunder_bgx thunder_xcv dwmac_generic stmmac_platform stmmac rvu_nicvf rvu_nicpf rvu_af rvu_mbox mvpp2 mvneta vmxnet3 fec fsl_enetc fsl_enetc_mdio fsl_enetc_ierb fsl_dpaa2_eth ifb mdio_thunder mdio_cavium mdio_bcm_unimac xgmac_mdio pcs_lynx fsl_mc_dpio genet nls_utf8 nls_iso8859_1 nls_cp437 pcs_xpcs marvell10g marvell macsec sha512_generic seqiv jitterentropy_rng drbg hmac rtc_rx8025 vfat fat ptp realtek broadcom bcm_phy_lib aquantia hwmon crc_ccitt pps_core phylink mii
>>> [   90.435728] CPU: 0 PID: 3667 Comm: tc Not tainted 5.15.189 #0
>>> [   90.436003] Hardware name: linux,dummy-virt (DT)
>>> [   90.436306] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> [   90.436578] pc : 0xffff800000d1b5dc
>>> [   90.436736] lr : qdisc_tree_reduce_backlog+0xa0/0x120
>>> [   90.436930] sp : ffff80000b73b6d0
>>> [   90.437053] x29: ffff80000b73b6d0 x28: ffff000003d81030 x27: ffff0000033bf800
>>> [   90.437335] x26: ffff0000033bf800 x25: ffff80000b73b8e0 x24: ffff000003677400
>>> [   90.437576] x23: ffff800000d1f5e0 x22: 0000000000000000 x21: 0000000000000000
>>> [   90.437816] x20: 0000000000000000 x19: ffff0000034f6800 x18: 0000000000000000
>>> [   90.438054] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffc7ffd278
>>> [   90.438299] x14: 000122a60001216d x13: 0001204400011f1c x12: 00011df300011cca
>>> [   90.438548] x11: 00011b9100011a68 x10: 0001194000011817 x9 : 0000000000000000
>>> [   90.438794] x8 : ffff000003677e00 x7 : 0000000000000000 x6 : 0000000000000000
>>> [   90.439037] x5 : ffff0000029df000 x4 : 0000000000000003 x3 : ffff000003684000
>>> [   90.439277] x2 : ffff800000d1b5a0 x1 : 0000000000000000 x0 : ffff000003c64140
>>> [   90.439629] Call trace:
>>> [   90.439859]  0xffff800000d1b5dc
>>> [   90.440021]  qdisc_tree_reduce_backlog+0xa0/0x120
>>> [   90.440184]  0xffff800000d1dd8c
>>> [   90.440302]  tc_ctl_tclass+0x15c/0x460
>>> [   90.440440]  rtnetlink_rcv_msg+0x1b8/0x320
>>> [   90.440583]  netlink_rcv_skb+0x5c/0x130
>>> [   90.440715]  rtnetlink_rcv+0x18/0x2c
>>> [   90.440841]  netlink_unicast+0x214/0x310
>>> [   90.440975]  netlink_sendmsg+0x1a0/0x3dc
>>> [   90.441120]  ____sys_sendmsg+0x1b8/0x220
>>> [   90.441257]  ___sys_sendmsg+0x84/0xf0
>>> [   90.441385]  __sys_sendmsg+0x48/0xb0
>>> [   90.441509]  __arm64_sys_sendmsg+0x24/0x30
>>> [   90.441647]  invoke_syscall.constprop.0+0x5c/0x110
>>> [   90.441811]  do_el0_svc+0x6c/0x150
>>> [   90.441929]  el0_svc+0x28/0xc0
>>> [   90.442039]  el0t_64_sync_handler+0xe8/0x114
>>> [   90.442186]  el0t_64_sync+0x1a4/0x1a8
>>> [   90.442408] ---[ end trace b27ff72c6be40920 ]---
>>>
>>
>> It looks like some of the "make class ops idempotent" patches are
>> missing on this stable tree (the patch depends on them)?
>>
>>      sch_htb: make htb_deactivate() idempotent
>>      sch_qfq: make qfq_qlen_notify() idempotent
>>      sch_hfsc: make hfsc_qlen_notify() idempotent
>>      sch_drr: make drr_qlen_notify() idempotent
> 
> I think you are right - I believe the following patches somehow are
> missing in 5.15.187:
> https://lore.kernel.org/netdev/20250707210801.372995-1-victor@mojatatu.com/
> https://lore.kernel.org/netdev/20250403211033.166059-1-xiyou.wangcong@gmail.com/
> 
> 5.15.189 seems to have Victor's patch but for some reason only one of
> several in Cong's patches was ever merged in stable, basically:
> https://lore.kernel.org/netdev/20250403211033.166059-6-xiyou.wangcong@gmail.com/
> 
> cheers,
> jamal

Hi,

Thanks for the help.

I cherry picked these patches on top of 5.15.189 and then I do not see 
the warning any more:
https://git.kernel.org/linus/5ba8b837b522d7051ef81bacf3d95383ff8edce5
https://git.kernel.org/linus/df008598b3a00be02a8051fde89ca0fbc416bd55
https://git.kernel.org/linus/51eb3b65544c9efd6a1026889ee5fb5aa62da3bb
https://git.kernel.org/linus/55f9eca4bfe30a15d8656f915922e8c98b7f0728

I will ask Greg to add them to stable 5.15 too.

Hauke

