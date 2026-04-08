Return-Path: <stable+bounces-234139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEkfNpeb1mnDGggAu9opvQ
	(envelope-from <stable+bounces-234139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:16:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A683C0544
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2873031AC6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F83D75AF;
	Wed,  8 Apr 2026 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dkegdr5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B303AEF45;
	Wed,  8 Apr 2026 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672085; cv=none; b=rh/4ILrk9X4TBoabAcP4M3YZGFZg80+rCrt+IlAojh6TkewZ8ItD0IPfaia+rqM30XhQTugtYxDpGkPQ2V74fh8XQGsDl/bPkaY8fPBDOlU4zy8uXe64Dy0Kcdv4+8kiCACWFNYqYU7QnQKrHY0cn9KPLmI+NpztwhOs/kJpspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672085; c=relaxed/simple;
	bh=1BrArdDNwDbMhoR/IHM/A/VZIPVO2TWJpjrmb3JRey0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOnBuv3Qkzn1ZMfayZiB5v+99GaGYYpnomahR3KCUzIXO25uzULQ8f7arcRBGo/geDMdItWIbVzSDq/LCH69UGPfL+/oeazhVzc0BBemeBy4a4OEvV52eUYHTsf5g1WUobVpWCqL3pQEuJcP3j65/2DZlgGH4JnjMMnG6yEWWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dkegdr5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1048C19421;
	Wed,  8 Apr 2026 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672085;
	bh=1BrArdDNwDbMhoR/IHM/A/VZIPVO2TWJpjrmb3JRey0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dkegdr5dpdoT63FOa02+mY3jJeMeCiASp8+AKFmmZPRCtpzvAWEIsZVX3dflIB0Qj
	 6PxhjjQr6AMbBa/4f+F4xlZiM8QYvX7C5yyFXnHgLrWRR6LxsxAFQOAG4Buvam6uoq
	 CdpUneFfYhaC036haZT32r/vHpnlZ4PuSKsOBb1s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 183/312] net/mlx5: lag: Check for LAG device before creating debugfs
Date: Wed,  8 Apr 2026 20:01:40 +0200
Message-ID: <20260408175940.598456234@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234139-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 68A683C0544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit bf16bca6653679d8a514d6c1c5a2c67065033f14 ]

__mlx5_lag_dev_add_mdev() may return 0 (success) even when an error
occurs that is handled gracefully. Consequently, the initialization
flow proceeds to call mlx5_ldev_add_debugfs() even when there is no
valid LAG context.

mlx5_ldev_add_debugfs() blindly created the debugfs directory and
attributes. This exposed interfaces (like the members file) that rely on
a valid ldev pointer, leading to potential NULL pointer dereferences if
accessed when ldev is NULL.

Add a check to verify that mlx5_lag_dev(dev) returns a valid pointer
before attempting to create the debugfs entries.

Fixes: 7f46a0b7327a ("net/mlx5: Lag, add debugfs to query hardware lag state")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20260330194015.53585-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
index b8feaf0f5c4c8..a372cb13aa08b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/debugfs.c
@@ -163,8 +163,11 @@ DEFINE_SHOW_ATTRIBUTE(members);
 
 void mlx5_ldev_add_debugfs(struct mlx5_core_dev *dev)
 {
+	struct mlx5_lag *ldev = mlx5_lag_dev(dev);
 	struct dentry *dbg;
 
+	if (!ldev)
+		return;
 	dbg = debugfs_create_dir("lag", mlx5_debugfs_get_dev_root(dev));
 	dev->priv.dbg.lag_debugfs = dbg;
 
-- 
2.53.0




