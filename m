Return-Path: <stable+bounces-35643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36257895CC7
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 21:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E211F215DF
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 19:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B9A15B972;
	Tue,  2 Apr 2024 19:36:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [89.58.27.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908915DBD6
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.27.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086569; cv=none; b=V2/COJe8U38mFm3/1JbSbgljsHD6y0z6PRuBByaj+5F12M+9js8DreBZ5R+bcVqax5CDLOFUq/mn8qIpQa4eCeuUFUITkIZ6oBj0azAD2n8sdDCcpxg5Ejf8bcqXvwPM9IFIIjMPkv6Z00uqTbsK2aMDHLKVxmSbC3dhGcaPZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086569; c=relaxed/simple;
	bh=C+sxaHWdoQnuXwu4aDiuiJDjiNUG2v14M2Yveog+WBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JUiz63aFoCrKGThoWrUG7/zMtLTgRIuD8wj0w8YrMEhnC4WiE5oj9HRAOYzQTz3HCpRwaaW79W6sm6YO4Bq2kMjKV734UTC6Z1QN0aKl9giahiSmqHs8pBfjelvrvSSAb38qq9s3e+Vdd8FT2CMlUB1KvBRJVHyIBdKl7UO6twI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=89.58.27.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id B36DF8718;
	Tue,  2 Apr 2024 19:29:54 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Linux kernel regressions list <regressions@lists.linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Subject: 6.7.11: Fails to hibernate - work queues still busy
Date: Tue, 02 Apr 2024 21:29:50 +0200
Message-ID: <13486453.uLZWGnKmhe@lichtvoll.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thorsten, hi Greg,

6.7.9 + some bcachefs upgrade/downgrade fixes included in 6.7.11 works
okay. 6.7.11 fails. Two repeated attempts failed with a dmesg like this:

[  192.465064] r8169 0000:05:00.0 en1: Link is Down
[  193.246691] PM: hibernation: hibernation entry
[  193.622844] Filesystems sync: 0.097 seconds
[  193.623337] Freezing user space processes
[  193.627326] Freezing user space processes completed (elapsed 0.003 seconds)
[  193.627390] OOM killer disabled.
[  193.627889] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[  193.627933] PM: hibernation: Marking nosave pages: [mem 0x0009f000-0x000fffff]
[  193.627973] PM: hibernation: Marking nosave pages: [mem 0x09c00000-0x09d00fff]
[  193.628022] PM: hibernation: Marking nosave pages: [mem 0x09f00000-0x09f0ffff]
[  193.628063] PM: hibernation: Marking nosave pages: [mem 0xa22d1000-0xa22d1fff]
[  193.628099] PM: hibernation: Marking nosave pages: [mem 0xa22de000-0xa22dffff]
[  193.628135] PM: hibernation: Marking nosave pages: [mem 0xa22ed000-0xa22eefff]
[  193.628172] PM: hibernation: Marking nosave pages: [mem 0xa22ff000-0xa22fffff]
[  193.628210] PM: hibernation: Marking nosave pages: [mem 0xb9533000-0xb95c3fff]
[  193.628263] PM: hibernation: Marking nosave pages: [mem 0xbd9de000-0xcc3fdfff]
[  193.630011] PM: hibernation: Marking nosave pages: [mem 0xce000000-0xffffffff]
[  193.632545] PM: hibernation: Basic memory bitmaps created
[  193.639135] PM: hibernation: Preallocating image memory
[  195.755034] PM: hibernation: Allocated 2438707 pages for snapshot
[  195.755817] PM: hibernation: Allocated 9754828 kbytes in 2.11 seconds (4623.14 MB/s)
[  195.755842] Freezing remaining freezable tasks
[  215.764748] Freezing remaining freezable tasks failed after 20.009 seconds (0 tasks refusing to freeze, wq_busy=1):
[  215.764813] Showing freezable workqueues that are still busy:
[  215.764841] workqueue events_freezable: flags=0x4
[  215.764869]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=0 refcnt=2
[  215.764881]     inactive: pci_pme_list_scan
[  215.764895] workqueue usb_hub_wq: flags=0x4
[  215.764965]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=2 refcnt=3
[  215.764974]     in-flight: 350:hub_event [usbcore] hub_event [usbcore]
[  215.765212] Restarting kernel threads ... done.
[  216.244833] PM: hibernation: Basic memory bitmaps freed
[  216.245961] OOM killer enabled.
[  216.246377] Restarting tasks ... done.
[  216.250708] thermal thermal_zone0: failed to read out thermal zone (-61)
[  216.252313] PM: hibernation: hibernation exit
[  216.276601] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
[  216.871301] r8169 0000:02:00.0 en0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).
[  216.976901] r8169 0000:02:00.0 en0: Link is Down
[  217.003589] Generic FE-GE Realtek PHY r8169-0-500:00: attached PHY driver (mii_bus:phy_addr=r8169-0-500:00, irq=MAC)
[  217.169087] r8169 0000:05:00.0 en1: Link is Down
[  220.611547] r8169 0000:05:00.0 en1: Link is Up - 1Gbps/Full - flow control rx/tx

ThinkPad T14 Gen 1 with AMD Ryzen 4750U and 32 GiB of RAM.

Could that be related to the following issue?

* Hibernate stuck after recent kernel/workqueue.c changes in Stable 6.6.23
@ 2024-04-02  8:08 Linux regression tracking (Thorsten Leemhuis)

https://lore.kernel.org/regressions/ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info/T/#u

However I did not find above work queue related error messages in the
dmesg in the bug tracker bug report mentioned there:

https://bugzilla.kernel.org/show_bug.cgi?id=218658

If really needed I could do a bisect, but it would take a while until I
can take time to do it.

Best,
-- 
Martin



