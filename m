Return-Path: <stable+bounces-218325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA/hJ7tRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:34:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8D18F06D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E5630A3353
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94E20C012;
	Wed, 25 Feb 2026 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IcFm9+NI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039818DB2A;
	Wed, 25 Feb 2026 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983129; cv=none; b=gpBrLBJenwg/fcOI0vJm5oA+180kZDD47I/gTCQKUAA8QH1fFXDBTq6GhjMoXAfLMSLeo67kkOmGqM8DuGGs79lrYhZj1WZ3KL9bF1hXYq3BDRmOgRpCYsBH6tq+/o5berWpGuQZDqLLPI5wwf0lkly/SLBBQAqi77zNLhSomWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983129; c=relaxed/simple;
	bh=jqjpw33yq8kR+A2S+3WCeSY/4Guq7Kcmx7euwn/vhME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWZ0GLsFHtKSQjG/pyt+5cXKXjkN+OH4EpIHBGiCBibd9DqNZezMuWW5FdBzCY7OFsqJsyt/uIjhVyem7yuBEmClRwAQZcNbbh/MZitsSuhGCC/fCEc8VZ3YcCwnBbcLr1hiNngRYTxfB2QHGHwlH3vyp8mTEYY4kSIzsj4Il+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IcFm9+NI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C292BC116D0;
	Wed, 25 Feb 2026 01:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983128;
	bh=jqjpw33yq8kR+A2S+3WCeSY/4Guq7Kcmx7euwn/vhME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IcFm9+NIK7oN7Pf61P6PDSLWmGkRw0N1RR8aHRxtmPEcueM6dYf5BHfKiS+oVwUNG
	 o9bRRoGeQ/EPW6EnYto4pQovuTnUZIcsC1PA07RgCfa8tEf+b0yJyep+qQa8r4Ezag
	 OYsQ/3wCpjmRO96S0LRdsRLML6iWd4gYIC86hj84=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Itay Chamiel <itay.chamiel@q.ai>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 286/781] media: uvcvideo: Fix allocation for small frame sizes
Date: Tue, 24 Feb 2026 17:16:35 -0800
Message-ID: <20260225012406.720481943@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218325-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,ideasonboard.com:email]
X-Rspamd-Queue-Id: 4DC8D18F06D
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 40d3ac25c11310bfaa50ed7614846ef75cb69a1e ]

If a frame has size of less or equal than one packet size
uvc_alloc_urb_buffers() is unable to allocate memory for it due to a
off-by-one error.

Fix the off-by-one-error and now that we are at it, make sure that
stream->urb_size has always a valid value when we return from the
function, even when an error happens.

Fixes: efdc8a9585ce ("V4L/DVB (10295): uvcvideo: Retry URB buffers allocation when the system is low on memory.")
Reported-by: Itay Chamiel <itay.chamiel@q.ai>
Closes: https://lore.kernel.org/linux-media/CANiDSCsSoZf2LsCCoWAUbCg6tJT-ypXR1B85aa6rAdMVYr2iBQ@mail.gmail.com/T/#t
Co-developed-by: Itay Chamiel <itay.chamiel@q.ai>
Signed-off-by: Itay Chamiel <itay.chamiel@q.ai>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Itay Chamiel <itay.chamiel@q.ai>
Link: https://patch.msgid.link/20260114-uvc-alloc-urb-v1-1-cedf3fb66711@chromium.org
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/uvc/uvc_video.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 2094e059d7d39..ec76595f3c4be 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1812,7 +1812,7 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
 		npackets = UVC_MAX_PACKETS;
 
 	/* Retry allocations until one succeed. */
-	for (; npackets > 1; npackets /= 2) {
+	for (; npackets > 0; npackets /= 2) {
 		stream->urb_size = psize * npackets;
 
 		for (i = 0; i < UVC_URBS; ++i) {
@@ -1837,6 +1837,7 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
 	uvc_dbg(stream->dev, VIDEO,
 		"Failed to allocate URB buffers (%u bytes per packet)\n",
 		psize);
+	stream->urb_size = 0;
 	return 0;
 }
 
-- 
2.51.0




