Return-Path: <stable+bounces-1814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B797F817B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303EB1C216AD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57D35F04;
	Fri, 24 Nov 2023 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zvo8K0tw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9422F1D;
	Fri, 24 Nov 2023 18:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52250C433C8;
	Fri, 24 Nov 2023 18:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852337;
	bh=6YLbCEG3+7wCgJYPmhtEiadT50uYh/IQKZfGyYYuObw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zvo8K0twjUvbbKhw2IgH6K7OogS4AX0i9J/WEVmHRg9PHg5cGoOHmoM6nvidw1R0t
	 r2R0j8tRnz1ChxTTR27D6azLsenpbyD+X9ZFDmvCJMo1uaubs34UBGqSh2cVe7UJqM
	 fDmx9lpDakAwFzwXTtHB3uc4cZ6sFWgBDDh8bniY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jim Harris <jim.harris@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 298/372] cxl/region: Do not try to cleanup after cxl_region_setup_targets() fails
Date: Fri, 24 Nov 2023 17:51:25 +0000
Message-ID: <20231124172020.362219786@linuxfoundation.org>
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

From: Jim Harris <jim.harris@samsung.com>

[ Upstream commit 0718588c7aaa7a1510b4de972370535b61dddd0d ]

Commit 5e42bcbc3fef ("cxl/region: decrement ->nr_targets on error in
cxl_region_attach()") tried to avoid 'eiw' initialization errors when
->nr_targets exceeded 16, by just decrementing ->nr_targets when
cxl_region_setup_targets() failed.

Commit 86987c766276 ("cxl/region: Cleanup target list on attach error")
extended that cleanup to also clear cxled->pos and p->targets[pos]. The
initialization error was incidentally fixed separately by:
Commit 8d4285425714 ("cxl/region: Fix port setup uninitialized variable
warnings") which was merged a few days after 5e42bcbc3fef.

But now the original cleanup when cxl_region_setup_targets() fails
prevents endpoint and switch decoder resources from being reused:

1) the cleanup does not set the decoder's region to NULL, which results
   in future dpa_size_store() calls returning -EBUSY
2) the decoder is not properly freed, which results in future commit
   errors associated with the upstream switch

Now that the initialization errors were fixed separately, the proper
cleanup for this case is to just return immediately. Then the resources
associated with this target get cleanup up as normal when the failed
region is deleted.

The ->nr_targets decrement in the error case also helped prevent
a p->targets[] array overflow, so add a new check to prevent against
that overflow.

Tested by trying to create an invalid region for a 2 switch * 2 endpoint
topology, and then following up with creating a valid region.

Fixes: 5e42bcbc3fef ("cxl/region: decrement ->nr_targets on error in cxl_region_attach()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jim Harris <jim.harris@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1ee51327e989d..13b1b18612d3f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1291,6 +1291,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
+	if (p->nr_targets >= p->interleave_ways) {
+		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
+			p->nr_targets);
+		return -EINVAL;
+	}
+
 	ep_port = cxled_to_port(cxled);
 	root_port = cxlrd_to_port(cxlrd);
 	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
@@ -1339,7 +1345,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (p->nr_targets == p->interleave_ways) {
 		rc = cxl_region_setup_targets(cxlr);
 		if (rc)
-			goto err_decrement;
+			return rc;
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
@@ -1351,12 +1357,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	};
 
 	return 0;
-
-err_decrement:
-	p->nr_targets--;
-	cxled->pos = -1;
-	p->targets[pos] = NULL;
-	return rc;
 }
 
 static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
-- 
2.42.0




