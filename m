Return-Path: <stable+bounces-182052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8927ABABFA9
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 10:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365D13C6CD6
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D12F3631;
	Tue, 30 Sep 2025 08:16:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CE419343B;
	Tue, 30 Sep 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220200; cv=none; b=lmjt6LsTBb4xdhSgQcyem4buHQiFkix7UUhsoB5uwQMT6Wh+ZsfU1hOVzjU4HiPLNRFcRsSuOFEOWqpXNtFs2Y/T7195w32kWR5stiniJjcgAi44bpAr/bJGvxuiyNVCwL/ATq209I9iu74J00gS/9qlwqw5nyR26rdqEgz8DkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220200; c=relaxed/simple;
	bh=V5wuETQcgvIF648FSp/qiHyosW7aBRE9KR160cw0vcU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lE0tLqFA9v24WP6NjZbiAqgzfWLAo5ymUJy+2Qw75xu04ocYIdsJDKf56nukRYfaVEjKJR7PNxXUZAO+dl+w5HTC7kajwNm/FtP65SxnbYvZ1G2Q6Wx0axpLvcjtckzLTGNxtWyR9Aa/oP/aO9BFxoUr5U3JcwUg97OJxb+box4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAAHpg_Ukdto_09DCQ--.10836S2;
	Tue, 30 Sep 2025 16:16:28 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: robh@kernel.org,
	saravanak@google.com,
	lizhi.hou@amd.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] of: unittest: Fix device reference count leak in of_unittest_pci_node_verify
Date: Tue, 30 Sep 2025 16:16:18 +0800
Message-Id: <20250930081618.794-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAAHpg_Ukdto_09DCQ--.10836S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1kKFWxAry3JryxuryUWrg_yoW8GFy5pw
	47Kas0vrWkGa17Kw4jvF1xZFy5C3y2k3yrGFyxA3WI9395Z34xtryUtayUtrn8ZrWkXFs0
	q3W7tay0kF4UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU0tCzDUUUU
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
leading to a device reference count leak. Add put_device() in the else
branch immediately after child_dev is no longer needed.

As the comment of device_find_any_child states: "NOTE: you will need
to drop the reference with put_device() after use".

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the put_device() location as suggestions.
---
 drivers/of/unittest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e3503ec20f6c..388e9ec2cccf 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4300,6 +4300,7 @@ static int of_unittest_pci_node_verify(struct pci_dev *pdev, bool add)
 		unittest(!np, "Child device tree node is not removed\n");
 		child_dev = device_find_any_child(&pdev->dev);
 		unittest(!child_dev, "Child device is not removed\n");
+		put_device(child_dev);
 	}
 
 failed:
-- 
2.17.1


