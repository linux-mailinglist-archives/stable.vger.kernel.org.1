Return-Path: <stable+bounces-23642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE1867146
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6649E1C27193
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6AF1CD3A;
	Mon, 26 Feb 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZbM1bYoV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CC17551
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943206; cv=none; b=XOJGTR3WXqGx1R8DBqP0lelAzeoH1ebA7Rks9QVtxf+ZiMChOynW+4WsMsol4OXdNUdtqpsezxp09Vg5taCZpwlezfN29JeIftdIa8b9mcokS66uaLsFOUq2eHpFsBOenU0CUjrYMjznEbdzsysgnYV2FuDmUWFuwMNF66ELjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943206; c=relaxed/simple;
	bh=r7qG9Iba5zejulfZqph2X6/phMrf4unaeLnQDECE8UM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nKs0Cq9jnbBGA8wBK+Xq/JbXL6vNjGrKAuG5k3imBeVRcY4hvwqaAQLtNP9KrKiqYRxSbhoynrjn2zGicdW75vodT6SwAaAscX9LlQN0WN6GWS+6sAFbnb8gt1GV9FaZ+OpiU7M7xIj/oRjKzwgV0XTaxF0/lOPNZNPYvPNh0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZbM1bYoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1A0C43390;
	Mon, 26 Feb 2024 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943206;
	bh=r7qG9Iba5zejulfZqph2X6/phMrf4unaeLnQDECE8UM=;
	h=Subject:To:Cc:From:Date:From;
	b=ZbM1bYoV4vXujMbRgKaWfUP3rFF77LIBjjnBxruRHa3ChnbgIaENchc7mRnY4KKI9
	 yLFrroPuevCwuRyp4LFHLVl+TI6emn0M1PXoL5UsPTKwaqGEla804BhIHMCNEnwr4W
	 c+BkMsGh50w0qvFHKJNoa3alHw0K/sYlLUzezqlM=
Subject: FAILED: patch "[PATCH] cxl/acpi: Fix load failures due to single window creation" failed to apply to 6.1-stable tree
To: dan.j.williams@intel.com,alison.schofield@intel.com,leitao@debian.org,stable@vger.kernel.org,vishal.l.verma@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:26:43 +0100
Message-ID: <2024022643-rearview-spouse-b8a1@gregkh>
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
git cherry-pick -x 5c6224bfabbf7f3e491c51ab50fd2c6f92ba1141
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022643-rearview-spouse-b8a1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5c6224bfabbf ("cxl/acpi: Fix load failures due to single window creation failure")
790815902ec6 ("cxl: Add support for _DSM Function for retrieving QTG ID")
91019b5bc7c2 ("cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()")
4cf67d3cc999 ("cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()")
d35b495ddf92 ("cxl/port: Fix find_cxl_root() for RCDs and simplify it")
a32320b71f08 ("cxl/region: Add region autodiscovery")
32ce3f185bbb ("cxl/port: Split endpoint and switch port probe")
9995576cef48 ("cxl/region: Move region-position validation to a helper")
86987c766276 ("cxl/region: Cleanup target list on attach error")
1b9b7a6fd618 ("cxl/region: Validate region mode vs decoder mode")
7d505f982f53 ("cxl/region: Add a mode attribute for regions")
02fedf146656 ("Merge branch 'for-6.2/cxl-xor' into for-6.2/cxl")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c6224bfabbf7f3e491c51ab50fd2c6f92ba1141 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Feb 2024 19:11:34 -0800
Subject: [PATCH] cxl/acpi: Fix load failures due to single window creation
 failure

The expectation is that cxl_parse_cfwms() continues in the face the of
failure as evidenced by code like:

    cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
    if (IS_ERR(cxlrd))
    	return 0;

There are other error paths in that function which mistakenly follow
idiomatic expectations and return an error when they should not. Most of
those mistakes are innocuous checks that hardly ever fail in practice.
However, a recent change succeed in making the implementation more
fragile by applying an idiomatic, but still wrong "fix" [1]. In this
failure case the kernel reports:

    cxl root0: Failed to populate active decoder targets
    cxl_acpi ACPI0017:00: Failed to add decode range: [mem 0x00000000-0x7fffffff flags 0x200]

...which is a real issue with that one window (to be fixed separately),
but ends up failing the entirety of cxl_acpi_probe().

Undo that recent breakage while also removing the confusion about
ignoring errors. Update all exits paths to return an error per typical
expectations and let an outer wrapper function handle dropping the
error.

Fixes: 91019b5bc7c2 ("cxl/acpi: Return 'rc' instead of '0' in cxl_parse_cfmws()") [1]
Cc: <stable@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index dcf2b39e1048..1a3e6aafbdcc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -316,31 +316,27 @@ static const struct cxl_root_ops acpi_root_ops = {
 	.qos_class = cxl_acpi_qos_class,
 };
 
-static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
-			   const unsigned long end)
+static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
+			     struct cxl_cfmws_context *ctx)
 {
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
-	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
 	struct resource *cxl_res = ctx->cxl_res;
 	struct cxl_cxims_context cxims_ctx;
 	struct cxl_root_decoder *cxlrd;
 	struct device *dev = ctx->dev;
-	struct acpi_cedt_cfmws *cfmws;
 	cxl_calc_hb_fn cxl_calc_hb;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
 	struct resource *res;
 	int rc;
 
-	cfmws = (struct acpi_cedt_cfmws *) header;
-
 	rc = cxl_acpi_cfmws_verify(dev, cfmws);
 	if (rc) {
 		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
 			cfmws->base_hpa,
 			cfmws->base_hpa + cfmws->window_size - 1);
-		return 0;
+		return rc;
 	}
 
 	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
@@ -376,7 +372,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 	cxlrd = cxl_root_decoder_alloc(root_port, ways, cxl_calc_hb);
 	if (IS_ERR(cxlrd))
-		return 0;
+		return PTR_ERR(cxlrd);
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
@@ -420,16 +416,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		put_device(&cxld->dev);
 	else
 		rc = cxl_decoder_autoremove(dev, cxld);
-	if (rc) {
-		dev_err(dev, "Failed to add decode range: %pr", res);
-		return rc;
-	}
-	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
-		dev_name(&cxld->dev),
-		phys_to_target_node(cxld->hpa_range.start),
-		cxld->hpa_range.start, cxld->hpa_range.end);
-
-	return 0;
+	return rc;
 
 err_insert:
 	kfree(res->name);
@@ -438,6 +425,29 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	return -ENOMEM;
 }
 
+static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
+			   const unsigned long end)
+{
+	struct acpi_cedt_cfmws *cfmws = (struct acpi_cedt_cfmws *)header;
+	struct cxl_cfmws_context *ctx = arg;
+	struct device *dev = ctx->dev;
+	int rc;
+
+	rc = __cxl_parse_cfmws(cfmws, ctx);
+	if (rc)
+		dev_err(dev,
+			"Failed to add decode range: [%#llx - %#llx] (%d)\n",
+			cfmws->base_hpa,
+			cfmws->base_hpa + cfmws->window_size - 1, rc);
+	else
+		dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
+			phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
+			cfmws->base_hpa + cfmws->window_size - 1);
+
+	/* never fail cxl_acpi load for a single window failure */
+	return 0;
+}
+
 __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 					      struct device *dev)
 {


