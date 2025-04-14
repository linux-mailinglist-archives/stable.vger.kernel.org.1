Return-Path: <stable+bounces-132400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED475A8783D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 08:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A42D3AC7DB
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 06:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808931B041E;
	Mon, 14 Apr 2025 06:53:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414AE1A2630;
	Mon, 14 Apr 2025 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613601; cv=none; b=pORU94RQZI/XX4edE871aZ+c2p1ZSGk8UO1W8mqIi/cODtWVbsJFhDOpnPdMg1LL1ltdsYq+WnD8h0zDjBzbZdYCOUDzwpDNCIqcr6sE1nXg7bs+H6vZ2IK8mQUfRTd56v+HkJpmVyAeADZkDn/dn68uPvugUIeIGlKWK9CFE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613601; c=relaxed/simple;
	bh=Af1+AkpqfX2f2V8L9uHzFX6RQOHRce6SCz0W2kXUOSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GgWDHQ8ysjTXq/L1AIDr7SgOUo+JyDeUQDPaFFl6e8vxK9C0z5PH2Fw+85YaSJg5xYgfmPYgzLxVM39I/+can5WR/eDdij7GDan6aCYYPqQWx2dd2ncdNWCLFKk4ANrg5TwdlukqjR2NGB4JIt8cw5pYmWxcchiH7XVwmR9Q8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABHhQ3WsPxnNSvmCA--.18873S2;
	Mon, 14 Apr 2025 14:53:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: obitton@habana.ai,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] habanalabs: Add error handling for hl_mmu_get_hop_pte_phys_addr()
Date: Mon, 14 Apr 2025 14:52:42 +0800
Message-ID: <20250414065242.2150-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHhQ3WsPxnNSvmCA--.18873S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4Uuw18JF4Duw15Kr47CFg_yoW8GryfpF
	n3Kr4rXFy5Jr1UZayUtr1IvF1Yv39xWFy3K3ZFka9093s8X3s7u343W3WSvw4UArWkGan7
	Zw1kAFs8CF18ZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUb9N3UUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoMA2f8nOlFygAAsj

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


