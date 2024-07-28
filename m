Return-Path: <stable+bounces-62259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DABB93E7AF
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4918A1C2144A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFB513AD3F;
	Sun, 28 Jul 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utYpxDxp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E113AD07;
	Sun, 28 Jul 2024 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182781; cv=none; b=Skb8K3CLLcw11+EFNsEpV3x4qZ8bFC+oS6PXng6DcLV9Ud9sThNCaOIBJFOeNVSTnZkhia9hz9DKq4KMQsge2DU3RwOJWqmmW3ruJaLBaDojm26kdgquyXWzgsOZJwfjf6OIhMnTn6RbFBoM25f92FYxPloCshBjNDT3Z4H8rfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182781; c=relaxed/simple;
	bh=Tcwwtvo3ZLDBG1U9pzD8XiY8uu586Uga2SiPIeuqrv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl4otdELkEymLquO6l+Nk7mXsEiC4Nb7BTylIp5ILYWIhXbxpWKosV/Hj5XAZp48MJmhKEWOdrSLF6Asn1kEJg566528T8q19u3yS5Nmg2eT3JCBlglaNoVOQRdudwbaIyYUj6gqe8mStyW4aEsIoNF5Er1DTMJ5A5bUjALgsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utYpxDxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C351FC32782;
	Sun, 28 Jul 2024 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182781;
	bh=Tcwwtvo3ZLDBG1U9pzD8XiY8uu586Uga2SiPIeuqrv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utYpxDxpllBgOW4l7Bx+Hmq7oTHTDXmHggZSUXIbEoQRwUG66RfxP4mSE7GvZpR7Z
	 FwfF1zvrmbqcYKOeDuUShV5OtuRoC9GwNVvrJRtnODf02t1jYAFehjS4Hb8qFATZtQ
	 L4KK13UUkychZ4T8WVJhNjbiYvzSE8TDF0W8r+3HcrtgR2AbblC+11C2bSd/TueyEu
	 BAVtNxOqnW+WfkgsTongpSr5AF66LhFbohh3o0WLFvCpKkHieoIV319kkYsIeScQKE
	 i1Auxp1dh+JGFgW3No1IkLzxdt40ewMg9nqskXPZfTAypgvb1rdCPcp4X7QnES/iRc
	 MrAb93LQagWhg==
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
Subject: [PATCH AUTOSEL 6.10 16/23] usb: gadget: aspeed_udc: validate endpoint index for ast udc
Date: Sun, 28 Jul 2024 12:04:57 -0400
Message-ID: <20240728160538.2051879-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 821a6ab5da56f..f4781e611aaa2 100644
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


