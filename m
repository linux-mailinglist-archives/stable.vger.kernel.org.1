Return-Path: <stable+bounces-1809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E7D7F8175
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EE828269C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EFC321AD;
	Fri, 24 Nov 2023 18:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gd+EXDsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770122E64F;
	Fri, 24 Nov 2023 18:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071DDC433C8;
	Fri, 24 Nov 2023 18:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852325;
	bh=4qefQexLw75OrvH/W1hj2YamxTY91bb01WINdSay20k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gd+EXDsXJBTtnmJGbtQvvnxhhg5tXCKdKAw7ChL4oBqnzI4dyhI69mo9tMS9bw2Y9
	 wjcFzOzdBGhjpWIQcCug9W91cracrcGu5TP3z1Nb9b4MohrWLv2OR1rCp9/eMh9U4z
	 P7VD3HmluaGftT4v/hQaUkG12DUYtpzxy73Z8d/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Holger Dengler <dengler@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.1 311/372] s390/ap: fix AP bus crash on early config change callback invocation
Date: Fri, 24 Nov 2023 17:51:38 +0000
Message-ID: <20231124172020.771434247@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

commit e14aec23025eeb1f2159ba34dbc1458467c4c347 upstream.

Fix kernel crash in AP bus code caused by very early invocation of the
config change callback function via SCLP.

After a fresh IML of the machine the crypto cards are still offline and
will get switched online only with activation of any LPAR which has the
card in it's configuration. A crypto card coming online is reported
to the LPAR via SCLP and the AP bus offers a callback function to get
this kind of information. However, it may happen that the callback is
invoked before the AP bus init function is complete. As the callback
triggers a synchronous AP bus scan, the scan may already run but some
internal states are not initialized by the AP bus init function resulting
in a crash like this:

  [   11.635859] Unable to handle kernel pointer dereference in virtual kernel address space
  [   11.635861] Failing address: 0000000000000000 TEID: 0000000000000887
  [   11.635862] Fault in home space mode while using kernel ASCE.
  [   11.635864] AS:00000000894c4007 R3:00000001fece8007 S:00000001fece7800 P:000000000000013d
  [   11.635879] Oops: 0004 ilc:1 [#1] SMP
  [   11.635882] Modules linked in:
  [   11.635884] CPU: 5 PID: 42 Comm: kworker/5:0 Not tainted 6.6.0-rc3-00003-g4dbf7cdc6b42 #12
  [   11.635886] Hardware name: IBM 3931 A01 751 (LPAR)
  [   11.635887] Workqueue: events_long ap_scan_bus
  [   11.635891] Krnl PSW : 0704c00180000000 0000000000000000 (0x0)
  [   11.635895]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
  [   11.635897] Krnl GPRS: 0000000001000a00 0000000000000000 0000000000000006 0000000089591940
  [   11.635899]            0000000080000000 0000000000000a00 0000000000000000 0000000000000000
  [   11.635901]            0000000081870c00 0000000089591000 000000008834e4e2 0000000002625a00
  [   11.635903]            0000000081734200 0000038000913c18 000000008834c6d6 0000038000913ac8
  [   11.635906] Krnl Code:>0000000000000000: 0000                illegal
  [   11.635906]            0000000000000002: 0000                illegal
  [   11.635906]            0000000000000004: 0000                illegal
  [   11.635906]            0000000000000006: 0000                illegal
  [   11.635906]            0000000000000008: 0000                illegal
  [   11.635906]            000000000000000a: 0000                illegal
  [   11.635906]            000000000000000c: 0000                illegal
  [   11.635906]            000000000000000e: 0000                illegal
  [   11.635915] Call Trace:
  [   11.635916]  [<0000000000000000>] 0x0
  [   11.635918]  [<000000008834e4e2>] ap_queue_init_state+0x82/0xb8
  [   11.635921]  [<000000008834ba1c>] ap_scan_domains+0x6fc/0x740
  [   11.635923]  [<000000008834c092>] ap_scan_adapter+0x632/0x8b0
  [   11.635925]  [<000000008834c3e4>] ap_scan_bus+0xd4/0x288
  [   11.635927]  [<00000000879a33ba>] process_one_work+0x19a/0x410
  [   11.635930] Discipline DIAG cannot be used without z/VM
  [   11.635930]  [<00000000879a3a2c>] worker_thread+0x3fc/0x560
  [   11.635933]  [<00000000879aea60>] kthread+0x120/0x128
  [   11.635936]  [<000000008792afa4>] __ret_from_fork+0x3c/0x58
  [   11.635938]  [<00000000885ebe62>] ret_from_fork+0xa/0x30
  [   11.635942] Last Breaking-Event-Address:
  [   11.635942]  [<000000008834c6d4>] ap_wait+0xcc/0x148

This patch improves the ap_bus_force_rescan() function which is
invoked by the config change callback by checking if a first
initial AP bus scan has been done. If not, the force rescan request
is simple ignored. Anyhow it does not make sense to trigger AP bus
re-scans even before the very first bus scan is complete.

Cc: stable@vger.kernel.org
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/ap_bus.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1012,6 +1012,10 @@ EXPORT_SYMBOL(ap_driver_unregister);
 
 void ap_bus_force_rescan(void)
 {
+	/* Only trigger AP bus scans after the initial scan is done */
+	if (atomic64_read(&ap_scan_bus_count) <= 0)
+		return;
+
 	/* processing a asynchronous bus rescan */
 	del_timer(&ap_config_timer);
 	queue_work(system_long_wq, &ap_scan_work);



