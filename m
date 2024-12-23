Return-Path: <stable+bounces-105862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A2B9FB21C
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4741645C3
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940B7E0FF;
	Mon, 23 Dec 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VMZ9/DKT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66481B3948;
	Mon, 23 Dec 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970392; cv=none; b=Zj2/giC53fK2ltfrPr2dEPUTmR99EOF+EJi18GbamAfMh72zm0tRHyL52kj7RjLeYhWHoZF4RneI1vgO6XSGRcPeNseEtps+Dg3WVakIOwWehnMae7xqA7Bv+Xr7l3Q6/ezvXsSVENqCa1dEtFj6VxMdtbZQoK0GDW9GDlt9iH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970392; c=relaxed/simple;
	bh=OgJwMJ6+NQ/koMwlv0DaesVB64qfVHB3SYdkNqs1PNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2rGeeMIIGVzJVlrBBT3uFhpCfLZHmOnxt6rnWIHqADnCxWMYahMb/vO31BnAmCWxKCm0O4wgjCaXWLD6smVCWj2g8vuzfU+yLmtWzAxjUUUlFTxBWCK/RN5PIfWf3GxCOExKkQQWRfjtJDGvGGhEfgQuScBSTT2qWAOrYK0O28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VMZ9/DKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F0FC4CED3;
	Mon, 23 Dec 2024 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970392;
	bh=OgJwMJ6+NQ/koMwlv0DaesVB64qfVHB3SYdkNqs1PNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMZ9/DKTFSfHBcmlHLJvanvy5fmWrToq5IuXdxmhwXzYjfAdd4iR24viw5hc8jaL4
	 ut9hTk2exLmVNK+jpnwOBw9tdk4syoOkf852gpLG+7gfu8F4lNG0NAnLARZA7vgCFy
	 eNA4Hi8zOML270jGIW6rf+QUQ/yxCcEXLvDhz4Bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huaisheng Ye <huaisheng.ye@intel.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 038/116] cxl/region: Fix region creation for greater than x2 switches
Date: Mon, 23 Dec 2024 16:58:28 +0100
Message-ID: <20241223155401.050714278@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155359.534468176@linuxfoundation.org>
References: <20241223155359.534468176@linuxfoundation.org>
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

From: Huaisheng Ye <huaisheng.ye@intel.com>

[ Upstream commit 76467a94810c2aa4dd3096903291ac6df30c399e ]

The cxl_port_setup_targets() algorithm fails to identify valid target list
ordering in the presence of 4-way and above switches resulting in
'cxl create-region' failures of the form:

  $ cxl create-region -d decoder0.0 -g 1024 -s 2G -t ram -w 8 -m mem4 mem1 mem6 mem3 mem2 mem5 mem7 mem0
  cxl region: create_region: region0: failed to set target7 to mem0
  cxl region: cmd_create_region: created 0 regions

  [kernel debug message]
  check_last_peer:1213: cxl region0: pci0000:0c:port1: cannot host mem6:decoder7.0 at 2
  bus_remove_device:574: bus: 'cxl': remove device region0

QEMU can create this failing topology:

                       ACPI0017:00 [root0]
                           |
                         HB_0 [port1]
                        /             \
                     RP_0             RP_1
                      |                 |
                USP [port2]           USP [port3]
            /    /    \    \        /   /    \    \
          DSP   DSP   DSP   DSP   DSP  DSP   DSP  DSP
           |     |     |     |     |    |     |    |
          mem4  mem6  mem2  mem7  mem1 mem3  mem5  mem0
 Pos:      0     2     4     6     1    3     5    7

 HB: Host Bridge
 RP: Root Port
 USP: Upstream Port
 DSP: Downstream Port

...with the following command steps:

