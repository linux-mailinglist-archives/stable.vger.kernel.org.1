Return-Path: <stable+bounces-51752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D790716C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C751F2566F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B04161;
	Thu, 13 Jun 2024 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PXwyFuT0"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0104384;
	Thu, 13 Jun 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282209; cv=none; b=puoRYQ2hFE7EPkimKgH1O7ogeKnM7uCLAiDyUtyQsQCUd+AfoYUcdk/HIleTARLWsw5b5QW3BcbSGufYl2/611nxJeETxT3PnsM9fbPxEqQNdVWWT27NiMwwxeJfaZxfEQG6zwASNbzcEhpGMPS6uGuReiKk3vyzaeZxz81Hv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282209; c=relaxed/simple;
	bh=romDsGiHyj+Pvt3P68qf7EXcJ8es7BN5r0u1TQ25g6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UsOTdFhQ1xb/3E9pTKIxUkEoBvZjiNj2WPAuw9kwybpRG3C1XXwY7+FeCgjqmB5V+7j7UhCz49p/xNjXv6JT46tWJMEgb/dnuZGwJKAwF6heakdTFN/zZPMPfWeukwvWQlf56WLSKtF7ULqfSL12x5ZUew4EzpajLOvHU6y1C4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=PXwyFuT0; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718282203;
	bh=WW4ftqDIvUMc2IIhJpk+diOslyASBtsvVD8iegY87PQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PXwyFuT0fc4hMs9pFRG3kpugSS278/qYyt7ZY2A+u//PUS/buq32NBNIvQL63/xXL
	 tEq34mdCKNjp+ZZoBlNLP5or9K9NG5iBg5S72q0XhgsTF65Pg/FN1vJvm6Rgh7NMXu
	 no+OD7C3MEvBBqmG+6hujrWnn/zkmFqxqGs70RpryxlDbaKS24tLs9+SeNxstMhcG6
	 t9bgZDYnr8pF05mpv3OjWUlhZJq5NpTJp9l8IRiiQrpYmukWizAQxR1cHys5FucZ0l
	 I80tfoay+LQFSUh3wGRp+nZCQwEQAq+mxG67iaNisQlSlACaZIB/gPDCXVn4RPwl7X
	 bWrMga/romgbg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W0MNW4qdLz4xrg;
	Thu, 13 Jun 2024 22:36:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ghadi Elie Rahme <ghadi.rahme@canonical.com>, netdev@vger.kernel.org
Cc: Ghadi Elie Rahme <ghadi.rahme@canonical.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] bnx2x: Fix multiple UBSAN array-index-out-of-bounds
In-Reply-To: <20240612154449.173663-1-ghadi.rahme@canonical.com>
References: <20240612154449.173663-1-ghadi.rahme@canonical.com>
Date: Thu, 13 Jun 2024 22:36:42 +1000
Message-ID: <8734phow85.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ghadi Elie Rahme <ghadi.rahme@canonical.com> writes:
> Fix UBSAN warnings that occur when using a system with 32 physical
> cpu cores or more, or when the user defines a number of Ethernet
> queues greater than or equal to FP_SB_MAX_E1x using the num_queues
> module parameter.
>
> The value of the maximum number of Ethernet queues should be limited
> to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
> enabled to avoid out of bounds reads and writes.
>
> Stack traces:
>
> UBSAN: array-index-out-of-bounds in
>        drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1529:11
> index 20 is out of range for type 'stats_query_entry [19]'
> CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic
> 	     #202405052133
> Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,
> 	       BIOS P89 10/21/2019
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x76/0xa0
>  dump_stack+0x10/0x20
>  __ubsan_handle_out_of_bounds+0xcb/0x110
>  bnx2x_prep_fw_stats_req+0x2e1/0x310 [bnx2x]
>  bnx2x_stats_init+0x156/0x320 [bnx2x]
>  bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
>  bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
>  bnx2x_open+0x16b/0x290 [bnx2x]
>  __dev_open+0x10e/0x1d0
> RIP: 0033:0x736223927a0a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca
>       64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00
>       f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
> RSP: 002b:00007ffc0bb2ada8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 0000583df50f9c78 RCX: 0000736223927a0a
> RDX: 0000000000000020 RSI: 0000583df50ee510 RDI: 0000000000000003
> RBP: 0000583df50d4940 R08: 00007ffc0bb2adb0 R09: 0000000000000080
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000583df5103ae0
> R13: 000000000000035a R14: 0000583df50f9c30 R15: 0000583ddddddf00
> </TASK>
> ---[ end trace ]---
> ------------[ cut here ]------------
> UBSAN: array-index-out-of-bounds in
>        drivers/net/ethernet/broadcom/bnx2x/bnx2x_stats.c:1546:11
> index 28 is out of range for type 'stats_query_entry [19]'
> CPU: 12 PID: 858 Comm: systemd-network Not tainted 6.9.0-060900rc7-generic
> 	     #202405052133
> Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9,
> 	       BIOS P89 10/21/2019
> Call Trace:
> <TASK>
> dump_stack_lvl+0x76/0xa0
> dump_stack+0x10/0x20
> __ubsan_handle_out_of_bounds+0xcb/0x110
> bnx2x_prep_fw_stats_req+0x2fd/0x310 [bnx2x]
> bnx2x_stats_init+0x156/0x320 [bnx2x]
> bnx2x_post_irq_nic_init+0x81/0x1a0 [bnx2x]
> bnx2x_nic_load+0x8e8/0x19e0 [bnx2x]
> bnx2x_open+0x16b/0x290 [bnx2x]
> __dev_open+0x10e/0x1d0
 
I also hit this one on powerpc:

  https://lore.kernel.org/all/87pltc4rs8.fsf@mail.lhotse/

And confirm that this patch fixes it there too.

cheers

