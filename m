Return-Path: <stable+bounces-144473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76BAB7D6E
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 07:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0D717ADDB
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888029551F;
	Thu, 15 May 2025 05:56:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851E10E5
	for <stable@vger.kernel.org>; Thu, 15 May 2025 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288584; cv=none; b=aZBnI3bLapqbliKrM2mqddsOF+Zyg+/Hjg1eQoNeAc8spnn7QtTrsunVkEbmXqhj8idCwsqtyKZqrDcvhQNTBkf9cArRSZBZNQDjbKs3yj8UHUbCR7slJDAx7SCWpCwKuO8YFqOmxmu81TDX3V4msBMzp26l5xVzhjJySmiqjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288584; c=relaxed/simple;
	bh=o3a3tpbQNjxh9VCgYdjo15ndCNc8prj2xttIV2N0sG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ujt8pXN1QffThPyrP8bvUgHfw90v9OIJCxLcf/XFiS7adio5VD4hoTA31A3uZmEW1YcO7FP20N1wSkAIryxFpGrESFEY2/8Nxrv4ToFiXYFdWGJGFqz23y2/dbilPPujI2POEzoeytOB8dzxCYiV7SpxccmkZASJ9A3wUvFoZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrADHzXXYgSVoRqpPAQ--.12993S2;
	Thu, 15 May 2025 13:55:36 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wCnry_XgSVoSEhhAA--.54160S4;
	Thu, 15 May 2025 13:55:36 +0800 (CST)
From: Zhaoyang Li <lizy04@hust.edu.cn>
To: stable@vger.kernel.org
Cc: dzm91@hust.edu.cn,
	Shigeru Yoshida <syoshida@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Zhaoyang Li <lizy04@hust.edu.cn>
Subject: [PATCH 6.1.y] ipv6: Fix potential uninit-value access in __ip6_make_skb()
Date: Thu, 15 May 2025 13:55:33 +0800
Message-Id: <20250515055533.408837-1-lizy04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrADHzXXYgSVoRqpPAQ--.12993S2
Authentication-Results: app2; spf=neutral smtp.mail=lizy04@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7Zw15uw1rWw4rZw4ktFb_yoW8JFWrpF
	yDG3W5GFykGrZrtFsrJF48XFW5Ga1qka42g3y5u3Wa9wn8Xrs5tFy2ga45WF15Aa93AFW5
	tF15Kw15KFWUuaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXV
	WUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr
	1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU32-eDUUUU
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQgDB2glY+EMHgAAsQ

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 4e13d3a9c25b7080f8a619f961e943fe08c2672c ]

As it was done in commit fc1092f51567 ("ipv4: Fix uninit-value access in
__ip_make_skb()") for IPv4, check FLOWI_FLAG_KNOWN_NH on fl6->flowi6_flags
instead of testing HDRINCL on the socket to avoid a race condition which
causes uninit-value access.

Fixes: ea30388baebc ("ipv6: Fix an uninit variable access bug in __ip6_make_skb()")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
---
 net/ipv6/ip6_output.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d7f7a714bd23..088487c5b548 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1985,7 +1985,8 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
 
-		if (sk->sk_socket->type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+		if (sk->sk_socket->type == SOCK_RAW &&
+		    !(fl6->flowi6_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp6_type = fl6->fl6_icmp_type;
 		else
 			icmp6_type = icmp6_hdr(skb)->icmp6_type;
-- 
2.25.1


