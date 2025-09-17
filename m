Return-Path: <stable+bounces-180378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5BFB7F65E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DE44A6E9E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F4316182;
	Wed, 17 Sep 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqtdSHTU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C62FF678
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115806; cv=none; b=NYxqondd77JEBFzlTaj7fyYGslUMQzTCV67ElksKdgiBq4f79QGP28p9y4XK+Yk9o+EDLtDGJ9qfuKtuP0lKdULEM9YXqb3koXZBalzTV5a5y9tZBqz1w/CUJbaqLtynnN34DpcyVHzlhFbUO43EDm2NsGmi+z4BRs18e4V82k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115806; c=relaxed/simple;
	bh=tBMoHpze395ju8ID7VqUXTLENRbthCPqoi+GFgPli7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g16tb2E0yhKfZU4Jq2umxGxBtngEB8pXUlM82NyKtRgpSI+FhdcppEyte2FMIF/MDw1j3jP9hZlRcTWimllId9AofUpEFm1JcqRSG7Ld4Jow0rsIn7nJE09+IUySOIpidyJsl7v/1bMrcqRwCbocPFo98PSP/9GL21dLXRraFj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqtdSHTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A157C4CEF5;
	Wed, 17 Sep 2025 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115805;
	bh=tBMoHpze395ju8ID7VqUXTLENRbthCPqoi+GFgPli7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqtdSHTUEtzfZBevWy/zr6tDd/HxATinm2y0ej8XWART3WnDjrTFoTSRFID1E6GFB
	 W5SH0Yof1o84xpmOdpRK8HmEoyOWE7itents8SVbn7+nCiIoCiPN+fLYNkX7TgQrwD
	 K6c/vbEKRFSSQveF4W/HIF0a8cjd9XyC0glAKNTAnXuOTmcxSPJ1s9GHbZP7AUhaTH
	 ZT0Jmg2rHzACHO/518HXQqRQzR+9OdXSxgXQMTLYb360zuzNmRDNS4sOECKbDPwBfX
	 rj/bUD4VQhuyVI2V+fOgUtYPkFQhtr5qQEXR3C8xbQC/Z7yWe/b9bv++3GIKa40MW2
	 R0AhADIOxAWQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakob Koschel <jakobkoschel@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] usb: gadget: dummy_hcd: remove usage of list iterator past the loop body
Date: Wed, 17 Sep 2025 09:30:02 -0400
Message-ID: <20250917133003.551232-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091724-yeast-sublet-dc69@gregkh>
References: <2025091724-yeast-sublet-dc69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakob Koschel <jakobkoschel@gmail.com>

[ Upstream commit 7975f080d3557725160a878b1a64339043ba3d91 ]

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Link: https://lore.kernel.org/r/20220308171818.384491-26-jakobkoschel@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8d63c83d8eb9 ("USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 58261ec1300a8..47e97679a2adf 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -748,7 +748,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	struct dummy		*dum;
 	int			retval = -EINVAL;
 	unsigned long		flags;
-	struct dummy_request	*req = NULL;
+	struct dummy_request	*req = NULL, *iter;
 
 	if (!_ep || !_req)
 		return retval;
@@ -760,13 +760,14 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 
 	local_irq_save(flags);
 	spin_lock(&dum->lock);
-	list_for_each_entry(req, &ep->queue, queue) {
-		if (&req->req == _req) {
-			list_del_init(&req->queue);
-			_req->status = -ECONNRESET;
-			retval = 0;
-			break;
-		}
+	list_for_each_entry(iter, &ep->queue, queue) {
+		if (&iter->req != _req)
+			continue;
+		list_del_init(&iter->queue);
+		_req->status = -ECONNRESET;
+		req = iter;
+		retval = 0;
+		break;
 	}
 	spin_unlock(&dum->lock);
 
-- 
2.51.0


