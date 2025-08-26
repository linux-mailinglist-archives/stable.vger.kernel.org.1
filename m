Return-Path: <stable+bounces-174091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7BEB3614C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC2A1BA5342
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D983F25DB0A;
	Tue, 26 Aug 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHT7J2uC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E3246333;
	Tue, 26 Aug 2025 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213469; cv=none; b=j2fLZq1CYFn1mlAUb3hqIoEo0l2AGWucdo/WoLqhYr4yF43xxFy6GCYG9IqC4gWv5zXICx7ycVhhK8j4t2HtJr9kOCRcZB3+g2RGjyi2O2uLdBFd7DwpT3lDttwDydZ3x+X3/KTnI0Z5NmC5ahucs2N7+NCz13rzS8d2W9s0+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213469; c=relaxed/simple;
	bh=fEK+VKj3zB4NB8DLKY7IqSWl2jU0FYBzoEOzXkR5mi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9rak4Rw/8UOotfoQ+IF+AMUiaUjEff2jgpK46D3cWJ+y2LU4H+hBwPj4iXXQBWeWJ8rCn4Sm/x+xLQaB2foaIlZKu9Xp4DMObD69Sm7tANbShD8DjH/VjGdnvdKSA85BOHD1ibN8u+04MW4XExlew6AFh5EamjjmuboW8jT5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHT7J2uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1817EC4CEF1;
	Tue, 26 Aug 2025 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213469;
	bh=fEK+VKj3zB4NB8DLKY7IqSWl2jU0FYBzoEOzXkR5mi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHT7J2uCsCTuvoZaU1q+8HoDstUgMT/oIwOUeA2wu8WbXO6d5S9mbzmkcnRsGRBjZ
	 CZfHt6yYBsJtusnyLCWDYZcB+Jb+iqgWFdZewZHeSsPUD7ACUTuGIX9lYwXAGdRsV2
	 3Aj2A/Q/TLrPsuSkAY1hY7LnCEP+AtS627wRQJno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.6 359/587] dt-bindings: display: sprd,sharkl3-dsi-host: Fix missing clocks constraints
Date: Tue, 26 Aug 2025 13:08:28 +0200
Message-ID: <20250826111002.044333172@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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



