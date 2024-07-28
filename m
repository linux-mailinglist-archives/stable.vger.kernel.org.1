Return-Path: <stable+bounces-62294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E5293E81C
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AAB31F21519
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9415D5A6;
	Sun, 28 Jul 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYhWktkA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BB15CD64;
	Sun, 28 Jul 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182923; cv=none; b=aczOsoHE7auGWhG0CNKFOZAVqqNnDFJkNCw9IFZgPf7P6V+s5KVzk9XS//YEdVy33TiwcJQQt8jpo/vhko5VwfqnM15TatMs58ISGalNjdAsXwvB8Hwn00hQbvU2ug+oxIhvdj8XrYwnDFHNV0pCk5btcnGcHJJTYZ/BhTpxATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182923; c=relaxed/simple;
	bh=AMyrZkeFei7kfoMV7PgU6V6mZ5tguz2djO7KA35Lg2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Da54Az9JEnBApiyvDqyCx/erOjTFmPPzPt1avwJArjYpK3A15aXWpAV57bFLiOfsUcGJVI4bogeYkLwv8xihCrQm1xthYpAWrdV2tIYyz56gIKXpXu9yS0JRKwwoEQOl8mZ7+4+f3OzDn1V1QRnZdDIkXs84ZmYSaLIjG/R/VOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYhWktkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8446C32782;
	Sun, 28 Jul 2024 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182923;
	bh=AMyrZkeFei7kfoMV7PgU6V6mZ5tguz2djO7KA35Lg2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYhWktkAeDuxCfIoAojWQqip/tC1zUolhfOStnILI35+1YLOa7h0zGuwDjfN7tGLW
	 BUj4O7fhgYzzIYsh/OiXEBqkg2ZCWV1nrnGy+b42fV9cWn6OhLWL604PWCatczIhIF
	 143kvvZBY2NcDHr6JYSFoQIG8LAeO5C0pR9X4rmooHPHIv+1RFwwEIkoHSyYcAWo98
	 ahSOIMYpl4y5e9MqYsWiMRgMgbE+0PLChvLj8rt1XwRGfLLKDmAkqFtUHyeB6rJ1/o
	 gE05BrVIeAeAMVvlyTFyxyFqb8ieqOVGtTXf5qNBq2H9y/njvWJ9NXQT664oLlaUs4
	 rBnh0oGOV5D9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	neal_liu@aspeedtech.com,
	joel@jms.id.au,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 11/15] usb: gadget: aspeed_udc: validate endpoint index for ast udc
Date: Sun, 28 Jul 2024 12:07:55 -0400
Message-ID: <20240728160813.2053107-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit ee0d382feb44ec0f445e2ad63786cd7f3f6a8199 ]

We should verify the bound of the array to assure that host
may not manipulate the index to point past endpoint array.

Found by static analysis.

Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Link: https://lore.kernel.org/r/20240625022306.2568122-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index cedf17e38245d..1a5a1115c1d96 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1009,6 +1009,8 @@ static void ast_udc_getstatus(struct ast_udc_dev *udc)
 		break;
 	case USB_RECIP_ENDPOINT:
 		epnum = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (epnum >= AST_UDC_NUM_ENDPOINTS)
+			goto stall;
 		status = udc->ep[epnum].stopped;
 		break;
 	default:
-- 
2.43.0


