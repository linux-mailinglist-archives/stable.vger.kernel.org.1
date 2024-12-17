Return-Path: <stable+bounces-104538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F7C9F51BE
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8612D1888125
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42291F6671;
	Tue, 17 Dec 2024 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WczKGPXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87C1F37BE;
	Tue, 17 Dec 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455357; cv=none; b=QtZTXhAuyBuPkE0wIhIHci177sLvz8xKWVi0rbxXyx/mmoR/jWSEWqbRDdD82eYgrmdUQ9Wc0bWa6Quav8tQ8MxA63EMLymsBa3jjzzdEge54ynZpIvlc7+TSFVjOUORICS5GBbTjh42xbrgbOHrDtOz7P4/pXVYfeFqfzHCnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455357; c=relaxed/simple;
	bh=Iann/wFmLIj9xWof4Ztst2ntKja20OXa6BE3zEZslqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuwR7GuSf+ckJuiwgspTpiMzy4amlRf1dilK6QCLiVKQ/SUCIk72AfQot7crj4Wk6wM1TedW0zi9WBRLrO5ehNYqIjfIrpK0pEGpRt0vlkXpDyr6nRtAu7hoU437PlVmS5naCKa2hx7Pey4NEmEipkV5/aQ5bs6mBzu0SLoByVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WczKGPXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA032C4CED7;
	Tue, 17 Dec 2024 17:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455356;
	bh=Iann/wFmLIj9xWof4Ztst2ntKja20OXa6BE3zEZslqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WczKGPXMCsqSkvstZPvelNh9YkMmSaxKjWQDr6OgbjGmAWjTUvb0tgVGeNdWEcxUd
	 QkDOqhlwTxDt/LcJ0Upa7xSOrpgi44LSdsthPV7R3fD0xQeHRQXHcXD3Fu9NSflF+5
	 Oc35Q9CvFzO3V55p/62cmMkWORdvx96ITwHS1EZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 5.4 01/24] usb: host: max3421-hcd: Correctly abort a USB request.
Date: Tue, 17 Dec 2024 18:06:59 +0100
Message-ID: <20241217170519.070064694@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170519.006786596@linuxfoundation.org>
References: <20241217170519.006786596@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>

commit 0d2ada05227881f3d0722ca2364e3f7a860a301f upstream.

If the current USB request was aborted, the spi thread would not respond
to any further requests. This is because the "curr_urb" pointer would
not become NULL, so no further requests would be taken off the queue.
The solution here is to set the "urb_done" flag, as this will cause the
correct handling of the URB. Also clear interrupts that should only be
expected if an URB is in progress.

Fixes: 2d53139f3162 ("Add support for using a MAX3421E chip as a host driver.")
Cc: stable <stable@kernel.org>
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20241124221430.1106080-1-mark.tomlinson@alliedtelesis.co.nz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/max3421-hcd.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -785,11 +785,17 @@ max3421_check_unlink(struct usb_hcd *hcd
 				retval = 1;
 				dev_dbg(&spi->dev, "%s: URB %p unlinked=%d",
 					__func__, urb, urb->unlinked);
-				usb_hcd_unlink_urb_from_ep(hcd, urb);
-				spin_unlock_irqrestore(&max3421_hcd->lock,
-						       flags);
-				usb_hcd_giveback_urb(hcd, urb, 0);
-				spin_lock_irqsave(&max3421_hcd->lock, flags);
+				if (urb == max3421_hcd->curr_urb) {
+					max3421_hcd->urb_done = 1;
+					max3421_hcd->hien &= ~(BIT(MAX3421_HI_HXFRDN_BIT) |
+							       BIT(MAX3421_HI_RCVDAV_BIT));
+				} else {
+					usb_hcd_unlink_urb_from_ep(hcd, urb);
+					spin_unlock_irqrestore(&max3421_hcd->lock,
+							       flags);
+					usb_hcd_giveback_urb(hcd, urb, 0);
+					spin_lock_irqsave(&max3421_hcd->lock, flags);
+				}
 			}
 		}
 	}



