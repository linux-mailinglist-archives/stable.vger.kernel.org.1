Return-Path: <stable+bounces-132934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A81A9187A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3237319E24D1
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD23225A59;
	Thu, 17 Apr 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T9CEMoyI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EA1C84AD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883905; cv=none; b=hfyN/e7I3OQs+bt7kYwUoMn0bZWhU5uTXsoY1krIyslCCQ5wPTHVf0ZmmWXEURUKfKbd0hokb4zeGlgP42umZbynnO3xwipyXcx8jwp8mwThxMx/8zJjAvsq0yrWHpgnXVykIVPfFur67xdXKdzR433cECop3IzGaHRXfgpudWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883905; c=relaxed/simple;
	bh=sDN1dvkG3mfXslkyDWfZSUsM/WN/vgqFgH8cozYzAbA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uSWWPbYXb7Cehdfvaw/5O3yFH7FNxIWgDzAk5J9g7msicOvRwgHCBIZNPst93/rc4WTCtvPkMK3ZeO8ZfzNVHgnjJ8eGoQvwrohbYv65CQtm0WyJA+n4TatO6Q4PUfJ3VFfH3+ZLegti+jWXO7s0Pfc4Z1q/Tl3EW+jJqT+ySnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T9CEMoyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583DDC4CEE4;
	Thu, 17 Apr 2025 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744883904;
	bh=sDN1dvkG3mfXslkyDWfZSUsM/WN/vgqFgH8cozYzAbA=;
	h=Subject:To:Cc:From:Date:From;
	b=T9CEMoyIvNsE1m5kUcZkCkibFlcqm+vwdorRw28TUJQpA9H3dZMA6nZ0Mc+We4h+c
	 bHEbClu/Ra0GtzeEz/hhtmwLfI0U/7wdKTv2zWDDjP3v7d2SK9EyA1X4MBfhKlByBe
	 Qrk8I6lCwgpSEoYJJxtZezOsJigiR+eh+9bRsUV0=
Subject: FAILED: patch "[PATCH] auxdisplay: hd44780: Fix an API misuse in hd44780.c" failed to apply to 6.1-stable tree
To: haoxiang_li2024@163.com,andriy.shevchenko@linux.intel.com,geert@linux-m68k.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 11:58:13 +0200
Message-ID: <2025041713-morphing-vividly-c492@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9b98a7d2e5f4e2beeff88f6571da0cdc5883c7fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041713-morphing-vividly-c492@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b98a7d2e5f4e2beeff88f6571da0cdc5883c7fb Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Mon, 24 Feb 2025 18:15:27 +0800
Subject: [PATCH] auxdisplay: hd44780: Fix an API misuse in hd44780.c

Variable allocated by charlcd_alloc() should be released
by charlcd_free(). The following patch changed kfree() to
charlcd_free() to fix an API misuse.

Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 0526f0d90a79..9d0ae9c02e9b 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -313,7 +313,7 @@ static int hd44780_probe(struct platform_device *pdev)
 fail3:
 	kfree(hd);
 fail2:
-	kfree(lcd);
+	charlcd_free(lcd);
 fail1:
 	kfree(hdc);
 	return ret;
@@ -328,7 +328,7 @@ static void hd44780_remove(struct platform_device *pdev)
 	kfree(hdc->hd44780);
 	kfree(lcd->drvdata);
 
-	kfree(lcd);
+	charlcd_free(lcd);
 }
 
 static const struct of_device_id hd44780_of_match[] = {


