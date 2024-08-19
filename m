Return-Path: <stable+bounces-69463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B062A956640
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E281F22EEF
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BE515B966;
	Mon, 19 Aug 2024 09:04:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D46B4C8F;
	Mon, 19 Aug 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058265; cv=none; b=WIyPtlefK44fdw2TyA+zIIPo2Lgw39/wpiWor4i/2aGoDFNUg1OF0780UMDK6ih16HuFOPpB9tYMiCu12xTWh7XyDDqxIiuz8e/bflMj4OCB9fgW44Odd781ghhrGLSJg6b8dKVOcR7rYibKHIqgJLFTjI9P48Bsdq9yWeiEekY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058265; c=relaxed/simple;
	bh=xTVcQrxxfosSm/0YHPLcGuf5tQDE5+4P8KTE8UqLPoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oP1pNA81GWMDWmbSVwcuB8FAsTLInkymABjq1duUCfq4CplwxN7yp3cZuvfRLiOvylNK4Vq9ylcRob8Hx3H/7MtJH+9wbD3iUDh15KUypLQJ/6KsDSmyE1jQUPhX99BGmRyfy3ejxD3Bnto/0+4Z+e99hXqHhQ5dSB7xq63U3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAA3XQCGCsNmoSsTCA--.43971S2;
	Mon, 19 Aug 2024 17:04:13 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: make24@iscas.ac.cn,
	nico@fluxnic.net,
	will@kernel.org,
	suzuki.poulose@arm.com,
	punitagrawal@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm-cci: Fix refcount leak in cci_probe
Date: Mon, 19 Aug 2024 17:04:05 +0800
Message-Id: <20240819090405.1014759-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3XQCGCsNmoSsTCA--.43971S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWUWrWDGr4rZFWUuFWruFg_yoWxCrg_Cr
	4fXryfJryDuF1DWw1avwnxur9Yv395WF1kXF47ta4fK347Ar1rJr18urZ3WF1xZr47tryD
	C3yDJryIkr4UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUp7KsUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Add the missing of_node_put() to release the refcount incremented
by of_find_matching_node().

Cc: stable@vger.kernel.org
Fixes: f6b9e83ce05e ("arm-cci: Rearrange code for splitting PMU vs driver code")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/bus/arm-cci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..6be7b05b5ff1 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -548,6 +548,7 @@ static int cci_probe(void)
 	}
 	if (ret || !cci_ctrl_base) {
 		WARN(1, "unable to ioremap CCI ctrl\n");
+		of_node_put(np);
 		return -ENXIO;
 	}
 
-- 
2.25.1


