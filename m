Return-Path: <stable+bounces-166648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6B2B1BB68
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 22:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D5018A449E
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 20:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC44239072;
	Tue,  5 Aug 2025 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="B7zW+YuP"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE61401B;
	Tue,  5 Aug 2025 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754425714; cv=none; b=MkVwh8n2ebc5rbAsCnfwGHieqq4HG6rtzZa4NwmKRV6Dvb5TpWuu0/Kq85TUQT4hXNkjoEdJtKiwKk9F1aQiCX+db7nfRrsnHLnhcD4UZvoD/+SdoHzgeO8FhSTCVYA0Vr0OL+iIhY+lZGSbN+OA4ndazUY5prkNLCWJR2mgDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754425714; c=relaxed/simple;
	bh=qCAG/fe4kCTZ6rMz18mRxTtJt52oLk5XWWLtiwWwiTM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QRHTtZcVCbmkA1lnyNzg07pvRsZomCkCU8u1wm55exc/lX+prbRJp5EGhPlCN4Bljs5v2tfjsmn/C9r+8peUFSwzT/DcWj+lysz0duguMIWb4wm66/2fzahoRfv2svFh/W6zsP+vOg2VdI9MH0oSDNat+bRm20R50QVbf11l/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=B7zW+YuP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bxQ3k5TB0z9tQs;
	Tue,  5 Aug 2025 22:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1754425698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c5Nn7i0VkLvbxOj7/59vZOfEDznfAuB4gK2fc69rcaA=;
	b=B7zW+YuPf6JAfDJ1xdDdiBE2xVoihg4v2H4CzbaH2ZBcyfEY0xtW5xeSiIiJCFCj4bXTQq
	HJ+wFd+slcgVQw5B2z63oTn/s7S1fETfjQvJLKN+wReqSpklYV5ooyXN/RCIBRB1mnJ73M
	/njKa8pG3z3NNkZH6zSuVBnznpsH8SztNa0ktDogNipnvXxHF1yDq30tZbFJ+b78Av7+y6
	seuIea/hYaLe7NO91WVDIyF0gZaZVV+D+aZPM1SXtZQhpzAiA2Xw4IcuYkVdlI5IY7j6QL
	MgIsWT7SEf0ZZmjTdOoYNubCHdNkIj44K2NWV4jnjMqrgTWLkx5/9YFhllRWXg==
Message-ID: <97c607e9-516d-49b2-b7a5-4a2b7903c0b8@hauke-m.de>
Date: Tue, 5 Aug 2025 22:28:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: nnamrec@gmail.com
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, stable@vger.kernel.org
From: Hauke Mehrtens <hauke@hauke-m.de>
Subject: Kernel warning on 5.15.187+ caused: net/sched: Always pass
 notifications when child class becomes empty
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

We see a kernel warning with kernel 5.15.187 and later in OpenWrt 23.05.

When I revert this patch it is gone:
commit e269f29e9395527bc00c213c6b15da04ebb35070
Author: Lion Ackermann <nnamrec@gmail.com>
Date:   Mon Jun 30 15:27:30 2025 +0200
     net/sched: Always pass notifications when child class becomes empty
     [ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]

Link: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.189&id=e269f29e9395527bc00c213c6b15da04ebb35070

Hauke


