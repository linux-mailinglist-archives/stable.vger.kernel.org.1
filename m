Return-Path: <stable+bounces-84271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDC99CF5C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66462B2239F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E511C75E4;
	Mon, 14 Oct 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fF938+T2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421941C729E;
	Mon, 14 Oct 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917429; cv=none; b=ckkCXN9ktQM7aiqfeLH05daVJwANq4mYTsN0Mq7+MAA5N/aWtri9NjreCqFij3JDOoNFWkIOWMHw8nw78GAqWZx2cLRiPe9E1196XYZN+8YTnMlOSyzgrvpJK/nlayl+Me2Yzm1AVJPGyVeJtf8f4z0H9VzLD7QfVOFs7fruG6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917429; c=relaxed/simple;
	bh=+7TO0PI7VJHbF7RSzgR7/ndRXN5BlaI+8fHzySLVCc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7R7IKVx50ZByxlTYoldrj2lmMdP5hQ3qrqA/8o0SASU0vPdgzek+VGKayYlZebCCxZmzQ8HdgpbMHLGeMQp5T3fOGn9b9MhZ41bwGtv+/xPIQgTn+fumIuh16DXU7GeinsZyBB9Cbrwe7ZK2e47x/W27y4uKF1H0wmSDv68HLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fF938+T2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DE5C4CEC3;
	Mon, 14 Oct 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917429;
	bh=+7TO0PI7VJHbF7RSzgR7/ndRXN5BlaI+8fHzySLVCc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fF938+T2dBGp9BGOzqmDJ+yiP7xeJ9LN+oNG2vumHbZhIg4mlI/2UBmXpQnLWiRRk
	 dAQUr2JG3j5MYJSer8GjNGgyS1aXIesnhT5QMJu2wBgz3Gfb7en8ufQ4XdxV8AKwgu
	 xgib7mDfCucePaC5WZuT8+T3MhPd+XlWxFrxrroM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/798] perf/arm-cmn: Refactor node ID handling. Again.
Date: Mon, 14 Oct 2024 16:09:47 +0200
Message-ID: <20241014141219.246471262@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit e79634b53e398966c49f803c49701bc74dc3ccf8 ]

The scope of the "extra device ports" configuration is not made clear by
the CMN documentation - so far we've assumed it applies globally, based
on the sole example which suggests as much. However it transpires that
this is incorrect, and the format does in fact vary based on each
individual XP's port configuration. As a consequence, we're currenly
liable to decode the port/device indices from a node ID incorrectly,
thus program the wrong event source in the DTM leading to bogus event
counts, and also show device topology on the wrong ports in debugfs.

To put this right, rework node IDs yet again to carry around the
additional data necessary to decode them properly per-XP. At this point
the notion of fully decomposing an ID becomes more impractical than it's
worth, so unabstracting the XY mesh coordinates (where 2/3 users were
just debug anyway) ends up leaving things a bit simpler overall.

Fixes: 60d1504070c2 ("perf/arm-cmn: Support new IP features")
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/5195f990152fc37adba5fbf5929a6b11063d9f09.1725296395.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 94 ++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 54 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 5ddb6a8611d8c..60bca69bb3592 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -24,14 +24,6 @@
 #define CMN_NI_NODE_ID			GENMASK_ULL(31, 16)
 #define CMN_NI_LOGICAL_ID		GENMASK_ULL(47, 32)
 
-#define CMN_NODEID_DEVID(reg)		((reg) & 3)
-#define CMN_NODEID_EXT_DEVID(reg)	((reg) & 1)
-#define CMN_NODEID_PID(reg)		(((reg) >> 2) & 1)
-#define CMN_NODEID_EXT_PID(reg)		(((reg) >> 1) & 3)
-#define CMN_NODEID_1x1_PID(reg)		(((reg) >> 2) & 7)
-#define CMN_NODEID_X(reg, bits)		((reg) >> (3 + (bits)))
-#define CMN_NODEID_Y(reg, bits)		(((reg) >> 3) & ((1U << (bits)) - 1))
-
 #define CMN_CHILD_INFO			0x0080
 #define CMN_CI_CHILD_COUNT		GENMASK_ULL(15, 0)
 #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
