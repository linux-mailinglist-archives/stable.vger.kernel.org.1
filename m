Return-Path: <stable+bounces-124313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0761AA5F650
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A3F189E52A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6CF267B63;
	Thu, 13 Mar 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fA6szS8W"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131722641FD
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873813; cv=none; b=jfvRw/fnxLkrzadDeMw6lDEJQzuq76c2+jjlLCuOF6qxgWIiOusOk3VghSvE6xxzyDRODDSdvl2Vo01SzX1Sz21rlHiurkqArVSF6Lkp/5lEpChFCfrC5pS881md2LxW4xcc9SpuogBlzApF0KonJLl8fAO08srzZ19hcBZ2BWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873813; c=relaxed/simple;
	bh=FwwsN0eC4Qds2BGRabhzCC9Jl+QWdC5SOLxOA1a1/qk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTSgPuD9cpz4TdFhj1k3LPfLQ0s6CnD3dLRNZ1vPOlG9NlWuHneG+JGpTUC2wpi4GLQ8uB31eKh2MTc/SXKC7x4GjonkR92lKwmZT9QZcUTSlhp3XppuUeNIsxzVx4V2G4UP/i5cjt7CnDnT7VYCInrkU3znYJJrS7wfRK1Sj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fA6szS8W; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741873812; x=1773409812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WZGksTaZlzK1KQ0QdUvR1EgolS9iDfK5452QY2wlY9Q=;
  b=fA6szS8Wv8e6ahJHksr3cYRgPaguHMK60pFRq4KRVGd8J/0b5H5mHbqb
   6jAfvlijI17M0zcxqsvjzGOjnTE90sPju9SRwT033hmt+VU1MI4lsM6EL
   onNZSrk5vXd7bKWWVZtfpoYRMoVxLJiuJlnuKOJ1lwWASH300hPsiBtX0
   8=;
X-IronPort-AV: E=Sophos;i="6.14,244,1736812800"; 
   d="scan'208";a="726509082"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 13:50:08 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:6569]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.251:2525] with esmtp (Farcaster)
 id f1f1b0a0-0d94-44e6-b197-f4f713d23f5a; Thu, 13 Mar 2025 13:50:07 +0000 (UTC)
