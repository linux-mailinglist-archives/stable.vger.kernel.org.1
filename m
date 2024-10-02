Return-Path: <stable+bounces-79448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC23298D858
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0171F239C0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354FF1D0DFC;
	Wed,  2 Oct 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IUYDBPRC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0F1D04B4;
	Wed,  2 Oct 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877489; cv=none; b=UktWRMgVG5B4QnZuDa0+lh5QNBiAw81Hj1TDVjrsacr1OskbRIVbFDLzahbbt6EftiBTd9gC/7tygu7UJMiPqCDssLATpeXj/qQroVLaTy+v7aIQn5V03QT8V6/Yxbfn/kYl1+9buc9Mhcb/jH7QFsCrlunXgdWVpUsMRnhN0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877489; c=relaxed/simple;
	bh=DlGenmnC92FdxwbsCdFgAYvjvM/GZLNs25YEUQ3orCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHrAVjexrKREgzzWdkCOuCXr2rwoA5VEkrmY1bd4yNQNz5Ok/w5P+Qv4Q36wKhrpuC47QmRjUlZRwSZaz+NUhiZCRy0Aarq8chdDqHw7ypELtjD1mON7E+GyaMynXFFdLGWQ3Jqp/7559wxNfo2BW9eCqbS1L2ZUAYGmYrxui8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IUYDBPRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA2DC4CED5;
	Wed,  2 Oct 2024 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877488;
	bh=DlGenmnC92FdxwbsCdFgAYvjvM/GZLNs25YEUQ3orCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUYDBPRCq2ohofqY8jOf3AVeJW32zpSyD3BZpRpECKJJPwmCvXQX9AjKfB1mG2bCU
	 vC0hxV3YTJwsg1aoipQ1no4aKJuCTvdVojitGBmJNFADKpWSr9N1izrq2w17let9za
	 Vixbkc0DTiD93pihmf8M8EHv+0F69avsgOpUtEds=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Nault <gnault@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 094/634] bareudp: Pull inner IP header on xmit.
Date: Wed,  2 Oct 2024 14:53:14 +0200
Message-ID: <20241002125814.820509124@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit c471236b2359e6b27388475dd04fff0a5e2bf922 ]

Both bareudp_xmit_skb() and bareudp6_xmit_skb() read their skb's inner
IP header to get its ECN value (with ip_tunnel_ecn_encap()). Therefore
we need to ensure that the inner IP header is part of the skb's linear
data.

Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/267328222f0a11519c6de04c640a4f87a38ea9ed.1726046181.git.gnault@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bareudp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index b4e820a123caf..e80992b4f9de9 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -317,6 +317,9 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be32 saddr;
 	int err;
 
+	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+		return -EINVAL;
+
 	if (!sock)
 		return -ESHUTDOWN;
 
@@ -384,6 +387,9 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
+	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+		return -EINVAL;
+
 	if (!sock)
 		return -ESHUTDOWN;
 
-- 
2.43.0




