Return-Path: <stable+bounces-84495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F5899D078
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239171C21366
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD121AE006;
	Mon, 14 Oct 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0ltzAIW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF51AAE38;
	Mon, 14 Oct 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918206; cv=none; b=uvZjDxfhRRlXAYo9W1hLJao71nc0/Pub8AdD9fFQ48VSDFhcWHsxMbgKdJ5WUSaPA3MdVm/MLoWrEDaA8VNTS+3LrzNrGOSTqPn0rn7OjF0L5vXINs1pxvL+smQssVmF1UI0mYqWAt70kBXINOOnv4i1f+Y/sf0O5l7cKQNvY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918206; c=relaxed/simple;
	bh=BhudRIa9m+ZQeNH4vmFPwewbYDCsH+ZxIK/cnJ0PCyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMt+Y3lUJksfCChR9hDfWRxjBnmF4VJe7Tm71ZsYTXoyVGOWthQVm6KEJxbQmmhfgyz2dAjSLkcII2fWfykoZ9+tId0tVW3fQTkJzFHi4Ey/nZLa1SG6vGVG2i+u68QXMmC9tGU5MAvsIW8ZClwOKU15WFtZjeqKDQwDyLIbv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0ltzAIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B902CC4CEC3;
	Mon, 14 Oct 2024 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918206;
	bh=BhudRIa9m+ZQeNH4vmFPwewbYDCsH+ZxIK/cnJ0PCyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0ltzAIWu/6XRlExEbZBIAtDUN2EKDr/1RyogrJzwPpRkMnUpZTCeWxdt8+7vVGTo
	 34NusC7ta1KRUJ/Zis8LiDFmXnRlbNvpyFOsr4JcVS9PyOtTERSGmohEQepDztGx/D
	 ckXi7kwF1PXFvpAb6BY0X41c7v52NDu/dGo9H1ro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 253/798] dt-bindings: iio: asahi-kasei,ak8975: drop incorrect AK09116 compatible
Date: Mon, 14 Oct 2024 16:13:27 +0200
Message-ID: <20241014141227.874347685@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c7668ac67bc21aebdd8e2d7f839bfffba31b7713 ]

All compatibles in this binding without prefixes were deprecated, so
adding a new deprecated one after some time is not allowed, because it
defies the core logic of deprecating things.

Drop the AK09916 vendorless compatible.

Fixes: 76e28aa97fa0 ("iio: magnetometer: ak8975: add AK09116 support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20240806053016.6401-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index 9790f75fc669e..fe5145d3b73cf 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -23,7 +23,6 @@ properties:
           - ak8963
           - ak09911
           - ak09912
-          - ak09916
         deprecated: true
 
   reg:
-- 
2.43.0