X-Farcaster-Flow-ID: f1f1b0a0-0d94-44e6-b197-f4f713d23f5a
Received: from EX19D016EUA001.ant.amazon.com (10.252.50.245) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 13:50:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D016EUA001.ant.amazon.com (10.252.50.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 13:50:06 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 13:50:06 +0000
Received: from dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com (dev-dsk-kareemem-1c-885b5fe7.eu-west-1.amazon.com [10.13.243.223])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTPS id 76A4A4030C;
	Thu, 13 Mar 2025 13:50:05 +0000 (UTC)
From: Abdelkareem Abdelsaamad <kareemem@amazon.com>
To: <stable@vger.kernel.org>
CC: Wang Yufen <wangyufen@huawei.com>, Hulk Robot <hulkci@huawei.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, "Abdelkareem
 Abdelsaamad" <kareemem@amazon.com>
Subject: [PATCH 5.10.y 5.15.y] ipv6: Fix signed integer overflow in __ip6_append_data
Date: Thu, 13 Mar 2025 13:50:01 +0000
Message-ID: <20250313135001.21490-1-kareemem@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Wang Yufen <wangyufen@huawei.com>

[ Upstream commit f93431c86b631bbca5614c66f966bf3ddb3c2803 ]

Resurrect ubsan overflow checks and ubsan report this warning,
fix it by change the variable [length] type to size_t.

UBSAN: signed-integer-overflow in net/ipv6/ip6_output.c:1489:19
2147479552 + 8567 cannot be represented in type 'int'
CPU: 0 PID: 253 Comm: err Not tainted 5.16.0+ #1
Hardware name: linux,dummy-virt (DT)
Call trace:
  dump_backtrace+0x214/0x230
  show_stack+0x30/0x78
  dump_stack_lvl+0xf8/0x118
  dump_stack+0x18/0x30
  ubsan_epilogue+0x18/0x60
  handle_overflow+0xd0/0xf0
  __ubsan_handle_add_overflow+0x34/0x44
  __ip6_append_data.isra.48+0x1598/0x1688
  ip6_append_data+0x128/0x260
  udpv6_sendmsg+0x680/0xdd0
  inet6_sendmsg+0x54/0x90
  sock_sendmsg+0x70/0x88
  ____sys_sendmsg+0xe8/0x368
  ___sys_sendmsg+0x98/0xe0
  __sys_sendmmsg+0xf4/0x3b8
  __arm64_sys_sendmmsg+0x34/0x48
  invoke_syscall+0x64/0x160
  el0_svc_common.constprop.4+0x124/0x300
  do_el0_svc+0x44/0xc8
  el0_svc+0x3c/0x1e8
  el0t_64_sync_handler+0x88/0xb0
  el0t_64_sync+0x16c/0x170

Changes since v1:
-Change the variable [length] type to unsigned, as Eric Dumazet suggested.
Changes since v2:
-Don't change exthdrlen type in ip6_make_skb, as Paolo Abeni suggested.
Changes since v3:
-Don't change ulen type in udpv6_sendmsg and l2tp_ip6_sendmsg, as
Jakub Kicinski suggested.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Link: https://lore.kernel.org/r/20220607120028.845916-1-wangyufen@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Conflict due to
f37a4cc6bb0b ("udp6: pass flow in ip6_make_skb together with cork")
not in the tree
]
Signed-off-by: Abdelkareem Abdelsaamad <kareemem@amazon.com>
---
 include/net/ipv6.h    | 4 ++--
 net/ipv6/ip6_output.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 47d644de0e47..2909233427de 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -991,7 +991,7 @@ int ip6_find_1stfragopt(struct sk_buff *skb, u8 **nexthdr);
 int ip6_append_data(struct sock *sk,
 		    int getfrag(void *from, char *to, int offset, int len,
 				int odd, struct sk_buff *skb),
-		    void *from, int length, int transhdrlen,
+		    void *from, size_t length, int transhdrlen,
 		    struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
 		    struct rt6_info *rt, unsigned int flags);
 
@@ -1007,7 +1007,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk, struct sk_buff_head *queue,
 struct sk_buff *ip6_make_skb(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
-			     void *from, int length, int transhdrlen,
+			     void *from, size_t length, int transhdrlen,
 			     struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
 			     struct rt6_info *rt, unsigned int flags,
 			     struct inet_cork_full *cork);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4da3238836b7..d0f69026b689 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1448,7 +1448,7 @@ static int __ip6_append_data(struct sock *sk,
 			     struct page_frag *pfrag,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
-			     void *from, int length, int transhdrlen,
+			     void *from, size_t length, int transhdrlen,
 			     unsigned int flags, struct ipcm6_cookie *ipc6)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
@@ -1794,7 +1794,7 @@ static int __ip6_append_data(struct sock *sk,
 int ip6_append_data(struct sock *sk,
 		    int getfrag(void *from, char *to, int offset, int len,
 				int odd, struct sk_buff *skb),
-		    void *from, int length, int transhdrlen,
+		    void *from, size_t length, int transhdrlen,
 		    struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
 		    struct rt6_info *rt, unsigned int flags)
 {
@@ -1988,7 +1988,7 @@ EXPORT_SYMBOL_GPL(ip6_flush_pending_frames);
 struct sk_buff *ip6_make_skb(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
-			     void *from, int length, int transhdrlen,
+			     void *from, size_t length, int transhdrlen,
 			     struct ipcm6_cookie *ipc6, struct flowi6 *fl6,
 			     struct rt6_info *rt, unsigned int flags,
 			     struct inet_cork_full *cork)
-- 
2.47.1


