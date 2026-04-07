Return-Path: <stable+bounces-233639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDChNBce1Wnr0wcAu9opvQ
	(envelope-from <stable+bounces-233639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:09:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C393B0AC2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E62630B9972
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409634AB14;
	Tue,  7 Apr 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iBAPCbMi"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AA34A3D6
	for <Stable@vger.kernel.org>; Tue,  7 Apr 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574030; cv=none; b=XCroxhITSsEeNQAPE98mBPt4xR+DuckdqVQm8gemhLsA5XEv6XxODZ7g/lF5ZwBgIMilqioT872/FRK7NZPLhn94J71hNHDitjgjI1J90nOpgRS8ABB/LuN+cIPpuPh3bGx/IBjr8fhJqGnvVTs1D6PXVhKtGI+QymAdBi82M5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574030; c=relaxed/simple;
	bh=rCdH5Wxek/tAIxNPuL/z4mKWHdfvsUybVjJF5eU5/tw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rkyF5l+/neBIqkXH9L3TrpzM/f0hdfmvPljSHhNfwpyu2TTI6pMJm0+VrQiOpXeEud66eL74TtL3G4j1uflGQIseZeeQ/j1/JE4IZB+ABgMKsfcYdOj5iZT1TEhc09wyfGC2fCdCbWjg4UbfXy7GhDxvZp+hQCkX6ptb/rq98F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iBAPCbMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74DAC116C6;
	Tue,  7 Apr 2026 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775574030;
	bh=rCdH5Wxek/tAIxNPuL/z4mKWHdfvsUybVjJF5eU5/tw=;
	h=Subject:To:Cc:From:Date:From;
	b=iBAPCbMirmaQG8iizSiVsJBBxqcwskWyGDPUltGp0u8oQnejJDxqRrfMHhRITX8Kp
	 Cpd1eqzUNX79QRuX3ogFeHy0+0qMLWb8prow2dNRGkx9+t2OyKCcJhzhsMK0dYLDLF
	 vQ/gmC7hPGrIJieNkjtF4t4KAKSk+MClO1T5HpWo=
Subject: FAILED: patch "[PATCH] iio: orientation: hid-sensor-rotation: add timestamp hack to" failed to apply to 6.6-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,jic23@kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:00:25 +0200
Message-ID: <2026040725-duckbill-appetite-17f3@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233639-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,huawei.com:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 58C393B0AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 79a86a6cc3669416a21fef32d0767d39ba84b3aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040725-duckbill-appetite-17f3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


