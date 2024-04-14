Return-Path: <stable+bounces-39383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0E8A42A9
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 15:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814291F2125B
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 13:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFB328DB;
	Sun, 14 Apr 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wEhhii0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB943AD1
	for <stable@vger.kernel.org>; Sun, 14 Apr 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713101785; cv=none; b=oWayHUCUR/rWJu92zFYywLRi2KdI87I4M3b7Q9YH21enXgccYiq2mkBrF0NE4d2gyVEKJTaS3ucq4qbrPMv9Ec1Q7wSOYKJkYZzvyPEiZ8mt/EudOul7+JhdgocyArRGJQoVTo3TJD2LHjRXaag6ACSuOsh+Sm5xRyQH1vz1kbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713101785; c=relaxed/simple;
	bh=SeVLaIXHt7Gct99lrWg4xxTbXV7IbAep785OQLA2jBQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f6BAgjDqZ/C2oZGFCPWR7m+Gm/5VyzeNF362tpFPsbOURE85P8T6xEPk/TsbMeo9OGYvj3cRDgqUHAH1JN3pIym4IDX0+LUAhhpMxkGlSrOpONvxcsOMkojqhvEyVdWVGGNo5BCY/UjSniNYwLVt61tg0AUE2aDNUTAnhFcn3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wEhhii0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC7FC072AA;
	Sun, 14 Apr 2024 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713101785;
	bh=SeVLaIXHt7Gct99lrWg4xxTbXV7IbAep785OQLA2jBQ=;
	h=Subject:To:Cc:From:Date:From;
	b=wEhhii0H1aBguyDx8QgwUYli3LVWxpJDMkiSM+B6LhTBiJa9aUnz9LE0/g1D1zWlA
	 ZEnOX3KHvjv9OCPPwdCFm1RtqSVHvPg+TSvDqEmizrwjbhMoMo1WKc1kUzSJ0/Y/yw
	 9Iq/EbEII2/axvNtJPeiaDUXg+Dcu5fnw30vp+H4=
Subject: FAILED: patch "[PATCH] virtio_net: Do not send RSS key if it is not supported" failed to apply to 6.1-stable tree
To: leitao@debian.org,davem@davemloft.net,hengqi@linux.alibaba.com,xuanzhuo@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Apr 2024 15:36:14 +0200
Message-ID: <2024041414-humming-alarm-eb41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 059a49aa2e25c58f90b50151f109dd3c4cdb3a47
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041414-humming-alarm-eb41@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

059a49aa2e25 ("virtio_net: Do not send RSS key if it is not supported")
fb6e30a72539 ("net: ethtool: pass a pointer to parameters to get/set_rxfh ethtool ops")
02cbfba1add5 ("idpf: add ethtool callbacks")
a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
3a8845af66ed ("idpf: add RX splitq napi poll support")
c2d548cad150 ("idpf: add TX splitq napi poll support")
6818c4d5b3c2 ("idpf: add splitq start_xmit")
d4d558718266 ("idpf: initialize interrupts and enable vport")
95af467d9a4e ("idpf: configure resources for RX queues")
1c325aac10a8 ("idpf: configure resources for TX queues")
ce1b75d0635c ("idpf: add ptypes and MAC filter support")
0fe45467a104 ("idpf: add create vport and netdev configuration")
4930fbf419a7 ("idpf: add core init and interrupt request")
8077c727561a ("idpf: add controlq init and reset checks")
e850efed5e15 ("idpf: add module register and probe functionality")
b9335a757232 ("net/mlx5e: Make flow classification filters static")
4cab498f33f7 ("hv_netvsc: Allocate rx indirection table size dynamically")
4f3ed1293feb ("ixgbe: Allow flow hash to be set via ethtool")
2b30f8291a30 ("net: ethtool: add support for MAC Merge layer")
8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 059a49aa2e25c58f90b50151f109dd3c4cdb3a47 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Wed, 3 Apr 2024 08:43:12 -0700
Subject: [PATCH] virtio_net: Do not send RSS key if it is not supported

There is a bug when setting the RSS options in virtio_net that can break
the whole machine, getting the kernel into an infinite loop.

Running the following command in any QEMU virtual machine with virtionet
will reproduce this problem:

    # ethtool -X eth0  hfunc toeplitz

This is how the problem happens:

1) ethtool_set_rxfh() calls virtnet_set_rxfh()

2) virtnet_set_rxfh() calls virtnet_commit_rss_command()

3) virtnet_commit_rss_command() populates 4 entries for the rss
scatter-gather

4) Since the command above does not have a key, then the last
scatter-gatter entry will be zeroed, since rss_key_size == 0.
sg_buf_size = vi->rss_key_size;

5) This buffer is passed to qemu, but qemu is not happy with a buffer
with zero length, and do the following in virtqueue_map_desc() (QEMU
function):

  if (!sz) {
      virtio_error(vdev, "virtio: zero sized buffers are not allowed");

6) virtio_error() (also QEMU function) set the device as broken

    vdev->broken = true;

7) Qemu bails out, and do not repond this crazy kernel.

8) The kernel is waiting for the response to come back (function
virtnet_send_command())

9) The kernel is waiting doing the following :

      while (!virtqueue_get_buf(vi->cvq, &tmp) &&
	     !virtqueue_is_broken(vi->cvq))
	      cpu_relax();

10) None of the following functions above is true, thus, the kernel
loops here forever. Keeping in mind that virtqueue_is_broken() does
not look at the qemu `vdev->broken`, so, it never realizes that the
vitio is broken at QEMU side.

Fix it by not sending RSS commands if the feature is not available in
the device.

Fixes: c7114b1249fa ("drivers/net/virtio_net: Added basic RSS support.")
Cc: stable@vger.kernel.org
Cc: qemu-devel@nongnu.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..115c3c5414f2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3807,6 +3807,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			    struct netlink_ext_ack *extack)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
@@ -3814,13 +3815,28 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	if (rxfh->indir) {
+		if (!vi->has_rss)
+			return -EOPNOTSUPP;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+		update = true;
 	}
-	if (rxfh->key)
-		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
 
-	virtnet_commit_rss_command(vi);
+	if (rxfh->key) {
+		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
+		 * device provides hash calculation capabilities, that is,
+		 * hash_key is configured.
+		 */
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EOPNOTSUPP;
+
+		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		update = true;
+	}
+
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -4729,13 +4745,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
-	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+	}
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 


