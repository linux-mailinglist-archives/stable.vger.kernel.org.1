Return-Path: <stable+bounces-132935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB589A9187B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBDD3BE305
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD321898FB;
	Thu, 17 Apr 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="imuimfvx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EE1C84AD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883908; cv=none; b=GaozPH0QjY9GubGr62pbrw6cQ4k2LwhWh9M3N75QQ7lqMZ4+beJiEVysAbfDLygLuY2cLTIPZTqScnGWlbPZOcv9Tuu+PNyXIvl1K1h+5TCUuAUJNpZwki9cvw5uPSd6B1FjJlbwEG6ZK9p/lbXRDx+KSTxTgAAv4dmgf14soJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883908; c=relaxed/simple;
	bh=/DOvnxOCElwrAvj+VJQGu6mS82vRN/LLO3WNTpoCJ1U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aQvhiQcvzPOutNg7FvTYT4VWefd1jMpuPUoZkrAYhVVtkqUVFaj29YLpJR/y91QEj3sN8CBL3+D+lRkmINZ6DVTi0woDVtROcE0Zq89hZEMR2+v6h9i+EocHv/8VrO2CSnA3BppktBsKNxgY4KDYjSyv1gbj7/Ve0bXBsIgOALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=imuimfvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD23C4CEE4;
	Thu, 17 Apr 2025 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744883908;
	bh=/DOvnxOCElwrAvj+VJQGu6mS82vRN/LLO3WNTpoCJ1U=;
	h=Subject:To:Cc:From:Date:From;
	b=imuimfvxw2rZ+NRwBYN13i+zzMj1DM+JzsptdTGg2O/yi+oaeefv6R37olI0/vA4A
	 4JPE4UvxXnIoMDPj4xMGf6At/4Y1PBEVa8yr531j2kfxyqw8qH8X9PPVk18J57wlPH
	 WgGQBF5768378mzVsyyM9FZHUSrp9i+uRcQwpE48=
Subject: FAILED: patch "[PATCH] auxdisplay: hd44780: Fix an API misuse in hd44780.c" failed to apply to 5.15-stable tree
To: haoxiang_li2024@163.com,andriy.shevchenko@linux.intel.com,geert@linux-m68k.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 11:58:14 +0200
Message-ID: <2025041714-projector-suffix-41d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9b98a7d2e5f4e2beeff88f6571da0cdc5883c7fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041714-projector-suffix-41d5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


