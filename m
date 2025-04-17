Return-Path: <stable+bounces-134421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DEBA92AF7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3AB1728A9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0C256C67;
	Thu, 17 Apr 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4pIhRal"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186B1DF246;
	Thu, 17 Apr 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916078; cv=none; b=mVezxqUKJuUBFyFYl56zs2aXhREHYsGuDJ8K9QUPQdsaBSG/F9P9jpSuKovMpl7tEGxWCCfEwnTcinaNcEOObQ0LNQ9efrUrKVFNrl3MFUF8k45oypjTjyFOSpNhNi4XkHG5mOhSo7IuhW4wVJLWLRknSlDwIDB/Izd8ceEJNvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916078; c=relaxed/simple;
	bh=Ju3hj7ZrgYXPBG0tdNnnQNypy8dZbd8t4rPY69PAzCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=htVmUB2NVre0KmhPQWZmDC8gVdc1Q5GP/i4WFkTCp3XWreh4tZ/ZzcB7yIaAfPFd6Lw3uuRVZk46Ff2RgS41w8PkCUKlHGe4ufZhWnKlHPcbBdXDQchc2uYJdqTRZlivDEJfYtZHPlgNGlMgp/carP/JJ7AU9FoIe87Txnf+UZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4pIhRal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82663C4CEE4;
	Thu, 17 Apr 2025 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916077;
	bh=Ju3hj7ZrgYXPBG0tdNnnQNypy8dZbd8t4rPY69PAzCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4pIhRalsAEEzQxkTpgQsi416G4jGOTYguQj4OdJfzQR4P9H7vSedzriCQqf6VTTp
	 4eeWSWjvvS03YMG2Z951rSBAelkV2hx3wjlGHrRB+2ul5K/zI9rxKCwYwV253oStj8
	 DiKN7T8IT07HL1UBoNABn/8jpaZbOngiNyTWcCG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 6.12 335/393] dt-bindings: coresight: qcom,coresight-tpda: Fix too many reg
Date: Thu, 17 Apr 2025 19:52:24 +0200
Message-ID: <20250417175121.076832113@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit d72deaf05ac18e421d7e52a6be8966fd6ee185f4 upstream.

Binding listed variable number of IO addresses without defining them,
however example DTS code, all in-tree DTS and Linux kernel driver
mention only one address space, so drop the second to make binding
precise and correctly describe the hardware.

Fixes: a8fbe1442c2b ("dt-bindings: arm: Adds CoreSight TPDA hardware definitions")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20250226112914.94361-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpda.yaml
@@ -55,8 +55,7 @@ properties:
       - const: arm,primecell
 
   reg:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   clocks:
     maxItems: 1



