Return-Path: <stable+bounces-179833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF64B7C54B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5105461879
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 11:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E7C37288E;
	Wed, 17 Sep 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsAcESCy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396A372885
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110270; cv=none; b=DbPlojjn4wr6jtm4ojWrZf3oorFNADRScnfV33AXQ3m4YPfViEYNDwU+zvMr6A7cplID25qMxZpQPxLxdsKgzVwfSk0jtllJB2T75LN7T4SjTa3m4LmRGoRMRtsjdlRgVRo2HbWNbfIUjPiVNQuOFXJMKOwW1v8SS+vuCsdv2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110270; c=relaxed/simple;
	bh=5VkndjsK/oxlCUa/BjmXCCb7RTeDO63F1wNlTbQJtWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2Ri4HL91+GL7FOCrj4Y3YOsWYY+7erkVxz5enrpNFcE94tgT45gxICew+8anmRvOtvRpz+gucyUodLW3YzoAxfxxcXZfGMmQ9KhGIAOs/v/0ur8A7QhpZY7tpIsxQvBu1ICcqOn60JVP7zRQ8pX3Dxn8+VPLfojzvkgr+1dy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsAcESCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DABCC4CEF7;
	Wed, 17 Sep 2025 11:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758110270;
	bh=5VkndjsK/oxlCUa/BjmXCCb7RTeDO63F1wNlTbQJtWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YsAcESCyvTTN6UX5wSfwEAm9uXLVmSM2W1pDMo2c3nnax+BTs8YflVWgsF8if7rDJ
	 gPmh2RcIOdMvZ/a1gAT5nf28jCm8Cv5WpuuFZO25CqbeFmZwp9sP5AOjP14gr6oyk7
	 6o0Dc2f45PbFY1Fnew5VmYM9bkkvjS5leR7wUw3xuiOWUiaBdWf0MvvZLITYS+vN2q
	 ODvrJL9/XXJdFHuojgSrZZU8J+ZYPEyeTW64Xj0vL5SPlEm72NCmSD9N677ju4Yc9N
	 7MSBovHjpUXlZfQn4UeDGCVoIj8MbmX14uX4fB2JZrimWCcAureFPI/5IYMLjQI9il
	 02VFl0oMytagQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yixun Lan <dlan@gentoo.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/3] dt-bindings: serial: 8250: spacemit: set clocks property as required
Date: Wed, 17 Sep 2025 07:57:45 -0400
Message-ID: <20250917115746.482046-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917115746.482046-1-sashal@kernel.org>
References: <2025091759-buddy-verdict-96be@gregkh>
 <20250917115746.482046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yixun Lan <dlan@gentoo.org>

[ Upstream commit 48f9034e024a4c6e279b0d040e1f5589bb544806 ]

In SpacemiT's K1 SoC, the clocks for UART are mandatory needed, so
for DT, both clocks and clock-names property should be set as required.

Fixes: 2c0594f9f062 ("dt-bindings: serial: 8250: support an optional second clock")
Signed-off-by: Yixun Lan <dlan@gentoo.org>
Acked-by: "Rob Herring (Arm)" <robh@kernel.org>
Link: https://lore.kernel.org/r/20250718-01-k1-uart-binding-v1-1-a92e1e14c836@gentoo.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 387d00028ccc ("dt-bindings: serial: 8250: move a constraint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 2766bb6ff2d1b..e46bee8d25bf0 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -272,7 +272,9 @@ if:
           - spacemit,k1-uart
           - nxp,lpc1850-uart
 then:
-  required: [clock-names]
+  required:
+    - clocks
+    - clock-names
   properties:
     clocks:
       minItems: 2
-- 
2.51.0


