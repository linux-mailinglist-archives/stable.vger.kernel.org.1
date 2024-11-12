Return-Path: <stable+bounces-92720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA1F9C55CA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AC92823B3
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45E7219E5E;
	Tue, 12 Nov 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l3aI0ffB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E502214416;
	Tue, 12 Nov 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408370; cv=none; b=mt3KhH5Dk6VGGx4quzZIWzC7REZdV9mouVGhsWlEKd0uMqFgLk5gB9iRx5rLjNhaqj3vwH+22XygWLCwXHjDKWu4nvLprIB5+eMi32T8idQfUWJRy7P4MirErzJBPb/3OEL8evGBzDWa5sA2ePnTzlbLH86GHC0gJSL3CNFgY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408370; c=relaxed/simple;
	bh=KI85fzJ/5lnlZiqtQlU/FUeKjHiETAtjzvdxPwlIqLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9MnaMt8WlBQarzYXSydXoQeOvJaUXAb9JoeTCbAk5eDnB7dnchwAWeT/B1AQczjJG1u6F9XhaHLgccA/wmDQNAp81E3pTdKaRLKpnSI7hLpwI4tNcK2KkRacmMoorXftjfmIISFJpyxlNGhJ6HCtlp8SMcKqcU+Hhz5JHgUa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l3aI0ffB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9E9C4CECD;
	Tue, 12 Nov 2024 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408370;
	bh=KI85fzJ/5lnlZiqtQlU/FUeKjHiETAtjzvdxPwlIqLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3aI0ffB5iSfsA1/O/AV+/QTuqA5kSe735LayL1Seqd4656nZMJ910ZaXidvDIu+q
	 FqiHEgVOUR9oEJEeuIc8XSRIeCtDxZkpb7/kti/lwNdFREUf5+hW/Or9FXNsUF81vd
	 CSAlUrrvEfw+75ZfBsIkW4xs+Q7sVZk321nE7u9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benoit Sevens <bsevens@google.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.11 142/184] media: uvcvideo: Skip parsing frames of type UVC_VS_UNDEFINED in uvc_parse_format
Date: Tue, 12 Nov 2024 11:21:40 +0100
Message-ID: <20241112101906.321867535@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benoit Sevens <bsevens@google.com>

commit ecf2b43018da9579842c774b7f35dbe11b5c38dd upstream.

This can lead to out of bounds writes since frames of this type were not
taken into account when calculating the size of the frames buffer in
uvc_parse_streaming.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Signed-off-by: Benoit Sevens <bsevens@google.com>
Cc: stable@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -371,7 +371,7 @@ static int uvc_parse_format(struct uvc_d
 	 * Parse the frame descriptors. Only uncompressed, MJPEG and frame
 	 * based formats have frame descriptors.
 	 */
-	while (buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
+	while (ftype && buflen > 2 && buffer[1] == USB_DT_CS_INTERFACE &&
 	       buffer[2] == ftype) {
 		unsigned int maxIntervalIndex;
 