@@ -273,8 +265,11 @@ struct arm_cmn_node {
 	u16 id, logid;
 	enum cmn_node_type type;
 
+	/* XP properties really, but replicated to children for convenience */
 	u8 dtm;
 	s8 dtc;
+	u8 portid_bits:4;
+	u8 deviceid_bits:4;
 	/* DN/HN-F/CXHA */
 	struct {
 		u8 val : 4;
@@ -350,49 +345,33 @@ struct arm_cmn {
 static int arm_cmn_hp_state;
 
 struct arm_cmn_nodeid {
-	u8 x;
-	u8 y;
 	u8 port;
 	u8 dev;
 };
 
 static int arm_cmn_xyidbits(const struct arm_cmn *cmn)
 {
-	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1) | 2);
+	return fls((cmn->mesh_x - 1) | (cmn->mesh_y - 1));
 }
 
-static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn *cmn, u16 id)
+static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn_node *dn)
 {
 	struct arm_cmn_nodeid nid;
 
-	if (cmn->num_xps == 1) {
-		nid.x = 0;
-		nid.y = 0;
-		nid.port = CMN_NODEID_1x1_PID(id);
-		nid.dev = CMN_NODEID_DEVID(id);
-	} else {
-		int bits = arm_cmn_xyidbits(cmn);
-
-		nid.x = CMN_NODEID_X(id, bits);
-		nid.y = CMN_NODEID_Y(id, bits);
-		if (cmn->ports_used & 0xc) {
-			nid.port = CMN_NODEID_EXT_PID(id);
-			nid.dev = CMN_NODEID_EXT_DEVID(id);
-		} else {
-			nid.port = CMN_NODEID_PID(id);
-			nid.dev = CMN_NODEID_DEVID(id);
-		}
-	}
+	nid.dev = dn->id & ((1U << dn->deviceid_bits) - 1);
+	nid.port = (dn->id >> dn->deviceid_bits) & ((1U << dn->portid_bits) - 1);
 	return nid;
 }
 
 static struct arm_cmn_node *arm_cmn_node_to_xp(const struct arm_cmn *cmn,
 					       const struct arm_cmn_node *dn)
 {
-	struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
-	int xp_idx = cmn->mesh_x * nid.y + nid.x;
+	int id = dn->id >> (dn->portid_bits + dn->deviceid_bits);
+	int bits = arm_cmn_xyidbits(cmn);
+	int x = id >> bits;
+	int y = id & ((1U << bits) - 1);
 
-	return cmn->xps + xp_idx;
+	return cmn->xps + cmn->mesh_x * y + x;
 }
 static struct arm_cmn_node *arm_cmn_node(const struct arm_cmn *cmn,
 					 enum cmn_node_type type)
@@ -478,13 +457,13 @@ static const char *arm_cmn_device_type(u8 type)
 	}
 }
 
-static void arm_cmn_show_logid(struct seq_file *s, int x, int y, int p, int d)
+static void arm_cmn_show_logid(struct seq_file *s, const struct arm_cmn_node *xp, int p, int d)
 {
 	struct arm_cmn *cmn = s->private;
 	struct arm_cmn_node *dn;
+	u16 id = xp->id | d | (p << xp->deviceid_bits);
 
 	for (dn = cmn->dns; dn->type; dn++) {
-		struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
 		int pad = dn->logid < 10;
 
 		if (dn->type == CMN_TYPE_XP)
@@ -493,7 +472,7 @@ static void arm_cmn_show_logid(struct seq_file *s, int x, int y, int p, int d)
 		if (dn->type < CMN_TYPE_HNI)
 			continue;
 
-		if (nid.x != x || nid.y != y || nid.port != p || nid.dev != d)
+		if (dn->id != id)
 			continue;
 
 		seq_printf(s, " %*c#%-*d  |", pad + 1, ' ', 3 - pad, dn->logid);
@@ -514,6 +493,7 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 	y = cmn->mesh_y;
 	while (y--) {
 		int xp_base = cmn->mesh_x * y;
+		struct arm_cmn_node *xp = cmn->xps + xp_base;
 		u8 port[CMN_MAX_PORTS][CMN_MAX_DIMENSION];
 
 		for (x = 0; x < cmn->mesh_x; x++)
@@ -521,16 +501,14 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 
 		seq_printf(s, "\n%-2d   |", y);
 		for (x = 0; x < cmn->mesh_x; x++) {
-			struct arm_cmn_node *xp = cmn->xps + xp_base + x;
-
 			for (p = 0; p < CMN_MAX_PORTS; p++)
-				port[p][x] = arm_cmn_device_connect_info(cmn, xp, p);
+				port[p][x] = arm_cmn_device_connect_info(cmn, xp + x, p);
 			seq_printf(s, " XP #%-3d|", xp_base + x);
 		}
 
 		seq_puts(s, "\n     |");
 		for (x = 0; x < cmn->mesh_x; x++) {
-			s8 dtc = cmn->xps[xp_base + x].dtc;
+			s8 dtc = xp[x].dtc;
 
 			if (dtc < 0)
 				seq_puts(s, " DTC ?? |");
@@ -547,10 +525,10 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 				seq_puts(s, arm_cmn_device_type(port[p][x]));
 			seq_puts(s, "\n    0|");
 			for (x = 0; x < cmn->mesh_x; x++)
-				arm_cmn_show_logid(s, x, y, p, 0);
+				arm_cmn_show_logid(s, xp + x, p, 0);
 			seq_puts(s, "\n    1|");
 			for (x = 0; x < cmn->mesh_x; x++)
-				arm_cmn_show_logid(s, x, y, p, 1);
+				arm_cmn_show_logid(s, xp + x, p, 1);
 		}
 		seq_puts(s, "\n-----+");
 	}
@@ -1629,10 +1607,7 @@ static int arm_cmn_event_init(struct perf_event *event)
 	}
 
 	if (!hw->num_dns) {
-		struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, nodeid);
-
-		dev_dbg(cmn->dev, "invalid node 0x%x (%d,%d,%d,%d) type 0x%x\n",
-			nodeid, nid.x, nid.y, nid.port, nid.dev, type);
+		dev_dbg(cmn->dev, "invalid node 0x%x type 0x%x\n", nodeid, type);
 		return -EINVAL;
 	}
 
