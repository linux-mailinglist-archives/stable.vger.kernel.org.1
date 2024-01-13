Return-Path: <stable+bounces-10615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A716682C87D
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 01:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED830B23EE6
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 00:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE4CF503;
	Sat, 13 Jan 2024 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mjIoRTX1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0310797
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705107332; x=1736643332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=agsLXchAQ2QVAKnUpd3j0QPlc5+iFPD1UdzFYRgZdaU=;
  b=mjIoRTX1P8XwSd+nnIJEXQBrAJJEKcKjIaLegS/l5u7NSJBnGbF+D/dN
   HgDB70vhHcwfGI/oiQhgL+T24haEQ+zjoNX/6PrTe6Aa4e/Di72OAKOIA
   yc+yY3yS4OTRU1oF5wX2nnRxOGtQwpZqF4nMQJLlT6tVsXR5zmlxZhSfN
   g=;
X-IronPort-AV: E=Sophos;i="6.04,191,1695686400"; 
   d="scan'208";a="389545044"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 00:55:31 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-47cc8a4c.us-east-1.amazon.com (Postfix) with ESMTPS id 92D1F1607FC;
	Sat, 13 Jan 2024 00:55:29 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:62764]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.220:2525] with esmtp (Farcaster)
 id 1fa0be87-add7-46dd-8961-feee4852bc91; Sat, 13 Jan 2024 00:55:29 +0000 (UTC)
X-Farcaster-Flow-ID: 1fa0be87-add7-46dd-8961-feee4852bc91
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 13 Jan 2024 00:55:28 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.187.171.38) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 13 Jan 2024 00:55:27 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <trawets@amazon.com>, <security@kernel.org>,
	Peter Oskolkov <posk@google.com>, "David S . Miller" <davem@davemloft.net>,
	Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH stable 4.19.x 1/4] net: add a route cache full diagnostic message
Date: Fri, 12 Jan 2024 16:53:05 -0800
Message-ID: <20240113005308.2422331-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024011155-gruffly-chunk-e186@gregkh>
References: <2024011155-gruffly-chunk-e186@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)

From: Peter Oskolkov <posk@google.com>

commit 22c2ad616b74f3de2256b242572ab449d031d941 upstream.

In some testing scenarios, dst/route cache can fill up so quickly
that even an explicit GC call occasionally fails to clean it up. This leads
to sporadically failing calls to dst_alloc and "network unreachable" errors
to the user, which is confusing.

This patch adds a diagnostic message to make the cause of the failure
easier to determine.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: <stable@vger.kernel.org> # 4.19.x
---
 net/core/dst.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index 81ccf20e2826..a263309df115 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -98,8 +98,12 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 	struct dst_entry *dst;
 
 	if (ops->gc && dst_entries_get_fast(ops) > ops->gc_thresh) {
-		if (ops->gc(ops))
+		if (ops->gc(ops)) {
+			printk_ratelimited(KERN_NOTICE "Route cache is full: "
+					   "consider increasing sysctl "
+					   "net.ipv[4|6].route.max_size.\n");
 			return NULL;
+		}
 	}
 
 	dst = kmem_cache_alloc(ops->kmem_cachep, GFP_ATOMIC);
-- 
2.34.1


