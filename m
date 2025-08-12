Return-Path: <stable+bounces-168013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E9B232FB
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA08188D949
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022863F9D2;
	Tue, 12 Aug 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jwLESAmc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B52DBF5E;
	Tue, 12 Aug 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022749; cv=none; b=qeSikYXxQ1AuawSFxHOUVQvclBlE0NMq2o6yhhFhvCvVL9NOMTFV8akwaIh6I2zC4HjgZSUgJQkehL9glioVIxNuDtbf2ZNtYjKqeAT6mVctzZ1MFoo2MAMpxVFQ5GqDFjVUTU+MfOBzXg1V/zeVKDbfKugjE+sYd/rVLDZrDdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022749; c=relaxed/simple;
	bh=TphznTO4JtIyOSRDkmIZh1EZrlDutCRHuwGxZjifK4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZy8wj2rk3GY28aBms9utSGMuaKzdM5UaqVrSdOVnZdrrEgUmabruDSvxzbzJEVBJSmq6V1EpdTJXZ2D/qe3oNNqWe0HSWmtv7fbFtYHe0DXYThscpAAxOZ00T5IU7MWcxe624gozsUr1aS+FF0WAsIQCTyyS6jlQJkcJXq4rD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jwLESAmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A0DC4CEF6;
	Tue, 12 Aug 2025 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022749;
	bh=TphznTO4JtIyOSRDkmIZh1EZrlDutCRHuwGxZjifK4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jwLESAmcO5A5hvCysFVLSqy+qXfhpUGKpVmzVb4+xyf6GTaq8rDK16Uvd9cEFNy0J
	 x8Zrc/M2ICqosPw/b9aR7pA5O2xp6kqpt0IXYFeKXcojbY2jdpVbvr0bQ7jy17TZJL
	 dXC3KKBvF/Slf5TPdsyMup+2mNWcS5+wEMF3yFEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tanmay Shah <tanmay.shah@amd.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 214/369] remoteproc: xlnx: Disable unsupported features
Date: Tue, 12 Aug 2025 19:28:31 +0200
Message-ID: <20250812173022.805177877@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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
index 5aeedeaf3c41..c165422d0651 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -906,6 +906,8 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 
 	rproc_coredump_set_elf_info(r5_rproc, ELFCLASS32, EM_ARM);
 
+	r5_rproc->recovery_disabled = true;
+	r5_rproc->has_iommu = false;
 	r5_rproc->auto_boot = false;
 	r5_core = r5_rproc->priv;
 	r5_core->dev = cdev;
-- 
2.39.5




