Return-Path: <stable+bounces-257932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCYyIiQiG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:45:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DE6104DA
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61DCD303B4D4
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673F3B389D;
	Sat, 30 May 2026 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q4y8cU8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C23B0ADF;
	Sat, 30 May 2026 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162654; cv=none; b=sYXccKZy9eN6DCiLKRlcEYdX9AL/Z/8II6RwixLt7fEBSUZ+kBTpc/YS5EdwCIsgQOCbuz0Q+5d4fCPZVuGcvKEFlukPibAUEwWmElvMRN6IENoZPN+UOw74Y23A81U6VGjQaH51IvNUe7Ayr6jVIOPNI+lXVIOpjGVEJ/MAMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162654; c=relaxed/simple;
	bh=8omaB/Su2v/uHRbWvHvwf83YAulBOaYJtv7UkNZy57g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELR9v9rMwB+NfZJne4gcfIogCOBOfuzJwD0Kb0wrAqnfqpYtEVsYIYH3je8wbkpvpHxn1fRiHKzeY8Yw5g/upK+yz0HpdOkG5PAhn47XfybPapLLPChkNUlm1V4K+8kh/kk/1qZSJTTntWvL5g5iHvnSdYEYJlfA3J1ogSyE+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q4y8cU8I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9241F00893;
	Sat, 30 May 2026 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162653;
	bh=oSAGo/K11zJdGEDVd2twkdHo/YDBP2MSPLhSOPadIWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q4y8cU8IO34vBk45O7Px/q0HVrdCmsKRi06n8apq/xMDlfKZjU27vb1eBkYFN7mZG
	 /0vK1BQttHpTGJ+Waufzdhjok5J8yjoBWc6p6XjaF79mesKkY6SQpmqH5a5eKc+yNw
	 L7bDgKamsz4idDZHTeWcZmVClvNEyR3+VMs7ye2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Ruide Cao <caoruide123@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/776] net: sched: act_csum: validate nested VLAN headers
Date: Sat, 30 May 2026 17:55:39 +0200
Message-ID: <20260530160240.915014170@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257932-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,lzu.edu.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D28DE6104DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruide Cao <caoruide123@gmail.com>

[ Upstream commit c842743d073bdd683606cb414eb0ca84465dd834 ]

tcf_csum_act() walks nested VLAN headers directly from skb->data when an
skb still carries in-payload VLAN tags. The current code reads
vlan->h_vlan_encapsulated_proto and then pulls VLAN_HLEN bytes without
first ensuring that the full VLAN header is present in the linear area.

If only part of an inner VLAN header is linearized, accessing
h_vlan_encapsulated_proto reads past the linear area, and the following
skb_pull(VLAN_HLEN) may violate skb invariants.

Fix this by requiring pskb_may_pull(skb, VLAN_HLEN) before accessing and
pulling each nested VLAN header. If the header still is not fully
available, drop the packet through the existing error path.

Fixes: 2ecba2d1e45b ("net: sched: act_csum: Fix csum calc for tagged packets")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/22df2fcb49f410203eafa5d97963dd36089f4ecf.1774892775.git.caoruide123@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_csum.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 2f2fb0f7cc714..277f6a93cc66e 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -602,8 +602,12 @@ static int tcf_csum_act(struct sk_buff *skb, const struct tc_action *a,
 			protocol = skb->protocol;
 			orig_vlan_tag_present = true;
 		} else {
-			struct vlan_hdr *vlan = (struct vlan_hdr *)skb->data;
+			struct vlan_hdr *vlan;
 
+			if (!pskb_may_pull(skb, VLAN_HLEN))
+				goto drop;
+
+			vlan = (struct vlan_hdr *)skb->data;
 			protocol = vlan->h_vlan_encapsulated_proto;
 			skb_pull(skb, VLAN_HLEN);
 			skb_reset_network_header(skb);
-- 
2.53.0




