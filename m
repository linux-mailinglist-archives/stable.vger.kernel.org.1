Return-Path: <stable+bounces-236030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNxTGLDf3GnrXgkAu9opvQ
	(envelope-from <stable+bounces-236030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:21:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A807B3EBD5C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8694F303AAAA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412B3C197F;
	Mon, 13 Apr 2026 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CbDf8HSA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638535DA4F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082533; cv=none; b=eXapnOgoVex8z0jUpgrNp15pjAggEcaqf9IV4eiHC4WyDsbfWvFnhbZM6WI0itq0kPg7EjYGlw4DCjteAd05yu6iuTnVzEWlbJQu80yBkwowQpsT1jsWfqavIOfhw+QzLXFZcmdO2jHasPTuFfA0IMLd0xV9Uqvt6vhtfkTvVtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082533; c=relaxed/simple;
	bh=+dZyMMafc1Ev6PnWdXkJaT6luuJVdQInUiMZubdmg+0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mEjGhuYGfgeRzsVUZKsEA/sogbpwqN1ElRYr7pWXmuaOaVzawsttcGg/qSxVJ823zZLT3+ptbV5CS3FHkjey7Ol9PQNwyVSQ6YEVNYW/UfY0NDHP4vjBK+2AziMyR+3idmASgQI20xuzX1JA5E6wtNpAbQP/Aby03tU8cRT9Ojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CbDf8HSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488C2C2BCAF;
	Mon, 13 Apr 2026 12:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776082533;
	bh=+dZyMMafc1Ev6PnWdXkJaT6luuJVdQInUiMZubdmg+0=;
	h=Subject:To:Cc:From:Date:From;
	b=CbDf8HSAUIe6jCBYtcEZ1NpGrhxG3eaE4DDo5zH9arbddwWXpyIplWueQTtxQknMJ
	 GHqLNzkbR8bQ0mvK9VuJ/a0HMBZ4GqwTxJ45UVVzEA963XZJbxA+KR0CLDVsgtMZL1
	 /bk8K22qq1LXX94MHjsoLOL4g9rN9RZMOlfvOlDg=
Subject: FAILED: patch "[PATCH] batman-adv: hold claim backbone gateways by reference" failed to apply to 5.15-stable tree
To: royenheart@gmail.com,bird@lzu.edu.cn,n05ec@lzu.edu.cn,sven@narfation.org,sw@simonwunderlich.de,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Apr 2026 14:15:31 +0200
Message-ID: <2026041331-darkness-relic-85a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236030-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lzu.edu.cn,narfation.org,simonwunderlich.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,simonwunderlich.de:email,narfation.org:email,gregkh:email,lzu.edu.cn:email]
X-Rspamd-Queue-Id: A807B3EBD5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 82d8701b2c930d0e96b0dbc9115a218d791cb0d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026041331-darkness-relic-85a7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82d8701b2c930d0e96b0dbc9115a218d791cb0d2 Mon Sep 17 00:00:00 2001
From: Haoze Xie <royenheart@gmail.com>
Date: Mon, 6 Apr 2026 21:17:28 +0800
Subject: [PATCH] batman-adv: hold claim backbone gateways by reference

batadv_bla_add_claim() can replace claim->backbone_gw and drop the old
gateway's last reference while readers still follow the pointer.

The netlink claim dump path dereferences claim->backbone_gw->orig and
takes claim->backbone_gw->crc_lock without pinning the underlying
backbone gateway. batadv_bla_check_claim() still has the same naked
pointer access pattern.

Reuse batadv_bla_claim_get_backbone_gw() in both readers so they operate
on a stable gateway reference until the read-side work is complete.
This keeps the dump and claim-check paths aligned with the lifetime
rules introduced for the other BLA claim readers.

Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Fixes: 04f3f5bf1883 ("batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink")
Cc: stable@vger.kernel.org
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 3dc791c15bf7..648fa97ea913 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2130,6 +2130,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct batadv_bla_claim *claim)
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
+	struct batadv_bla_backbone_gw *backbone_gw;
 	u16 backbone_crc;
 	bool is_own;
 	void *hdr;
@@ -2145,32 +2146,35 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
-	is_own = batadv_compare_eth(claim->backbone_gw->orig,
-				    primary_addr);
+	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 
-	spin_lock_bh(&claim->backbone_gw->crc_lock);
-	backbone_crc = claim->backbone_gw->crc;
-	spin_unlock_bh(&claim->backbone_gw->crc_lock);
+	is_own = batadv_compare_eth(backbone_gw->orig, primary_addr);
+
+	spin_lock_bh(&backbone_gw->crc_lock);
+	backbone_crc = backbone_gw->crc;
+	spin_unlock_bh(&backbone_gw->crc_lock);
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {
 			genlmsg_cancel(msg, hdr);
-			goto out;
+			goto put_backbone_gw;
 		}
 
 	if (nla_put(msg, BATADV_ATTR_BLA_ADDRESS, ETH_ALEN, claim->addr) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, claim->vid) ||
 	    nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
-		    claim->backbone_gw->orig) ||
+		    backbone_gw->orig) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
 			backbone_crc)) {
 		genlmsg_cancel(msg, hdr);
-		goto out;
+		goto put_backbone_gw;
 	}
 
 	genlmsg_end(msg, hdr);
 	ret = 0;
 
+put_backbone_gw:
+	batadv_backbone_gw_put(backbone_gw);
 out:
 	return ret;
 }
@@ -2448,6 +2452,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 			    u8 *addr, unsigned short vid)
 {
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_bla_claim search_claim;
 	struct batadv_bla_claim *claim = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -2470,9 +2475,13 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 	 * return false.
 	 */
 	if (claim) {
-		if (!batadv_compare_eth(claim->backbone_gw->orig,
+		backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
+
+		if (!batadv_compare_eth(backbone_gw->orig,
 					primary_if->net_dev->dev_addr))
 			ret = false;
+
+		batadv_backbone_gw_put(backbone_gw);
 		batadv_claim_put(claim);
 	}
 


