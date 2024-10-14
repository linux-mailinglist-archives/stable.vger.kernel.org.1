Return-Path: <stable+bounces-83939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D099CD43
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3587BB23764
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE41798C;
	Mon, 14 Oct 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OmZ3n4I4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0020EB;
	Mon, 14 Oct 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916259; cv=none; b=Y0Po46Q6ZkqXZwQeGbpdkE0U9M+SzW3isVlvSQMwFxMtBdruH3JkIeMIZQdXYRuSTjGpvSzIURbSPIThRtMVHJW0l8cYDWzcahK4RlhPnWNt6vadBYbALadasnREnzqR45779zaoWp9DtSCBjJzwri78RxVN6qyUc77R+lLR0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916259; c=relaxed/simple;
	bh=fVaY1fCksSeh/kSTfvqGNythRE4wD0vekD/Vl9KjYgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy/xOeFr79Dr46iHRuiz8VIKyuqb4cmKcJJLlrME1i+z+F6qUuiKJWVLrrFLndRKzK0067sVApYRLqSWmLUdngwHRsqhudTYvFu+QNoMvOS1O5B5oFRGTG04pVeA15NBune3VK22sbIlF2OeBfxVCH2C4ohVBJMV+z0DIxGCG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OmZ3n4I4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A575FC4CEC3;
	Mon, 14 Oct 2024 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728916259;
	bh=fVaY1fCksSeh/kSTfvqGNythRE4wD0vekD/Vl9KjYgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmZ3n4I4aU6Ixkb3gAp1N8Sk4wH6OVd3+EnW048fREz0GrdaLcp/tg2MNv52sKp4b
	 eVR5o4mEPpM5F53YHI7aPP9oceP5qLadKUpPLN4I+PgwIu+vVB9m90l8y17iDh/PBa
	 2lRTHEiwC0cJ0czUgMsds+fzoeLKfLFTaky60gLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 098/214] net: dsa: sja1105: fix reception from VLAN-unaware bridges
Date: Mon, 14 Oct 2024 16:19:21 +0200
Message-ID: <20241014141048.820742846@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141044.974962104@linuxfoundation.org>
References: <20241014141044.974962104@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 1f9fc48fd302be3311186152225ef195e6139d7a ]

The blamed commit introduced an unexpected regression in the sja1105
driver. Packets from VLAN-unaware bridge ports get received correctly,
but the protocol stack can't seem to decode them properly.

For ds->untag_bridge_pvid users (thus also sja1105), the blamed commit
did introduce a functional change: dsa_switch_rcv() used to call
dsa_untag_bridge_pvid(), which looked like this:

	err = br_vlan_get_proto(br, &proto);
	if (err)
		return skb;

	/* Move VLAN tag from data to hwaccel */
	if (!skb_vlan_tag_present(skb) && skb->protocol == htons(proto)) {
		skb = skb_vlan_untag(skb);
		if (!skb)
			return NULL;
	}

and now it calls dsa_software_vlan_untag() which has just this:

	/* Move VLAN tag from data to hwaccel */
	if (!skb_vlan_tag_present(skb)) {
		skb = skb_vlan_untag(skb);
		if (!skb)
			return NULL;
	}

thus lacks any skb->protocol == bridge VLAN protocol check. That check
is deferred until a later check for skb->vlan_proto (in the hwaccel area).

The new code is problematic because, for VLAN-untagged packets,
skb_vlan_untag() blindly takes the 4 bytes starting with the EtherType
and turns them into a hwaccel VLAN tag. This is what breaks the protocol
stack.

It would be tempting to "make it work as before" and only call
skb_vlan_untag() for those packets with the skb->protocol actually
representing a VLAN.

But the premise of the newly introduced dsa_software_vlan_untag() core
function is not wrong. Drivers set ds->untag_bridge_pvid or
ds->untag_vlan_aware_bridge_pvid presumably because they send all
traffic to the CPU reception path as VLAN-tagged. So why should we spend
any additional CPU cycles assuming that the packet may be VLAN-untagged?
And why does the sja1105 driver opt into ds->untag_bridge_pvid if it
doesn't always deliver packets to the CPU as VLAN-tagged?

The answer to the latter question is indeed more interesting: it doesn't
need to. This got done in commit 884be12f8566 ("net: dsa: sja1105: add
support for imprecise RX"), because I thought it would be needed, but I
didn't realize that it doesn't actually make a difference.

As explained in the commit message of the blamed patch, ds->untag_bridge_pvid
only makes a difference in the VLAN-untagged receive path of a bridge port.
However, in that operating mode, tag_sja1105.c makes use of VLAN tags
with the ETH_P_SJA1105 TPID, and it decodes and consumes these VLAN tags
as if they were DSA tags (aka tag_8021q operation). Even if commit
884be12f8566 ("net: dsa: sja1105: add support for imprecise RX") added
this logic in sja1105_bridge_vlan_add():

	/* Always install bridge VLANs as egress-tagged on the CPU port. */
	if (dsa_is_cpu_port(ds, port))
		flags = 0;

that was for _bridge_ VLANs, which are _not_ committed to hardware
in VLAN-unaware mode (aka the mode where ds->untag_bridge_pvid does
anything at all). Even prior to that change, the tag_8021q VLANs
were always installed as egress-tagged on the CPU port, see
dsa_switch_tag_8021q_vlan_add():

	u16 flags = 0; // egress-tagged, non-PVID

	if (dsa_port_is_user(dp))
		flags |= BRIDGE_VLAN_INFO_UNTAGGED |
			 BRIDGE_VLAN_INFO_PVID;

	err = dsa_port_do_tag_8021q_vlan_add(dp, info->vid,
					     flags);
	if (err)
		return err;

Whether the sja1105 driver needs the new flag, ds->untag_vlan_aware_bridge_pvid,
rather than ds->untag_bridge_pvid, is a separate discussion. To fix the
current bug in VLAN-unaware bridge mode, I would argue that the sja1105
driver should not request something it doesn't need, rather than
complicating the core DSA helper. Whereas before the blamed commit, this
setting was harmless, now it has caused breakage.

Fixes: 93e4649efa96 ("net: dsa: provide a software untagging function on RX for VLAN-aware bridges")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20241001140206.50933-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index c7282ce3d11c5..6eec3be855716 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3164,7 +3164,6 @@ static int sja1105_setup(struct dsa_switch *ds)
 	 * TPID is ETH_P_SJA1105, and the VLAN ID is the port pvid.
 	 */
 	ds->vlan_filtering_is_global = true;
-	ds->untag_bridge_pvid = true;
 	ds->fdb_isolation = true;
 	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 
-- 
2.43.0




