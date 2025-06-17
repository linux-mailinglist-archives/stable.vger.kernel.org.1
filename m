Return-Path: <stable+bounces-154282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B0ADD90B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355E51BC105E
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7A2DFF39;
	Tue, 17 Jun 2025 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXTgo+bc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A02DFF2F;
	Tue, 17 Jun 2025 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178688; cv=none; b=AgcdB2YSJ5QqkWnpY0uhCo5ZAphRTPQtGf1MHkuwDhLWE3r6cKiVvtNXo/z8yD0HmjQIksj3ZqwCFGpC+HRcDnY2aQvU1V5/vVo10v7B4tDCKDv2jiCI25f+/UOE0cf3GURPrEoZwJHnPPsSQtxJ6szl+7HMM9IFHgiBdXi5xyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178688; c=relaxed/simple;
	bh=ivhFaR9ANHP6tuws53enP05i6e9SxUjypkNDl51mjjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKw3zK8tp04wIDm38HuOalusx9/AELaLiHflBfH3flYeCe22lYzbHQVqQjkVrnWXBSgCZAaKagOTa8dVa6pwYCHIEW1b7FAIxFohr7Qz5AHujg5GHYQ24L6p/3CqykQ95mugHOc8UMpnOUcgaJs7ogk5Q2c9u2aBBlvEiIFVwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXTgo+bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA67C4CEE7;
	Tue, 17 Jun 2025 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178688;
	bh=ivhFaR9ANHP6tuws53enP05i6e9SxUjypkNDl51mjjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXTgo+bcBxujjeV9rHsuFqzjrSRaGrxLF2tfBUZaw5oxqelec6IiQoZbo2v1dgL3G
	 RoC6dkzzZfDwqlEh3fp1lHVm1AFDyr/JmOJrlX5Ovp9lv01j9xBA8MZbpgCqhVa8/X
	 Tb3IJaIxVVs3EONws4JGJeOkWf/IGj25+xHTEjUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	WangYuli <wangyuli@uniontech.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 524/780] MIPS: Loongson64: Add missing #interrupt-cells for loongson64c_ls7a
Date: Tue, 17 Jun 2025 17:23:52 +0200
Message-ID: <20250617152512.853722266@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WangYuli <wangyuli@uniontech.com>

[ Upstream commit 6d223b8ffcd1593d032b71875def2daa71c53111 ]

Similar to commit 98a9e2ac3755 ("MIPS: Loongson64: DTS: Fix msi node for ls7a").

Fix follow warnings:
  arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts:28.31-36.4: Warning (interrupt_provider): /bus@10000000/msi-controller@2ff00000: Missing '#interrupt-cells' in interrupt provider
  arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'

Fixes: 24af105962c8 ("MIPS: Loongson64: DeviceTree for LS7A PCH")
Tested-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts b/arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts
index c7ea4f1c0bb21..6c277ab83d4b9 100644
--- a/arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts
+++ b/arch/mips/boot/dts/loongson/loongson64c_4core_ls7a.dts
@@ -29,6 +29,7 @@
 		compatible = "loongson,pch-msi-1.0";
 		reg = <0 0x2ff00000 0 0x8>;
 		interrupt-controller;
+		#interrupt-cells = <1>;
 		msi-controller;
 		loongson,msi-base-vec = <64>;
 		loongson,msi-num-vecs = <64>;
-- 
2.39.5




