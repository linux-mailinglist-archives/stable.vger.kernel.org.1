Return-Path: <stable+bounces-201637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FADCC3F99
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B25B304B397
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D965434D3AC;
	Tue, 16 Dec 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1itA0VZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553434D3A8;
	Tue, 16 Dec 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885295; cv=none; b=h7tiHFAf7/ADMuFvubNfu6JWWyjaaObqmrjc5qY+90x4HyBrWtuI24Iq+1AkTErbhfUV/ZMjvwVPDZzuepu2Fwlz2UJSfMe0sQVK0fxiHJv+RHAJqYmxsCCUJgOiaFD3wj+rs0kXTNaydotEqlAJb2TZGEUdZV1I1YJ1VOoVEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885295; c=relaxed/simple;
	bh=m2FgzkKYYoruca/XHReQowmj2q7Nllhd9p5GTELfg0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hn73inYpCQsRPxla6zL1QfhVRwHKBIf1+Q4JJTsykkbtEt1VjMRIHOOKso+AVKxNki2zqWJfMEvvyD96Kh1vyUbwVjEiL7BOET5uCyVnbepzXckIcL855MKH7jNxC7tfLz9VV4oMNmejpq2bVTq3vg0c4L77KcsA6iA50CD3GFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1itA0VZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CBBC4CEF1;
	Tue, 16 Dec 2025 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885295;
	bh=m2FgzkKYYoruca/XHReQowmj2q7Nllhd9p5GTELfg0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1itA0VZVKVFww24sRooE2oHKJgwySot66Q1wSIeq6Yl7we4b4vbl8dA0hEQNswfhO
	 JlAqtSHSi5BDfyH3w5riEuyIVZeLIIlD0B1JFP4b7uViJjnEmECZrlmxljgP0yScBR
	 uLV5fd6kKnZAPQwZ3lLKte8VD3Lu6cBR+hOdksCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 095/507] arm64: dts: qcom: starqltechn: remove extra empty line
Date: Tue, 16 Dec 2025 12:08:56 +0100
Message-ID: <20251216111348.980009150@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Gonçalves <ghatto404@gmail.com>

[ Upstream commit 6e71c5812856d67881572159098f701184c9356a ]

Remove empty white line ine starqltechn device tree at the end of
max77705_charger node.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
Link: https://lore.kernel.org/r/20250828204929.35402-1-ghatto404@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 4372b15d89e2 ("arm64: dts: qcom: sdm845-starqltechn: fix max77705 interrupts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 016a245a97c40..e0d83b6344215 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -631,7 +631,6 @@ max77705_charger: charger@69 {
 		monitored-battery = <&battery>;
 		interrupt-parent = <&pm8998_gpios>;
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
 	};
 
 	fuel-gauge@36 {
-- 
2.51.0




