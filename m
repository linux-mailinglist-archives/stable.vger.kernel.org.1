Return-Path: <stable+bounces-162703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC98BB05F74
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C81C412B1
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8F2E7BCC;
	Tue, 15 Jul 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2p6j59cb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243D2561AE;
	Tue, 15 Jul 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587253; cv=none; b=YVgN+NxL4YXa8lhp5M3T2tGL8MEQe24vYdsRJjq04BcUXr6mIrWo1pd1gkWZfdVJw+SHwzcHCfNgjCLnYyWayQEWyF71Llv7BeZ3sO4Ed4g6NpLt+MiuWo6v4Syx+juVMs+jKRw2oc+LbDaazKwAfuTGf/Ghsh1bwgV7kMrc1XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587253; c=relaxed/simple;
	bh=M5UhIEY3Lqd3qV7eSxDjupJ49zVBh3x9nJvrSFHEM2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbKBYD5/nF2kdIIIrUpVkdQw8B7Qb5cyBnCyW9IthDWD1LRUeddBk9pajGL2qKz4OiHFDEEdd7Np0woAGZktxecsb7Ggwl9hOJ7Qt+mrrVRFXSoaGrqCJkCsFX82l1gn1Od17fH7REp2LOu1A5QprmjPacFk/cjY1Ala29GE/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2p6j59cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F35C4CEE3;
	Tue, 15 Jul 2025 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587253;
	bh=M5UhIEY3Lqd3qV7eSxDjupJ49zVBh3x9nJvrSFHEM2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2p6j59cbv8sQkw/T3pBmyiMyKeRaKLH6X8frQIM82IVeWQAb6HrntTR7ah5fAKmAO
	 qordF2pysw+wFuX1o7LcQE6ywWAPAL/GE6EyAooPlNzwaES36BHIOvEFa//N4lgVjY
	 znk/x6d76F3Yene/m+/7Kh5mEM4V1vene56aOGrg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 31/88] wifi: prevent A-MSDU attacks in mesh networks
Date: Tue, 15 Jul 2025 15:14:07 +0200
Message-ID: <20250715130755.771080647@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130754.497128560@linuxfoundation.org>
References: <20250715130754.497128560@linuxfoundation.org>
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

From: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>

commit 737bb912ebbe4571195c56eba557c4d7315b26fb upstream.

This patch is a mitigation to prevent the A-MSDU spoofing vulnerability
for mesh networks. The initial update to the IEEE 802.11 standard, in
response to the FragAttacks, missed this case (CVE-2025-27558). It can
be considered a variant of CVE-2020-24588 but for mesh networks.

This patch tries to detect if a standard MSDU was turned into an A-MSDU
by an adversary. This is done by parsing a received A-MSDU as a standard
MSDU, calculating the length of the Mesh Control header, and seeing if
the 6 bytes after this header equal the start of an rfc1042 header. If
equal, this is a strong indication of an ongoing attack attempt.

This defense was tested with mac80211_hwsim against a mesh network that
uses an empty Mesh Address Extension field, i.e., when four addresses
are used, and when using a 12-byte Mesh Address Extension field, i.e.,
when six addresses are used. Functionality of normal MSDUs and A-MSDUs
was also tested, and confirmed working, when using both an empty and
12-byte Mesh Address Extension field.

It was also tested with mac80211_hwsim that A-MSDU attacks in non-mesh
networks keep being detected and prevented.

Note that the vulnerability being patched, and the defense being
implemented, was also discussed in the following paper and in the
following IEEE 802.11 presentation:

https://papers.mathyvanhoef.com/wisec2025.pdf
https://mentor.ieee.org/802.11/dcn/25/11-25-0949-00-000m-a-msdu-mesh-spoof-protection.docx

Cc: stable@vger.kernel.org
Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Link: https://patch.msgid.link/20250616004635.224344-1-Mathy.Vanhoef@kuleuven.be
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/util.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -813,6 +813,52 @@ bool ieee80211_is_valid_amsdu(struct sk_
 }
 EXPORT_SYMBOL(ieee80211_is_valid_amsdu);
 
+
+/*
+ * Detects if an MSDU frame was maliciously converted into an A-MSDU
+ * frame by an adversary. This is done by parsing the received frame
+ * as if it were a regular MSDU, even though the A-MSDU flag is set.
+ *
+ * For non-mesh interfaces, detection involves checking whether the
+ * payload, when interpreted as an MSDU, begins with a valid RFC1042
+ * header. This is done by comparing the A-MSDU subheader's destination
+ * address to the start of the RFC1042 header.
+ *
+ * For mesh interfaces, the MSDU includes a 6-byte Mesh Control field
+ * and an optional variable-length Mesh Address Extension field before
+ * the RFC1042 header. The position of the RFC1042 header must therefore
+ * be calculated based on the mesh header length.
+ *
+ * Since this function intentionally parses an A-MSDU frame as an MSDU,
+ * it only assumes that the A-MSDU subframe header is present, and
+ * beyond this it performs its own bounds checks under the assumption
+ * that the frame is instead parsed as a non-aggregated MSDU.
+ */
+static bool
+is_amsdu_aggregation_attack(struct ethhdr *eth, struct sk_buff *skb,
+			    enum nl80211_iftype iftype)
+{
+	int offset;
+
+	/* Non-mesh case can be directly compared */
+	if (iftype != NL80211_IFTYPE_MESH_POINT)
+		return ether_addr_equal(eth->h_dest, rfc1042_header);
+
+	offset = __ieee80211_get_mesh_hdrlen(eth->h_dest[0]);
+	if (offset == 6) {
+		/* Mesh case with empty address extension field */
+		return ether_addr_equal(eth->h_source, rfc1042_header);
+	} else if (offset + ETH_ALEN <= skb->len) {
+		/* Mesh case with non-empty address extension field */
+		u8 temp[ETH_ALEN];
+
+		skb_copy_bits(skb, offset, temp, ETH_ALEN);
+		return ether_addr_equal(temp, rfc1042_header);
+	}
+
+	return false;
+}
+
 void ieee80211_amsdu_to_8023s(struct sk_buff *skb, struct sk_buff_head *list,
 			      const u8 *addr, enum nl80211_iftype iftype,
 			      const unsigned int extra_headroom,
@@ -857,8 +903,10 @@ void ieee80211_amsdu_to_8023s(struct sk_
 		/* the last MSDU has no padding */
 		if (subframe_len > remaining)
 			goto purge;
-		/* mitigate A-MSDU aggregation injection attacks */
-		if (ether_addr_equal(hdr.eth.h_dest, rfc1042_header))
+		/* mitigate A-MSDU aggregation injection attacks, to be
+		 * checked when processing first subframe (offset == 0).
+		 */
+		if (offset == 0 && is_amsdu_aggregation_attack(&hdr.eth, skb, iftype))
 			goto purge;
 
 		offset += sizeof(struct ethhdr);



