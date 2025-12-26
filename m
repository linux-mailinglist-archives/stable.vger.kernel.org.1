Return-Path: <stable+bounces-203413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D2CDE503
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 05:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F119300B9AA
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 04:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB7C1917F0;
	Fri, 26 Dec 2025 04:17:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDB4414;
	Fri, 26 Dec 2025 04:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766722649; cv=none; b=T/3Q2Gu/ivoH0XzGD4HVe3bfuWzxN/BKeBdLwV86ECEqDTYWowvRDr2LbEl0mHctTFKCnaPgW9aVnqPHNu1GjW2DMp71UoGQvl7BFZEt7+6XtZNHIew0/TYPFrlBxvmmbgsnoAJhdIsX+OKSn5Mzf68dVbInLwXC3Q1YMOpTPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766722649; c=relaxed/simple;
	bh=Pogo4etnkPqNpaamNBBLM12DtD0IXYYjfZAsBoD7QDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G3prhi9SgqT1MVRkGkehbqw2jEGehNHSUovLS8DBtCVYNEZ4MaYl0CBB7P4ca8EWl+GBafei3A31s0/df91h8ubUJ0oMv78l8xiS7NohT4YiVoRm4IOuf3MMV7bltOceGEAbFce3THABhfSs15UNFinht+Cl4k9CWSUJGnAoCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowAAnzWhNDE5psCHdAQ--.33559S2;
	Fri, 26 Dec 2025 12:17:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: rockchip: inno-usb2: Fix a double free bug in rockchip_usb2phy_probe()
Date: Fri, 26 Dec 2025 04:17:11 +0000
Message-Id: <20251226041711.2369638-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnzWhNDE5psCHdAQ--.33559S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18KF15Wr15Wry3Jr43Jrb_yoW8GrW8pa
	yDCrWDtrW8Kay8Wr1qyrn8ZFsYyayDt3yxGFZ2k3WfZ3Zxtw1DZa4fuFyUursxJFW8ZFsx
	Jrs8ta4UAF43Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26rkl6F8dMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFylc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjTRAPEfUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgIA2lN4TqlYQAAs0

The for_each_available_child_of_node() calls of_node_put() to
release child_np in each success loop. After breaking from the
loop with the child_np has been released, the code will jump to
the put_child label and will call the of_node_put() again if the
devm_request_threaded_irq() fails. These cause a double free bug.

Fix by using a separate label to avoid the duplicate of_node_put().

Fixes: ed2b5a8e6b98 ("phy: phy-rockchip-inno-usb2: support muxed interrupts")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index b0f23690ec30..f754c3b1c357 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1491,7 +1491,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 						rphy);
 		if (ret) {
 			dev_err_probe(rphy->dev, ret, "failed to request usb2phy irq handle\n");
-			goto put_child;
+			goto ret_error;
 		}
 	}
 
@@ -1499,6 +1499,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 put_child:
 	of_node_put(child_np);
+ret_error:
 	return ret;
 }
 
-- 
2.34.1


