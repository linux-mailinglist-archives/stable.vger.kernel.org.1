Return-Path: <stable+bounces-199504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D914CA0DE9
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05ED031C8380
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1286F3451D7;
	Wed,  3 Dec 2025 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuCPwrIO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E23446C6;
	Wed,  3 Dec 2025 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780016; cv=none; b=EOlIvWjv3ko0xuJku2jlrfsqbaIlPui8MCrq5ENO46FI0jH6VlYy1ZQeqfDKNGGoJOsGNtGm3ZO85UTqF3KX39m+fkW2SJ2Bbbk56EA6D1Rfc7iK4qC9QwMN41p0jZi0ql+0DwAzW0x08HFk0u67KXSob3BeaDSI67uvsO1/fpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780016; c=relaxed/simple;
	bh=Xm/qbd9phTeccguV87cvJgReHTkIdWlPrCEwr4Ha66k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5Xzq5/IDDj7d6zOcJGrGDnt1Yu5+Cr6EqIasgA9pWoqudhWoqMtkboY/VzM2V6hAyXcF5wKEynVyEd/Nw6Dfhz89Ub/x9vIGL2i11CI9ZgiBvQCU9PfTT6KLLKBn7cONqEa4LmD2wTK+F+VSoAiYrg9iISlSEgzcrL19/0RWG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuCPwrIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C0BC4CEF5;
	Wed,  3 Dec 2025 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780016;
	bh=Xm/qbd9phTeccguV87cvJgReHTkIdWlPrCEwr4Ha66k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vuCPwrIOpbRMhs/1do52CadEKMQ2H8lJkp4mnweJytvIxvCXe+DjFgBHK2FnfGmD4
	 fGdBLsGsYdrh0KKr5N/jZOp7qNeiBhGaf3LJIYoVj39nOKaxe6fF+tQhS4y66u+UB5
	 0bUp3HUTLCso9oI4Aqo+MoZIEa7MyrRhV5riahbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maher Sanalla <msanalla@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH 6.1 423/568] net/mlx5: Fix memory leak in error flow of port set buffer
Date: Wed,  3 Dec 2025 16:27:05 +0100
Message-ID: <20251203152456.190655115@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maher Sanalla <msanalla@nvidia.com>

commit e3e01c1c15986f9531b854634eec8381e72cb605 upstream.

In the cited commit, shared buffer updates were added whenever
port buffer gets updated.

However, in case the shared buffer update fails, exiting early from
port_set_buffer() is performed without freeing previously-allocated memory.

Fix it by jumping to out label where memory is freed before returning
with error.

Fixes: a440030d8946 ("net/mlx5e: Update shared buffer along with device buffer changes")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -325,11 +325,11 @@ static int port_set_buffer(struct mlx5e_
 	err = port_update_shared_buffer(priv->mdev, current_headroom_size,
 					new_headroom_size);
 	if (err)
-		return err;
+		goto out;
 
 	err = port_update_pool_cfg(priv->mdev, port_buffer);
 	if (err)
-		return err;
+		goto out;
 
 	err = mlx5e_port_set_pbmc(mdev, in);
 out:



