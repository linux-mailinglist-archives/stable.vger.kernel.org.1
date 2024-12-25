Return-Path: <stable+bounces-106104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B29FC4A0
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 11:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D730418831F1
	for <lists+stable@lfdr.de>; Wed, 25 Dec 2024 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BFB1514DC;
	Wed, 25 Dec 2024 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="eV9vOvn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FHiSFl7r"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91B13211A
	for <stable@vger.kernel.org>; Wed, 25 Dec 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735121201; cv=none; b=a6j79UeA25gk7CAaypdTo0h0yHF0Od6APJMyDbVaGKwIlf+Esot15NAWm11m20hvgwJuXXv6lRpegk/ykAK7KKNfxi/cX+pVNoeihhC4gF2ZVsIvI3G4Pous5tqmXCziZRHIAPdpfjgg6PizY4ALas0LugvRE9C79chgSDLkCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735121201; c=relaxed/simple;
	bh=m5f6elrDFRhN5O0keou/jRCSBt7xgrWDUyi4PEs2/R8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ksvmWCZk2rmwHxdC2eMJ5hHZxJZ7wdoaHQRh6qovx7A82MnKk9/b6qzb+VBj7hNOEe2FxIoBIYhsmeCYffDNabcDdBfWcUuIjce1j2JBHlpo/VpkdCVl/VX6uJIIqmnNRFfi3ovVZoj5EH4un0B+v2RiooI0cSZsY3j6puA4Th4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=eV9vOvn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FHiSFl7r; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id EA016138017E;
	Wed, 25 Dec 2024 05:06:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 25 Dec 2024 05:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1735121196; x=1735207596; bh=Z1j2zj0cqFcqkETa/lKOk0LWPvRoE6lV
	EdeEBQONvk8=; b=eV9vOvn2myD1VWTvQ0uLohFjMxlsbmCCHzcplQMJDCpeUr15
	tRnInaRREQkYn8Jb82Z2bhK90FMRk0iP+tJFpx+pey3Yt8VSeNlwFe76+4B9EgRJ
	O1zCzWf/POQ+fHeN+y2MnmIkky5J7GIUtRGjbXPZ6eNGbLSb1GlaKZ0BFF5NS0/7
	saNqI6gYKnc4BaHb11f8F2ck7l7B1fn6p5qxGGYzUlZBXg/Ti208YaF/xlpxcAav
	ijUYlPjBLk6zRQuf76bMDxxWN38m0w/fTKOz73XFJ3nuqZxADsuLIp5Dfz0GSLtP
	sMWSyuL9tz8iIkfuC5r9X5mCuqD/LC4eWWuOUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735121196; x=
	1735207596; bh=Z1j2zj0cqFcqkETa/lKOk0LWPvRoE6lVEdeEBQONvk8=; b=F
	HiSFl7r9zDKS5VOPA3QClZpuxPpeEDtrPh4Q61Zvc7wizK1iqRc9I3IaWzyO6b3p
	+Jb4La53ACBcTULVpjrUokj0ERAv3Q0UJn3LNu/57KX0qiKDK3xEJxoRuH/IQyfx
	n0W2nubQnbANFof+O/kwWuec6EpxOneI/IPVgWIQspV+rxIWPESnPwrAo4RmP852
	ESs0fFlYREyl2t2BXRBkLkBzdqUXR9qZZ7EUVRdqZ39S46oKxHpvaK/N9v3x90+q
	+u+ettTWoj9YKtX7ylgoWhEdhFAFNJmEw/XyRKN1piGiJ/32BWT1vInJJ16MI2mq
	6OxMvzKZL1I2MCQdZUa+g==
X-ME-Sender: <xms:LNlrZzMNLFc--4sc03rIuBF8xDONydjUx3Ek9YMIm-4ZkMGtO8Ck6Q>
    <xme:LNlrZ9-Ml17szESerJeomSJ4i9qbNbNyCxu3F7G1NSxs4PXNuSvf4VeMaD7i5IrKy
    Actvxt450fUQtmRaA>
X-ME-Received: <xmr:LNlrZyStC6Z1WnK7_ezlGDxm49Pj4Temky7Au_tCjL8wRUXcERC3pYqst-LfDS-m9_JX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduiedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfggtggusehttdertddttdejnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcu
    oehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeehjefhueffve
    dtteegffelleekfeekffetffejuddujedtfedvgffhueeggeetleenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvd
    drvghupdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    grnhguvghrrdguvghutghhvghrsegrmhgurdgtohhm
