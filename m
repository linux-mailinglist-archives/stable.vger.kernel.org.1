Return-Path: <stable+bounces-248876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALZ2CmFRB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:01:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3007554540
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D264A3154E6B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3643E7BDE;
	Fri, 15 May 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bhTSFiPN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE43E7BAB;
	Fri, 15 May 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862857; cv=none; b=qebCcFLTE/p7fdrhceadWxNRPvsxO88hzjyQxBZ2rEZE5iv+idyIuvtHrB41gq5JYVXwdTD8yJf6r2L+v/vnvIlmmYYtuVv/J5MMHO0auKEZ9s/JzZoGdhtCKCKSSaXJ9Rovf/dhQVmECdrFR/MdyCP5b4CVdY99xFJdt7q4qdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862857; c=relaxed/simple;
	bh=02/D+EsE/TAmRZyLC0gJcOD6K3TqcmE9tf/hWf7aTME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwYM8UXW2Fo46sHEutCqcLyYF3TDk2kSSKQducNxYWhq6g98cgvRl1qTaf2dczZ5qyvam/1bPdIaR2RmYeiL/o/eBl2XCjxOMZwgIhHcx3PTtTNFGKNwG/TvHn4g6z+fyBFVpSDjFbCnuXVTU/Iwu+OMRiEm7Ao/ldMVa4Q5qkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bhTSFiPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D51C2BCB0;
	Fri, 15 May 2026 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862856;
	bh=02/D+EsE/TAmRZyLC0gJcOD6K3TqcmE9tf/hWf7aTME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhTSFiPN9i2wvaFIvGxdcdyC8DC7J01YZFhaRXAiTJkqo+PJRmn7VblpCcsH9yNyW
	 jt3LXHb5wEiWOi2yMfkM9v84QqIVKR2z4tInVz0f/95ceZQ+sYFMvDNQzP+ktFrgiF
	 5rj3Z0i/ySvZXwG3CrsJSYjxPRFIh/biQH1pKZK8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyes Bourennani <lbourennani@fuzzinglabs.com>,
	Alexis Pinson <apinson@fuzzinglabs.com>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 173/201] batman-adv: fix integer overflow on buff_pos
Date: Fri, 15 May 2026 17:49:51 +0200
Message-ID: <20260515154702.323281403@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3007554540
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248876-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,narfation.org:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyes Bourennani <lbourennani@fuzzinglabs.com>

commit 0799e5943611006b346b8813c7daf7dd5aa26bfd upstream.

Fixing an integer overflow present in batadv_iv_ogm_send_to_if. The size
check is done using the int type in batadv_iv_ogm_aggr_packet whereas the
buff_pos variable uses the s16 type. This could lead to an out-of-bound
read.

Cc: stable@vger.kernel.org
Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Signed-off-by: Lyes Bourennani <lbourennani@fuzzinglabs.com>
Signed-off-by: Alexis Pinson <apinson@fuzzinglabs.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_iv_ogm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -335,7 +335,7 @@ static void batadv_iv_ogm_send_to_if(str
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	const char *fwd_str;
 	u8 packet_num;
-	s16 buff_pos;
+	int buff_pos;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct sk_buff *skb;
 	u8 *packet_pos;



