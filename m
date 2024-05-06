Return-Path: <stable+bounces-43156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789FF8BD6CE
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 23:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FC51F24462
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63015B96B;
	Mon,  6 May 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Mjfe0IoX"
X-Original-To: stable@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BD15B55F
	for <stable@vger.kernel.org>; Mon,  6 May 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030758; cv=none; b=YANh2NUUNUDLh90w1Pl9wmDJnkFxYaVTJChhZOANBI6JaXoh5dY1aD7zgr2fOHKLo6uiKA3zicJ5/yqQ6KYttp6kRiNmol8ak2v2ULXU8DYGLpziw+5z3ZMbkZJjkbZqwQ9CG8FD0ARD7k8Q/6mbaz4KvIdxEIULsWkyH3OBJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030758; c=relaxed/simple;
	bh=FxhnZC/CizYCx74Ctf/oWcjoheLLT6fzBAQic0vPHX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJmPIC2o+/PRnOJPVqYZXGWXd2iCLb8i2cSw2zh0XUU5BjkS89Btsy7ke6+hQNaJCMFx3WEkk07Iz0OFJ3pJNorusF89EQ9Y91DSdX2AYCSnSXT8UAjjbRZVEcBl1hwo3ftJxgTquaNO10hY0yWd+E+ZLJixDJ4QeIlLft1ihe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Mjfe0IoX; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 66760600A7;
	Mon,  6 May 2024 21:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715030753;
	bh=FxhnZC/CizYCx74Ctf/oWcjoheLLT6fzBAQic0vPHX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mjfe0IoXETjEb0EiKO1F8SpTufCgYh0luLzF5lTs5l5BSl0S2CkXYpGvwfRUWwTr7
	 tn/rTUytC2HXPVRkhSMSLeRzuAqRseoUGIQA0lTjfCzUQjrvPHqWAPq0NlAhYLuUEk
	 ZZAS7bDzF63j6CL/qMyU2fqXz7jtr6+b0+ZlnDxP0rbebttGXgVGGaAXNXQlmWtScB
	 WyrRXq4NY88yjwKS0xyYrfOeIrw8kAC1lyRXKqokdgfCrrnRGNJBhQy7D5X0dA46IE
	 kzKWasDMarRzaNDuwDz7B4rKjMmQ04zFuzTHWqFYZAJt57ZLiHGXPE0YBz3JtT02Wa
	 oHpqYI8wgyBeQ==
Received: by x201s (Postfix, from userid 1000)
	id 064F42032CC; Mon, 06 May 2024 21:25:31 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.4.y 1/2] net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
Date: Mon,  6 May 2024 21:24:22 +0000
Message-ID: <20240506212423.1520562-2-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506212423.1520562-1-ast@fiberby.net>
References: <20240506212423.1520562-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Stable-dep-of: fcee2065a178 ("net: qede: use return from qede_parse_flow_attr() for flower")
[ resolved conflict in v5.4, no extack for qede_parse_actions() yet ]
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 5041994bf03f..69d9b4a32c56 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1949,8 +1949,8 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 			    struct flow_cls_offload *f)
 {
 	struct qede_arfs_fltr_node *n;
-	int min_hlen, rc = -EINVAL;
 	struct qede_arfs_tuple t;
+	int min_hlen, rc;
 
 	__qede_lock(edev);
 
@@ -1960,8 +1960,10 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	if (qede_parse_flow_attr(edev, proto, f->rule, &t))
+	if (qede_parse_flow_attr(edev, proto, f->rule, &t)) {
+		rc = -EINVAL;
 		goto unlock;
+	}
 
 	/* Validate profile mode and number of filters */
 	if ((edev->arfs->filter_count && edev->arfs->mode != t.mode) ||
@@ -1969,12 +1971,15 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 		DP_NOTICE(edev,
 			  "Filter configuration invalidated, filter mode=0x%x, configured mode=0x%x, filter count=0x%x\n",
 			  t.mode, edev->arfs->mode, edev->arfs->filter_count);
+		rc = -EINVAL;
 		goto unlock;
 	}
 
 	/* parse tc actions and get the vf_id */
-	if (qede_parse_actions(edev, &f->rule->action))
+	if (qede_parse_actions(edev, &f->rule->action)) {
+		rc = -EINVAL;
 		goto unlock;
+	}
 
 	if (qede_flow_find_fltr(edev, &t)) {
 		rc = -EEXIST;
-- 
2.43.0


