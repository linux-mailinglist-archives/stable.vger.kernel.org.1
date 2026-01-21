Return-Path: <stable+bounces-211062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA1IAO0kcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-211062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:11:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FC45BE28
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAA70B6111C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1234A3AC;
	Wed, 21 Jan 2026 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="izG1SZnX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C00316193;
	Wed, 21 Jan 2026 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020309; cv=none; b=EM1eGmvB4Nfr494ar+Fh5gtUkPvYKTYooasvUVCC2CNnvTnxhWQfgBbuQxJsoU/SwK10wpolEUEFyc3rKmFKC82tdGuKs6yg7O5f7uBt2tpdkTrDq7ZI03ye7d0ZO2FLZ83+YTmsIM/4FLIen622Lmmq/ZwK0I0G0valWIgis3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020309; c=relaxed/simple;
	bh=FIzAMxQsVrSGdSftzMdY5BuXrxN+8K5GBzDI538nYzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBSLmB0n68kW9KPl/SVFpgomFNAbomxi9dROxU7e9vfxQQuv1zw6STgtQSGi5jpYaYBgKQbTmcJXNIc4A2FIFMj1OaxAA6n3yv6G4rED2MMnZkpwm+6TqWl+eHBGrAO6zva4hb4R+pIAhox7j23gjuSQazCO8VvZHLjKZ40DIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=izG1SZnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D03DC4CEF1;
	Wed, 21 Jan 2026 18:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020309;
	bh=FIzAMxQsVrSGdSftzMdY5BuXrxN+8K5GBzDI538nYzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izG1SZnXR12yAoqo2DLNBjiO1mTMvyv8WDfIjpSqYss674y6YZNdHDuVCU0vHcbW0
	 FglVl9yEEf5SRanx9o8Ks8+z/oio6apXIgRu1Ig7owOZchNjyY3DYbO5vcTVndFHSQ
	 sodxhoWu/jW+gM03itX9+Aoh/1JboBoyCrnJJemE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.18 120/198] usb: gadget: uvc: fix req_payload_size calculation
Date: Wed, 21 Jan 2026 19:15:48 +0100
Message-ID: <20260121181422.869524262@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211062-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 60FC45BE28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

commit 2edc1acb1a2512843425aa19d0c6060a0a924605 upstream.

Current req_payload_size calculation has 2 issue:

(1) When the first time calculate req_payload_size for all the buffers,
    reqs_per_frame = 0 will be the divisor of DIV_ROUND_UP(). So
    the result is undefined.
    This happens because VIDIOC_STREAMON is always executed after
    VIDIOC_QBUF. So video->reqs_per_frame will be 0 until VIDIOC_STREAMON
    is run.

(2) The buf->req_payload_size may be bigger than max_req_size.

    Take YUYV pixel format as example:
    If bInterval = 1, video->interval = 666666, high-speed:
    video->reqs_per_frame = 666666 / 1250 = 534
     720p: buf->req_payload_size = 1843200 / 534 = 3452
    1080p: buf->req_payload_size = 4147200 / 534 = 7766

    Based on such req_payload_size, the controller can't run normally.

To fix above issue, assign max_req_size to buf->req_payload_size when
video->reqs_per_frame = 0. And limit buf->req_payload_size to
video->req_size if it's large than video->req_size. Since max_req_size
is used at many place, add it to struct uvc_video and set the value once
endpoint is enabled.

Fixes: 98ad03291560 ("usb: gadget: uvc: set req_length based on payload by nreqs instead of req_size")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20260113-uvc-gadget-fix-patch-v2-1-62950ef5bcb5@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_uvc.c     |    4 ++++
 drivers/usb/gadget/function/uvc.h       |    1 +
 drivers/usb/gadget/function/uvc_queue.c |   15 +++++++++++----
 drivers/usb/gadget/function/uvc_video.c |    4 +---
 4 files changed, 17 insertions(+), 7 deletions(-)

--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -362,6 +362,10 @@ uvc_function_set_alt(struct usb_function
 			return ret;
 		usb_ep_enable(uvc->video.ep);
 
+		uvc->video.max_req_size = uvc->video.ep->maxpacket
+			* max_t(unsigned int, uvc->video.ep->maxburst, 1)
+			* (uvc->video.ep->mult);
+
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_STREAMON;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -117,6 +117,7 @@ struct uvc_video {
 	/* Requests */
 	bool is_enabled; /* tracks whether video stream is enabled */
 	unsigned int req_size;
+	unsigned int max_req_size;
 	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
 
 	/* USB requests that the video pump thread can encode into */
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -86,10 +86,17 @@ static int uvc_buffer_prepare(struct vb2
 		buf->bytesused = 0;
 	} else {
 		buf->bytesused = vb2_get_plane_payload(vb, 0);
-		buf->req_payload_size =
-			  DIV_ROUND_UP(buf->bytesused +
-				       (video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
-				       video->reqs_per_frame);
+
+		if (video->reqs_per_frame != 0)	{
+			buf->req_payload_size =
+				DIV_ROUND_UP(buf->bytesused +
+					(video->reqs_per_frame * UVCG_REQUEST_HEADER_LEN),
+					video->reqs_per_frame);
+			if (buf->req_payload_size > video->req_size)
+				buf->req_payload_size = video->req_size;
+		} else {
+			buf->req_payload_size = video->max_req_size;
+		}
 	}
 
 	return 0;
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -503,9 +503,7 @@ uvc_video_prep_requests(struct uvc_video
 	unsigned int max_req_size, req_size, header_size;
 	unsigned int nreq;
 
-	max_req_size = video->ep->maxpacket
-		 * max_t(unsigned int, video->ep->maxburst, 1)
-		 * (video->ep->mult);
+	max_req_size = video->max_req_size;
 
 	if (!usb_endpoint_xfer_isoc(video->ep->desc)) {
 		video->req_size = max_req_size;



