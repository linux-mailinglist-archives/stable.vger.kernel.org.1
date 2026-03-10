Return-Path: <stable+bounces-224162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGG/FgL/r2mQeQIAu9opvQ
	(envelope-from <stable+bounces-224162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5B624A869
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E1E030D50AE
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B53A38A71E;
	Tue, 10 Mar 2026 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpz40Vg5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E665387362;
	Tue, 10 Mar 2026 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141293; cv=none; b=MkcwXFuMPt57/xt6Z+783pajt14Cu1F79B048nOh+zL2VekN1aVMcI0b0p+wRUaU9saVrvjvQNV4fLuqZsygiG3P9dn1Ibq1byo2Tcb4WCPaeyAcOsb7cxR0vSaWek/eOUNak/r4rIRcIXKaj8zCIKpXc+uM3pKZyGD47VoUPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141293; c=relaxed/simple;
	bh=v9hWWMA8CXsJIY+g8KeSYE4twmJI6BQ2yRWT84uXZ9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSjrrJrEteKilK5Lsi6ucqnOAX+Hgk3Evqslxt60tYFWVTIMmyMdv7TrmuooOzMbPWk585Wu/Dcvi2aDJ23RMHPnc3WYt5e49Ke2fHxv0JqpUamGbMzD37cYGojcnsAAABubwiLmPtRUbW6gamOtL6G0IYGuQtG1fzaUo5Cvsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpz40Vg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910BCC2BCB0;
	Tue, 10 Mar 2026 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141293;
	bh=v9hWWMA8CXsJIY+g8KeSYE4twmJI6BQ2yRWT84uXZ9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gpz40Vg5uqalFY2rza4eyMWF+sCcFJ8bYOq8M1BmVTz4oct8mqqkeGWYn+5dSs6zC
	 dayxd/3b1WpnuBGrEZECFzQP+SRRpMCce3v4lorlaTrkl6baRSDYzchQHxXOetDRNd
	 4+oP3zQdlj2euLRaFBRJHWBFbqcCmXUUR5JGy37MXH+p3hlEfuKVAllriS43tP/jCS
	 dMNR+sboAFUEUCkQZ3L8WnoZi4dBK3EP4W7uO87hQgctRB1SumVwDb3TiTmrN/wsoC
	 yvoJy5h/vjsz1NYIGKhggIw1cho5QdVXhZ/+2QHpsJlqWPRb2Xyh9RxqHvf4fUVn6c
	 iq/fsVUDXpKOw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 297/311] xdp: use modulo operation to calculate XDP frag tailroom
Date: Tue, 10 Mar 2026 07:05:44 -0400
Message-ID: <47293be2485f025cc9a03f9bb5c7fe7495b8e6b9.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB5B624A869
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224162-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,intel.com:email]
X-Rspamd-Action: no action

From: Larysa Zaremba <larysa.zaremba@intel.com>

[ Upstream commit 88b6b7f7b216108a09887b074395fa7b751880b1 ]

The current formula for calculating XDP tailroom in mbuf packets works only
if each frag has its own page (if rxq->frag_size is PAGE_SIZE), this
defeats the purpose of the parameter overall and without any indication
leads to negative calculated tailroom on at least half of frags, if shared
pages are used.

There are not many drivers that set rxq->frag_size. Among them:
* i40e and enetc always split page uniformly between frags, use shared
  pages
* ice uses page_pool frags via libeth, those are power-of-2 and uniformly
  distributed across page
* idpf has variable frag_size with XDP on, so current API is not applicable
* mlx5, mtk and mvneta use PAGE_SIZE or 0 as frag_size for page_pool

As for AF_XDP ZC, only ice, i40e and idpf declare frag_size for it. Modulo
operation yields good results for aligned chunks, they are all power-of-2,
between 2K and PAGE_SIZE. Formula without modulo fails when chunk_size is
2K. Buffers in unaligned mode are not distributed uniformly, so modulo
operation would not work.

To accommodate unaligned buffers, we could define frag_size as
data + tailroom, and hence do not subtract offset when calculating
tailroom, but this would necessitate more changes in the drivers.

Define rxq->frag_size as an even portion of a page that fully belongs to a
single frag. When calculating tailroom, locate the data start within such
portion by performing a modulo operation on page offset.

Fixes: bf25146a5595 ("bpf: add frags support to the bpf_xdp_adjust_tail() API")
Acked-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://patch.msgid.link/20260305111253.2317394-2-larysa.zaremba@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 51318cb40f778..f82996e63dd72 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4156,7 +4156,8 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	if (!rxq->frag_size || rxq->frag_size > xdp->frame_sz)
 		return -EOPNOTSUPP;
 
-	tailroom = rxq->frag_size - skb_frag_size(frag) - skb_frag_off(frag);
+	tailroom = rxq->frag_size - skb_frag_size(frag) -
+		   skb_frag_off(frag) % rxq->frag_size;
 	if (unlikely(offset > tailroom))
 		return -EINVAL;
 
-- 
2.51.0


