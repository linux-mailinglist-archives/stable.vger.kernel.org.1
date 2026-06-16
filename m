Return-Path: <stable+bounces-263546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JTIQJZ7bMGoVYAUAu9opvQ
	(envelope-from <stable+bounces-263546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:14:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB368C0CB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:14:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SYbSRDn7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263546-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263546-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C883046364
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2F3CF02E;
	Tue, 16 Jun 2026 05:12:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B953CEB8F
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:12:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586771; cv=none; b=P8Hq5Ebr4Dh1bFs29KBMfLjKapI+E4aBnwUtqSNO3UB/QaI244jc7q4qJzqZ+jrV1EK+xpyt8vFYBDDP8eLDRPZWYdyMREsDW1vDuY3K/65gwECk+YKKYa/s7iXo3HyEJAavVrKRW+1vqsuU46WFj3nb/r0NpogPUDnM2Asd0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586771; c=relaxed/simple;
	bh=jRm5BKdrWbSx6QhorT2ZQ9qmT3GuxjxZKNXk1rRkeIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLbfz/Zr4zxTEf6HmJqtcs35SE1rLfIpMavMcItZF1hfxCeEu+AGFbqEIfTn2m9TgK4naE22xMeYVPBuxKK4jMUujwQLEHJcldosLy8D0IZ6zr9m0vsfk/wRlbYKoS8bfpju/tc880Bcscs4uMaTJhxUhyGJwgf0sNAR0kYlKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYbSRDn7; arc=none smtp.client-ip=74.125.82.174
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304fb780deaso4274382eec.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 22:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586769; x=1782191569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a06GnFTgOZ8VawHWEGB4YwWHIzCduqDiZ9BtHLrmlk=;
        b=SYbSRDn7p18XwSc57xUoJivPTMTs23UorX5eoCd+3F40Rpm1Mn4YhzUtDmAzT7vvHb
         9wybNBIzJJYhV6vEJObGAqvHOXnya41pjHm09DEYpNDwZI6cTO3hdMq5ZdywzzhAJ7IT
         CRYF7tUln3jAzsu+t+pdO4xl2sOK/B4vJu+9qXPufnYj/smWnJGMjunEGHCUnZAfXpZY
         GXiDO51tMpDboqs9XBXU5aIe47rVmYaSKJ+zbpR3ANFGoPSdfRs/winGWhIH4eU0uYbF
         M8a4eBsS60tA9lhk0ket2fCJjAKN5j68YdEUfDcuMPDOQZI9QZ2If0Sig/ZNfZT9il6H
         SAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586769; x=1782191569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9a06GnFTgOZ8VawHWEGB4YwWHIzCduqDiZ9BtHLrmlk=;
        b=kbSauALGfWVfC3oe+kL6GRJAhrwdSOHufcy5O7f4x8xJ2F3tg9nTqQ78eTCmCwkQl4
         HWwM7MY7eU5iW53k8IDi8vUOZURQpp2o7BAzL0QUITGzx6/VSZFvxOm0dSFz2U6gikC3
         /kG5ptC6Lm9wjvpz7th1IG/RNCEh1A6tywActc4n/4JOQLYU5dO5y+JXM1EWsTlWBeCn
         03pYeiFZ+qcRxuqwMZzISUj2GSRR/e3S73+LFHfRwEJs6o6O8+KdqVDr5o5Lt0m/m5L4
         6X/gD8pzza/y9aCFKeNHcT4grLjmXjv3Lpz5zz2QkQtJzTNDgYhVLuOy9lYo9M85fci6
         fB7A==
X-Forwarded-Encrypted: i=1; AFNElJ8Et4+/6jnopHWCAumA2s8NSLPA6gm0zf8nkIEhDSnvRQ0PE5V/1EfAwB/cOQ37Rj3M7WcaOHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKcsEnia9cKjnncPGSZ7QtyJL113VsIORxtuuWgkG8LXIYztC6
	O8cPxa6D0kT7DRshNHi2I32WVS58GMRGGt9ToGWLHRVpeW2fWR9XScus
X-Gm-Gg: Acq92OHLDniRxuR6SBjQq+J7wB1zUo2Z13ZbKIQNwLhKyfQl2/BK+IotOmd2MikILDu
	cU4H3Xui2DHVZQ+yQola49IqRVVfjfqpH+RE0tnXJEUbBrE5hZz3KmgFaRElZMesXX2j6kcAMMa
	pRbW8ssCWGC1dCcL1Rgp9NUDwmQdjHJohjmROgwdaAvv4L0HKH0xpvlaoNtkEHVlmV0rwXV3E4v
	EET80vujJSA2kV4OVddmvUYOGMBG5IgE4/Et+xpiug6QHARmc+wlZK7OSb2P0amc0vmTHs8b/fg
	v5fyv6zJFu9aljOMj++txHTWMpM6NmKrD3wzoabYHLpoKQ+++ZLebxoyfopkgxSHmr23oeYP4AK
	lA0dfNljK17FYBNYP6UWmAc9wMl1zzR/RDUW7+Wgyv62y9OJY4dzKdCNE1NBUPvM6s1y2qo9JXt
	psXveBLQymiCZgBayJ5EPPym0nGfOtRIrq9VZ/VOqrA6Wkv9mTGHcqRXrzfqFS1uOQ/SP4Q/1c8
	YhrWuTUY2HXL3A=
X-Received: by 2002:a05:7300:8b84:b0:304:e587:5063 with SMTP id 5a478bee46e88-3081ff7ca07mr9443416eec.12.1781586768879;
        Mon, 15 Jun 2026 22:12:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43b80sm16726052eec.21.2026.06.15.22.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:12:48 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] Input: sur40 - fix V4L2 video device lifetime
