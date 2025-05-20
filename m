Return-Path: <stable+bounces-145209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79A1ABDA8A
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B32189B744
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D92242D7D;
	Tue, 20 May 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hOQV7Qe5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C422D7A8;
	Tue, 20 May 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749488; cv=none; b=VgL5eS9Z1TeNg5uCm/fhv1i3LPGpVNLjhBPEqT6lUbMYTMrRxwEWM0GlI1KqhmiIjb35k1iVXqGrWyRyPUCNDRzQZHYlvaTwHLeOBI/XAmUyu3QLcBmim8HGYmInG2gLh6bD0R9bycGSfwMIQDkKTks/Nca4tqOVkcW22NyBoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749488; c=relaxed/simple;
	bh=rg+K04/zpmt7rgDjPlWE/2A7o0oAWL43tsqcxEqRCN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JziQsK7FD+Y+v/AvTEvQokXxCmhWVDJW0cAUrlNAecXTUXXOy6Dt/OSD4Goh3vWKZc1YzJCsYZPnjkf1Kdbh4xT4V/B9/GG2XWLE/AhINamscm53vu3bmCVrAcRC68XtZB+MAwg/pVV/AP5MP5cnKvnzRH6Qk/MXVKxsIvo4OcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hOQV7Qe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EA7C4CEE9;
	Tue, 20 May 2025 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749488;
	bh=rg+K04/zpmt7rgDjPlWE/2A7o0oAWL43tsqcxEqRCN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOQV7Qe5tPf0ARye96+IYJ3HhC+YY/dnKsQOiLL7W4D/7CpYLgyTfTrQRACWUROMm
	 dk3JMMUkMBX0vkHM5dcF1zX2/jaq6hRiiJjdDQTmFJpuJO3DllmfCqLvnZvsP0XE9N
	 pvhwrtmq1FKHHhNR9wFnxD3rx/8Gcjq3wgJg9+7I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 30/97] net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING
Date: Tue, 20 May 2025 15:49:55 +0200
Message-ID: <20250520125801.840675708@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index f1f1368e8146f..d51d982c4bc01 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2083,6 +2083,7 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
 	switch (state) {
 	case BR_STATE_DISABLED:
 	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
 		/* From UM10944 description of DRPDTAG (why put this there?):
 		 * "Management traffic flows to the port regardless of the state
 		 * of the INGRESS flag". So BPDUs are still be allowed to pass.
@@ -2092,11 +2093,6 @@ static void sja1105_bridge_stp_state_set(struct dsa_switch *ds, int port,
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




