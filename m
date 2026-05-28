Return-Path: <stable+bounces-255099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CELHAtabGGr+lQgAu9opvQ
	(envelope-from <stable+bounces-255099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:47:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2295F74F0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41DA8301C6A6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A300313539;
	Thu, 28 May 2026 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="pV/iVUmM"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A926C3BD
	for <stable@vger.kernel.org>; Thu, 28 May 2026 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997591; cv=none; b=indFJ3vP6hzTP+W67t3dmSXR1C7/Okxvv2wyfer+zQ/lIKE1veDPMc317ppi2GXG7gweDRe0LsijpvmcZYGz5ZfPSbmYl1L3JMbKJq2PAgxWxVlfznJ7PDCnovT9Lop42vR/qN8bXFv3JIu4RXBcwvFfQsgxoZDTtyjwvF5T7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997591; c=relaxed/simple;
	bh=rZb/7khu9hYByppE9ZeoxGCVZHODZTMPQ89M7G7RMvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRCQmrIsUirPxIVACVesTYIQQ7T0II9ngLNXt+pIa7YbcBcm2RWQpQLW+zg2Lw26tiVR4sEE8iyzzh4cKJGA1UCaYKsxetoLR29a8eqEcRi9A9TidwAVtb1MBc/DJqrKknnuSe19QllBgJUFOMvHbRFGlnGMAk4RzLARIl8cO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=pV/iVUmM; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id AA04720074;
	Thu, 28 May 2026 19:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779997587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhWhzo8Wb+lG6HflMJhExbWB0/rmWZ/Ebl/Q8qMRnsw=;
	b=pV/iVUmMCvWJw1I9cl0RpKaBM3ERFlqS0DSw6eFQ/r/ivFE/j7TE50gig0unWynWSUoIqs
	+Hb+b6+GdsysdhHj1uSTx1ucXXcMmfKN4dI3gkV1PZmS6KasqLCT6yZQEkEIJeqAKHe5vK
	WVOjzY1ktorESyQOaNQiinq85TfN1/8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: [PATCH 6.12.y] batman-adv: tvlv: abort OGM send on tvlv append failure
Date: Thu, 28 May 2026 21:46:02 +0200
Message-ID: <20260528194602.258724-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026052822-diocese-jet-ec4c@gregkh>
References: <2026052822-diocese-jet-ec4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255099-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[narfation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,narfation.org:email,narfation.org:mid,narfation.org:dkim]
X-Rspamd-Queue-Id: ED2295F74F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 501368506563e151b322c8c3f228b796e615b90d upstream.

batadv_tvlv_container_ogm_append() could fail in two ways: a memory
allocation failure when resizing the packet buffer, or the tvlv data
exceeding U16_MAX bytes. In both cases the function previously returned the
old (now stale) tvlv_value_len rather than signalling an error, causing the
OGM/OGM2 send path to transmit a packet whose TVLV length field no longer
matched the actual buffer contents. And because it also didn't fill in the
new TVLV data, sending either uninitialized or corrupted data on the wire.

All errors in batadv_tvlv_container_ogm_append() must be forwarded to the
caller. And the caller must abort the send of the OGM2. For B.A.T.M.A.N.
IV, it is currently not allowed to abort the send. The non-TVLV part of the
OGM must be queued up instead.

Cc: stable@kernel.org
Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
[ Context ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 16 +++++++++++++---
 net/batman-adv/bat_v_ogm.c  | 26 ++++++++++++++------------
 net/batman-adv/tvlv.c       | 17 ++++++++++++-----
 net/batman-adv/tvlv.h       |  2 +-
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 748188d3b878..42b687c1a768 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -781,6 +781,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	u32 seqno;
 	u16 tvlv_len = 0;
 	unsigned long send_time;
+	int ret;
 
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
 
@@ -804,9 +805,18 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 * appended as it may alter the tt tvlv container
 		 */
 		batadv_tt_local_commit_changes(bat_priv);
-		tvlv_len = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
-							    ogm_buff_len,
-							    BATADV_OGM_HLEN);
+		ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
+						       ogm_buff_len,
+						       BATADV_OGM_HLEN);
+		if (ret < 0) {
+			/* OGMs must be queued even when the buffer allocation for
+			 * TVLVs failed. just fall back to the non-TVLV version
+			 */
+			ret = 0;
+			*ogm_buff_len = BATADV_OGM_HLEN;
+		}
+
+		tvlv_len = ret;
 	}
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)(*ogm_buff);
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 8f89ffe6020c..559d38781f2d 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -264,9 +264,9 @@ static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
 	struct sk_buff *skb, *skb_tmp;
