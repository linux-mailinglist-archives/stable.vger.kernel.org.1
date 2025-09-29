Return-Path: <stable+bounces-181854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 331FBBA7E0B
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 05:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9103D1898BB4
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 03:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAF020B7ED;
	Mon, 29 Sep 2025 03:47:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6FD515;
	Mon, 29 Sep 2025 03:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759117659; cv=none; b=ElfulgAQQ9Cf9MD2USyGxRmtHsdpno/32PSATSgnf8OZiYCqcthz+iolnPJEnxzXwbPV06Hft42BZU/pDULhnliHtoKl0bR7qA406scIMdyUH0qei84z+AjVse7MXONdQcBkgOMMsjlnEIxe0wUXxpftZ+TUtyOegSatao3BPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759117659; c=relaxed/simple;
	bh=98/A/gvh5ZZHq0EdCKQVJZBXC8RCJoc/pSNT9Nc/RpM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aL0iaRXduwMgLQJNTy6ZhdiPZu9MO8N3cUnf2mmbKvDHZkQa5CGUIjt7cIGpXrtRpLnT0wIFYEcPoALrMFO3A7M2t57IhI8DC4VwwcmetFi6M/GlMEGiyCsngxXt2WC21eWUvUL2Y8zQWpG57gC1gNqgWFyvj3FwQrGgK2jUCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAB33RZCAdpo+z+RCA--.20813S2;
	Mon, 29 Sep 2025 11:47:28 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: robh@kernel.org,
	saravanak@google.com,
	lizhi.hou@amd.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] of: unittest: Fix device reference count leak in of_unittest_pci_node_verify
Date: Mon, 29 Sep 2025 11:47:13 +0800
Message-Id: <20250929034713.22867-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAB33RZCAdpo+z+RCA--.20813S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1kKFWxAryxKFW3Zr17GFg_yoW8Gw1kp3
	yUGas09rW8GF47Kw48Zr4UZFy3A342934rGFy8A3WS9wsYq34xtFyUXayjyrs8urWkXF1Y
	yr17tay8CF4UtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8txhDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

In of_unittest_pci_node_verify(), when the add parameter is false,
device_find_any_child() obtains a reference to a child device. This
function implicitly calls get_device() to increment the device's
reference count before returning the pointer. However, the caller
fails to properly release this reference by calling put_device(),
leading to a device reference count leak.

As the comment of device_find_any_child states: "NOTE: you will need
to drop the reference with put_device() after use".

Cc: stable@vger.kernel.org
Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/of/unittest.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e3503ec20f6c..d225e73781fe 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4271,7 +4271,7 @@ static struct platform_driver unittest_pci_driver = {
 static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
 {
 	struct device_node *pnp, *np = NULL;
-	struct device *child_dev;
+	struct device *child_dev = NULL;
 	char *path = NULL;
 	const __be32 *reg;
 	int rc = 0;
@@ -4306,6 +4306,8 @@ static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
 	kfree(path);
 	if (np)
 		of_node_put(np);
+	if (child_dev)
+		put_device(child_dev);
 
 	return rc;
 }
-- 
2.17.1


