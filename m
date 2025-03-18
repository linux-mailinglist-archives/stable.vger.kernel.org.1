Return-Path: <stable+bounces-124811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA277A67730
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025783BDF4A
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62020F075;
	Tue, 18 Mar 2025 15:00:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680F20F065;
	Tue, 18 Mar 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310050; cv=none; b=S154w34fx/N5VBXT2U1VsNUP+8+Q+xu5WvbA0+0+2qkT94uGo9/si7wY7Ui3JfW313/dpiReXt1mzhC4Iz7s+HMFqKKi9ZCqLyEwQ3YsG8LfCUwhCJwDw+hDs8Hl3kanQW9Hsq0FS/q/jfVPJgqfGDDrrzvPaSoerdMKu42mMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310050; c=relaxed/simple;
	bh=wyn3VpaSleocOcFN9TKcRvlozK514gBG9UmOzKFHjxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxLQhSDpBuJz6ek5Uh3JgX0+zIG2mKl1PykBfJF9Q0gBdfR+APV3ztXb7GFSZ9zi39IDKYmVKJIWdN1wsI3DebiZZmqBM0VcEOsI4yYLchFZw4dtRHHe41MiGRMz6AOAU06kcLmpifOFMbi/zPZN8ArRy7/cd6hrzbp9E2auIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5973197D81320d84731f3581A.dip0.t-ipconnect.de [IPv6:2003:c5:9731:97d8:1320:d847:31f3:581a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D3090FA132;
	Tue, 18 Mar 2025 16:00:38 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/1] batman-adv: Ignore own maximum aggregation size during RX
Date: Tue, 18 Mar 2025 16:00:35 +0100
Message-Id: <20250318150035.35356-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318150035.35356-1-sw@simonwunderlich.de>
References: <20250318150035.35356-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

An OGMv1 and OGMv2 packet receive processing were not only limited by the
number of bytes in the received packet but also by the nodes maximum
aggregation packet size limit. But this limit is relevant for TX and not
for RX. It must not be enforced by batadv_(i)v_ogm_aggr_packet to avoid
loss of information in case of a different limit for sender and receiver.

This has a minor side effect for B.A.T.M.A.N. IV because the
batadv_iv_ogm_aggr_packet is also used for the preprocessing for the TX.
But since the aggregation code itself will not allow more than
BATADV_MAX_AGGREGATION_BYTES bytes, this check was never triggering (in
this context) prior of removing it.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 3 +--
 net/batman-adv/bat_v_ogm.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 07ae5dd1f150..b12645949ae5 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -325,8 +325,7 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /* send a batman ogm to a given interface */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e503ee0d896b..8f89ffe6020c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -839,8 +839,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /**
-- 
2.39.5


