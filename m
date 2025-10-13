Return-Path: <stable+bounces-184236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA8BD34A5
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C134C794
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5C1F4C96;
	Mon, 13 Oct 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nuKAjZTQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451C145B3F
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363552; cv=none; b=nA52AOtaaIlASqS5CBNZOr2DHwfPqKYTLR7fyH644irE+U93CEyXxfJj55kwu4fHn4v8JXiSfEpl9hisAHndXeJ6MiR2J/AyksxLMKKQU7+41ElJtkMuYszC3JtZqRPZ/DxRdWCehVfzTLjfnFN3DpKUftLmuu4JpGlEhQe/ojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363552; c=relaxed/simple;
	bh=dRgItSQV18fEgJ/jlbgm0jLSiWYEBECFrNy9DarrL/o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DsgsQStDeMz8DLCTGrmPmHA55Mj51c0NG5IJnlysco8R2nqHPcuHJG3C4T3GAIuo3DVC+7JuP9AXnQzvfsgsHqiquYbLHxcuveYAcCUFwlkl6AzKyYyVGc5+ooVZaXliErJmLPx5KPEuCHoAOq9axYCW1p1ypZOUgDRgbyIzUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nuKAjZTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9298C4CEE7;
	Mon, 13 Oct 2025 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760363552;
	bh=dRgItSQV18fEgJ/jlbgm0jLSiWYEBECFrNy9DarrL/o=;
	h=Subject:To:Cc:From:Date:From;
	b=nuKAjZTQVSKh0vzvrTeShX6pdnrLGoA7BCFcgzEbOGSADP/4gw9JbG0PGcFWo+iXZ
	 n1EKBXDPR1dG2JZPTxQW+Lrm1POj1YVAydvOeeZEIM8APdllxGsWdAjQpzqPmU5Oag
	 lhssipNO91rRgKYYGaPQitB59mkn8S0dHDrFNliY=
Subject: FAILED: patch "[PATCH] cacheinfo: Check cache properties are present in DT" failed to apply to 6.1-stable tree
To: pierre.gondois@arm.com,alexghiti@rivosinc.com,conor.dooley@microchip.com,sudeep.holla@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 15:52:28 +0200
Message-ID: <2025101328-ferry-wrought-6a64@gregkh>
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
git cherry-pick -x cde0fbff07eff7e4e0e85fa053fe19a24c86b1e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101328-ferry-wrought-6a64@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cde0fbff07eff7e4e0e85fa053fe19a24c86b1e0 Mon Sep 17 00:00:00 2001
From: Pierre Gondois <pierre.gondois@arm.com>
Date: Fri, 14 Apr 2023 10:14:50 +0200
Subject: [PATCH] cacheinfo: Check cache properties are present in DT

If a Device Tree (DT) is used, the presence of cache properties is
assumed. Not finding any is not considered. For arm64 platforms,
cache information can be fetched from the clidr_el1 register.
Checking whether cache information is available in the DT
allows to switch to using clidr_el1.

init_of_cache_level()
\-of_count_cache_leaves()
will assume there a 2 cache leaves (L1 data/instruction caches), which
can be different from clidr_el1 information.

cache_setup_of_node() tries to read cache properties in the DT.
If there are none, this is considered a success. Knowing no
information was available would allow to switch to using clidr_el1.

Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count cache leaves")
Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@spud/
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230414081453.244787-3-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index ba14c7872e4a..f16e5a82f0f3 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -78,6 +78,9 @@ bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y)
 }
 
 #ifdef CONFIG_OF
+
+static bool of_check_cache_nodes(struct device_node *np);
+
 /* OF properties to query for a given cache type */
 struct cache_type_info {
 	const char *size_prop;
@@ -205,6 +208,11 @@ static int cache_setup_of_node(unsigned int cpu)
 		return -ENOENT;
 	}
 
+	if (!of_check_cache_nodes(np)) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+
 	prev = np;
 
 	while (index < cache_leaves(cpu)) {
@@ -229,6 +237,25 @@ static int cache_setup_of_node(unsigned int cpu)
 	return 0;
 }
 
+static bool of_check_cache_nodes(struct device_node *np)
+{
+	struct device_node *next;
+
+	if (of_property_present(np, "cache-size")   ||
+	    of_property_present(np, "i-cache-size") ||
+	    of_property_present(np, "d-cache-size") ||
+	    of_property_present(np, "cache-unified"))
+		return true;
+
+	next = of_find_next_cache_node(np);
+	if (next) {
+		of_node_put(next);
+		return true;
+	}
+
+	return false;
+}
+
 static int of_count_cache_leaves(struct device_node *np)
 {
 	unsigned int leaves = 0;
@@ -260,6 +287,11 @@ int init_of_cache_level(unsigned int cpu)
 	struct device_node *prev = NULL;
 	unsigned int levels = 0, leaves, level;
 
+	if (!of_check_cache_nodes(np)) {
+		of_node_put(np);
+		return -ENOENT;
+	}
+
 	leaves = of_count_cache_leaves(np);
 	if (leaves > 0)
 		levels = 1;