X-ME-Proxy: <xmx:LNlrZ3t8mkpM-vUeOcmoO_52Ew07vZw0FIPTzZeQIeDXTWlX5Dx8fA>
    <xmx:LNlrZ7dGRTdlaIqnvBaC6CWOmBCcVJHk1u0rMgDgVBmN48Ru3J8veg>
    <xmx:LNlrZz0ioinXfHRO1cDwfEDe36YRpNlfNZ9pSAHyQCzFwnWVPCyLdA>
    <xmx:LNlrZ3_zpE0s5f01VILsHzW9QLxV7t6Yw-QXZ5aQVfZEuM3n4zJt-g>
    <xmx:LNlrZ8rTF8VjU0h1yJXt6LekOMhsN411RNLrYrA-SZO0akd0dEsdkdxm>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Dec 2024 05:06:35 -0500 (EST)
Date: Wed, 25 Dec 2024 11:05:56 +0100
From: Fernando Ramos <greenfoo@u92.eu>
To: stable@vger.kernel.org
Cc: alexander.deucher@amd.com
Subject: [REGRESSION] Brightness control does not work after waking up from
 suspend
Message-ID: <Z2vZBFDJrIufbM9F@x395.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Commit 73dae652dcac776296890da215ee7dec357a1032 (included in 6.13-rc2) was
backported to 6.12.5 as 99a02eab82515343d536796aa917dee50aec1551.

This causes a problem where brightness control no longer works after waking up
from suspend.

