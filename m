Return-Path: <stable+bounces-44900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6818C54E5
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D9428AB90
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23E57CA1;
	Tue, 14 May 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGvaJ/hD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090844CB2E;
	Tue, 14 May 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687503; cv=none; b=dnSSRTG0Nb2qZ5qRH0rRFjQHMn5Vjh+5xv80fucWHb/RYypnfChvU9hVOwOQf7OvYo0wYhvwjbcE8pVsECpoc7nSZemEBQanWmc2vNAMaGwWkx2wgfGNsUUmCZgwW6gLT5figDutfY13rUECWBNQendp7UCfuIxCu2VdOEm+jCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687503; c=relaxed/simple;
	bh=jJL1JvWE0USOI3rbz3VvcakyPWzfglCaCuelOyVkzuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYgF51MbfZ6RPFNUHlUpwCAgmcNBSKru0RPxrFr70VRGo5+ezbYnqn24fRTeJqj9WIvpFMaEht6foqfIYSuUYhJn5zSu17n/saOqdRyS63CTYGkdx/BeFjvYN6MmWH3cGHs1xmpxnb3uyLZ0OUFBI8hfP6ib65nAnt7EY6BafBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oGvaJ/hD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DACC2BD10;
	Tue, 14 May 2024 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687502;
	bh=jJL1JvWE0USOI3rbz3VvcakyPWzfglCaCuelOyVkzuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGvaJ/hD8A71YL5omPmCIZ0Ujwsc4fVCKXBXF6++W8DmCs7gMukTRejwCuZ/T2jQy
	 9m+c7ns1u22ubsvO2fUr8GU0IgoW49ZMjnEWuhJJlg6dNkbe4D0U6BAuEXqMd6j73j
	 aZVSqONDoriQNvh4RHVPRJoDJ2ve0656fC83Utzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Chris Wulff <chris.wulff@biamp.com>
Subject: [PATCH 5.10 097/111] usb: gadget: f_fs: Fix a race condition when processing setup packets.
Date: Tue, 14 May 2024 12:20:35 +0200
Message-ID: <20240514101000.815701644@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wulff <Chris.Wulff@biamp.com>

commit 0aea736ddb877b93f6d2dd8cf439840d6b4970a9 upstream.

If the USB driver passes a pointer into the TRB buffer for creq, this
buffer can be overwritten with the status response as soon as the event
is queued. This can make the final check return USB_GADGET_DELAYED_STATUS
when it shouldn't. Instead use the stored wLength.

Fixes: 4d644abf2569 ("usb: gadget: f_fs: Only return delayed status when len is 0")
Cc: stable <stable@kernel.org>
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
Link: https://lore.kernel.org/r/CO1PR17MB5419BD664264A558B2395E28E1112@CO1PR17MB5419.namprd17.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3403,7 +3403,7 @@ static int ffs_func_setup(struct usb_fun
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);
 
-	return creq->wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
+	return ffs->ev.setup.wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
 }
 
 static bool ffs_func_req_match(struct usb_function *f,



