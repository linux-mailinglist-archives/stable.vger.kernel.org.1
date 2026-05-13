Return-Path: <stable+bounces-246811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBVGLqpfBGqiHQIAu9opvQ
	(envelope-from <stable+bounces-246811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:25:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA05322E7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29FA43100BC6
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1733A6B83;
	Wed, 13 May 2026 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="W6VLL/Xj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572D3E9C2D
	for <stable@vger.kernel.org>; Wed, 13 May 2026 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671353; cv=none; b=GyQhPvEF2SGWrR2BbR38IqKITL1SANuN9JXKF/FpjTfPfdKccTAn4PXMxUwtNqmqyNvvvK3gi80gTSXdFQN3kRTAFvN79oU1eVNU6Tcl1BEXctggwSaa3mCnHeA0iCWdD5L7nh1eJyOVljZRrnMBBO0XkiGv3QZRx01rJ55OyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671353; c=relaxed/simple;
	bh=MaMJwaY1jyCxoJgJJwEYMbmhk/zTgU1mLcEV3YoPoKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghmKrszjb1fpAk9WtJDYIZJ6feRrkPpu9CN4wqWhLKhVsKVPSeKmUD9J0jF3+Z/EO55G4rU9EYrbpPRacxCJfprhLcQ6iHTyo0sYs2tyAH2s60jdQnrGXv9dlE5bEoDffLLU2qDA4EyoQ7jNit0hQ7Zh7OA4fvpTa2r7jYyvenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=W6VLL/Xj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891f625344so60802585e9.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1778671350; x=1779276150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/i2eA1a8q5KfMM5M8lDNpFGwLlluyiXuu0AO0XM8wY=;
        b=W6VLL/XjxnMsOoECNbKj8rg9knujVe2qn9Sl2EB/jxDawvlh4qXqmihPKkE4d1CMVd
         cYdpoPrVRlZxpxgcdf8lSPD4j+HT2GT/yHf/1RYrWWXgU84jVFpZYmaxrnjLEnBTVTDo
         t40aAL3elX9y9qMd8Tw9eVysNuw2r3bZnOiMeCsInIDNWgKKp+7QhwnBCT+bQ/gHRce9
         azhwL1zWTP3zTyQ29iAWy6EsqQ1rIMZ+/PfBkQB5U4fUgY5yWp4gX8u8hbxqF2yyFQwF
         rARfTctHJn6/XJfIjFMLig+NqUOs+j1xcQrNViJBJqkanKSgCx1UW1zJwMexQxs8Lh2i
         WJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778671350; x=1779276150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/i2eA1a8q5KfMM5M8lDNpFGwLlluyiXuu0AO0XM8wY=;
        b=VWFyOpFuvnfjIeAR4OUjI/2r4/OLpVunROhxIlgkV2BqRVelaYvVEp3QK7vEKIa8LC
         BgwBZi44GFNKAoinFjdm1Aky8wJCjo+3PlakeHetxcUYGdeKjJ+9iVGFHnrqtht3KmoS
         C7v1aoO+dnCBZSF2GrZ/UGpVKNIe09x+5ZAaHS4FUz1pOJ4IX0K4Nhw0ADQxwoDnOYbn
         u/OgInopo5vF+6FLJTqgPWUczYJNLLR4FGxfiAHcsoSK7bFtEXS/OVTTTKCU0PQ/prJu
         lc4SRHoQLM47ahlat4t3sTEcxT2ZLaOCQmrTVSBzCZBaECRi5HgvbnAw7JFhSGu3dO8B
         nRKg==
X-Forwarded-Encrypted: i=1; AFNElJ8g5/FZfA7KMMa9b3jmPmAPk3exs842mmj5cRBCMErgJHd1uh09Xt8aNR6I4HbP7flBLwT/ugE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxp/q/BWbNtoAVrgUcrbTvY44dEv0qKEyti+ihSEaECpjFU8MK
	DHmEreLYTiVChgUw94x8/1EPpzlcVpCjAlKSQ23ZGLoxcZTmPtyE5QlvTkEyq1PojKc=
X-Gm-Gg: Acq92OE27DsSp4hQzIyMfXd6H+fKX5nz6rr8U6IewOfO9FcPyR3Smg7U9Awamza8jeb
	gAc7ApsNGnST8I+00/rAff0ynlt4PPdcr6i5GuPmLpN1YwjrJyAsS6s+CKxOHrNOK1eZx5AEast
	ij0gLbwnIPWj8a7XbIdK/iBfOsrETROsSfswftPac1EqldLsNWb5K3JrnqiUsNbKHuJYhb+Am47
	Bm6GWUE7Ef1CP5JxEVwkYq9iSGfWNkdIAZgrNYE8Yq3s5wtOqLGBFVHiY6lXpt2W8UzlHlJUV+w
	lRR4iqRkl81HHOGPkDxYb4I9iJsDqq9xIbNKhNE4WPoZHnwaRBHvjfljL8KmocbsDUNcQve2TwS
	yCs2EBUS+j2l2JfWiEV3Z9RMRmry4v2/Y+wm/XnYYjK4vRurcKDK9qF2Qi/m+17mDAoVnlhs/+b
	jwJG+AgDTMANEPz5vKKUlXazlWOyoS9hex72I=
X-Received: by 2002:a05:600c:4503:b0:48a:534a:eed8 with SMTP id 5b1f17b1804b1-48fc971f11bmr42812895e9.1.1778671349955;
        Wed, 13 May 2026 04:22:29 -0700 (PDT)
Received: from matt-Precision-5490.. ([104.28.20.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f438890sm47322865e9.23.2026.05.13.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:22:29 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Feng Liu <feliu@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH net v2] net/mlx5e: Fix use-after-free in mlx5e_tx_reporter_timeout_recover
Date: Wed, 13 May 2026 12:22:26 +0100
Message-ID: <20260513112226.140512-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 23AA05322E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-246811-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:email]
X-Rspamd-Action: no action

From: Matt Fleming <mfleming@cloudflare.com>

mlx5e_tx_reporter_timeout_recover() accesses sq->netdev after
mlx5e_safe_reopen_channels() has torn down and freed the channel (and
its embedded SQs). Replace the three sq->netdev references with
priv->netdev which is safe because priv outlives channel teardown.

The netdev_err() call already used priv->netdev for this reason; make
the trylock/unlock and health_channel_eq_recover calls consistent.

This fixes the following KASAN splat:

  BUG: KASAN: use-after-free in mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
  Read of size 8 at addr ffff889860ed0b28 by task kworker/u113:2/5277

  Call Trace:
   mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
   devlink_health_reporter_recover+0xa2/0x150
   devlink_health_report+0x254/0x7c0
   mlx5e_reporter_tx_timeout+0x297/0x380 [mlx5_core]
   mlx5e_tx_timeout_work+0x109/0x170 [mlx5_core]
   process_one_work+0x677/0xf20
   worker_thread+0x51f/0xd90
   kthread+0x3a5/0x810
   ret_from_fork+0x208/0x400
   ret_from_fork_asm+0x1a/0x30

Fixes: 83ac0304a2d7 ("net/mlx5e: Fix deadlocks between devlink and netdev instance locks")
Cc: stable@vger.kernel.org
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
Changes in v2:
  - Add Cc: stable and Reviewed-by tags from Cosmin and Tariq.
  - Add people from the Fixes: commit and related discussion to Cc.
---

 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index afdeb1b3d425..8409ae73768f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -160,13 +160,13 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	 * channels are being closed for other reason and this work is not
 	 * relevant anymore.
 	 */
-	while (!netdev_trylock(sq->netdev)) {
+	while (!netdev_trylock(priv->netdev)) {
 		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
 			return 0;
 		msleep(20);
 	}
 
-	err = mlx5e_health_channel_eq_recover(sq->netdev, eq, sq->cq.ch_stats);
+	err = mlx5e_health_channel_eq_recover(priv->netdev, eq, sq->cq.ch_stats);
 	if (!err) {
 		to_ctx->status = 0; /* this sq recovered */
 		goto out;
@@ -186,7 +186,7 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 		   "mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(%d).\n",
 		   err);
 out:
-	netdev_unlock(sq->netdev);
+	netdev_unlock(priv->netdev);
 	return err;
 }
 
-- 
2.43.0

