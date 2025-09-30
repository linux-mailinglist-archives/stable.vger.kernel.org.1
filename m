Return-Path: <stable+bounces-182188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DAEBAD596
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 16:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104F8194203A
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619CE304BA2;
	Tue, 30 Sep 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yMWqLve9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D8303C9B;
	Tue, 30 Sep 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244131; cv=none; b=rrwzEx7nX8dYYoBsMyH3i289xopEc3ndAprmuL1pApudTxrGY8fEhRXo2gK1hsUDqm4LyS2Ucm6sQ7Pm2QSEDjUZoyDJZn0zQAfIXyq+CTSZQt/1tlpF16qqj+xAN/YCI2dV2XxZd+LV/ZUUBVAl0nFuJy+6f3cXKpLHf9+Sfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244131; c=relaxed/simple;
	bh=PFDixMgRNTBoRKdf90jsgivYjUUDz4tVIzLjScuA5xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKz7aW+7mneq4+tufzq+q6JW6XPx7AUs8GbvhdIFZHYkv9OiGs0gvzLYOphyHUYpN7WjcmCdGjyf4yzOD1/QmXXMMDCUjSghKlc3DlnLSgP3pKT7PfOQ8IK3PgVj8BOKqXcyBmaLsjsp26jlwAotl5kmKMgty4YY7H9dIbsHljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yMWqLve9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB15C113D0;
	Tue, 30 Sep 2025 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244131;
	bh=PFDixMgRNTBoRKdf90jsgivYjUUDz4tVIzLjScuA5xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yMWqLve9SLMFim5rJ3m2DBJTNJgZt/S5XV1GTteEpJ3ZMu/maG1IPMAjqzdxutBKh
	 YDKVMZYtxnM3R84SZO208ceufdTP9W8ZuvPyLiPmm6HEhpzIGhS8AFFr1VbNg/Z2ng
	 pTnx75wjZ93rRri5T7rpo1OWWPjCLEuOPPmj4DcE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nitesh Narayan Lal <nitesh@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 036/122] i40e: Use irq_update_affinity_hint()
Date: Tue, 30 Sep 2025 16:46:07 +0200
Message-ID: <20250930143824.481972219@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
References: <20250930143822.939301999@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nitesh Narayan Lal <nitesh@redhat.com>

[ Upstream commit d34c54d1739c2cdf2e4437b74e6da269147f4987 ]

The driver uses irq_set_affinity_hint() for two purposes:

 - To set the affinity_hint which is consumed by the userspace for
   distributing the interrupts

 - To apply an affinity that it provides for the i40e interrupts

The latter is done to ensure that all the interrupts are evenly spread
across all available CPUs. However, since commit a0c9259dc4e1 ("irq/matrix:
Spread interrupts on allocation") the spreading of interrupts is
dynamically performed at the time of allocation. Hence, there is no need
for the drivers to enforce their own affinity for the spreading of
interrupts.

Also, irq_set_affinity_hint() applying the provided cpumask as an affinity
for the interrupt is an undocumented side effect. To remove this side
effect irq_set_affinity_hint() has been marked as deprecated and new
interfaces have been introduced. Hence, replace the irq_set_affinity_hint()
with the new interface irq_update_affinity_hint() that only sets the
pointer for the affinity_hint.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Link: https://lore.kernel.org/r/20210903152430.244937-4-nitesh@redhat.com
Stable-dep-of: 915470e1b44e ("i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index aa24d1808c981..0b0f6bf5affe0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3969,10 +3969,10 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		 *
 		 * get_cpu_mask returns a static constant mask with
 		 * a permanent lifetime so it's ok to pass to
-		 * irq_set_affinity_hint without making a copy.
+		 * irq_update_affinity_hint without making a copy.
 		 */
 		cpu = cpumask_local_spread(q_vector->v_idx, -1);
-		irq_set_affinity_hint(irq_num, get_cpu_mask(cpu));
+		irq_update_affinity_hint(irq_num, get_cpu_mask(cpu));
 	}
 
 	vsi->irqs_ready = true;
@@ -3983,7 +3983,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		vector--;
 		irq_num = pf->msix_entries[base + vector].vector;
 		irq_set_affinity_notifier(irq_num, NULL);
-		irq_set_affinity_hint(irq_num, NULL);
+		irq_update_affinity_hint(irq_num, NULL);
 		free_irq(irq_num, &vsi->q_vectors[vector]);
 	}
 	return err;
@@ -4801,7 +4801,7 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
 			/* clear the affinity notifier in the IRQ descriptor */
 			irq_set_affinity_notifier(irq_num, NULL);
 			/* remove our suggested affinity mask for this IRQ */
-			irq_set_affinity_hint(irq_num, NULL);
+			irq_update_affinity_hint(irq_num, NULL);
 			synchronize_irq(irq_num);
 			free_irq(irq_num, vsi->q_vectors[i]);
 
-- 
2.51.0




