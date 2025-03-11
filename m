Return-Path: <stable+bounces-123532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB7A5C606
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A71189E509
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558225E80B;
	Tue, 11 Mar 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AZ/nj+j8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A161BD00C;
	Tue, 11 Mar 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706226; cv=none; b=KydAM7h49UXV/a7fDsWw1SZqPNkUIIC5LL/zgySe+aetcshKYZ+BErtJOdGwoGmK7DrVoxk+wLOFX8nFrUooWjvY5gdDnXkxHe9904ueJeiONDjMy2p6Uk3apw3NYIynKFAzGPzKM+Ezag578FyNncP3xfqysR0K7qGaXzm33Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706226; c=relaxed/simple;
	bh=O/qvqWSmcL5Ocvbl2k3zg6YZ/PRcNJV3BMZZPun9WDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYSRoXbX3w6kpy/GxTCYyju3D2dTd4T9WU1mceZ9RVjcSYTKE/xxUfMDHqRRLGKK/obB4QYs/jCaF3Q1leJbZz798CbxTARBDpgxzaCI9DXVQ+/7lp4pHANXlx05tcRF18/G74aaxUpLIUgEC56eCms09KV7QWbeVPbL3iD0T8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AZ/nj+j8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A62BC4CEE9;
	Tue, 11 Mar 2025 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706225;
	bh=O/qvqWSmcL5Ocvbl2k3zg6YZ/PRcNJV3BMZZPun9WDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZ/nj+j8ss4+vCZBLonxSqSHx37COAthegmB0uDByVg6TXwAwmLWax8rLUJo6viAz
	 tW/op6HbChwNbFo9O8+4RMYWGi6mu4P3Fsu6z+e6zPJ6de+LiVFcwJcueRcOtEtOu6
	 +vwE7NEsrabluuUEwT2xRXwyPaWMh2Jc7gAHGoeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Mackerras <paulus@samba.org>,
	syzbot+853242d9c9917165d791@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 305/328] ppp: Fix KMSAN uninit-value warning with bpf
Date: Tue, 11 Mar 2025 16:01:15 +0100
Message-ID: <20250311145727.032007164@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 4c2d14c40a68678d885eab4008a0129646805bae ]

Syzbot caught an "KMSAN: uninit-value" warning [1], which is caused by the
ppp driver not initializing a 2-byte header when using socket filter.

The following code can generate a PPP filter BPF program:
'''
struct bpf_program fp;
pcap_t *handle;
handle = pcap_open_dead(DLT_PPP_PPPD, 65535);
pcap_compile(handle, &fp, "ip and outbound", 0, 0);
bpf_dump(&fp, 1);
'''
Its output is:
'''
(000) ldh [2]
(001) jeq #0x21 jt 2 jf 5
(002) ldb [0]
(003) jeq #0x1 jt 4 jf 5
(004) ret #65535
(005) ret #0
'''
Wen can find similar code at the following link:
https://github.com/ppp-project/ppp/blob/master/pppd/options.c#L1680
The maintainer of this code repository is also the original maintainer
of the ppp driver.

As you can see the BPF program skips 2 bytes of data and then reads the
'Protocol' field to determine if it's an IP packet. Then it read the first
byte of the first 2 bytes to determine the direction.

The issue is that only the first byte indicating direction is initialized
in current ppp driver code while the second byte is not initialized.

For normal BPF programs generated by libpcap, uninitialized data won't be
used, so it's not a problem. However, for carefully crafted BPF programs,
such as those generated by syzkaller [2], which start reading from offset
0, the uninitialized data will be used and caught by KMSAN.

[1] https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
[2] https://syzkaller.appspot.com/text?tag=ReproC&x=11994913980000

Cc: Paul Mackerras <paulus@samba.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/000000000000dea025060d6bc3bc@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250228141408.393864-1-jiayuan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ppp/ppp_generic.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 3cd4196b36b21..7b9337e16d6e1 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -72,6 +72,17 @@
 #define PPP_PROTO_LEN	2
 #define PPP_LCP_HDRLEN	4
 
+/* The filter instructions generated by libpcap are constructed
+ * assuming a four-byte PPP header on each packet, where the last
+ * 2 bytes are the protocol field defined in the RFC and the first
+ * byte of the first 2 bytes indicates the direction.
+ * The second byte is currently unused, but we still need to initialize
+ * it to prevent crafted BPF programs from reading them which would
+ * cause reading of uninitialized data.
+ */
+#define PPP_FILTER_OUTBOUND_TAG 0x0100
+#define PPP_FILTER_INBOUND_TAG  0x0000
+
 /*
  * An instance of /dev/ppp can be associated with either a ppp
  * interface unit or a ppp channel.  In both cases, file->private_data
@@ -1541,10 +1552,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 
 	if (proto < 0x8000) {
 #ifdef CONFIG_PPP_FILTER
-		/* check if we should pass this packet */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		/* check if the packet passes the pass and active filters.
+		 * See comment for PPP_FILTER_OUTBOUND_TAG above.
+		 */
+		*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
 		if (ppp->pass_filter &&
 		    BPF_PROG_RUN(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
@@ -2223,14 +2234,13 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 		/* network protocol frame - give it to the kernel */
 
 #ifdef CONFIG_PPP_FILTER
-		/* check if the packet passes the pass and active filters */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
 		if (ppp->pass_filter || ppp->active_filter) {
 			if (skb_unclone(skb, GFP_ATOMIC))
 				goto err;
-
-			*(u8 *)skb_push(skb, 2) = 0;
+			/* Check if the packet passes the pass and active filters.
+			 * See comment for PPP_FILTER_INBOUND_TAG above.
+			 */
+			*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);
 			if (ppp->pass_filter &&
 			    BPF_PROG_RUN(ppp->pass_filter, skb) == 0) {
 				if (ppp->debug & 1)
-- 
2.39.5




