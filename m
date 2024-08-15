Return-Path: <stable+bounces-69053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36A2953535
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5BBB28713
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C501993B9;
	Thu, 15 Aug 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zdisjM8R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD863D5;
	Thu, 15 Aug 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732514; cv=none; b=WhmohiT05N5S7m/hbTkYZu73NdsDyfF3wx9yH0qlmlAAa0n0CYoJoWmiMbBhhWwaYbLneCnCgT6Iuk3PfWpFOr1rvkzoiv41lh683MN7+0gqIol8XuVeGfpQ5mbADULk5ZzNcEUsTBBA3NuUucWy7YFCFRYMduVpZXULH3w2wCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732514; c=relaxed/simple;
	bh=hCZWnv2VRiFIOcffyFD0O/V5KSlgEGLIaIFXLmj0JYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baWUnMJ1qEyLDlBaWi6rAJdVO2zTd241+5U8EJ8VuwWqp/Ktt+JAEMqmqddyLOzCC/8tbQ+TjRzMcNbOu8DFxhhSSLHDP447ZFTV2FRm5qUeR0OBJok5tN8KHpM+iXj00uS9BdYA61FE/uOaeg3ARKpfqH8YHZN6xYldMAH2HEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zdisjM8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ED8C32786;
	Thu, 15 Aug 2024 14:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723732514;
	bh=hCZWnv2VRiFIOcffyFD0O/V5KSlgEGLIaIFXLmj0JYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zdisjM8RfdoMvMx/ZRWrA/Bwv9FnuzJ2f1lK5gxDfmJ13+ROhy0ybZEHM5xMZkRC8
	 dyeoUZppko0zgp3X0Ed7EYRK5+grBpJlZCAhItigxnlr6IxdMw4Gd16f4YA0YIXnPA
	 hUvHN+l8lbwEiuq+hOPxwI3TWjkYbDx9Qf3uo0No=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fred Li <dracodingfly@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 202/352] bpf: Fix a segment issue when downgrading gso_size
Date: Thu, 15 Aug 2024 15:24:28 +0200
Message-ID: <20240815131927.083419460@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fred Li <dracodingfly@gmail.com>

[ Upstream commit fa5ef655615a01533035c6139248c5b33aa27028 ]

Linearize the skb when downgrading gso_size because it may trigger a
BUG_ON() later when the skb is segmented as described in [1,2].

Fixes: 2be7e212d5419 ("bpf: add bpf_skb_adjust_room helper")
Signed-off-by: Fred Li <dracodingfly@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/all/20240626065555.35460-2-dracodingfly@gmail.com [1]
Link: https://lore.kernel.org/all/668d5cf1ec330_1c18c32947@willemb.c.googlers.com.notmuch [2]
Link: https://lore.kernel.org/bpf/20240719024653.77006-1-dracodingfly@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a3101cdfd47b9..99fdd8afeeda3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3535,13 +3535,20 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* Due to header grow, MSS needs to be downgraded. */
-		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
-			skb_decrease_gso_size(shinfo, len_diff);
-
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= gso_type;
 		shinfo->gso_segs = 0;
+
+		/* Due to header growth, MSS needs to be downgraded.
+		 * There is a BUG_ON() when segmenting the frag_list with
+		 * head_frag true, so linearize the skb after downgrading
+		 * the MSS.
+		 */
+		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
+			skb_decrease_gso_size(shinfo, len_diff);
+			if (shinfo->frag_list)
+				return skb_linearize(skb);
+		}
 	}
 
 	return 0;
-- 
2.43.0




