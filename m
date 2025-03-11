Return-Path: <stable+bounces-123925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E5A5C80B
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81FF17BEFE
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F825EF90;
	Tue, 11 Mar 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="daa+GClV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FBA25E47F;
	Tue, 11 Mar 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707356; cv=none; b=d2LzNAP6G2k6hAYlR9Af7F9lO+owXHR991hNTCrzcZI320jIkOVyqs2FuP1TlGS/5RogmD5AbKu5u5aSorGUkpafHNXPz8TzdVZYzHkmMHUm0WQzw9GYoMOGJhz7pG7nFrVIoYj+RPwbYNDtTJ606NBTidGbMr+pzQ9+1dR7DRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707356; c=relaxed/simple;
	bh=VRtGZbuxxXoXW7eJJymHcRPB4P024Tllt8WpwJjfFU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndkd/IwwtfwSj45Cbzx6wFpLWnJveHNREcI/eCqSEtxR7xNcid/QZWppK5LGkSNo8HjogU7K55VHOVOGcNIEH7abLyErO+BL089Cr9/Hsb8IJ9B5Mn4TixAWFNzeQcGZsFyVYp51dv1FbqrXgZUhU3uT+AnM5A88JDGi8jf3bnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=daa+GClV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E34C4CEE9;
	Tue, 11 Mar 2025 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741707356;
	bh=VRtGZbuxxXoXW7eJJymHcRPB4P024Tllt8WpwJjfFU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daa+GClVz8Z2Wphk5lxsciz3ZAaexZj48qxHlyP53x99zkzj9mS8ciQxpa9q0JoYC
	 tSeeR9fAOnBF8f672FWT+mrWHRCOM/RSzb3sBeMNtIyo6NKo0qwhzHKCi0RcKg2fsk
	 ZFm0yqUY/S90l1ZE155VKA9octBuzLr9Jh5RvTFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Yongjun <zhengyongjun3@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 362/462] net: ipv6: rpl_iptunnel: simplify the return expression of rpl_do_srh()
Date: Tue, 11 Mar 2025 16:00:28 +0100
Message-ID: <20250311145812.653551827@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
References: <20250311145758.343076290@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yongjun <zhengyongjun3@huawei.com>

[ Upstream commit 9faad250ce66ed4159fa095a269690d7cfdb3ce3 ]

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 13e55fbaec17 ("net: ipv6: fix dst ref loop on input in rpl lwt")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/rpl_iptunnel.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 274593b7c6107..df835dfcc5b70 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -190,18 +190,13 @@ static int rpl_do_srh(struct sk_buff *skb, const struct rpl_lwt *rlwt)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct rpl_iptunnel_encap *tinfo;
-	int err = 0;
 
 	if (skb->protocol != htons(ETH_P_IPV6))
 		return -EINVAL;
 
 	tinfo = rpl_encap_lwtunnel(dst->lwtstate);
 
-	err = rpl_do_srh_inline(skb, rlwt, tinfo->srh);
-	if (err)
-		return err;
-
-	return 0;
+	return rpl_do_srh_inline(skb, rlwt, tinfo->srh);
 }
 
 static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
-- 
2.39.5




