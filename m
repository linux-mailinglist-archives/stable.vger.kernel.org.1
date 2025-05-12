Return-Path: <stable+bounces-143226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B34AB34B0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46357188D863
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA825A341;
	Mon, 12 May 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XnhFdlRS"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B04255E33
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045055; cv=none; b=OIWP5JzfiRbkCPhw7uM+gnRJ0TMNuw2AwR71Co6vnnNdJkR4sSnGtPyOm5YjmZUBwvCP0Zn3Q8qRBLzyEzinlJH22z8KDd2AjH+lGLNDC2H2Zg/BXt68hm13zLc0DBR1soEvzmj/tf4LvaG11hDhtRjydSaOxHzXm7Fj1uyLCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045055; c=relaxed/simple;
	bh=g9+cmFt/1o1cYWD0VKKDsB93quC9a27iNwsvHdPAfAY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ItT7pkby9f9LdCmkfI+OzCxIEY7NzoTRhDMZOnU2Ua4qp6y+sHKKt7toAOZNqunMSBQgrHjBF0e1cgsC5C+M6XGdGUrfT422zQPnsbM5GUdoaXQWO7f9FfMLztcuAzHWEngCcPZFpVvMPaFfQGXfElxh1HaxJI5e5CMi8nkLycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XnhFdlRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF80C4CEE7;
	Mon, 12 May 2025 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747045055;
	bh=g9+cmFt/1o1cYWD0VKKDsB93quC9a27iNwsvHdPAfAY=;
	h=Subject:To:Cc:From:Date:From;
	b=XnhFdlRSVLbcEeJx8fRhkDhPEY6TCSK9lfEcFsBe5UaakWk0V3/ULA6EcUf2uf3Km
	 P2VwpPS211X9b8Su68HUf3+ICTO112wmuI3fh8A8GiJn/9wlhEGhhf9+LPLZ2Ttehs
	 T49FSGzl3iFlU5DklokcQxwn6PeoRzjgHVnoR57E=
Subject: FAILED: patch "[PATCH] iio: chemical: sps30: use aligned_s64 for timestamp" failed to apply to 6.12-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:17:32 +0200
Message-ID: <2025051232-trivial-handbook-ec4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bb49d940344bcb8e2b19e69d7ac86f567887ea9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051232-trivial-handbook-ec4c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb49d940344bcb8e2b19e69d7ac86f567887ea9a Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:37 -0500
Subject: [PATCH] iio: chemical: sps30: use aligned_s64 for timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure that the timestamp is correctly aligned on
all architectures.

Fixes: a5bf6fdd19c3 ("iio:chemical:sps30: Fix timestamp alignment")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250417-iio-more-timestamp-alignment-v1-5-eafac1e22318@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 6f4f2ba2c09d..a7888146188d 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -108,7 +108,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	int ret;
 	struct {
 		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 
 	mutex_lock(&state->lock);


