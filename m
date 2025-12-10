Return-Path: <stable+bounces-200504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E554CB1B86
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 03:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5F73080ADD
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 02:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2204F26CE2D;
	Wed, 10 Dec 2025 02:33:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965F2686A0;
	Wed, 10 Dec 2025 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765333991; cv=none; b=jB8iSdU0UbEnX0S2GcWmLChFVFCK27MLqZByGgJbxuPPOZidOomAIrUOTuWlhx1c2mAbWTeI4/0uPhxD4FLp1L4YwNmxffFc6EJM7cEK7xiZIF7rFxP1a3QB/Mo8vj/aUcoaNbviFCBdDbhuPhuVBlhpdkrmeVBeS+hTRmlK3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765333991; c=relaxed/simple;
	bh=ag80Eo7W0tTquSre16KVgyzlL2w8cbwSMmdYxHMnsw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jA3tQqjCsOljBch0QwvGmFOSqyrwwMoxyc74PkbpC/b9+moSFABewQeim9oEhxaxfIePrGXh158qJnx5NAO7GD7U5Y38nSRslZfLlr7p2fhjdWSAhe76ZFkibNrB1fUoULf6Jb9jwM/DxDb/Y9qjeKNCxgtMlDYKl1fvl16WE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.239])
	by APP-01 (Coremail) with SMTP id qwCowAD3nmrM2zhpn84nAA--.13800S2;
	Wed, 10 Dec 2025 10:32:46 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lihaoxiang@isrc.iscas.ac.cn,
	izumi.taku@jp.fujitsu.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fjes: Add missing iounmap in fjes_hw_init()
Date: Wed, 10 Dec 2025 10:32:43 +0800
Message-Id: <20251210023243.47945-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3nmrM2zhpn84nAA--.13800S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1xCr43Gr18WF47KF48Zwb_yoWkWrbE9r
	1SgFsrW3WUCr15tF1UCrW3Zry2vF4DWrySg3W7tFWftasxCF9FyryIkFsxX348Xw45Zr93
	A34UXr13Jw13ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiBgoLE2k35laN1wABsh

In error paths, add fjes_hw_iounmap() to release the
resource acquired by fjes_hw_iomap().

Fixes: 8cdc3f6c5d22 ("fjes: Hardware initialization routine")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/net/fjes/fjes_hw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
index b9b5554ea862..a2e89ffa6f70 100644
--- a/drivers/net/fjes/fjes_hw.c
+++ b/drivers/net/fjes/fjes_hw.c
@@ -333,8 +333,10 @@ int fjes_hw_init(struct fjes_hw *hw)
 		return -EIO;
 
 	ret = fjes_hw_reset(hw);
-	if (ret)
+	if (ret) {
+		fjes_hw_iounmap(hw);
 		return ret;
+	}
 
 	fjes_hw_set_irqmask(hw, REG_ICTL_MASK_ALL, true);
 
@@ -347,8 +349,10 @@ int fjes_hw_init(struct fjes_hw *hw)
 	hw->max_epid = fjes_hw_get_max_epid(hw);
 	hw->my_epid = fjes_hw_get_my_epid(hw);
 
-	if ((hw->max_epid == 0) || (hw->my_epid >= hw->max_epid))
+	if ((hw->max_epid == 0) || (hw->my_epid >= hw->max_epid)) {
+		fjes_hw_iounmap(hw);
 		return -ENXIO;
+	}
 
 	ret = fjes_hw_setup(hw);
 
-- 
2.25.1


