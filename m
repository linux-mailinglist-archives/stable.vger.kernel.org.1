Return-Path: <stable+bounces-18231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C9F8481E8
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD1AB29B58
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95A84207D;
	Sat,  3 Feb 2024 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="081TQdX5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582512B7B;
	Sat,  3 Feb 2024 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933644; cv=none; b=CzExi5yYqOeyESJmbMWE6RlHto8i1BmrEM9uAHbLDJpR90uxxb2nWyMO2/kRfzvkH/1ZpJhqgOCMLbTu0wtMLS1uUsboxvhMn1tyG0Rjm+DNNly1m/k+GMgUB1FZ9kVQUBjcQdFz797yWzH238L/9/kSZjUpXBXDoPID5wAtsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933644; c=relaxed/simple;
	bh=1f/rPJrbb+riHPa9juxg0uZHcBzvsfGY5YvJ7CrL72Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bd2GBLHoduAIOp3Pb6fK8mGT/XDrwmIRZLb6o8DVywyTdJAEMcxsKiP2ww3WSgl2ief7uRe1M7jHFkSlB9wtZoj5+C2kJNacTKPSMyX1al2OrD+YbyZM+cLIoKHqruaRNew7hVix5y44a8KAtX/axuddLLU6Lh4zcO2BBSU/Wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=081TQdX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD45C43399;
	Sat,  3 Feb 2024 04:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933644;
	bh=1f/rPJrbb+riHPa9juxg0uZHcBzvsfGY5YvJ7CrL72Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=081TQdX5cpwGUGyGrwaQsZK647+DrBDcFZm+N3Umb2SAfm8igJWt9lbbKTRgVbdlO
	 35yGcz49wFbBdgAZu89y7nBaIryQBdoyhozWST7INMQtThwXlWxG4rEVYT2jfqxxRp
	 JOIr0ITA8YiwPjzeT0aHJCLO4QNTZEvVH2dkLZnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Robinson <pbrobinson@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 227/322] mfd: ti_am335x_tscadc: Fix TI SoC dependencies
Date: Fri,  2 Feb 2024 20:05:24 -0800
Message-ID: <20240203035406.542725050@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
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

From: Peter Robinson <pbrobinson@gmail.com>

[ Upstream commit 284d16c456e5d4b143f375b8ccc4038ab3f4ee0f ]

The ti_am335x_tscadc is specific to some TI SoCs, update
the dependencies for those SoCs and compile testing.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Link: https://lore.kernel.org/r/20231220155643.445849-1-pbrobinson@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 90ce58fd629e..68d71b4b55bd 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1483,6 +1483,7 @@ config MFD_SYSCON
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
+	depends on ARCH_OMAP2PLUS || ARCH_K3 || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
-- 
2.43.0




