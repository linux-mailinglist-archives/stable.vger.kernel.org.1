Return-Path: <stable+bounces-220540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJq6KZc8o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20C1C6998
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24539318D71E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3DA3D061B;
	Sat, 28 Feb 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msqdqyL3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2773D0E9F;
	Sat, 28 Feb 2026 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300423; cv=none; b=HfhLFhhi6JL+vkwpuX4ZWTsNoGdwfahiq8DUXLWyva5hc14eU8Q6kymeLzK1T1yvNMuMWyRjjZf235BApxryxXYliLe3dsXXr2IMdaTcCsk5Zdw61gj4RMhDWb27GWnxEiGmBJ+Mr1R/GbPgCt04qn4lXhy4LVDstMcs2KIVv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300423; c=relaxed/simple;
	bh=GKG4WXJ0g5xS0f6lnaAyKIggdj/G7+BuJYBs6t6nw3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0ESmRtu5dwpbBahex0jdKeqarjHLPs8UjuRngUnkVEyuFr5vtp9PA48MPDq3jIaQrrrhtU6j1GkZjiFoti7z/IXW0Pl/Snu136b208GN1hp6g5Q9HB3uGqk6L353ZdAF1KkThhIgwEaFyjcD8Vz8JJJEhUBoekloFqBhBZk2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msqdqyL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4982CC19425;
	Sat, 28 Feb 2026 17:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300423;
	bh=GKG4WXJ0g5xS0f6lnaAyKIggdj/G7+BuJYBs6t6nw3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msqdqyL3hdphKnv5RM4ehse4A+KlFgPku775Gor4Z2U2f2BBkwfbQGuuOiGQHUpbJ
	 CwwKeo/0gDqOMFr5U4xuYBX5KNGCpqPHEfzNRLQGHRf2lipTqdJZMu8z35oIiVeCkA
	 RWs/eo1VKEF4T1lbk2pr+b1ZPmplwK7JVouGaJu3NTzhNm7mL/PFHDBCsR4eGaNfoP
	 fChk+AJBzxdYTJiXK84hEdAnnFF9q2RnoqtLVyxsti903Yp/kZXUB9yTCXzl6N9b6H
	 U0y47ckeSJxvzPtimV01l1+AEMcgTtkz45RXxqX5Md1qknZJJ4ZmAAh9lRNuVLH5xR
	 HQh9nNRSFXnDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kicinski@meta.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 461/844] bnxt_en: Fix RSS context delete logic
Date: Sat, 28 Feb 2026 12:26:14 -0500
Message-ID: <20260228173244.1509663-462-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220540-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,meta.com:email]
X-Rspamd-Queue-Id: 2F20C1C6998
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

[ Upstream commit e123d9302d223767bd910bfbcfe607bae909f8ac ]

We need to free the corresponding RSS context VNIC
in FW everytime an RSS context is deleted in driver.
Commit 667ac333dbb7 added a check to delete the VNIC
in FW only when netif_running() is true to help delete
RSS contexts with interface down.

Having that condition will make the driver leak VNICs
in FW whenever close() happens with active RSS contexts.
On the subsequent open(), as part of RSS context restoration,
we will end up trying to create extra VNICs for which we
did not make any reservation. FW can fail this request,
thereby making us lose active RSS contexts.

Suppose an RSS context is deleted already and we try to
process a delete request again, then the HWRM functions
will check for validity of the request and they simply
return if the resource is already freed. So, even for
delete-when-down cases, netif_running() check is not
necessary.

Remove the netif_running() condition check when deleting
an RSS context.

Reported-by: Jakub Kicinski <kicinski@meta.com>
Fixes: 667ac333dbb7 ("eth: bnxt: allow deleting RSS contexts when the device is down")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20260219185313.2682148-2-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8419d1eb4035d..64832289e18d0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10827,12 +10827,10 @@ void bnxt_del_one_rss_ctx(struct bnxt *bp, struct bnxt_rss_ctx *rss_ctx,
 	struct bnxt_ntuple_filter *ntp_fltr;
 	int i;
 
-	if (netif_running(bp->dev)) {
-		bnxt_hwrm_vnic_free_one(bp, &rss_ctx->vnic);
-		for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++) {
-			if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
-				bnxt_hwrm_vnic_ctx_free_one(bp, vnic, i);
-		}
+	bnxt_hwrm_vnic_free_one(bp, &rss_ctx->vnic);
+	for (i = 0; i < BNXT_MAX_CTX_PER_VNIC; i++) {
+		if (vnic->fw_rss_cos_lb_ctx[i] != INVALID_HW_RING_ID)
+			bnxt_hwrm_vnic_ctx_free_one(bp, vnic, i);
 	}
 	if (!all)
 		return;
-- 
2.51.0


