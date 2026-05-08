Return-Path: <stable+bounces-244788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id urarH2sG/mkxmQAAu9opvQ
	(envelope-from <stable+bounces-244788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:51:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 880344F901F
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5CE83041A45
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FA30FC1A;
	Fri,  8 May 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="p4+LF1Sa"
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B12FF144;
	Fri,  8 May 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255430; cv=none; b=dPZTUyD71WtlTfjRj8vatnddVbGf6cD2eMys2RGvYzCzXQsqmwc1VX82/GhfpP1vFit7/XWnV9Jw2FFZgcA7JiHvNYPh5KFGEx+ZGGiUJryif8cZ4FWVX/MG8gkVOcTMXuvU0aaM1fqlsNQD4MMAzLHEG93LWh5Byw53kh5haw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255430; c=relaxed/simple;
	bh=Kk33coW1BTPPsoCzN/JAaLnY1ljWrmKl1FiAXHveNYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0HLi7PUeAGSxtBgA0YlIY+4AyoSzaJDK3JbGVR4udQNQoFanbbp6qwBNtEMrOfRsWfiLLHhJqGLZderwUWnUlsMdF72PHvPQumk/ukHDT+/6xrkFZT+xyy7Vv3UMFiMHAG1WpzqWRy1xY5kpAO4CYxTMAeWgMYXJTB6Z2KuvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=p4+LF1Sa; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnpguk5kWeeiPMWnYmoJrWVYQWeHIgM9Bw9lqx5btd8=;
	b=p4+LF1SaGzSqq95SIiJjAFZpQZEZ5JI/fpKPr+uoXjKGXWhJl3/zGW/HbZu+rleL4SSx2/
	BX7HtEvWdhhUfsmjZ4a03+6BBNQD2/B+5GRD3sVvSBA2lu/H2MUU7tMlbmsQIcPscRyztx
	bdr/EPFCy4SLxzR5d0VdDyBEZrwJAOGqBDadWIORfddHkOQR8Qyc6KgYXYQVVz4N78Ak80
	A0dJAaloRPrgbk2+9zD5Nf8shToYQRpl1gXpqXZbMjKX5TS7SfePcvhl9SpXV/7FnQ/vJd
	L8aFUEtzK2HA0eZVaIUM39lW6vNpcWRIC9xOCjEZDrhL3Hhqtc1E2Nwrp35dNg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Lyes Bourennani <lbourennani@fuzzinglabs.com>,
	stable@vger.kernel.org,
	Alexis Pinson <apinson@fuzzinglabs.com>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 1/8] batman-adv: fix integer overflow on buff_pos
Date: Fri,  8 May 2026 17:43:07 +0200
Message-ID: <20260508154314.12817-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 880344F901F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244788-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Lyes Bourennani <lbourennani@fuzzinglabs.com>

Fixing an integer overflow present in batadv_iv_ogm_send_to_if. The size
check is done using the int type in batadv_iv_ogm_aggr_packet whereas the
buff_pos variable uses the s16 type. This could lead to an out-of-bound
read.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Lyes Bourennani <lbourennani@fuzzinglabs.com>
Signed-off-by: Alexis Pinson <apinson@fuzzinglabs.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index f28e9cbf8ad5f..618d1889c04e7 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -335,7 +335,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	const char *fwd_str;
 	u8 packet_num;
-	s16 buff_pos;
+	int buff_pos;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct sk_buff *skb;
 	u8 *packet_pos;
-- 
2.47.3


