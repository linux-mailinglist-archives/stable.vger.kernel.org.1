Return-Path: <stable+bounces-181422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6564CB93E44
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 03:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F43E3B503C
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D67253F3A;
	Tue, 23 Sep 2025 01:37:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758323A98E;
	Tue, 23 Sep 2025 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591428; cv=none; b=mqWP2ouuNX6YoFlh2GOHjqQ2XYm/1v1m7EePvVxtVsjP+gD2s7DMl6IiCSoadRRHA6LnjB4pYz1t/UIs1kTrwe9yc1bJqocFxXior6nGINOurSzblfcscltcnvH6l0MHXaALUSgBWaHKL4gfjrwcLmA4d1aNHzGGfZMllpnddcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591428; c=relaxed/simple;
	bh=h72PRuXb+5YDJqBFUXpma8t7W0H7b3KGo9y9VyMi1b4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QqYZcLg4cieyBA1p2YkOU1vv2gcA715KmqC7T2/dON64YMM+4Xd0rUCBOAHLtSBEr+Glfh50XiuleJQqXFgKRrUzMBa5XY5ehJKMudxYayfq1PKlDlg/eqUgIDv0iz8Vf+Oi07FUrd9l+qlGQfXD6ALgu/oA4T9mAgs8qdx5WX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowADH24WE+dFoYA9aBA--.14812S2;
	Tue, 23 Sep 2025 09:36:14 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	matchstick@neverthere.org,
	dominik.karol.piatkowski@protonmail.com,
	arnd@arndb.de,
	paul.retourne@orange.fr,
	dan.carpenter@linaro.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] staging: gpib: Fix device reference leak in fmh_gpib driver
Date: Tue, 23 Sep 2025 09:36:03 +0800
Message-Id: <20250923013603.30012-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowADH24WE+dFoYA9aBA--.14812S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4UWw17KF4rAw1rJr1xAFb_yoW8GFWUpF
	4rW3WUGryUurs3WF4UX34DZFWYka1Iyryruw18A345XFs5ZrySgF1qgrW5J3s0yrZ7Jr1j
	yF1fGw1vgFWDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmQ6LU
	UUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The fmh_gpib driver contains a device reference count leak in
fmh_gpib_attach_impl() where driver_find_device() increases the
reference count of the device by get_device() when matching but this
reference is not properly decreased. Add put_device() in
fmh_gpib_detach(), which ensures that the reference count of the
device is correctly managed.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- deleted the redundant put_device() to avoid double free as suggestions;
Changes in v2:
- modified the free operations as suggestions. Thanks for dan carpenter's instructions.
---
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 4138f3d2bae7..efce01b39b9b 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -1517,6 +1517,11 @@ void fmh_gpib_detach(struct gpib_board *board)
 					   resource_size(e_priv->gpib_iomem_res));
 	}
 	fmh_gpib_generic_detach(board);
+
+	if (board->dev) {
+		put_device(board->dev);
+		board->dev = NULL;
+	}
 }
 
 static int fmh_gpib_pci_attach_impl(struct gpib_board *board,
-- 
2.17.1


