Return-Path: <stable+bounces-18482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A725C8482E6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2691C23248
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F5A4F21B;
	Sat,  3 Feb 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDIrDm49"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8734D1C6A6;
	Sat,  3 Feb 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933831; cv=none; b=ZyWC/A5DOVXFUB5h/74tQy2hRxcZIauT9Lc4Li6pdXBFJaSZlZtSrjRQEMG8gofByRwEeYj7e6iva68MKF9SU3hfcwv/qIFTUZmOOKUrHbDvg8PvZTL+A8qNQUNYLkRRihq+ZyWXmxQO7jesiPJeMPqSzmbgAVBJ4CrIGmc/pXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933831; c=relaxed/simple;
	bh=YYlQzTMUkM2QCiMihekzp4IHj1n3BBzNSMHi4PxEDVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nbsw/2fwwUWN+4i8piRSk2JHmSCgbmukGlKaYT9dGp93E7EOtvZ+CG1NRbmF6X4bVHMkPZ8QLCyUzPyv5I/eWGnnow0v78JB0t9JOeO4Vwz2gaUkvzyKsw7BbgbrwbLaih+5DsQ6hSYGKJTn8v/p2GMdLt1fO6sw20Od8X8Bol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gDIrDm49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509E1C433F1;
	Sat,  3 Feb 2024 04:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933831;
	bh=YYlQzTMUkM2QCiMihekzp4IHj1n3BBzNSMHi4PxEDVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDIrDm49Hcnmxh1s6MWYaSEu/HNVCHqKM34hoRfE7NuizaAQFidGVj4NKt7SiDvWv
	 uF3NAE3Km8mlj1RxCOU4xtJgQHaz2YO7ZTIStu31TLfqdumugTckml8rZLs6CU51Np
	 fwcUByhHoSgpbBLhIIEPT/m6gLedVmepL5yEmGEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 155/353] arm64: dts: sprd: Change UMS512 idle-state nodename to match bindings
Date: Fri,  2 Feb 2024 20:04:33 -0800
Message-ID: <20240203035408.563401697@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit 1cff7243334f851b7dddf450abdaa6223a7a28e3 ]

Fix below dtbs_check warning:

idle-states: 'core-pd' does not match any of the regexes: '^(cpu|cluster)-', 'pinctrl-[0-9]+'

Link: https://lore.kernel.org/r/20231221092824.1169453-3-chunyan.zhang@unisoc.com
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/sprd/ums512.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index 91c22667d40f..cc4459551e05 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -113,7 +113,7 @@
 
 	idle-states {
 		entry-method = "psci";
-		CORE_PD: core-pd {
+		CORE_PD: cpu-pd {
 			compatible = "arm,idle-state";
 			entry-latency-us = <4000>;
 			exit-latency-us = <4000>;
-- 
2.43.0




