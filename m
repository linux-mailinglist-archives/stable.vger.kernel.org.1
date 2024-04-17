Return-Path: <stable+bounces-40075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A08A7D67
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 09:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4313AB21EAC
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BC0745C5;
	Wed, 17 Apr 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eKhPh5nv"
X-Original-To: stable@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22FD7173A;
	Wed, 17 Apr 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340269; cv=none; b=DmWWBqAGptHGUumth4eQHyja+0EDeYNWqcgK7cu1ebzHizCCtdgviAnQO70/k6aBbwDGQhKJ+1zBxlCoTQkDn8q7FJJ6RecooigSWHmwhPVkaFUy6RyX3n15IgLIhCIYDmfL+kB+FpjFrl+ZqFjlGiGeTbKkOg2RKJN5JO2koL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340269; c=relaxed/simple;
	bh=nkHXoxrUC6y6rXyp3n2yBLub76g+yVRVU0sB8x34LCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trAWfDQQYV6CVtMRf2QR5AAnZM8KnJxN/ZDyeBsRYqc8EX6kwBdU09nnrbHUhCd71VUXUMXyQlJY5hcYGOS1J+uVh39GYFp8gu5VCzRz0ePQwli9Do+XF4MOxJiJnerS1bAtB2bJ1M5YkhGDTKqROI6Qfhi7V6LyymDB4beKjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eKhPh5nv; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713340267; x=1744876267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nkHXoxrUC6y6rXyp3n2yBLub76g+yVRVU0sB8x34LCc=;
  b=eKhPh5nvtWPGFBzrANTr93lci/cw1PLYB/gX0LN1Vgm/osV1GQjaJwIu
   JBVvGV7NG+iglIuPVyZEgFbs48zZPUlul1ziSI0F+qrHVwJbsxqBC6XF0
   UpGM+TGCb939VM/oYyNDjIeI02+E4QfkC37qOQKNcnmuJgevou5MuaZJB
   1d3Tr/s6kt6a37UYKppPmLATwqG9Aye/QNU8To63YBefTMcDuEYT1gL56
   dg1/t+iClIt9VjxVBV23rHprPndmmfrsS1mgJv4diiZOCmgC4uSWXgQhO
   Ma1R52KRfzwuQLAXdV5qZbRuglKQiibZWE9ChK+1H+hIFkjpC2yMBp430
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="157776076"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; 
   d="scan'208";a="157776076"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 16:50:58 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id E216715FA8;
	Wed, 17 Apr 2024 16:50:55 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2436E4E653;
	Wed, 17 Apr 2024 16:50:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 948502288CF;
	Wed, 17 Apr 2024 16:50:54 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id EF3991A000C;
	Wed, 17 Apr 2024 15:50:53 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] cxl/core: correct length of DPA field masks
Date: Wed, 17 Apr 2024 15:50:52 +0800
Message-Id: <20240417075053.3273543-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28326.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28326.006
X-TMASE-Result: 10-1.936900-10.000000
X-TMASE-MatchedRID: Z72PYcQfb3Po4fT4WEihVSQWufwDJ4K9T5ysQDj6eFnIPbn2oQhptW4j
	6HJSTgstiC69Gex0rT0XkIT0cenSu+BRuAss+FbmEXjPIvKd74BUENBIMyKD0ceQfu6iwSfsePr
	7SQbqKPDi8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSmcfuxsiY4QFJp+Fkm0Yph4NSGlnU1tfkqmmA
	tzdYh7Px/SCJhYcntdSNllVVIjtxumPccZWwKt1wdD9AYG5JbSTGKjvF046qOjDGFJqjnwwJsNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The length of Physical Address in General Media Event Record/DRAM Event
Record is 64-bit, so the field mask should be defined as such length.
Otherwise, this causes cxl_general_media and cxl_dram tracepoints to
mask off the upper-32-bits of DPA addresses. The cxl_poison event is
unaffected.

If userspace was doing its own DPA-to-HPA translation this could lead to
incorrect page retirement decisions, but there is no known consumer
(like rasdaemon) of this event today.

Fixes: d54a531a430b ("cxl/mem: Trace General Media Event Record")
Cc: <stable@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e5f13260fc52..cdfce932d5b1 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -253,7 +253,7 @@ TRACE_EVENT(cxl_generic_event,
  * DRAM Event Record
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
  */
-#define CXL_DPA_FLAGS_MASK			0x3F
+#define CXL_DPA_FLAGS_MASK			0x3FULL
 #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
 
 #define CXL_DPA_VOLATILE			BIT(0)
-- 
2.34.1


