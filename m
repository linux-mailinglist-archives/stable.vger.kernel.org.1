Return-Path: <stable+bounces-154336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA1ADD9AF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB461944C58
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA30623B603;
	Tue, 17 Jun 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D+buchPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942362CCC5;
	Tue, 17 Jun 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178870; cv=none; b=tpzbNIjBJZWDW2EnusZwKuRUOkDanBXk9csccIHKK0eiUaehX6UfCwflFdycLLFFrV8jAPmY6TA4qrY1BxHLrYSZ7HMS87RXIh8wPa0VkMS+434muTTtR/FjmbXxw3RrIV+isgFsyvHwQGvdnD9KkbvvgjcHJNuN6AYib/fBqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178870; c=relaxed/simple;
	bh=jqSuOVKrYqGtQ0VkZGrf2jrO/s649Yqp3MmL9biG4ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnxlSNCxrYE7geyN+UjILRckfFqsZiajqUxu6Gut3nYfCfS3Tbo0GLv7NjIW3OuvZNvhNz+V4i2D9s5agOpg+459iL5z2qukoAetCaKjs29ciGoxZIco3I6KhAs618PGoGPW9DLMLHAOBW+laYeOmT637hh2DUoSiol77N6FuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D+buchPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263D0C4CEE3;
	Tue, 17 Jun 2025 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178870;
	bh=jqSuOVKrYqGtQ0VkZGrf2jrO/s649Yqp3MmL9biG4ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+buchPIJLLG7ZhrPv8uACLn8t7lSsmCheqcS6jZOlvivKPxwHE8ET1v0ZStKlZ9P
	 P9kzSiPFJuKNlbQ/w4AQhuQDUsUMvHxcN3GGHuq9MsKJu94mQ4TB04DOYuSNY7G9wV
	 q7HB2Zw7/vJ6vIVZJvoMDDEGHVVTC46ZCZZUwmrs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 547/780] USB: gadget: udc: fix const issue in gadget_match_driver()
Date: Tue, 17 Jun 2025 17:24:15 +0200
Message-ID: <20250617152513.787395227@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 5f5cc794fac605afd3bef8065e33096aeacf6257 ]

gadget_match_driver() takes a const pointer, and then decides to cast it
away into a non-const one, which is not a good thing to do overall.  Fix
this up by properly setting the pointers to be const to preserve that
attribute.

Fixes: d69d80484598 ("driver core: have match() callback in struct bus_type take a const *")
Link: https://lore.kernel.org/r/2025052139-rash-unsaddle-7c5e@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 4b3d5075621aa..d709e24c1fd42 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1570,7 +1570,7 @@ static int gadget_match_driver(struct device *dev, const struct device_driver *d
 {
 	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
 	struct usb_udc *udc = gadget->udc;
-	struct usb_gadget_driver *driver = container_of(drv,
+	const struct usb_gadget_driver *driver = container_of(drv,
 			struct usb_gadget_driver, driver);
 
 	/* If the driver specifies a udc_name, it must match the UDC's name */
-- 
2.39.5




