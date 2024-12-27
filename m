Return-Path: <stable+bounces-106206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E39FD536
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 15:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E588F1885E88
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114FB1F540F;
	Fri, 27 Dec 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="mWb8Ymuz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dinSZlld"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52391F193A
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310088; cv=none; b=jU9wQsQPYdoEhJT8/G82PyOVJlU6GM7iSqIL7aEJ0xzQjtW5qtfJcYtjYeaG5jXj7I2B6kpL1KqWYD8GJsGFkRZn3cxc+R2Z50Mcyp8Y4iBoeesyTLh55yTkO9ML8c9WL3O5KIDBwYWaQyy0Uh2P3uc4/c5E1IP+iikk++ENyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310088; c=relaxed/simple;
	bh=L3WGVfuOPTRr2DS7+pUWo8Wrc+V6a1nW2gMFXqnVAUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txnvgwWwHWq8yvUAhi0eJAracN3+MkEk7E3fmmNOUxl+++mcaTfOjFVUXOk0ew0iyvZqLbMAa4arZc0jotfEmSKN5TFPKYpwpcPlf1H4G+Hc0T1uVYNp+TnYkPku3HDCc9gN4diiBD8HVsctOOc1J7Txn33z2T5O8eKNQUDe6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=mWb8Ymuz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dinSZlld; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BEB2F2540189;
	Fri, 27 Dec 2024 09:34:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 27 Dec 2024 09:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735310085; x=1735396485; bh=ErPE+j19Da
	+32oLuDOx5Z5qcmUKwIPob9NithBvJ19c=; b=mWb8Ymuz4A8RfQnLseCthDt87W
	xznW6QodB00RCdPgdKETZusdqs3sGM2w5mjtKOdC7Zg3oJe/a5gVURvE1dcRMOTg
	cTOWKt8Jt/5YMfsNlvmU3tGfDr9Mb4cCxCE+OFtljLB04YhVRVr71hrpCA7Mc5tD
	hBBwAsrxy90+n86yrYdBsstKL7PUGPBqf9A8Lge7WKZ4ta5HWyQJnFXYH2c2SX7k
	7fnSVe+QOk7OPauQyFRVR44Gn40hWbP8ijhjfz2tqWCvFxfXntyQpvRKHVWY7BXz
	tU1wjsUDERTXRFZXTY9bOyrTZ6FhkPiOlvJnmzdX49F47wN3BQ2+Xt/lUOLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735310085; x=1735396485; bh=ErPE+j19Da+32oLuDOx5Z5qcmUKwIPob9Ni
	thBvJ19c=; b=dinSZlld2llIQ2oi3q2xtU9ThmMDCrGnjhPQa3/TjKPo2xBSTYM
	+GYazxyB9BkEJ34cRKQufkwu0I5cdJDP0fiZ3Lz5qg4vO2/RSpb57GyiNXJuKXK/
	q6MNEh4d6JC1vESCaoJ37UL3iZ/4bChDwOzWNleISlVnwRcLdSEVNbZEYTPTPFTf
	Wc8dxeKEtpxo2Yf7Bdivrfm3uQSgd/X84pEebHioekiEEXfRB09YYrXf2MYJ/Nwp
	vGCNmSbl02MkzR8OAdWXmAgoqH0d50w/uODH2owAiUR5CK4iea/kl1aN2davmUNe
	h6st5sqeMJF45LVhlxKU4Sh5xqUDXCU7Bww==
X-ME-Sender: <xms:BbtuZ1zfoeu4-eSNu0y7ObEpIy-rjwmwm88-vAERQ9PTfNBlpFdHrw>
    <xme:BbtuZ1TeXrsOad8x_EqFC0sXk8ifvKJiOg2Uhm4OJy96IWvd7zv0bMumAzVwGOHZ9
    H9CAp4ZiD1oF9tJHQ>
X-ME-Received: <xmr:BbtuZ_V59MfsLHMEo2RDavYxd8AbP-TaX5s47qUjVtwL6zBNM-WNmEWT_QL3lodYtVF7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhho
    shcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeffheevte
    efjeevieekheeujeeivefguedvieefleeuiefgtddtleelheevledvjeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuh
    elvddrvghupdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvg
    hgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprghl
    vgigrghnuggvrhdruggvuhgthhgvrhesrghmugdrtghomh
