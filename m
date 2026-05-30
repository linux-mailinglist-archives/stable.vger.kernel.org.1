Return-Path: <stable+bounces-257359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF2DN0IbG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C060F40F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE5C30AD683
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365C34BA42;
	Sat, 30 May 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lxp4v23H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917D2690D5;
	Sat, 30 May 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160719; cv=none; b=PObtTptAPdEcW0yC0DeoTr++J9O/gga/SHq7SNLjyxr3wrYBoYHy5sOp6LnHnedLl3Abw5Dw4+RSTR0P87Oymu7eW67u4LmQdwBZrefMVVBuczb3Ha+4XRRBnwyrvAVeWSYuAAo4UghkcBwPsH5px3+uyd6IwUtahzcrE4PKjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160719; c=relaxed/simple;
	bh=XDpoq+or2Mela53TV4nXU7kxxPwl1WOPOj6Nzt0wl5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNWYdqhe1aQvtX7USpCl7tdHUMnTUkrvipX6/EWDPMy5OFBFdfQJLAK9AGpkowMgrYOLIjirZF9XbmybM5FiVEfNm79SZZvzj+dE5A4WfHCS1PcRt/cbv3JAQZloOk7TVr40FkyMk1X2LVexAhI6oAXlqbjfFXSZ0nbaC1eE230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lxp4v23H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFCD1F00893;
	Sat, 30 May 2026 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160718;
	bh=nnccGVOyZg+0Bu04iyQ5hRyQidfHVyrRPsYjcn5RfO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lxp4v23HscsLzwdYAMKNPtdxHXmgSDPbNj+Iy4/4tuHyRs4E1pjRuOXFjIxErsy3V
	 sswqvLIjxicuXi1fM8QUEKD9JGt5YlktOiHpbZY5PC9o6icNdBpoKRLVPUnXEjOW9E
	 0YjD1unzTdDHuLJ0x+CIKrUT9x2sZBUtPem5oVsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyes Bourennani <lbourennani@fuzzinglabs.com>,
	Alexis Pinson <apinson@fuzzinglabs.com>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 416/969] batman-adv: fix integer overflow on buff_pos
Date: Sat, 30 May 2026 17:59:00 +0200
Message-ID: <20260530160311.760905066@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257359-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5F1C060F40F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 	const char *fwd_str;
 	u8 packet_num;
-	s16 buff_pos;
+	int buff_pos;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct sk_buff *skb;
 	u8 *packet_pos;



