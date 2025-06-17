Return-Path: <stable+bounces-153524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7610ADD4EF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D921940E71
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81992EA170;
	Tue, 17 Jun 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMdeicvz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEC2EA153;
	Tue, 17 Jun 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176242; cv=none; b=Ey3uCDaGfP8BJ00nKuy5LZTlooW/Kq9N7zZJtA/eczTC8Fz7z7s26CCEH/Bi/fA/HO8MZnz/CqUukdWBf+9NwA0X7f/b6zGmqX37SRHLyhBHb6wDUfg5AcP1olWzp7USikXY5IZoG6LyNEPBj6AZhFFUPgVAag5ZMAceVMVQe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176242; c=relaxed/simple;
	bh=QJka88SJ8Qsb+AzY5htQ+EC3WcymAUHmAsR1UAtOtXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWtCkIDnKSVhCX7zKwt1CIH6diZtcVd4U4FSpN+rd0vC+TjHZ2lkif86Tssw0ZHvAr1fxT1MRxd8InVlkvHT3PArIShJlYBXlSwsBgmg0TM4fVlf45bkwu8HH8ongteUGcsARUJ7O6kQbo6UaOUtjQxm6+v4lzLDjrfeKLay3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eMdeicvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BBCC4CEE7;
	Tue, 17 Jun 2025 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176242;
	bh=QJka88SJ8Qsb+AzY5htQ+EC3WcymAUHmAsR1UAtOtXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMdeicvznTag4WkuJWlYp6sF7Hg0Fq5WuRZw4kaAJFHlvsaZ6oylTWqNb7W9LQgLZ
	 6TLhPRricOKvzOuVTgxztWwzGFGpsi11OOKb/fzbvBDP8oqPWhLP3Nm4fMy0eduOLU
	 tcHk3dj8rWNhDBKavEbH0oiss/w3an/CtVp5Y78w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shiming Cheng <shiming.cheng@mediatek.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 258/356] net: fix udp gso skb_segment after pull from frag_list
Date: Tue, 17 Jun 2025 17:26:13 +0200
Message-ID: <20250617152348.590521423@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiming Cheng <shiming.cheng@mediatek.com>

[ Upstream commit 3382a1ed7f778db841063f5d7e317ac55f9e7f72 ]

Commit a1e40ac5b5e9 ("net: gso: fix udp gso fraglist segmentation after
pull from frag_list") detected invalid geometry in frag_list skbs and
redirects them from skb_segment_list to more robust skb_segment. But some
packets with modified geometry can also hit bugs in that code. We don't
know how many such cases exist. Addressing each one by one also requires
touching the complex skb_segment code, which risks introducing bugs for
other types of skbs. Instead, linearize all these packets that fail the
basic invariants on gso fraglist skbs. That is more robust.

If only part of the fraglist payload is pulled into head_skb, it will
always cause exception when splitting skbs by skb_segment. For detailed
call stack information, see below.

Valid SKB_GSO_FRAGLIST skbs
- consist of two or more segments
- the head_skb holds the protocol headers plus first gso_size
- one or more frag_list skbs hold exactly one segment
- all but the last must be gso_size

Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
modify fraglist skbs, breaking these invariants.

In extreme cases they pull one part of data into skb linear. For UDP,
this  causes three payloads with lengths of (11,11,10) bytes were
pulled tail to become (12,10,10) bytes.

The skbs no longer meets the above SKB_GSO_FRAGLIST conditions because
payload was pulled into head_skb, it needs to be linearized before pass
to regular skb_segment.

    skb_segment+0xcd0/0xd14
    __udp_gso_segment+0x334/0x5f4
    udp4_ufo_fragment+0x118/0x15c
    inet_gso_segment+0x164/0x338
    skb_mac_gso_segment+0xc4/0x13c
    __skb_gso_segment+0xc4/0x124
    validate_xmit_skb+0x9c/0x2c0
    validate_xmit_skb_list+0x4c/0x80
    sch_direct_xmit+0x70/0x404
    __dev_queue_xmit+0x64c/0xe5c
    neigh_resolve_output+0x178/0x1c4
    ip_finish_output2+0x37c/0x47c
    __ip_finish_output+0x194/0x240
    ip_finish_output+0x20/0xf4
    ip_output+0x100/0x1a0
    NF_HOOK+0xc4/0x16c
    ip_forward+0x314/0x32c
    ip_rcv+0x90/0x118
    __netif_receive_skb+0x74/0x124
    process_backlog+0xe8/0x1a4
    __napi_poll+0x5c/0x1f8
    net_rx_action+0x154/0x314
    handle_softirqs+0x154/0x4b8

    [118.376811] [C201134] rxq0_pus: [name:bug&]kernel BUG at net/core/skbuff.c:4278!
    [118.376829] [C201134] rxq0_pus: [name:traps&]Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
    [118.470774] [C201134] rxq0_pus: [name:mrdump&]Kernel Offset: 0x178cc00000 from 0xffffffc008000000
    [118.470810] [C201134] rxq0_pus: [name:mrdump&]PHYS_OFFSET: 0x40000000
    [118.470827] [C201134] rxq0_pus: [name:mrdump&]pstate: 60400005 (nZCv daif +PAN -UAO)
    [118.470848] [C201134] rxq0_pus: [name:mrdump&]pc : [0xffffffd79598aefc] skb_segment+0xcd0/0xd14
    [118.470900] [C201134] rxq0_pus: [name:mrdump&]lr : [0xffffffd79598a5e8] skb_segment+0x3bc/0xd14
    [118.470928] [C201134] rxq0_pus: [name:mrdump&]sp : ffffffc008013770

Fixes: a1e40ac5b5e9 ("gso: fix udp gso fraglist segmentation after pull from frag_list")
Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp_offload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 132cfc3b2c847..3870b59f54004 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -332,6 +332,7 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	bool copy_dtor;
 	__sum16 check;
 	__be16 newlen;
+	int ret = 0;
 
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
@@ -354,6 +355,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
+		ret = __skb_linearize(gso_skb);
+		if (ret)
+			return ERR_PTR(ret);
+
 		 /* Setup csum, as fraglist skips this in udp4_gro_receive. */
 		gso_skb->csum_start = skb_transport_header(gso_skb) - gso_skb->head;
 		gso_skb->csum_offset = offsetof(struct udphdr, check);
-- 
2.39.5




