Return-Path: <stable+bounces-110267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A41CA1A3EA
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB2B7A23A5
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 12:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF7520E70B;
	Thu, 23 Jan 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="g+JcKW5P"
X-Original-To: stable@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128120CCCF;
	Thu, 23 Jan 2025 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634176; cv=none; b=fYXlk8tODoKpx7ZO6LbyDzLZkvu9bhSrFMagB6ou1JbzIeft1iic6JbNiffOk2Bi0QMXr8gHEzXV+bLqiiuW+Zj8bMD8D4iXcGPNBRZBp2SxXnHqBUOCRVLcS++wMZCF5U3XbOION2bd1xE5/ZZQq2dCEZJRIXLeE9VsDuO9M4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634176; c=relaxed/simple;
	bh=1yagOzbCr1GRravRa4GsczpG7j9uj9NeB3VK3oK70U8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=anzcZCJ9sreoW7r3QtjPyEN80DDuWRZdGHN3/xX6YVXRhmPpznnG34L8845n/1M8Ni52fwirSX446Le9JeXrBl/uJFfsVJKTYEJvmKkhaGy/y9nP0xIXyEIqW+EVwBH1gtfdOt+qkEGT4vKE296WT7SCE6f6XlcyC8xd8BJ1Too=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=g+JcKW5P; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1373; q=dns/txt; s=iport;
  t=1737634174; x=1738843774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sHYqUzpVkt2xm/o6QBDiwfgv52ObOwHXyR6Gn28PiA4=;
  b=g+JcKW5PUr+eogk7zKJ8YD4Sko8Fo6Kfh3IlzihM8VPbUmaH9aiY267E
   n4SaTems2dGisK9AkU4BjVHrVFSiDbVKwFHcCl+pAN0Ykake2ki2eMlLV
   Gc0YROuYf8mf5l+9vZkzgVUXQOWUpBCro2RchBMXoaMoOWfGs4Gn5nF31
   M=;
X-CSE-ConnectionGUID: UAiUAA6YTaaWNi/iulwotg==
X-CSE-MsgGUID: ScdvSaPoRzihDFhIgVQTgA==
X-IPAS-Result: =?us-ascii?q?A0ALAAD+L5Jnj4z/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF/BgEBAQsBAYQZQkiMcpVIkiWBJQNWDwEBAQ9EBAEBhQeKdQImNAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwUUAQEBAQEBOQUOO4YIS?=
 =?us-ascii?q?QEMAQgBhX0rCwFGMFxEgwGCZQIBtSmBeTOBAd4zgW2BSAGNSVeFECcbgUlEg?=
 =?us-ascii?q?RWDaIN7gRWFdwSCL4FFMIM/oAlIgSEDWSwBVRMNCgsHBYFxAzgMCzAVgUl7g?=
 =?us-ascii?q?kdpSToCDQI1gh58giuEXoRFhFGFW4IUghSCNoMpQAMLGA1IESw3FBsGPm4Hn?=
 =?us-ascii?q?Bc8g3cBgQ1OgXKlcKEDhCWhRhozqlIBLphOoyuBHIRmgWc6gVtNIxWDIlIZD?=
 =?us-ascii?q?446xHYiNTwCBwsBAQMJjUCBOHuBbAEB?=
