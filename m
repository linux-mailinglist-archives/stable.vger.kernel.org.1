Return-Path: <stable+bounces-62278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF093E7ED
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE44283674
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0EF1474D4;
	Sun, 28 Jul 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW3jWl1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9A1474BF;
	Sun, 28 Jul 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182862; cv=none; b=Yf/fBYaTUWRMzK0x+9eM16760Bh3DEcCXVusAwCiJ8G/+ZzVtM++MuwHHuad71ZTplpp/SVBhRi/JhWuPqcR72u7/g3Z5oQaEd9JjYa9daOiLOhKeh/XK4ZOcoq8ovRrgOI9Ho6XhIB+e7jY1FFQEnX5MoicSl2Jt4dtzSvTVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182862; c=relaxed/simple;
	bh=Hv2mfnRlffbbfCzYBIwAUMCTK9WEX5CKZn4YhFzdeuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTyohypAYuaTzWzj8OEgcRku8nkusd36mmAQd1GlFndy6nfOfSob48AIQkKF8ftRoUT1K4JhjQ3h6ynuGa0agyOonpUIJzi88n7IvL4U7haxSIPFb+23SIhE+h5Y1zU8+uej55XCm7LgvDN86UQAWyHJmH5kCqLRbGtrhBrB5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW3jWl1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB19DC32782;
	Sun, 28 Jul 2024 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182862;
	bh=Hv2mfnRlffbbfCzYBIwAUMCTK9WEX5CKZn4YhFzdeuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BW3jWl1rPpIqyu3XJ3/ZZMVnTm92P3dBpLcyukyh8VWIHyKyxbT6td5zDMvTuYHMJ
	 gfE2LAKywm8yhqtRBqd6vIMiTCpX2ehXANIvQrBB/5j9a3ZZ9/6lNxV1yGxSdNson3
	 ywjCGM/o05jlc4LwkTHIPJ01MmJ7XXJd4+DStBsJ8+JMYTrwn8AiLFktusgefkEnnX
	 qEESoPIRLX2MSfa0dPBJJZ/NR3d+rWP9nu6zl0CLtC/YHGsPgqmPRC2FPnLVazcsK5
	 8r5cBLyYI9H5mwm3CfPH4z23ungxHMVUz0jLOywFAKdfLn8nO7sb+FQID/ayXWIcB9
	 YybLjsythiXKQ==
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
Subject: [PATCH AUTOSEL 6.6 12/17] usb: gadget: aspeed_udc: validate endpoint index for ast udc
Date: Sun, 28 Jul 2024 12:06:48 -0400
Message-ID: <20240728160709.2052627-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index fc2ead0fe6217..4868286574a1c 100644
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


