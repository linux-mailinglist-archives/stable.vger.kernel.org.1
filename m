Return-Path: <stable+bounces-8640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45A81F78D
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 12:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18551F219EE
	for <lists+stable@lfdr.de>; Thu, 28 Dec 2023 11:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C106863DB;
	Thu, 28 Dec 2023 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HJcpH46p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5D6FB6
	for <stable@vger.kernel.org>; Thu, 28 Dec 2023 11:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF99CC433C8;
	Thu, 28 Dec 2023 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703761601;
	bh=t2f9hB4YCAcc1Hp+flCb0yJM1i23fiJ0PMSzX99fQiE=;
	h=Subject:To:Cc:From:Date:From;
	b=HJcpH46poknL9kIrOkRonUbjWYo2+WK4Hp86afW83YThwgkoDmhYPhfwCmajrwlhI
	 k2aXDw2fmG/Q6MR07yY2gYncaIP+V2yww7hpNa2oSD3vUL77bO3cfsXnCgn2xoQRVv
	 Nh49rLYJ2cANqaNLeQTk+k0XuRWiE+uvrsom11Xo=
Subject: FAILED: patch "[PATCH] usb: fotg210-hcd: delete an incorrect bounds test" failed to apply to 5.4-stable tree
To: dan.carpenter@linaro.org,gregkh@linuxfoundation.org,lee@kernel.org,linus.walleij@linaro.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 Dec 2023 11:06:33 +0000
Message-ID: <2023122833-thickness-pulp-2179@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7fbcd195e2b8cc952e4aeaeb50867b798040314c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023122833-thickness-pulp-2179@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

7fbcd195e2b8 ("usb: fotg210-hcd: delete an incorrect bounds test")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fbcd195e2b8cc952e4aeaeb50867b798040314c Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Wed, 13 Dec 2023 16:22:43 +0300
Subject: [PATCH] usb: fotg210-hcd: delete an incorrect bounds test

Here "temp" is the number of characters that we have written and "size"
is the size of the buffer.  The intent was clearly to say that if we have
written to the end of the buffer then stop.

However, for that to work the comparison should have been done on the
original "size" value instead of the "size -= temp" value.  Not only
will that not trigger when we want to, but there is a small chance that
it will trigger incorrectly before we want it to and we break from the
loop slightly earlier than intended.

This code was recently changed from using snprintf() to scnprintf().  With
snprintf() we likely would have continued looping and passed a negative
size parameter to snprintf().  This would have triggered an annoying
WARN().  Now that we have converted to scnprintf() "size" will never
drop below 1 and there is no real need for this test.  We could change
the condition to "if (temp <= 1) goto done;" but just deleting the test
is cleanest.

Fixes: 7d50195f6c50 ("usb: host: Faraday fotg210-hcd driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/ZXmwIwHe35wGfgzu@suswa
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 929106c16b29..7bf810a0c98a 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -428,8 +428,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 			temp = size;
 		size -= temp;
 		next += temp;
-		if (temp == size)
-			goto done;
 	}
 
 	temp = snprintf(next, size, "\n");
@@ -439,7 +437,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 	size -= temp;
 	next += temp;
 
-done:
 	*sizep = size;
 	*nextp = next;
 }


