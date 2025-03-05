Return-Path: <stable+bounces-120648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4ECA507AB
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AE53A202E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB5C250C0E;
	Wed,  5 Mar 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fcz3X8g1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99B14B075;
	Wed,  5 Mar 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197569; cv=none; b=pojo1tbwQ9hKsVCoRXEJbnuBp59/FpgV3hNXutmaG+WQS0UAr1WPnJsaZlQnRAvg2NTaKxsBKDTOHl6HRf8t46Har0tfyfDBkTJkSNzvy4hbS4IfHt0DPa9lY1AI/0Q6aXglYxfwiS72UVC+L0ENAtnTOVPXipfeOKvTE7kuCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197569; c=relaxed/simple;
	bh=JSm0yX8xS65lqomga4ZOUr4nBogHlPnIuXGm3e1xdOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCXyU7/5K7GSMv+G1/ujsHqU8SUQS/fGpZYEI+soUq7d8q18mmmp28aKa63IdyZuRzrg0IOzYVsJSQLpTdABNnfF4aBS3u8JCdv1q/5oQD/3binlmLJGYGtVLqCuXqoEvP3zRkL4NteG9PV9EVWAyyWdmB8n4dU0RvtbgcEB4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fcz3X8g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1ACC4CEE2;
	Wed,  5 Mar 2025 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197568;
	bh=JSm0yX8xS65lqomga4ZOUr4nBogHlPnIuXGm3e1xdOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcz3X8g1Qv5+wo5WNzw4L7rN23gJTJunyLdmTPUdljHo7Azk9wRjp3Q6aZUHOcphE
	 iDQWEMXdElTH2lk4XvViJcwb1ZgM1+GTkkAQYpcdGpFU3iYc0TXzyMbviKxUcZZeBq
	 cvOlekhElVHEuMIHTJUpzVw55Sdq/eXW+b9cMjE0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peilin He <he.peilin@zte.com.cn>,
	xu xin <xu.xin16@zte.com.cn>,
	Yunkai Zhang <zhang.yunkai@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Liu Chun <liu.chun2@zte.com.cn>,
	Xuexin Jiang <jiang.xuexin@zte.com.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 024/142] net/ipv4: add tracepoint for icmp_send
Date: Wed,  5 Mar 2025 18:47:23 +0100
Message-ID: <20250305174501.313600517@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
References: <20250305174500.327985489@linuxfoundation.org>
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

From: Peilin He <he.peilin@zte.com.cn>

[ Upstream commit db3efdcf70c752e8a8deb16071d8e693c3ef8746 ]

Introduce a tracepoint for icmp_send, which can help users to get more
detail information conveniently when icmp abnormal events happen.

1. Giving an usecase example:
=============================
When an application experiences packet loss due to an unreachable UDP
destination port, the kernel will send an exception message through the
icmp_send function. By adding a trace point for icmp_send, developers or
system administrators can obtain detailed information about the UDP
packet loss, including the type, code, source address, destination address,
source port, and destination port. This facilitates the trouble-shooting
of UDP packet loss issues especially for those network-service
applications.

2. Operation Instructions:
==========================
Switch to the tracing directory.
        cd /sys/kernel/tracing
Filter for destination port unreachable.
        echo "type==3 && code==3" > events/icmp/icmp_send/filter
Enable trace event.
        echo 1 > events/icmp/icmp_send/enable

3. Result View:
================
 udp_client_erro-11370   [002] ...s.12   124.728002:
 icmp_send: icmp_send: type=3, code=3.
 From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=23
 skbaddr=00000000589b167a

Signed-off-by: Peilin He <he.peilin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Liu Chun <liu.chun2@zte.com.cn>
Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 27843ce6ba3d ("ipvlan: ensure network headers are in skb linear part")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/icmp.h | 67 +++++++++++++++++++++++++++++++++++++
 net/ipv4/icmp.c             |  4 +++
 2 files changed, 71 insertions(+)
 create mode 100644 include/trace/events/icmp.h

diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
new file mode 100644
index 0000000000000..31559796949a7
--- /dev/null
+++ b/include/trace/events/icmp.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM icmp
+
+#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ICMP_H
+
+#include <linux/icmp.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(icmp_send,
+
+		TP_PROTO(const struct sk_buff *skb, int type, int code),
+
+		TP_ARGS(skb, type, code),
+
+		TP_STRUCT__entry(
+			__field(const void *, skbaddr)
+			__field(int, type)
+			__field(int, code)
+			__array(__u8, saddr, 4)
+			__array(__u8, daddr, 4)
+			__field(__u16, sport)
+			__field(__u16, dport)
+			__field(unsigned short, ulen)
+		),
+
+		TP_fast_assign(
+			struct iphdr *iph = ip_hdr(skb);
+			struct udphdr *uh = udp_hdr(skb);
+			int proto_4 = iph->protocol;
+			__be32 *p32;
+
+			__entry->skbaddr = skb;
+			__entry->type = type;
+			__entry->code = code;
+
+			if (proto_4 != IPPROTO_UDP || (u8 *)uh < skb->head ||
+				(u8 *)uh + sizeof(struct udphdr)
+				> skb_tail_pointer(skb)) {
+				__entry->sport = 0;
+				__entry->dport = 0;
+				__entry->ulen = 0;
+			} else {
+				__entry->sport = ntohs(uh->source);
+				__entry->dport = ntohs(uh->dest);
+				__entry->ulen = ntohs(uh->len);
+			}
+
+			p32 = (__be32 *) __entry->saddr;
+			*p32 = iph->saddr;
+
+			p32 = (__be32 *) __entry->daddr;
+			*p32 = iph->daddr;
+		),
+
+		TP_printk("icmp_send: type=%d, code=%d. From %pI4:%u to %pI4:%u ulen=%d skbaddr=%p",
+			__entry->type, __entry->code,
+			__entry->saddr, __entry->sport, __entry->daddr,
+			__entry->dport, __entry->ulen, __entry->skbaddr)
+);
+
+#endif /* _TRACE_ICMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
+
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index a21d32b3ae6c3..b05fa424ad5ce 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -93,6 +93,8 @@
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
 #include <net/addrconf.h>
+#define CREATE_TRACE_POINTS
+#include <trace/events/icmp.h>
 
 /*
  *	Build xmit assembly blocks
@@ -778,6 +780,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	if (!fl4.saddr)
 		fl4.saddr = htonl(INADDR_DUMMY);
 
+	trace_icmp_send(skb_in, type, code);
+
 	icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
 ende:
 	ip_rt_put(rt);
-- 
2.39.5




