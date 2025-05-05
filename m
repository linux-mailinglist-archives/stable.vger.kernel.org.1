Return-Path: <stable+bounces-141193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BC0AAB150
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D717A134
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3A3C8759;
	Tue,  6 May 2025 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6UXE1EH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EBC2D111C;
	Mon,  5 May 2025 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485464; cv=none; b=mG9zpoJUk+DOBNYgPDy0qJH+BVQgXQh1S8+kuYbW4JKJNN/GL6ek5vQrRINDNDYuNOyf2+ZKrzYYrNJ4/z9ZMcp776NXcEIu0TEK8c7txm4FVzMNvH6Rtyd8RkGmgkUmNKwhEzP1RhFDQSGuPLks66L9lNxSvIN/eOE6sOOtDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485464; c=relaxed/simple;
	bh=qm8pJYqgBS9g9flUCLFZljzZnY4uiLUSesZQ6cB7eEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RR4jZ7GgWUPnz/ho5TanlQ1ThU9DZlPQ64QXMJqE/4jo07IfYmVrLTZTWV/BNOuV435z00PoYIlYIJdXHyINLJtCDAQCU0j7OY9mDXue/miSOcxOKVlJkv7uN/1or+g1Cq6noApUxvuQM15D1qIILz9rRYSEWSlf8LWHUQKcLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6UXE1EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06CAC4CEED;
	Mon,  5 May 2025 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485463;
	bh=qm8pJYqgBS9g9flUCLFZljzZnY4uiLUSesZQ6cB7eEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6UXE1EHHjNf4DXb919bjcwd7FjnfpvVLp3/X/Ih9E+yFO95vLeHwyERfa8gvPkui
	 NDwE5CIuFYEWGfu6KxIPt5JBjg5azBPn0zpJbdJjj2NkUfV9+G8aiaF1A3nqdI4RME
	 EF6nLlIxy2GHmixp3xefSz7nlYPtulUHiStZgOKKNdrgtF+rX0xpfKuL0fY4cRFx4N
	 R+yJ1f8MlC39uWfiznmbJ0Xk+D0zODBK9v/SyqVHMfJQ1agHQxUxZkkaSPBtDCJj7e
	 iz5KRl+OW/838/RBWUdNYiTl0la5aBWfJzB2u32PJZ74q9crx4RmyNxtUuaoFklddD
	 cvds/QeDubPVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>,
	Nava kishore Manne <nava.kishore.manne@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	ronak.jain@amd.com,
	jay.buddhabhatti@amd.com,
	radhey.shyam.pandey@amd.com,
	gregkh@linuxfoundation.org,
	u.kleine-koenig@baylibre.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 325/486] firmware: xilinx: Dont send linux address to get fpga config get status
Date: Mon,  5 May 2025 18:36:41 -0400
Message-Id: <20250505223922.2682012-325-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index add8acf66a9c7..5578158f13750 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1012,17 +1012,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
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


