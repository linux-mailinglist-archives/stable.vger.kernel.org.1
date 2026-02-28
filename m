Return-Path: <stable+bounces-220405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGC+GXNIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EFF1C795B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D77630BD88A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F8248034A;
	Sat, 28 Feb 2026 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgDPclcX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0103AC616;
	Sat, 28 Feb 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300296; cv=none; b=GyzM738V69J0ACS9yaSWFdn/j/z8JRjzzE3jABHH5qARJL+Ba7TuvEwRk2YzkOvw9iQqy+bwUmVdqV6Fi/FDQIHHeQ3/xbvDaJz85GLERicQQPGeIYRiUDssTTx4G4X4zLAi8S/oanz/SquE9EwEIiXaiw/fCCPP9N4O2AdH0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300296; c=relaxed/simple;
	bh=ZzOY2QlqWAp4Qat/4E/iQvMtW9oNsInxHa5TgouFuZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Osanl4hzyJwrb4a9U3eAID/Cy2J0pXU0HfbEh6gCPSk1S2a0Eicuj7pKN0qCrG9P+ay/iCtiCOEbny9kwdqHiYkmWb+e3pyU16qAWCm28oze0OCqfCn4cNZHzrqc29JqtWzHdl2ocypBt6oyXjiNzKygy9yxX3txhBeRW1Yg3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgDPclcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00152C116D0;
	Sat, 28 Feb 2026 17:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300296;
	bh=ZzOY2QlqWAp4Qat/4E/iQvMtW9oNsInxHa5TgouFuZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OgDPclcX5RVFfPL0k8eazEDcNUyNVAHftXZkOiWpRQCCBxJzVnwolzAmAiScEty9c
	 4dv1EtoUuNiGUpDaDJ0h9IomZvTYXSnSyhhE2ntwIG0qaBR9PyiaoL6mEm8JXO5Xqf
	 DYIwrVzFBwPsHh9GRqLYagwvpO73IMyKgN0OuZ7P07Xdh27ZETQADvVg9TvE5Q2Gd7
	 L8Fqe8UXNAKPRaAjK3fhgXOxGvfRy6HoCT40fP8ZqnVmZQ8vZK+CuTtIyRpreNPUK2
	 2Xen0RkqISnu4SDup8rwWAPEJY9LQqH3TNSXhk63jRQmdxcpBpKB7htZzM5EMTYWbY
	 ytb+KMGMATR7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 326/844] bnxt_en: Allow ntuple filters for drops
Date: Sat, 28 Feb 2026 12:23:59 -0500
Message-ID: <20260228173244.1509663-327-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220405-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url]
X-Rspamd-Queue-Id: 86EFF1C795B
X-Rspamd-Action: no action

From: Joe Damato <joe@dama.to>

[ Upstream commit 61cef6454cfbb9fcdbe41401fb53895f86603081 ]

It appears that in commit 7efd79c0e689 ("bnxt_en: Add drop action
support for ntuple"), bnxt gained support for ntuple filters for packet
drops.

However, support for this does not seem to work in recent kernels or
against net-next:

  % sudo ethtool -U eth0 flow-type udp4 src-ip 1.1.1.1 action -1
    rmgr: Cannot insert RX class rule: Operation not supported
    Cannot insert classification rule

The issue is that the existing code uses ethtool_get_flow_spec_ring_vf,
which will return a non-zero value if the ring_cookie is set to
RX_CLS_FLOW_DISC, which then causes bnxt_add_ntuple_cls_rule to return
-EOPNOTSUPP because it thinks the user is trying to set an ntuple filter
for a vf.

Fix this by first checking that the ring_cookie is not RX_CLS_FLOW_DISC.

After this patch, ntuple filters for drops can be added:

  % sudo ethtool -U eth0 flow-type udp4 src-ip 1.1.1.1 action -1
  Added rule with ID 0

  % ethtool -n eth0
  44 RX rings available
  Total 1 rules

  Filter: 0
      Rule Type: UDP over IPv4
      Src IP addr: 1.1.1.1 mask: 0.0.0.0
      Dest IP addr: 0.0.0.0 mask: 255.255.255.255
      TOS: 0x0 mask: 0xff
      Src port: 0 mask: 0xffff
      Dest port: 0 mask: 0xffff
      Action: Drop

Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260131003042.2570434-1-joe@dama.to
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 068e191ede19e..c76a7623870be 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1346,16 +1346,17 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	struct bnxt_l2_filter *l2_fltr;
 	struct bnxt_flow_masks *fmasks;
 	struct flow_keys *fkeys;
-	u32 idx, ring;
+	u32 idx;
 	int rc;
-	u8 vf;
 
 	if (!bp->vnic_info)
 		return -EAGAIN;
 
-	vf = ethtool_get_flow_spec_ring_vf(fs->ring_cookie);
-	ring = ethtool_get_flow_spec_ring(fs->ring_cookie);
-	if ((fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT)) || vf)
+	if (fs->flow_type & (FLOW_MAC_EXT | FLOW_EXT))
+		return -EOPNOTSUPP;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    ethtool_get_flow_spec_ring_vf(fs->ring_cookie))
 		return -EOPNOTSUPP;
 
 	if (flow_type == IP_USER_FLOW) {
@@ -1481,7 +1482,7 @@ static int bnxt_add_ntuple_cls_rule(struct bnxt *bp,
 	if (fs->ring_cookie == RX_CLS_FLOW_DISC)
 		new_fltr->base.flags |= BNXT_ACT_DROP;
 	else
-		new_fltr->base.rxq = ring;
+		new_fltr->base.rxq = ethtool_get_flow_spec_ring(fs->ring_cookie);
 	__set_bit(BNXT_FLTR_VALID, &new_fltr->base.state);
 	rc = bnxt_insert_ntp_filter(bp, new_fltr, idx);
 	if (!rc) {
-- 
2.51.0


