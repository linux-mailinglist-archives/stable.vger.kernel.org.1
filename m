Return-Path: <stable+bounces-22486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8148085DC42
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14091B246E8
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CFC78B73;
	Wed, 21 Feb 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tEFidDzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572F838398;
	Wed, 21 Feb 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523462; cv=none; b=MBKsiAwf2KDqDzNDG52UInaQUtjclrBN/RnDldeJaJ3wQ8xFx0UE+IJxnqDPAiiMpIaQFxSVzVXdl8N0CZqhsIMPw4UzRKAkGdM0ntwLxFdgPLfTkkT73iDjlLm+y02Eszfa0zCvf3Zu5WjaWEqWu5by2WHVmzV6DqCXA1APFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523462; c=relaxed/simple;
	bh=bWoFotOnLpxZ9o81QeKpToBQPQJt0tww3qMtn8vqht0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqwfCR460sI7sozDRI1oVnRLnUjLvSj8YVFaZC9t2Y41XUNmz0Cpcgw6Ytf/FwEyqcPxJnFKWi0soX16DUDc/EBzczRgZ7pqjtBOirkZBZcpnWewOV4WwJsRAj64KQmJh8+GE5PG3ZIgjjhQQvaLtOEfg0hybMemEWTuxLS7qAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tEFidDzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA99C433F1;
	Wed, 21 Feb 2024 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523462;
	bh=bWoFotOnLpxZ9o81QeKpToBQPQJt0tww3qMtn8vqht0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEFidDzHrQglWI9RU80trL3S7OaN0uy/b5Z/tWii1oLn3fy9urCmgpTFmz/iEZQgj
	 SQFoDlQM25gB3NGM1D6TVD8bhRAnFrhCHzTgZKQIQi+I8q6zjSUCjiJglyA76Kys17
	 hFSDV7FGSwzCEQhGyd2NvVp3rhMPekiQwupZFR6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 442/476] usb: dwc3: gadget: Handle EP0 request dequeuing properly
Date: Wed, 21 Feb 2024 14:08:13 +0100
Message-ID: <20240221130024.384668878@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wesley Cheng <quic_wcheng@quicinc.com>

[ Upstream commit 730e12fbec53ab59dd807d981a204258a4cfb29a ]

Current EP0 dequeue path will share the same as other EPs.  However, there
are some special considerations that need to be made for EP0 transfers:

  - EP0 transfers never transition into the started_list
  - EP0 only has one active request at a time

In case there is a vendor specific control message for a function over USB
FFS, then there is no guarantee on the timeline which the DATA/STATUS stage
is responded to.  While this occurs, any attempt to end transfers on
non-control EPs will end up having the DWC3_EP_DELAY_STOP flag set, and
defer issuing of the end transfer command.  If the USB FFS application
decides to timeout the control transfer, or if USB FFS AIO path exits, the
USB FFS driver will issue a call to usb_ep_dequeue() for the ep0 request.

In case of the AIO exit path, the AIO FS blocks until all pending USB
requests utilizing the AIO path is completed.  However, since the dequeue
of ep0 req does not happen properly, all non-control EPs with the
DWC3_EP_DELAY_STOP flag set will not be handled, and the AIO exit path will
be stuck waiting for the USB FFS data endpoints to receive a completion
callback.

Fix is to utilize dwc3_ep0_reset_state() in the dequeue API to ensure EP0
is brought back to the SETUP state, and ensures that any deferred end
transfer commands are handled.  This also will end any active transfers
on EP0, compared to the previous implementation which directly called
giveback only.

Fixes: fcd2def66392 ("usb: dwc3: gadget: Refactor dwc3_gadget_ep_dequeue")
Cc: stable <stable@kernel.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20231206201814.32664-1-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 7704e2444b4b..d472dab16889 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2039,7 +2039,17 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 	list_for_each_entry(r, &dep->pending_list, list) {
 		if (r == req) {
-			dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			/*
+			 * Explicitly check for EP0/1 as dequeue for those
+			 * EPs need to be handled differently.  Control EP
+			 * only deals with one USB req, and giveback will
+			 * occur during dwc3_ep0_stall_and_restart().  EP0
+			 * requests are never added to started_list.
+			 */
+			if (dep->number > 1)
+				dwc3_gadget_giveback(dep, req, -ECONNRESET);
+			else
+				dwc3_ep0_reset_state(dwc);
 			goto out;
 		}
 	}
-- 
2.43.0




