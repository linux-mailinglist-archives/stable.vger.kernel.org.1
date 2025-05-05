Return-Path: <stable+bounces-140158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6CDAAA5B3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2831018872A1
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8250E315F98;
	Mon,  5 May 2025 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czF5dTQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED73315F8E;
	Mon,  5 May 2025 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484250; cv=none; b=BuXs0QCIn7ouSJ2yNrrdXwlzaUVjVh/z9MR4gbfEMs3871S1VO9ryse+QfBczi8wtnW7ZYgrvJzk8coYXL4Fj76U2QwytZFXv3ZXl9gBNnuMyvm3A3AJ3egycs1GHWrqb7nOCssEPwG/YWb6u78nCCV5tIiNse8P4iRfsPU8fw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484250; c=relaxed/simple;
	bh=W1z9LlLC9I5AttB7l1i4Ia/f9RWJJFje1bqZEjRt27w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FvYG1jEC/R8ID6VB4de5m1PaCEGDN3lcQH7Ub2N7kzbOYUTt8+3i7MpxKoVOxOa5bteh3lIWeizfM89H6rjYU/E5W8frnpc/uj0eMVBll++mi/1Vh+uHjXshcmda8g1jfNh59NLSvBRBYhjzJxu7KfeTMvhQyFlwqBWdAYL5Dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czF5dTQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB42C4CEE4;
	Mon,  5 May 2025 22:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484250;
	bh=W1z9LlLC9I5AttB7l1i4Ia/f9RWJJFje1bqZEjRt27w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czF5dTQjCC6jiNfCX1hjZwuvtqGecoDnCt6uoxyeB3YEEYL/vau7QTq4P3ctQ4zLN
	 t/6v0VuAkBLJcWpcurSBfj7l7ru1ItfzPAXTZZ6rROUnPWjFoIDWQhJHKGr0TCk/tG
	 fDLRIcCbZMRbKi7FIz2Q+XVPDY8XhWl13AqYVogrLDnikXARcwM0Pbu13hu4e8CIt0
	 EcRA3E9djLEM0YZsgN0fo2brlIWytoR/tQMtlaXeV08UIfskjMKZNGpxyDVjK8Wdh/
	 D6uDN0IEhQTuAYEQDiUG08+BkRsPYSAMLHzI8O2k5DtC0MpqG69mWuQGZqJe2BhWY0
	 SrMB1WKc9qz8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>,
	Nava kishore Manne <nava.kishore.manne@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	ronak.jain@amd.com,
	jay.buddhabhatti@amd.com,
	u.kleine-koenig@baylibre.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 411/642] firmware: xilinx: Dont send linux address to get fpga config get status
Date: Mon,  5 May 2025 18:10:27 -0400
Message-Id: <20250505221419.2672473-411-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>

[ Upstream commit 5abc174016052caff1bcf4cedb159bd388411e98 ]

Fpga get config status just returns status through ret_payload and there
is no need to allocate local buf and send its address through SMC args.
Moreover, the address that is being passed till now is linux virtual
address and is incorrect.
Corresponding modification has been done in the firmware to avoid using the
address sent by linux.

Signed-off-by: Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
Link: https://lore.kernel.org/r/20250207054951.1650534-1-nava.kishore.manne@amd.com
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/xilinx/zynqmp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 720fa8b5d8e95..7356e860e65ce 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1139,17 +1139,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
 int zynqmp_pm_fpga_get_config_status(u32 *value)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
-	u32 buf, lower_addr, upper_addr;
 	int ret;
 
 	if (!value)
 		return -EINVAL;
 
-	lower_addr = lower_32_bits((u64)&buf);
-	upper_addr = upper_32_bits((u64)&buf);
-
 	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ, ret_payload, 4,
-				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, lower_addr, upper_addr,
+				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, 0, 0,
 				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG);
 
 	*value = ret_payload[1];
-- 
2.39.5


