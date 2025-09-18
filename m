Return-Path: <stable+bounces-177300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F8CB404B3
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941DC18847BF
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0A832ED39;
	Tue,  2 Sep 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="am5GcSWL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DBB32ED25;
	Tue,  2 Sep 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820210; cv=none; b=ARhoPnlg4BXls68zbUTIjeeigQ/uV4lL3lL/Wp5FlP8oWrtkqz2YOozKVVmIkD0ERJNO7GNlx+lqzgx69kHCh2Ox9cpANUc2v3kEhSPO2byyy2yWXnxFIuJ0tv+EuR7dIIRtJ1/g2TVI8mptgukrisq7iSIArXep81o3TGGfMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820210; c=relaxed/simple;
	bh=NW8RcqN8bmlBWPMJPIiWnsVToIn9fQYTNDEMrNHMe5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prj1lUr1npQ1UoVk4FDPCHEh/qipkrAm6P9BBS/ksFLx3pw/BCw0fq9ou3iYzeND+ZMx/XRmaXNXf08ZReqWnHPblaz0v2a7mGi6WVp1Z8VwvH06y7z+aO9QS5zBN8eDAJ5zTIdUeKXdhW6CYOVnvkl07VptdIKEbvQRL+/jk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=am5GcSWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17BBC4CEF4;
	Tue,  2 Sep 2025 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756820210;
	bh=NW8RcqN8bmlBWPMJPIiWnsVToIn9fQYTNDEMrNHMe5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=am5GcSWL7ppK/MJheRN9tFaOOgRZr7d/PkQs1t4z8rkksQPHyJZhbwwxCCOAXfhx4
	 5DcDtfKhGVVH6egMkAhKftyN9R5Jzq1ghIaBgfld6haTTUWwKyg6vFoUpXDD7CIZjT
	 xSR/sXwFksGqNG/Co+9Va7WtnPl0NvCcWv5LJstQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH 6.6 31/75] ice: stop storing XDP verdict within ice_rx_buf
Date: Tue,  2 Sep 2025 15:20:43 +0200
Message-ID: <20250902131936.341138004@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
References: <20250902131935.107897242@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit 468a1952df78f65c5991b7ac885c8b5b7dd87bab ]

Idea behind having ice_rx_buf::act was to simplify and speed up the Rx
data path by walking through buffers that were representing cleaned HW
Rx descriptors. Since it caused us a major headache recently and we
rolled back to old approach that 'puts' Rx buffers right after running
XDP prog/creating skb, this is useless now and should be removed.

Get rid of ice_rx_buf::act and related logic. We still need to take care
of a corner case where XDP program releases a particular fragment.

Make ice_run_xdp() to return its result and use it within
ice_put_rx_mbuf().

Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: b1a0c977c6f1 ("ice: fix incorrect counter for buffer allocation failures")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 62 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 43 -------------
 3 files changed, 36 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index beb5c8643fe7d..e7084c6aab6da 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -527,15 +527,14 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
  * @xdp: xdp_buff used as input to the XDP program
  * @xdp_prog: XDP program to run
  * @xdp_ring: ring to be used for XDP_TX action
- * @rx_buf: Rx buffer to store the XDP action
  * @eop_desc: Last descriptor in packet to read metadata from
  *
  * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
  */
-static void
+static u32
 ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
-	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
+	    union ice_32b_rx_flex_desc *eop_desc)
 {
 	unsigned int ret = ICE_XDP_PASS;
 	u32 act;
@@ -574,7 +573,7 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		ret = ICE_XDP_CONSUMED;
 	}
 exit:
-	ice_set_rx_bufs_act(xdp, rx_ring, ret);
+	return ret;
 }
 
 /**
@@ -860,10 +859,8 @@ ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		xdp_buff_set_frags_flag(xdp);
 	}
 
-	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
-		ice_set_rx_bufs_act(xdp, rx_ring, ICE_XDP_CONSUMED);
+	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS))
 		return -ENOMEM;
-	}
 
 	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
 				   rx_buf->page_offset, size);
@@ -1076,12 +1073,12 @@ ice_construct_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
 				rx_buf->page_offset + headlen, size,
 				xdp->frame_sz);
 	} else {
-		/* buffer is unused, change the act that should be taken later
-		 * on; data was copied onto skb's linear part so there's no
+		/* buffer is unused, restore biased page count in Rx buffer;
+		 * data was copied onto skb's linear part so there's no
 		 * need for adjusting page offset and we can reuse this buffer
 		 * as-is
 		 */
