Return-Path: <stable+bounces-202563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02613CC32EE
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA996309BE2A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB94387B3A;
	Tue, 16 Dec 2025 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TKeqwA3E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B34387B33;
	Tue, 16 Dec 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888301; cv=none; b=WEct1AbWTNNlcoERNis49q4ilpWzWIG08qBDRvx0Xh5k4MwXC0/V5ZLnxAzwlvIR9a2E+YVwxK5evwG6xrGLFBcABvPTpuBj4nohoyJ6puDMj2DKUFGEgwLTY3UZrBa5aRXUcppHEgvfG8OVxX40m2Qzo9WDmoIZ4w2LDDklTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888301; c=relaxed/simple;
	bh=Z4wgdNoXJyvfK+hcdLvGbV6cKKJUX++da331BF1zwn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIdBigMxUAV8vb6bJyHDDMp73qK1Eb7P4pvATXAd3yJzak0OnnrKfx5OsDfYt4ofMo8ReCG8a0T0cfln9GjfD/peaUIL3A8+0d9vZzHr3YFpxAw8lYiEpsiqD5ErbrKJdqhOcmrmKJ4OfYwYPhgiBil5O3ivS1SDANi5fbW0r2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TKeqwA3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BE0C4CEF1;
	Tue, 16 Dec 2025 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765888301;
	bh=Z4wgdNoXJyvfK+hcdLvGbV6cKKJUX++da331BF1zwn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKeqwA3EmdllwVPpFiU52QdL2hBwwO0A/b94m61+Gn85mEPdQudGKaJvRfkd7whmD
	 kVyxvbjBtPXMwyPtDfKlbtaBiymDTphD5beNFXofkOx2R5+9AcaeMxaXDq9zBHKkup
	 m3MaPPMA7RVW6SJgt2x5DIBbFr1FsJFBhPcJeuPk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 460/614] virtio: fix typo in virtio_device_ready() comment
Date: Tue, 16 Dec 2025 12:13:47 +0100
Message-ID: <20251216111418.036124213@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

[ Upstream commit 361173f95ae4b726ebbbf0bd594274f5576c4abc ]

"coherenct" -> "coherent"

Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
Message-Id: <db286e9a65449347f6584e68c9960fd5ded2b4b0.1763026134.git.mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/virtio_config.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 16001e9f9b391..1ea5baa62141f 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -362,7 +362,7 @@ void virtio_device_ready(struct virtio_device *dev)
 	 * specific set_status() method.
 	 *
 	 * A well behaved device will only notify a virtqueue after
-	 * DRIVER_OK, this means the device should "see" the coherenct
+	 * DRIVER_OK, this means the device should "see" the coherent
 	 * memory write that set vq->broken as false which is done by
 	 * the driver when it sees DRIVER_OK, then the following
 	 * driver's vring_interrupt() will see vq->broken as false so
-- 
2.51.0




