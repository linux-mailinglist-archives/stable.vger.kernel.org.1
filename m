Return-Path: <stable+bounces-172538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF1B3265B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3098B6191A
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E81AC43A;
	Sat, 23 Aug 2025 02:02:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728035963;
	Sat, 23 Aug 2025 02:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914525; cv=none; b=FnD3cUTrpVwDhb7CbkmdiFVF4FkCqzaCBAVrWxj9IUDHFVSpM71HeglEky+Gc5VBLhhSYm139uYwqb87jzv7jgbfWClnQl6Cr62Xr7wpgFekJ4H+0xLVGdzNEPyPpYQa1CmMSsrIgplUdCUl7s+HaH22JdeBStevo8FKFNoJmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914525; c=relaxed/simple;
	bh=68uIIk/t327iWo6rNsAtv3FKCWScccbYXSU7TNuKJVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONEj3xeYfuw4souQAL5hXLNq/m8lcsGOFsshSdZj3tFxYdQL28pLGb+3T35MEtSapsvqf/eG13H+YRoQD4KI/5q2MlVC9rAra6OT0bT4Uc+wtc9tz/LaiD3DE+rLooH6ONvVP4nBvyttKpOFkirLTuchld+pPolcNxcVC1A86Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c80fW2KWJzYl4tT;
	Sat, 23 Aug 2025 10:01:39 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 23 Aug
 2025 10:01:53 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 23 Aug
 2025 10:01:53 +0800
From: wangzijie <wangzijie1@honor.com>
To: <rsalvaterra@gmail.com>
CC: <adobriyan@gmail.com>, <akpm@linux-foundation.org>,
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <openwrt-devel@lists.openwrt.org>,
	<stable@vger.kernel.org>, <viro@zeniv.linux.org.uk>, <wangzijie1@honor.com>
Subject: Re: [REGRESSION, BISECTED] IPv6 RA is broken with Linux 6.12.42+
Date: Sat, 23 Aug 2025 10:01:52 +0800
Message-ID: <20250823020152.1651585-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CALjTZvZkDr8N18ocZ8jNND_4DwKqr-PV4BBXB60+=WXPF3vn=Q@mail.gmail.com>
References: <CALjTZvZkDr8N18ocZ8jNND_4DwKqr-PV4BBXB60+=WXPF3vn=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a011.hihonor.com
 (10.68.31.243)

> Hi, everyone,
> 
> 
> We noticed a regression in OpenWrt, with IPv6, which causes a router's
> client devices to stop receiving the IPv6 default route. I have
> bisected it down to (rather surprisingly)
> fc1072d934f687e1221d685cf1a49a5068318f34 ("proc: use the same
> treatment to check proc_lseek as ones for proc_read_iter et.al").
> Reverting the aforementioned commit fixes the issue, of course.
> 
> Git bisect log follows:
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [880e4ff5d6c8dc6b660f163a0e9b68b898cc6310] Linux 6.12.42
> git bisect bad 880e4ff5d6c8dc6b660f163a0e9b68b898cc6310
> # status: waiting for good commit(s), bad commit known
> # good: [8f5ff9784f3262e6e85c68d86f8b7931827f2983] Linux 6.12.41
> git bisect good 8f5ff9784f3262e6e85c68d86f8b7931827f2983
> # good: [dab173bae3303f074f063750a8dead2550d8c782] RDMA/hns: Fix
> double destruction of rsv_qp
> git bisect good dab173bae3303f074f063750a8dead2550d8c782
> # bad: [11fa01706a4f60e759fbee7c53095ff22eaf1595] PCI: pnv_php: Work
> around switches with broken presence detection
> git bisect bad 11fa01706a4f60e759fbee7c53095ff22eaf1595
> # bad: [966460bace9e1dd8609c9d44cf4509844daea8bb] perf record: Cache
> build-ID of hit DSOs only
> git bisect bad 966460bace9e1dd8609c9d44cf4509844daea8bb
> # bad: [f63bd615e58f43dbe4b2e4c3f3ffa0bfb7766007] hwrng: mtk - handle
> devm_pm_runtime_enable errors
> git bisect bad f63bd615e58f43dbe4b2e4c3f3ffa0bfb7766007
> # bad: [9ea3f6b9a67be3476e331ce51cac316c2614a564] pinmux: fix race
> causing mux_owner NULL with active mux_usecount
> git bisect bad 9ea3f6b9a67be3476e331ce51cac316c2614a564
> # good: [1209e33fe3afb6d9e543f963d41b30cfc04538ff] RDMA/hns: Get
> message length of ack_req from FW
> git bisect good 1209e33fe3afb6d9e543f963d41b30cfc04538ff
> # good: [5f3c0301540bc27e74abbfbe31571e017957251b] RDMA/hns: Fix
> -Wframe-larger-than issue
> git bisect good 5f3c0301540bc27e74abbfbe31571e017957251b
> # bad: [fc1072d934f687e1221d685cf1a49a5068318f34] proc: use the same
> treatment to check proc_lseek as ones for proc_read_iter et.al
> git bisect bad fc1072d934f687e1221d685cf1a49a5068318f34
> # good: [ec437d0159681bbdb1cf1f26759d12e9650bffca] kernel: trace:
> preemptirq_delay_test: use offstack cpu mask
> git bisect good ec437d0159681bbdb1cf1f26759d12e9650bffca
> # first bad commit: [fc1072d934f687e1221d685cf1a49a5068318f34] proc:
> use the same treatment to check proc_lseek as ones for proc_read_iter
> et.al
> 
> Please let me know if you need any additional information.
> 
> 
> Kind regards,
> 
> Rui Salvaterra

Hi Rui,
Thanks. I have submitted a patch and I think it can fix this.
https://lore.kernel.org/all/20250821105806.1453833-1-wangzijie1@honor.com

