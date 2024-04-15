Return-Path: <stable+bounces-39761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B478A549E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051E01C21EA8
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8117A724;
	Mon, 15 Apr 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V4FlCZah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA217581B;
	Mon, 15 Apr 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191734; cv=none; b=areNmYHgyYkzkU+pE9wkvMEEG222OHrEM/MbGwve5fHrVsn/O783cXKhGpkeMhpw3FKw2R9JqYc56JnuMvOvMCuaJK56d4yzAHvyawIuyuJTzffVQueRfDBMEBs3e0SXB1Up/6ScyG83tX06qYraySlc3JQFwd0L354IaKXN8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191734; c=relaxed/simple;
	bh=SPK31REBAgv5VJGfMsruwgbTQ3egwx+J08SobjRaY0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNk0sAdJOh8/imZkib7de6/CBFziTwHfriPziEoRcKaI1Qgcob70foZVFlcd8OPs8pGjDC3yxAgNdAfOFDNFnBJafRAcXpUJzIxTzz2fk3xkslkz/im8/PrFUyW9zoNzejbgBY15IgoxExo1gAiVprTIt7HbncyoVe8TS57+TE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V4FlCZah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898E3C113CC;
	Mon, 15 Apr 2024 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191733;
	bh=SPK31REBAgv5VJGfMsruwgbTQ3egwx+J08SobjRaY0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4FlCZah4c+b7ubhMvdVS2MfP0UCOQQCea1owlgsozDTcqO0VMgEXmjF/3SQVuOxQ
	 1wy3soRBEd+K7ysmzRvk/wt89QrA8ejhmeIxJQjy8M4B1SuPiVcJZy1aWDf1/pERN1
	 5dPV2b01SKqKYOYsQObWBg4NQCLt37UXfHauOzAs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 068/122] net: ena: Fix potential sign extension issue
Date: Mon, 15 Apr 2024 16:20:33 +0200
Message-ID: <20240415141955.420177717@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit 713a85195aad25d8a26786a37b674e3e5ec09e3c ]

Small unsigned types are promoted to larger signed types in
the case of multiplication, the result of which may overflow.
In case the result of such a multiplication has its MSB
turned on, it will be sign extended with '1's.
This changes the multiplication result.

Code example of the phenomenon:
-------------------------------
u16 x, y;
size_t z1, z2;

x = y = 0xffff;
printk("x=%x y=%x\n",x,y);

z1 = x*y;
z2 = (size_t)x*y;

printk("z1=%lx z2=%lx\n", z1, z2);

Output:
-------
x=ffff y=ffff
z1=fffffffffffe0001 z2=fffe0001

The expected result of ffff*ffff is fffe0001, and without the
explicit casting to avoid the unwanted sign extension we got
fffffffffffe0001.

This commit adds an explicit casting to avoid the sign extension
issue.

Fixes: 689b2bdaaa14 ("net: ena: add functions for handling Low Latency Queues in ena_com")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 633b321d7fdd9..4db689372980e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -362,7 +362,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			ENA_COM_BOUNCE_BUFFER_CNTRL_CNT;
 		io_sq->bounce_buf_ctrl.next_to_use = 0;
 
-		size = io_sq->bounce_buf_ctrl.buffer_size *
+		size = (size_t)io_sq->bounce_buf_ctrl.buffer_size *
 			io_sq->bounce_buf_ctrl.buffers_num;
 
 		dev_node = dev_to_node(ena_dev->dmadev);
-- 
2.43.0




