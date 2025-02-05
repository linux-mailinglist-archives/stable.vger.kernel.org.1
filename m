Return-Path: <stable+bounces-113254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E9EA290AB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCB83A717E
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C6158870;
	Wed,  5 Feb 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ITrwa4xK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6D80BFF;
	Wed,  5 Feb 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766340; cv=none; b=aIy5WuEIoBXE1VLbz6nXvuAciVGPvx2sCcjh0OKlJAAx0Br/0QzjDV1tj9nlenpo6kUIF4VfsO4vNdsdPxpXg/EK81hlDpnODrizdQy3goTFnTIZHoc3ve2bJXeuLNrLIJFiBe0EHBTzn8I1jIWiaUrMyA77eCSeWx7Sn14drIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766340; c=relaxed/simple;
	bh=BwvSjlSWARJPaChgEvriJEeXSvFVL5VCF/t9qi4aciI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0/O/Q1htBjcDHnEWoTm9Nc1BLgAE/oQhtuHg60KIFDgxGT+Dwejj8UwtQ6Hsk2FLLyQjE+AxNx81D+7qBs9qudFKgMBw0L+uUacXbia1T3y96EXOdhN0tZAhtA95QW8TQ5f94RqKDnopfzLuC7r8ErjLJAbc3ek/fRHXN/+PTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ITrwa4xK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE96CC4CED1;
	Wed,  5 Feb 2025 14:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766340;
	bh=BwvSjlSWARJPaChgEvriJEeXSvFVL5VCF/t9qi4aciI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITrwa4xKxAeLDGRRxEG63nHAHvRpHSuioN4oo9KChmfdQPhtLNRomkARzSXpD04Xx
	 MLyttJyOjkAY+QsKSM/QPs0xq+JNvj7KDD19alDlK+0rX6NmK3FnghaiLPc6Mb1Q07
	 1oDpnUGOQRNlmpDTYblSdfKNJYArdhGrjmhBXaV4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 312/590] RDMA/mlx4: Avoid false error about access to uninitialized gids array
Date: Wed,  5 Feb 2025 14:41:07 +0100
Message-ID: <20250205134507.210802979@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 1f53d88cbb0dcc7df235bf6611ae632b254fccd8 ]

Smatch generates the following false error report:
drivers/infiniband/hw/mlx4/main.c:393 mlx4_ib_del_gid() error: uninitialized symbol 'gids'.

Traditionally, we are not changing kernel code and asking people to fix
the tools. However in this case, the fix can be done by simply rearranging
the code to be more clear.

Fixes: e26be1bfef81 ("IB/mlx4: Implement ib_device callbacks")
Link: https://patch.msgid.link/6a3a1577463da16962463fcf62883a87506e9b62.1733233426.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 529db874d67c6..b1bbdcff631d5 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -351,7 +351,7 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 	struct mlx4_port_gid_table   *port_gid_table;
 	int ret = 0;
 	int hw_update = 0;
-	struct gid_entry *gids;
+	struct gid_entry *gids = NULL;
 
 	if (!rdma_cap_roce_gid_table(attr->device, attr->port_num))
 		return -EINVAL;
@@ -389,10 +389,10 @@ static int mlx4_ib_del_gid(const struct ib_gid_attr *attr, void **context)
 	}
 	spin_unlock_bh(&iboe->lock);
 
-	if (!ret && hw_update) {
+	if (gids)
 		ret = mlx4_ib_update_gids(gids, ibdev, attr->port_num);
-		kfree(gids);
-	}
+
+	kfree(gids);
 	return ret;
 }
 
-- 
2.39.5