X-ME-Proxy: <xmx:BbtuZ3h3afGZ96sgD1MiqjOBXVtKue4zrX20UrlS04CiA0Dr20Qvaw>
    <xmx:BbtuZ3ByIfrdGABHjEN1-s4IC6gnrepYDeDuSOwC0ZeLUR2A7N7C3Q>
    <xmx:BbtuZwL2NK3y-OA-sJ5B963RbSJsI3zFaRYm2ujTepmQPgjayiu0MQ>
    <xmx:BbtuZ2AcCE0XPuT9Tn9TF7bmzm-bRm6DQco5fFbNJMlcq3722eKcLg>
    <xmx:BbtuZ-NZkeoYX66iOA4ybxx2D2fnWBqeFT22wjBp1ECicj4onqss_tcT>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:34:44 -0500 (EST)
Date: Fri, 27 Dec 2024 15:34:03 +0100
From: Fernando Ramos <greenfoo@u92.eu>
To: stable@vger.kernel.org, regressions@lists.linux.dev
Cc: alexander.deucher@amd.com
Subject: Re: [REGRESSION] Brightness control does not work after waking up
 from suspend
Message-ID: <Z26622iBftg1XJtl@x395.localdomain>
References: <Z2vZBFDJrIufbM9F@x395.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2vZBFDJrIufbM9F@x395.localdomain>

I've been told to forward this message to regressions@lists.linux.dev in
addition to stable@vger.kernel.org.

