Return-Path: <stable+bounces-168558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63549B23561
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6905D561C58
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA49A2FDC55;
	Tue, 12 Aug 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISbQ3El9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422F2C21F6;
	Tue, 12 Aug 2025 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024573; cv=none; b=Fe7Bk57/zOlMswv/lQLmvES6cz84dE09zn8M0c7RTmBYa8Vm9HCQFHvM00VNkbKvmxZVjgxHFK+ExuL7+UxcIQEGU+T82pDOMnTH54kahMqOwhVX/VxKUb4IykWWEy9mf4G6RnfxZbEgSxFXGgOAhHRLbsj1HmXbMn3QETbl00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024573; c=relaxed/simple;
	bh=0M77PLtZjd5xtxBRnvCdRbghTbwLvNTBOBRXY77xLxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiXWSroCVUJHRd48jVDiTMJ87Rc0pRTmNSvpbkcaXiZ2gkfDbn+lRJ1ydjRTLdj4NRh97XtjBaxQcD494vS6irhPlg/Kp7znN9Bkf5PR4aj7umq2jQqQaVsp4HdQNqoXG7O8SII9rrp1BB9gnFS68OfJ6BqRHUBq9zlxI4EJFEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISbQ3El9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061DAC4CEF0;
	Tue, 12 Aug 2025 18:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755024573;
	bh=0M77PLtZjd5xtxBRnvCdRbghTbwLvNTBOBRXY77xLxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISbQ3El9cjmCP/+UqtJDBlIsapj/Aj1FwMHcxDzhuuQukglholAb+sxgh28z9AhVl
	 xTpVh8I5jHg6uU6FvkYEYkcE8NKfhhjDSHTFeG5ytdNjHa+SV3bHknFmafJraoWHXg
	 AxHK2zkrSB3mwLGYhk1gqNP0gbflXY2nxyjA/agA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tanmay Shah <tanmay.shah@amd.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 412/627] remoteproc: xlnx: Disable unsupported features
Date: Tue, 12 Aug 2025 19:31:47 +0200
Message-ID: <20250812173434.953376020@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tanmay Shah <tanmay.shah@amd.com>

[ Upstream commit 699cdd706290208d47bd858a188b030df2e90357 ]

AMD-Xilinx platform driver does not support iommu or recovery mechanism
yet. Disable both features in platform driver.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Link: https://lore.kernel.org/r/20250716213048.2316424-2-tanmay.shah@amd.com
Fixes: 6b291e8020a8 ("drivers: remoteproc: Add Xilinx r5 remoteproc driver")
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 1af89782e116..79be88b40ab0 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -938,6 +938,8 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 
 	rproc_coredump_set_elf_info(r5_rproc, ELFCLASS32, EM_ARM);
 
+	r5_rproc->recovery_disabled = true;
+	r5_rproc->has_iommu = false;
 	r5_rproc->auto_boot = false;
 	r5_core = r5_rproc->priv;
 	r5_core->dev = cdev;
-- 
2.39.5




