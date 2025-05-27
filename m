Return-Path: <stable+bounces-146693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93BAC543B
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349731BA4885
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012A8280008;
	Tue, 27 May 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ETxtXe6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB02CCC0;
	Tue, 27 May 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365015; cv=none; b=W+JBvwREtWi9LGK34K2WiMf9oYlktOAcXSYoyfds4CLZvJSW0S41aFeIzGMC2iiIgNJUTTDN/9aEmA5TBqRWyNTEixNSostHK/Kq2HsMkf65gTYjcl/ftylk1dxGCjw8eRN1KyDkk5poZ6LS5CGVameyvwxL12Z9FNCk4p/qvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365015; c=relaxed/simple;
	bh=eVG3osM5cJc5CJCHEI1FF4qId3mSqIbtpngO4c6vKuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSudNMNeI9y/8+KUYFlZtLn2XrhsYOQYNZq6jjaudtnt3LhpT5FMIvMwoKewNgYhT95fWZ8Fs84GwaIwBuTqrvUbqdUJgt/Q6VOlF4NZYpHb8Mb3a/OTa3qZi+UayuyDHUC+hNCkVZ0npV+tvcVArprX2dWxTPFNCTYuy+g1ePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ETxtXe6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1DDC4CEE9;
	Tue, 27 May 2025 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365015;
	bh=eVG3osM5cJc5CJCHEI1FF4qId3mSqIbtpngO4c6vKuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETxtXe6NNBX22oqfiNZwxt4f6c+TzoRafnrBNRc4LzmrYkv7jufAbzlwYDwiaZ4Tt
	 6Ur1jF+Y0+fXVodf64xvz5caONQbwoQ20LZ7UDwBZwdcMBburEfy6hdL/ecU4bSJLk
	 qLVai7lioTcNTJJ2dJ4n2AbUdSyB/EtGmH8sqkD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 213/626] arm64: tegra: Resize aperture for the IGX PCIe C5 slot
Date: Tue, 27 May 2025 18:21:46 +0200
Message-ID: <20250527162453.673043586@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

From: Jon Hunter <jonathanh@nvidia.com>

[ Upstream commit 6d4bfe6d86af1ef52bdb4592c9afb2037f24f2c4 ]

Some discrete graphics cards such as the NVIDIA RTX A6000 support
resizable BARs. When connecting an A6000 card to the NVIDIA IGX Orin
platform, resizing the BAR1 aperture to 8GB fails because the current
device-tree configuration for the PCIe C5 slot cannot support this.
Fix this by updating the device-tree 'reg' and 'ranges' properties for
the PCIe C5 slot to support this.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20250116151903.476047-1-jonathanh@nvidia.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
index 36e8880537460..9ce55b4d2de89 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3740-0002+p3701-0008.dts
@@ -302,6 +302,16 @@ pcie@14160000 {
 		};
 
 		pcie@141a0000 {
+			reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
+			       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) */
+			       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
+			       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
+			       0x2e 0x20000000 0x0 0x10000000>; /* ECAM (256MB)               */
+
+			ranges = <0x81000000 0x00 0x3a100000 0x00 0x3a100000 0x0 0x00100000      /* downstream I/O (1MB) */
+				  0x82000000 0x00 0x40000000 0x2e 0x30000000 0x0 0x08000000      /* non-prefetchable memory (128MB) */
+				  0xc3000000 0x28 0x00000000 0x28 0x00000000 0x6 0x20000000>;    /* prefetchable memory (25088MB) */
+
 			status = "okay";
 			vddio-pex-ctl-supply = <&vdd_1v8_ls>;
 			phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
-- 
2.39.5