On 24/12/25 11:06AM, Fernando Ramos wrote:
> Commit 73dae652dcac776296890da215ee7dec357a1032 (included in 6.13-rc2) was
> backported to 6.12.5 as 99a02eab82515343d536796aa917dee50aec1551.
> 
> This causes a problem where brightness control no longer works after waking up
> from suspend.
> 
> This is the  output of "journalctl -f" when the issue is triggered:
> 
>   > ...
>   > Dec 25 01:37:00 x395 kernel: usb 4-1: reset full-speed USB device number 2 using xhci_hcd
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 8
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 8
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 8
>   > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 8
>   > Dec 25 01:37:00 x395 kernel: irq 7: nobody cared (try booting with the "irqpoll" option)
>   > Dec 25 01:37:00 x395 kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.7-rc1-gc157915828d8 #7 14cb019df871d9dae96d82113f6abf187f110b68
>   > Dec 25 01:37:00 x395 kernel: Hardware name: LENOVO 20NLCTO1WW/20NLCTO1WW, BIOS R13ET50W(1.24 ) 06/11/2021
>   > Dec 25 01:37:00 x395 kernel: Call Trace:
>   > Dec 25 01:37:00 x395 kernel:  <IRQ>
>   > Dec 25 01:37:00 x395 kernel:  dump_stack_lvl+0x5d/0x80
>   > Dec 25 01:37:00 x395 kernel:  __report_bad_irq+0x35/0xa7
>   > Dec 25 01:37:00 x395 kernel:  note_interrupt.cold+0xa/0x62
>   > Dec 25 01:37:00 x395 kernel:  handle_irq_event+0x6f/0x80
>   > Dec 25 01:37:00 x395 kernel:  handle_fasteoi_irq+0x78/0x200
>   > Dec 25 01:37:00 x395 kernel:  __common_interrupt+0x3e/0x90
>   > Dec 25 01:37:00 x395 kernel:  common_interrupt+0x42/0xa0
>   > Dec 25 01:37:00 x395 kernel:  asm_common_interrupt+0x26/0x40
>   > Dec 25 01:37:00 x395 kernel: RIP: 0010:tmigr_handle_remote+0x87/0x470
>   > Dec 25 01:37:00 x395 kernel: Code: 24 04 00 0f 84 ac 00 00 00 48 b9 ff ff ff ff ff ff ff 7f 41 0f b6 54 24 10 48 89 4c 24 38 88 54 24 48 49 8b 44 24 08 8b 40 50 <0f> b6 c4 38 c2 74 0e 3c ff 74 0a 49 8b 44 24 18 48 39 c8 74 76 48
>   > Dec 25 01:37:00 x395 kernel: RSP: 0018:ffffafe000003ea8 EFLAGS: 00000202
>   > Dec 25 01:37:00 x395 kernel: RAX: 000000003de00141 RBX: 0000000000000002 RCX: 7fffffffffffffff
>   > Dec 25 01:37:00 x395 kernel: RDX: 0000000000000001 RSI: ffffafe000003ed8 RDI: ffffafe000003f10
>   > Dec 25 01:37:00 x395 kernel: RBP: 0000000000000101 R08: f1c92dc141c95fb9 R09: 263db225b099c5f2
>   > Dec 25 01:37:00 x395 kernel: R10: f1c92dc141c95fb9 R11: 263db225b099c5f2 R12: ffff989030a26300
>   > Dec 25 01:37:00 x395 kernel: R13: 0000000000000001 R14: 0000000000000282 R15: 0000000000000001
>   > Dec 25 01:37:00 x395 kernel:  ? srso_return_thunk+0x5/0x5f
>   > Dec 25 01:37:00 x395 kernel:  ? __run_timers+0x1fc/0x280
>   > Dec 25 01:37:00 x395 kernel:  handle_softirqs+0xe4/0x2a0
>   > Dec 25 01:37:00 x395 kernel:  __irq_exit_rcu+0x97/0xb0
>   > Dec 25 01:37:00 x395 kernel:  sysvec_apic_timer_interrupt+0x71/0x90
>   > Dec 25 01:37:00 x395 kernel:  </IRQ>
>   > Dec 25 01:37:00 x395 kernel:  <TASK>
>   > Dec 25 01:37:00 x395 kernel:  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>   > Dec 25 01:37:00 x395 kernel: RIP: 0010:tick_nohz_idle_enter+0x59/0x70
>   > Dec 25 01:37:00 x395 kernel: Code: 02 00 01 83 45 7c 01 e8 05 c9 fe ff 48 89 85 80 00 00 00 48 83 8b 00 62 02 00 04 83 45 7c 01 e8 3d 93 f8 ff fb 0f 1f 44 00 00 <5b> 5d e9 10 d1 c8 00 0f 0b eb c6 66 66 2e 0f 1f 84 00 00 00 00 00
>   > Dec 25 01:37:00 x395 kernel: RSP: 0018:ffffffffa1c03e68 EFLAGS: 00000282
>   > Dec 25 01:37:00 x395 kernel: RAX: 0000000874467ae1 RBX: ffff989030a00000 RCX: 0000000874467ae1
>   > Dec 25 01:37:00 x395 kernel: RDX: 0000000874467ae1 RSI: 0000000000001d53 RDI: 0000000874467ae1
>   > Dec 25 01:37:00 x395 kernel: RBP: ffff989030a26200 R08: 0000000000000002 R09: 0000000000000000
>   > Dec 25 01:37:00 x395 kernel: R10: 0000000000000001 R11: 0000000000000000 R12: ffff98903efc9ff4
>   > Dec 25 01:37:00 x395 kernel: R13: 0000000000000000 R14: ffffffffa1c10038 R15: 00000000aafaf000
>   > Dec 25 01:37:00 x395 kernel:  ? tick_nohz_idle_enter+0x53/0x70
>   > Dec 25 01:37:00 x395 kernel:  do_idle+0x3f/0x210
>   > Dec 25 01:37:00 x395 kernel:  cpu_startup_entry+0x29/0x30
>   > Dec 25 01:37:00 x395 kernel:  rest_init+0xcc/0xd0
>   > Dec 25 01:37:00 x395 kernel:  start_kernel+0x9be/0x9c0
>   > Dec 25 01:37:00 x395 kernel:  x86_64_start_reservations+0x24/0x30
>   > Dec 25 01:37:00 x395 kernel:  x86_64_start_kernel+0x95/0xa0
>   > Dec 25 01:37:00 x395 kernel:  common_startup_64+0x13e/0x141
>   > Dec 25 01:37:00 x395 kernel:  </TASK>
>   > Dec 25 01:37:00 x395 kernel: handlers:
>   > Dec 25 01:37:00 x395 kernel: [<00000000d69cbeca>] amd_gpio_irq_handler
>   > Dec 25 01:37:00 x395 kernel: Disabling IRQ #7
>   > Dec 25 01:37:00 x395 kernel: usb 4-2: reset high-speed USB device number 3 using xhci_hcd
>   > Dec 25 01:37:01 x395 kernel: usb 4-2.1: reset high-speed USB device number 4 using xhci_hcd
>   > Dec 25 01:37:01 x395 kernel: OOM killer enabled.
>   > Dec 25 01:37:01 x395 kernel: Restarting tasks ... 
>   > Dec 25 01:37:01 x395 kernel: usb 4-2.2: USB disconnect, device number 5
>   > Dec 25 01:37:01 x395 kernel: done.
>   > ...
> 
> The problem only happens in the stable branch (v6.12.y) and not in the main
> branch. More specifically:
> 
>   Version                                        Problem present
>   =================================================================
>   v6.12.5                                        Yes !!
>   v6.12.5 + revert 99a02eab                      No
>   v6.12.7-rc1 (c157915828d)                      Yes !!
>   v6.12.7-rc1 (c157915828d) + revert 99a02eab    No
>   v6.13-rc4                                      No
> 

