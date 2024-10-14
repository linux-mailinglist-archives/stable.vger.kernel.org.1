Return-Path: <stable+bounces-83809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACDE99CAF2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C0B1C23228
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A219CD0E;
	Mon, 14 Oct 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y+LT7EgG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB001AA7A4
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911117; cv=none; b=kj++FAHAXWCZ/YYPo98Wng/pZ0gU1B+9ms5iWMjHPV7+HchLJ6TVBjVbtdeb9kXJLn+pzxdtHD8wlbjjNv5IxcPtluCTWbrERWLwOmZNRVctPHma2NzPTjmUiW8ULsv/nGwciV5QgPcwqO/CXLCmvf+6mqdWm6tZnMzV4gOYLWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911117; c=relaxed/simple;
	bh=Ew3ooGXbh5MoT3azC3zAubDXmwgRe2cxfH5pKOMKV4M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uYdoNjRI4G53V2m46UhbhC5CU5O8QjKihF3alaqIEQh3FAhzEi4QI0k891z2xvC9uZGky4La2IYhS4f0sQ6Va7xqOrZTnWAGOdbDTGXt9bs4uNvVnx/2RRlZU6pJUwxcU4jp3g9Bw0Y9bmcnI0SbD2c9e26OqbJewBr6oGc9kVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y+LT7EgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E49C4CEC3;
	Mon, 14 Oct 2024 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728911116;
	bh=Ew3ooGXbh5MoT3azC3zAubDXmwgRe2cxfH5pKOMKV4M=;
	h=Subject:To:Cc:From:Date:From;
	b=y+LT7EgGgm5VP3tNmBzj8sXlZ3EQL3PpsaI6PPp3VQyq7u4MBAZ32uuL1+SeDkNlK
	 u6YOhNx93FyVAHmP/rUnKPQSb6AReXwynBDpWc2zazteFZmFq7pTsIbbZJlsaeNQ+D
	 kgyCZOwzp7GlAOJoR/MfX/M/EzjR0ilhjyNvYoRs=
Subject: FAILED: patch "[PATCH] net: ethernet: cortina: Restore TSO support" failed to apply to 4.19-stable tree
To: linus.walleij@linaro.org,davem@davemloft.net,edumazet@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 15:05:06 +0200
Message-ID: <2024101406-matted-figure-a255@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 2942dfab630444d46aaa37fb7d629b620abbf6ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101406-matted-figure-a255@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

2942dfab6304 ("net: ethernet: cortina: Restore TSO support")
ac631873c9e7 ("net: ethernet: cortina: Drop TSO support")
d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2942dfab630444d46aaa37fb7d629b620abbf6ba Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 21:26:44 +0200
Subject: [PATCH] net: ethernet: cortina: Restore TSO support

An earlier commit deleted the TSO support in the Cortina Gemini
driver because the driver was confusing gso_size and MTU,
probably because what the Linux kernel calls "gso_size" was
called "MTU" in the datasheet.

Restore the functionality properly reading the gso_size from
the skbuff.

Tested with iperf3, running a server on a different machine
and client on the device with the cortina gemini ethernet:

Connecting to host 192.168.1.2, port 5201
60008000.ethernet-port eth0: segment offloading mss = 05ea len=1c8a
60008000.ethernet-port eth0: segment offloading mss = 05ea len=1c8a
60008000.ethernet-port eth0: segment offloading mss = 05ea len=27da
60008000.ethernet-port eth0: segment offloading mss = 05ea len=0b92
60008000.ethernet-port eth0: segment offloading mss = 05ea len=2bda
(...)

(The hardware MSS 0x05ea here includes the ethernet headers.)

If I disable all segment offloading on the receiving host and
dump packets using tcpdump -xx like this:

ethtool -K enp2s0 gro off gso off tso off
tcpdump -xx -i enp2s0 host 192.168.1.136

I get segmented packages such as this when running iperf3:

23:16:54.024139 IP OpenWrt.lan.59168 > Fecusia.targus-getdata1:
Flags [.], seq 1486:2934, ack 1, win 4198,
options [nop,nop,TS val 3886192908 ecr 3601341877], length 1448
0x0000:  fc34 9701 a0c6 14d6 4da8 3c4f 0800 4500
0x0010:  05dc 16a0 4000 4006 9aa1 c0a8 0188 c0a8
0x0020:  0102 e720 1451 ff25 9822 4c52 29cf 8010
0x0030:  1066 ac8c 0000 0101 080a e7a2 990c d6a8
(...)
0x05c0:  5e49 e109 fe8c 4617 5e18 7a82 7eae d647
0x05d0:  e8ee ae64 dc88 c897 3f8a 07a4 3a33 6b1b
0x05e0:  3501 a30f 2758 cc44 4b4a

Several such packets often follow after each other verifying
the segmentation into 0x05a8 (1448) byte packages also on the
reveiving end. As can be seen, the ethernet frames are
0x05ea (1514) in size.

Performance with iperf3 before this patch: ~15.5 Mbit/s
Performance with iperf3 after this patch: ~175 Mbit/s

This was running a 60 second test (twice) the best measurement
was 179 Mbit/s.

For comparison if I run iperf3 with UDP I get around 1.05 Mbit/s
both before and after this patch.

While this is a gigabit ethernet interface, the CPU is a cheap
D-Link DIR-685 router (based on the ARMv5 Faraday FA526 at
~50 MHz), and the software is not supposed to drive traffic,
as the device has a DSA chip, so this kind of numbers can be
expected.

Fixes: ac631873c9e7 ("net: ethernet: cortina: Drop TSO support")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5f0c9e1771db..7ebd61a3a49b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -79,7 +79,8 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
 
 #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
-			       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
+			       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
+			       NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
 
 /**
  * struct gmac_queue_page - page buffer per-page info
@@ -1148,13 +1149,25 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
 	void *buffer;
+	u16 mss;
 	int ret;
 
-	/* TODO: implement proper TSO using MTU in word3 */
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
-	if (skb->len >= ETH_FRAME_LEN) {
+	mss = skb_shinfo(skb)->gso_size;
+	if (mss) {
+		/* This means we are dealing with TCP and skb->len is the
+		 * sum total of all the segments. The TSO will deal with
+		 * chopping this up for us.
+		 */
+		/* The accelerator needs the full frame size here */
+		mss += skb_tcp_all_headers(skb);
+		netdev_dbg(netdev, "segment offloading mss = %04x len=%04x\n",
+			   mss, skb->len);
+		word1 |= TSS_MTU_ENABLE_BIT;
+		word3 |= mss;
+	} else if (skb->len >= ETH_FRAME_LEN) {
 		/* Hardware offloaded checksumming isn't working on frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
 		 * checksum buffer is only 1518 bytes, so when the frames get
@@ -1169,7 +1182,9 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 				return ret;
 		}
 		word1 |= TSS_BYPASS_BIT;
-	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+	}
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
 		/* We do not switch off the checksumming on non TCP/UDP


