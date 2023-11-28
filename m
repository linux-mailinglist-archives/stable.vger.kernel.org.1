Return-Path: <stable+bounces-2876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5AA7FB535
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 10:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B58D1C210AA
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6A8374D8;
	Tue, 28 Nov 2023 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ipuF873A"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805511B6;
	Tue, 28 Nov 2023 01:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701162440; x=1732698440;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z1TW0Hfw0huACu3MYZumgUWnW7GOEILz6vqy+fXSiuE=;
  b=ipuF873A6fjc1Cd9SolAyWqs/vKndQA+9pFXn5cwOQy7CCNw72z6lgmd
   Gj1aiNUs1E3T+DAjCEf2MWbibN7NcJB4sB+iycEAgSvWw3e0JF1BQd0kE
   VFmAXNldSPq0HGcivVP/Q02k6j09N2lp+aXMznodrmR1azSegqaZs2ozz
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,233,1695686400"; 
   d="scan'208";a="686862827"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 09:07:14 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id 5414F68209;
	Tue, 28 Nov 2023 09:07:11 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:58411]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.35:2525] with esmtp (Farcaster)
 id 2c7e7e41-2e49-48f3-9887-6580cefdb379; Tue, 28 Nov 2023 09:07:10 +0000 (UTC)
X-Farcaster-Flow-ID: 2c7e7e41-2e49-48f3-9887-6580cefdb379
Received: from EX19D008EUA003.ant.amazon.com (10.252.50.155) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 28 Nov 2023 09:07:09 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008EUA003.ant.amazon.com (10.252.50.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 28 Nov 2023 09:07:09 +0000
Received: from dev-dsk-hagarhem-1b-81bb22e5.eu-west-1.amazon.com
 (172.19.65.226) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server id 15.2.1118.39 via Frontend Transport; Tue, 28 Nov 2023 09:07:09
 +0000
Received: by dev-dsk-hagarhem-1b-81bb22e5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id EB76D5BCC; Tue, 28 Nov 2023 09:07:08 +0000 (UTC)
From: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
To:
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Hagar Gamal Halim Hemdan <hagarhem@amazon.com>, <stable@vger.kernel.org>,
	Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>, "VMware
 PV-Drivers Reviewers" <pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov
	<dtor@vmware.com>, George Zhang <georgezhang@vmware.com>, Andy king
	<acking@vmware.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] vmci: prevent speculation leaks by sanitizing event in event_deliver()
Date: Tue, 28 Nov 2023 09:06:46 +0000
Message-ID: <20231128090647.49863-1-hagarhem@amazon.com>
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
v3: added cc stable tag to the commit message as requested by kernel
test robot.

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


