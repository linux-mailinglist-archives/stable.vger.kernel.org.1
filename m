Return-Path: <stable+bounces-234799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI51JOih1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:43:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 289143C15B9
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BC213011052
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD62346FB0;
	Wed,  8 Apr 2026 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bflwfBZa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49241A285;
	Wed,  8 Apr 2026 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673792; cv=none; b=g1Mxjg3vASdWCRhN9LkJr0Z19lB66jRDiFZDjius5gb9vn5MKybRFTuQET/FiOYv2xjch73PAL7HrT5Uqt7wdcZQ4Qh/TGmzYrnclz6v3FGeaaPsCR2LC1gIZ5BgFehPKoNK5IOvi7ObqUgGuP/VBuEWwmjvSU5eZPie1Wad3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673792; c=relaxed/simple;
	bh=yI/DxdUgbzYFkYb4CpeHT8XcU1yS1moH6KbWy/4nHt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkwV+COiBHu+CuPmhqRST9mh4DIq+twAIi1j3px2o2HIXmcARqvoAd+CwOoNOCXKAP0ujtFzyiWH/e3clMdOX0tBRUOFch/0kjclc74h6gR2BF2EuMnyEmYHCKdE0G5NO5XJlqIRyfwrAbFAQDDAF72aNYqG0oOu7FgWr4BqR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bflwfBZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3B0C19421;
	Wed,  8 Apr 2026 18:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673792;
	bh=yI/DxdUgbzYFkYb4CpeHT8XcU1yS1moH6KbWy/4nHt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bflwfBZalSCpzWKLGe/Yo6dl2odDmoLb7nSDzhwUEKTqrrBFlk8uuBtUlP64Sv/lT
	 otnUkD8oNf+S982bNYYkJuSbnHFjz8qSo82odEBEQUF1uSfOfxl+su+wDeQmjalXaM
	 Rwg+hAGlOjlR1emHeQgnnFBPbrcEfyvufIyI0jb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 091/242] net/mlx5: lag: Check for LAG device before creating debugfs
Date: Wed,  8 Apr 2026 20:02:11 +0200
Message-ID: <20260408175930.490880123@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234799-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 289143C15B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index f4b777d4e1086..41ddca52e9547 100644
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




