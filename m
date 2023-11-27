Return-Path: <stable+bounces-2803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA87FAA7D
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260CE1C20C41
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BA23FB39;
	Mon, 27 Nov 2023 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IfG2fEZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F809170B;
	Mon, 27 Nov 2023 11:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701113917; x=1732649917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4O/H8hZxUEAevN+ZrA3EKQUKcMfxg0sA4Wnf7tueTHI=;
  b=IfG2fEZS7hmGsN1mC6yRkdAx1Zu5GQenr779HrV1eb+CivUtEua+dBSK
   Fgvv2WmIqLnAsSdDbRyHklASpQPW9s2CS+YeM+gw9Hw1kTrE0r6qtImnn
   BcMrrhxb1Q70rOSDOXapsfADgLRNYlZU8iMIHD3RtzEQNrIPgKGXQrQ7Z
   k=;
X-IronPort-AV: E=Sophos;i="6.04,231,1695686400"; 
   d="scan'208";a="379093772"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:38:32 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 40C7BC1808;
	Mon, 27 Nov 2023 19:38:31 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:18477]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.47.241:2525] with esmtp (Farcaster)
 id 34c62af7-a95a-44cd-a237-865a88738a8d; Mon, 27 Nov 2023 19:38:30 +0000 (UTC)
X-Farcaster-Flow-ID: 34c62af7-a95a-44cd-a237-865a88738a8d
Received: from EX19D043EUC001.ant.amazon.com (10.252.61.155) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 27 Nov 2023 19:38:29 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D043EUC001.ant.amazon.com (10.252.61.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 27 Nov 2023 19:38:29 +0000
Received: from dev-dsk-hagarhem-1b-81bb22e5.eu-west-1.amazon.com
 (172.19.65.226) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1118.39 via Frontend Transport; Mon, 27 Nov 2023 19:38:29
 +0000
Received: by dev-dsk-hagarhem-1b-81bb22e5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 8FB3B88FB; Mon, 27 Nov 2023 19:38:28 +0000 (UTC)
From: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Hagar Gamal Halim Hemdan <hagarhem@amazon.com>,
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, "VMware
 PV-Drivers Reviewers" <pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov
	<dtor@vmware.com>, George Zhang <georgezhang@vmware.com>, Andy king
	<acking@vmware.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vmci: prevent speculation leaks by sanitizing event in event_deliver()
Date: Mon, 27 Nov 2023 19:35:33 +0000
Message-ID: <20231127193533.46174-1-hagarhem@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Coverity spotted that event_msg is controlled by user-space,
event_msg->event_data.event is passed to event_deliver() and used
as an index without sanitization.

This change ensures that the event index is sanitized to mitigate any
possibility of speculative information leaks.

Fixes: 1d990201f9bb ("VMCI: event handling implementation.")

Signed-off-by: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
---
 drivers/misc/vmw_vmci/vmci_event.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index 5d7ac07623c2..9a41ab65378d 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -9,6 +9,7 @@
 #include <linux/vmw_vmci_api.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
@@ -86,9 +87,12 @@ static void event_deliver(struct vmci_event_msg *event_msg)
 {
 	struct vmci_subscription *cur;
 	struct list_head *subscriber_list;
+	u32 sanitized_event, max_vmci_event;
 
 	rcu_read_lock();
-	subscriber_list = &subscriber_array[event_msg->event_data.event];
+	max_vmci_event = ARRAY_SIZE(subscriber_array);
+	sanitized_event = array_index_nospec(event_msg->event_data.event, max_vmci_event);
+	subscriber_list = &subscriber_array[sanitized_event];
 	list_for_each_entry_rcu(cur, subscriber_list, node) {
 		cur->callback(cur->id, &event_msg->event_data,
 			      cur->callback_data);
-- 
2.40.1


