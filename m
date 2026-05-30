Return-Path: <stable+bounces-259182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLZrBN4xG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8951612AA4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 036B23098057
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6212367DF;
	Sat, 30 May 2026 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKr7yyQY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C808231A21;
	Sat, 30 May 2026 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166881; cv=none; b=DVn7c//wj5dZz4XdtbypjREXrqoZWO407eI3PPQDqD8t2zSDuraQ5tpdd/yssKGJvqi2tQLSG+s3E3lKvxeBw0YQ59qj9dy9OJuTrfwGVAfb/DFByhDCFOv91fhTzM0Bqs4bVmnxXjBO7N1KuCexARS7Dl80LCkPhbXWHcE+YoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166881; c=relaxed/simple;
	bh=mAe+XkT4hAvdSNCV9VnwhgFoYNJdd/+vHzjxMfvG3F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHZ+qp06wI0VwI7zO/q8FFl/iwccNKGlDE41/SWkRxrJfCeevkpdqp18aEn0aIZgGwvVAY3bxzpymPJQWhHBwzpaSgtTrG8aBcGxAaGOF0BjIGrJfRypkR45tgMsDM72D/a5xN/+HXYvRlqucg2EdjCkTzUktEt2ohDK3xBs0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKr7yyQY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA251F00893;
	Sat, 30 May 2026 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166880;
	bh=KCv0P8m3TWxE7IMt2/2B/xCWK4Naw1QCXgkkCpBDJKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKr7yyQYQl70fZypxxBBV2G9w2yB9aaDEtBp1ybHF9OJ/yAIb8PXEAwGGdr3IF178
	 D5SkLE2wqKDBZ1CO5aNsGs0Xp+7ePnhkEWCwtnUNPaTG8WhG7FpPJIWdmURLAc7uxu
	 rgK3d2TLHz/P+P3W5C4o6RRZ7q3Pde5efQUw8SVs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qingqing Yang <qingqing.yang@broadcom.com>,
	Boris Sukholitko <boris.sukholitko@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 499/589] flow_dissector: Do not count vlan tags inside tunnel payload
Date: Sat, 30 May 2026 18:06:20 +0200
Message-ID: <20260530160237.728806526@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259182-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A8951612AA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qingqing Yang <qingqing.yang@broadcom.com>

[ Upstream commit 9f87eb4246994e32a4e4ea88476b20ab3b412840 ]

We've met the problem that when there is a vlan tag inside
GRE encapsulation, the match of num_of_vlans fails.
It is caused by the vlan tag inside GRE payload has been
counted into num_of_vlans, which is not expected.

One example packet is like this:
Ethernet II, Src: Broadcom_68:56:07 (00:10:18:68:56:07)
                   Dst: Broadcom_68:56:08 (00:10:18:68:56:08)
802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 100
Internet Protocol Version 4, Src: 192.168.1.4, Dst: 192.168.1.200
Generic Routing Encapsulation (Transparent Ethernet bridging)
Ethernet II, Src: Broadcom_68:58:07 (00:10:18:68:58:07)
                   Dst: Broadcom_68:58:08 (00:10:18:68:58:08)
802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 200
...
It should match the (num_of_vlans 1) rule, but it matches
the (num_of_vlans 2) rule.

The vlan tags inside the GRE or other tunnel encapsulated payload
should not be taken into num_of_vlans.
The fix is to stop counting the vlan number when the encapsulation
bit is set.

Fixes: 34951fcf26c5 ("flow_dissector: Add number of vlan tags dissector")
Signed-off-by: Qingqing Yang <qingqing.yang@broadcom.com>
Reviewed-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
Link: https://lore.kernel.org/r/20220919074808.136640-1-qingqing.yang@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/flow_dissector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 86eb489ee76e0..10e9d6e47e0a3 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1170,8 +1170,8 @@ bool __skb_flow_dissect(const struct net *net,
 			nhoff += sizeof(*vlan);
 		}
 
-		if (dissector_uses_key(flow_dissector,
-				       FLOW_DISSECTOR_KEY_NUM_OF_VLANS)) {
+		if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_NUM_OF_VLANS) &&
+		    !(key_control->flags & FLOW_DIS_ENCAPSULATION)) {
 			struct flow_dissector_key_num_of_vlans *key_nvs;
 
 			key_nvs = skb_flow_dissector_target(flow_dissector,
-- 
2.53.0




