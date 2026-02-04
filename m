Return-Path: <stable+bounces-214225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CABCGp1og2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:41:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4819E9232
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6693C319818C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269172D5926;
	Wed,  4 Feb 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Ttv4ptA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87121FF4C;
	Wed,  4 Feb 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218980; cv=none; b=XNhqPNFw5hvZQdwIwgiGOpJ+0lmILJbn+YsdVnLQcLH05iIhwQKlZXajhn+vh+b+HJrZl8b0/D8v8hw/IFiFapkRWcsbk8EfB6XBFSPNSgVu3bDXzzNegScuflYVa+INd3YgI8TYDziTFwv4TPuuSzzhM9cg/Cfzg9Xm1N6JYPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218980; c=relaxed/simple;
	bh=3Fh1ShpVoLJnyGwZmS3nODR1f5jkQJKCiStZCxX2J0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2MX01bgIMgIjUlgy0lN0qI+Ua6jjOiM4jjRetGfKT7dvw1ROWIgNlTQ4nShPm29tLcySu0dGM3lBOuXBnPjBENA9dTQ/keBqf+/Z9R52gvLRCvsazWoQl8lCLi7h6K55K3uyP3oMKW7ynfuEMbbIigEWPv/fHttfguGEh8HpJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Ttv4ptA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2AFC4CEF7;
	Wed,  4 Feb 2026 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218980;
	bh=3Fh1ShpVoLJnyGwZmS3nODR1f5jkQJKCiStZCxX2J0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Ttv4ptAskCs3tPZRqNGJMknkwYjoW0j5F+7wDzZdsAw0XrqUltablRnbJE8f3T4R
	 lyYteM+hf/MezXH5s0RGOuHFF0lwOV5mwVDePdh5rLa9TzdU5KB80i9gGOj80A7x5Q
	 /7SaKmEMTkh+VP+T+43TA8oQZi5ckJq6c3tVP+rI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 032/122] net/mlx5: Initialize events outside devlink lock
Date: Wed,  4 Feb 2026 15:40:14 +0100
Message-ID: <20260204143853.017599349@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214225-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,msgid.link:url]
X-Rspamd-Queue-Id: C4819E9232
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cosmin Ratiu <cratiu@nvidia.com>

[ Upstream commit b6b03097f9826db72aeb3f751774c5e9edd9a5b3 ]

Move event init/cleanup outside of mlx5_init_one() / mlx5_uninit_one()
and into the mlx5_mdev_init() / mlx5_mdev_uninit() functions.

By doing this, we avoid the events being reinitialized on devlink reload
and, more importantly, the events->sw_nh notifier chain becomes
available earlier in the init procedure, which will be used in
subsequent patches. This makes sense because the events struct is pure
software, independent of any HW details.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/1763325940-1231508-2-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: a8f930b7be7b ("net/mlx5: Fix vhca_id access call trace use before alloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 34 +++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 9e0c9e6266a47..236cb1eb98c82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -999,16 +999,10 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 		goto err_irq_cleanup;
 	}
 
-	err = mlx5_events_init(dev);
-	if (err) {
-		mlx5_core_err(dev, "failed to initialize events\n");
-		goto err_eq_cleanup;
-	}
-
 	err = mlx5_fw_reset_init(dev);
 	if (err) {
 		mlx5_core_err(dev, "failed to initialize fw reset events\n");
-		goto err_events_cleanup;
+		goto err_eq_cleanup;
 	}
 
 	mlx5_cq_debugfs_init(dev);
@@ -1110,8 +1104,6 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	mlx5_cleanup_reserved_gids(dev);
 	mlx5_cq_debugfs_cleanup(dev);
 	mlx5_fw_reset_cleanup(dev);
-err_events_cleanup:
-	mlx5_events_cleanup(dev);
 err_eq_cleanup:
 	mlx5_eq_table_cleanup(dev);
 err_irq_cleanup:
@@ -1144,7 +1136,6 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_cleanup_reserved_gids(dev);
 	mlx5_cq_debugfs_cleanup(dev);
 	mlx5_fw_reset_cleanup(dev);
-	mlx5_events_cleanup(dev);
 	mlx5_eq_table_cleanup(dev);
 	mlx5_irq_table_cleanup(dev);
 	mlx5_devcom_unregister_device(dev->priv.devc);
@@ -1822,6 +1813,24 @@ static int vhca_id_show(struct seq_file *file, void *priv)
 
 DEFINE_SHOW_ATTRIBUTE(vhca_id);
 
+static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
+{
+	int err;
+
+	err = mlx5_events_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "failed to initialize events\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void mlx5_notifiers_cleanup(struct mlx5_core_dev *dev)
+{
+	mlx5_events_cleanup(dev);
+}
+
 int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 {
 	struct mlx5_priv *priv = &dev->priv;
@@ -1877,6 +1886,10 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	if (err)
 		goto err_hca_caps;
 
+	err = mlx5_notifiers_init(dev);
+	if (err)
+		goto err_hca_caps;
+
 	/* The conjunction of sw_vhca_id with sw_owner_id will be a global
 	 * unique id per function which uses mlx5_core.
 	 * Those values are supplied to FW as part of the init HCA command to
@@ -1919,6 +1932,7 @@ void mlx5_mdev_uninit(struct mlx5_core_dev *dev)
 	if (priv->sw_vhca_id > 0)
 		ida_free(&sw_vhca_ida, dev->priv.sw_vhca_id);
 
+	mlx5_notifiers_cleanup(dev);
 	mlx5_hca_caps_free(dev);
 	mlx5_adev_cleanup(dev);
 	mlx5_pagealloc_cleanup(dev);
-- 
2.51.0