-		rx_buf->act = ICE_SKB_CONSUMED;
+		rx_buf->pagecnt_bias++;
 	}
 
 	if (unlikely(xdp_buff_has_frags(xdp))) {
@@ -1134,29 +1131,34 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
  * @xdp: XDP buffer carrying linear + frags part
  * @xdp_xmit: XDP_TX/XDP_REDIRECT verdict storage
  * @ntc: a current next_to_clean value to be stored at rx_ring
+ * @verdict: return code from XDP program execution
  *
  * Walk through gathered fragments and satisfy internal page
  * recycle mechanism; we take here an action related to verdict
  * returned by XDP program;
  */
 static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
-			    u32 *xdp_xmit, u32 ntc)
+			    u32 *xdp_xmit, u32 ntc, u32 verdict)
 {
 	u32 nr_frags = rx_ring->nr_frags + 1;
 	u32 idx = rx_ring->first_desc;
 	u32 cnt = rx_ring->count;
+	u32 post_xdp_frags = 1;
 	struct ice_rx_buf *buf;
 	int i;
 
-	for (i = 0; i < nr_frags; i++) {
+	if (unlikely(xdp_buff_has_frags(xdp)))
+		post_xdp_frags += xdp_get_shared_info_from_buff(xdp)->nr_frags;
+
+	for (i = 0; i < post_xdp_frags; i++) {
 		buf = &rx_ring->rx_buf[idx];
 
-		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
+		if (verdict & (ICE_XDP_TX | ICE_XDP_REDIR)) {
 			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-			*xdp_xmit |= buf->act;
-		} else if (buf->act & ICE_XDP_CONSUMED) {
+			*xdp_xmit |= verdict;
+		} else if (verdict & ICE_XDP_CONSUMED) {
 			buf->pagecnt_bias++;
-		} else if (buf->act == ICE_XDP_PASS) {
+		} else if (verdict == ICE_XDP_PASS) {
 			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
 		}
 
@@ -1165,6 +1167,17 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		if (++idx == cnt)
 			idx = 0;
 	}
+	/* handle buffers that represented frags released by XDP prog;
+	 * for these we keep pagecnt_bias as-is; refcount from struct page
+	 * has been decremented within XDP prog and we do not have to increase
+	 * the biased refcnt
+	 */
+	for (; i < nr_frags; i++) {
+		buf = &rx_ring->rx_buf[idx];
+		ice_put_rx_buf(rx_ring, buf);
+		if (++idx == cnt)
+			idx = 0;
+	}
 
 	xdp->data = NULL;
 	rx_ring->first_desc = ntc;
@@ -1191,9 +1204,9 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	struct ice_tx_ring *xdp_ring = NULL;
 	struct bpf_prog *xdp_prog = NULL;
 	u32 ntc = rx_ring->next_to_clean;
+	u32 cached_ntu, xdp_verdict;
 	u32 cnt = rx_ring->count;
 	u32 xdp_xmit = 0;
-	u32 cached_ntu;
 	bool failure;
 
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
@@ -1257,7 +1270,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
 			xdp_buff_clear_frags_flag(xdp);
 		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
-			ice_put_rx_mbuf(rx_ring, xdp, NULL, ntc);
+			ice_put_rx_mbuf(rx_ring, xdp, NULL, ntc, ICE_XDP_CONSUMED);
 			break;
 		}
 		if (++ntc == cnt)
@@ -1268,13 +1281,13 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			continue;
 
 		ice_get_pgcnts(rx_ring);
-		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
-		if (rx_buf->act == ICE_XDP_PASS)
+		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
+		if (xdp_verdict == ICE_XDP_PASS)
 			goto construct_skb;
 		total_rx_bytes += xdp_get_buff_len(xdp);
 		total_rx_pkts++;
 
-		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc);
+		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
 
 		continue;
 construct_skb:
@@ -1285,12 +1298,9 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
 			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
-			rx_buf->act = ICE_XDP_CONSUMED;
-			if (unlikely(xdp_buff_has_frags(xdp)))
-				ice_set_rx_bufs_act(xdp, rx_ring,
-						    ICE_XDP_CONSUMED);
+			xdp_verdict = ICE_XDP_CONSUMED;
 		}
-		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc);
+		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit, ntc, xdp_verdict);
 
 		if (!skb)
 			break;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index ad2d286bd359d..53a155dde3e32 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -201,7 +201,6 @@ struct ice_rx_buf {
 	struct page *page;
 	unsigned int page_offset;
 	unsigned int pgcnt;
-	unsigned int act;
 	unsigned int pagecnt_bias;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 00971f8491358..41efafc5eb386 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -5,49 +5,6 @@
 #define _ICE_TXRX_LIB_H_
 #include "ice.h"
 
-/**
- * ice_set_rx_bufs_act - propagate Rx buffer action to frags
- * @xdp: XDP buffer representing frame (linear and frags part)
- * @rx_ring: Rx ring struct
- * act: action to store onto Rx buffers related to XDP buffer parts
- *
- * Set action that should be taken before putting Rx buffer from first frag
- * to the last.
- */
-static inline void
-ice_set_rx_bufs_act(struct xdp_buff *xdp, const struct ice_rx_ring *rx_ring,
-		    const unsigned int act)
-{
-	u32 sinfo_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
-	u32 nr_frags = rx_ring->nr_frags + 1;
-	u32 idx = rx_ring->first_desc;
-	u32 cnt = rx_ring->count;
-	struct ice_rx_buf *buf;
-
-	for (int i = 0; i < nr_frags; i++) {
-		buf = &rx_ring->rx_buf[idx];
-		buf->act = act;
-
-		if (++idx == cnt)
-			idx = 0;
-	}
-
-	/* adjust pagecnt_bias on frags freed by XDP prog */
-	if (sinfo_frags < rx_ring->nr_frags && act == ICE_XDP_CONSUMED) {
-		u32 delta = rx_ring->nr_frags - sinfo_frags;
-
-		while (delta) {
-			if (idx == 0)
-				idx = cnt - 1;
-			else
-				idx--;
-			buf = &rx_ring->rx_buf[idx];
-			buf->pagecnt_bias--;
-			delta--;
-		}
-	}
-}
-
 /**
  * ice_test_staterr - tests bits in Rx descriptor status and error fields
  * @status_err_n: Rx descriptor status_error0 or status_error1 bits
-- 
2.50.1