Warning:
[   90.429594] ------------[ cut here ]------------
[   90.429929] WARNING: CPU: 0 PID: 3667 at net/sched/sch_htb.c:609 
0xffff800000d1b5dc
[   90.430561] Modules linked in: pppoe ppp_async nft_fib_inet 
nf_flow_table_ipv6 nf_flow_table_ipv4 nf_flow_table_inet pppox 
ppp_generic nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject 
nft_redir nft_quota nft_objref nft_numgen nft_nat nft_masq nft_log 
nft_limit nft_hash nft_flow_offload nft_fib_ipv6 nft_fib_ipv4 nft_fib 
nft_ct nft_counter nft_compat nft_chain_nat nf_tables nf_nat 
nf_flow_table nf_conntrack iptable_mangle iptable_filter ipt_REJECT 
ipt_ECN ip_tables xt_time xt_tcpudp xt_tcpmss xt_statistic xt_multiport 
xt_mark xt_mac xt_limit xt_length xt_hl xt_ecn xt_dscp xt_comment 
xt_TCPMSS xt_LOG xt_HL xt_DSCP xt_CLASSIFY x_tables smsc slhc sfp 
sch_cake ravb nfnetlink nf_reject_ipv6 nf_reject_ipv4 nf_log_syslog 
nf_defrag_ipv6 nf_defrag_ipv4 mdio_i2c mdio_gpio mdio_bitbang libcrc32c 
e1000e atlantic sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 
cls_route cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred 
act_gact gpio_pca953x i2c_mux_pca954x i2c_mux i2c_dev
[   90.431030]  sp805_wdt dwmac_sun8i dwmac_rk dwmac_imx nicvf nicpf 
thunder_bgx thunder_xcv dwmac_generic stmmac_platform stmmac rvu_nicvf 
rvu_nicpf rvu_af rvu_mbox mvpp2 mvneta vmxnet3 fec fsl_enetc 
fsl_enetc_mdio fsl_enetc_ierb fsl_dpaa2_eth ifb mdio_thunder mdio_cavium 
mdio_bcm_unimac xgmac_mdio pcs_lynx fsl_mc_dpio genet nls_utf8 
nls_iso8859_1 nls_cp437 pcs_xpcs marvell10g marvell macsec 
sha512_generic seqiv jitterentropy_rng drbg hmac rtc_rx8025 vfat fat ptp 
realtek broadcom bcm_phy_lib aquantia hwmon crc_ccitt pps_core phylink mii
[   90.435728] CPU: 0 PID: 3667 Comm: tc Not tainted 5.15.189 #0
[   90.436003] Hardware name: linux,dummy-virt (DT)
[   90.436306] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[   90.436578] pc : 0xffff800000d1b5dc
[   90.436736] lr : qdisc_tree_reduce_backlog+0xa0/0x120
[   90.436930] sp : ffff80000b73b6d0
[   90.437053] x29: ffff80000b73b6d0 x28: ffff000003d81030 x27: 
ffff0000033bf800
[   90.437335] x26: ffff0000033bf800 x25: ffff80000b73b8e0 x24: 
ffff000003677400
[   90.437576] x23: ffff800000d1f5e0 x22: 0000000000000000 x21: 
0000000000000000
[   90.437816] x20: 0000000000000000 x19: ffff0000034f6800 x18: 
0000000000000000
[   90.438054] x17: 0000000000000000 x16: 0000000000000000 x15: 
0000ffffc7ffd278
[   90.438299] x14: 000122a60001216d x13: 0001204400011f1c x12: 
00011df300011cca
[   90.438548] x11: 00011b9100011a68 x10: 0001194000011817 x9 : 
0000000000000000
[   90.438794] x8 : ffff000003677e00 x7 : 0000000000000000 x6 : 
0000000000000000
[   90.439037] x5 : ffff0000029df000 x4 : 0000000000000003 x3 : 
ffff000003684000
[   90.439277] x2 : ffff800000d1b5a0 x1 : 0000000000000000 x0 : 
ffff000003c64140
[   90.439629] Call trace:
[   90.439859]  0xffff800000d1b5dc
[   90.440021]  qdisc_tree_reduce_backlog+0xa0/0x120
[   90.440184]  0xffff800000d1dd8c
[   90.440302]  tc_ctl_tclass+0x15c/0x460
[   90.440440]  rtnetlink_rcv_msg+0x1b8/0x320
[   90.440583]  netlink_rcv_skb+0x5c/0x130
[   90.440715]  rtnetlink_rcv+0x18/0x2c
[   90.440841]  netlink_unicast+0x214/0x310
[   90.440975]  netlink_sendmsg+0x1a0/0x3dc
[   90.441120]  ____sys_sendmsg+0x1b8/0x220
[   90.441257]  ___sys_sendmsg+0x84/0xf0
[   90.441385]  __sys_sendmsg+0x48/0xb0
[   90.441509]  __arm64_sys_sendmsg+0x24/0x30
[   90.441647]  invoke_syscall.constprop.0+0x5c/0x110
[   90.441811]  do_el0_svc+0x6c/0x150
[   90.441929]  el0_svc+0x28/0xc0
[   90.442039]  el0t_64_sync_handler+0xe8/0x114
[   90.442186]  el0t_64_sync+0x1a4/0x1a8
[   90.442408] ---[ end trace b27ff72c6be40920 ]---


