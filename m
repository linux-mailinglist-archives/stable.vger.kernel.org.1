Return-Path: <stable+bounces-55-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F50E7F5EB6
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDAB3281C46
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210B622069;
	Thu, 23 Nov 2023 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qbqn+jRx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36922307
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BCBC433C8;
	Thu, 23 Nov 2023 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700741173;
	bh=mboHwWdM5k2x0Buwoa2OkdqsiupIJ+JRlNK+k1sO1OM=;
	h=Subject:To:Cc:From:Date:From;
	b=qbqn+jRxl1/FCRp/v3eY5IjlcytWCDK8MVTwZHfvRLnCRydIFYpO/UOvwEaZEmLE0
	 BBhB95oC23NoZc7uK0O79/VFyiMQwhh2EyFRCOQ1z49ZF6Smh83ZsZrDq7GtKW5FDV
	 VHpQsQMpa3IWVgNvJ2+v1ZscO3+UC92Gx9JEBanA=
Subject: FAILED: patch "[PATCH] cxl/region: Do not try to cleanup after" failed to apply to 6.1-stable tree
To: jim.harris@samsung.com,Jonathan.Cameron@huawei.com,dan.carpenter@linaro.org,dan.j.williams@intel.com,dave.jiang@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 12:06:07 +0000
Message-ID: <2023112307-hardened-pureblood-48c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0718588c7aaa7a1510b4de972370535b61dddd0d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112307-hardened-pureblood-48c1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

0718588c7aaa ("cxl/region: Do not try to cleanup after cxl_region_setup_targets() fails")
9995576cef48 ("cxl/region: Move region-position validation to a helper")
86987c766276 ("cxl/region: Cleanup target list on attach error")
1b9b7a6fd618 ("cxl/region: Validate region mode vs decoder mode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0718588c7aaa7a1510b4de972370535b61dddd0d Mon Sep 17 00:00:00 2001
From: Jim Harris <jim.harris@samsung.com>
Date: Wed, 11 Oct 2023 14:51:31 +0000
Subject: [PATCH] cxl/region: Do not try to cleanup after
 cxl_region_setup_targets() fails

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

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d74bf1b664b6..a3bc6424f175 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1652,6 +1652,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -1744,7 +1750,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	if (p->nr_targets == p->interleave_ways) {
 		rc = cxl_region_setup_targets(cxlr);
 		if (rc)
-			goto err_decrement;
+			return rc;
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
@@ -1756,12 +1762,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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


