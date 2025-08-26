Return-Path: <stable+bounces-173445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B62B35D85
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF281880933
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D4340DA1;
	Tue, 26 Aug 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tdMZb2ES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F8A33A03C;
	Tue, 26 Aug 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208267; cv=none; b=dA4vcHKzN8ileJfobZwwXmDOEDPAFFAwER/1plpDlGkqt/H1XIQtibKNf/bQt+V5tliWmH+Zk5cb4Pl4Asu8GOq/wWL2RSmJV2PscMjLb1bwsm4QI0px9Bxs+HCCJETmkdhlifCNB2IEjb3qhzFpdmJN/IRQZyABbJ6lnc611DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208267; c=relaxed/simple;
	bh=7s1gy1+aUWXSGel2r4HB9KJ41AU5EsSJeFPobkE6/ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeRliqUHY6hPpKRitLGu3ZimWYI8S0ccn8rBoIBnFPspooaAfGj2im73pd9Fnz/gglT6xqR5XCiAkcf805/wdI/Otm4qRZ5c4sZLrjt/nVlNvhcycZ65BLWfg8VpLzePa11QcYW1o30wESToJAZcxWuDS8mwmsy1k8m9rQXIcDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tdMZb2ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD538C116B1;
	Tue, 26 Aug 2025 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208267;
	bh=7s1gy1+aUWXSGel2r4HB9KJ41AU5EsSJeFPobkE6/ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdMZb2ESOSqRwHcbz/kXRKVpiPd6eK0t+YodqXBZ00RzjHsGEiWEAzIJLVaSbwIvI
	 yFtdkGeMpQpcjAStmPGt+I1gdCN7/mr3jEjjP9FYcjMYEKe8w1CPdeNCNVc/JR9VlS
	 p2LHfyqwM6nQubds3Zb8s+8k/FNeiZxs8x/+CfSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.12 046/322] dt-bindings: display: sprd,sharkl3-dsi-host: Fix missing clocks constraints
Date: Tue, 26 Aug 2025 13:07:41 +0200
Message-ID: <20250826110916.527854341@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

commit 2558df8c13ae3bd6c303b28f240ceb0189519c91 upstream.

'minItems' alone does not impose upper bound, unlike 'maxItems' which
implies lower bound.  Add missing clock constraint so the list will have
exact number of items (clocks).

Fixes: 2295bbd35edb ("dt-bindings: display: add Unisoc's mipi dsi controller bindings")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20250720123003.37662-4-krzysztof.kozlowski@linaro.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -20,7 +20,7 @@ properties:
     maxItems: 2
 
   clocks:
-    minItems: 1
+    maxItems: 1
 
   clock-names:
     items:



