Return-Path: <stable+bounces-242417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN3oIEOd9GloCwIAu9opvQ
	(envelope-from <stable+bounces-242417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:32:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43D4AC6B2
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36C523026C20
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABBA1AA1F4;
	Fri,  1 May 2026 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4XPZrTw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28C1FC7
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638619; cv=none; b=bysyUp0QecFwZQdB2LvnQmUqqkrZxYGXc72Ubg+ptlT0HGCOqHsRA4SebRD/tOfUBlFUwmoqat7o5m+y4/5UdICtk0mCtPkkVE9rHbxEG8yHP4zxgSi2y6V5z4xvWzFglO6LgWAMbUOWFMlbSeIRLUpsonvL1xiyhm+fO84UcOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638619; c=relaxed/simple;
	bh=uNUctGSRkRpDy9lfLD8YlsPaDB7xAb6aoTc3llDyeYM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sb10mzFi44eYtsJjPJJZi7VSA7GC4lTy+l2HcO7HxhyfCOD9mXMugpwiHXfGy3rXWAMQcW0lUERf7GdIvcn2VmBUUcyxUVDhPDX/mysghF7PSC/J+2+bPkQF1ESCdDdbBfD3baetOu32S0zZCXmlVJJfzUCPid3xAN7+dGIExqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4XPZrTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FBCC2BCB4;
	Fri,  1 May 2026 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777638619;
	bh=uNUctGSRkRpDy9lfLD8YlsPaDB7xAb6aoTc3llDyeYM=;
	h=Subject:To:Cc:From:Date:From;
	b=B4XPZrTw0ttHMCgwMX43OmWzzH03JSfgcoLVPchFq1Zwr94kmmIGu0merwOWYCXKb
	 tsAbk5NRLyelPaGQg4ygzWX2Q+O7ckXBbEpxlv3v4Gplx2keEC+0K+7BjhUiRqbd7d
	 bKAYQe7uBHvXk/OcEWSJ6IPYcTF5w6MoLQdpFZ8k=
Subject: FAILED: patch "[PATCH] octeon_ep_vf: add NULL check for napi_build_skb()" failed to apply to 7.0-stable tree
To: devnexen@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:29:48 +0200
Message-ID: <2026050148-renounce-robin-688e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D43D4AC6B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242417-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x dd66b42854705e4e4ee7f14d260f86c578bed3e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050148-renounce-robin-688e@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd66b42854705e4e4ee7f14d260f86c578bed3e3 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Thu, 9 Apr 2026 19:40:09 +0100
Subject: [PATCH] octeon_ep_vf: add NULL check for napi_build_skb()

napi_build_skb() can return NULL on allocation failure. In
__octep_vf_oq_process_rx(), the result is used directly without a NULL
check in both the single-buffer and multi-fragment paths, leading to a
NULL pointer dereference.

Add NULL checks after both napi_build_skb() calls, properly advancing
descriptors and consuming remaining fragments on failure.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260409184009.930359-3-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index 7bd1b9b8d7f5..d98247408242 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -414,10 +414,15 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
-		rx_bytes += buff_info->len;
-
 		if (buff_info->len <= oq->max_single_buffer_size) {
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				desc_used++;
+				read_idx = octep_vf_oq_next_idx(oq, read_idx);
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
 			desc_used++;
@@ -427,6 +432,27 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			u16 data_len;
 
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				desc_used++;
+				read_idx = octep_vf_oq_next_idx(oq, read_idx);
+				data_len = buff_info->len - oq->max_single_buffer_size;
+				while (data_len) {
+					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+						       PAGE_SIZE, DMA_FROM_DEVICE);
+					buff_info = (struct octep_vf_rx_buffer *)
+						    &oq->buff_info[read_idx];
+					buff_info->page = NULL;
+					if (data_len < oq->buffer_size)
+						data_len = 0;
+					else
+						data_len -= oq->buffer_size;
+					desc_used++;
+					read_idx = octep_vf_oq_next_idx(oq, read_idx);
+				}
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.