@@ -1727,7 +1702,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 			dtm->wp_event[wp_idx] = hw->dtc_idx[d];
 			writel_relaxed(cfg, dtm->base + CMN_DTM_WPn_CONFIG(wp_idx));
 		} else {
-			struct arm_cmn_nodeid nid = arm_cmn_nid(cmn, dn->id);
+			struct arm_cmn_nodeid nid = arm_cmn_nid(dn);
 
 			if (cmn->multi_dtm)
 				nid.port %= 2;
@@ -1973,10 +1948,12 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
 			continue;
 
 		xp = arm_cmn_node_to_xp(cmn, dn);
+		dn->portid_bits = xp->portid_bits;
+		dn->deviceid_bits = xp->deviceid_bits;
 		dn->dtc = xp->dtc;
 		dn->dtm = xp->dtm;
 		if (cmn->multi_dtm)
-			dn->dtm += arm_cmn_nid(cmn, dn->id).port / 2;
+			dn->dtm += arm_cmn_nid(dn).port / 2;
 
 		if (dn->type == CMN_TYPE_DTC) {
 			int err = arm_cmn_init_dtc(cmn, dn, dtc_idx++);
@@ -2146,18 +2123,27 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		arm_cmn_init_dtm(dtm++, xp, 0);
 		/*
 		 * Keeping track of connected ports will let us filter out
-		 * unnecessary XP events easily. We can also reliably infer the
-		 * "extra device ports" configuration for the node ID format
-		 * from this, since in that case we will see at least one XP
-		 * with port 2 connected, for the HN-D.
+		 * unnecessary XP events easily, and also infer the per-XP
+		 * part of the node ID format.
 		 */
 		for (int p = 0; p < CMN_MAX_PORTS; p++)
 			if (arm_cmn_device_connect_info(cmn, xp, p))
 				xp_ports |= BIT(p);
 
-		if (cmn->multi_dtm && (xp_ports & 0xc))
+		if (cmn->num_xps == 1) {
+			xp->portid_bits = 3;
+			xp->deviceid_bits = 2;
+		} else if (xp_ports > 0x3) {
+			xp->portid_bits = 2;
+			xp->deviceid_bits = 1;
+		} else {
+			xp->portid_bits = 1;
+			xp->deviceid_bits = 2;
+		}
+
+		if (cmn->multi_dtm && (xp_ports > 0x3))
 			arm_cmn_init_dtm(dtm++, xp, 1);
-		if (cmn->multi_dtm && (xp_ports & 0x30))
+		if (cmn->multi_dtm && (xp_ports > 0xf))
 			arm_cmn_init_dtm(dtm++, xp, 2);
 
 		cmn->ports_used |= xp_ports;
-- 
2.43.0




