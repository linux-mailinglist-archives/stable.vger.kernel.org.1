Return-Path: <stable+bounces-143219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72158AB349C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BF73BDAD5
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31E29D0B;
	Mon, 12 May 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ve3fepEr"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE5336C
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044923; cv=none; b=IZeJEKBH1VGMmPTR0enxSQpPpx24snXTeiQXkTizSHq5a/vwkau14nsqFwWFvzXx+0+ulAyGxATBacvkVtnk2If5I7F1HSflWpdjUWwV5BrfKWt1bxiWRZK8INjRk+1PO1pn3+2dpWSiJgLiiSctZmmJgALfhB4TNbcuy6JJ2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044923; c=relaxed/simple;
	bh=WXcI9Fq5fnJ7t5Ziy+bl4uLE9wlrifkpTQ/HwjXCQgA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XPwzEkVGqY/Hl8r2GChVePfCfj2fgqZ9zaKM/p2acJIbNx0xeGTMzvtWZ379/RWuaO3+JlhHL11NpavumTS04/aAWZF2xCTUAR9956qa7uCOogUrAkHCvmjTMMW0x9LtSy0BlQjv/8RqHigys+U6g2U6dc1dQJ5yuWGIcGU30LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ve3fepEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C58C4CEE7;
	Mon, 12 May 2025 10:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044923;
	bh=WXcI9Fq5fnJ7t5Ziy+bl4uLE9wlrifkpTQ/HwjXCQgA=;
	h=Subject:To:Cc:From:Date:From;
	b=ve3fepErToor/Cvm69Z+JQY2+5qTBsJDC2SZu+0yYcGsXgqsGhV7HhFP432qNRlGn
	 w9OiHHZIY4emAd0010M2JrnuU2vLONHbd9gwUCSp2TyXAh89c7uY7lCTZg77SBvwQ/
	 ntT5+0y9SA5Xi37dsIrlQZgZkUR20Fm7jcf8wkEM=
Subject: FAILED: patch "[PATCH] iio: adc: ad7768-1: Fix insufficient alignment of timestamp." failed to apply to 5.10-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:15:05 +0200
Message-ID: <2025051205-spelling-reconvene-1e4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ffbc26bc91c1f1eb3dcf5d8776e74cbae21ee13a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051205-spelling-reconvene-1e4a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


