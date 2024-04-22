Return-Path: <stable+bounces-40382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438D88AD073
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD3F1F218BF
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F37A1534E2;
	Mon, 22 Apr 2024 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElRNR3hV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD617153505
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799090; cv=none; b=MjhUrSI9HwYBDnNjZ1+aEOoqc1/w4RYSHht/L8LfKtDQoEAmsr0DCwM73A5KCFBiOF1Ohn8cFenLpeLmB23eq2nfG+CyRQMt4x17KJ5E0zL68aU9U7wC1c/Pbv0WvG3fZS5kHgrQTmpIxAIYo8wnMTdOq9VTGytJqpyilwTXq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799090; c=relaxed/simple;
	bh=egAKcaQhm4QwS4uKVQDr57jjtMoFh1CKVEFLITqf4YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frreXTNpyf5O/wYQjl1c6hd5kX5V953dbHEAY5KB9mlcofxkG9HsxYYZorYqK635nu2KLM4RVdweVlPiKOyEHVxp6y+Ua/CcQpJiAdUsfnV965yzax4ZyutCKsjCW+y3fKu4rUiZjXmwNAMWMsf/gHKXoPM+b//nUr6T8mW/bKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElRNR3hV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so1561711a12.3
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713799086; x=1714403886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9xj7HwmwuIRzsMLAZWeyWIJzUgtPFLJ8hFtN2pvdUw=;
        b=ElRNR3hVUEOMSXIsCS0BdIUjbBxXt0hkzEsxhbsb85bOB224owjRLDCmFTt2rO3xQf
         c6Uyw8jFyoxr4JEqYYr0TKeZUL3QTVlXohXmDxW03wllHzrBR9diTREz0iIoTEO+5zmQ
         HUNgx3nln8MXxIVTMjAJIkjKkWq8QJtSnm5qenKM9u5mcvf5ICebAdjqtMeq6GN5nbae
         MutVwT5wyw0rWBEYsH94S37/Z4XNaQQgqKeG+BdeNX2/rusrS9zomPqnDsy0LZaTWg34
         H1t+wHgOm6tSipCVDOncx9IWO/xTsZkRQmnaI1q+2sHRELBK7URziVi/H/+wMYdadQdv
         gO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799086; x=1714403886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9xj7HwmwuIRzsMLAZWeyWIJzUgtPFLJ8hFtN2pvdUw=;
        b=HGVrva07xrrWnFaeGMo3MNbJm5mNgkrbXjFQVTMIB6XuX9mO1j1HuutBiIC1HLr/Op
         LOnbGoStAEcuekTus909yPp07EAe3jGOQx2+rlahdDvynjk7HlBbK3H/UxoNCs5Jj9QA
         aVaol5ej8l2891QnFGVh4a9E5oBivr8Mwj7yUjGMCzaOy1zVj+udkxM+PnGJTLeHuDJa
         UJhfCgrQZaZd6gEfXHL8s0mYFKloXABWN9rOrE5cWwYIMxYtdVUKThT45HoPwAPfLbE4
         5OoTPik2vUNvM+6ej6zk1+pMpEvCEDIn5Xtva+GYPF7JKeoQ9cHFoodODUGHJIyIgHks
         IYCA==
X-Gm-Message-State: AOJu0YwP6oiWCZnvnu5GfZWWMdva+pYyxOEZsRid+HdB4LXbcPt2tyY5
	c4GzCFylb1HXS3Ryx4lqoP/dZA3la9yBZnSpDjX6O8HPVcq69Vuyqfxs7BeBaJI=
X-Google-Smtp-Source: AGHT+IE0xIZcSiuCSsz7uHwpkq02z/02QgEoSLowEQ4mDuOxo6EQH/+kgcM7JeLLwXtgGDXeB3sn2Q==
X-Received: by 2002:a05:6402:524c:b0:572:1574:2b88 with SMTP id t12-20020a056402524c00b0057215742b88mr1242248edd.40.1713799086256;
        Mon, 22 Apr 2024 08:18:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id p8-20020a05640243c800b00571fad0647csm2411769edc.74.2024.04.22.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:18:05 -0700 (PDT)
From: Vlad Poenaru <vlad.wing@gmail.com>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	qemu-devel@nongnu.org,
	Heng Qi <hengqi@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 6.6.y] virtio_net: Do not send RSS key if it is not supported
Date: Mon, 22 Apr 2024 08:18:03 -0700
Message-ID: <20240422151803.1266071-1-vlad.wing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024041412-subduing-brewing-cd04@gregkh>
References: <2024041412-subduing-brewing-cd04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

commit 059a49aa2e25c58f90b50151f109dd3c4cdb3a47 upstream.

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
Signed-off-by: Vlad Poenaru <vlad.wing@gmail.com>
---
 drivers/net/virtio_net.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7cb0548d17a3..56cbe00126bb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3570,19 +3570,34 @@ static int virtnet_get_rxfh(struct net_device *dev, u32 *indir, u8 *key, u8 *hfu
 static int virtnet_set_rxfh(struct net_device *dev, const u32 *indir, const u8 *key, const u8 hfunc)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
 	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
 	if (indir) {
+		if (!vi->has_rss)
+			return -EOPNOTSUPP;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = indir[i];
+		update = true;
 	}
-	if (key)
+	if (key) {
+		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
+		 * device provides hash calculation capabilities, that is,
+		 * hash_key is configured.
+		 */
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EOPNOTSUPP;
+
 		memcpy(vi->ctrl->rss.key, key, vi->rss_key_size);
+		update = true;
+	}
 
-	virtnet_commit_rss_command(vi);
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -4491,13 +4506,15 @@ static int virtnet_probe(struct virtio_device *vdev)
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
 
-- 
2.43.0


