Return-Path: <stable+bounces-189140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE6C020EF
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDF03A8582
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9F334370;
	Thu, 23 Oct 2025 15:06:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E907332913;
	Thu, 23 Oct 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232016; cv=none; b=A/G8UTL30rQu+MXbyxI93W9JMd+MyYvzQoIUhX2MEBNTNyx975mjDIVr/TlmqeuwtbUPCv+cnI/bmpRlwdrfEPxUKMeWgH/Lge/8mKowX10D98ah0jGXSK0kdja4z/qMxblgv90FiShzQwiJBlv68W122wOfFx77X4nySBSHxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232016; c=relaxed/simple;
	bh=lppIrAl7qoh560wA9LABUDYJWVSAM2ZH2IPsCuoFf0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuFJ0nIO7R4Oa/KDdAzDXoonkF9g93Fyq7z8SWFPG4YmZJ+129uxf31OgvelH5+zA5hLEycqBcq3XR4NLedFJPy11B1viGujPZOeeMyecMA89vI1DwEpoyS+IUQ2k+JYwBzgoewlYEEMUfP3u58c59tF0znvCuBk1keonkutpgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAne519RPpoxY0dFQ--.12488S2;
	Thu, 23 Oct 2025 23:06:42 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: ioana.ciornei@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: fix device reference leak in fsl_mc_device_lookup()
Date: Thu, 23 Oct 2025 23:05:58 +0800
Message-ID: <20251023150558.890-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAne519RPpoxY0dFQ--.12488S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyrtr48WF1kZFyDXFWfuFg_yoW8JF43pF
	4UXa45ZFWqgrZrCwn7ZF40ka4Yya12y34rGryIy3sa9r95Jr90qr95JryYg3WUXrZ5WF12
	qr9Iya4ru3W8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYEA2j6RD0AxQAAsj

The device_find_child() function calls the get_device() and returns a
device reference that must be properly released when no longer needed.
The fsl_mc_device_lookup() directly returns without releasing the
reference via put_device().

Add the missing put_device() call to prevent reference leaks.

Fixes: f2f2726b62f5 ("staging: fsl-mc: Device driver for FSL-MC DPRC devices")
Cc: stable@vger.kernel.org # v4.1+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/bus/fsl-mc/dprc-driver.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index c63a7e688db6..e92c75cef90c 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -124,11 +124,17 @@ struct fsl_mc_device *fsl_mc_device_lookup(struct fsl_mc_obj_desc *obj_desc,
 					   struct fsl_mc_device *mc_bus_dev)
 {
 	struct device *dev;
+	struct fsl_mc_device *mc_dev;
 
 	dev = device_find_child(&mc_bus_dev->dev, obj_desc,
 				__fsl_mc_device_match);
+	if (!dev)
+		return NULL;
+
+	mc_dev = to_fsl_mc_device(dev);
+	put_device(dev);
 
-	return dev ? to_fsl_mc_device(dev) : NULL;
+	return mc_dev;
 }
 
 /**
-- 
2.42.0.windows.2


