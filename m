Return-Path: <stable+bounces-218483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ8WJw5SnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09818F1AF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4335630789E1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F57248886;
	Wed, 25 Feb 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lSMFhRis"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AF18B0A;
	Wed, 25 Feb 2026 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983312; cv=none; b=F8VszOeka2GwZp6rw/hR/5OpdzURn5vsV/ChTsS47MZ22+9gwVQITFeluhepp97PJKyjnDb8DcefuU8PsBkshhBPCIOcfLjfeQaZzzsEP8ciy65beqqZw9gfOkAkdBN5BadlIeoNICBbEwuedVc5o36EjSz8+PNsSIYWRR/SFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983312; c=relaxed/simple;
	bh=ifUlT3Q1bruDK+IvbpQ3Funucg/uvvXmKq0Uc7EGKQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSJmQ3XkJJ1IrCyVN08XZU5ZXCEQwi/WqMOF03XB1fCgqAoL6/gDED79iYGJyCFGG4DxGPyp5y4NdG9dsn6zl0AMnyfKWaJNJDmyBvzgVTwzhSIKJaIx9C2lLLKwVjcgJ3Yi4gYpe0rHUHlZFo10TJEsR4sf4zlUDJ3GSBFHax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lSMFhRis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB94BC116D0;
	Wed, 25 Feb 2026 01:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983312;
	bh=ifUlT3Q1bruDK+IvbpQ3Funucg/uvvXmKq0Uc7EGKQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSMFhRisDnP1pDsZuIrL5KQuIkD9Ls+kvryDk6nDEe91Un2fsbuW6i/gMvk1HEK4j
	 oAUgeSMsTknZMB2TjNp4gbNZGO5lXhkNhsS36mIg0FTlHgRVeJu/QPtGCge+hPL/z5
	 xKBYHlreyQfTxx+ZtE8/XSF+r6eie5g3z4rYcAm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alejandro Lucero <alucerop@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 446/781] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
Date: Tue, 24 Feb 2026 17:19:15 -0800
Message-ID: <20260225012410.646945137@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218483-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,huawei.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: 1F09818F1AF
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 10016118b6fade907143a32a7aeaa777063dc79c ]

A device release method is only for undoing allocations on the path to
preparing the device for device_add(). In contrast, devm allocations are
post device_add(), are acquired during / after ->probe() and are released
synchronous with ->remove().

So, a "devm" helper in a "release" method is a clear anti-pattern.

Move this devm release action where it belongs, an action created at edac
object creation time. Otherwise, this leaks resources until
cxl_memdev_release() time which may be long after these xarray and error
record caches have gone idle.

Note, this also fixes up the type of @cxlmd->err_rec_array which needlessly
dropped type-safety.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
Tested-by: Alejandro Lucero <alucerop@amd.com>
Link: https://patch.msgid.link/20251216005616.3090129-2-dan.j.williams@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/edac.c   | 64 ++++++++++++++++++++++-----------------
 drivers/cxl/core/memdev.c |  1 -
 drivers/cxl/cxlmem.h      |  5 +--
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 79994ca9bc9f3..81160260e26b7 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -1988,6 +1988,40 @@ static int cxl_memdev_soft_ppr_init(struct cxl_memdev *cxlmd,
 	return 0;
 }
 
+static void err_rec_free(void *_cxlmd)
+{
+	struct cxl_memdev *cxlmd = _cxlmd;
+	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
+	struct cxl_event_gen_media *rec_gen_media;
+	struct cxl_event_dram *rec_dram;
+	unsigned long index;
+
+	cxlmd->err_rec_array = NULL;
+	xa_for_each(&array_rec->rec_dram, index, rec_dram)
+		kfree(rec_dram);
+	xa_destroy(&array_rec->rec_dram);
+
+	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
+		kfree(rec_gen_media);
+	xa_destroy(&array_rec->rec_gen_media);
+	kfree(array_rec);
+}
+
+static int devm_cxl_memdev_setup_err_rec(struct cxl_memdev *cxlmd)
+{
+	struct cxl_mem_err_rec *array_rec =
+		kzalloc(sizeof(*array_rec), GFP_KERNEL);
+
+	if (!array_rec)
+		return -ENOMEM;
+
+	xa_init(&array_rec->rec_gen_media);
+	xa_init(&array_rec->rec_dram);
+	cxlmd->err_rec_array = array_rec;
+
+	return devm_add_action_or_reset(&cxlmd->dev, err_rec_free, cxlmd);
+}
+
 int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 {
 	struct edac_dev_feature ras_features[CXL_NR_EDAC_DEV_FEATURES];
@@ -2038,15 +2072,9 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 		}
 
 		if (repair_inst) {
-			struct cxl_mem_err_rec *array_rec =
-				devm_kzalloc(&cxlmd->dev, sizeof(*array_rec),
-					     GFP_KERNEL);
-			if (!array_rec)
-				return -ENOMEM;
-
-			xa_init(&array_rec->rec_gen_media);
-			xa_init(&array_rec->rec_dram);
-			cxlmd->err_rec_array = array_rec;
+			rc = devm_cxl_memdev_setup_err_rec(cxlmd);
+			if (rc)
+				return rc;
 		}
 	}
 
@@ -2088,22 +2116,4 @@ int devm_cxl_region_edac_register(struct cxl_region *cxlr)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_region_edac_register, "CXL");
 
-void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
-{
-	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
-	struct cxl_event_gen_media *rec_gen_media;
-	struct cxl_event_dram *rec_dram;
-	unsigned long index;
-
-	if (!IS_ENABLED(CONFIG_CXL_EDAC_MEM_REPAIR) || !array_rec)
-		return;
-
-	xa_for_each(&array_rec->rec_dram, index, rec_dram)
-		kfree(rec_dram);
-	xa_destroy(&array_rec->rec_dram);
 
-	xa_for_each(&array_rec->rec_gen_media, index, rec_gen_media)
-		kfree(rec_gen_media);
-	xa_destroy(&array_rec->rec_gen_media);
-}
-EXPORT_SYMBOL_NS_GPL(devm_cxl_memdev_edac_release, "CXL");
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index e370d733e4400..4dff7f44d908e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -27,7 +27,6 @@ static void cxl_memdev_release(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	ida_free(&cxl_memdev_ida, cxlmd->id);
-	devm_cxl_memdev_edac_release(cxlmd);
 	kfree(cxlmd);
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 434031a0c1f74..c12ab4fc95123 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -63,7 +63,7 @@ struct cxl_memdev {
 	int depth;
 	u8 scrub_cycle;
 	int scrub_region_id;
-	void *err_rec_array;
+	struct cxl_mem_err_rec *err_rec_array;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
@@ -877,7 +877,6 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd);
 int devm_cxl_region_edac_register(struct cxl_region *cxlr);
 int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt);
 int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt);
-void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd);
 #else
 static inline int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
 { return 0; }
@@ -889,8 +888,6 @@ static inline int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd,
 static inline int cxl_store_rec_dram(struct cxl_memdev *cxlmd,
 				     union cxl_event *evt)
 { return 0; }
-static inline void devm_cxl_memdev_edac_release(struct cxl_memdev *cxlmd)
-{ return; }
 #endif
 
 #ifdef CONFIG_CXL_SUSPEND
-- 
2.51.0




