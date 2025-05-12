Return-Path: <stable+bounces-143190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E8BAB3466
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240953AB8A0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C924625A64C;
	Mon, 12 May 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MHensnKW"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DBD25A34F
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044233; cv=none; b=mK4r7SN+RhxXZwL+Egj7WuLuNgpNy0TPfDkC3nZRylPFvbHBW0d8I8EAGH0K9NIFO+ieQG1zhhMbBsTQh3EZVEqHkkofF28LtcT6waLUHIeK4Pc7uiNOWV7cVay2DaBH3e0MuYZ84aHs6HRQhkvIFpfdISCi9mkG0vZ80NsE7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044233; c=relaxed/simple;
	bh=6OyJRp68TTeNkkqmWKrIhnSUl3ITw9MYbzU4HbzirZw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iwsn8ohoDbmWjgX6/aRdPcLG2Ph6N9uCPTvBGzcyI3V/KvAPpn5tZ4yEq0pbmWxypMyRSVb+JyXi9lwKvdLRXvlVsrMDO8B0xaCk8y/eQIL/B2NB+ThdVpALf/fxXJsPHnvh2aqt9RETqbPiE62ySMDcmDY3hCj3SkEFOzrN9vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MHensnKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7611DC4CEE7;
	Mon, 12 May 2025 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044232;
	bh=6OyJRp68TTeNkkqmWKrIhnSUl3ITw9MYbzU4HbzirZw=;
	h=Subject:To:Cc:From:Date:From;
	b=MHensnKWIVxT+Z3sNoOFLzgIfiuK65e8Lc/DgkXdYeqExeTokTYO9N1NIns1kbILx
	 8a4hGtQwXFdE/h2GQOflr0UzYK6HnwmcQYGvuxUZJbwNDAzXEhgLve/tui93lz4vWx
	 EjgfLf0ripVXOrUDWffBMqTAs/rs+loM6c2AzPkI=
Subject: FAILED: patch "[PATCH] iio: chemical: pms7003: use aligned_s64 for timestamp" failed to apply to 6.1-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:03:41 +0200
Message-ID: <2025051241-pushing-regain-cfd8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6ffa698674053e82e811520642db2650d00d2c01
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051241-pushing-regain-cfd8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ffa698674053e82e811520642db2650d00d2c01 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:36 -0500
Subject: [PATCH] iio: chemical: pms7003: use aligned_s64 for timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure that the timestamp is correctly aligned on
all architectures.

Also move the unaligned.h header while touching this since it was the
only one not in alphabetical order.

Fixes: 13e945631c2f ("iio:chemical:pms7003: Fix timestamp alignment and prevent data leak.")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250417-iio-more-timestamp-alignment-v1-4-eafac1e22318@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index d0bd94912e0a..e05ce1f12065 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -5,7 +5,6 @@
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  */
 
-#include <linux/unaligned.h>
 #include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/errno.h>
@@ -19,6 +18,8 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/serdev.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
 
 #define PMS7003_DRIVER_NAME "pms7003"
 
@@ -76,7 +77,7 @@ struct pms7003_state {
 	/* Used to construct scan to push to the IIO buffer */
 	struct {
 		u16 data[3]; /* PM1, PM2P5, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 };
 


