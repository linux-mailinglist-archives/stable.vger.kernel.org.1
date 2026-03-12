Return-Path: <stable+bounces-225128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAolOgYhs2mpSQAAu9opvQ
	(envelope-from <stable+bounces-225128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E2278FBB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA10230236AB
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74835A3A9;
	Thu, 12 Mar 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O0BM+1RH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E72D0606;
	Thu, 12 Mar 2026 20:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347074; cv=none; b=G1o/z29k4PVE00JIDE8xQNer9d9N1E+/HTM+lD9ff25UtxoIkU00EdIibjifwdAiiJesyojZZnYfVdh5bjab9tVU/ShQtjJT2DKTP3QKg6S9KDkvgtFY9pHv90+XRi21J57gvHhwEM3BVEx8kfi/pMmvdiYi59BCoKiFB+LK/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347074; c=relaxed/simple;
	bh=T9kEJNonYVDLJr/jYYgITPEukiPgXL6MSqAFcXHLgFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUQnb/GvMXpx2tGukiItlY4AGXiKJrElu7aqdvh2ec1frMEB2Ddqh5soCSPgaS2MeaWOlQbqYOMTIO84whI+ANn7xl0zVosYFjRx+3B8RtvnwdXHVFL5Ynv/9R5m1hOTI/A0RLXs3dD5GJ/0u2qCcp0nFa3Fh9UpsPIalK4mp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O0BM+1RH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3415EC4CEF7;
	Thu, 12 Mar 2026 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347074;
	bh=T9kEJNonYVDLJr/jYYgITPEukiPgXL6MSqAFcXHLgFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0BM+1RHjbyFHlu2oYfuPRJJcJ33WAB6jM7wyXZgFvEkFO1EhUO3AzNy5VG+F4xuY
	 qBb8lz+M4+PvEkLjpaGyZLPfsKu6OBngoVgb2BE74F4harc8pmJ57xBp9eewRnK2SZ
	 S34SvK2OBVqjCmyQ7qnBH46RJt4VtNK2o3XZsiNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Nikhil P. Rao" <nikhil.rao@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 188/265] xsk: Fix zero-copy AF_XDP fragment drop
Date: Thu, 12 Mar 2026 21:09:35 +0100
Message-ID: <20260312201025.104015013@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225128-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 824E2278FBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikhil P. Rao <nikhil.rao@amd.com>

[ Upstream commit f7387d6579d65efd490a864254101cb665f2e7a7 ]

AF_XDP should ensure that only a complete packet is sent to application.
In the zero-copy case, if the Rx queue gets full as fragments are being
enqueued, the remaining fragments are dropped.

For the multi-buffer case, add a check to ensure that the Rx queue has
enough space for all fragments of a packet before starting to enqueue
them.

Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Link: https://patch.msgid.link/20260225000456.107806-3-nikhil.rao@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 158c92918bc3a..ed1aeaded9be7 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -159,25 +159,31 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 	struct xdp_buff_xsk *pos, *tmp;
 	struct list_head *xskb_list;
 	u32 contd = 0;
+	u32 num_desc;
 	int err;
 
-	if (frags)
-		contd = XDP_PKT_CONTD;
+	if (likely(!frags)) {
+		err = __xsk_rcv_zc(xs, xskb, len, contd);
+		if (err)
+			goto err;
+		return 0;
+	}
 
-	err = __xsk_rcv_zc(xs, xskb, len, contd);
-	if (err)
+	contd = XDP_PKT_CONTD;
+	num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
+	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
+		xs->rx_queue_full++;
+		err = -ENOBUFS;
 		goto err;
-	if (likely(!frags))
-		return 0;
+	}
 
+	__xsk_rcv_zc(xs, xskb, len, contd);
 	xskb_list = &xskb->pool->xskb_list;
 	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
-		err = __xsk_rcv_zc(xs, pos, len, contd);
-		if (err)
-			goto err;
+		__xsk_rcv_zc(xs, pos, len, contd);
 		list_del_init(&pos->list_node);
 	}
 
-- 
2.51.0




