Return-Path: <stable+bounces-149871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB05DACB43F
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31CE7A466C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551BA20E6E3;
	Mon,  2 Jun 2025 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LT74emqq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB722539F;
	Mon,  2 Jun 2025 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875307; cv=none; b=jsNN5yQB+4ZHwNx+S3Ej0BAyKBugwT7ZQF7vNM4b3U1etLGrtTvoZaqiNF2bxI9GSiNGKSPsYcNliy2KcFUSTUvdF6X+ZOdP+CN/Fi4o5hsUv6aMvyI9u9WK5WPWVekiNeCfv5Po8IzzAgfSI0O0rhc83QPKO/ZshgihqRAmKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875307; c=relaxed/simple;
	bh=UrsIzcl+g+JCUs2EmVIty1FICpwNaSbA2812N3A34o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSqUlpCmL4/AHywVAl4XVUR8HykVqhJwJfmAe0hxuSDhLjHdg8GOI0yADmK5dnZzWo5JofZBtN8imzeWVoRJJQvqNtrtBBoquRGNve2v3uFbBEfLsQygZSlBjxNR7RFKgNyXlf0JHcyAyjPwXkhmrB3vDnU45ncvRPwVvM3ddv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LT74emqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D44C4CEEB;
	Mon,  2 Jun 2025 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875306;
	bh=UrsIzcl+g+JCUs2EmVIty1FICpwNaSbA2812N3A34o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LT74emqqskw5JC8N7vxlJWXT18Zzy+0eq9QnWkgbvaP70mK2vJMIpDFDrGddlwdzF
	 LQtpZcem1/SFzAKmI0y8+PtLDKsZuyYdO1qt7L+A5GRoYE7h+WjjPzMhCG63m2bhtF
	 5WrttdMxAGIT5beiOxttE+Xn3M96plHPi3If8qw4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 091/270] net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING
Date: Mon,  2 Jun 2025 15:46:16 +0200
Message-ID: <20250602134310.894418310@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 498625a8ab2c8e1c9ab5105744310e8d6952cc01 ]

It has been reported that when under a bridge with stp_state=1, the logs
get spammed with this message:

[  251.734607] fsl_dpaa2_eth dpni.5 eth0: Couldn't decode source port

Further debugging shows the following info associated with packets:
source_port=-1, switch_id=-1, vid=-1, vbid=1

In other words, they are data plane packets which are supposed to be
decoded by dsa_tag_8021q_find_port_by_vbid(), but the latter (correctly)
refuses to do so, because no switch port is currently in
BR_STATE_LEARNING or BR_STATE_FORWARDING - so the packet is effectively
unexpected.

The error goes away after the port progresses to BR_STATE_LEARNING in 15
seconds (the default forward_time of the bridge), because then,
dsa_tag_8021q_find_port_by_vbid() can correctly associate the data plane
packets with a plausible bridge port in a plausible STP state.

Re-reading IEEE 802.1D-1990, I see the following:

"4.4.2 Learning: (...) The Forwarding Process shall discard received
frames."

IEEE 802.1D-2004 further clarifies:

"DISABLED, BLOCKING, LISTENING, and BROKEN all correspond to the
DISCARDING port state. While those dot1dStpPortStates serve to
distinguish reasons for discarding frames, the operation of the
Forwarding and Learning processes is the same for all of them. (...)
LISTENING represents a port that the spanning tree algorithm has
selected to be part of the active topology (computing a Root Port or
Designated Port role) but is temporarily discarding frames to guard
against loops or incorrect learning."

Well, this is not what the driver does - instead it sets
mac[port].ingress = true.

To get rid of the log spam, prevent unexpected data plane packets to
be received by software by discarding them on ingress in the LISTENING
state.

In terms of blame attribution: the prints only date back to commit
d7f9787a763f ("net: dsa: tag_8021q: add support for imprecise RX based
on the VBID"). However, the settings would permit a LISTENING port to
forward to a FORWARDING port, and the standard suggests that's not OK.

Fixes: 640f763f98c2 ("net: dsa: sja1105: Add support for Spanning Tree Protocol")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250509113816.2221992-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 4362fe0f346d2..5f5e5b8267e0c 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1644,6 +1644,7 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
 		/* From UM10944 description of DRPDTAG (why put this there?):
 		 * "Management traffic flows to the port regardless of the state
 		 * of the INGRESS flag". So BPDUs are still be allowed to pass.
@@ -1653,11 +1654,6 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 		mac[port].egress    = false;
 		mac[port].dyn_learn = false;
 		break;
-	case BR_STATE_LISTENING:
-		mac[port].ingress   = true;
-		mac[port].egress    = false;
-		mac[port].dyn_learn = false;
-		break;
 	case BR_STATE_LEARNING:
 		mac[port].ingress   = true;
 		mac[port].egress    = false;
-- 
2.39.5




