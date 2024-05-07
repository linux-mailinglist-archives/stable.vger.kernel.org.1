Return-Path: <stable+bounces-43420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D088BF2A2
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB13284EF5
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08919F0D5;
	Tue,  7 May 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnlAlQ1V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0519F0CA;
	Tue,  7 May 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123656; cv=none; b=QZ2ogfIwAzwcreNt6KG9UwfHFFC+vDjv/oAxPocGvR0OxYyafstsQA/q4Sab+TQVOWxOT9dMUe3skMfLih0e5hUg/AZtGv2Kgfb/Zlz6pfnl4HwZuSiPzcRrdtIp3oLZcX1Dc7xYtsFI1Wz1VmAYokx2flr2qJ9TDgW1fhHR98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123656; c=relaxed/simple;
	bh=Dxj5RRktJQRL9gOBT4vzGDQo76tsHd9nRkN7+UYgGiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1i1GlCgL08327mJnbtWBZQEtLVg6PJAptHU9VuLKp3iCqtOeOoNJ5/LMLPksjJqlMypmR7BDo+271a/hmYYHMUDnH6O/vYhmekEsCigCx10jiphSyykZJvSN89WANeIbCQ3o85A8sCAMIff6/74ehFnDpw4KG6/HYZLeusVQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnlAlQ1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8279C3277B;
	Tue,  7 May 2024 23:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123656;
	bh=Dxj5RRktJQRL9gOBT4vzGDQo76tsHd9nRkN7+UYgGiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnlAlQ1VxHPrG4ZfGSiatVuKi27tOX2oAtB3w7OL2g42IjvSx1g4y+GokpxWwLdCy
	 oa6MwDcR848IB2il/Vnj9HWw6eLWoqxhmXxJpeQGaIVoYDfepaF/1DGsnWO++7lgal
	 CB7avGG8ETxDxYr39A+f1DN85ZTsYzXEAozhIfZwPyaSpCEGooKDLK9R7AtCsBnadj
	 Huj6e7G1MtP9f8lF0RFD5XGaNjKpc97kSQodTfvn/h3LnIpWwNSM9YFXiIWhBkel5w
	 uS2AIGLU0DFiifWFS19qCh2MZ3OFVrdigxshG+TvwPSepw9ULVO3/BURGyJOZnti3c
	 99Qlmoz4TTebA==
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
Subject: [PATCH AUTOSEL 5.10 5/9] net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
Date: Tue,  7 May 2024 19:14:00 -0400
Message-ID: <20240507231406.395123-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231406.395123-1-sashal@kernel.org>
References: <20240507231406.395123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
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
index a2e4dfb5cb44e..ba28381c26bbf 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1877,8 +1877,8 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 			    struct flow_cls_offload *f)
 {
 	struct qede_arfs_fltr_node *n;
-	int min_hlen, rc = -EINVAL;
 	struct qede_arfs_tuple t;
+	int min_hlen, rc;
 
 	__qede_lock(edev);
 
@@ -1888,8 +1888,10 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 	}
 
 	/* parse flower attribute and prepare filter */
-	if (qede_parse_flow_attr(edev, proto, f->rule, &t))
+	if (qede_parse_flow_attr(edev, proto, f->rule, &t)) {
+		rc = -EINVAL;
 		goto unlock;
+	}
 
 	/* Validate profile mode and number of filters */
 	if ((edev->arfs->filter_count && edev->arfs->mode != t.mode) ||
@@ -1897,12 +1899,15 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
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


