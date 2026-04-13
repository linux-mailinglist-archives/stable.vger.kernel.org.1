Return-Path: <stable+bounces-236635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MRQCMMg3WneaAkAu9opvQ
	(envelope-from <stable+bounces-236635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:58:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 715183F0668
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A847321791D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB491309DB5;
	Mon, 13 Apr 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="baf/XGxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F98E2FFFBE;
	Mon, 13 Apr 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097414; cv=none; b=uMa4+J35cIV11WTDA3lzS9bvVhf7udHrMfyN79EYqOedjMUG412ub9UX/6ZYZ65dSK8Npg3KFGJmbQNkU+UWoyEom+azdFYtKpAAUh8694GiTatbRwisqfkBbfczsSDPUQqPlyJWhq3EdABlvtoI4nA5yPKMnxfY5n5Dj+FDIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097414; c=relaxed/simple;
	bh=WTZZTHkovjychB617eHCXpN2sHE+cSHQ/o/kOgwoHHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbrdcAj0lPRiSeIoXNph/BYxC/DOK9JraVGhaAO9M/6o7iCMq30e6vLT3g8STMGCjk7YqZ5fvo/ctCdcZfwYPtlXEK7zZj4AJbT+AQWrxm9JfeJWG3smodhyZQ20AjL9ykPwr/pKNp1MN0Am3jOF+K7nUK37zy+R0MHxagPsHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=baf/XGxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C21C2BCAF;
	Mon, 13 Apr 2026 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097414;
	bh=WTZZTHkovjychB617eHCXpN2sHE+cSHQ/o/kOgwoHHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baf/XGxb5al27ao4f5EyWftp/U6369LCqjSNwjKTBeGMAGouQ+ABRv6zMGKFBh+dj
	 RB+54tri+kV+Xad85voUGbItvSKzCFxiUn9UAIGsSmV2+EMLtP2C0VzJcDGpcSeDGO
	 KiBzdafkovn0G6nsfNchRXZ2OPmisb3G+BQTzuxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 085/570] net: stmmac: Fix error handling in VLAN add and delete paths
Date: Mon, 13 Apr 2026 17:53:36 +0200
Message-ID: <20260413155833.627836999@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236635-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,renesas.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 715183F0668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

[ Upstream commit 35dfedce442c4060cfe5b98368bc9643fb995716 ]

stmmac_vlan_rx_add_vid() updates active_vlans and the VLAN hash
register before writing the HW filter entry. If the filter write
fails, it leaves a stale VID in active_vlans and the hash register.

stmmac_vlan_rx_kill_vid() has the reverse problem: it clears
active_vlans before removing the HW filter. On failure, the VID is
gone from active_vlans but still present in the HW filter table.

To fix this, reorder the operations to update the hash table first,
then attempt the HW filter operation. If the HW filter fails, roll
back both the active_vlans bitmap and the hash table by calling
stmmac_vlan_update() again.

Fixes: ed64639bc1e0 ("net: stmmac: Add support for VLAN Rx filtering")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Link: https://patch.msgid.link/20260303145828.7845-2-ovidiu.panait.rb@renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e056b512c1277..70e941650b425 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6281,9 +6281,13 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 
 	if (priv->hw->num_vlan) {
 		ret = stmmac_add_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
-		if (ret)
+		if (ret) {
+			clear_bit(vid, priv->active_vlans);
+			stmmac_vlan_update(priv, is_double);
 			goto err_pm_put;
+		}
 	}
+
 err_pm_put:
 	pm_runtime_put(priv->device);
 
@@ -6306,15 +6310,21 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 		is_double = true;
 
 	clear_bit(vid, priv->active_vlans);
+	ret = stmmac_vlan_update(priv, is_double);
+	if (ret) {
+		set_bit(vid, priv->active_vlans);
+		goto del_vlan_error;
+	}
 
 	if (priv->hw->num_vlan) {
 		ret = stmmac_del_hw_vlan_rx_fltr(priv, ndev, priv->hw, proto, vid);
-		if (ret)
+		if (ret) {
+			set_bit(vid, priv->active_vlans);
+			stmmac_vlan_update(priv, is_double);
 			goto del_vlan_error;
+		}
 	}
 
-	ret = stmmac_vlan_update(priv, is_double);
-
 del_vlan_error:
 	pm_runtime_put(priv->device);
 
-- 
2.51.0




