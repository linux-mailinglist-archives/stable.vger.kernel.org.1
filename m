Return-Path: <stable+bounces-196531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05AC7AF01
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCB754EE8DF
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA2C2F066D;
	Fri, 21 Nov 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvM81oRw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455302BEC2C;
	Fri, 21 Nov 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743616; cv=none; b=Ltu6VQCCiyHUE0h5s5dPZ+9M3CeE1+N3qbiIQ0ORPmuaUuud78FJXVRxNHD9Nfw5priD1lxkVdE8eb5I9YxvEm3fa22QhmvmcOjNfiz84XzKoa3JAGoEGGx1OQNuVNEdFLLw5boj0CCSo3BZBnGhPxtERF9RmDAowx6Owx0sUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743616; c=relaxed/simple;
	bh=wO5VidB/EAiJ5mwgeHjepeP6B+fU37Eas6aRn/dc7+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk/Z1whLMBBNA35baNKYwl9o3xS9DoDxcrdQv77qxrtHtrhMGhmGtGFvxIj2WAuK36SameLoWiVecVSrl+FcZ7fEyvfcZxXpvW2pyz1kx4rSGvdNiN/bbiMVyWlSGuEqw59/B9cLUhswn991Pkc26KvX80NsgI1vgIqD1TzZOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvM81oRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11331C4CEF1;
	Fri, 21 Nov 2025 16:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763743616;
	bh=wO5VidB/EAiJ5mwgeHjepeP6B+fU37Eas6aRn/dc7+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvM81oRwBZs+8ChD+xZR2nlor0dXwHrqQLLJTpxNfLs3bnDuBM7cgYdbVWlDobb4B
	 gmE1d2bpmRqsrhzh6P89iYbcV5G1xg+DYuumFvaOcDqNODbb5f+Z7T3zJkuZR+ce1B
	 flETduggsY/NU/jgFADtijKayf4OVC9Qy7Aa8h1phVlK3FyeCNvoptEcRs+XlYiydK
	 hzwpJ+SWfNMVuLzmB9hrFhCfwkll1LACgVB+cFsxzAV2/oymkzSpf5FhQN/CLPTy0j
	 FBhMfUEy7U+G6WVEh56qdJW5FVtWehvRbSo6r6KaaHNmi6zBYyJekaeNOI0baWBRp4
	 PB/Ixrpyd+wbw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMUHh-000000003ZP-1idI;
	Fri, 21 Nov 2025 17:46:57 +0100
From: Johan Hovold <johan@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH 1/3] memory: mtk-smi: fix device leaks on common probe
Date: Fri, 21 Nov 2025 17:46:22 +0100
Message-ID: <20251121164624.13685-2-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121164624.13685-1-johan@kernel.org>
References: <20251121164624.13685-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference taken when looking up the SMI device
during common probe on late probe failure (e.g. probe deferral) and on
driver unbind.

Fixes: 47404757702e ("memory: mtk-smi: Add device link for smi-sub-common")
Fixes: 038ae37c510f ("memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common")
Cc: stable@vger.kernel.org	# 5.16: 038ae37c510f
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/memory/mtk-smi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 733e22f695ab..dd6150d200e8 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -674,6 +674,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(dev);
 	device_link_remove(dev, larb->smi_common_dev);
+	put_device(larb->smi_common_dev);
 	return ret;
 }
 
@@ -917,6 +918,7 @@ static void mtk_smi_common_remove(struct platform_device *pdev)
 	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
 		device_link_remove(&pdev->dev, common->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
+	put_device(common->smi_common_dev);
 }
 
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
-- 
2.51.2