$ qemu-system-x86_64 -machine q35,cxl=on,accel=tcg  \
        -smp cpus=8 \
        -m 8G \
        -hda /home/work/vm-images/centos-stream8-02.qcow2 \
        -object memory-backend-ram,size=4G,id=m0 \
        -object memory-backend-ram,size=4G,id=m1 \
        -object memory-backend-ram,size=2G,id=cxl-mem0 \
        -object memory-backend-ram,size=2G,id=cxl-mem1 \
        -object memory-backend-ram,size=2G,id=cxl-mem2 \
        -object memory-backend-ram,size=2G,id=cxl-mem3 \
        -object memory-backend-ram,size=2G,id=cxl-mem4 \
        -object memory-backend-ram,size=2G,id=cxl-mem5 \
        -object memory-backend-ram,size=2G,id=cxl-mem6 \
        -object memory-backend-ram,size=2G,id=cxl-mem7 \
        -numa node,memdev=m0,cpus=0-3,nodeid=0 \
        -numa node,memdev=m1,cpus=4-7,nodeid=1 \
        -netdev user,id=net0,hostfwd=tcp::2222-:22 \
        -device virtio-net-pci,netdev=net0 \
        -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
        -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
        -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
        -device cxl-upstream,bus=root_port0,id=us0 \
        -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
        -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-vmem0 \
        -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
        -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-vmem1 \
        -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
        -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-vmem2 \
        -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
        -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-vmem3 \
        -device cxl-upstream,bus=root_port1,id=us1 \
        -device cxl-downstream,port=4,bus=us1,id=swport4,chassis=0,slot=8 \
        -device cxl-type3,bus=swport4,volatile-memdev=cxl-mem4,id=cxl-vmem4 \
        -device cxl-downstream,port=5,bus=us1,id=swport5,chassis=0,slot=9 \
        -device cxl-type3,bus=swport5,volatile-memdev=cxl-mem5,id=cxl-vmem5 \
        -device cxl-downstream,port=6,bus=us1,id=swport6,chassis=0,slot=10 \
        -device cxl-type3,bus=swport6,volatile-memdev=cxl-mem6,id=cxl-vmem6 \
        -device cxl-downstream,port=7,bus=us1,id=swport7,chassis=0,slot=11 \
        -device cxl-type3,bus=swport7,volatile-memdev=cxl-mem7,id=cxl-vmem7 \
        -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=32G &

In Guest OS:
$ cxl create-region -d decoder0.0 -g 1024 -s 2G -t ram -w 8 -m mem4 mem1 mem6 mem3 mem2 mem5 mem7 mem0

Fix the method to calculate @distance by iterativeley multiplying the
number of targets per switch port. This also follows the algorithm
recommended here [1].

Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
Link: http://lore.kernel.org/6538824b52349_7258329466@dwillia2-xfh.jf.intel.com.notmuch [1]
Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>
[djbw: add a comment explaining 'distance']
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/173378716722.1270362.9546805175813426729.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7a9357f42dad..d7f7f88009d7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1167,6 +1167,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_switch_decoder *cxlsd;
+	struct cxl_port *iter = port;
 	u16 eig, peig;
 	u8 eiw, peiw;
 
@@ -1183,16 +1184,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 	cxlsd = to_cxl_switch_decoder(&cxld->dev);
 	if (cxl_rr->nr_targets_set) {
-		int i, distance;
+		int i, distance = 1;
+		struct cxl_region_ref *cxl_rr_iter;
 
 		/*
-		 * Passthrough decoders impose no distance requirements between
-		 * peers
+		 * The "distance" between peer downstream ports represents which
+		 * endpoint positions in the region interleave a given port can
+		 * host.
+		 *
+		 * For example, at the root of a hierarchy the distance is
+		 * always 1 as every index targets a different host-bridge. At
+		 * each subsequent switch level those ports map every Nth region
+		 * position where N is the width of the switch == distance.
 		 */
-		if (cxl_rr->nr_targets == 1)
-			distance = 0;
-		else
-			distance = p->nr_targets / cxl_rr->nr_targets;
+		do {
+			cxl_rr_iter = cxl_rr_load(iter, cxlr);
+			distance *= cxl_rr_iter->nr_targets;
+			iter = to_cxl_port(iter->dev.parent);
+		} while (!is_cxl_root(iter));
+		distance *= cxlrd->cxlsd.cxld.interleave_ways;
+
 		for (i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
 				rc = check_last_peer(cxled, ep, cxl_rr,
-- 
2.39.5




