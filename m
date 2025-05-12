Return-Path: <stable+bounces-143215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53368AB3498
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E253BDA8B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241825D21F;
	Mon, 12 May 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iqJl0all"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17351993B7
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044910; cv=none; b=BQEWGaFaSmEuhv1K6r5VmDdKoLSRztZGbLDjE7Q+jalyxE658mVgwZ8QLD/PVjAXEX+GIbiUi7inYlBitisSnx3+4Nm3CJ91luCfAb7sEbWlWzOKrOyooc5D3BR0yErf23s8IY3BDygK2jPRVKdv2qIt4iQxOLWENdbuOfGZAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044910; c=relaxed/simple;
	bh=38tkZswmuakLLdkkxr9JU/WxHEY+hVDRYKFD5VTtW2E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q84j8yJeoJMhSqRUmov1skwQQuqkP8oapuyTqI7igY0uFt1e4B3pOWr/8ysEhR0c70ipRgpY8d3r0RW9EHltEtnhj5VGXpEbUjqccCcgDz/l5Om6/dgugtZ8c148bmKX+8nvrdH5JynHudDyjZy2uXyec3esnuzyesnBoDBX9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iqJl0all; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E29C4CEE7;
	Mon, 12 May 2025 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044910;
	bh=38tkZswmuakLLdkkxr9JU/WxHEY+hVDRYKFD5VTtW2E=;
	h=Subject:To:Cc:From:Date:From;
	b=iqJl0allHK/PwGnRY/ExoJZGwG6HCmyOg3vdmwHfgrOtTQYYEPDiaC38peaHHIac3
	 srMjLWCaU/OPBklCePYAsqdxeqsch/mkGdhKkXylzV/YFbYeOcnDFrRojQGIyxgy7M
	 WWx+0qWcJ1vJb/QeeMgakakLLCQHSLyfQyJC0T4U=
Subject: FAILED: patch "[PATCH] iio: adc: ad7768-1: Fix insufficient alignment of timestamp." failed to apply to 6.1-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:15:04 +0200
Message-ID: <2025051204-sedate-collar-e8b8@gregkh>
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
git cherry-pick -x ffbc26bc91c1f1eb3dcf5d8776e74cbae21ee13a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051204-sedate-collar-e8b8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffbc26bc91c1f1eb3dcf5d8776e74cbae21ee13a Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sun, 13 Apr 2025 11:34:25 +0100
Subject: [PATCH] iio: adc: ad7768-1: Fix insufficient alignment of timestamp.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On architectures where an s64 is not 64-bit aligned, this may result
insufficient alignment of the timestamp and the structure being too small.
Use aligned_s64 to force the alignment.

Fixes: a1caeebab07e ("iio: adc: ad7768-1: Fix too small buffer passed to iio_push_to_buffers_with_timestamp()") # aligned_s64 newer
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250413103443.2420727-3-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 5a863005aca6..5e0be36af0c5 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -168,7 +168,7 @@ struct ad7768_state {
 	union {
 		struct {
 			__be32 chan;
-			s64 timestamp;
+			aligned_s64 timestamp;
 		} scan;
 		__be32 d32;
 		u8 d8[2];


