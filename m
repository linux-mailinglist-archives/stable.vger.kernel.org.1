Return-Path: <stable+bounces-2805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA227FAA90
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A5D2819B5
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E43FE5E;
	Mon, 27 Nov 2023 19:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fQA9mq+M"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70214B8;
	Mon, 27 Nov 2023 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701114510; x=1732650510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dzJq7ZS6+MalTytYoBY1Oc9I5uKD7F8atHWY0xkMgew=;
  b=fQA9mq+MsGoy7uSE4udHth6uIbuUu4RbTFzbn5Lhl7Z5r1UNJgldmjsS
   EzH0FT+AmqPFAC2P47mUKTBx25qIJJsaDC4x9kdTCTje3V2jDQYZDHW+R
   Hcg4r+m/byIou9JhsqsrZceYaULSfzLRfSEiaq0QFLDwfV5AymklBxRmf
   M=;
X-IronPort-AV: E=Sophos;i="6.04,231,1695686400"; 
   d="scan'208";a="621904629"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:48:27 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id C5E4E40D40;
	Mon, 27 Nov 2023 19:48:24 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:24343]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.218:2525] with esmtp (Farcaster)
 id e9d39be2-78bd-4c61-ab28-987d6bc93359; Mon, 27 Nov 2023 19:48:23 +0000 (UTC)
X-Farcaster-Flow-ID: e9d39be2-78bd-4c61-ab28-987d6bc93359
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 27 Nov 2023 19:48:22 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 27 Nov 2023 19:48:22 +0000
Received: from dev-dsk-hagarhem-1b-81bb22e5.eu-west-1.amazon.com
 (172.19.65.226) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.39 via Frontend Transport; Mon, 27 Nov 2023 19:48:21
 +0000
Received: by dev-dsk-hagarhem-1b-81bb22e5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 9DEDB2A1D; Mon, 27 Nov 2023 19:48:20 +0000 (UTC)
From: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>, Hagar Gamal Halim Hemdan <hagarhem@amazon.com>,
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, "VMware
 PV-Drivers Reviewers" <pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov
	<dtor@vmware.com>, George Zhang <georgezhang@vmware.com>, Andy king
	<acking@vmware.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] vmci: prevent speculation leaks by sanitizing event in event_deliver()
Date: Mon, 27 Nov 2023 19:48:17 +0000
Message-ID: <20231127194817.57209-1-hagarhem@amazon.com>
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
Cc: stable@vger.kernel.org
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


