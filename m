Return-Path: <stable+bounces-127308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0481A77804
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 11:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6AA16A4D6
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B1F1EF375;
	Tue,  1 Apr 2025 09:44:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C01EB1A7;
	Tue,  1 Apr 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500686; cv=none; b=bg73S1GTi/X0aJhtfoseXDR8LM435c/n06k1ALqpPqUt1jyUgVjrNIGFXb3L4bigj/0AHXlCLAR1vNdJsAOTqEYEsdtCg40FeE3HUL+Rkz4CND18E2VDek/dBEI6xeas6WzV6QqHdtX3iq7NCGoNdi0o5pJs7M7hXaef6QkjANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500686; c=relaxed/simple;
	bh=Af1+AkpqfX2f2V8L9uHzFX6RQOHRce6SCz0W2kXUOSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FB54+JLfuny62Wh8ZFlQOREniNHSSeF9u7IUFlCo/ywcTPsFpGckIDoXReMaylyOsiglxr8a5QC8+WRLjl+iELIaEA99K2Ky5SXVuxKlGe5lUS4Sy8KC1Kn310YoxJAuIG0awAWMFqg6uSIkgucj9Uao3xiLvKTvioU3BrytVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADnjv+DtetnAd2vBA--.1435S2;
	Tue, 01 Apr 2025 17:44:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: obitton@habana.ai,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] habanalabs: Add error handling for hl_mmu_get_hop_pte_phys_addr()
Date: Tue,  1 Apr 2025 17:44:13 +0800
Message-ID: <20250401094413.2401-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnjv+DtetnAd2vBA--.1435S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4Uuw18JF4Duw15Kr47CFg_yoW8GryfpF
	n3Kr4rXFy5Jr1UZayUtr1IvF1Yv39xWFy3K3ZFka9093s8X3s7u343W3WSvw4UArWkGan7
	Zw1kAFs8CF18ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0TA2frlYJ04QABsU

In _hl_mmu_v2_hr_map(), If hl_mmu_get_hop_pte_phys_addr() fail to
get physical address, the return address will be set as U64_MAX.
Hence, the return value of hl_mmu_get_hop_pte_phys_addr() must
be checked to prevent invalid address access. Add error handling
and propagate return code to caller function to fix this issue.

Fixes: 8aa1e1e60553 ("habanalabs: add gaudi2 MMU support")
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c b/drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c
index 31507b2a431b..cdade07e22c5 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu_v2_hr.c
@@ -253,6 +253,11 @@ static int _hl_mmu_v2_hr_map(struct hl_ctx *ctx,
 		hop_pte_phys_addr[i] = hl_mmu_get_hop_pte_phys_addr(ctx, mmu_prop, i,
 									hops_pgt_info[i]->phys_addr,
 									scrambled_virt_addr);
+		if (hop_pte_phys_addr[i] == U64_MAX) {
+			rc = -EINVAL;
+			goto err;
+		}
+
 		curr_pte = *(u64 *) (uintptr_t) hl_mmu_hr_pte_phys_to_virt(ctx, hops_pgt_info[i],
 							hop_pte_phys_addr[i],
 							ctx->hdev->asic_prop.pmmu.hop_table_size);
-- 
2.42.0.windows.2


