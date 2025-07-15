Return-Path: <stable+bounces-162143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E6B05BC4
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDA5165099
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BFD2E3364;
	Tue, 15 Jul 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CSIm7gCk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A02C327B;
	Tue, 15 Jul 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585787; cv=none; b=eLSh7SwFoaUVHR815PzxnoV0oiVxIHQ08DSSq5FmhYDq4zjTbfShURbFhghjxkrw1G71ZIPdUSgjeriNxdOw4rhphwM/t8WEf6qtxikdxBjumaHCt+n6k03GpYuYtYcwMKFRREXFgsR7odloRuso5EziDB1Hqi0yab6t6C8d5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585787; c=relaxed/simple;
	bh=fN9WP7ena3U2SIVe0d4dqdL2K2Cg5cpi4d8PDorwtuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTdbP0MWAqXkjrzEgEw8z49ShjD4k4sKHLB0Brq/4c3RIxmTchaBVgEi0CY+yy9NBk9Th02nLcBdDuZpEE18pdo5q2B2C0zWN4U1E/Q2pFFAKTmRw9lHDMTkpXlXrJ6jZm/EjLx0MzI0ENbFWZOLppyNwVdg8gS3FfDnqr8daWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CSIm7gCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B8FC4CEF7;
	Tue, 15 Jul 2025 13:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585787;
	bh=fN9WP7ena3U2SIVe0d4dqdL2K2Cg5cpi4d8PDorwtuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSIm7gCkTDEUSdIdmyReyVytwbY6xy9NICgy20PfCLmVwlSrE7KtbrzVhgotA8d6c
	 MXpLe6Txt7ln5ltHd16FjMo6/QVfpCq6X5Xk3CfIYDL0RrC5FxJ1oFb8ni5oEQ+WkI
	 Vw8AZUXDkrqavbHop9hTt9g0f0R4Cl3hXAopd1aI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <longli@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 150/163] net: mana: Record doorbell physical address in PF mode
Date: Tue, 15 Jul 2025 15:13:38 +0200
Message-ID: <20250715130814.855295132@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

[ Upstream commit e0fca6f2cebff539e9317a15a37dcf432e3b851a ]

MANA supports RDMA in PF mode. The driver should record the doorbell
physical address when in PF mode.

The doorbell physical address is used by the RDMA driver to map
doorbell pages of the device to user-mode applications through RDMA
verbs interface. In the past, they have been mapped to user-mode while
the device is in VF mode. With the support for PF mode implemented,
also expose those pages in PF mode.

Support for PF mode is implemented in
290e5d3c49f6 ("net: mana: Add support for Multi Vports on Bare metal")

Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/1750210606-12167-1-git-send-email-longli@linuxonhyperv.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 9bac4083d8a09..876de6db63c4f 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -28,6 +28,9 @@ static void mana_gd_init_pf_regs(struct pci_dev *pdev)
 	gc->db_page_base = gc->bar0_va +
 				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
 
+	gc->phys_db_page_base = gc->bar0_pa +
+				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
+
 	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
 
 	sriov_base_va = gc->bar0_va + sriov_base_off;
-- 
2.39.5




