Return-Path: <stable+bounces-138241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B112DAA171A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC661A86FBD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32224397A;
	Tue, 29 Apr 2025 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x9h++9sp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A01227E95;
	Tue, 29 Apr 2025 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948624; cv=none; b=h/sDiBEjLxX5w7uPxUsZ5xcesV11Rolbkjznm5IVk6gfe/gVUew/OsLjEevp2TJSTgG6RuHCuFd1rs0gHKxSo9ulPZKN2va11MU6AsxJRUVUrOujFHUzy0XY5Kc8XpMqEI5Tju1SefKxcvBqqzxDI7mT23UKu4oA4gVwivJO2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948624; c=relaxed/simple;
	bh=xoKGhzsJnj3jPglH43vY1DfTcjUY/uZrQvxK4BHjBgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuckJVZeg6ybcWqxhMe65p4yJZeNWhfOftAmxlXPvkF2AWjy5EgVSLYsn70DvOkCvfbst3TWYOJC2FS4Og/rmh/SvGPp067NgWqphUZzmfyGE9UhaDmHZO57qgCZaMURywXCV7HwBiwHHR2mIAwvHkv/8gOIcyIhOko5KF/LxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x9h++9sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154A9C4CEE3;
	Tue, 29 Apr 2025 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948624;
	bh=xoKGhzsJnj3jPglH43vY1DfTcjUY/uZrQvxK4BHjBgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x9h++9sptioMaPaQAmkL2HHCVR2vEDvix9aVLCmRWEy5XxsZi7O/LlX76fJhuR4vx
	 gNAY6JP6DkGTonA/Gqv85YhO5xMG5RrDj4M305dVCRTEi9J2lQtG50OPI/BmYRKtmH
	 8djzBUStCoNJpYnVJePX4OoBSphTX4xf3qHCkLdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Moeller <moeller.matt@gmail.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 056/373] bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
Date: Tue, 29 Apr 2025 18:38:53 +0200
Message-ID: <20250429161125.430715003@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit d4bac0288a2b444e468e6df9cb4ed69479ddf14a ]

Classic BPF socket filters with SKB_NET_OFF and SKB_LL_OFF fail to
read when these offsets extend into frags.

This has been observed with iwlwifi and reproduced with tun with
IFF_NAPI_FRAGS. The below straightforward socket filter on UDP port,
applied to a RAW socket, will silently miss matching packets.

    const int offset_proto = offsetof(struct ip6_hdr, ip6_nxt);
    const int offset_dport = sizeof(struct ip6_hdr) + offsetof(struct udphdr, dest);
    struct sock_filter filter_code[] = {
            BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_AD_OFF + SKF_AD_PKTTYPE),
            BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, PACKET_HOST, 0, 4),
            BPF_STMT(BPF_LD  + BPF_B   + BPF_ABS, SKF_NET_OFF + offset_proto),
            BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, IPPROTO_UDP, 0, 2),
            BPF_STMT(BPF_LD  + BPF_H   + BPF_ABS, SKF_NET_OFF + offset_dport),

This is unexpected behavior. Socket filter programs should be
consistent regardless of environment. Silent misses are
particularly concerning as hard to detect.

Use skb_copy_bits for offsets outside linear, same as done for
non-SKF_(LL|NET) offsets.

Offset is always positive after subtracting the reference threshold
SKB_(LL|NET)_OFF, so is always >= skb_(mac|network)_offset. The sum of
the two is an offset against skb->data, and may be negative, but it
cannot point before skb->head, as skb_(mac|network)_offset would too.

This appears to go back to when frag support was introduced to
sk_run_filter in linux-2.4.4, before the introduction of git.

The amount of code change and 8/16/32 bit duplication are unfortunate.
But any attempt I made to be smarter saved very few LoC while
complicating the code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/20250122200402.3461154-1-maze@google.com/
Link: https://elixir.bootlin.com/linux/2.4.4/source/net/core/filter.c#L244
Reported-by: Matt Moeller <moeller.matt@gmail.com>
Co-developed-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://lore.kernel.org/r/20250408132833.195491-2-willemdebruijn.kernel@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 80 ++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 45cde12e41284..9d358fb865e28 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -209,24 +209,36 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
 	return 0;
 }
 
+static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int offset)
+{
+	if (likely(offset >= 0))
+		return offset;
+
+	if (offset >= SKF_NET_OFF)
+		return offset - SKF_NET_OFF + skb_network_offset(skb);
+
+	if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
+		return offset - SKF_LL_OFF + skb_mac_offset(skb);
+
+	return INT_MIN;
+}
+
 BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u8 tmp, *ptr;
+	u8 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return *(u8 *)(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return tmp;
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return *(u8 *)ptr;
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return *(u8 *)(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return tmp;
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
@@ -239,21 +251,19 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	__be16 tmp, *ptr;
+	__be16 tmp;
 	const int len = sizeof(tmp);
 
-	if (offset >= 0) {
-		if (headlen - offset >= len)
-			return get_unaligned_be16(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be16_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be16(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be16(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be16_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
@@ -266,21 +276,19 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	__be32 tmp, *ptr;
+	__be32 tmp;
 	const int len = sizeof(tmp);
 
-	if (likely(offset >= 0)) {
-		if (headlen - offset >= len)
-			return get_unaligned_be32(data + offset);
-		if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
-			return be32_to_cpu(tmp);
-	} else {
-		ptr = bpf_internal_load_pointer_neg_helper(skb, offset, len);
-		if (likely(ptr))
-			return get_unaligned_be32(ptr);
-	}
+	offset = bpf_skb_load_helper_convert_offset(skb, offset);
+	if (offset == INT_MIN)
+		return -EFAULT;
 
-	return -EFAULT;
+	if (headlen - offset >= len)
+		return get_unaligned_be32(data + offset);
+	if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
+		return be32_to_cpu(tmp);
+	else
+		return -EFAULT;
 }
 
 BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
-- 
2.39.5




