Return-Path: <stable+bounces-161823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6E0B03AA6
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F028189AFE5
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7822723F41F;
	Mon, 14 Jul 2025 09:20:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37610A1E;
	Mon, 14 Jul 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484832; cv=none; b=KqlA07g6ao5YJ28XE8U81zolTCn/p6PgOBlkbKwn3qeRPFplpU6k8YRcgmby//SbNQnAlVfjGP77xQeywciIEtxtdjyxjyMxhD1X1vGh5XTkCmNHxyXJuTPlYKkNRhTy5HbMDBul28bLxS6/6uVxlfwc1VWe1bk/g9U3L/vBark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484832; c=relaxed/simple;
	bh=L7BcJGw5ym6qPfgaTER92wS3T7ZHpzuHID6PqQyX3Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KiIiWc37y0pUBU6mc2W5ee7Kh1pdoTzHKYYkutgqI9m2sKIUAB66YpFh/zRr290IWa0RHwdCW+jjxB6Vqt126ZV5TpubWjcpeOcxH5miOO09dlyG0q2aYzIgHhZieS73T2R76w08IJHbRQMs+01v9eTbAlupTN050J8Wjh7mLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [211.71.28.34])
	by APP-03 (Coremail) with SMTP id rQCowAD3h3kTy3RotjvpAw--.2702S2;
	Mon, 14 Jul 2025 17:17:10 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	zijun.hu@oss.qualcomm.com,
	fabio.m.de.francesco@linux.intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] cxl/region: Balance device refcount when destroying devices
Date: Mon, 14 Jul 2025 17:16:54 +0800
Message-Id: <20250714091654.3206432-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3h3kTy3RotjvpAw--.2702S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF18Kr1fXF4kZr4DZF4fXwb_yoW8GrWkp3
	yUCFWUuryrCF109rnxZayUZry5uFWDuayrurW8J34Fg3s5J3y0yrWUA3Z0gF17A392qF1U
	ZrnFyF18CayUW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYPEfUUUU
	U
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Using device_find_child() to lookup the proper device to destroy
causes an unbalance in device refcount, since device_find_child()
calls an implicit get_device() to increment the device's reference
count before returning the pointer. cxl_port_find_switch_decoder()
directly converts this pointer to a cxl_decoder and returns it without
releasing the reference properly. We should call put_device() to
decrement reference count.

As comment of device_find_child() says, 'NOTE: you will need to drop
the reference with put_device() after use'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: d6879d8cfb81 ("cxl/region: Add function to find a port's switch decoder by range")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..cae16d761261 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3234,6 +3234,9 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
 	struct device *cxld_dev = device_find_child(&port->dev, hpa,
 						    match_decoder_by_range);
 
+	/* Drop the refcnt bumped implicitly by device_find_child */
+	put_device(cxld_dev);
+
 	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
 }
 
-- 
2.25.1


