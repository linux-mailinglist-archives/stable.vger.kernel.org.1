Return-Path: <stable+bounces-227981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJgfOfw9wWk9RwQAu9opvQ
	(envelope-from <stable+bounces-227981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:19:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A742F2B7D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12AAF3060799
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508803A9D9B;
	Mon, 23 Mar 2026 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bA2XrGdr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04D3AB282
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271444; cv=none; b=ZMFbzVJgjm8MIub37Ce9nRnBFtl3aNMUxFkFsd4tJffIm4SJAaYEOJDpUtPg1ImqcGoWs60EEwWgCCYHjDTM+S9tn7XjQoPNn/ChFfauSOWZ1hgAuO15uAkSkcjUZQzEGA7r/s5Ei655s0E26faoy9UwWl2DnFzv53/fApqJ+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271444; c=relaxed/simple;
	bh=+sjG9Y89xiTyAd2WtTGciLIS9T6N5GSrKMdc4XxAA04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UdJc7pmOx5ELzhEe61ATxLlHQN3xJ4pQCGQ5EDu25ZQNFtsa1l3TLaqNG8TqnwTCAoKP29hf9jmmJ6fmkoMIgNXf8x1Q8nvcogk7jqn8arbBbVV4yR+GOjPcH3e4YFwoXhYSOy+Gm2gef3bUWliegg5f1jbua7aF/fFlg5fUlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bA2XrGdr; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dcdf60427so103901e87.3
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774271441; x=1774876241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHX78l0IWaFY465sZIyem0S3+5Hdcjbh+Os+s15sjNo=;
        b=bA2XrGdrfDhmPW1AYucVq1zKukGlv+tLHJrTtpwiclAGIlPMd8r+blfM4Gb7drR5xB
         djgI+RQsCyANMam/LsDsAwVK3fSpPcmmD/ds9xJwa1NOGOp7QcwiYHZShpI4r/k/p7zA
         k6uAvqlz9WSSKGBKdeH/jDVr0OLqii36rkEJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271441; x=1774876241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OHX78l0IWaFY465sZIyem0S3+5Hdcjbh+Os+s15sjNo=;
        b=qzba2f4w2ZDx6BrzNRZVVH5+37NYlar6qFLcX3fDaRtdbGPbM7XIdhHq/lVBJE9fMS
         guPJSQRYunxj9tL10ytK0K5F7Gd8d2DwUQRpwAuhA7CwEIxnJYUzL1b+M80QpYukpyt2
         UhNo+PQr6TwZdoXt5qh4MX+FKA7NPRDqzO7mhDBtPL+r7QnY/kOHPm/GAnjR6Jr03Cez
         t6/O4iCPXlGrPO8rMOxyuDvk7PhYCbp1GKljlhzDZ8MA5vU/Ko8UCFJ0A0NdEvTBwuS2
         MDpsXte6sWQeK1EUhM/DFkMFU1GJXA/LY1TsHWYfZ9YJIpX2tWUwylv1MwM3wStfwZk9
         yv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs00wyV7OmKnDrF2kPfZ04K6qfHwhPjT8Z7It5Oe0rVRYk4hXvNae2dPclPLHNngYRGDYUC/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVGW7lAY0jv+9DaBgQ5CXg7N/1zSQz0TBMZ6q9oA2E1K/uNm/
	/gy+yJZqriS6uOTVMIXWTL6cMyntRSz7yOE9OhJ2sWzhgAKPBAQ3s5VU/1C2oeo5qw==
X-Gm-Gg: ATEYQzwzUuD5vbAMl/qn+xVmQ0GMkxK6IwSN+OK4c41mUgh68tfAMrCQPkpvMPRvmb8
	thbIsDoJ/k+qOzyzTMxpSOzMbo26yffx02oCEAXDn5yQkb85D9Kh+nWMHxoGJ+tfjrw8KopUzzb
	ODxyZDWw1QjKbRsKGZOPPZfR4bTQ8BmKWVwIfQZPFw+5Kh8gzPdqVuLrxKmX7viafJdn1XhX7OK
	/EdUO8RQBxinrNIZFe5yC7lthSBP7AOqw3CrYczlbiwZKszIzMylEhWJkZw08vJ709/J+K/s26a
	fMxQjXJbvYKwxlAa6VTNBft2ZB2RllZz6v58iRJ9vglBNflHHK2umKd2U3zQXPDL5SyGhFuSdAC
	ELOXqjG/rps29frJohvTRtK/HR3yX8xim4fmLfZbOhE7nXyUyvroF+NUEJWu2+8lSjz+we0anUK
	Ld1XH+hsBbhwN8s3vR9Me3gfO07BNLxmbYYR7xL5AM6+aqGgS8gmExehgl8LavAlrPJ3rm05TZ9
	3PXewM6Fd4GSj1nnQ==
X-Received: by 2002:a05:6512:1294:b0:5a2:777f:8323 with SMTP id 2adb3069b0e04-5a285b3150cmr3866798e87.18.1774271440713;
        Mon, 23 Mar 2026 06:10:40 -0700 (PDT)
Received: from ribalda.c.googlers.com (252.116.88.34.bc.googleusercontent.com. [34.88.116.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285305e07sm2515904e87.66.2026.03.23.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:10:39 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 23 Mar 2026 13:10:30 +0000
Subject: [PATCH 3/4] media: uvcvideo: Relax the constrains for
 interpolating the hw clock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-uvc-hwtimestamp-v1-3-aa42e3865204@chromium.org>
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
In-Reply-To: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227981-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email,chromium.org:mid]
X-Rspamd-Queue-Id: 47A742F2B7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the initial version we set the min value to 250msec. Looks like
100msec can also provide a good value.

Now that we are at it, refactor a bit the code to make it cleaner.

Fixes: 6243c83be6ee8 ("media: uvcvideo: Allow hw clock updates with buffers not full")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index c7ebedb3450f..dcbc0941ffe6 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -494,6 +494,13 @@ static int uvc_commit_video(struct uvc_streaming *stream,
  * Clocks and timestamps
  */
 
+/*
+ * The accuracy of the hardware timestamping depends on having enough data to
+ * interpolate between the different clock domains. This value is sof cycles,
+ * this is, milliseconds.
+ */
+#define MIN_HW_TIMESTAMP_DIFF 100
+
 static inline ktime_t uvc_video_get_time(void)
 {
 	if (uvc_clock_param == CLOCK_MONOTONIC)
@@ -834,15 +841,12 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		y2 += 2048 << 16;
 
 	/*
-	 * Have at least 1/4 of a second of timestamps before we
-	 * try to do any calculation. Otherwise we do not have enough
-	 * precision. This value was determined by running Android CTS
-	 * on different devices.
+	 * Check that we have enough data to do the interpolation.
 	 *
-	 * dev_sof runs at 1KHz, and we have a fixed point precision of
-	 * 16 bits.
+	 * y1 and y2 are dev_sof with a fixed point precision of 16 bits.
 	 */
-	if (clock->size != clock->count && (y2 - y1) < ((1000 / 4) << 16))
+	if (clock->size != clock->count &&
+	    (y2 - y1) < (MIN_HW_TIMESTAMP_DIFF << 16))
 		goto done;
 
 	y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2

-- 
2.53.0.959.g497ff81fa9-goog


