Return-Path: <stable+bounces-43307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9DB8BF194
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3D0280A7F
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FA413F436;
	Tue,  7 May 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B51bK4tL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED23513F442;
	Tue,  7 May 2024 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123336; cv=none; b=khlL6wcoEw0NR3A/pzsVJeE2BBpIgnSzamlQjWHEEG37CG2bg08f3M82MU6XHI6Fe3Q5yAVmVjsjd8Bqm3xBSe/RJY02UimzTzvtRmms7713hLDVqqLRkgC4TnzMoTnrtJWmTOqhY2bWVfUzTBgu0BpzUsEXIUTlgt5gqLQqSLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123336; c=relaxed/simple;
	bh=P9+Xv74RFVSFodo/2jDBWm/cubv4cnUm6GU0sms+K4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdEMLaixHNRT2vcC+HUZnQm/l5vFXIPZii4bZXG3pyffXKhPsUkGpD3Qhxp3REDoRscY/xHVLgMMHxDbLz+0cUX0JriPMA8caM1Idm370SLD47SS0aqdOAov2xdYd5I6ukFaPV9GwGNICPKIlz1rwI1cix2QQrkeTDI37WjsY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B51bK4tL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5BFC3277B;
	Tue,  7 May 2024 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123335;
	bh=P9+Xv74RFVSFodo/2jDBWm/cubv4cnUm6GU0sms+K4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B51bK4tLNSWnA2+CBa36+PTWN2p84upaq8D8xvXn2M3BaCJsQLqNKjdX3gw9ry2SR
	 LX6DA5zx7M6xnL4ZA8/8SkRfMiN5nxQmA0t46H2EdRegiLDTwL8HNrNmVWKXR1WRSV
	 IEkwFv5eXZQmukLh/pLBqjFZdeaKgqZteVekf299+wNn555ofUY1Jm+YzfT5zaa4vl
	 ZyEp57ykaavcsANclxsVCxirJuf5SQQhodRqe2q4tPreFaL1wGf+izCuIyGcPToq48
	 skQpOIMOKtblHK/1kDuxjAcatXQw6xCFnJSUzZg/PhaRVqbM9PphIqxZCzuRvRM6uI
	 HbcXoO2M2s8mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	manishc@marvell.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 28/52] net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
Date: Tue,  7 May 2024 19:06:54 -0400
Message-ID: <20240507230800.392128-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

[ Upstream commit e25714466abd9d96901b15efddf82c60a38abd86 ]

Explicitly set 'rc' (return code), before jumping to the
unlock and return path.

By not having any code depend on that 'rc' remains at
it's initial value of -EINVAL, then we can re-use 'rc' for
the return code of function calls in subsequent patches.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index a5ac21a0ee33f..8ecdfa36a6854 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1868,8 +1868,8 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 			    struct flow_cls_offload *f)
 {
 	struct qede_arfs_fltr_node *n;
-	int min_hlen, rc = -EINVAL;
 	struct qede_arfs_tuple t;
+	int min_hlen, rc;
 
 	__qede_lock(edev);
 
@@ -1879,8 +1879,10 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	if (qede_parse_flow_attr(edev, proto, f->rule, &t))
+	if (qede_parse_flow_attr(edev, proto, f->rule, &t)) {
+		rc = -EINVAL;
 		goto unlock;
+	}
 
 	/* Validate profile mode and number of filters */
 	if ((edev->arfs->filter_count && edev->arfs->mode != t.mode) ||
@@ -1888,12 +1890,15 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 		DP_NOTICE(edev,
 			  "Filter configuration invalidated, filter mode=0x%x, configured mode=0x%x, filter count=0x%x\n",
 			  t.mode, edev->arfs->mode, edev->arfs->filter_count);
+		rc = -EINVAL;
 		goto unlock;
 	}
 
 	/* parse tc actions and get the vf_id */
-	if (qede_parse_actions(edev, &f->rule->action, f->common.extack))
+	if (qede_parse_actions(edev, &f->rule->action, f->common.extack)) {
+		rc = -EINVAL;
 		goto unlock;
+	}
 
 	if (qede_flow_find_fltr(edev, &t)) {
 		rc = -EEXIST;
-- 
2.43.0


