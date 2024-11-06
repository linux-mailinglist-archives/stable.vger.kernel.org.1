Return-Path: <stable+bounces-91083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCDF9BEC5C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55F2285BDD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337C31FBCA4;
	Wed,  6 Nov 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y3lTQd87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAC21FBC9A;
	Wed,  6 Nov 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897691; cv=none; b=g52d/4PA8+PqCVoSQEqo3k5OJHDqI2Ujhp8ysgdfV9S2EkuNfn5ZweqvSUDYhhn2uHXCPznv8dVLfQkothO0A3WowJ/mRCpThr3y4RHZN+/Nma9aiRfA6xDDdf1uhcf26SD1DyYZCLt4p4qjb4SyFsCsPa/KtdMPqsImzT+SS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897691; c=relaxed/simple;
	bh=KgYgwRIW87RpGFZjnm3SBedogxjkbj+vIXNA8G6SvOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSrJo5UDCVe7SElDTUhd/FYajMOGTXJ20xR/gC22a+8yxBkfkfONA/XZtvYjDoYMTirDdPp7uMYjvlq8VZpU9HgmhpMwjjDSqE0zKgL5QhO+gu0Yj/Tnnx9iK8fW3vJkKlpUlmTXScYmSpqeaNNfV+7CyZ1UkDgTGGuzBetJgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y3lTQd87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615D2C4CECD;
	Wed,  6 Nov 2024 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897690;
	bh=KgYgwRIW87RpGFZjnm3SBedogxjkbj+vIXNA8G6SvOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y3lTQd87ikRGwFi5lIpH2EdG4in9NaNukFTgEkN1//OWV9C2MAFdKbDbW2DmHZTjY
	 BCja9CQgwzoKvX7ngd0FzlZWItYF0iHOgmFvcPstEWnNhRvOchbQopTMqVi14niVqH
	 vEFHR3PQRBls+16CvLocfoqUWjUFQXXobcIOzvYs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Haibo Chen <haibo.chen@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 6.6 138/151] arm64: dts: imx8ulp: correct the flexspi compatible string
Date: Wed,  6 Nov 2024 13:05:26 +0100
Message-ID: <20241106120312.652611126@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

From: Haibo Chen <haibo.chen@nxp.com>

commit 409dc5196d5b6eb67468a06bf4d2d07d7225a67b upstream.

The flexspi on imx8ulp only has 16 LUTs, and imx8mm flexspi has
32 LUTs, so correct the compatible string here, otherwise will
meet below error:

[    1.119072] ------------[ cut here ]------------
[    1.123926] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-nxp-fspi.c:855 nxp_fspi_exec_op+0xb04/0xb64
[    1.133239] Modules linked in:
[    1.136448] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc6-next-20240902-00001-g131bf9439dd9 #69
[    1.146821] Hardware name: NXP i.MX8ULP EVK (DT)
[    1.151647] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.158931] pc : nxp_fspi_exec_op+0xb04/0xb64
[    1.163496] lr : nxp_fspi_exec_op+0xa34/0xb64
[    1.168060] sp : ffff80008002b2a0
[    1.171526] x29: ffff80008002b2d0 x28: 0000000000000000 x27: 0000000000000000
[    1.179002] x26: ffff2eb645542580 x25: ffff800080610014 x24: ffff800080610000
[    1.186480] x23: ffff2eb645548080 x22: 0000000000000006 x21: ffff2eb6455425e0
[    1.193956] x20: 0000000000000000 x19: ffff80008002b5e0 x18: ffffffffffffffff
[    1.201432] x17: ffff2eb644467508 x16: 0000000000000138 x15: 0000000000000002
[    1.208907] x14: 0000000000000000 x13: ffff2eb6400d8080 x12: 00000000ffffff00
[    1.216378] x11: 0000000000000000 x10: ffff2eb6400d8080 x9 : ffff2eb697adca80
[    1.223850] x8 : ffff2eb697ad3cc0 x7 : 0000000100000000 x6 : 0000000000000001
[    1.231324] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000007a6
[    1.238795] x2 : 0000000000000000 x1 : 00000000000001ce x0 : 00000000ffffff92
[    1.246267] Call trace:
[    1.248824]  nxp_fspi_exec_op+0xb04/0xb64
[    1.253031]  spi_mem_exec_op+0x3a0/0x430
[    1.257139]  spi_nor_read_id+0x80/0xcc
[    1.261065]  spi_nor_scan+0x1ec/0xf10
[    1.264901]  spi_nor_probe+0x108/0x2fc
[    1.268828]  spi_mem_probe+0x6c/0xbc
[    1.272574]  spi_probe+0x84/0xe4
[    1.275958]  really_probe+0xbc/0x29c
[    1.279713]  __driver_probe_device+0x78/0x12c
[    1.284277]  driver_probe_device+0xd8/0x15c
[    1.288660]  __device_attach_driver+0xb8/0x134
[    1.293316]  bus_for_each_drv+0x88/0xe8
[    1.297337]  __device_attach+0xa0/0x190
[    1.301353]  device_initial_probe+0x14/0x20
[    1.305734]  bus_probe_device+0xac/0xb0
[    1.309752]  device_add+0x5d0/0x790
[    1.313408]  __spi_add_device+0x134/0x204
[    1.317606]  of_register_spi_device+0x3b4/0x590
[    1.322348]  spi_register_controller+0x47c/0x754
[    1.327181]  devm_spi_register_controller+0x4c/0xa4
[    1.332289]  nxp_fspi_probe+0x1cc/0x2b0
[    1.336307]  platform_probe+0x68/0xc4
[    1.340145]  really_probe+0xbc/0x29c
[    1.343893]  __driver_probe_device+0x78/0x12c
[    1.348457]  driver_probe_device+0xd8/0x15c
[    1.352838]  __driver_attach+0x90/0x19c
[    1.356857]  bus_for_each_dev+0x7c/0xdc
[    1.360877]  driver_attach+0x24/0x30
[    1.364624]  bus_add_driver+0xe4/0x208
[    1.368552]  driver_register+0x5c/0x124
[    1.372573]  __platform_driver_register+0x28/0x34
[    1.377497]  nxp_fspi_driver_init+0x1c/0x28
[    1.381888]  do_one_initcall+0x80/0x1c8
[    1.385908]  kernel_init_freeable+0x1c4/0x28c
[    1.390472]  kernel_init+0x20/0x1d8
[    1.394138]  ret_from_fork+0x10/0x20
[    1.397885] ---[ end trace 0000000000000000 ]---
[    1.407908] ------------[ cut here ]------------

Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
Cc: stable@kernel.org
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -352,7 +352,7 @@
 			};
 
 			flexspi2: spi@29810000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx8ulp-fspi";
 				reg = <0x29810000 0x10000>, <0x60000000 0x10000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;



