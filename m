Return-Path: <stable+bounces-14922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F180783832B
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD331C298B9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE1E60888;
	Tue, 23 Jan 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c19Z749n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DC50266;
	Tue, 23 Jan 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974723; cv=none; b=hppMdN1Q+bwtjyS25H9eTQ5jEp9312/Q7LQmZAAMXgQLwgJiPog2HafQrZWoeX+sRnkyIbNhA6u9YJIFQP1UmwFPyiOqxO/XK6j7f1BDeULbfTAJMFV3U0/ZKzJRhNjv/VGKFSYd6+0s46zbmOdljHL9qVxyFORDL2iWzFXm/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974723; c=relaxed/simple;
	bh=AcwAUkKjJl639+Rruw8ScYMhcpEMfna+5aekxIPzz5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnoXZ5F+pmmMCgAR+fSPS6eNVzSHgovJiZkZvOPYUNIliGuCXlETmnPRuU7lZuY92+ibVvlqe9FYN3hHLKjF0UFJXfmrj7odYgAttZXo7WTZQzC3V2NaQXAuKbcKQ7gJoZ6cmXLR7s0Z+RAci8Uz+M6l5rn6RYX6NGmW3VsCM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c19Z749n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31241C43394;
	Tue, 23 Jan 2024 01:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974723;
	bh=AcwAUkKjJl639+Rruw8ScYMhcpEMfna+5aekxIPzz5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c19Z749nI20/kXoXFvGoMgx3faIUwgFPeNK6P1ECT8MvteiagcifStWWiHzIsrOwM
	 uMdSo4eHx453sMeQfZfnHs36P/Hj0JgUumrG4VOg278bZ4wtXP0VJ85aIn+3HZQNy+
	 psZhiumKfQcXNE2YkfM/7ItDJVld1iRulkxCGS8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Wei Xu <xuwei5@hisilicon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 143/583] arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties
Date: Mon, 22 Jan 2024 15:53:14 -0800
Message-ID: <20240122235816.477893777@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit 44ab3ee76a5a977864ba0bb6c352dcf6206804e0 ]

The Hi6421 PMIC regulator child nodes do not have unit addresses so drop
the incorrect '#address-cells' and '#size-cells' properties.

Fixes: 6219b20e1ecd ("arm64: dts: hisilicon: Add support for Hikey 970 PMIC")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
index 970047f2dabd..c06e011a6c3f 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
@@ -25,9 +25,6 @@ pmic: pmic@0 {
 			gpios = <&gpio28 0 0>;
 
 			regulators {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ldo3: ldo3 { /* HDMI */
 					regulator-name = "ldo3";
 					regulator-min-microvolt = <1500000>;
-- 
2.43.0




