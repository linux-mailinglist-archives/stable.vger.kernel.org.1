Return-Path: <stable+bounces-142163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694C3AAE953
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D805E7BB369
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C81228B7D6;
	Wed,  7 May 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ugVvsI+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CE114A4C7;
	Wed,  7 May 2025 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643407; cv=none; b=O+7jH8ixROA0Ste8sq/Tr92NjYRmhGhFrkhFjopDai6PSqb6aH0e8SL1OdKRgzfshaPSPmf7VQHN2IqaB3HybHOyE0AjkoaPU07j4zfaJFOVEa3Tf5rrBmzV9eoPVSQnQ8DeonlcNF+etaJh57PxvQfXL/GkgxHtAjNaOX/UL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643407; c=relaxed/simple;
	bh=BygBvMjnd/thE0vCUYW/znt46lxIJ274cl/7BzDoGY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRKD/w209dLnCdhP2PV80CnT5rl8yZomTSzXfcXX+btuWuTrpuPwecPVJ96z6qzkRphLdFE/df2fjCh+WHDJP2r25/yuuLl4df+Ibwl8QXUsiIciVDc+K00lYq9leXJVcMawjoiJg7CGSlNjD7Nl0lDltW56O2eAjtEVLa60yM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ugVvsI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957D9C4CEE2;
	Wed,  7 May 2025 18:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643407;
	bh=BygBvMjnd/thE0vCUYW/znt46lxIJ274cl/7BzDoGY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ugVvsI+rSiQlaYW0gAAkTDVE1/aMCfls1PYMQHpy1p++zcH7tNrdJcK8ezqxc4Uy
	 SPNuluo7mWr2td9CP8ElESLFKXiqs5utMRatP0pBfin/n/LbQ/kChLcEBbf6dzqUI+
	 A5LsUwcqZJDAyipgC12cRDskW8VDNwBEcnP+Bowc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 49/55] irqchip/gic-v2m: Add const to of_device_id
Date: Wed,  7 May 2025 20:39:50 +0200
Message-ID: <20250507183801.020417502@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183759.048732653@linuxfoundation.org>
References: <20250507183759.048732653@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang wangx <wangxiang@cdjrlc.com>

[ Upstream commit c10f2f8b5d8027c1ea77f777f2d16cb9043a6c09 ]

struct of_device_id should normally be const.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211209132453.25623-1-wangxiang@cdjrlc.com
Stable-dep-of: 3318dc299b07 ("irqchip/gic-v2m: Prevent use after free of gicv2m_get_fwnode()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-gic-v2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 0e57c60681aab..48e2eed33f8fa 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -405,7 +405,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	return ret;
 }
 
-static struct of_device_id gicv2m_device_id[] = {
+static const struct of_device_id gicv2m_device_id[] = {
 	{	.compatible	= "arm,gic-v2m-frame",	},
 	{},
 };
-- 
2.39.5




