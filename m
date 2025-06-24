Return-Path: <stable+bounces-157837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F39FAE55DE
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33351B674F6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE922B5A3;
	Mon, 23 Jun 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="udLMVoFV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2EF22AE65;
	Mon, 23 Jun 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716840; cv=none; b=j601e1ximVO8xJ8aqUaEWASOdKvnj/Zb1ec0kq6wtfSkHW7U985A3oZQWzjibo3HBzhWLYF6iMJaXZ7yXRLKXiiJ3FMNscW695kCZLXeqCRACRUdwnlZcnii1m3WeRrNkNU936p1bSqR/GlbQQkHo2k/AJoEAYOLNKoR+ZkoBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716840; c=relaxed/simple;
	bh=/ne8tI+hUYoPwUCCegZskvPQLAK0LKulixS+uSrqeLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Juq2MmnrksA/KrVvGltj8H7Ymw5naELWW4RxQ74JfmYFc2sW0P60x0jLwobC86WR4e8iGwdmjynqTsaQsDYbWrdxst2C/CfDT4GgIPScqLmozkyeq1L7qbLSE8NKMuD6XglFNw2VXs2Ru7ZI4tQw8lW9vTko97xzGmcfpnE2OCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=udLMVoFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFB4C4CEEA;
	Mon, 23 Jun 2025 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716840;
	bh=/ne8tI+hUYoPwUCCegZskvPQLAK0LKulixS+uSrqeLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udLMVoFVaOx2DZt233Jb5ZajfB72wwwNIwspBJFyb1GiL4c6hG7BL0qVImK3agI7J
	 cN1BhwsvCxgyUTMqB1gx52CWYiLWQKAFxN+yemgAfTE408iJ0ayL+m2yAXecIEf9IZ
	 gQew4jGMgPEW2ENZkRiXZylv8DHZggzoRCieG/9E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Peng Fan <peng.fan@nxp.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 6.1 364/508] remoteproc: core: Release rproc->clean_table after rproc_attach() fails
Date: Mon, 23 Jun 2025 15:06:49 +0200
Message-ID: <20250623130654.317387463@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Xiaolei Wang <xiaolei.wang@windriver.com>

commit bcd241230fdbc6005230f80a4f8646ff5a84f15b upstream.

When rproc->state = RPROC_DETACHED is attached to remote processor
through rproc_attach(), if rproc_handle_resources() returns failure,
then the clean table should be released, otherwise the following
memory leak will occur.

unreferenced object 0xffff000086a99800 (size 1024):
comm "kworker/u12:3", pid 59, jiffies 4294893670 (age 121.140s)
hex dump (first 32 bytes):
00 00 00 00 00 80 00 00 00 00 00 00 00 00 10 00 ............
00 00 00 00 00 00 08 00 00 00 00 00 00 00 00 00 ............
backtrace:
 [<000000008bbe4ca8>] slab_post_alloc_hook+0x98/0x3fc
 [<000000003b8a272b>] __kmem_cache_alloc_node+0x13c/0x230
 [<000000007a507c51>] __kmalloc_node_track_caller+0x5c/0x260
 [<0000000037818dae>] kmemdup+0x34/0x60
 [<00000000610f7f57>] rproc_boot+0x35c/0x56c
 [<0000000065f8871a>] rproc_add+0x124/0x17c
 [<00000000497416ee>] imx_rproc_probe+0x4ec/0x5d4
 [<000000003bcaa37d>] platform_probe+0x68/0xd8
 [<00000000771577f9>] really_probe+0x110/0x27c
 [<00000000531fea59>] __driver_probe_device+0x78/0x12c
 [<0000000080036a04>] driver_probe_device+0x3c/0x118
 [<000000007e0bddcb>] __device_attach_driver+0xb8/0xf8
 [<000000000cf1fa33>] bus_for_each_drv+0x84/0xe4
 [<000000001a53b53e>] __device_attach+0xfc/0x18c
 [<00000000d1a2a32c>] device_initial_probe+0x14/0x20
 [<00000000d8f8b7ae>] bus_probe_device+0xb0/0xb4
 unreferenced object 0xffff0000864c9690 (size 16):

Fixes: 9dc9507f1880 ("remoteproc: Properly deal with the resource table when detaching")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250430092043.1819308-3-xiaolei.wang@windriver.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/remoteproc/remoteproc_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1653,6 +1653,7 @@ clean_up_resources:
 	rproc_resource_cleanup(rproc);
 	/* release HW resources if needed */
 	rproc_unprepare_device(rproc);
+	kfree(rproc->clean_table);
 disable_iommu:
 	rproc_disable_iommu(rproc);
 	return ret;



