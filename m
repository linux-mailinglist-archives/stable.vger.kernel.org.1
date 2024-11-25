Return-Path: <stable+bounces-95396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3079D8909
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C35161CF9
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF411B2196;
	Mon, 25 Nov 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2m7r5Mf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36C1946B9
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548037; cv=none; b=XWad8K+2CvJ04Xo5vkWO085GLs8N0Oz2WqpDdhlKPsH0NshhlYufx+vO5h7j+BVzlgC9qwKojPlnL9iraWuNmZLXEvUZ70j5uQOCCZuUSA3sZFl3vlB+IWoNS9GBGKGj7O/X2LQHoPlBxpbl69VTOP9xOtQvHmOyvRPx97asSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548037; c=relaxed/simple;
	bh=s8hEcDLip67mRO52O2FRQqepcSJpsRxRtL6/aqoc4vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BitxinCl7BpqO1aTdH3c5ybDT/k1tr7jqmfODwqVVZBo3v0JW2autpWXFu6M0HVuoIhMGXVUsm1snR9H2U1Ye8J4tBKJAbbiM6TnjicUyHe3LYh+/njcQaJA1aUNpsLSr3nffehFy8H8cBqzLM3goHczHi8k3VYIYa8jH+vsBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2m7r5Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61428C4CECE;
	Mon, 25 Nov 2024 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548036;
	bh=s8hEcDLip67mRO52O2FRQqepcSJpsRxRtL6/aqoc4vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2m7r5MfN1H3O7Qgdjq9KIGmYln9NXBwZShKjMMwiAbNOjsSWg0vaLUaxP0kxVtG7
	 aHMnE9EV9EcL0FgcDIzxt+tNVwOEtIUsArq0LuVvTWrRpWTwmAv56gOuYsqVXrbSId
	 qyQ7Z6kewQW/4O1bnnY96buSM9ME3P9hMMZCPTejlxmNSQpbK8dMI8uqP2SwP/3nOZ
	 5qpIb24vsKo3UxDz7m2KCQdMRC08EZXtiMuLtY0VRqVghnStvVH37RSQQeGJ6gZUBT
	 kXwTUmbKmdEyONChS/auWtZl7RTUTR/2wDNDUs3Z310o8kty6UhFxHlTYs4N6M2PwK
	 yVFovZU8z02YA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon, 25 Nov 2024 10:20:33 -0500
Message-ID: <20241125092010-00cdbb00841b5b49@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125091639.2729916-2-csokas.bence@prolan.hu>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 1aa772be0444a2bd06957f6d31865e80e6ae4244

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 09:11:16.976864779 -0500
+++ /tmp/tmp.L8bIAVDsFo	2024-11-25 09:11:16.968567367 -0500
@@ -6,15 +6,18 @@
 Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
 Acked-by: Conor Dooley <conor.dooley@microchip.com>
 Signed-off-by: Paolo Abeni <pabeni@redhat.com>
+
+(cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
+Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
 ---
  Documentation/devicetree/bindings/net/fsl,fec.yaml | 7 +++++++
  1 file changed, 7 insertions(+)
 
 diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
-index 5536c06139cae..24e863fdbdab0 100644
+index b494e009326e..9925563e5e14 100644
 --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
 +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
-@@ -183,6 +183,13 @@ properties:
+@@ -182,6 +182,13 @@ properties:
      description:
        Register bits of stop mode control, the format is <&gpr req_gpr req_bit>.
  
@@ -28,3 +31,7 @@
    mdio:
      $ref: mdio.yaml#
      unevaluatedProperties: false
+-- 
+2.34.1
+
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

