Return-Path: <stable+bounces-14714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488988382C8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D90B23F4D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB0459B5D;
	Tue, 23 Jan 2024 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OGmCbcA3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C84EB52;
	Tue, 23 Jan 2024 01:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974105; cv=none; b=asLbBcEMTi1etRt/1za2yHbji8LUhIwmTuUeQyS9SK9EMlPvfIBvSHWsI7fN2Jd+Zb7xxMSTSu3BjW0+rQCBzv2eOGlY8Bfd+cHOWSJT3KOfQf75Lxm7L7mlfC07y2HYRNuFeBNcuEnjf18PzzHg6A+R2tywpiTiYQR8fxmltJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974105; c=relaxed/simple;
	bh=AGz8RIdaW7988L0YOvKEN31AhG/QF40gjfDw9q7++AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5SSLCyC4nd4xyrtND1d0Qa5eDDnbpfBlCmKWIErqXsvVwFVvsPjtRLZArnY0AlH+J6LECHnTKbJ63aakLsiHb5G2NQVTOVmZn5UJevd3zeFqVpsRa03JCd15/zj8Cz4xUcR58n5uYr4CcRoLSy94pPOITf2YNNCBe/emtn93rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OGmCbcA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8B6C43394;
	Tue, 23 Jan 2024 01:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974104;
	bh=AGz8RIdaW7988L0YOvKEN31AhG/QF40gjfDw9q7++AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OGmCbcA3ju7bWHf3UHsKGWeIWtGpMppgZOj0JBtr9OGTMBBcI6AYagQz+Pvh18Rld
	 3Twy9oryVZDeDjLFLyGMWSjxDHhrLfuPSX2wBgmvAKHULhay58jRe26hi8TRzgsZvw
	 s5efPSVDueZepXDPZYJtdEd+sZJXDCFjXVIdMxyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 040/583] drivers/thermal/loongson2_thermal: Fix incorrect PTR_ERR() judgment
Date: Mon, 22 Jan 2024 15:51:31 -0800
Message-ID: <20240122235813.375915692@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Binbin Zhou <zhoubinbin@loongson.cn>

[ Upstream commit 15ef92e9c41124ee9d88b01208364f3fe1f45f84 ]

PTR_ERR() returns -ENODEV when thermal-zones are undefined, and we need
-ENODEV as the right value for comparison.

Otherwise, tz->type is NULL when thermal-zones is undefined, resulting
in the following error:

