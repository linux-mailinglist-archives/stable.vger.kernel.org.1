Return-Path: <stable+bounces-220562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJLwBG09o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A91E81C6A68
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 696C130C0C9E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5D93D9DA3;
	Sat, 28 Feb 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+u3HTyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251F481FDF;
	Sat, 28 Feb 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300443; cv=none; b=fJGfRI4AHGo+ycA4qGAp/NU/vSU/tqOa5aJCoz9UoOkiSdaribIDJc3jmCZWzWH+Lp4Ak8sQFaMHcJ2o22qC6VY7zrfKHzj1CVwQ5ACm1MNi5U/DDgcqT0fgXDvTDTWDInLW88JOrS13QfsEPh9BoFJ3cxF7doJ5rfOQtXtVg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300443; c=relaxed/simple;
	bh=ZKLOfgt7DuMD+hChXCv/rI0XkF20k9wMc4tB1RBafQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1utqBmLYFWb1TmygltlXOLNkVLjlhz7HM5y7N0y9RqTarCSVLRIvSVvqlYjdrf6wxSBj5PP1sd19EkpYx7RNzzCqUwVsrxwpyE5M8CmZeFDU3Jy5kr+/kY+2s5uoIdgqbeM9nKZQq2tHaagUiuIwNGjpd8U55LX8AnRGhljD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+u3HTyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BB6C116D0;
	Sat, 28 Feb 2026 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300443;
	bh=ZKLOfgt7DuMD+hChXCv/rI0XkF20k9wMc4tB1RBafQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+u3HTyi+OVgaWcipVOxOXsyWSINnRpRf5mBfsJkVgeyEQPJA8AW0DGiGUma0Xusk
	 Rhu+Omm7b4Ebwii+QWe2TF+5aXxJw52ODTdV76tnhFrIMMZLKNzYMcJK8V6U+7plnH
	 PizewESNE/2VZZQAcbDNJ0s9KVv89wYZjJBq23I9d+pCDv5vjYi2r5RfAM5JoWwQiS
	 9YBg7Ve3tfs2lcoggq46SAGb4cJp/z868EabyjsdO5T71x+8JzKRP27/qwMCKKKWzn
	 CwiE+NBATsftvUmPBJeBjZkUagzM2MIf+neEJzLJcqmjlHbleyMDuahnMaoUfaU1kO
	 LESH1j829X4Mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 483/844] RDMA/bng_re: Unwind bng_re_dev_init properly
Date: Sat, 28 Feb 2026 12:26:36 -0500
Message-ID: <20260228173244.1509663-484-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,kernel.org,intel.com,gmail.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220562-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,nvidia.com:email,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: A91E81C6A68
X-Rspamd-Action: no action

From: Siva Reddy Kallam <siva.kallam@broadcom.com>

[ Upstream commit 3d2e5d12a2eef0ca8a629a422aa593673235c77c ]

Fix below smatch warning:
drivers/infiniband/hw/bng_re/bng_dev.c:270
bng_re_dev_init() warn: missing unwind goto?

Current bng_re_dev_init function is not having clear unwinding code.
So, added proper unwinding with ladder.

Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Link: https://patch.msgid.link/20260218091246.1764808-3-siva.kallam@broadcom.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 29 +++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 0678aaecb3b5a..fd0a4fe274ca6 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -285,7 +285,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 				"Failed to register with netedev: %#x\n", rc);
-		return -EINVAL;
+		goto reg_netdev_fail;
 	}
 
 	set_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
@@ -294,19 +294,16 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 		ibdev_err(&rdev->ibdev,
 			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
 			  rdev->aux_dev->auxr_info->msix_requested);
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto msix_ctx_fail;
 	}
 	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
 		  rdev->aux_dev->auxr_info->msix_requested);
 
 	rc = bng_re_setup_chip_ctx(rdev);
 	if (rc) {
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
-		return -EINVAL;
+		goto msix_ctx_fail;
 	}
 
 	bng_re_query_hwrm_version(rdev);
@@ -315,16 +312,14 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate RCFW Channel: %#x\n", rc);
-		goto fail;
+		goto alloc_fw_chl_fail;
 	}
 
 	/* Allocate nq record memory */
 	rdev->nqr = kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
 	if (!rdev->nqr) {
-		bng_re_destroy_chip_ctx(rdev);
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto nq_alloc_fail;
 	}
 
 	rdev->nqr->num_msix = rdev->aux_dev->auxr_info->msix_requested;
@@ -393,9 +388,15 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 free_ring:
 	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
 free_rcfw:
+	kfree(rdev->nqr);
+nq_alloc_fail:
 	bng_re_free_rcfw_channel(&rdev->rcfw);
-fail:
-	bng_re_dev_uninit(rdev);
+alloc_fw_chl_fail:
+	bng_re_destroy_chip_ctx(rdev);
+msix_ctx_fail:
+	bnge_unregister_dev(rdev->aux_dev);
+	clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+reg_netdev_fail:
 	return rc;
 }
 
-- 
2.51.0


