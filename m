Return-Path: <stable+bounces-200218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E39CAA21D
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 08:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7179430164D3
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B9D2DEA67;
	Sat,  6 Dec 2025 07:05:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D39F9C0;
	Sat,  6 Dec 2025 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765004705; cv=none; b=PdBEIk3bfbmfpjxzCyEML2tSQwMbAjvDSNZHvff967o1yAlIGpgWubsOM1NmDQRoM59TvJnqJA/6kuWPcqR7BKtmuVAInq0c3kIfu5nBsYC2L9+oNd191mzzI00FqPm5Q63/MkqyrXPS/ikMovsy9oVWZ1vLJJCCuPBxXo5X+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765004705; c=relaxed/simple;
	bh=dmEcXohiP6xGoU59qpLmCeCrnU+0GmNhT+tsvnywt5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GyD46BVgsk5Kz233g/q3wTHlnhNbDPvXtQOgHknUeS6LunkbQGoW2NMi/9bbuoUcWrDTRUms+fIVvgA1e3ZXXwaPFp+yjMFv0yGE4+oG9lc0B0GI+VXH0JYl5FVKUxPctpAp7WJzevEAI3YohwAjdQOCqiK4T6F8JNeE9T+6/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-01 (Coremail) with SMTP id qwCowAAnv86T1TNp6+FAAw--.4791S2;
	Sat, 06 Dec 2025 15:04:52 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	rdbabiera@google.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: altmodes/displayport: Drop the device reference in dp_altmode_probe()
Date: Sat,  6 Dec 2025 15:04:45 +0800
Message-Id: <20251206070445.190770-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnv86T1TNp6+FAAw--.4791S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GryxCF13XryxJrW3Zr4rGrg_yoW8JF45pF
	srWFWqyFyUJFZIq3Wxtr42gFW5Was7A3yFg34a9w1Svw13Jw48J345JF9YgF97uFZaqFW5
	try3Kr1akF4kJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUJVWUGwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
	4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBwsHE2kytJhShQABs5

In error paths, call typec_altmode_put_plug() to drop the device reference
obtained by typec_altmode_get_plug().

Fixes: 71ba4fe56656 ("usb: typec: altmodes/displayport: add SOP' support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/usb/typec/altmodes/displayport.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 1dcb77faf85d..5d02c97e256e 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -764,12 +764,16 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
 	      DP_CAP_PIN_ASSIGN_UFP_D(alt->vdo)) &&
 	    !(DP_CAP_PIN_ASSIGN_UFP_D(port->vdo) &
-	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
-		return -ENODEV;
+	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo))) {
+		typec_altmode_put_plug(plug);
+		return -ENODEV;
+	}
 
 	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
-	if (!dp)
+	if (!dp) {
+		typec_altmode_put_plug(plug);
 		return -ENOMEM;
+	}
 
 	INIT_WORK(&dp->work, dp_altmode_work);
 	mutex_init(&dp->lock);
-- 
2.25.1


