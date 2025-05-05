Return-Path: <stable+bounces-140055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19FAAA469
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C24465650
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E8288CA8;
	Mon,  5 May 2025 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/qDpzAB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5D2FFC6D;
	Mon,  5 May 2025 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483991; cv=none; b=Y8fSHzYM/afi3QnZC19ZOcj+mMB2giV7BsqpAh/1FhkVFqcCPodiEN5BaIkyMhtL1n3IEWv28wqFgwJxVf+UCNmOkK1oOMxBOsyO2BEux8/4HjP2G1ich8STWkYoO2K3YBF1tNnuSQdL+/Hp+65NUemFMZesx0qVoMLam7h+hXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483991; c=relaxed/simple;
	bh=DXfYW3r1DBrCeuxs2FZqkes4nI1/Zin0FtfeaKoIqGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQtDLHFQOv5YKb6BNsMN1KkTJlM6wz0/eoaEDtkEzlu56/KPpZfQ8DQRibPIO0C1U4L+jN7Yb7VnHlR2rlET9OL9GU2a4qso6wD5u3oViQwOMCcaAMo3sMsXvE9jtdDywG2rLUKDMun5otu4/QsRtandIjFPz95iqcMquNZVyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/qDpzAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B0DC4CEF2;
	Mon,  5 May 2025 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483991;
	bh=DXfYW3r1DBrCeuxs2FZqkes4nI1/Zin0FtfeaKoIqGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/qDpzABwBWFNSrq1oqAlehBbf3G15yzPlixl+px0POMaT9ZlUrsLFPwvHD98r7ej
	 XLJRkHNLJqZ6GHk+T3IDO1Bx+PvfDCZ2E2m3Jycan5wDh712n4nq4hssddvhGb31B4
	 EgV7f3iYYAVdLxzg3Ik5zIaLFqsPQAk8yI+j0CtDsyhg2SZ3Z66prsyypm48YnE0vw
	 PT5uB2nVkz3FkRmjufB1gGDuKne0TMx/BsJTEErNnFLtiHQ7B5kZT+7lf+o7meIhQ9
	 Dm5QB32GWW7RrRDOuhqJ5LP3t+oBxFAe0MHPIZVk9rBNMMJXVWUoMS8/uWFOKhrmDZ
	 KSMFGmZhpXQFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 308/642] net: ethernet: mtk_ppe_offload: Allow QinQ, double ETH_P_8021Q only
Date: Mon,  5 May 2025 18:08:44 -0400
Message-Id: <20250505221419.2672473-308-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Eric Woudstra <ericwouds@gmail.com>

[ Upstream commit 7fe0353606d77a32c4c7f2814833dd1c043ebdd2 ]

mtk_foe_entry_set_vlan() in mtk_ppe.c already supports double vlan
tagging, but mtk_flow_offload_replace() in mtk_ppe_offload.c only allows
for 1 vlan tag, optionally in combination with pppoe and dsa tags.

However, mtk_foe_entry_set_vlan() only allows for setting the vlan id.
The protocol cannot be set, it is always ETH_P_8021Q, for inner and outer
tag. This patch adds QinQ support to mtk_flow_offload_replace(), only in
the case that both inner and outer tags are ETH_P_8021Q.

Only PPPoE-in-Q (as before) and Q-in-Q are allowed. A combination
of PPPoE and Q-in-Q is not allowed.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
Link: https://patch.msgid.link/20250225201509.20843-1-ericwouds@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mediatek/mtk_ppe_offload.c   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index f20bb390df3ad..c855fb799ce14 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -34,8 +34,10 @@ struct mtk_flow_data {
 	u16 vlan_in;
 
 	struct {
-		u16 id;
-		__be16 proto;
+		struct {
+			u16 id;
+			__be16 proto;
+		} vlans[2];
 		u8 num;
 	} vlan;
 	struct {
@@ -349,18 +351,19 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		case FLOW_ACTION_CSUM:
 			break;
 		case FLOW_ACTION_VLAN_PUSH:
-			if (data.vlan.num == 1 ||
+			if (data.vlan.num + data.pppoe.num == 2 ||
 			    act->vlan.proto != htons(ETH_P_8021Q))
 				return -EOPNOTSUPP;
 
-			data.vlan.id = act->vlan.vid;
-			data.vlan.proto = act->vlan.proto;
+			data.vlan.vlans[data.vlan.num].id = act->vlan.vid;
+			data.vlan.vlans[data.vlan.num].proto = act->vlan.proto;
 			data.vlan.num++;
 			break;
 		case FLOW_ACTION_VLAN_POP:
 			break;
 		case FLOW_ACTION_PPPOE_PUSH:
-			if (data.pppoe.num == 1)
+			if (data.pppoe.num == 1 ||
+			    data.vlan.num == 2)
 				return -EOPNOTSUPP;
 
 			data.pppoe.sid = act->pppoe.sid;
@@ -450,12 +453,9 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 	if (offload_type == MTK_PPE_PKT_TYPE_BRIDGE)
 		foe.bridge.vlan = data.vlan_in;
 
-	if (data.vlan.num == 1) {
-		if (data.vlan.proto != htons(ETH_P_8021Q))
-			return -EOPNOTSUPP;
+	for (i = 0; i < data.vlan.num; i++)
+		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.vlans[i].id);
 
-		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.id);
-	}
 	if (data.pppoe.num == 1)
 		mtk_foe_entry_set_pppoe(eth, &foe, data.pppoe.sid);
 
-- 
2.39.5


