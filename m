Return-Path: <stable+bounces-218523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGVoK5RSnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 907B518F420
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3E2B3091056
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C83E18B0A;
	Wed, 25 Feb 2026 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qw4QKwwZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049D23D7CF;
	Wed, 25 Feb 2026 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983359; cv=none; b=sxtaPhdI4uyThYwyYkzT1s97bclvOxq3xNTTOoJNZVp/GNGEPgq6JKByvf3G1lub89w/sDAs7FfIUoO3x2clPnl+zzkqXV1EXUIMog6J6IsxXf4i8pj6LxxSx7U1npdaf5/h6WBzPtJc+dMUF6CH7njy4aq1wbD8A/rBGCCaamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983359; c=relaxed/simple;
	bh=VcJqSKw2GWAEt4WmyLGvuZ4XLGdBAOYQ5e79mnVKfsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l44TlO9miC5HkxTZVgYX9F55a9EPsF23MTrQxbZ/DNkdZABesGLz2pRIfLEdXOmwWQ9HGy7fctrNLXXZj9KhggWPWugjEys9llzHSqofixPpjLzBOXm3UZDJ7RqE8xLkopITh8VlcQ+AHa0GhT+izGDE1m2CPxpFveorN+xA7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qw4QKwwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEFCC116D0;
	Wed, 25 Feb 2026 01:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983359;
	bh=VcJqSKw2GWAEt4WmyLGvuZ4XLGdBAOYQ5e79mnVKfsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qw4QKwwZnbyJV8DzW8yKUlsn8poFw8227YUVUPuKb2ovWHYPP8FIlPl5k0ghsyHrw
	 J0WsdXw7eiuAci+QvQd1WyeQHjIuilAN+/L3Pp20ns96+35mnzjyCESw1CDiNNr5KW
	 8Q7uE/9BdlthtI4df7yJAp03ez07QesMw5ji3u2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 443/781] RDMA/hns: Fix RoCEv1 failure due to DSCP
Date: Tue, 24 Feb 2026 17:19:12 -0800
Message-ID: <20260225012410.568646091@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218523-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 907B518F420
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junxian Huang <huangjunxian6@hisilicon.com>

[ Upstream commit 84bd5d60f0a2b9c763c5e6d0b3d8f4f61f6c5470 ]

DSCP is not supported in RoCEv1, but get_dscp() is still called. If
get_dscp() returns an error, it'll eventually cause create_ah to fail
even when using RoCEv1.

Correct the return value and avoid calling get_dscp() when using
RoCEv1.

Fixes: ee20cc17e9d8 ("RDMA/hns: Support DSCP")
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20260104064057.1582216-4-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c    | 23 +++++++++---------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 28 ++++++++++++----------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 0c1c32d23c884..8a605da8a93c9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -60,7 +60,7 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	u8 tclass = get_tclass(grh);
 	u8 priority = 0;
 	u8 tc_mode = 0;
-	int ret;
+	int ret = 0;
 
 	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08 && udata) {
 		ret = -EOPNOTSUPP;
@@ -77,19 +77,18 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	ah->av.flowlabel = grh->flow_label;
 	ah->av.udp_sport = get_ah_udp_sport(ah_attr);
 	ah->av.tclass = tclass;
+	ah->av.sl = rdma_ah_get_sl(ah_attr);
 
-	ret = hr_dev->hw->get_dscp(hr_dev, tclass, &tc_mode, &priority);
-	if (ret == -EOPNOTSUPP)
-		ret = 0;
-
-	if (ret && grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		goto err_out;
+	if (grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
+		ret = hr_dev->hw->get_dscp(hr_dev, tclass, &tc_mode, &priority);
+		if (ret == -EOPNOTSUPP)
+			ret = 0;
+		else if (ret)
+			goto err_out;
 
-	if (tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
-	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		ah->av.sl = priority;
-	else
-		ah->av.sl = rdma_ah_get_sl(ah_attr);
+		if (tc_mode == HNAE3_TC_MAP_MODE_DSCP)
+			ah->av.sl = priority;
+	}
 
 	if (!check_sl_valid(hr_dev, ah->av.sl)) {
 		ret = -EINVAL;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index f95442798ddb3..1f37d74b466b5 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -5053,20 +5053,22 @@ static int hns_roce_set_sl(struct ib_qp *ibqp,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
-	ret = hns_roce_hw_v2_get_dscp(hr_dev, get_tclass(&attr->ah_attr.grh),
-				      &hr_qp->tc_mode, &hr_qp->priority);
-	if (ret && ret != -EOPNOTSUPP &&
-	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
-		ibdev_err_ratelimited(ibdev,
-				      "failed to get dscp, ret = %d.\n", ret);
-		return ret;
-	}
+	hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
 
-	if (hr_qp->tc_mode == HNAE3_TC_MAP_MODE_DSCP &&
-	    grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP)
-		hr_qp->sl = hr_qp->priority;
-	else
-		hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+	if (grh->sgid_attr->gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
+		ret = hns_roce_hw_v2_get_dscp(hr_dev,
+					      get_tclass(&attr->ah_attr.grh),
+					      &hr_qp->tc_mode, &hr_qp->priority);
+		if (ret && ret != -EOPNOTSUPP) {
+			ibdev_err_ratelimited(ibdev,
+					      "failed to get dscp, ret = %d.\n",
+					      ret);
+			return ret;
+		}
+
+		if (hr_qp->tc_mode == HNAE3_TC_MAP_MODE_DSCP)
+			hr_qp->sl = hr_qp->priority;
+	}
 
 	if (!check_sl_valid(hr_dev, hr_qp->sl))
 		return -EINVAL;
-- 
2.51.0




