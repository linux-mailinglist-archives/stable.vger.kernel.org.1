Return-Path: <stable+bounces-151934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB88AD12D2
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638091655FC
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C6E24DFF1;
	Sun,  8 Jun 2025 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XmoTs7uZ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EA378C9C;
	Sun,  8 Jun 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749394968; cv=none; b=BmO4TGWZUGce4RcPMWl1gNZ2NA9vTO5X5XmBC8cQHOp1RWBk6unsRIMmlWOWVUhpHBSfk8uZGupHSBN8+1/X4s9pgJzS5tfGbdL4tnPR77a3m+oWreSy0hOHkUtVHiYbbGMrvJcvr4kkqd/8Pc3fxLMfAwqonznB/eizjkTjrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749394968; c=relaxed/simple;
	bh=5ki4Suw7Y/kqfH3heJcBTTyb40st4/AvL2pWY4Fr3Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nkXRHR+sTVsizSEQO+RlinEmHb1pnkukft4oIBu0NwRYqubyEDWAI4Yz1P4Oxr1/yi9MHrgslm8t/uT76bgsftt8k6e1D2CCG0K2uQRY/z8stlyQbn1m+HoNCJPX+OMySpaylTyagO3+dEWa0i/yi87Mh7fsHiJPloFv2ehH3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XmoTs7uZ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=JBaLlBHHoYS3cZOCIh/U3xTKIcpHZAiK9qfb5paTjnQ=;
	b=XmoTs7uZzgYhDbqCXy+Esuqp36lsk6HHRSXgNanybDJNeXJWhcJea6OU9Wz/a0
	OV93wq+usCcITbm5PZRtgz+6iH716EDMHRbtWb3EY5DMXLjH5xU7NWVL7ItUpqa/
	0/oUX8YViol7RuPHI+W3lO1s5lJLvCzo1JYB3GmdsifF0=
Received: from gnu.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC38+tiokVo5N0GHA--.23029S2;
	Sun, 08 Jun 2025 22:46:59 +0800 (CST)
From: moyuanhao3676@163.com
To: edumazet@google.com,
	kuniyu@amazon.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	MoYuanhao <moyuanhao3676@163.com>
Subject: [PATCH] net: core: fix UNIX-STREAM alignment in /proc/net/protocols
Date: Sun,  8 Jun 2025 22:46:52 +0800
Message-Id: <20250608144652.27079-1-moyuanhao3676@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC38+tiokVo5N0GHA--.23029S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr15AF45WrW8ArW3Kw17Wrg_yoWrWr4xpr
	1UGr15Xw1UAr1UArnxJF1j9r15Jw1UJrW3Gwn5Cr1rJwn0qFyjyr17Xr1UXFy5ArnFgwn7
	ur13Jryjyw47XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRHv3UUUUUU=
X-CM-SenderInfo: 5pr13t5qkd0jqwxwqiywtou0bp/1tbioBFmfmhFmFC1kwAAsq

From: MoYuanhao <moyuanhao3676@163.com>

Widen protocol name column from %-9s to %-11s to properly display
UNIX-STREAM and keep table alignment.

before modification：
console:/ # cat /proc/net/protocols
protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
PPPOL2TP   920      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
HIDP       808      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
BNEP       808      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
RFCOMM     840      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
KEY        864      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
PACKET    1536      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
PINGv6    1184      0      -1   NI       0   yes  kernel      y  y  y  n  n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
RAWv6     1184      0      -1   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
UDPLITEv6 1344      0       0   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
UDPv6     1344      0       0   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
TCPv6     2352      0       0   no     320   yes  kernel      y  y  y  y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
PPTP       920      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
PPPOE      920      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
UNIX-STREAM 1024     29      -1   NI       0   yes  kernel      y  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  y  n  n
UNIX      1024    193      -1   NI       0   yes  kernel      y  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
UDP-Lite  1152      0       0   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
PING       976      0      -1   NI       0   yes  kernel      y  y  y  n  n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
RAW        984      0      -1   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
UDP       1152      0       0   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
TCP       2192      0       0   no     320   yes  kernel      y  y  y  y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
SCO        848      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
L2CAP      824      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
HCI        888      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
NETLINK   1104     18      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n

after modification:
console:/ # cat /proc/net/protocols
protocol    size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
PPPOL2TP     920      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
HIDP         808      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
BNEP         808      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
RFCOMM       840      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
KEY          864      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
PACKET      1536      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
PINGv6      1184      0      -1   NI       0   yes  kernel      y  y  y  n  n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
RAWv6       1184      0      -1   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
UDPLITEv6   1344      0       0   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
UDPv6       1344      0       0   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
TCPv6       2352      0       0   no     320   yes  kernel      y  y  y  y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
PPTP         920      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
PPPOE        920      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
UNIX-STREAM 1024     29      -1   NI       0   yes  kernel      y  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  y  n  n
UNIX        1024    193      -1   NI       0   yes  kernel      y  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
UDP-Lite    1152      0       0   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
PING         976      0      -1   NI       0   yes  kernel      y  y  y  n  n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
RAW          984      0      -1   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
UDP         1152      0       0   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
TCP         2192      0       0   no     320   yes  kernel      y  y  y  y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
SCO          848      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
L2CAP        824      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
HCI          888      0      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
NETLINK     1104     18      -1   NI       0   no   kernel      n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 3b409bc8ef6d..d2de5459e94f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4284,7 +4284,7 @@ static const char *sock_prot_memory_pressure(struct proto *proto)
 static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 {
 
-	seq_printf(seq, "%-9s %4u %6d  %6ld   %-3s %6u   %-3s  %-10s "
+	seq_printf(seq, "%-11s %4u %6d  %6ld   %-3s %6u   %-3s  %-10s "
 			"%2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c %2c\n",
 		   proto->name,
 		   proto->obj_size,
@@ -4317,7 +4317,7 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 static int proto_seq_show(struct seq_file *seq, void *v)
 {
 	if (v == &proto_list)
-		seq_printf(seq, "%-9s %-4s %-8s %-6s %-5s %-7s %-4s %-10s %s",
+		seq_printf(seq, "%-11s %-4s %-8s %-6s %-5s %-7s %-4s %-10s %s",
 			   "protocol",
 			   "size",
 			   "sockets",
-- 
2.34.1


