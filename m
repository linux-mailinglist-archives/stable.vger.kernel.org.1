Return-Path: <stable+bounces-246570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJoyA2RxA2q55wEAu9opvQ
	(envelope-from <stable+bounces-246570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:28:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7092D5279B1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614C83175BFD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FD834E744;
	Tue, 12 May 2026 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="gWu2boyf"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6320317557E
	for <stable@vger.kernel.org>; Tue, 12 May 2026 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609565; cv=none; b=Jcaa3i0eBQLs7fot0iCdo/zrrEx6vV+0HBfV2ptzfZIX9KPtPP985NeRSdldBLd4JAMDyroblroeT1yp3x65Xh6+HZ7qnFzmjpmmWly1g1n3cEgfxdWD9qwbeN7dtaGgz4KOZaF+ORR70+9Zw1B8b6w2ZGDPZRFPf1es/j0UVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609565; c=relaxed/simple;
	bh=MUOVVO6mZtwbmG7pd0/JXFWZUsFCEQUEeSfw7P0MOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YUeX/EhTvkyshrDRKVpQ6xXa/rQzmFRKgUtXcVkfPCLfLKqyjGxq9RjK1Z+Uj6Em2m0heBHAYsX7jdaea4mygqkAJm5Smo5B17zVjFGzgeB3kbuHpY3M9CypZxn07xQAnRMmUuYUN5KB/QaSPnLoAVXQC38DTZJoJjOLvQujBgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=gWu2boyf; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fdFgQ/ZBiZyYXW7AgsaZl04rGnPpRCjyYbY7fGFESq8=; t=1778609564; x=1779473564; 
	b=gWu2boyfx25E/iwNFQZh2UNSy8NClNvtSbleV0LhcGZqXThPxVk9zMeZHdh8SbbZ8AKDXN1VsoS
	Ht4huD2wyLxbMxR15o68hRA6RnWkbrNXVYfDB5JeVhF/X5ZP0wnipC4WNiaVFWOYV0D182plDUyTZ
	/i+qp4hty708PDfHijv1XPNdOSgwtOCQIf9eF02OfYRm9wqcyHym2vDWFSXZPsnQExa+2Bz4Iqpw8
	MTue0/OetojGcVcQjrByMCZw0Syj++mgd/Bo1dElGmiQ+MrpdkiWT4lh2VaoP1K913at4agFZQqQV
	5J5c6z72m3PlXPYHzfvEZpSUCJB1OL0U9i/A==;
Received: from ouster448.stanford.edu ([172.24.72.71]:62163 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1wMrav-0003uV-46; Tue, 12 May 2026 11:12:38 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: ouster@cs.stanford.edu
Cc: stable@vger.kernel.org
Subject: [PATCH net-next v3] ice: fix packet corruption due to extraneous page flip
Date: Tue, 12 May 2026 11:12:28 -0700
Message-ID: <20260512181228.1619-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.1
X-Scan-Signature: 0858a923cc4ba3562bb802375c61c59b
X-Rspamd-Queue-Id: 7092D5279B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246570-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.892];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanford.edu:email,cs.stanford.edu:mid]
X-Rspamd-Action: no action

Consider the following sequence of events:
* The bottom half of a buffer page is filled with data from
  packet A. The page has a net reference count (reference count
  - bias) of 1. The page is returned to the NIC, flipped to
  use the top half.
* Before the reference on the page is released, the NIC returns
  the page with no data in it ('size' is zero in ice_clean_rx_irq).
  In this case the bias does not get decremented. The page still
  has a net reference count of 1, so it gets returned to the NIC.
  However, ice_put_rx_mbuf flipped the page so that the bottom
  half is active.
* If the NIC stores another packet in the page before packet A
  has released its reference, the data in packet A will be
  overwritten with data from the new packet.
* Unfortunately zero-length buffers occur frequently: they seem
  to occur whenever a packet uses every available byte in a
  buffer, ending precisely at the end of the buffer. When this
  happens the NIC seems to generate an extra zero-length
  buffer.
The fix is for ice_put_rx_mbuf not to flip pages that have a
size of 0.

This patch applies directly to longterm stable versions 6.18.27
and 6.12.86; it also seems relevant for 6.6.137 but would need
modifcations for that version. I have not examined earlier
versions.

Unfortunately there is no upstream commit id for this patch because
the ICE driver has undergone a major revision (libeth refactor and
pagepool conversion) that eliminated the buggy code. Thus the
problem no longer exists in the main line.

Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 51c459a3e722..081c7a7392b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1215,6 +1215,13 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		xdp_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
 
 	while (idx != ntc) {
+		union ice_32b_rx_flex_desc *rx_desc;
+		unsigned int size;
+
+		rx_desc = ICE_RX_DESC(rx_ring, idx);
+		size = le16_to_cpu(rx_desc->wb.pkt_len) &
+		       ICE_RX_FLX_DESC_PKT_LEN_M;
+
 		buf = &rx_ring->rx_buf[idx];
 		if (++idx == cnt)
 			idx = 0;
@@ -1224,10 +1231,20 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		 * To do this, only adjust pagecnt_bias for fragments up to
 		 * the total remaining after the XDP program has run.
 		 */
-		if (verdict != ICE_XDP_CONSUMED)
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		else if (i++ <= xdp_frags)
+		if (verdict != ICE_XDP_CONSUMED) {
+			/* Don't "flip" the page if size is 0: in this case
+			 * the data in the current half will not be used so
+			 * it's OK to reuse that half. And, since the bias
+			 * didn't get decremented for this half, the page can
+			 * be returned to the NIC even if the other half is
+			 * still in use, so flipping the page could cause
+			 * live packet data to be overwritten.
+			 */
+			if (size != 0)
+				ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
+		} else if (i++ <= xdp_frags) {
 			buf->pagecnt_bias++;
+		}
 
 		ice_put_rx_buf(rx_ring, buf);
 	}
-- 
2.43.0


