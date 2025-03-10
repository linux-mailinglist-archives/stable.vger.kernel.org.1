Return-Path: <stable+bounces-122647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33386A5A098
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34F71891F10
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA97231A3B;
	Mon, 10 Mar 2025 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hmeum9kz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A217CA12;
	Mon, 10 Mar 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629095; cv=none; b=LYc8ACBL1iXojNnaeNQvTFDGkSAixPuFlem8tk6COwKOeJe2I47wrd7b9wwE56tA9UPY2VrL0gVSsqtRvWV1jVPCCYCzWyTp20ru+q6Ev3LSu2ZRwEyTsrE/1nZehT5yC8jo8WkMSb5F+Qu49VwhhvZlRmRgFMCL4f2cjS3hFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629095; c=relaxed/simple;
	bh=WPf+o9/ygVl+vFBSNk3R3A54DhDqAQNuxZGSWz2helQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2FR/KiAjLeSFJM6MNZBKE4icGHz7nDYfXX5TgD8rsT40UOhLZXx6QZNCajTluTTK2Nsc74lGjrMp+X3UOWIyheQxmolSlx1LzeiGjfOiKMpEI9o+vwZanwIm6PFpn1MG+cYg//jsnJYCC0j/37Jy7nR40FxaB6aPLzdhY1BAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hmeum9kz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75935C4CEE5;
	Mon, 10 Mar 2025 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629094;
	bh=WPf+o9/ygVl+vFBSNk3R3A54DhDqAQNuxZGSWz2helQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hmeum9kzc6KshIZQ47Pl2GnGudNeb1S0sPwGmXKbZUo1g2PZmq1OPKadlDMjVrh7Y
	 u/DuLaFPv0vPGW4Vlz9heywH4I6s4QlEqZ9KpplXg7648SV9RoTIJju5e4tzMbciIB
	 i2clYVwUvIVkcucFovlJH1P/9+yoQSaFzRRx9sXY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Wurm <stephan.wurm@a-eberle.de>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 174/620] net: hsr: fix fill_frame_info() regression vs VLAN packets
Date: Mon, 10 Mar 2025 18:00:20 +0100
Message-ID: <20250310170552.492170263@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0f5697f1a3f99bc2b674b8aa3c5da822c5673c11 ]

Stephan Wurm reported that my recent patch broke VLAN support.

Apparently skb->mac_len is not correct for VLAN traffic as
shown by debug traces [1].

Use instead pskb_may_pull() to make sure the expected header
is present in skb->head.

Many thanks to Stephan for his help.

[1]
kernel: skb len=170 headroom=2 headlen=170 tailroom=20
        mac=(2,14) mac_len=14 net=(16,-1) trans=-1
        shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
        csum(0x0 start=0 offset=0 ip_summed=0 complete_sw=0 valid=0 level=0)
        hash(0x0 sw=0 l4=0) proto=0x0000 pkttype=0 iif=0
        priority=0x0 mark=0x0 alloc_cpu=0 vlan_all=0x0
        encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
kernel: dev name=prp0 feat=0x0000000000007000
kernel: sk family=17 type=3 proto=0
kernel: skb headroom: 00000000: 74 00
kernel: skb linear:   00000000: 01 0c cd 01 00 01 00 d0 93 53 9c cb 81 00 80 00
kernel: skb linear:   00000010: 88 b8 00 01 00 98 00 00 00 00 61 81 8d 80 16 52
kernel: skb linear:   00000020: 45 47 44 4e 43 54 52 4c 2f 4c 4c 4e 30 24 47 4f
kernel: skb linear:   00000030: 24 47 6f 43 62 81 01 14 82 16 52 45 47 44 4e 43
kernel: skb linear:   00000040: 54 52 4c 2f 4c 4c 4e 30 24 44 73 47 6f 6f 73 65
kernel: skb linear:   00000050: 83 07 47 6f 49 64 65 6e 74 84 08 67 8d f5 93 7e
kernel: skb linear:   00000060: 76 c8 00 85 01 01 86 01 00 87 01 00 88 01 01 89
kernel: skb linear:   00000070: 01 00 8a 01 02 ab 33 a2 15 83 01 00 84 03 03 00
kernel: skb linear:   00000080: 00 91 08 67 8d f5 92 77 4b c6 1f 83 01 00 a2 1a
kernel: skb linear:   00000090: a2 06 85 01 00 83 01 00 84 03 03 00 00 91 08 67
kernel: skb linear:   000000a0: 8d f5 92 77 4b c6 1f 83 01 00
kernel: skb tailroom: 00000000: 80 18 02 00 fe 4e 00 00 01 01 08 0a 4f fd 5e d1
kernel: skb tailroom: 00000010: 4f fd 5e cd

Fixes: b9653d19e556 ("net: hsr: avoid potential out-of-bound access in fill_frame_info()")
Reported-by: Stephan Wurm <stephan.wurm@a-eberle.de>
Tested-by: Stephan Wurm <stephan.wurm@a-eberle.de>
Closes: https://lore.kernel.org/netdev/Z4o_UC0HweBHJ_cw@PC-LX-SteWu/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250129130007.644084-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_forward.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 20d4c3f8d8750..3de280a0dab2b 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -546,9 +546,12 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 		frame->is_vlan = true;
 
 	if (frame->is_vlan) {
-		if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlanhdr))
+		/* Note: skb->mac_len might be wrong here. */
+		if (!pskb_may_pull(skb,
+				   skb_mac_offset(skb) +
+				   offsetofend(struct hsr_vlan_ethhdr, vlanhdr)))
 			return -EINVAL;
-		vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
+		vlan_hdr = (struct hsr_vlan_ethhdr *)skb_mac_header(skb);
 		proto = vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
 		/* FIXME: */
 		netdev_warn_once(skb->dev, "VLAN not yet supported");
-- 
2.39.5




