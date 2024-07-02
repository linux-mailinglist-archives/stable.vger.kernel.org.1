Return-Path: <stable+bounces-56587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5BF924519
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE571C226FD
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394F1C0DE3;
	Tue,  2 Jul 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hDeK8CW+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50341C0056;
	Tue,  2 Jul 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940678; cv=none; b=nxfJCmI47rx8nM4YLlXjeoCly5/VUduwqh3hiKruH6g/bVgUQHRv1xPEAUf9XewfyUL7hYEBPOOqJVccXpRaRWTKRtBiZOGSi6VwOdGDGqmbsdPtPC8qlgKrPp21Cycj5TFN3iaXd+udd3m8Sj8S+wkcV39OgGw0t8B44K5avH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940678; c=relaxed/simple;
	bh=j8gphsF72wGb6c+RIcIIb5/oWBy4mDPO7v30FgM7ofE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZM36999lWAjcC1YR5ESxwDA66gomGMnh91FvvhiQZaiohujUNh3ihPBPO+8I/C6jYR9B/VRHhS6xOzZu0lRnGXDBVB28MdUw7mcqJriMO518jofrJHP1dzGl43myB0q5IQTsxfKj4UzqOTX5xWHbeldvrsM/CRaXKHkwXrIHeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hDeK8CW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D03C116B1;
	Tue,  2 Jul 2024 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940678;
	bh=j8gphsF72wGb6c+RIcIIb5/oWBy4mDPO7v30FgM7ofE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDeK8CW+53/Keo5fEGvkE75lByeeVeGC2ZDp5XQiCQqdufLxzGnrSQbOXDZTPNhXw
	 XxEpDlekxOF81ba6AdGNhbySx3JI/p1/45yKxtmKo0F1C+rnKbffvj6D7YNWdbSZe0
	 3v8Axg5X0e8c+lPORrzQfYEwXxaoLgoScmOEA8P0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 220/222] cxl/region: check interleave capability
Date: Tue,  2 Jul 2024 19:04:18 +0200
Message-ID: <20240702170252.397109419@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

[ Upstream commit 84328c5acebc10c8cdcf17283ab6c6d548885bfc ]

Since interleave capability is not verified, if the interleave
capability of a target does not match the region need, committing decoder
should have failed at the device end.

In order to checkout this error as quickly as possible, driver needs
to check the interleave capability of target during attaching it to
region.

Per CXL specification r3.1(8.2.4.20.1 CXL HDM Decoder Capability Register),
bits 11 and 12 indicate the capability to establish interleaving in 3, 6,
12 and 16 ways. If these bits are not set, the target cannot be attached to
a region utilizing such interleave ways.

Additionally, bits 8 and 9 represent the capability of the bits used for
interleaving in the address, Linux tracks this in the cxl_port
interleave_mask.

Per CXL specification r3.1(8.2.4.20.13 Decoder Protection):
  eIW means encoded Interleave Ways.
  eIG means encoded Interleave Granularity.

  in HPA:
  if eIW is 0 or 8 (interleave ways: 1, 3), all the bits of HPA are used,
  the interleave bits are none, the following check is ignored.

  if eIW is less than 8 (interleave ways: 2, 4, 8, 16), the interleave bits
  start at bit position eIG + 8 and end at eIG + eIW + 8 - 1.

  if eIW is greater than 8 (interleave ways: 6, 12), the interleave bits
  start at bit position eIG + 8 and end at eIG + eIW - 1.

  if the interleave mask is insufficient to cover the required interleave
  bits, the target cannot be attached to the region.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20240614084755.59503-2-yaoxt.fnst@fujitsu.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/hdm.c       | 13 ++++++
 drivers/cxl/core/region.c    | 82 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h            |  2 +
 drivers/cxl/cxlmem.h         | 10 +++++
 tools/testing/cxl/test/cxl.c |  4 ++
 5 files changed, 111 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d7..e01c16fdc7575 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -52,6 +52,14 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 	struct cxl_dport *dport = NULL;
 	int single_port_map[1];
 	unsigned long index;
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+
+	/*
+	 * Capability checks are moot for passthrough decoders, support
+	 * any and all possibilities.
+	 */
+	cxlhdm->interleave_mask = ~0U;
+	cxlhdm->iw_cap_mask = ~0UL;
 
 	cxlsd = cxl_switch_decoder_alloc(port, 1);
 	if (IS_ERR(cxlsd))