This is the  output of "journalctl -f" when the issue is triggered:

  > ...
  > Dec 25 01:37:00 x395 kernel: usb 4-1: reset full-speed USB device number 2 using xhci_hcd
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 11 on hub 0
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 8
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 8
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 8
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 8
  > Dec 25 01:37:00 x395 kernel: amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 8
  > Dec 25 01:37:00 x395 kernel: irq 7: nobody cared (try booting with the "irqpoll" option)
  > Dec 25 01:37:00 x395 kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.7-rc1-gc157915828d8 #7 14cb019df871d9dae96d82113f6abf187f110b68
  > Dec 25 01:37:00 x395 kernel: Hardware name: LENOVO 20NLCTO1WW/20NLCTO1WW, BIOS R13ET50W(1.24 ) 06/11/2021
  > Dec 25 01:37:00 x395 kernel: Call Trace:
  > Dec 25 01:37:00 x395 kernel:  <IRQ>
  > Dec 25 01:37:00 x395 kernel:  dump_stack_lvl+0x5d/0x80
  > Dec 25 01:37:00 x395 kernel:  __report_bad_irq+0x35/0xa7
  > Dec 25 01:37:00 x395 kernel:  note_interrupt.cold+0xa/0x62
  > Dec 25 01:37:00 x395 kernel:  handle_irq_event+0x6f/0x80
  > Dec 25 01:37:00 x395 kernel:  handle_fasteoi_irq+0x78/0x200
  > Dec 25 01:37:00 x395 kernel:  __common_interrupt+0x3e/0x90
  > Dec 25 01:37:00 x395 kernel:  common_interrupt+0x42/0xa0
  > Dec 25 01:37:00 x395 kernel:  asm_common_interrupt+0x26/0x40
  > Dec 25 01:37:00 x395 kernel: RIP: 0010:tmigr_handle_remote+0x87/0x470
  > Dec 25 01:37:00 x395 kernel: Code: 24 04 00 0f 84 ac 00 00 00 48 b9 ff ff ff ff ff ff ff 7f 41 0f b6 54 24 10 48 89 4c 24 38 88 54 24 48 49 8b 44 24 08 8b 40 50 <0f> b6 c4 38 c2 74 0e 3c ff 74 0a 49 8b 44 24 18 48 39 c8 74 76 48
  > Dec 25 01:37:00 x395 kernel: RSP: 0018:ffffafe000003ea8 EFLAGS: 00000202
  > Dec 25 01:37:00 x395 kernel: RAX: 000000003de00141 RBX: 0000000000000002 RCX: 7fffffffffffffff
  > Dec 25 01:37:00 x395 kernel: RDX: 0000000000000001 RSI: ffffafe000003ed8 RDI: ffffafe000003f10
  > Dec 25 01:37:00 x395 kernel: RBP: 0000000000000101 R08: f1c92dc141c95fb9 R09: 263db225b099c5f2
  > Dec 25 01:37:00 x395 kernel: R10: f1c92dc141c95fb9 R11: 263db225b099c5f2 R12: ffff989030a26300
  > Dec 25 01:37:00 x395 kernel: R13: 0000000000000001 R14: 0000000000000282 R15: 0000000000000001
  > Dec 25 01:37:00 x395 kernel:  ? srso_return_thunk+0x5/0x5f
  > Dec 25 01:37:00 x395 kernel:  ? __run_timers+0x1fc/0x280
  > Dec 25 01:37:00 x395 kernel:  handle_softirqs+0xe4/0x2a0
  > Dec 25 01:37:00 x395 kernel:  __irq_exit_rcu+0x97/0xb0
  > Dec 25 01:37:00 x395 kernel:  sysvec_apic_timer_interrupt+0x71/0x90
  > Dec 25 01:37:00 x395 kernel:  </IRQ>
  > Dec 25 01:37:00 x395 kernel:  <TASK>
  > Dec 25 01:37:00 x395 kernel:  asm_sysvec_apic_timer_interrupt+0x1a/0x20
  > Dec 25 01:37:00 x395 kernel: RIP: 0010:tick_nohz_idle_enter+0x59/0x70
  > Dec 25 01:37:00 x395 kernel: Code: 02 00 01 83 45 7c 01 e8 05 c9 fe ff 48 89 85 80 00 00 00 48 83 8b 00 62 02 00 04 83 45 7c 01 e8 3d 93 f8 ff fb 0f 1f 44 00 00 <5b> 5d e9 10 d1 c8 00 0f 0b eb c6 66 66 2e 0f 1f 84 00 00 00 00 00
  > Dec 25 01:37:00 x395 kernel: RSP: 0018:ffffffffa1c03e68 EFLAGS: 00000282
  > Dec 25 01:37:00 x395 kernel: RAX: 0000000874467ae1 RBX: ffff989030a00000 RCX: 0000000874467ae1
  > Dec 25 01:37:00 x395 kernel: RDX: 0000000874467ae1 RSI: 0000000000001d53 RDI: 0000000874467ae1
  > Dec 25 01:37:00 x395 kernel: RBP: ffff989030a26200 R08: 0000000000000002 R09: 0000000000000000
  > Dec 25 01:37:00 x395 kernel: R10: 0000000000000001 R11: 0000000000000000 R12: ffff98903efc9ff4
  > Dec 25 01:37:00 x395 kernel: R13: 0000000000000000 R14: ffffffffa1c10038 R15: 00000000aafaf000
  > Dec 25 01:37:00 x395 kernel:  ? tick_nohz_idle_enter+0x53/0x70
  > Dec 25 01:37:00 x395 kernel:  do_idle+0x3f/0x210
  > Dec 25 01:37:00 x395 kernel:  cpu_startup_entry+0x29/0x30
  > Dec 25 01:37:00 x395 kernel:  rest_init+0xcc/0xd0
  > Dec 25 01:37:00 x395 kernel:  start_kernel+0x9be/0x9c0
  > Dec 25 01:37:00 x395 kernel:  x86_64_start_reservations+0x24/0x30
  > Dec 25 01:37:00 x395 kernel:  x86_64_start_kernel+0x95/0xa0
  > Dec 25 01:37:00 x395 kernel:  common_startup_64+0x13e/0x141
  > Dec 25 01:37:00 x395 kernel:  </TASK>
  > Dec 25 01:37:00 x395 kernel: handlers:
  > Dec 25 01:37:00 x395 kernel: [<00000000d69cbeca>] amd_gpio_irq_handler
  > Dec 25 01:37:00 x395 kernel: Disabling IRQ #7
  > Dec 25 01:37:00 x395 kernel: usb 4-2: reset high-speed USB device number 3 using xhci_hcd
  > Dec 25 01:37:01 x395 kernel: usb 4-2.1: reset high-speed USB device number 4 using xhci_hcd
  > Dec 25 01:37:01 x395 kernel: OOM killer enabled.
  > Dec 25 01:37:01 x395 kernel: Restarting tasks ... 
  > Dec 25 01:37:01 x395 kernel: usb 4-2.2: USB disconnect, device number 5
  > Dec 25 01:37:01 x395 kernel: done.
  > ...

The problem only happens in the stable branch (v6.12.y) and not in the main
branch. More specifically:

  Version                                        Problem present
  =================================================================
  v6.12.5                                        Yes !!
  v6.12.5 + revert 99a02eab                      No
  v6.12.7-rc1 (c157915828d)                      Yes !!
  v6.12.7-rc1 (c157915828d) + revert 99a02eab    No
  v6.13-rc4                                      No


