Return-Path: <stable+bounces-177224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DCB4044E
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EDF18847BD
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283FF30ACFE;
	Tue,  2 Sep 2025 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YyRfs4ca"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90252DECDE;
	Tue,  2 Sep 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819975; cv=none; b=CSzbq2tJr7sbTlWoRpssCvOEnf8TKhy+cOdIFxsXootIXUy4wMuASmviOdgGxjS9Z0z7xqYqcdCMtdDazVaKwKTCljWp7QNIFndg91apw9IPV9KnD0YasGO3rx79rFCabeFdu/f3qUK0W2fwu7OxtMpPwNnV03C4EE9jvJHH2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819975; c=relaxed/simple;
	bh=yjtEcr22ZjG65eqtHsq+8VR+he4Py4SIt0/I6ftcmoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAuwd6J/2pde7mZHiUT8Ao9r1LA2PHnQoElahXVQIfC+XdgeOP8XykCvTDTlQ8b7/By+q31XWc+594MsNgyBc1xzkKQXIYkNtYBf+ZjUmLzKArkz5OanUaWqtrnKmGlYuG2uA6PwtFqRTDD34iqirCQdaHO3q70rPcbXLaJ24p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YyRfs4ca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C46CC4CEED;
	Tue,  2 Sep 2025 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756819975;
	bh=yjtEcr22ZjG65eqtHsq+8VR+he4Py4SIt0/I6ftcmoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyRfs4ca3CUeIyH1PsZYie1p0AX84dVZE0H6QFOBlbqR72aj6M08jxjc0hOp6ULbN
	 0GqYt9xDrwlX/bUl9UzcPh2pLFF6zTF0Hwa+1kPdeO4xcy+7415vUqXh9WIxGWx0gO
	 qaLCBoYVlnQgRndfyAEUnF6+eK308qYg15EabgKM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexei Lazar <alazar@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 53/95] net/mlx5e: Set local Xoff after FW update
Date: Tue,  2 Sep 2025 15:20:29 +0200
Message-ID: <20250902131941.639561755@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
References: <20250902131939.601201881@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Lazar <alazar@nvidia.com>

[ Upstream commit aca0c31af61e0d5cf1675a0cbd29460b95ae693c ]

The local Xoff value is being set before the firmware (FW) update.
In case of a failure where the FW is not updated with the new value,
there is no fallback to the previous value.
Update the local Xoff value after the FW has been successfully set.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Link: https://patch.msgid.link/20250825143435.598584-12-mbloch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 3efa8bf1d14ef..4720523813b97 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -575,7 +575,6 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 		if (err)
 			return err;
 	}
-	priv->dcbx.xoff = xoff;
 
 	/* Apply the settings */
 	if (update_buffer) {
@@ -584,6 +583,8 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 			return err;
 	}
 
+	priv->dcbx.xoff = xoff;
+
 	if (update_prio2buffer)
 		err = mlx5e_port_set_priority2buffer(priv->mdev, prio2buffer);
 
-- 
2.50.1




