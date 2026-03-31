Return-Path: <stable+bounces-231783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FD2J6X7y2mwNAYAu9opvQ
	(envelope-from <stable+bounces-231783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:51:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 005FA36D453
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6F8C32700A0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12776436352;
	Tue, 31 Mar 2026 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AO630IiY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD142EEDA;
	Tue, 31 Mar 2026 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975057; cv=none; b=uwt1ade/HdgFmf3hUq9MKwXqqDGRTYICxtXIO2XAl+OjYa9r728KtDJhXoc9o8VNblQp724c4Se9SUXdGWY7Tf0SOV9D16Bd+OlmRD10WwSRvus4KabW/m5NcvGhubrIK5ZB4BEJRjR5bJQr28gvTSckwzdH0L2tVmfGhLIiQiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975057; c=relaxed/simple;
	bh=leAC6GUoN7zbrfgDqaABSwr4NV2zrskaw1LAUgrphiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9fuuNCH1XKRgsXlC0KN8DPqjwuqAb37rBbF6o2rQlmh47B+wSyZJGjnA0xsPZPUih4c9Z4JSvQV09gwbtqPuRJOxeP/qautHS8Hmac+2Df8IDUe53SB8+sZkxllgan8FyOI9P6vNOftqm2XDxLc22HX4dBeg3FaqgnXb9QQkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AO630IiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601C4C19424;
	Tue, 31 Mar 2026 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975057;
	bh=leAC6GUoN7zbrfgDqaABSwr4NV2zrskaw1LAUgrphiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AO630IiY2XVi5L9a3G2nzR5ChQG3QCSQ+Ab65xsUXF7KjwjRlhmYDlp50yfutZ2Mz
	 2s3thzcIvOjn1tD46nBiVAkPKocEVmbASW3kZm64or/dymOn7+XIK54b17dM0GbD21
	 k1KLPdVAQgP5BOWzqbA9m+eUjQbgwCuB+GXEUPjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamal Heib <kheib@redhat.com>,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 147/342] RDMA/bng_re: Fix silent failure in HWRM version query
Date: Tue, 31 Mar 2026 18:19:40 +0200
Message-ID: <20260331161804.413720188@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231783-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 005FA36D453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Heib <kheib@redhat.com>

[ Upstream commit c242e92c9da456d361d1d4482fb6e93ee95bd8cf ]

If the firmware version query fails, the driver currently ignores the
error and continues initializing. This leaves the device in a bad state.

Fix this by making bng_re_query_hwrm_version() return the error code and
update the driver to check for this error and stop the setup process
safely if it happens.

Fixes: 745065770c2d ("RDMA/bng_re: Register and get the resources from bnge driver")
Signed-off-by: Kamal Heib <kheib@redhat.com>
Link: https://patch.msgid.link/20260303043645.425724-1-kheib@redhat.com
Reviewed-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index fd0a4fe274ca6..9cf73f87070ec 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -210,7 +210,7 @@ static int bng_re_stats_ctx_alloc(struct bng_re_dev *rdev)
 	return rc;
 }
 
-static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
+static int bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 {
 	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
 	struct hwrm_ver_get_output ver_get_resp = {};
@@ -230,7 +230,7 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
 			  rc);
-		return;
+		return rc;
 	}
 
 	cctx = rdev->chip_ctx;
@@ -244,6 +244,8 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 
 	if (!cctx->hwrm_cmd_max_timeout)
 		cctx->hwrm_cmd_max_timeout = BNG_ROCE_FW_MAX_TIMEOUT;
+
+	return 0;
 }
 
 static void bng_re_dev_uninit(struct bng_re_dev *rdev)
@@ -306,13 +308,15 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 		goto msix_ctx_fail;
 	}
 
-	bng_re_query_hwrm_version(rdev);
+	rc = bng_re_query_hwrm_version(rdev);
+	if (rc)
+		goto destroy_chip_ctx;
 
 	rc = bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate RCFW Channel: %#x\n", rc);
-		goto alloc_fw_chl_fail;
+		goto destroy_chip_ctx;
 	}
 
 	/* Allocate nq record memory */
@@ -391,7 +395,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	kfree(rdev->nqr);
 nq_alloc_fail:
 	bng_re_free_rcfw_channel(&rdev->rcfw);
-alloc_fw_chl_fail:
+destroy_chip_ctx:
 	bng_re_destroy_chip_ctx(rdev);
 msix_ctx_fail:
 	bnge_unregister_dev(rdev->aux_dev);
-- 
2.53.0




