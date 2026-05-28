Return-Path: <stable+bounces-256418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AgDOImuGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:07:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A805FA3E2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B5F43098EF3
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8467A352007;
	Thu, 28 May 2026 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="pkGObwER"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22549352019
	for <stable@vger.kernel.org>; Thu, 28 May 2026 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002272; cv=none; b=jFY4EwcZoeZb6uiXMIlojxOBRL/5Swuc+e2H4gYn+FL5dkKb23Py61nrWugutrIhRzdLvCvMrj/GNss6Nxp9Vis7PuyRroNbRvy2pCt+fP/rddfJR0nCbj3FPI4PfBrvy/EuAJ3nLnzN6yzrR3AMxLG6yXmxRMwRdugkxossaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002272; c=relaxed/simple;
	bh=u+kIf9B96UhX47upqBGcF5aWzXvMQdDdEC7bU6PPsVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQYqH8D/guE78cNUdpRoi7P4hYHHjkU//outlY5qj1lKLY5XE13pi2fT2LpIz8omQqPDt0Fd+F3x3FobDkb1zTmZr6tuAwmfdK89Jnu/zDTJ+mgSySb2/ZeVa8KaWMFiaOVPIOpyiTKEXmggq8iD7Lg2EHnZ5uVU43dvf62nsnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=pkGObwER; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 365AC1FE2A;
	Thu, 28 May 2026 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780002269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZujK9VW4qiw7Ivj9l+nwy9I07/plpKA8OXkVGUJRrM=;
	b=pkGObwERfckbyxHdnnxOVUL04ouFWKIajSrd21SeXjREaJ1q24TOZ4rHQMCAiFOK/AyXQI
	HiiFsRSGymmZDtXsBTQcMGzIo8eK4Aqy4FhtJlM8qjAlQIDylezUNHJ6aVXWUEpJybNC4r
	hihHEBUmPj4mDwneigSHRPOzABCLe1I=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: [PATCH 5.15.y] batman-adv: tt: fix TOCTOU race for reported vlans
Date: Thu, 28 May 2026 23:04:23 +0200
Message-ID: <20260528210423.755282-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026052810-narrow-feast-bb41@gregkh>
References: <2026052810-narrow-feast-bb41@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256418-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,narfation.org:mid,narfation.org:dkim]
X-Rspamd-Queue-Id: B3A805FA3E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 94d27005016be15ffc638b2ecbc4d58805ad7b48 upstream.

The local TT based TVLV is generated by first checking the number of VLANs
which have at least one TT entry. A new buffer with the correct size for
the VLANs is then allocated. Only then, the list of VLANs s used to fill
the VLAN entries in the buffer. During this time, the meshif_vlan_list_lock
is held. But the actual number of TT entries of each VLAN can still
increase during this time - just not the number of VLANs in the list.

But the prefilter used in the buffer size calculation might still cause an
increase of the number of VLANs which need to be stored. Simply because a
VLAN might now suddenly have at least one entry when it had none in the
pre-alloc check - and then needs to occupy space which was not allocated.

It is better to overestimate the buffer size at the beginning and then fill
the buffer only with the VLANs which are not empty.

Cc: stable@kernel.org
Fixes: 16116dac2339 ("batman-adv: prevent TT request storms by not sending inconsistent TT TLVLs")
[ Context, drop flex array dependency ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 76cf40d85990..11c39a9ab90e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -934,11 +934,8 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		if (vlan_entries < 1)
-			continue;
-
-		num_vlan++;
 		total_entries += vlan_entries;
+		num_vlan++;
 	}
 
 	change_offset = sizeof(**tt_data);
@@ -962,6 +959,7 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	(*tt_data)->num_vlan = htons(num_vlan);
 
 	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(*tt_data + 1);
+	num_vlan = 0;
 	hlist_for_each_entry(vlan, &bat_priv->softif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
 		if (vlan_entries < 1)
@@ -972,8 +970,16 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 		tt_vlan->reserved = 0;
 
 		tt_vlan++;
+		num_vlan++;
 	}
 
+	/* recalculate in case number of VLANs reduced */
+	change_offset = sizeof(**tt_data);
+	change_offset += num_vlan * sizeof(*tt_vlan);
+	tvlv_len = *tt_len + change_offset;
+
+	(*tt_data)->num_vlan = htons(num_vlan);
+
 	tt_change_ptr = (u8 *)*tt_data + change_offset;
 	*tt_change = (struct batadv_tvlv_tt_change *)tt_change_ptr;
 
-- 
2.47.3


