Return-Path: <stable+bounces-205740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF74CFB20E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 22:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D63F304F516
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 21:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C435F8D0;
	Tue,  6 Jan 2026 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zQ9TgZDG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787035F8B3;
	Tue,  6 Jan 2026 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721702; cv=none; b=awXh3dWL0mr7+N8MDrgzjHc+wKNLqwSQbJTxztfdFZZdr0jvjhGM36UAOKS29noaKP/zDShDok3uiCo+WW3K6engj535q2lGS4v8WdsrljghnWjubbMqWRfJ4Mc4X4BMi7xYIz9cAB3yHi75/xj+luYYUG+0duzRlG6NH88syuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721702; c=relaxed/simple;
	bh=qzl8hK9Qmh3dfkG8ME3O1rmQprQUCW6nbHltUUMaO8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmsmoNMOL6nav9qfoOZd6OAI+/6fP4IMXJV+Lsx/DnGdSYNNrVVGLqHf6WyKhrWOInfuqmf8sIOWT/ZXXW0s5CHXr8CDcizxLIvVvGvDRaeMGz8M/FId0EFF8VMCUIIPvIZa3fnrb0/36LhvOy7vhLi4mPA4hnpdlbuB/fEwWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zQ9TgZDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2D7C116C6;
	Tue,  6 Jan 2026 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721702;
	bh=qzl8hK9Qmh3dfkG8ME3O1rmQprQUCW6nbHltUUMaO8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zQ9TgZDGJtKm1R5JsgmdVIV/AmFzy45R/413VMc3WGuNqjaCLDheEPA+heTsm0g7U
	 yNSPX6nvA12Szsdg0plpNG6K1rR7qABNXeFucEDb3lwV+mueKBPKxFb/LjLblDVZGo
	 11euHiOgy/QR3lU5GPYGHUSRJlCQiBpfWTZ51V3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 046/312] firewire: nosy: Fix dma_free_coherent() size
Date: Tue,  6 Jan 2026 18:02:00 +0100
Message-ID: <20260106170549.523131790@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
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

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit c48c0fd0e19684b6ecdb4108a429e3a4e73f5e21 ]

It looks like the buffer allocated and mapped in add_card() is done
with size RCV_BUFFER_SIZE which is 16 KB and 4KB.

Fixes: 286468210d83 ("firewire: new driver: nosy - IEEE 1394 traffic sniffer")
Co-developed-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Co-developed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20251216165420.38355-2-fourier.thomas@gmail.com
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firewire/nosy.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index ea31ac7ac1ca..e59053738a43 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -36,6 +36,8 @@
 
 static char driver_name[] = KBUILD_MODNAME;
 
+#define RCV_BUFFER_SIZE (16 * 1024)
+
 /* this is the physical layout of a PCL, its size is 128 bytes */
 struct pcl {
 	__le32 next;
@@ -517,16 +519,14 @@ remove_card(struct pci_dev *dev)
 			  lynx->rcv_start_pcl, lynx->rcv_start_pcl_bus);
 	dma_free_coherent(&lynx->pci_device->dev, sizeof(struct pcl),
 			  lynx->rcv_pcl, lynx->rcv_pcl_bus);
-	dma_free_coherent(&lynx->pci_device->dev, PAGE_SIZE, lynx->rcv_buffer,
-			  lynx->rcv_buffer_bus);
+	dma_free_coherent(&lynx->pci_device->dev, RCV_BUFFER_SIZE,
+			  lynx->rcv_buffer, lynx->rcv_buffer_bus);
 
 	iounmap(lynx->registers);
 	pci_disable_device(dev);
 	lynx_put(lynx);
 }
 
-#define RCV_BUFFER_SIZE (16 * 1024)
-
 static int
 add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 {
@@ -680,7 +680,7 @@ add_card(struct pci_dev *dev, const struct pci_device_id *unused)
 		dma_free_coherent(&lynx->pci_device->dev, sizeof(struct pcl),
 				  lynx->rcv_pcl, lynx->rcv_pcl_bus);
 	if (lynx->rcv_buffer)
-		dma_free_coherent(&lynx->pci_device->dev, PAGE_SIZE,
+		dma_free_coherent(&lynx->pci_device->dev, RCV_BUFFER_SIZE,
 				  lynx->rcv_buffer, lynx->rcv_buffer_bus);
 	iounmap(lynx->registers);
 
-- 
2.51.0




