Return-Path: <stable+bounces-184819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63278BD450D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252E63E4CFB
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A3B308F3C;
	Mon, 13 Oct 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+TAx2xJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBD26B742;
	Mon, 13 Oct 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368526; cv=none; b=Iiqj1BJ3KBDtoID5W/ew86I5G3br/vU5F+DOa5cZg08a6i7Owuy6EO9LYNRxpnxgLu5l8EctRoqUjErFHz1NhNDkvmaiK6kUmUjz1CLu74ZSw2eZD4Y+nrA8auO1WDPE+Z1ONDjDR0kDClRqRB5+RUQQIEuAsYFt61HAXmxwp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368526; c=relaxed/simple;
	bh=AMVyQutS7QSzpKmR9DMAkB9C2h7po5CZV1VsnOdK0V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/JkSr8vQ3C9Gj0Br2xRCn50pdigaBnAeAB+yPye5Ff5ly1sjFLyJ7vY8sEXYpUzoS8LQl+3M3Rt7d7msTrALHVcDoZuSifKIWoXZq595ClFtnWel7wSDV6kK7gkknY7JzeBLyL7nexpTBjHKyoyonLAikuFAM9avBQxp1DuCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+TAx2xJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFBFC4CEFE;
	Mon, 13 Oct 2025 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368525;
	bh=AMVyQutS7QSzpKmR9DMAkB9C2h7po5CZV1VsnOdK0V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+TAx2xJjNkdfL5Mins9m1kM1Yj5Sl6WDEPHlS+XdqcFujN1K39+DWW9kuPzw8lM2
	 SGh5J+anCotKoJKFwXPdtiMZWsmf0CCR8edR9fp84sF8DwppG+Lr73l8dgIyPZ+QFR
	 f8rh7wTzcTaR6nBfeeAy3CWaq4jiCD+DYmt/MW6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 192/262] scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()
Date: Mon, 13 Oct 2025 16:45:34 +0200
Message-ID: <20251013144333.163754472@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ranjan Kumar <ranjan.kumar@broadcom.com>

[ Upstream commit 1703fe4f8ae50d1fb6449854e1fcaed1053e3a14 ]

During mpt3sas_transport_port_remove(), messages were logged with
dev_printk() against &mpt3sas_port->port->dev. At this point the SAS
transport device may already be partially unregistered or freed, leading
to a crash when accessing its struct device.

Using ioc_info(), which logs via the PCI device (ioc->pdev->dev),
guaranteed to remain valid until driver removal.

[83428.295776] Oops: general protection fault, probably for non-canonical address 0x6f702f323a33312d: 0000 [#1] SMP NOPTI
[83428.295785] CPU: 145 UID: 0 PID: 113296 Comm: rmmod Kdump: loaded Tainted: G           OE       6.16.0-rc1+ #1 PREEMPT(voluntary)
[83428.295792] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[83428.295795] Hardware name: Dell Inc. Precision 7875 Tower/, BIOS 89.1.67 02/23/2024
[83428.295799] RIP: 0010:__dev_printk+0x1f/0x70
[83428.295805] Code: 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 49 89 d1 48 85 f6 74 52 4c 8b 46 50 4d 85 c0 74 1f 48 8b 46 68 48 85 c0 74 22 <48> 8b 08 0f b6 7f 01 48 c7 c2 db e8 42 ad 83 ef 30 e9 7b f8 ff ff
[83428.295813] RSP: 0018:ff85aeafc3137bb0 EFLAGS: 00010206
[83428.295817] RAX: 6f702f323a33312d RBX: ff4290ee81292860 RCX: 5000cca25103be32
[83428.295820] RDX: ff85aeafc3137bb8 RSI: ff4290eeb1966c00 RDI: ffffffffc1560845
[83428.295823] RBP: ff85aeafc3137c18 R08: 74726f702f303a33 R09: ff85aeafc3137bb8
[83428.295826] R10: ff85aeafc3137b18 R11: ff4290f5bd60fe68 R12: ff4290ee81290000
[83428.295830] R13: ff4290ee6e345de0 R14: ff4290ee81290000 R15: ff4290ee6e345e30
[83428.295833] FS:  00007fd9472a6740(0000) GS:ff4290f5ce96b000(0000) knlGS:0000000000000000
[83428.295837] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[83428.295840] CR2: 00007f242b4db238 CR3: 00000002372b8006 CR4: 0000000000771ef0
[83428.295844] PKRU: 55555554
[83428.295846] Call Trace:
[83428.295848]  <TASK>
[83428.295850]  _dev_printk+0x5c/0x80
[83428.295857]  ? srso_alias_return_thunk+0x5/0xfbef5
[83428.295863]  mpt3sas_transport_port_remove+0x1c7/0x420 [mpt3sas]
[83428.295882]  _scsih_remove_device+0x21b/0x280 [mpt3sas]
[83428.295894]  ? _scsih_expander_node_remove+0x108/0x140 [mpt3sas]
[83428.295906]  ? srso_alias_return_thunk+0x5/0xfbef5
[83428.295910]  mpt3sas_device_remove_by_sas_address.part.0+0x8f/0x110 [mpt3sas]
[83428.295921]  _scsih_expander_node_remove+0x129/0x140 [mpt3sas]
[83428.295933]  _scsih_expander_node_remove+0x6a/0x140 [mpt3sas]
[83428.295944]  scsih_remove+0x3f0/0x4a0 [mpt3sas]
[83428.295957]  pci_device_remove+0x3b/0xb0
[83428.295962]  device_release_driver_internal+0x193/0x200
[83428.295968]  driver_detach+0x44/0x90
[83428.295971]  bus_remove_driver+0x69/0xf0
[83428.295975]  pci_unregister_driver+0x2a/0xb0
[83428.295979]  _mpt3sas_exit+0x1f/0x300 [mpt3sas]
[83428.295991]  __do_sys_delete_module.constprop.0+0x174/0x310
[83428.295997]  ? srso_alias_return_thunk+0x5/0xfbef5
[83428.296000]  ? __x64_sys_getdents64+0x9a/0x110
[83428.296005]  ? srso_alias_return_thunk+0x5/0xfbef5
[83428.296009]  ? syscall_trace_enter+0xf6/0x1b0
[83428.296014]  do_syscall_64+0x7b/0x2c0
[83428.296019]  ? srso_alias_return_thunk+0x5/0xfbef5
[83428.296023]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: f92363d12359 ("[SCSI] mpt3sas: add new driver supporting 12GB SAS")
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index d84413b77d849..421db8996927b 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -987,11 +987,9 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
 	list_for_each_entry_safe(mpt3sas_phy, next_phy,
 	    &mpt3sas_port->phy_list, port_siblings) {
 		if ((ioc->logging_level & MPT_DEBUG_TRANSPORT))
-			dev_printk(KERN_INFO, &mpt3sas_port->port->dev,
-			    "remove: sas_addr(0x%016llx), phy(%d)\n",
-			    (unsigned long long)
-			    mpt3sas_port->remote_identify.sas_address,
-			    mpt3sas_phy->phy_id);
+			ioc_info(ioc, "remove: sas_addr(0x%016llx), phy(%d)\n",
+				(unsigned long long) mpt3sas_port->remote_identify.sas_address,
+					mpt3sas_phy->phy_id);
 		mpt3sas_phy->phy_belongs_to_port = 0;
 		if (!ioc->remove_host)
 			sas_port_delete_phy(mpt3sas_port->port,
-- 
2.51.0




