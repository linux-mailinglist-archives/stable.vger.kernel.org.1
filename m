Return-Path: <stable+bounces-155768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09AAE439D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5CD11B60742
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C972517AF;
	Mon, 23 Jun 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e7WGWApM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA413A265;
	Mon, 23 Jun 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685283; cv=none; b=Suy9aJHecUlPaUG1YIYjyzJxz5wtxPwnsFjfLve5U086MnAo4IoN2D5x+H1iuVWXpi5w6Pv6cP07vRU0UEwx477azmyRj4CECLbnHCDvSRm1rdXRLsSbfb/O0qkGYsd+tC0Co5eXslpr//BYIUoJzSJv5fqanxvVzuU6GKz0yok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685283; c=relaxed/simple;
	bh=sg4wzNKAwcI1hENiA1BV7KxAln116WX+3c/FqFrdibE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5W/W/i7+9zwSB6ePA0Fy0hn8f3aky34G1NMX6IFbcal2lE9r437e5mNpfzWNGj2qOiAMczc8LdThQGc9UGDevhMrLVzVGD+CDE1RZfkVoJ1sJuc2zwOuau78IHTahMBy2dKfq1hkEF+hAIDBeN444fNVmv4BKq4XacLPIjU0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e7WGWApM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2C1C4CEEA;
	Mon, 23 Jun 2025 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685283;
	bh=sg4wzNKAwcI1hENiA1BV7KxAln116WX+3c/FqFrdibE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7WGWApMohmnIk+OBytK1ogGEZ7PbGMPhTkzMsXUgKioM5xthYDOlNgoD6WwgAPSR
	 w5OXROuq8/7bXaeBe7U7yDY7ylYt2pCCsgW6vTMxBctPqMOoxhJm3eAH7RSV8zsAx8
	 JZdht5A/y6ths6sn+XBomF+mnIuupFcNykZyH2VU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Blakey <paulb@mellanox.com>,
	Roi Dayan <roid@mellanox.com>,
	Mark Bloch <markb@mellanox.com>,
	Maor Gottlieb <maorg@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 081/222] net/mlx5: Wait for inactive autogroups
Date: Mon, 23 Jun 2025 15:06:56 +0200
Message-ID: <20250623130614.533467026@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Blakey <paulb@mellanox.com>

[ Upstream commit 49c0355d301b4e0e01e0f19ddbb023bd7d0ee48c ]

Currently, if one thread tries to add an entry to an autogrouped table
with no free matching group, while another thread is in the process of
creating a new matching autogroup, it doesn't wait for the new group
creation, and creates an unnecessary new autogroup.

Instead of skipping inactive, wait on the write lock of those groups.

Signed-off-by: Paul Blakey <paulb@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Stable-dep-of: 8ec40e3f1f72 ("net/mlx5: Fix return value when searching for existing flow group")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 30d5b7f52a2a0..25f9185d5a15e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1768,11 +1768,13 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 	list_for_each_entry(iter, match_head, list) {
 		g = iter->g;
 
-		if (!g->node.active)
-			continue;
-
 		nested_down_write_ref_node(&g->node, FS_LOCK_PARENT);
 
+		if (!g->node.active) {
+			up_write_ref_node(&g->node, false);
+			continue;
+		}
+
 		err = insert_fte(g, fte);
 		if (err) {
 			up_write_ref_node(&g->node, false);
-- 
2.39.5




