Return-Path: <stable+bounces-19792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA772853741
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EE22833AC
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054125FDB5;
	Tue, 13 Feb 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5nVnSun"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2CF5FEEB;
	Tue, 13 Feb 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845006; cv=none; b=EYe9KZ0xBQWrO3BsJIyHJHKCIc1WlZKqPhMMz59j+wwgaPe2xNzcdoR/OHFQDu+0Qx+doDKymoQADIkyEZ5DYZqP0o4Yt9ZKT9MAcHnkYjx+Jw2cYkaJMy7C4Fs0Ynhuf/JFETcyA1rJ5mp3rhv5KcHrEzP3OjQHt65Tgq80hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845006; c=relaxed/simple;
	bh=wyGAaV4Cza2clEsZnsC3TNR2ihKQgfAi9l2UkfF3TC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNm+i1fq3EoJ5yjqpHFNkGDoTvowR3FTJozPVonxSRu4PITmJguzvZexsELlEdd0lKPiUWyS6a9/LK+ASuL8tsJOKo2F02jX6/m95tDs1rJpgrTScnAUXwvqV7q0cBp0j6Tem2ULj1RQ1hdjCUi5FqXwbumgWrRWuYYvf12WnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5nVnSun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EED8C433F1;
	Tue, 13 Feb 2024 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845006;
	bh=wyGAaV4Cza2clEsZnsC3TNR2ihKQgfAi9l2UkfF3TC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y5nVnSunuLLAqvgfvbCV5p8FlMddqzwyzVjQTc6crdzwPWhPmpUH43A9AvDyuwsYk
	 c2otnY7asV3YARJC9RivM0shgWBEPlppuKnuRtYW8YMZJyZex7r9xap9qtL/p9ufkq
	 IFFu6Ay0km0VaYmf0umOKZl2/+LgfEyDtXBXAC2o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoine Tenart <atenart@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 19/64] tunnels: fix out of bounds access when building IPv6 PMTU error
Date: Tue, 13 Feb 2024 18:21:05 +0100
Message-ID: <20240213171845.339012770@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
References: <20240213171844.702064831@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit d75abeec401f8c86b470e7028a13fcdc87e5dd06 ]

If the ICMPv6 error is built from a non-linear skb we get the following
splat,

  BUG: KASAN: slab-out-of-bounds in do_csum+0x220/0x240
  Read of size 4 at addr ffff88811d402c80 by task netperf/820
  CPU: 0 PID: 820 Comm: netperf Not tainted 6.8.0-rc1+ #543
  ...
   kasan_report+0xd8/0x110
   do_csum+0x220/0x240
   csum_partial+0xc/0x20
   skb_tunnel_check_pmtu+0xeb9/0x3280
   vxlan_xmit_one+0x14c2/0x4080
   vxlan_xmit+0xf61/0x5c00
   dev_hard_start_xmit+0xfb/0x510
   __dev_queue_xmit+0x7cd/0x32a0
   br_dev_queue_push_xmit+0x39d/0x6a0

Use skb_checksum instead of csum_partial who cannot deal with non-linear
SKBs.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 586b1b3e35b8..80ccd6661aa3 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -332,7 +332,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	};
 	skb_reset_network_header(skb);
 
-	csum = csum_partial(icmp6h, len, 0);
+	csum = skb_checksum(skb, skb_transport_offset(skb), len, 0);
 	icmp6h->icmp6_cksum = csum_ipv6_magic(&nip6h->saddr, &nip6h->daddr, len,
 					      IPPROTO_ICMPV6, csum);
 
-- 
2.43.0




