Return-Path: <stable+bounces-218690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HunJINYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F33A7190743
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9187630ECBEF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C1A268690;
	Wed, 25 Feb 2026 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B+m/hVZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889F2494FE;
	Wed, 25 Feb 2026 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983548; cv=none; b=ohSSIBMZFwAUwCaKoJ1XX5YV0fk84kMRO75f+6EuuBUlBtDudXJFE5nSgkz2kUOcHmtbVL9SXurdKUqGy96QFq6CB5p8GVlwY5V0505hi9y3d9xkpFKzsIS4TEcvKBUib0LH5spwDOok49HerONLMyxqgEyeFvu3CSO8ioGb990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983548; c=relaxed/simple;
	bh=NBW7ZeO2V2WP10Aoz/jhe/o9ZVIL8GFzCi4urZMCTbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2mEZ6EB++ewHlkdBtX4fi+4g/wWacLZdoe5MsuQYdznEPSKO3zN5XrpshjwHqtWYVpryAykbvn/txRsO+lqLSajBqzibWgWSkutdslmU92BZ3IY2YXzULWORDigKnkEYD5q627pWlxhzMVqzwiJbtoweMxE+6HfB/f0hDNdH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B+m/hVZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530F7C116D0;
	Wed, 25 Feb 2026 01:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983548;
	bh=NBW7ZeO2V2WP10Aoz/jhe/o9ZVIL8GFzCi4urZMCTbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+m/hVZoKMvwYTB2W+XDhhQz+cyXp9fmCIg1uR3n5pnqFsdrjpTJ6j6E+A9PJu2uP
	 A7yfmg5Tyl+05ofalmykKnAldFq1nKjb1hKobFcbDyyvO+peXLhn7Q3QXXqKp/sUAV
	 EskGvYRVakpd2fDTh4lHrecW3kSQV5OsbiG5ZX/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 650/781] eth: fbnic: set FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT on RDE_CTL0
Date: Tue, 24 Feb 2026 17:22:39 -0800
Message-ID: <20260225012415.735460587@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218690-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,meta.com,gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: F33A7190743
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bobby Eshleman <bobbyeshleman@meta.com>

[ Upstream commit bbeb3bfbffe0279fa47c041658b037fb38a93965 ]

Fix EN_HDR_SPLIT configuration by writing the field to RDE_CTL0 instead
of RDE_CTL1.

Because drop mode configuration and header splitting enablement both use
RDE_CTL0, we consolidate these configurations into the single function
fbnic_config_drop_mode.

Fixes: 2b30fc01a6c7 ("eth: fbnic: Add support for HDS configuration")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
Acked-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Link: https://patch.msgid.link/20260211-fbnic-tcp-hds-fixes-v1-1-55d050e6f606@meta.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 25 +++++++++++---------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 13d508ce637f1..e119526fce14c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2575,7 +2575,8 @@ static void fbnic_enable_bdq(struct fbnic_ring *hpq, struct fbnic_ring *ppq)
 }
 
 static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
-				       struct fbnic_ring *rcq, bool tx_pause)
+				       struct fbnic_ring *rcq, bool tx_pause,
+				       bool hdr_split)
 {
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 drop_mode, rcq_ctl;
@@ -2588,22 +2589,26 @@ static void fbnic_config_drop_mode_rcq(struct fbnic_napi_vector *nv,
 	/* Specify packet layout */
 	rcq_ctl = FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_DROP_MODE_MASK, drop_mode) |
 	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_HROOM_MASK, FBNIC_RX_HROOM) |
-	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM);
+	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_MIN_TROOM_MASK, FBNIC_RX_TROOM) |
+	    FIELD_PREP(FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT, hdr_split);
 
 	fbnic_ring_wr32(rcq, FBNIC_QUEUE_RDE_CTL0, rcq_ctl);
 }
 
-void fbnic_config_drop_mode(struct fbnic_net *fbn, bool tx_pause)
+void fbnic_config_drop_mode(struct fbnic_net *fbn, bool txp)
 {
+	bool hds;
 	int i, t;
 
+	hds = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
+
 	for (i = 0; i < fbn->num_napi; i++) {
 		struct fbnic_napi_vector *nv = fbn->napi[i];
 
 		for (t = 0; t < nv->rxt_count; t++) {
 			struct fbnic_q_triad *qt = &nv->qt[nv->txt_count + t];
 
-			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, tx_pause);
+			fbnic_config_drop_mode_rcq(nv, &qt->cmpl, txp, hds);
 		}
 	}
 }
@@ -2654,20 +2659,18 @@ static void fbnic_enable_rcq(struct fbnic_napi_vector *nv,
 {
 	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
 	u32 log_size = fls(rcq->size_mask);
-	u32 hds_thresh = fbn->hds_thresh;
 	u32 rcq_ctl = 0;
-
-	fbnic_config_drop_mode_rcq(nv, rcq, fbn->tx_pause);
+	bool hdr_split;
+	u32 hds_thresh;
 
 	/* Force lower bound on MAX_HEADER_BYTES. Below this, all frames should
 	 * be split at L4. It would also result in the frames being split at
 	 * L2/L3 depending on the frame size.
 	 */
-	if (fbn->hds_thresh < FBNIC_HDR_BYTES_MIN) {
-		rcq_ctl = FBNIC_QUEUE_RDE_CTL0_EN_HDR_SPLIT;
-		hds_thresh = FBNIC_HDR_BYTES_MIN;
-	}
+	hdr_split = fbn->hds_thresh < FBNIC_HDR_BYTES_MIN;
+	fbnic_config_drop_mode_rcq(nv, rcq, fbn->tx_pause, hdr_split);
 
+	hds_thresh = max(fbn->hds_thresh, FBNIC_HDR_BYTES_MIN);
 	rcq_ctl |= FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PADLEN_MASK, FBNIC_RX_PAD) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_MAX_HDR_MASK, hds_thresh) |
 		   FIELD_PREP(FBNIC_QUEUE_RDE_CTL1_PAYLD_OFF_MASK,
-- 
2.51.0