@@ -79,6 +87,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(11, 8);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
+	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
+		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
+		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a083893c0afe0..a600feb8a4ed5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1101,6 +1101,26 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	}
 	cxld = cxl_rr->decoder;
 
+	/*
+	 * the number of targets should not exceed the target_count
+	 * of the decoder
+	 */
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd;
+
+		cxlsd = to_cxl_switch_decoder(&cxld->dev);
+		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s %s add: %s:%s @ %d overflows targets: %d\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				dev_name(&cxld->dev), dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev), pos,
+				cxlsd->nr_targets);
+			rc = -ENXIO;
+			goto out_erase;
+		}
+	}
+
 	rc = cxl_rr_ep_add(cxl_rr, cxled);
 	if (rc) {
 		dev_dbg(&cxlr->dev,
@@ -1210,6 +1230,50 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	unsigned int interleave_mask;
+	u8 eiw;
+	u16 eig;
+	int high_pos, low_pos;
+
+	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
+		return -ENXIO;
+	/*
+	 * Per CXL specification r3.1(8.2.4.20.13 Decoder Protection),
+	 * if eiw < 8:
+	 *   DPAOFFSET[51: eig + 8] = HPAOFFSET[51: eig + 8 + eiw]
+	 *   DPAOFFSET[eig + 7: 0]  = HPAOFFSET[eig + 7: 0]
+	 *
+	 *   when the eiw is 0, all the bits of HPAOFFSET[51: 0] are used, the
+	 *   interleave bits are none.
+	 *
+	 * if eiw >= 8:
+	 *   DPAOFFSET[51: eig + 8] = HPAOFFSET[51: eig + eiw] / 3
+	 *   DPAOFFSET[eig + 7: 0]  = HPAOFFSET[eig + 7: 0]
+	 *
+	 *   when the eiw is 8, all the bits of HPAOFFSET[51: 0] are used, the
+	 *   interleave bits are none.
+	 */
+	ways_to_eiw(iw, &eiw);
+	if (eiw == 0 || eiw == 8)
+		return 0;
+
+	granularity_to_eig(ig, &eig);
+	if (eiw > 8)
+		high_pos = eiw + eig - 1;
+	else
+		high_pos = eiw + eig + 7;
+	low_pos = eig + 8;
+	interleave_mask = GENMASK(high_pos, low_pos);
+	if (interleave_mask & ~cxlhdm->interleave_mask)
+		return -ENXIO;
+
+	return 0;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1360,6 +1424,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			return -ENXIO;
 		}
 	} else {
+		rc = check_interleave_cap(cxld, iw, ig);
+		if (rc) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s iw: %d ig: %d is not supported\n",
+				dev_name(port->uport_dev),
+				dev_name(&port->dev), iw, ig);
+			return rc;
+		}
+
 		cxld->interleave_ways = iw;
 		cxld->interleave_granularity = ig;
 		cxld->hpa_range = (struct range) {
@@ -1796,6 +1869,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 
+	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
+				  p->interleave_granularity);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
+			dev_name(&cxled->cxld.dev), p->interleave_ways,
+			p->interleave_granularity);
+		return rc;
+	}
+
 	if (cxled->mode != cxlr->mode) {
 		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
 			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2b82dcaf70aa6..6f9270f2faf96 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -45,6 +45,8 @@
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
 #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 36cee9c30cebd..07e65a7605f3e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -848,11 +848,21 @@ static inline void cxl_mem_active_dec(void)
 
 int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
 
+/**
+ * struct cxl_hdm - HDM Decoder registers and cached / decoded capabilities
+ * @regs: mapped registers, see devm_cxl_setup_hdm()
+ * @decoder_count: number of decoders for this port
+ * @target_count: for switch decoders, max downstream port targets
+ * @interleave_mask: interleave granularity capability, see check_interleave_cap()
+ * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
+ * @port: mapped cxl_port, see devm_cxl_setup_hdm()
+ */
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
+	unsigned long iw_cap_mask;
 	struct cxl_port *port;
 };
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3482248aa3442..90d5afd52dd06 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -630,11 +630,15 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
 					  struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
+	struct device *dev = &port->dev;
 
 	if (!cxlhdm)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	cxlhdm->interleave_mask = ~0U;
+	cxlhdm->iw_cap_mask = ~0UL;
+	dev_set_drvdata(dev, cxlhdm);
 	return cxlhdm;
 }
 
-- 
2.43.0




