Return-Path: <stable+bounces-44593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DA8C5390
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D451C22AA0
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685A12A157;
	Tue, 14 May 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xf4YvdkZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E8129E81;
	Tue, 14 May 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686610; cv=none; b=T3rWc73pJYNvvJcfTJU4oh9egyK+sbeoE/Iqw3gph4Yjz/w84x8UMYsTmaLKzT9lsIH5ccFWmxYOrn3+HokFL6ajCGYFubxoB8G4orI3PTlxl6QvLkTei6AUlNmf+tdrarg1B+e6RSkCOJMftVzVv2EOwnFRkMtYtcXd3o0YF78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686610; c=relaxed/simple;
	bh=WbctGedRsQiZeAJ3O9i5Mwg3rioxcFXeVrY9UXu3sUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/OVBTJ4yFYOBJNDGnmPBb7ULc+rUVcW2ctyDsEDp5XkeGTBJcsQ63Be1f4jthwGJlOZMz12Y8gEsUsZ/zYuLt3KyCfTpeGHFqoKWqaE8jBvW4WmUn2t3Dmtyj8XLYSCTpmv7YXTxcL7skf8XZCixNHmeIirmzerFlEXvxZd708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xf4YvdkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E27DC32782;
	Tue, 14 May 2024 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686610;
	bh=WbctGedRsQiZeAJ3O9i5Mwg3rioxcFXeVrY9UXu3sUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xf4YvdkZJoO807lG014Llmq6QdE1jGAEAjJxhVE7sAwXOnR9SOGa37EKRlWa2b7pp
	 uVgC4mhzvrfxwDw6eI6MX8KwopAOtFH+e2xDeFvEucttN6y6h/cA5KTSWspIFA+5oL
	 1WdVrevBX4/a22jhq7jLFt9iSZCzEoK5DcGLXeks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Chris Wulff <chris.wulff@biamp.com>
Subject: [PATCH 6.1 198/236] usb: gadget: f_fs: Fix a race condition when processing setup packets.
Date: Tue, 14 May 2024 12:19:20 +0200
Message-ID: <20240514101027.883510592@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
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
@@ -3414,7 +3414,7 @@ static int ffs_func_setup(struct usb_fun
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);
 
-	return creq->wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
+	return ffs->ev.setup.wLength == 0 ? USB_GADGET_DELAYED_STATUS : 0;
 }
 
 static bool ffs_func_req_match(struct usb_function *f,



