Return-Path: <stable+bounces-149599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DF4ACB354
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873C31948353
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3322B8CF;
	Mon,  2 Jun 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hm1kDNXl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4C1CBA18;
	Mon,  2 Jun 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874447; cv=none; b=JwiVvg97x4y6e33I6zILVV4m0WDxZf0x920WMhcpA2lgbtlItbpZoM+EeAzmCFqAoVyh3El0jVRqVZgWNiIC0S1DT0fs3YdvmofgFsikHb3J/mz1uXtcqLbW0jPMOqmIHzPb+BHQbp2RbRF4M3GeEntmy8PS8zsnZxEYSyxZ6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874447; c=relaxed/simple;
	bh=GhlcC37eAoiIWb+iJXN2nniluH09D3qtMLYQSPgEqyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0yyX6CDKsR656Lg/LlScd/WOwyRoo+PRzXh74wZvOVjJYKSEdotruC8j4Dx6Hr78Wf5JeP6c7rZBbk0YRHI3gOH6B9QcO1Tce7xJbj/PEe25gPOZ9GYXSFqjlFV9eEppfIMA2+9Dq/rJhlFe73kTjR6dNBCgK1t3D7yUOen19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hm1kDNXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270C4C4CEEB;
	Mon,  2 Jun 2025 14:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874447;
	bh=GhlcC37eAoiIWb+iJXN2nniluH09D3qtMLYQSPgEqyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hm1kDNXlEfOauMHo1ZbqUKXAeCpvJVSzQhI9T6vH3EamNQ3TS8fhwCwPbLh2yKShe
	 8boxTn1hz/jG6O+lXNBwpoZxF67WYXBlEP7YjUbtcZrBOpTY9BZ672vEi7TrLDFhEZ
	 aPVTagQpN9oQYdEubvRJwFA4HELLpM2XYYYvx7C8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chen <peter.chen@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 026/204] usb: chipidea: imx: change hsic power regulator as optional
Date: Mon,  2 Jun 2025 15:45:59 +0200
Message-ID: <20250602134256.712401903@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chen <peter.chen@nxp.com>

[ Upstream commit 7d5ec335f94e74e885ca2f6c97a3479fe9fe3b15 ]

Not every platform needs this regulator.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
Stable-dep-of: 8c531e0a8c2d ("usb: chipidea: ci_hdrc_imx: implement usb_phy_init() error handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 0fe545815c5ce..09a7bee7203c5 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -369,7 +369,8 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 			return PTR_ERR(data->pinctrl_hsic_active);
 		}
 
-		data->hsic_pad_regulator = devm_regulator_get(dev, "hsic");
+		data->hsic_pad_regulator =
+				devm_regulator_get_optional(dev, "hsic");
 		if (PTR_ERR(data->hsic_pad_regulator) == -EPROBE_DEFER) {
 			return -EPROBE_DEFER;
 		} else if (PTR_ERR(data->hsic_pad_regulator) == -ENODEV) {
-- 
2.39.5




