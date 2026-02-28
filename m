Return-Path: <stable+bounces-221156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OpvMOVNo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-221156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331861C8391
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B264F328FF0C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695EB37313F;
	Sat, 28 Feb 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byGMcqWE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F3373128;
	Sat, 28 Feb 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301509; cv=none; b=LgUJNJV3DANUPn8NgQDEgYZM46Ji8s1kEZsNi4A3i5hZ1u3KtmiEB2JCdW5eqXGHn5N9F+2D3NKcT1JnOyFThS+ojg/S7dW5zudURslLTcaQBLzeC6wkJqFu6XUfuI4XDBOX24cZvN+Te+wOAZcHrKaYvXB6bW/n0YnSPCZ7kKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301509; c=relaxed/simple;
	bh=lTm5cl+V2jkva3LXIgg4WOknLJI1vQm+hrb7u3EBiZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3OIirodLhGyDMxpcgZrdtCcligxbf1YOMzRIJV5Ss63XiVTU593Ievb7jCxvPr825ng9m/lrLoNVopwZziR5JRBjKdgpaN48T2/XWdWvEkwgbbxxA1gcFD293ZEyWabmgdYdjpjFTK+L5kNjMkS3Dp82F5fjmPMzBPOYeGn5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byGMcqWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5E5C116D0;
	Sat, 28 Feb 2026 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301509;
	bh=lTm5cl+V2jkva3LXIgg4WOknLJI1vQm+hrb7u3EBiZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byGMcqWEzXno+XexYGSt2sC1mnVoBPg/BavZXP9phBmtGpKSPDdLeuk1jXHivnr3J
	 PaLabgTBKfnnsi5mkyGu15Ab3gH7EVtpulQD30H5pQ2HJhOwNMaF+mNCbNvWuULnFf
	 C8bQnCO7ZxxiMA5PXH79E6YJSWOOYNsZvLbZENRqBvNmQFEyBq5etBB2Zag61wdM+b
	 YGxfrp4NE9xsgiwLcFsHhrpL55isapCrYTa340wu3DYGdP2Qtu4rlUot8fpqiGsaj+
	 4icYwINUryFpjDnxeAgo6+KtlVrUHYHzUF3PGRDKn1A3ISlqmrgtqchrAIgzXoblR+
	 hEGg18VhEijFA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Bo Sun <bo@mboxify.com>,
	stable@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jijie Shao <shaojijie@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 694/752] octeontx2-af: CGX: fix bitmap leaks
Date: Sat, 28 Feb 2026 12:46:45 -0500
Message-ID: <20260228174750.1542406-694-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221156-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linux.dev:email,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 331861C8391
X-Rspamd-Action: no action

From: Bo Sun <bo@mboxify.com>

[ Upstream commit 3def995c4ede842adf509c410e92d09a0cedc965 ]

The RX/TX flow-control bitmaps (rx_fc_pfvf_bmap and tx_fc_pfvf_bmap)
are allocated by cgx_lmac_init() but never freed in cgx_lmac_exit().
Unbinding and rebinding the driver therefore triggers kmemleak:

    unreferenced object (size 16):
        backtrace:
          rvu_alloc_bitmap
          cgx_probe

Free both bitmaps during teardown.

Fixes: e740003874ed ("octeontx2-af: Flow control resource management")
Cc: stable@vger.kernel.org
Signed-off-by: Bo Sun <bo@mboxify.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Jijie Shao <shaojijie@huawei.com>
Link: https://patch.msgid.link/20260206130925.1087588-2-bo@mboxify.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index ec0e11c77cbf2..81b55f1416e0d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1823,6 +1823,8 @@ static int cgx_lmac_exit(struct cgx *cgx)
 		cgx->mac_ops->mac_pause_frm_config(cgx, lmac->lmac_id, false);
 		cgx_configure_interrupt(cgx, lmac, lmac->lmac_id, true);
 		kfree(lmac->mac_to_index_bmap.bmap);
+		rvu_free_bitmap(&lmac->rx_fc_pfvf_bmap);
+		rvu_free_bitmap(&lmac->tx_fc_pfvf_bmap);
 		kfree(lmac->name);
 		kfree(lmac);
 	}
-- 
2.51.0


