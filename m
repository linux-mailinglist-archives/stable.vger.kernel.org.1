Return-Path: <stable+bounces-233640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHVVIkMd1Wnr0wcAu9opvQ
	(envelope-from <stable+bounces-233640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:05:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3F23B09EC
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76A71304D4F2
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E61034C83C;
	Tue,  7 Apr 2026 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dy8Vw3th"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1134C81E
	for <Stable@vger.kernel.org>; Tue,  7 Apr 2026 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574033; cv=none; b=VvG6qXTsZkHWG03NoPFYp7aldKSosaqJ1FAofayT8bGyrHC5F4jwRSX+NtE4or6JsNuxESb5jLD7EAp2M0CfKInpu7G//metbu0A/GNvGpKARcPi26u8JnzmtoRIt9TGc2eQso6SI3dwVQOPafuEsTKBNmxFicb0Kw5B6wVAjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574033; c=relaxed/simple;
	bh=Ogr+1AiEjmNuo/ycF4FRQjxJwaEiZSCg2uUp1hE/nos=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sgv4ozyEEoE/fRyA4X6q/9Sfn2SUHWkKmYESO3EFMQtR6RisZVgEJZLT7JjVa/LWQL+jZBYA+ng0m71FhMMuY2h5mV9iKg9UPL4e8guVChq+27X/prCdXotbzmTPSP5erPcQM25TcnaDQn3MHRTMBOlrO7nR1FFOWIz1dQin3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dy8Vw3th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8141CC116C6;
	Tue,  7 Apr 2026 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775574032;
	bh=Ogr+1AiEjmNuo/ycF4FRQjxJwaEiZSCg2uUp1hE/nos=;
	h=Subject:To:Cc:From:Date:From;
	b=Dy8Vw3thftmfk3/2s8/z6ZIOAShXVCSCZBxV8wbY9x+5VdclEVttGNoFjMXqMQpkk
	 9uUD5UH8IyW5Wuu/qLwM08+9Wcao6joOPSkeGndN1qz/uSvW2zQIy/T7iLPzUfQWqV
	 zli40EN/bS02DBe7UUIHn1RY4Lf8d00uZAQHlxLg=
Subject: FAILED: patch "[PATCH] iio: orientation: hid-sensor-rotation: add timestamp hack to" failed to apply to 6.1-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,jic23@kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:00:26 +0200
Message-ID: <2026040726-stained-tackle-e836@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233640-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 7F3F23B09EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 79a86a6cc3669416a21fef32d0767d39ba84b3aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040726-stained-tackle-e836@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79a86a6cc3669416a21fef32d0767d39ba84b3aa Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 7 Mar 2026 19:44:09 -0600
Subject: [PATCH] iio: orientation: hid-sensor-rotation: add timestamp hack to
 not break userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a hack to push two timestamps in the hid-sensor-rotation scan data
to avoid breaking userspace applications that depend on the timestamp
being at the incorrect location in the scan data due to unintentional
misalignment in older kernels.

When this driver was written, the timestamp was in the correct location
because of the way iio_compute_scan_bytes() was implemented at the time.
(Samples were 24 bytes each.) Then commit 883f61653069 ("iio: buffer:
align the size of scan bytes to size of the largest element") changed
the computed scan_bytes to be a different size (32 bytes), which caused
iio_push_to_buffers_with_timestamp() to place the timestamp at an
incorrect offset.

There have been long periods of time (6 years each) where the timestamp
was in either location, so to not break either case, we open-code the
timestamps to be pushed to both locations in the scan data.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20260215162351.79f40b32@jic23-huawei/
Fixes: 883f61653069 ("iio: buffer: align the size of scan bytes to size of the largest element")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 6806481873be..5a5e6e4fbe34 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -20,7 +20,12 @@ struct dev_rot_state {
 	struct hid_sensor_hub_attribute_info quaternion;
 	struct {
 		IIO_DECLARE_QUATERNION(s32, sampled_vals);
-		aligned_s64 timestamp;
+		/*
+		 * ABI regression avoidance: There are two copies of the same
+		 * timestamp in case of userspace depending on broken alignment
+		 * from older kernels.
+		 */
+		aligned_s64 timestamp[2];
 	} scan;
 	int scale_pre_decml;
 	int scale_post_decml;
@@ -154,8 +159,19 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!rot_state->timestamp)
 			rot_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &rot_state->scan,
-						   rot_state->timestamp);
+		/*
+		 * ABI regression avoidance: IIO previously had an incorrect
+		 * implementation of iio_push_to_buffers_with_timestamp() that
+		 * put the timestamp in the last 8 bytes of the buffer, which
+		 * was incorrect according to the IIO ABI. To avoid breaking
+		 * userspace that may be depending on this broken behavior, we
+		 * put the timestamp in both the correct place [0] and the old
+		 * incorrect place [1].
+		 */
+		rot_state->scan.timestamp[0] = rot_state->timestamp;
+		rot_state->scan.timestamp[1] = rot_state->timestamp;
+
+		iio_push_to_buffers(indio_dev, &rot_state->scan);
 
 		rot_state->timestamp = 0;
 	}