[   12.290030] CPU 1 Unable to handle kernel paging request at virtual address fffffffffffffff1, era == 900000000355f410, ra == 90000000031579b8
[   12.302877] Oops[#1]:
[   12.305190] CPU: 1 PID: 181 Comm: systemd-udevd Not tainted 6.6.0-rc7+ #5385
[   12.312304] pc 900000000355f410 ra 90000000031579b8 tp 90000001069e8000 sp 90000001069eba10
[   12.320739] a0 0000000000000000 a1 fffffffffffffff1 a2 0000000000000014 a3 0000000000000001
[   12.329173] a4 90000001069eb990 a5 0000000000000001 a6 0000000000001001 a7 900000010003431c
[   12.337606] t0 fffffffffffffff1 t1 54567fd5da9b4fd4 t2 900000010614ec40 t3 00000000000dc901
[   12.346041] t4 0000000000000000 t5 0000000000000004 t6 900000010614ee20 t7 900000000d00b790
[   12.354472] t8 00000000000dc901 u0 54567fd5da9b4fd4 s9 900000000402ae10 s0 900000010614ec40
[   12.362916] s1 90000000039fced0 s2 ffffffffffffffed s3 ffffffffffffffed s4 9000000003acc000
[   12.362931] s5 0000000000000004 s6 fffffffffffff000 s7 0000000000000490 s8 90000001028b2ec8
[   12.362938]    ra: 90000000031579b8 thermal_add_hwmon_sysfs+0x258/0x300
[   12.386411]   ERA: 900000000355f410 strscpy+0xf0/0x160
[   12.391626]  CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
[   12.397898]  PRMD: 00000004 (PPLV0 +PIE -PWE)
[   12.403678]  EUEN: 00000000 (-FPE -SXE -ASXE -BTE)
[   12.409859]  ECFG: 00071c1c (LIE=2-4,10-12 VS=7)
[   12.415882] ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
[   12.415907]  BADV: fffffffffffffff1
[   12.415911]  PRID: 0014a000 (Loongson-64bit, Loongson-2K1000)
[   12.415917] Modules linked in: loongson2_thermal(+) vfat fat uio_pdrv_genirq uio fuse zram zsmalloc
[   12.415950] Process systemd-udevd (pid: 181, threadinfo=00000000358b9718, task=00000000ace72fe3)
[   12.415961] Stack : 0000000000000dc0 54567fd5da9b4fd4 900000000402ae10 9000000002df9358
[   12.415982]         ffffffffffffffed 0000000000000004 9000000107a10aa8 90000001002a3410
[   12.415999]         ffffffffffffffed ffffffffffffffed 9000000107a11268 9000000003157ab0
[   12.416016]         9000000107a10aa8 ffffff80020fc0c8 90000001002a3410 ffffffffffffffed
[   12.416032]         0000000000000024 ffffff80020cc1e8 900000000402b2a0 9000000003acc000
[   12.416048]         90000001002a3410 0000000000000000 ffffff80020f4030 90000001002a3410
[   12.416065]         0000000000000000 9000000002df6808 90000001002a3410 0000000000000000
[   12.416081]         ffffff80020f4030 0000000000000000 90000001002a3410 9000000002df2ba8
[   12.416097]         00000000000000b4 90000001002a34f4 90000001002a3410 0000000000000002
[   12.416114]         ffffff80020f4030 fffffffffffffff0 90000001002a3410 9000000002df2f30
[   12.416131]         ...
[   12.416138] Call Trace:
[   12.416142] [<900000000355f410>] strscpy+0xf0/0x160
[   12.416167] [<90000000031579b8>] thermal_add_hwmon_sysfs+0x258/0x300
[   12.416183] [<9000000003157ab0>] devm_thermal_add_hwmon_sysfs+0x50/0xe0
[   12.416200] [<ffffff80020cc1e8>] loongson2_thermal_probe+0x128/0x200 [loongson2_thermal]
[   12.416232] [<9000000002df6808>] platform_probe+0x68/0x140
[   12.416249] [<9000000002df2ba8>] really_probe+0xc8/0x3c0
[   12.416269] [<9000000002df2f30>] __driver_probe_device+0x90/0x180
[   12.416286] [<9000000002df3058>] driver_probe_device+0x38/0x160
[   12.416302] [<9000000002df33a8>] __driver_attach+0xa8/0x200
[   12.416314] [<9000000002deffec>] bus_for_each_dev+0x8c/0x120
[   12.416330] [<9000000002df198c>] bus_add_driver+0x10c/0x2a0
[   12.416346] [<9000000002df46b4>] driver_register+0x74/0x160
[   12.416358] [<90000000022201a4>] do_one_initcall+0x84/0x220
[   12.416372] [<90000000022f3ab8>] do_init_module+0x58/0x2c0
[   12.416386] [<90000000022f6538>] init_module_from_file+0x98/0x100
[   12.416399] [<90000000022f67f0>] sys_finit_module+0x230/0x3c0
[   12.416412] [<900000000358f7c8>] do_syscall+0x88/0xc0
[   12.416431] [<900000000222137c>] handle_syscall+0xbc/0x158

Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal management support")
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/343c14de98216636a47b43e8bfd47b70d0a8e068.1700817227.git.zhoubinbin@loongson.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/loongson2_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 133098dc0854..99ca0c7bc41c 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -127,7 +127,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		if (!IS_ERR(tzd))
 			break;
 
-		if (PTR_ERR(tzd) != ENODEV)
+		if (PTR_ERR(tzd) != -ENODEV)
 			continue;
 
 		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
-- 
2.43.0




