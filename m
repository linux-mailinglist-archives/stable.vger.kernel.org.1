Return-Path: <stable+bounces-2795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557447FA903
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E92FB21010
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC3E1D697;
	Mon, 27 Nov 2023 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="E1tw0ayI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3A5A1
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 10:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701110286; x=1732646286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cuyYMQ2z3BW+g+ydRxPO7a62zsIRTL+NBe1b3AT5EKg=;
  b=E1tw0ayIiXUbNILPjTvfPGlGizQ90buubYHEJTUDsWomNR+O/WRyKpsv
   RYEs2wwJAj05JArAs6E+50xZumcX7X+/SsaHvWTbKdovgs+h1g3g/rsgM
   ozeuhZ70M8YelkvCYqlIQI6Q3pBj4hyqziPeEuEsBO98HLinfZTVohi2D
   c=;
X-IronPort-AV: E=Sophos;i="6.04,231,1695686400"; 
   d="scan'208";a="255152207"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 18:37:50 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id 5388560D39
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 18:37:49 +0000 (UTC)
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:2921]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.55:2525] with esmtp (Farcaster)
 id b8ad156e-5861-4487-9b6f-65aa65c201ae; Mon, 27 Nov 2023 18:37:48 +0000 (UTC)
X-Farcaster-Flow-ID: b8ad156e-5861-4487-9b6f-65aa65c201ae
Received: from EX19D043EUB004.ant.amazon.com (10.252.61.123) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 27 Nov 2023 18:37:46 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D043EUB004.ant.amazon.com (10.252.61.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 27 Nov 2023 18:37:45 +0000
Received: from dev-dsk-hagarhem-1b-81bb22e5.eu-west-1.amazon.com
 (172.19.65.226) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.39 via Frontend Transport; Mon, 27 Nov 2023 18:37:45
 +0000
Received: by dev-dsk-hagarhem-1b-81bb22e5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 6B09588F9; Mon, 27 Nov 2023 18:37:45 +0000 (UTC)
From: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
To:
CC: <stable@vger.kernel.org>
Subject: [PATCH] vmci: prevent speculation leaks by sanitizing event in event_deliver()
Date: Mon, 27 Nov 2023 18:37:45 +0000
Message-ID: <20231127183745.94955-1-hagarhem@amazon.com>
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

Fixes: 1d990201f9bb ("VMCI: event handling implementation")

Signed-off-by: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
---
 drivers/misc/vmw_vmci/vmci_event.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index 2100297c94ad..a1205bce0b7e 100644
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