Date: Mon, 15 Jun 2026 22:12:32 -0700
Message-ID: <20260616051235.1549517-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hverkuil@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-263546-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37AB368C0CB

sur40_disconnect() synchronously frees the sur40_state structure (kfree(sur40))
while userspace might still hold an open file descriptor to the V4L2 video
device node. When userspace later accesses or closes the lingering file
descriptor, the V4L2 core invokes file operations (such as vb2_fop_release)
that dereference the already freed sur40 memory, resulting in a use-after-free
vulnerability.

Fix this by implementing a V4L2 release callback (sur40_video_release) in
sur40_video_device to clean up V4L2 components and free the sur40 structure
only when the last video file descriptor is closed.

Additionally, update the sur40_probe() error path to call video_unregister_device()
and return inline if input initialization fails after video device registration
succeeded, allowing the V4L2 release callback to manage cleanup.

Also, call v4l2_device_disconnect() in sur40_disconnect() to safely dissociate
the V4L2 device from the parent USB device during unplug.

Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 1ad68131e3a6..2f0efee23d1e 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -806,8 +806,10 @@ static int sur40_probe(struct usb_interface *interface,
 	}
 
 	error = sur40_init_input(sur40);
-	if (error)
-		goto err_unreg_video;
+	if (error) {
+		video_unregister_device(&sur40->vdev);
+		return error;
+	}
 
 	/* we can register the device now, as it is ready */
 	usb_set_intfdata(interface, sur40);
@@ -815,8 +817,6 @@ static int sur40_probe(struct usb_interface *interface,
 
 	return 0;
 
-err_unreg_video:
-	video_unregister_device(&sur40->vdev);
 err_free_ctrl:
 	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
@@ -835,13 +835,8 @@ static void sur40_disconnect(struct usb_interface *interface)
 	struct sur40_state *sur40 = usb_get_intfdata(interface);
 
 	input_unregister_device(sur40->input);
-
-	v4l2_ctrl_handler_free(&sur40->hdl);
 	video_unregister_device(&sur40->vdev);
-	v4l2_device_unregister(&sur40->v4l2);
-
-	kfree(sur40->bulk_in_buffer);
-	kfree(sur40);
+	v4l2_device_disconnect(&sur40->v4l2);
 
 	usb_set_intfdata(interface, NULL);
 	dev_dbg(&interface->dev, "%s is now disconnected\n", DRIVER_DESC);
@@ -1176,11 +1171,21 @@ static const struct v4l2_ioctl_ops sur40_video_ioctl_ops = {
 	.vidioc_streamoff	= vb2_ioctl_streamoff,
 };
 
+static void sur40_video_release(struct video_device *vdev)
+{
+	struct sur40_state *sur40 = video_get_drvdata(vdev);
+
+	v4l2_device_unregister(&sur40->v4l2);
+	v4l2_ctrl_handler_free(&sur40->hdl);
+	kfree(sur40->bulk_in_buffer);
+	kfree(sur40);
+}
+
 static const struct video_device sur40_video_device = {
 	.name = DRIVER_LONG,
 	.fops = &sur40_video_fops,
 	.ioctl_ops = &sur40_video_ioctl_ops,
-	.release = video_device_release_empty,
+	.release = sur40_video_release,
 	.device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TOUCH |
 		       V4L2_CAP_READWRITE | V4L2_CAP_STREAMING,
 };
-- 
2.54.0.1136.gdb2ca164c4-goog


