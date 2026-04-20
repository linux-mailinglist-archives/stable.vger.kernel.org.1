Return-Path: <stable+bounces-239672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ2vF2dO5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:03:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0123442EE6A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C905C3018B76
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529D3342CB2;
	Mon, 20 Apr 2026 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZ6MhoAS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069B33E377;
	Mon, 20 Apr 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700924; cv=none; b=CPa8/54bPwoA5q+45QVMwmYFNnh65NGeWas1q7g4TKjXJE2ssCkPsS50Mpyufx8Dszi5F/Fv/cSNVDvxO5KIcY7IGeyY3lVJ68rkb9cqKJOYbh4aum14twrXhcUkd4eH1ZVlfHmAc6yy3h6VHAk14r4w6cKX0fynoqx9bsmO618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700924; c=relaxed/simple;
	bh=+UXvSXHUufANpCH9O+7BYqZ6xhqYzAbcz4CDjS1dmKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7Wznj/H0yUrNjK6wSNi7q6zDyHteaoCAOzCH3Tuvs6zyeGcUi2gqlC4AyT2Rg9ml01cddCOF9y9uefrpkC3fZQokdmxU1bTFTS98gD1v13dyaYCJC6w9QCz7NYCHasQzSOFHG4CedHSbcc5YXNnnWsGuyFzyK0xQ4dMh0y1gyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZ6MhoAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5908AC19425;
	Mon, 20 Apr 2026 16:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700923;
	bh=+UXvSXHUufANpCH9O+7BYqZ6xhqYzAbcz4CDjS1dmKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EZ6MhoAS9DeAKe+Ck49Tz+rXsx4nBpFzG8aA8m/uwpE+X5/zibDz0MlKtX5NVLg+c
	 bQVEn+GpuvBkUtpkpWk9UAyjJZoup4gSTZeaGf+UTcdB8nAT+6yZTpCdYETD8OBWVp
	 AIiYOnY5rbzv+IaXOXkzmBx5Bj5jX2ptRNGN3xuY=
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
Subject: [PATCH 6.18 070/198] net: sched: act_csum: validate nested VLAN headers
Date: Mon, 20 Apr 2026 17:40:49 +0200
Message-ID: <20260420153938.131013607@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239672-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0123442EE6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 0939e6b2ba4d1..3a377604ad343 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -604,8 +604,12 @@ TC_INDIRECT_SCOPE int tcf_csum_act(struct sk_buff *skb,
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




