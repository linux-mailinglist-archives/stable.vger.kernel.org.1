Return-Path: <stable+bounces-198554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D13DACA114F
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B699A32D83F0
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADF316914;
	Wed,  3 Dec 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQbiPRcm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBE314B78;
	Wed,  3 Dec 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776927; cv=none; b=GnQuuM4L+MyjKHzoIhjX903Hj5chjuq44x1UoRlUyFGnPUkenvfI+rlCJVw7h5VYBa38rriytMWKm5H7tfB43HGEH3NXFY9SDn06vM2B9J2Vnzn9GQ/+8/Ro+oM82uvaVAdot8scvd1jOAsn7aXwNQuWC3nyUafNYoN9PhqrPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776927; c=relaxed/simple;
	bh=dr+FPyxyjMOBudqCjD26h3Oj7wo53KF2H0q88DsEJx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBY/naULyXSt/gqowaoVrwy0qfjPhCkH0ihuoqOCxLVoqcQl55sHz6BPL1cklrFX9E0e0GF8AV/ORlgnp2S4LmronZ9CkuGOR3b7Za4NwLo4MXl95yIwCKFnElUb2YoIjvmoEIE2E+DdH1jDR0e0mdmTlAi9sCjwRrtumowMo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQbiPRcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186FDC4CEF5;
	Wed,  3 Dec 2025 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776927;
	bh=dr+FPyxyjMOBudqCjD26h3Oj7wo53KF2H0q88DsEJx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQbiPRcm98V/B/mDBzqqdIBxnYB1t5W/xfco8Z4+8TQPXTJ44zJwUAI35mGRN/JQX
	 yU9DurmDT35pUFJsukkM/91Puw0Evf7M9DXtYQpXEUjuIbQ3Msh5CTZRy8HXDluift
	 lfYF++eaoAZ2XSho8fYk3Sz9abO34oZScG7M+8IU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vince Chang <vince_chang@aspeedtech.com>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 029/146] net: mctp: unconditionally set skb->dev on dst output
Date: Wed,  3 Dec 2025 16:26:47 +0100
Message-ID: <20251203152347.540633168@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
References: <20251203152346.456176474@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Kerr <jk@codeconstruct.com.au>

[ Upstream commit b3e528a5811bbc8246dbdb962f0812dc9b721681 ]

On transmit, we are currently relying on skb->dev being set by
mctp_local_output() when we first set up the skb destination fields.
However, forwarded skbs do not use the local_output path, so will retain
their incoming netdev as their ->dev on tx. This does not work when
we're forwarding between interfaces.

Set skb->dev unconditionally in the transmit path, to allow for proper
forwarding.

We keep the skb->dev initialisation in mctp_local_output(), as we use it
for fragmentation.

Fixes: 269936db5eb3 ("net: mctp: separate routing database from routing operations")
Suggested-by: Vince Chang <vince_chang@aspeedtech.com>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Link: https://patch.msgid.link/20251125-dev-forward-v1-1-54ecffcd0616@codeconstruct.com.au
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mctp/route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 4d314e062ba9c..2ac4011a953ff 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -623,6 +623,7 @@ static int mctp_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 
 	skb->protocol = htons(ETH_P_MCTP);
 	skb->pkt_type = PACKET_OUTGOING;
+	skb->dev = dst->dev->dev;
 
 	if (skb->len > dst->mtu) {
 		kfree_skb(skb);
-- 
2.51.0




