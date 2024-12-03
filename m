Return-Path: <stable+bounces-97451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A79E2410
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CD828699E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157E1F75A6;
	Tue,  3 Dec 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HCjw6MOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4001F12E0;
	Tue,  3 Dec 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240549; cv=none; b=Zqrf08e2NWw3VXmcoYa9CC+JCriRmYlrgL3oODGM/0kB/wtwH8slp6Q2MNiQiVIvvaueZazWOPvC09SkkwCAEOOoB+wpuWg/LQwo35flkuqvdOmOPiOJs5FOb30bUSfNtfqMIJTumtk3A6Lff+I5HE9e5sdfteMboevW3wY1TuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240549; c=relaxed/simple;
	bh=WigICqfbVrM9NEpgcZhxulR8ruVQtHU+1fcv9kMT4cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4527bLF2ZgLGN5lizgZRZsrRk4SITBZQvGbk0M2a2Vgau1ef7bLZwfCslbGY4l4awLLpgYXS1c48QCH8iFBZ9AxMbg/f0r9Ptd+DBk+kCZpj5wJWnIklgkd5ZT96GuMWMPKOB/vw5c7vsS6dAGx1B2Fg7ivcFjxM5EZ8J8D9Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HCjw6MOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E2CC4CECF;
	Tue,  3 Dec 2024 15:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240549;
	bh=WigICqfbVrM9NEpgcZhxulR8ruVQtHU+1fcv9kMT4cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCjw6MODKn62iIstvKy2Tjj5ohuB0WTdMImx/HGgJlcJKxfA6aVT1iJ2MN+7gxkXw
	 Ro6Y6eWM9VXshYRPLGwA+hc0+PJi8dbr93bwObaoTgux5TOlLJT7dYXfDJL88NN01g
	 NXiyljPk9ILRfARkaGOmbYFhUNE/F3JTr6oZZWJ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luo Qiu <luoqiu@kylinsec.com.cn>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 167/826] firmware: arm_scpi: Check the DVFS OPP count returned by the firmware
Date: Tue,  3 Dec 2024 15:38:14 +0100
Message-ID: <20241203144750.249237259@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 94a6b4e667de1..f4d47577f83ee 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -630,6 +630,9 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
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




