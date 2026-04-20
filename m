Return-Path: <stable+bounces-239843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJp1JDJk5mkuvwEAu9opvQ
	(envelope-from <stable+bounces-239843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:36:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88809431985
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C97CF30A95C3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BAF33F5BC;
	Mon, 20 Apr 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ac3pVjlS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709E2E093A;
	Mon, 20 Apr 2026 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701358; cv=none; b=cs4lYzoJXaSQjLWTu/ZXa7qz9GVG56htl1GjyfGA4mzTE+Z5oKFosbFtoxVmiZMDCHpx2hnZoVHobhTmZrQR1SGqnvTZeBYhLr4yrMXxbI6bY+2CMJ1AKzAwb1OLDhvvMTvKlO3Apmhk6QGaDLOm6TquswEjzlRuGtWTHFkKJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701358; c=relaxed/simple;
	bh=Ya3HBMYzyXJaE+JUeKIz4cdnFXGhVSncBWg4wxlEpKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVLKjLfQHGxTT1GPX4y6e+TFjqa+wrru1fN708raP68aJL+omzIBufVnlpFVfRrN9tdmLYwgbFomRRzSTBf52jDqEvY0X7yr6UbVFIf/FPP5Ipr+3baEWb6AWv9OSQQ8bgN66fMIKWUnUYQr+D2/mh7cI8xvWzcUvC7sU1Wef2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ac3pVjlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD588C19425;
	Mon, 20 Apr 2026 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701358;
	bh=Ya3HBMYzyXJaE+JUeKIz4cdnFXGhVSncBWg4wxlEpKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ac3pVjlSATlpKLkACSEZHd4NjpLuNveJxS5tEXLvsvLi+nfI7Cyfg4cqcmAyudytm
	 3KDqomKf7sZ5Q9DVhAJ/4zayqWuXrHusssZnIvmLjSM1rEoy1JLIWdKHFS0rUlAk3F
	 ZqOHYnnq89dsuzn12pNYxbKhd0uO8q4gP02TLWJQ=
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
Subject: [PATCH 6.12 049/162] net: sched: act_csum: validate nested VLAN headers
Date: Mon, 20 Apr 2026 17:41:21 +0200
Message-ID: <20260420153928.811992054@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239843-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 88809431985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 5cc8e407e7911..8ea37c2c3c549 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -603,8 +603,12 @@ TC_INDIRECT_SCOPE int tcf_csum_act(struct sk_buff *skb,
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




