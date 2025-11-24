Return-Path: <stable+bounces-196780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B197AC821FD
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB243A9A8A
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9E31A04E;
	Mon, 24 Nov 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0C6HtT4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEAC2BDC05
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009481; cv=none; b=N90NgmYbCxKme8q9br7AGrJxfq6Nwo/IUBuIOFmuU/rrFmzhiSzg4tTfnSYtAScgUjXp1IqEk6PiJ8coAXUeIzTxsVFsuQkcluGx/mqoHN24ON9ilny4IArgL3JXAR2TvLict5WF9Vn1WvOg0Owekg29zK1mU9/AI5Ej2t6gLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009481; c=relaxed/simple;
	bh=Y/hS10CAGHEAEVWghgM+pZ0fkHnMC9dkJ6iAvRUDzb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJvobUNGO7UjnuJ2QtXYeR9TiKeLPq/WPJpCgSrg+3FucuP3r+iOaIXm+kTRKL0gg9VK1UT5NCB+LoTPR62GN6+ahHmM4DYnD3d4g0kwVLri6LT/6/blUmtUnmZPJatdxEAfe5YFyHtxm6MENRdedoVn8YwYp+hzy9cD4gfUUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0C6HtT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A784C4CEF1;
	Mon, 24 Nov 2025 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764009481;
	bh=Y/hS10CAGHEAEVWghgM+pZ0fkHnMC9dkJ6iAvRUDzb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0C6HtT4pL6sYjEtCNy4QSupw6Vjlm+fwcRVrm84uUSMRwHSGIWIA0yt/aE09TKV/
	 ru9YRvylnIWMLw8I6ybXY/tRPthucGqRG+uyG2XHSxC5x7WexLC1R2llAMqrN9P1Hz
	 FNDSo8vJEPbRBZZMO694E3eqodZ41yuZr+AFGcIFjPecygBHPjgmvOVm2j+PmvIq2o
	 OGLmIOqFVkOYQNVit1jaAsrBcwenhOnzvkWNAu875U0FAWQjuuwEAmGybIGBWltARF
	 Wx+8WEONH6lTRtP4QjxFYWYPMPrDonPcR+cd2z78S9FwXBdAMQZY1XrFlTbuyYUQOk
	 OK3lkw1VEoeVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] usb: deprecate the third argument of usb_maxpacket()
Date: Mon, 24 Nov 2025 13:37:56 -0500
Message-ID: <20251124183758.4187087-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112419-scariness-motive-d737@gregkh>
References: <2025112419-scariness-motive-d737@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

[ Upstream commit 0f08c2e7458e25c967d844170f8ad1aac3b57a02 ]

This is a transitional patch with the ultimate goal of changing the
prototype of usb_maxpacket() from:
| static inline __u16
| usb_maxpacket(struct usb_device *udev, int pipe, int is_out)

into:
| static inline u16 usb_maxpacket(struct usb_device *udev, int pipe)

The third argument of usb_maxpacket(): is_out gets removed because it
can be derived from its second argument: pipe using
usb_pipeout(pipe). Furthermore, in the current version,
ubs_pipeout(pipe) is called regardless in order to sanitize the is_out
parameter.

In order to make a smooth change, we first deprecate the is_out
parameter by simply ignoring it (using a variadic function) and will
remove it later, once all the callers get updated.

The body of the function is reworked accordingly and is_out is
replaced by usb_pipeout(pipe). The WARN_ON() calls become unnecessary
and get removed.

Finally, the return type is changed from __u16 to u16 because this is
not a UAPI function.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/r/20220317035514.6378-2-mailhol.vincent@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 69aeb5073123 ("Input: pegasus-notetaker - fix potential out-of-bounds access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/usb.h | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/usb.h b/include/linux/usb.h
index 15247a1cc65c6..671d8845bd46e 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1987,21 +1987,17 @@ usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
 	return eps[usb_pipeendpoint(pipe)];
 }
 
-/*-------------------------------------------------------------------------*/
-
-static inline __u16
-usb_maxpacket(struct usb_device *udev, int pipe, int is_out)
+static inline u16 usb_maxpacket(struct usb_device *udev, int pipe,
+				/* int is_out deprecated */ ...)
 {
 	struct usb_host_endpoint	*ep;
 	unsigned			epnum = usb_pipeendpoint(pipe);
 
-	if (is_out) {
-		WARN_ON(usb_pipein(pipe));
+	if (usb_pipeout(pipe))
 		ep = udev->ep_out[epnum];
-	} else {
-		WARN_ON(usb_pipeout(pipe));
+	else
 		ep = udev->ep_in[epnum];
-	}
+
 	if (!ep)
 		return 0;
 
@@ -2009,8 +2005,6 @@ usb_maxpacket(struct usb_device *udev, int pipe, int is_out)
 	return usb_endpoint_maxp(&ep->desc);
 }
 
-/* ----------------------------------------------------------------------- */
-
 /* translate USB error codes to codes user space understands */
 static inline int usb_translate_errors(int error_code)
 {
-- 
2.51.0


