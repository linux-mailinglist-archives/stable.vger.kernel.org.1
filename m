Return-Path: <stable+bounces-80294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBDF98DCCE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB001C21C87
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE5D1D270D;
	Wed,  2 Oct 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JRAt7ykD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2811D0F4B;
	Wed,  2 Oct 2024 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879951; cv=none; b=tUS+fe+XCDwEpiPGrn0wrCAG5nQjiHTG5A+8WKkLGQF4bRyiI6Y0OA9gcaa8rwUjaFGugwKCuUSri5lZ83ktWMhf12xcim6ZutgoDQ6pg8f1Xv3bmC3M6wVGt4EvtUuV6Z4U0QW7+/pmsQagRDyC1zFRhfh/3fKPMyGLT0mxrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879951; c=relaxed/simple;
	bh=vyFfkiY/sm+Nl9g0k3kqK0US4jHBgumzCEkQyo4vzq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0EcJ5nOeD4k2Wlvo8RuCeDfKQ+2qECP0UP8BqgDOWRnrZ1T9V0ieznbh4XXMF3yaqZxSDdouvq+CtHRU9tmc0ihjYqkEDW6HsmfYhJmII3W/Ex2qzmfVv7mZWaKK5liL7ScO5kWaN5b1pG5T2TKUg2Epqu3Rb+Ha5C6Eufgglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JRAt7ykD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89DFC4CEC5;
	Wed,  2 Oct 2024 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879951;
	bh=vyFfkiY/sm+Nl9g0k3kqK0US4jHBgumzCEkQyo4vzq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRAt7ykDHvN2R4YmfTb+S/HUYALiYmu5K6jfTWl9d5z8ZUoCmlhX4S2+oybSnHuqQ
	 Ox993NR5ilsNpfE6tTw2UZWNpqaOBFoFig/wsR+q2SKO6N/3qihj7PtW8z7gsL+Csm
	 sscq1f17qootgOG13M6WZQMhKYFJMnLVBKlqtCI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 292/538] nvdimm: Fix devs leaks in scan_labels()
Date: Wed,  2 Oct 2024 14:58:51 +0200
Message-ID: <20241002125803.783347840@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit 62c2aa6b1f565d2fc1ec11a6e9e8336ce37a6426 ]

scan_labels() leaks memory when label scanning fails and it falls back
to just creating a default "seed" namespace for userspace to configure.
Root can force the kernel to leak memory.

Allocate the minimum resources unconditionally and release them when
unneeded to avoid the memory leak.

A kmemleak reports:
unreferenced object 0xffff88800dda1980 (size 16):
  comm "kworker/u10:5", pid 69, jiffies 4294671781
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<00000000c5dea560>] __kmalloc+0x32c/0x470
    [<000000009ed43c83>] nd_region_register_namespaces+0x6fb/0x1120 [libnvdimm]
    [<000000000e07a65c>] nd_region_probe+0xfe/0x210 [libnvdimm]
    [<000000007b79ce5f>] nvdimm_bus_probe+0x7a/0x1e0 [libnvdimm]
    [<00000000a5f3da2e>] really_probe+0xc6/0x390
    [<00000000129e2a69>] __driver_probe_device+0x78/0x150
    [<000000002dfed28b>] driver_probe_device+0x1e/0x90
    [<00000000e7048de2>] __device_attach_driver+0x85/0x110
    [<0000000032dca295>] bus_for_each_drv+0x85/0xe0
    [<00000000391c5a7d>] __device_attach+0xbe/0x1e0
    [<0000000026dabec0>] bus_probe_device+0x94/0xb0
    [<00000000c590d936>] device_add+0x656/0x870
    [<000000003d69bfaa>] nd_async_device_register+0xe/0x50 [libnvdimm]
    [<000000003f4c52a4>] async_run_entry_fn+0x2e/0x110
    [<00000000e201f4b0>] process_one_work+0x1ee/0x600
    [<000000006d90d5a9>] worker_thread+0x183/0x350

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Fixes: 1b40e09a1232 ("libnvdimm: blk labels and namespace instantiation")
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://patch.msgid.link/20240819062045.1481298-1-lizhijian@fujitsu.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/namespace_devs.c | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 07177eadc56e8..1ea8c27e8874d 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1927,12 +1927,16 @@ static int cmp_dpa(const void *a, const void *b)
 static struct device **scan_labels(struct nd_region *nd_region)
 {
 	int i, count = 0;
-	struct device *dev, **devs = NULL;
+	struct device *dev, **devs;
 	struct nd_label_ent *label_ent, *e;
 	struct nd_mapping *nd_mapping = &nd_region->mapping[0];
 	struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
 	resource_size_t map_end = nd_mapping->start + nd_mapping->size - 1;
 
+	devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
+	if (!devs)
+		return NULL;
+
 	/* "safe" because create_namespace_pmem() might list_move() label_ent */
 	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
 		struct nd_namespace_label *nd_label = label_ent->label;
@@ -1951,12 +1955,14 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			goto err;
 		if (i < count)
 			continue;
-		__devs = kcalloc(count + 2, sizeof(dev), GFP_KERNEL);
-		if (!__devs)
-			goto err;
-		memcpy(__devs, devs, sizeof(dev) * count);
-		kfree(devs);
-		devs = __devs;
+		if (count) {
+			__devs = kcalloc(count + 2, sizeof(dev), GFP_KERNEL);
+			if (!__devs)
+				goto err;
+			memcpy(__devs, devs, sizeof(dev) * count);
+			kfree(devs);
+			devs = __devs;
+		}
 
 		dev = create_namespace_pmem(nd_region, nd_mapping, nd_label);
 		if (IS_ERR(dev)) {
@@ -1983,11 +1989,6 @@ static struct device **scan_labels(struct nd_region *nd_region)
 
 		/* Publish a zero-sized namespace for userspace to configure. */
 		nd_mapping_free_labels(nd_mapping);
-
-		devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
-		if (!devs)
-			goto err;
-
 		nspm = kzalloc(sizeof(*nspm), GFP_KERNEL);
 		if (!nspm)
 			goto err;
@@ -2026,11 +2027,10 @@ static struct device **scan_labels(struct nd_region *nd_region)
 	return devs;
 
  err:
-	if (devs) {
-		for (i = 0; devs[i]; i++)
-			namespace_pmem_release(devs[i]);
-		kfree(devs);
-	}
+	for (i = 0; devs[i]; i++)
+		namespace_pmem_release(devs[i]);
+	kfree(devs);
+
 	return NULL;
 }
 
-- 
2.43.0




