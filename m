Return-Path: <stable+bounces-220561-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGrAJMZOo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-220561-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:23:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F11C21C84DC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D1D375B959
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F73D933B;
	Sat, 28 Feb 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diJBqdm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886F3D9333;
	Sat, 28 Feb 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300442; cv=none; b=nWxzLx4Xy9/RpXdnPisaOl7zcNEaOF4x/NRVeBAOaTbeRHLDIglR1VEEmm5HqnE5ua6hJlMnfarx5tz6+KoqSshyXo4qOPAv11Y8dZwph2kjPftgFl302Zchq/+2fmQ9UhddB9VtdFBnr1NfqzF4xdgSyHdrTCptZZgxq2GhMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300442; c=relaxed/simple;
	bh=bsvXoGUNCJ3MfDXSFJNmUx/E3P2uYm7IiUQTKcKUV2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBFNOetDEaC2adIiXjIPbLWysKbkDoQ9We1npDeJtz9a6yx2llI6HPGB1GtIucQXGemkG5wg1cJVTulJ2liNpTc+4v/4zqOQ+4iRR7trhNPZ5usY+df9kg6+xAhZxk9KtS0ezJkVF2cPCn/gsTqIHhVGSTg0bpz83XUQM0MGzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diJBqdm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B46C19425;
	Sat, 28 Feb 2026 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300442;
	bh=bsvXoGUNCJ3MfDXSFJNmUx/E3P2uYm7IiUQTKcKUV2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diJBqdm6u1Fl3jR8zyV8xS9G+kqBSCxIh5DlpC9mYYj3DyJw/Y4Bs/E48L8B3uLgh
	 pl9nYeBgl7rEEXMjkf/YjZRXWE0uY8+ji3d9vKpF+zIkgw7vukEzqJMVYs+S9HM4Ox
	 /QjzX4nxqgKeGxwGLHfqsQWSi/hGtWlXk2rjSqtWbYU4OOyWdHHFkTkNw/CpBuzSI7
	 8Aj0cZFDxESrVD7bJ54uOdlPKjrQjqUP6ciIA82nKIFBIXtlMFS3cFB0gh18t/ba90
	 OrYutnIyDardIfQMy7AgKBvJ5/E0BVR75SEWHeXuPQED7Lbe3RihMBKHjmjOPBV/gu
	 2VbpZSIoYxwdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 482/844] RDMA/bng_re: Remove unnessary validity checks
Date: Sat, 28 Feb 2026 12:26:35 -0500
Message-ID: <20260228173244.1509663-483-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,intel.com,gmail.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220561-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,nvidia.com:email]
X-Rspamd-Queue-Id: F11C21C84DC
X-Rspamd-Action: no action

From: Siva Reddy Kallam <siva.kallam@broadcom.com>

[ Upstream commit 7a23af417d9dd57b4382356b2e7442e5d2bf5bea ]

Fix below smatch warning:
drivers/infiniband/hw/bng_re/bng_dev.c:113
bng_re_net_ring_free() warn: variable dereferenced before check 'rdev'
(see line 107)

current driver has unnessary validity checks. So, removing these
unnessary validity checks.

Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
Fixes: 745065770c2d ("RDMA/bng_re: Register and get the resources from bnge driver")
Fixes: 04e031ff6e60 ("RDMA/bng_re: Initialize the Firmware and Hardware")
Fixes: d0da769c19d0 ("RDMA/bng_re: Add Auxiliary interface")
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Link: https://patch.msgid.link/20260218091246.1764808-2-siva.kallam@broadcom.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 27 ++++----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index d8f8d7f7075f0..0678aaecb3b5a 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -54,9 +54,6 @@ static void bng_re_destroy_chip_ctx(struct bng_re_dev *rdev)
 {
 	struct bng_re_chip_ctx *chip_ctx;
 
-	if (!rdev->chip_ctx)
-		return;
-
 	kfree(rdev->dev_attr);
 	rdev->dev_attr = NULL;
 
@@ -124,12 +121,6 @@ static int bng_re_net_ring_free(struct bng_re_dev *rdev,
 	struct bnge_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!rdev)
-		return rc;
-
-	if (!aux_dev)
-		return rc;
-
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_FREE);
 	req.ring_type = type;
 	req.ring_id = cpu_to_le16(fw_ring_id);
@@ -150,10 +141,7 @@ static int bng_re_net_ring_alloc(struct bng_re_dev *rdev,
 	struct hwrm_ring_alloc_input req = {};
 	struct hwrm_ring_alloc_output resp;
 	struct bnge_fw_msg fw_msg = {};
-	int rc = -EINVAL;
-
-	if (!aux_dev)
-		return rc;
+	int rc;
 
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_RING_ALLOC);
 	req.enables = 0;
@@ -184,10 +172,7 @@ static int bng_re_stats_ctx_free(struct bng_re_dev *rdev)
 	struct hwrm_stat_ctx_free_input req = {};
 	struct hwrm_stat_ctx_free_output resp = {};
 	struct bnge_fw_msg fw_msg = {};
-	int rc = -EINVAL;
-
-	if (!aux_dev)
-		return rc;
+	int rc;
 
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_FREE);
 	req.stat_ctx_id = cpu_to_le32(rdev->stats_ctx.fw_id);
@@ -208,13 +193,10 @@ static int bng_re_stats_ctx_alloc(struct bng_re_dev *rdev)
 	struct hwrm_stat_ctx_alloc_output resp = {};
 	struct hwrm_stat_ctx_alloc_input req = {};
 	struct bnge_fw_msg fw_msg = {};
-	int rc = -EINVAL;
+	int rc;
 
 	stats->fw_id = BNGE_INVALID_STATS_CTX_ID;
 
-	if (!aux_dev)
-		return rc;
-
 	bng_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_ALLOC);
 	req.update_period_ms = cpu_to_le32(1000);
 	req.stats_dma_addr = cpu_to_le64(stats->dma_map);
@@ -486,8 +468,7 @@ static void bng_re_remove(struct auxiliary_device *adev)
 
 	rdev = dev_info->rdev;
 
-	if (rdev)
-		bng_re_remove_device(rdev, adev);
+	bng_re_remove_device(rdev, adev);
 	kfree(dev_info);
 }
 
-- 
2.51.0


