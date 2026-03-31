Return-Path: <stable+bounces-231779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEtxKsAAzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-231779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:13:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9E936E388
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76DB031A8EB6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC184279F3;
	Tue, 31 Mar 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NeVOI3+3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B204279E4;
	Tue, 31 Mar 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975047; cv=none; b=AElOeqMTo34/JLBcwXmXUdEcX3YYhdYdedib2NyzkD0nIinMa7gZCECsTcFmsaM6ipotzWx+ph7sMm58iEljEJDhSv2sWvDabESuNy7zCf3mJUOKmoEXfabjIZZK0fRKO/SuBCFhewkU3y0URuuD4xG9U0G9p3cSRIxk+izT86Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975047; c=relaxed/simple;
	bh=6+hsLyzWe2GaiUt/WQB3k7Y0fhY3X2jZLi4hGTNrZKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZ7XqKl39LCu6C89P4AuO9WhH30V2iuYx/eLw6Pika/SuxRHz8tQ9qgHUSe2otdyhglhkXs7qbR1vBGkTI2/yhrkYNV384MO14606v67wpeK38hYtr6mBGCF4sZlHsI80ji06iyzVKQKS5aiOUsN4fq9+/bgGQ6DfN0y2zH7TwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NeVOI3+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C31C2BCB4;
	Tue, 31 Mar 2026 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975047;
	bh=6+hsLyzWe2GaiUt/WQB3k7Y0fhY3X2jZLi4hGTNrZKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NeVOI3+3uInrweh0O7gpLdht22+UBH42ZjFiuprFawxi1crSA7cjy1f9qy2anXTVz
	 jU497fYqRmNFoHUwb9vA2og3GQEfUmGXa8DGR1rZAZs/JOMN6VyCVSGnU+niHEnaWL
	 bk9FHr3lwLSLeErJULQXEZSc5QPuja+ln4yAJHaQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 126/342] virtio-net: correct hdr_len handling for tunnel gso
Date: Tue, 31 Mar 2026 18:19:19 +0200
Message-ID: <20260331161803.642496543@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231779-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: AA9E936E388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

[ Upstream commit 6c860dc02a8e60b438e26940227dfa641fcdb66a ]

The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
GSO tunneling.") introduces support for the UDP GSO tunnel feature in
virtio-net.

The virtio spec says:

    If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
    VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
    all the headers up to and including the inner transport.

The commit did not update the hdr_len to include the inner transport.

I observed that the "hdr_len" is 116 for this packet:

    17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
        192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
    fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
        192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796

116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)

Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Link: https://patch.msgid.link/20260320021818.111741-3-xuanzhuo@linux.alibaba.com
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/virtio_net.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 361b60c8be680..f36d21b5bc19e 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -224,6 +224,22 @@ static inline void __virtio_net_set_hdrlen(const struct sk_buff *skb,
 	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
 }
 
+/* This function must be called after virtio_net_hdr_from_skb(). */
+static inline void __virtio_net_set_tnl_hdrlen(const struct sk_buff *skb,
+					       struct virtio_net_hdr *hdr)
+{
+	u16 hdr_len;
+
+	hdr_len = skb_inner_transport_offset(skb);
+
+	if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+		hdr_len += sizeof(struct udphdr);
+	else
+		hdr_len += inner_tcp_hdrlen(skb);
+
+	hdr->hdr_len = __cpu_to_virtio16(true, hdr_len);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -440,6 +456,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	if (ret)
 		return ret;
 
+	if (feature_hdrlen && hdr->hdr_len)
+		__virtio_net_set_tnl_hdrlen(skb, hdr);
+
 	if (skb->protocol == htons(ETH_P_IPV6))
 		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
 	else
-- 
2.51.0




