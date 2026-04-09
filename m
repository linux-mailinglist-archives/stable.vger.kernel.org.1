Return-Path: <stable+bounces-235296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KVTDgYU12kSKwgAu9opvQ
	(envelope-from <stable+bounces-235296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:50:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4893C5B5B
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A2BC302CD29
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022B367F40;
	Thu,  9 Apr 2026 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wl8qgk7H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L31CVT8E"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7523AE62;
	Thu,  9 Apr 2026 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703003; cv=none; b=LEcUUQTXqw/isheZKjxq7nGWUXxmMfIk9AjKEFP20zV2PwRuvRA6eF05ZWtKEYcnIPs7TgIz3tlw229K/pnb50glL/bGa5nlZL3yBdCWtRUs2Vkb+Y8ozU79EBgQbv7kg7DLHmUI/Q9MeKBqzPO3sPGGsB3OggGeEhkKnbDGdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703003; c=relaxed/simple;
	bh=0Pbj/t9PBA+V4Pfq4iqpUh+BvdT7LJ1OhIxqSu0zNZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciU4O9HueC3Upy6sL+y3+Lvs3kre+Y6wqPyNHTTRqZg1sQdmDJ8KMHKbqDUuD8hQfl5OI2AXG+h+WRzUf9ZwEb5tsr5xeqAEswXt7Wbbt5dSz1VnD/u1ej3xDw0qsXT1SUPEckc8/kUWMcnBWjNd7+24yB6XKyMkOwvX/I19KUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wl8qgk7H; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=L31CVT8E; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frktZ4bmqzB14V;
	Thu,  9 Apr 2026 04:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775702998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsidmfB0EwnTNO061hNze2h62VV8OIyujPFbtg3of64=;
	b=wl8qgk7HJK8ClFdJmmlV5Ml3K9YwnztQS9upxm2OxqJjAmztHeNAyR0OJ5MC8dqWKLuohR
	JwERnE9heEMtBxwZBGfVlLhyZOGWUPVFaEc3meXkESZzCKHqJo1G0Aggej81KqPzYuHpuA
	/eprfRiZ3mH/LbLTc62ViQF1OCpdAP/NZv9/eySJz479J+Cal/QocLjfyjSQsdVx5ahH8l
	4KXcGCZ/6Ps4K0AoMDLv+sAs0VartZWoO7sbGkFyqNhUYm15MToqyNIAC85Vfq64Wd7vv8
	Wo48Q4qYBSKgOWaj8/KJJedgZTC44V+Wlh+HfW/t33Dy2NGcVSkrdnlO5B9gpg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=L31CVT8E;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775702997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsidmfB0EwnTNO061hNze2h62VV8OIyujPFbtg3of64=;
	b=L31CVT8EQppmgQQoIEObaUH1PTbNAEPieZR+C6RVCXhEGqFyWPswcnsseuKC+5wgBLEIVK
	3jpLTG3SnCI000X+m6IKMWxUoryCRgfvlHl+9mp4Hyn+DieNLNtHMOCs0uf6CyUyynasNZ
	gf+9Bb5Q+X2/iyrFfuyPAkvHkz5l7jLwzgeoEiROqqKaF56JQsnTXYvGyHlL7BmfvfJS9S
	9XI5U4WQIbX6u1EVDATbz/Jtdhlg6IjLxLNZ3/5KKyuW8psIPi3Ivzp68ffeyKgmvb0mic
	JrUyBPiBC+xrfDiG3xS+cOqdBVgvndsLcGR4/2iK9Qu9hg3383wYEH9J2w6c0g==
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 net 1/2] net: hamradio: bpqether: validate frame length in bpq_rcv()
Date: Thu,  9 Apr 2026 10:49:26 +0800
Message-ID: <20260409024927.24397-2-mashiro.chen@mailbox.org>
In-Reply-To: <20260409024927.24397-1-mashiro.chen@mailbox.org>
References: <20260409024927.24397-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pgimnr9g3bswf9q61zcp5it94phwbyo4
X-MBO-RS-ID: f1c15c24337190e2404
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235296-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yaina.de:email,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA4893C5B5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The BPQ length field is decoded as:

  len = skb->data[0] + skb->data[1] * 256 - 5;

If the sender sets bytes [0..1] to values whose combined value is
less than 5, len becomes negative.  Passing a negative int to
skb_trim() silently converts to a huge unsigned value, causing the
function to be a no-op.  The frame is then passed up to AX.25 with
its original (untrimmed) payload, delivering garbage beyond the
declared frame boundary.

Additionally, a negative len corrupts the 64-bit rx_bytes counter
through implicit sign-extension.

Add a bounds check before pulling the length bytes: reject frames
where len is negative or exceeds the remaining skb data.

Cc: stable@vger.kernel.org
Cc: linux-hams@vger.kernel.org
Acked-by: Joerg Reuter <jreuter@yaina.de>
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/bpqether.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index 045c5177262eaf..214fd1f819a1bb 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -187,6 +187,9 @@ static int bpq_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_ty
 
 	len = skb->data[0] + skb->data[1] * 256 - 5;
 
+	if (len < 0 || len > skb->len - 2)
+		goto drop_unlock;
+
 	skb_pull(skb, 2);	/* Remove the length bytes */
 	skb_trim(skb, len);	/* Set the length of the data */
 
-- 
2.53.0


