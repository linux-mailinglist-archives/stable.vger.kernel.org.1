Return-Path: <stable+bounces-139324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E42AA60EA
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887861BA4FDD
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ED9202976;
	Thu,  1 May 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fga9Ani7"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A61BF37
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114592; cv=none; b=OwpyryrRxuox3qNRJORR3dvDcNQFV8OUMIaPDGTtnKPqOY1U/ellFBe4o+5DZjYTCOxfCKjXnOiQqRJjmEBCvBnGHzy8xWDmFOi7zMWrSs98Totj6IZQANQYLzr8Rc8lJQZffBCmgAUWINnaQMDznOa87kgyMPjWuyiLU+k78xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114592; c=relaxed/simple;
	bh=wX3lUOrcdTPh04FvnD2RIJv+9HqthWU1CEh3fo45Aok=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=choOZMNTAN5ZghHqDJMlEUwqUGE+QpZ+g73MPUzennoKgPK8GMV1xBQslQ8Yv2SkWMpshfrTPj1R46/jL25tzEBjuxmWAxb9b71Krq+n0LrN2AFt6Aw789g9/I9MbMtS5LXA51gBNpgqQVF5fe7XpFEmdRkhnDX29KLgGaiMxHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fga9Ani7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4695C4CEEE;
	Thu,  1 May 2025 15:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114592;
	bh=wX3lUOrcdTPh04FvnD2RIJv+9HqthWU1CEh3fo45Aok=;
	h=Subject:To:From:Date:From;
	b=Fga9Ani7nGQ8a2pYQ1m9ikVX4rLKbcL3fR7mHUTkhIFj0KfmtH2un0ovHWjHA+Bm7
	 2glKkb/CEgyMNsXCh4SUTib+49AY0ZtvJ95UBlExCoKAFLVuD9+zYTiW9aJiFReTeS
	 rH3imCNItf3O88EJtShf6WYugTwn0ulbfYgAME/Q=
Subject: patch "iio: chemical: sps30: use aligned_s64 for timestamp" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:48:59 +0200
Message-ID: <2025050158-ibuprofen-impeach-35d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: sps30: use aligned_s64 for timestamp

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From bb49d940344bcb8e2b19e69d7ac86f567887ea9a Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:37 -0500
Subject: iio: chemical: sps30: use aligned_s64 for timestamp
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
---
 drivers/iio/chemical/sps30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.49.0