IronPort-Data: A9a23:1+i1XqLwDTGJISBDFE+RNpUlxSXFcZb7ZxGr2PjKsXjdYENShmQCx
 zAdXjiPP66MYDamfY0laISypk5VucTRztNhQVMd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrW0
 T/Oi5eHYgL9gmQvajl8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1TJUALFKRGy9p+CF5o9
 LsZNTQSaQyM0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBVrAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEyojx5nYj/7DLolhPqzhmH8ehVTqUmeouw85G27IAlZjOG9bYKEI4faLSlTtn2Tq
 nz99lz+OAMbNPCxyRuKzEuQicaayEsXX6pJSeXnraQ16LGJ/UQYCBwfVUCmqP//gU6jXd13I
 kkYvCEpqMAa+EWtT9T5GQK4rXOAswQ0Ut9cVeY97WmlyqPO+RffGWUCUjpIbtAOvco6Azct0
 zehm9LvGCwqs7CPT3+Z3qmboCn0OiUPK2IGIygeQmMt+MXqqoU+pgzAQ8wlE6OviNDxXzbqz
 Fi3QDMWnb4fi4sPkq68512C22nqrZnSRQlz7QLSNo640u9nTLOMZrGBwAbq0f9JE6CYCVicu
 GcDh8fLuYjiEqqxvCCKRewMGpSg6PCELCDQjDZT838JqW7FF5mLI9s43d1uGHqFJProbtMAX
 aMyhe+zzMINVJdJRfYmC25UNyjM5fO9fTgCfquEBueimrArKGe6ENhGPCZ8JVzFnkk2ir0YM
 pyGa8uqBntyIf04l2XqGbxBiuF7mn5WKYbvqXbTkkTPPV22OS/9dFv5GALQBgzExPre+VyLr
 4Y32zWikUQBD7SWjtbrHX47dg1SciNhWvgaWuRcd/WIJUJ9CXo9BvrKibIncMoNokimvrmgw
 51JYWcBkACXrSSecW2iMyk/AJuxBswXhSxgYkQR0aOAhyNLjXCHsPxHL8NfkHhO3LAL8MOYu
 NFVJp7QX6wUEmyvFvZ0RcCVkbGOvS+D3WqmVxdJqhBmF3K8b2QlIuPZQzY=
IronPort-HdrOrdr: A9a23:aZ9aJaEIXaAjzK/CpLqE48eALOsnbusQ8zAXPo5KJiC9Ffbo8v
 xG88576faZslsssRIb6LK90de7IU80nKQdieJ6AV7IZmfbUQWTQL2KlbGSoAEJ30bFh4lgPW
 AKSdkbNOHN
X-Talos-CUID: 9a23:wy2v+mM1+qKj3u5DZQBmyWc9RPEZe3Ti6naXIlK8FmF1R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AdD32YQ65YpSlPNkfh3pFEa/gxoxT6KiwM0k1lq8?=
 =?us-ascii?q?UusmoGyxRNAmksDueF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732579200"; 
   d="scan'208";a="418509138"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Jan 2025 12:08:24 +0000
Received: from sjc-ads-1396.cisco.com (sjc-ads-1396.cisco.com [171.70.59.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 0FB84180001EF;
	Thu, 23 Jan 2025 12:08:24 +0000 (GMT)
Received: by sjc-ads-1396.cisco.com (Postfix, from userid 1839047)
	id 91048CC128E; Thu, 23 Jan 2025 04:08:23 -0800 (PST)
From: Shubham Pushpkar <spushpka@cisco.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	deeratho@cisco.com,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Shubham Pushpkar <spushpka@cisco.com>
Subject: [PATCH] drm/amd/display: Check link_index before accessing dc->links[]
Date: Thu, 23 Jan 2025 04:08:22 -0800
Message-Id: <20250123120822.1983325-1-spushpka@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 171.70.59.88, sjc-ads-1396.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com

From: Alex Hung <alex.hung@amd.com>

commit 8aa2864044b9d13e95fe224f32e808afbf79ecdf ("drm/amd/display:
Check link_index before accessing dc->links[]")

[WHY & HOW]
dc->links[] has max size of MAX_LINKS and NULL is return when trying to
access with out-of-bound index.

This fixes 3 OVERRUN and 1 RESOURCE_LEAK issues reported by Coverity.

Fixes: CVE-2024-46813
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8aa2864044b9d13e95fe224f32e808afbf79ecdf)
Signed-off-by: Shubham Pushpkar <spushpka@cisco.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index f365773d5714..b5639e88c581 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -37,6 +37,9 @@
 #include "dce/dce_i2c.h"
 struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_index)
 {
+	if (link_index >= MAX_LINKS)
+		return NULL;
+
 	return dc->links[link_index];
 }
 
-- 
2.35.6


