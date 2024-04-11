Return-Path: <stable+bounces-38882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7931A8A10D7
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B84B23F07
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7E7147C86;
	Thu, 11 Apr 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZ4ntCCQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEE179FD;
	Thu, 11 Apr 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831871; cv=none; b=Pru3VJFkojKRGPH7CS3hn4HWGNev/48dgyEiAzlf5X5upUWBbAHOPbwKDBPLC/v4w8FWgycYI51XVfZko14+25RPQ1++O+CWUa3o84ZpvXi8Ai6vd6FDCySt8KXUYWk4/8tDuYxqP/3CUHHUVeLYshzqYpAAuRGqHN4JmtZJwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831871; c=relaxed/simple;
	bh=s+cYk7q/Mew1M5G3L4R/RtoNVc3AbjaYX1pzpQRPKnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYkmHbfS7lrREdhvtH/kovF/yEo0+i5aj2c9i/7tg9opYhXA5uE0Olufz6KLFFIAbyZTwLNo048WAAAyrDQ9MZzd32DWbxfNqGzozHYnMFqE0kFaDdsPD/h0WpkAVEzkIicwM0cTS79lxoUQokc+s/Y+Ws156zMK3o5cHT1k1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RZ4ntCCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F41C433C7;
	Thu, 11 Apr 2024 10:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831871;
	bh=s+cYk7q/Mew1M5G3L4R/RtoNVc3AbjaYX1pzpQRPKnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZ4ntCCQVVLCyvnG7OkiLWj2+1mrUNirxxyZWdp5Fz/W9OSLyQ4beWouhn9d2mUkX
	 A3nJ9lCzb8Sh2TrhKk/nEhvRbPlCpwhJCDG3H0lyD1mbX25OJRnXQTv/0Ka7nrZ1hR
	 AibDEgLS+CO/MlqzTZ3a+CU0HM2DDx5rlmzUO8Uk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Sperbeck <jsperbeck@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 155/294] init: open /initrd.image with O_LARGEFILE
Date: Thu, 11 Apr 2024 11:55:18 +0200
Message-ID: <20240411095440.316071370@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

From: John Sperbeck <jsperbeck@google.com>

commit 4624b346cf67400ef46a31771011fb798dd2f999 upstream.

If initrd data is larger than 2Gb, we'll eventually fail to write to the
/initrd.image file when we hit that limit, unless O_LARGEFILE is set.

Link: https://lkml.kernel.org/r/20240317221522.896040-1-jsperbeck@google.com
Signed-off-by: John Sperbeck <jsperbeck@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/initramfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -589,7 +589,7 @@ static void __init populate_initrd_image
 
 	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
 			err);
-	file = filp_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
+	file = filp_open("/initrd.image", O_WRONLY|O_CREAT|O_LARGEFILE, 0700);
 	if (IS_ERR(file))
 		return;
 



