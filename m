Return-Path: <stable+bounces-33120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B238913DA
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 07:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C0B1C23B7E
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07AA224C9;
	Fri, 29 Mar 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WnPpWSfB"
X-Original-To: stable@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4633BB20;
	Fri, 29 Mar 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694253; cv=none; b=TLDtluwW/IVZPqcdjBop8gquOuTRjArJKabCIwrkVF+6KAzvnX3sDqQF4t73lYWxXsxDoNgYXwUghopk9hjKtyhOnaCV7OoOf7hc2Wf8InS94i50+3talX/B3MxXHFRXvOosQtel9mx08qge1dLfYVBGV2RVofrNLxGEf1AiSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694253; c=relaxed/simple;
	bh=eaTURs2DX3hFrascB0JmgCheHmdrmF0RLNDE+Or7F2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QNTDiocbIdyTUBleiml8aJ7QFOST9myPo7u9q/dxV446HKX8Y1I+xug+oObnI3WlqbOPGHkfxBdyyN9RVdYGkSZlATHTd6LhNiAbOTLyCMTXL76U0gwwvfdERBbyE0seddRk38Yx2X3AB0GUOafdxSsoU2oV12DfFjwvpBDOM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WnPpWSfB; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711694251; x=1743230251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eaTURs2DX3hFrascB0JmgCheHmdrmF0RLNDE+Or7F2I=;
  b=WnPpWSfB+nDinQ74Roq2uUQGzPg68f87JSOCOUylWknn5smSnul//wcl
   8jOTIKROUr3BmjsvOVI38dU/ewX9q9r1BSZT20uTxmSV+4Lc32XTYawEw
   eAwCpN2UDfubE7xgOy5GZMw1kA7KPI37VEqI68yWxUnKawUH8DY2PsPmZ
   0XDtdx8jH5HV0Xa2YYomQeL6pyan12SnExvrn8UCHnvBbLVBsOvN3WZ+7
   wufz4Vj7QyON1cUciqWokKGF0vB2n+31cYw8v3OSr6QO+6u80KCyJEFrR
   yYmQfo8l9wKS4bbHchokzuS1N1QtybZEzHYCjoWHTa9k7mtE+tYmVd05E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="132533101"
X-IronPort-AV: E=Sophos;i="6.07,164,1708354800"; 
   d="scan'208";a="132533101"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 15:36:18 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 01556E9668;
	Fri, 29 Mar 2024 15:36:17 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 34FEA12F761;
	Fri, 29 Mar 2024 15:36:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BC9362288EE;
	Fri, 29 Mar 2024 15:36:15 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 378B31A006D;
	Fri, 29 Mar 2024 14:36:15 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave@stgolabs.net,
	ira.weiny@intel.com,
	stable@vger.kernel.org
Subject: [RFC PATCH v2 1/6] cxl/core: correct length of DPA field masks
Date: Fri, 29 Mar 2024 14:36:09 +0800
Message-Id: <20240329063614.362763-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28282.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28282.003
X-TMASE-Result: 10-1.936900-10.000000
X-TMASE-MatchedRID: 6KVfooacCZzo4fT4WEihVSQWufwDJ4K9T5ysQDj6eFnIPbn2oQhptW4j
	6HJSTgstiC69Gex0rT0XkIT0cenSu+BRuAss+FbmEXjPIvKd74BUENBIMyKD0ceQfu6iwSfsePr
	7SQbqKPDi8zVgXoAltsIJ+4gwXrEtJ0RPnyOnrZINUgM7QdTcfXGwKxjdKzHf8Yi1jddtlC4HZ7
	7a2hmTYf2ng54tmDQpuA2+Y9lsxTCcrrRiTSKATNx+1ANNyC8exuBs026550TAYLx7rnbR8rDQ8
	m3TqgloelpCXnG+JjvDGBZ1G8r1Sf2D6gx/0ozp
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
 drivers/cxl/core/trace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e5f13260fc52..e2d1f296df97 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
  * DRAM Event Record
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
  */
-#define CXL_DPA_FLAGS_MASK			0x3F
+#define CXL_DPA_FLAGS_MASK			0x3FULL
 #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
 
-#define CXL_DPA_VOLATILE			BIT(0)
-#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
+#define CXL_DPA_VOLATILE			BIT_ULL(0)
+#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
 #define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
 	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
 	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
-- 
2.34.1


