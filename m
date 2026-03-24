Return-Path: <stable+bounces-230084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGECCQBPwmnvbAQAu9opvQ
	(envelope-from <stable+bounces-230084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:44:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C71304E90
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61D9F30BDFBE
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129DA371D00;
	Tue, 24 Mar 2026 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="wCdEs1T7"
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E6F3A5441;
	Tue, 24 Mar 2026 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341417; cv=none; b=rise/JLt7k4tBJWA8i6joCJBbvSFewJ+iBDWlfq/lxyWWFTORPZMNLDRq7/nrOabDk5SqMRLORhmR28qokpwQy1wgSwdTk+iiipLNaQP/y84KHncgOdmZyN21DCocytJUheP7Fj4LLksy7uVnjWbiGlrK1XZs72/7VL5L/0yEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341417; c=relaxed/simple;
	bh=9aR3DY4PzbQk/tWJxiI2QHQO1B8WWwLE28Hg1hdGCOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kgo6Zi9r4WBXXMa0K/dsNBgfAxrgA9ttIoAD9GE/bl4MzCxoJpine7LCKYJUJFgGdwzVzqN/AatasOHsQTX/0y6JBi9Ji9U4pk3elZtFh75dd7tLcOHCZE5S7Ycgfvix0W0DejEqWxxvz1QRIiZ/QYks2WyE7Frzq+X0FWkntdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=wCdEs1T7; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1774341397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F1AIVSQZ3n2swBcUlLexOCDQZvYcDIRq+pqWARwqygE=;
	b=wCdEs1T7lhIB9UsHzDPrQ+647MQLC1XiQj/9dtW43xXHBglYn5AkaidFKk3LzHFzlEtxKI
	n3MzZlT5VhZZcCcAsT8zlSlwfQmZJFjouPui9akl2q5gmJLxU7ynWCXy2/WmqDecYyaurg
	CpK4jhE8mVz1MWeMJtAO32EAvZkCfRvl2rul7ppTQuH3D30Y0DbGHKQA24L7+DVmrX2l02
	oYhAPs+FEPfR5hjzjNXyp8Obg0AEWiKW67LTjk0cYMYOGlEEAwy29dlmwtNVtzPZwRcZnb
	FsYdUD1+QRCgU6HuyCzovdAtsHDFaO6GR5pjO+xTuhnaMukfvG/z6qVrACR4fw==
From: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Date: Tue, 24 Mar 2026 09:36:01 +0100
Subject: [PATCH net] net: ethernet: mtk_ppe: avoid NULL deref when gmac0 is
 disabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-wed-crash-gmac0-disabled-v1-1-3bc388aee565@simonwunderlich.de>
X-B4-Tracking: v=1; b=H4sIAPBMwmkC/yWMQQ7CMAzAvjLlTKS2WznwFcQhTcMWBAU1GyBN+
 zsFjrZkr2BSVQwO3QpVnmp6Lw38rgOeqIyCmhtDcGHv+jDgSzJyJZtwvBE7zGqUrk2S9BSj5+T
 jAC1/VDnr+7c+QpEZTn9pS7oIz98pbNsHGXP+cYEAAAA=
X-Change-ID: 20260324-wed-crash-gmac0-disabled-ae3a551cb154
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Elad Yifee <eladwf@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, 
 "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224; i=se@simonwunderlich.de;
 h=from:subject:message-id; bh=9aR3DY4PzbQk/tWJxiI2QHQO1B8WWwLE28Hg1hdGCOY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJmHfPnfHLPa4rr9gd+TR0f3fIhjfX9Xym+aL3+3p99Vp
 QVGx29N7yhlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMxOM+I8NDf6bqqNU2h8Ot
 7W6trI76dWzKwhUGjvPevuDY4D3HpXEew/8ydZNPeRclJoqwdkW3JEnd1PidOmfW5LOb7PpSXsx
 Vms0BAA==
X-Developer-Key: i=se@simonwunderlich.de; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230084-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[se@simonwunderlich.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7C71304E90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If the gmac0 is disabled, the precheck for a valid ingress device will
cause a NULL pointer deref and crash the system. This happens because
eth->netdev[0] will be NULL but the code will directly try to access
netdev_ops.

Instead of just checking for the first net_device, it must be checked if
any of the mtk_eth net_devices is matching the netdev_ops of the ingress
device.

Cc: stable@vger.kernel.org
Fixes: 73cfd947dbdb ("net: ethernet: mtk_eth_soc: ppe: prevent ppe update for non-mtk devices")
Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
---
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index cb30108f2bf6..cc8c4ef8038f 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -244,6 +244,25 @@ mtk_flow_set_output_device(struct mtk_eth *eth, struct mtk_foe_entry *foe,
 	return 0;
 }
 
+static bool
+mtk_flow_is_valid_idev(const struct mtk_eth *eth, const struct net_device *idev)
+{
+	size_t i;
+
+	if (!idev)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(eth->netdev); i++) {
+		if (!eth->netdev[i])
+			continue;
+
+		if (idev->netdev_ops == eth->netdev[i]->netdev_ops)
+			return true;
+	}
+
+	return false;
+}
+
 static int
 mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 			 int ppe_index)
@@ -270,7 +289,7 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f,
 		flow_rule_match_meta(rule, &match);
 		if (mtk_is_netsys_v2_or_greater(eth)) {
 			idev = __dev_get_by_index(&init_net, match.key->ingress_ifindex);
-			if (idev && idev->netdev_ops == eth->netdev[0]->netdev_ops) {
+			if (mtk_flow_is_valid_idev(eth, idev)) {
 				struct mtk_mac *mac = netdev_priv(idev);
 
 				if (WARN_ON(mac->ppe_idx >= eth->soc->ppe_num))

---
base-commit: 70b439bf06f6a12e491f827fa81a9887a11501f9
change-id: 20260324-wed-crash-gmac0-disabled-ae3a551cb154

Best regards,
--  
Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>


