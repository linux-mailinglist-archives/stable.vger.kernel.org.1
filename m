Return-Path: <stable+bounces-43408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72E8BF284
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FC31F21311
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73321C17C;
	Tue,  7 May 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBFM9spO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1289621C171;
	Tue,  7 May 2024 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123628; cv=none; b=RfkI8KMyWcZWUGNGYV5NTrJ6/rJrzRQ7UhywIOEs/qW9ibmwMyqJ51kk0ILShuqJSGgQEAhAqMjserVBkC6tU8H8G4QsRDkTf/4R0okdLwDg2gfwHx6f/VsVCUTpaZJS/YflWIkzBBDhzKCaM4hkqqQ++cFifwuNMB6bmU92qy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123628; c=relaxed/simple;
	bh=9MpYwDDygwbSAzolG9in6+os4KOgRZ056ZMi1p6g0lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGkc+jkBkfMWw9ABj/0QuIrj3FjrhGhw0QuHWFRWimpFsPKgGz8gcEnZ5OjwYaJbG2K8WahXR/hSm0snpbByyOAdjTfvqTIDiiUVU102DhsMyRmlx8Z8kSZ70ai8AGPFMtL9jIPzYSHR//FNCc8JOZGd5byVUk0uiFCA9gRy+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBFM9spO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795DBC4AF17;
	Tue,  7 May 2024 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123627;
	bh=9MpYwDDygwbSAzolG9in6+os4KOgRZ056ZMi1p6g0lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cBFM9spOuDlGYuN26dairuN8MgMHlCM9JukHLFMLGvbR1GsBJRTO88Kk6ZvIST2EA
	 wr7zxsLjXa3/yGVOFIhFLMqq3mFUsgXCAqS+zEff/Z7jzvznyY66YvGeQyj9DT/9ts
	 KlYj3KKjHregs774Oh4tTUvs1zaJHrhWo8fue/LL8H5j3xgxlPSO92H/9kNTUeaOvJ
	 3eUmRSbbNmhs9yhmgjFyI5YCyE1UpvHcWRG/3p80p2KqnDtBOGUueL950PWIdGDKT+
	 obRlMEK+4RyTyn54/PN73uxLpAYz4YZ++cge91mwPWqLRpASFiQRqvRIDDL5+FMjLM
	 FpzrXjznyyNBQ==
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
Subject: [PATCH AUTOSEL 5.15 08/15] net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
Date: Tue,  7 May 2024 19:13:17 -0400
Message-ID: <20240507231333.394765-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index 3010833ddde33..76aa5934e985b 100644
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