-	unsigned char *ogm_buff;
-	int ogm_buff_len;
-	u16 tvlv_len = 0;
+	unsigned char **ogm_buff;
+	int *ogm_buff_len;
+	u16 tvlv_len;
 	int ret;
 
 	lockdep_assert_held(&bat_priv->bat_v.ogm_buff_mutex);
@@ -274,25 +274,27 @@ static void batadv_v_ogm_send_softif(struct batadv_priv *bat_priv)
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
-	ogm_buff = bat_priv->bat_v.ogm_buff;
-	ogm_buff_len = bat_priv->bat_v.ogm_buff_len;
+	ogm_buff = &bat_priv->bat_v.ogm_buff;
+	ogm_buff_len = &bat_priv->bat_v.ogm_buff_len;
+
 	/* tt changes have to be committed before the tvlv data is
 	 * appended as it may alter the tt tvlv container
 	 */
 	batadv_tt_local_commit_changes(bat_priv);
-	tvlv_len = batadv_tvlv_container_ogm_append(bat_priv, &ogm_buff,
-						    &ogm_buff_len,
-						    BATADV_OGM2_HLEN);
+	ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
+					       ogm_buff_len,
+					       BATADV_OGM2_HLEN);
+	if (ret < 0)
+		goto reschedule;
 
-	bat_priv->bat_v.ogm_buff = ogm_buff;
-	bat_priv->bat_v.ogm_buff_len = ogm_buff_len;
+	tvlv_len = ret;
 
-	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + ogm_buff_len);
+	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + *ogm_buff_len);
 	if (!skb)
 		goto reschedule;
 
 	skb_reserve(skb, ETH_HLEN);
-	skb_put_data(skb, ogm_buff, ogm_buff_len);
+	skb_put_data(skb, *ogm_buff, *ogm_buff_len);
 
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 	ogm_packet->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 2a583215d439..76c6e0599694 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -8,6 +8,7 @@
 
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
@@ -306,9 +307,10 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
  * The ogm packet might be enlarged or shrunk depending on the current size
  * and the size of the to-be-appended tvlv containers.
  *
- * Return: size of all appended tvlv containers in bytes.
+ * Return: size of all appended tvlv containers in bytes (max U16_MAX), negative
+ *  if operation failed
  */
-u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
+int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 				     unsigned char **packet_buff,
 				     int *packet_buff_len, int packet_min_len)
 {
@@ -316,6 +318,7 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	u16 tvlv_value_len;
 	void *tvlv_value;
+	int tvlv_len_ret;
 	bool ret;
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
@@ -323,9 +326,12 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 
 	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
 					      packet_min_len, tvlv_value_len);
-
-	if (!ret)
+	if (!ret) {
+		tvlv_len_ret = -ENOMEM;
 		goto end;
+	}
+
+	tvlv_len_ret = tvlv_value_len;
 
 	if (!tvlv_value_len)
 		goto end;
@@ -344,7 +350,8 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 
 end:
 	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
-	return tvlv_value_len;
+
+	return tvlv_len_ret;
 }
 
 /**
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index e5697230d991..f96f6b3f44a0 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -16,7 +16,7 @@
 void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 				    u8 type, u8 version,
 				    void *tvlv_value, u16 tvlv_value_len);
-u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
+int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 				     unsigned char **packet_buff,
 				     int *packet_buff_len, int packet_min_len);
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
-- 
2.47.3


