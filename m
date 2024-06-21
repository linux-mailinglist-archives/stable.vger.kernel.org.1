Return-Path: <stable+bounces-54828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C763912847
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2952A2811ED
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA273B7AC;
	Fri, 21 Jun 2024 14:45:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F72BAE3;
	Fri, 21 Jun 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981123; cv=none; b=io7op13h5R8cbzAIsqWXPjbl+wJMinpTT5AvjjnlrtVJaxpngaJnlOdYSec25ALMR6SKODWGid0ROV8bJCFovGb85WdnssI+oVq1o8lURVm0ija+Qc2Rs5BQ62/qRfyIo7TdLBjkAuAiIHRhPssiWpCEancqCAextgyVU4wyC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981123; c=relaxed/simple;
	bh=PL1DWzfxRnKA/W1x4Mg5aQiRnC6uKW5MiTt4rRk4UMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1QPYI5UwgUPfkNwhLoiMtOgn3+U0LpKh3WLeRdil5/qr8yHNT5l1mv38I1y/USaaS12P83CGxJ3SiC3huVF6xeecVyJWU3Q1lRKrtJ/dmn8MjKbKZK8MvgWXm35nalC0GMxalayCMpPvPEw5ZKHayll0blkCxuGmDPxAvCamZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5970FCfd871714591023aA0cD.dip0.t-ipconnect.de [IPv6:2003:c5:970f:cfd8:7171:4591:23a:a0cd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B531EFA132;
	Fri, 21 Jun 2024 16:39:22 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/2] batman-adv: Don't accept TT entries for out-of-spec VIDs
Date: Fri, 21 Jun 2024 16:39:14 +0200
Message-Id: <20240621143915.49137-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621143915.49137-1-sw@simonwunderlich.de>
References: <20240621143915.49137-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The internal handling of VLAN IDs in batman-adv is only specified for
following encodings:

* VLAN is used
  - bit 15 is 1
  - bit 11 - bit 0 is the VLAN ID (0-4095)
  - remaining bits are 0
* No VLAN is used
  - bit 15 is 0
  - remaining bits are 0

batman-adv was only preparing new translation table entries (based on its
soft interface information) using this encoding format. But the receive
path was never checking if entries in the roam or TT TVLVs were also
following this encoding.

It was therefore possible to create more than the expected maximum of 4096
+ 1 entries in the originator VLAN list. Simply by setting the "remaining
bits" to "random" values in corresponding TVLV.

Cc: stable@vger.kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ac74f6ead62d..8f6dd2c6ee41 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
+#include <linux/if_vlan.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -131,6 +132,29 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 	return vlan;
 }
 
+/**
+ * batadv_vlan_id_valid() - check if vlan id is in valid batman-adv encoding
+ * @vid: the VLAN identifier
+ *
+ * Return: true when either no vlan is set or if VLAN is in correct range,
+ *  false otherwise
+ */
+static bool batadv_vlan_id_valid(unsigned short vid)
+{
+	unsigned short non_vlan = vid & ~(BATADV_VLAN_HAS_TAG | VLAN_VID_MASK);
+
+	if (vid == 0)
+		return true;
+
+	if (!(vid & BATADV_VLAN_HAS_TAG))
+		return false;
+
+	if (non_vlan)
+		return false;
+
+	return true;
+}
+
 /**
  * batadv_orig_node_vlan_new() - search and possibly create an orig_node_vlan
  *  object
@@ -149,6 +173,9 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 {
 	struct batadv_orig_node_vlan *vlan;
 
+	if (!batadv_vlan_id_valid(vid))
+		return NULL;
+
 	spin_lock_bh(&orig_node->vlan_list_lock);
 
 	/* first look if an object for this vid already exists */
-- 
2.39.2


