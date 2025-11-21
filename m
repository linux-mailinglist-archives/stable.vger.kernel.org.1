Return-Path: <stable+bounces-196532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0BC7AF04
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1114E4EF22E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB062F12C4;
	Fri, 21 Nov 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr8pjvgb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866732ED85D;
	Fri, 21 Nov 2025 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743616; cv=none; b=ETiuOBJmNg24vr7mh+lWB4wkVQV7KnY57bTK+CudZLUPw++x8qMRUvG/S/hg/WmCG/9IX0ar0tJ/Khym5AmkuL+SRx9kKNL1+uFt+g3ioFjVFBCT+JzAEDl6xO2RiqXEslTWqdINqZPOFoUnLC8lNzv71y9cA+iYKCMeaI108CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743616; c=relaxed/simple;
	bh=aVXKgdTVNhP4i1JEeKXE3HxQU0vhsNU0tGwaDb1blrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UndW+7p3BOsBArVQo+tYiwCJi+lffiW0DURLm7Mo4G0hUVWyieBg5HeUZSDml311hsLbBXLl/YpssFJaidz/IB5yGDlJvx+Kvc1+/lg1qIWWmsFmPV8DBYO7JNizSbybUx/qvlIs2Ey5vuwgLeJX80/hYVkzVh89HcCMJFgXYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr8pjvgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDD0C19423;
	Fri, 21 Nov 2025 16:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763743616;
	bh=aVXKgdTVNhP4i1JEeKXE3HxQU0vhsNU0tGwaDb1blrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qr8pjvgbJKyX+UYd1vALWtKcUgng2r7Ve+VX31NpsgJabslvrLauyETtqlG0UyCa5
	 jxvsmL0VuOkP2BygUIdUNZd5fTsUNOdY6yflBydRC6jPbw7989NQAtjEylSWS/azR3
	 2Hj1IWc5XolMGho93lE4u2ylW59JttAhOl9+P/RyctCbO/bnwA0E3+a3I3KuDfAoaa
	 631aTYoWsQ9IvLZrBa5A+hwLFpBn4l+rpOgo5rWEHd3SSRDApE1jK6rwreiBbTCpmZ
	 QirtBglGPAqF5fi+jb4NRoqPdpNLbSIr+KAmRGm44rsZ/OgvcCMq9DPDosPCWBIG7T
	 wsxIou3k6L9Mw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMUHh-000000003ZR-28Kr;
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
Subject: [PATCH 2/3] memory: mtk-smi: fix device leak on larb probe
Date: Fri, 21 Nov 2025 17:46:23 +0100
Message-ID: <20251121164624.13685-3-johan@kernel.org>
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
during larb probe on late probe failure (e.g. probe deferral) and on
driver unbind.

Fixes: cc8bbe1a8312 ("memory: mediatek: Add SMI driver")
Fixes: 038ae37c510f ("memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common")
Cc: stable@vger.kernel.org	# 4.6: 038ae37c510f
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/memory/mtk-smi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index dd6150d200e8..3609bfd3c64b 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -685,6 +685,7 @@ static void mtk_smi_larb_remove(struct platform_device *pdev)
 	device_link_remove(&pdev->dev, larb->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
 	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
+	put_device(larb->smi_common_dev);
 }
 
 static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
-- 
2.51.2


