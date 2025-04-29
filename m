Return-Path: <stable+bounces-138972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 185BFAA3D31
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE4A98369F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEF2DFA58;
	Tue, 29 Apr 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgFqcXGF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372F92DFA51;
	Tue, 29 Apr 2025 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970639; cv=none; b=cQIxE656MQG7U7VAJM9Bj5Z6pXEVSOdTl+PYAw8Ep8TGRvNDCXSKsrORBXVp1Inl/Q57W39N90onz/eyQBapc1Kkk+zvI/5pFJL9N8QgNBqo9Uk7jSHerpDGNuImBboJYCp/tjROZPNUpns26X54fJpp2YpIRsAidG3hWbqJL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970639; c=relaxed/simple;
	bh=8hdEBo1yPbuOHBIUaj7dTjiOd65+FI2ULJt2TfWwjZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IlRoIiEadvi7K+/CU+4OZcr/mEKIykeJWnI0KOUfcS6InoaRxbt52RVtHnrzMgAHe6Yc6AQeBbgzhMXl/6qdeL0ace5t7NUIJKNafR5b3dikYPU5myZk+1by6UOl/kPqNiGo0KU9LSHUCkzuFgzusytpPiIvSFQ4o9S9iMMTx6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgFqcXGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AC6C4CEEE;
	Tue, 29 Apr 2025 23:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970639;
	bh=8hdEBo1yPbuOHBIUaj7dTjiOd65+FI2ULJt2TfWwjZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgFqcXGFptUSbfM+hLgh7QugMnlPh39E/N62y1wlKviGfFubwdaX5YOHj4SWQ6+0h
	 O/82te9SG/bIl2CGFnxclbRj2G8QvO2Q/blEcqwpdeSsirsqu2k3UOwCus4bTURf6/
	 wiGnxo8JNy2RL1NNizH6Ag7l1sHZatoQ9lxDkGPxix5NGr59BrAr8NpVQHrHo1TCsd
	 PlbhXfSFWZOWUvI/yvn37+A2pUtswhwoAJxn2k1eYweKTkmANpY4y7iQ8ad8P6SSjn
	 G3LJ17NZgzyS/R9v2FfCLKcy1GnvzGPqVvGd365kPedeNshBsD6x++wyqtnv1YkmCs
	 AlAgvhe7Co2ag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 16/39] mei: vsc: Use struct vsc_tp_packet as vsc-tp tx_buf and rx_buf type
Date: Tue, 29 Apr 2025 19:49:43 -0400
Message-Id: <20250429235006.536648-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f88c0c72ffb014e5eba676ee337c4eb3b1d6a119 ]

vsc_tp.tx_buf and vsc_tp.rx_buf point to a struct vsc_tp_packet, use
the correct type instead of "void *" and use sizeof(*ptr) when allocating
memory for these buffers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Link: https://lore.kernel.org/r/20250318141203.94342-3-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/vsc-tp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 7be1649b19725..40d99ad52210d 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -67,8 +67,8 @@ struct vsc_tp {
 	u32 seq;
 
 	/* command buffer */
-	void *tx_buf;
-	void *rx_buf;
+	struct vsc_tp_packet *tx_buf;
+	struct vsc_tp_packet *rx_buf;
 
 	atomic_t assert_cnt;
 	wait_queue_head_t xfer_wait;
@@ -160,7 +160,7 @@ static int vsc_tp_xfer_helper(struct vsc_tp *tp, struct vsc_tp_packet *pkt,
 {
 	int ret, offset = 0, cpy_len, src_len, dst_len = sizeof(struct vsc_tp_packet);
 	int next_xfer_len = VSC_TP_PACKET_SIZE(pkt) + VSC_TP_XFER_TIMEOUT_BYTES;
-	u8 *src, *crc_src, *rx_buf = tp->rx_buf;
+	u8 *src, *crc_src, *rx_buf = (u8 *)tp->rx_buf;
 	int count_down = VSC_TP_MAX_XFER_COUNT;
 	u32 recv_crc = 0, crc = ~0;
 	struct vsc_tp_packet ack;
@@ -320,7 +320,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 	guard(mutex)(&tp->mutex);
 
 	/* rom xfer is big endian */
-	cpu_to_be32_array(tp->tx_buf, obuf, words);
+	cpu_to_be32_array((u32 *)tp->tx_buf, obuf, words);
 
 	ret = read_poll_timeout(gpiod_get_value_cansleep, ret,
 				!ret, VSC_TP_ROM_XFER_POLL_DELAY_US,
@@ -336,7 +336,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 
 	if (ibuf)
-		be32_to_cpu_array(ibuf, tp->rx_buf, words);
+		be32_to_cpu_array(ibuf, (u32 *)tp->rx_buf, words);
 
 	return ret;
 }
@@ -490,11 +490,11 @@ static int vsc_tp_probe(struct spi_device *spi)
 	if (!tp)
 		return -ENOMEM;
 
-	tp->tx_buf = devm_kzalloc(dev, VSC_TP_MAX_XFER_SIZE, GFP_KERNEL);
+	tp->tx_buf = devm_kzalloc(dev, sizeof(*tp->tx_buf), GFP_KERNEL);
 	if (!tp->tx_buf)
 		return -ENOMEM;
 
-	tp->rx_buf = devm_kzalloc(dev, VSC_TP_MAX_XFER_SIZE, GFP_KERNEL);
+	tp->rx_buf = devm_kzalloc(dev, sizeof(*tp->rx_buf), GFP_KERNEL);
 	if (!tp->rx_buf)
 		return -ENOMEM;
 
-- 
2.39.5


