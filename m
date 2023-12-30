Return-Path: <stable+bounces-8849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FEC820527
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4380C281D8E
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A2D79EE;
	Sat, 30 Dec 2023 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sbbQWPHX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E9879DE;
	Sat, 30 Dec 2023 12:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04476C433C8;
	Sat, 30 Dec 2023 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937922;
	bh=sw3CAJlFavRhgtp6D+5lg/PM6ri9b/ZjAFzW1ICV+jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sbbQWPHXARQ9dixj8hjw3h9amA5tO1vRURcsCPQQTIEvW1bDSiTEaJMNk2SkbfKJ+
	 VgTVx7X8PrP75SV711E1HJONBOOdda0QZ3mZ426wu8jmBJ+9rAN2+HXdqcIwVK+Dry
	 DqFLTxGCaamp0DvjkxOymwf3M65rUAD2odcMbQBo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 6.6 115/156] usb: fotg210-hcd: delete an incorrect bounds test
Date: Sat, 30 Dec 2023 11:59:29 +0000
Message-ID: <20231230115816.121596517@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 7fbcd195e2b8cc952e4aeaeb50867b798040314c upstream.

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
---
 drivers/usb/fotg210/fotg210-hcd.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -428,8 +428,6 @@ static void qh_lines(struct fotg210_hcd
 			temp = size;
 		size -= temp;
 		next += temp;
-		if (temp == size)
-			goto done;
 	}
 
 	temp = snprintf(next, size, "\n");
@@ -439,7 +437,6 @@ static void qh_lines(struct fotg210_hcd
 	size -= temp;
 	next += temp;
 
-done:
 	*sizep = size;
 	*nextp = next;
 }



