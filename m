Return-Path: <stable+bounces-167815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FDDB23226
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F8018846C5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DFB18FC91;
	Tue, 12 Aug 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="14hzW92Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD720409A;
	Tue, 12 Aug 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022083; cv=none; b=jwbcmms9PtTrzTD76aBRoLc4bkrsPEIFMY5bAJN1u4UF2yYX5Ud/wBVd3UHS9YTBIYKPQivPYanKspunIyUhUPbbOwXOnlq80KsGx9npD1vPkAz0ruR7tKfC87+YMUpwIYH4peNcJ6kJjvFTJIdMQj3tyLV3tLljfV2HDPN0aO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022083; c=relaxed/simple;
	bh=MctgJZdl/yzn2VaUaufBNiqeMp6nNJt8LUPe8UAQUCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3wIAPWH2ECscsf6cwzb3uYqnfsckaLwsMrIx/63Z7Lr/osB3vsTp4iXIZI0ns0KVNJKnntDKMX8MbJT3W8wpjUKVrkht74+q1w2oKuGx7MUKoQgqbj196BbOzVO3Dex4WWRABcSHGXEe3pncFo7JoTrrQDwRJmatyLqVW0fdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=14hzW92Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27A8C4CEF0;
	Tue, 12 Aug 2025 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022083;
	bh=MctgJZdl/yzn2VaUaufBNiqeMp6nNJt8LUPe8UAQUCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=14hzW92YoO4zWUgwE+USgQNfScEc+fB2tUeq4AWzuQ+PXsLycLaeM+2xTqcI7Ynoz
	 4DxrrHd4sRRmRyMiIFmgM3iNFoiSf8pbU4ENIYnRLgbbphp9jC5yT8b3SAvGv3LDLl
	 RxcuFrT8in8NYyQIJGzwEl9nLWY9z0JQdoIYysUs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 050/369] arm64: dts: st: fix timer used for ticks
Date: Tue, 12 Aug 2025 19:25:47 +0200
Message-ID: <20250812173016.644313291@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

[ Upstream commit 9ec406ac4b7de3e8040a503429d1a5d389bfdaf6 ]

Remove always-on on generic ARM timer as the clock source provided by
STGEN is deactivated in low power mode, STOP1 by example.

Fixes: 5d30d03aaf78 ("arm64: dts: st: introduce stm32mp25 SoCs family")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Link: https://lore.kernel.org/r/20250515151238.1.I85271ddb811a7cf73532fec90de7281cb24ce260@changeid
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index cd9b92144a42..ed7804f06189 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -149,7 +149,7 @@ timer {
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
-		always-on;
+		arm,no-tick-in-suspend;
 	};
 
 	soc@0 {
-- 
2.39.5




