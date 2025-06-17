Return-Path: <stable+bounces-153707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C727ADD643
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6496D169893
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1112F94B9;
	Tue, 17 Jun 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KiHGgTwb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB92F9499;
	Tue, 17 Jun 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176830; cv=none; b=LAiQB0UrFwZOUUuVpKM+LpIwEzxsPi4Ksmcb6vVf3+H+s2jCGyDtcVPwtegA9LuW0aQqit+Kw8dLAX1HwYMMxaoTiJHZWQboeRjpcYtHwpA5JkUBHpjceR2iqktYYTjKx4e235BxNrRBL58Mx7YaxqshPoNp3rp57N2KhbTUAI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176830; c=relaxed/simple;
	bh=UGbFau2zbhnkYls57bWQwLrQ/1wPO5yKxHyRhEfcEJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND+CKlHCSANDTJ6unsg36j5cO9/rWypruW9uq39gJSPMwrnqH/7lrmemmIHIn4oYXfWx0hnWqINpLoyUHZyPeRSFp2U2HQAom/LmS7gSyplHyFway7SOqz3urTkDViCPZPYJ5f5bjgGZ53nKpGGxmEV/OOylHcNEAoIe0RxhHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KiHGgTwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A3C4CEE3;
	Tue, 17 Jun 2025 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176830;
	bh=UGbFau2zbhnkYls57bWQwLrQ/1wPO5yKxHyRhEfcEJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiHGgTwbp8PRAIGpEmlB/y3iD11JtImWzqMvWeyI3sOjD4+KusQ+3vtfe6FHzW875
	 gC9hIDLY1ZK4pJFvnOlrR2Gm9Nyl0kbFlaHpDi7/VuoPe5y9t8UvWJmhA50MpdnYZK
	 hO1iyoMmDx/2tRBtG0k2piZi3XB1NMzswyxOQZhY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreu Montiel <Andreu.Montiel@technica-engineering.de>,
	Carlos Fernandez <carlos.fernandez@technica-engineering.de>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 317/356] macsec: MACsec SCI assignment for ES = 0
Date: Tue, 17 Jun 2025 17:27:12 +0200
Message-ID: <20250617152350.920755805@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos Fernandez <carlos.fernandez@technica-engineering.de>

[ Upstream commit d9816ec74e6d6aa29219d010bba3f780ba1d9d75 ]

According to 802.1AE standard, when ES and SC flags in TCI are zero,
used SCI should be the current active SC_RX. Current code uses the
header MAC address. Without this patch, when ES flag is 0 (using a
bridge or switch), header MAC will not fit the SCI and MACSec frames
will be discarted.

In order to test this issue, MACsec link should be stablished between
two interfaces, setting SC and ES flags to zero and a port identifier
different than one. For example, using ip macsec tools:

ip link add link $ETH0 macsec0 type macsec port 11 send_sci off
end_station off
ip macsec add macsec0 tx sa 0 pn 2 on key 01 $ETH1_KEY
ip macsec add macsec0 rx port 11 address $ETH1_MAC
ip macsec add macsec0 rx port 11 address $ETH1_MAC sa 0 pn 2 on key 02
ip link set dev macsec0 up

ip link add link $ETH1 macsec1 type macsec port 11 send_sci off
end_station off
ip macsec add macsec1 tx sa 0 pn 2 on key 01 $ETH0_KEY
ip macsec add macsec1 rx port 11 address $ETH0_MAC
ip macsec add macsec1 rx port 11 address $ETH0_MAC sa 0 pn 2 on key 02
ip link set dev macsec1 up

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Co-developed-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Andreu Montiel <Andreu.Montiel@technica-engineering.de>
Signed-off-by: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7c96493a367bf..767053d6c6b6f 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -243,15 +243,39 @@ static sci_t make_sci(const u8 *addr, __be16 port)
 	return sci;
 }
 
-static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present)
+static sci_t macsec_active_sci(struct macsec_secy *secy)
 {
-	sci_t sci;
+	struct macsec_rx_sc *rx_sc = rcu_dereference_bh(secy->rx_sc);
+
+	/* Case single RX SC */
+	if (rx_sc && !rcu_dereference_bh(rx_sc->next))
+		return (rx_sc->active) ? rx_sc->sci : 0;
+	/* Case no RX SC or multiple */
+	else
+		return 0;
+}
+
+static sci_t macsec_frame_sci(struct macsec_eth_header *hdr, bool sci_present,
+			      struct macsec_rxh_data *rxd)
+{
+	struct macsec_dev *macsec;
+	sci_t sci = 0;
 
-	if (sci_present)
+	/* SC = 1 */
+	if (sci_present) {
 		memcpy(&sci, hdr->secure_channel_id,
 		       sizeof(hdr->secure_channel_id));
-	else
+	/* SC = 0; ES = 0 */
+	} else if ((!(hdr->tci_an & (MACSEC_TCI_ES | MACSEC_TCI_SC))) &&
+		   (list_is_singular(&rxd->secys))) {
+		/* Only one SECY should exist on this scenario */
+		macsec = list_first_or_null_rcu(&rxd->secys, struct macsec_dev,
+						secys);
+		if (macsec)
+			return macsec_active_sci(&macsec->secy);
+	} else {
 		sci = make_sci(hdr->eth.h_source, MACSEC_PORT_ES);
+	}
 
 	return sci;
 }
@@ -1105,7 +1129,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
 	unsigned int len;
-	sci_t sci;
+	sci_t sci = 0;
 	u32 hdr_pn;
 	bool cbit;
 	struct pcpu_rx_sc_stats *rxsc_stats;
@@ -1152,11 +1176,14 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 
 	macsec_skb_cb(skb)->has_sci = !!(hdr->tci_an & MACSEC_TCI_SC);
 	macsec_skb_cb(skb)->assoc_num = hdr->tci_an & MACSEC_AN_MASK;
-	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci);
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 
+	sci = macsec_frame_sci(hdr, macsec_skb_cb(skb)->has_sci, rxd);
+	if (!sci)
+		goto drop_nosc;
+
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct macsec_rx_sc *sc = find_rx_sc(&macsec->secy, sci);
 
@@ -1279,6 +1306,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	macsec_rxsa_put(rx_sa);
 drop_nosa:
 	macsec_rxsc_put(rx_sc);
+drop_nosc:
 	rcu_read_unlock();
 drop_direct:
 	kfree_skb(skb);
-- 
2.39.5




