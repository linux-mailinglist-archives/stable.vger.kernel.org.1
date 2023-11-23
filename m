Return-Path: <stable+bounces-58-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8EF7F5F1F
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C635D1C21014
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16487241E3;
	Thu, 23 Nov 2023 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rhyc1A7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835524B38
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967B2C433C8;
	Thu, 23 Nov 2023 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700743166;
	bh=IkRmzgHGB5KjaOxpK7jLAl440z3us70vd4aG7SIxrNo=;
	h=Subject:To:Cc:From:Date:From;
	b=rhyc1A7eB0JUGdyUNIU4M2W/JLbVrh0s9hErRK3Uyexuq8daG5q5G+//hPkAvk2ue
	 27oYeKjI3KZDcGWTrb0boLj6Iu5hsE8Ezh6T4C9Bn9sj0LwYOBNCSdyPL6m3DqfeJH
	 JMsABYI7/ABeYm1Ajf9+Fp+SRtNFVqls4fp7FHPk=
Subject: FAILED: patch "[PATCH] cxl/region: Fix x1 root-decoder granularity calculations" failed to apply to 6.1-stable tree
To: jim.harris@samsung.com,dan.j.williams@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 12:27:37 +0000
Message-ID: <2023112337-oxford-balcony-2137@gregkh>
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
git cherry-pick -x 98a04c7aced2b43b3ac4befe216c4eecc7257d4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112337-oxford-balcony-2137@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

98a04c7aced2 ("cxl/region: Fix x1 root-decoder granularity calculations")
3d8f7ccaa611 ("tools/testing/cxl: Define a fixed volatile configuration to parse")
7592d935b7ae ("cxl/mem: Move devm_cxl_add_endpoint() from cxl_core to cxl_mem")
f3cd264c4ec1 ("cxl: Unify debug messages when calling devm_cxl_add_port()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98a04c7aced2b43b3ac4befe216c4eecc7257d4b Mon Sep 17 00:00:00 2001
From: Jim Harris <jim.harris@samsung.com>
Date: Thu, 26 Oct 2023 10:09:06 -0700
Subject: [PATCH] cxl/region: Fix x1 root-decoder granularity calculations

Root decoder granularity must match value from CFWMS, which may not
be the region's granularity for non-interleaved root decoders.

So when calculating granularities for host bridge decoders, use the
region's granularity instead of the root decoder's granularity to ensure
the correct granularities are set for the host bridge decoders and any
downstream switch decoders.

Test configuration is 1 host bridge * 2 switches * 2 endpoints per switch.

Region created with 2048 granularity using following command line:

cxl create-region -m -d decoder0.0 -w 4 mem0 mem2 mem1 mem3 \
		  -g 2048 -s 2048M

Use "cxl list -PDE | grep granularity" to get a view of the granularity
set at each level of the topology.

Before this patch:
        "interleave_granularity":2048,
        "interleave_granularity":2048,
    "interleave_granularity":512,
        "interleave_granularity":2048,
        "interleave_granularity":2048,
    "interleave_granularity":512,
"interleave_granularity":256,

After:
        "interleave_granularity":2048,
        "interleave_granularity":2048,
    "interleave_granularity":4096,
        "interleave_granularity":2048,
        "interleave_granularity":2048,
    "interleave_granularity":4096,
"interleave_granularity":2048,

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jim Harris <jim.harris@samsung.com>
Link: https://lore.kernel.org/r/169824893473.1403938.16110924262989774582.stgit@bgt-140510-bm03.eng.stellus.in
[djbw: fixup the prebuilt cxl_test region]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3167b19f4081..a1eac592c66a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1127,7 +1127,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	if (is_cxl_root(parent_port)) {
-		parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
+		/*
+		 * Root decoder IG is always set to value in CFMWS which
+		 * may be different than this region's IG.  We can use the
+		 * region's IG here since interleave_granularity_store()
+		 * does not allow interleaved host-bridges with
+		 * root IG != region IG.
+		 */
+		parent_ig = p->interleave_granularity;
 		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
 		/*
 		 * For purposes of address bit routing, use power-of-2 math for
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index fb6ab9cef84f..b88546299902 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -831,7 +831,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 			cxld->interleave_ways = 2;
 		else
 			cxld->interleave_ways = 1;
-		cxld->interleave_granularity = 256;
+		cxld->interleave_granularity = 4096;
 		cxld->hpa_range = (struct range) {
 			.start = base,
 			.end = base + size - 1,


