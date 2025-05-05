Return-Path: <stable+bounces-140087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C76AAA4F2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E76D3A5CC0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C740128DF3B;
	Mon,  5 May 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIiG3Vn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2528DF34;
	Mon,  5 May 2025 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484082; cv=none; b=Q0DWRWqACzPW4UUPNcpxECQZpNtqEetzNLGLyimiNc/hP9aMs4CIkR441wLtkfnxj6+A5KphJtmRHpqKsQb//+4Rr6W5YqT8/7dk8KX5wqhEUS0rSSItf1w7Bkfm/jV03wb4ofxmNGomlrAv+2/h+mq/1EbBxOaQ1FSsJRdyN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484082; c=relaxed/simple;
	bh=GpP7fij2MVDiTOiIkQApfI57N4DJxLmRdJ3y3rhZlkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ewa8KE3nsathpCmCImdKe5S5+HI/WTBVB3LeqJ7DYNvxYAigczN+77ziY9CXjcMO26hmMTpWqXNnYNT3e93IpkrzK6t2KeCtaBcaac18TlLOzRY7jWl2tr8zv0Reo8xyiRL9oMl+ZVH9HrC3qIv+8QC2IhuBiHbCXn76TZBChJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIiG3Vn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA231C4CEEF;
	Mon,  5 May 2025 22:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484082;
	bh=GpP7fij2MVDiTOiIkQApfI57N4DJxLmRdJ3y3rhZlkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIiG3Vn8d5I6YUY8TfSmJki89nUBvin+UJ0s9hkcTA0AxQaBWq+ebjGYyMRuEPMF/
	 iWurS665XCRYZiVi3mGxaDCosPhv0az9ctuy32gjcox/tR5xy1kVC/X9MUgh1ElmiX
	 SriAUdphuz0P0NUCmVg0QUVtz9MxU+YDdcsRNQuE3gmLnNQA5c8z4uGzmQojgyuSz4
	 EQLooGrVRaBvGGMMUAw+nThN06OmQOeKAfqTQy5J8916262QYVxfAS3zgCx/Yg5N4J
	 QizhdnMpF/hPPA84TY5sJw/nb07g8WI3HDIXao8VobRHXePZTCQ5Zozl6Bpsj99JFK
	 2xLXuDkZR/U+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Eric Auger <eauger@redhat.com>,
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 340/642] virtio: break and reset virtio devices on device_shutdown()
Date: Mon,  5 May 2025 18:09:16 -0400
Message-Id: <20250505221419.2672473-340-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit 8bd2fa086a04886798b505f28db4002525895203 ]

Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
accesses during the hang.

	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
	...

It was traced down to virtio-console. Kexec works fine if virtio-console
is not in use.

The issue is that virtio-console continues to write to the MMIO even after
underlying virtio-pci device is reset.

Additionally, Eric noticed that IOMMUs are reset before devices, if
devices are not reset on shutdown they continue to poke at guest memory
and get errors from the IOMMU. Some devices get wedged then.

The problem can be solved by breaking all virtio devices on virtio
bus shutdown, then resetting them.

Reported-by: Eric Auger <eauger@redhat.com>
Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Message-ID: <c1dbc7dbad9b445245d3348f19e6742b0be07347.1740094946.git.mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index ba37665188b51..150753c3b5782 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -395,6 +395,34 @@ static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
 	return dev->config->get_vq_affinity(dev, irq_vec);
 }
 
+static void virtio_dev_shutdown(struct device *_d)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	/*
+	 * Stop accesses to or from the device.
+	 * We only need to do it if there's a driver - no accesses otherwise.
+	 */
+	if (!drv)
+		return;
+
+	/*
+	 * Some devices get wedged if you kick them after they are
+	 * reset. Mark all vqs as broken to make sure we don't.
+	 */
+	virtio_break_device(dev);
+	/*
+	 * Guarantee that any callback will see vq->broken as true.
+	 */
+	virtio_synchronize_cbs(dev);
+	/*
+	 * As IOMMUs are reset on shutdown, this will block device access to memory.
+	 * Some devices get wedged if this happens, so reset to make sure it does not.
+	 */
+	dev->config->reset(dev);
+}
+
 static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -403,6 +431,7 @@ static const struct bus_type virtio_bus = {
 	.probe = virtio_dev_probe,
 	.remove = virtio_dev_remove,
 	.irq_get_affinity = virtio_irq_get_affinity,
+	.shutdown = virtio_dev_shutdown,
 };
 
 int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
-- 
2.39.5


