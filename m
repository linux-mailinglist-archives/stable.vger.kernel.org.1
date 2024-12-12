Return-Path: <stable+bounces-102666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B29EF4E6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D48C189CF4A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19B723A1BB;
	Thu, 12 Dec 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfL9X/Bq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21F23A1B1;
	Thu, 12 Dec 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022054; cv=none; b=MtWiFleeUGnELPOpO4Ro3b4G2ykNyHifPqN37uCcSfz/mRUjpkZmBW75gnIvghWvttzhFvQd8dL7ieGuw9gMOdyFNNYXzfHwYX3qOxUZYOMPGDKc1VcxaH9ruShtbW9bGdmB5TYy+4M2Za9Bmkyl3sBVg+rlTY/4VqEgExMFAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022054; c=relaxed/simple;
	bh=Ke3Rjamq68Ij5DpGEz6pvXZWeDYJdVrBNuWcSwrwECA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cbm35NpQ6anEL+7hscXuLqf67P4c4k+vEQiXT6stdSVLXpIN7R2U4QCzHvD0qTYDwFsw2zP831SQUV8GQdRqawZwtqUjLnP5pfXLiBdzes+SPX8QKibD/EzWGDeQ5DsHj9LG+byLSIzL1TJ+xRex9AEP+uDSVbB2Qi85Axa6UIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfL9X/Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4367C4CECE;
	Thu, 12 Dec 2024 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022054;
	bh=Ke3Rjamq68Ij5DpGEz6pvXZWeDYJdVrBNuWcSwrwECA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfL9X/BqpgiPXctbbL6tMlx/oGr6EIGfW9gYPe4Fvi5aAQDZrp4HgntRX83RJrv28
	 xCftnhURmQvgPpiNwwLK/7LjqclUDXQTK7IbmZq+N8Hb1toK/CwnzHiPwSo+66bvpA
	 8sOfcfRIvxuhe7ynXNf7cjp6T0Sfo8Z//A0FlU7E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luo Qiu <luoqiu@kylinsec.com.cn>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 135/565] firmware: arm_scpi: Check the DVFS OPP count returned by the firmware
Date: Thu, 12 Dec 2024 15:55:30 +0100
Message-ID: <20241212144316.814344463@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Luo Qiu <luoqiu@kylinsec.com.cn>

[ Upstream commit 109aa654f85c5141e813b2cd1bd36d90be678407 ]

Fix a kernel crash with the below call trace when the SCPI firmware
returns OPP count of zero.

dvfs_info.opp_count may be zero on some platforms during the reboot
test, and the kernel will crash after dereferencing the pointer to
kcalloc(info->count, sizeof(*opp), GFP_KERNEL).

  |  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
  |  Mem abort info:
  |    ESR = 0x96000004
  |    Exception class = DABT (current EL), IL = 32 bits
  |    SET = 0, FnV = 0
  |    EA = 0, S1PTW = 0
  |  Data abort info:
  |    ISV = 0, ISS = 0x00000004
  |    CM = 0, WnR = 0
  |  user pgtable: 4k pages, 48-bit VAs, pgdp = 00000000faefa08c
  |  [0000000000000028] pgd=0000000000000000
  |  Internal error: Oops: 96000004 [#1] SMP
  |  scpi-hwmon: probe of PHYT000D:00 failed with error -110
  |  Process systemd-udevd (pid: 1701, stack limit = 0x00000000aaede86c)
  |  CPU: 2 PID: 1701 Comm: systemd-udevd Not tainted 4.19.90+ #1
  |  Hardware name: PHYTIUM LTD Phytium FT2000/4/Phytium FT2000/4, BIOS
  |  pstate: 60000005 (nZCv daif -PAN -UAO)
  |  pc : scpi_dvfs_recalc_rate+0x40/0x58 [clk_scpi]
  |  lr : clk_register+0x438/0x720
  |  Call trace:
  |   scpi_dvfs_recalc_rate+0x40/0x58 [clk_scpi]
  |   devm_clk_hw_register+0x50/0xa0
  |   scpi_clk_ops_init.isra.2+0xa0/0x138 [clk_scpi]
  |   scpi_clocks_probe+0x528/0x70c [clk_scpi]
  |   platform_drv_probe+0x58/0xa8
  |   really_probe+0x260/0x3d0
  |   driver_probe_device+0x12c/0x148
  |   device_driver_attach+0x74/0x98
  |   __driver_attach+0xb4/0xe8
  |   bus_for_each_dev+0x88/0xe0
  |   driver_attach+0x30/0x40
  |   bus_add_driver+0x178/0x2b0
  |   driver_register+0x64/0x118
  |   __platform_driver_register+0x54/0x60
  |   scpi_clocks_driver_init+0x24/0x1000 [clk_scpi]
  |   do_one_initcall+0x54/0x220
  |   do_init_module+0x54/0x1c8
  |   load_module+0x14a4/0x1668
  |   __se_sys_finit_module+0xf8/0x110
  |   __arm64_sys_finit_module+0x24/0x30
  |   el0_svc_common+0x78/0x170
  |   el0_svc_handler+0x38/0x78
  |   el0_svc+0x8/0x340
  |  Code: 937d7c00 a94153f3 a8c27bfd f9400421 (b8606820)
  |  ---[ end trace 06feb22469d89fa8 ]---
  |  Kernel panic - not syncing: Fatal exception
  |  SMP: stopping secondary CPUs
  |  Kernel Offset: disabled
  |  CPU features: 0x10,a0002008
  |  Memory Limit: none

Fixes: 8cb7cf56c9fe ("firmware: add support for ARM System Control and Power Interface(SCPI) protocol")
Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>
Message-Id: <55A2F7A784391686+20241101032115.275977-1-luoqiu@kylinsec.com.cn>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 435d0e2658a42..3de25e9d18ef8 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -627,6 +627,9 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (!buf.opp_count)
+		return ERR_PTR(-ENOENT);
+
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0




