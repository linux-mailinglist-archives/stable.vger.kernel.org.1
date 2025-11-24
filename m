Return-Path: <stable+bounces-196791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B3C82496
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5451134059F
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FCF2D5932;
	Mon, 24 Nov 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeaU/CC6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD829E112
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012050; cv=none; b=kb114ZTjJsl3x+Sp3K0YQX9G/bI0jB/+HE6V5Wm6/C6kiHCxYR/mvxOqoCsA42Y2qpfKyg2YWXxqZEbxmkjPtv2MJHZFxBKD2XeXdlwMdEQK20o73tX364UrA+Mua0ttORspLcgpUTN1WNiH7j17GkxwC2EIdX82HzBb7j6Gfw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012050; c=relaxed/simple;
	bh=YSYKK+e8RlF8gpQWhjmBOlGAwXu3eaG1duRPBt7xttg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4WHtHtRnv3An87QB2NCCwP6oiNf3AUDDYDY5t4lEOMB668Yhf6MH2ICs70YEmkRftHsfBnh6mbD3nr9N4s9qnVxV8mutQeYFGuULEoGLl0XdiQVHxAo12mVZi5bzeC1RGGzhWge/qRqAZnsj41PBQtleE+dtI0BeeYAl134H4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeaU/CC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE0AC4CEF1;
	Mon, 24 Nov 2025 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764012049;
	bh=YSYKK+e8RlF8gpQWhjmBOlGAwXu3eaG1duRPBt7xttg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EeaU/CC6eWqampuxS/Dy8zabvQZSxIT2fJrIFFZfrFdRH4brAUa5K8Zrf9dvYp/Vr
	 EOrIqh794I521X+JYsnSgBpKvIgez5leCaAstOM5baT9XlQmLi/rtSFDbdO0krSKG9
	 IJu+Jiz2H48GmKOKXpfu9XbvhtBP40CfarkeM2MK/8SeCHgCWXci0hRefaQVie+Yps
	 /ZpUNep0EPfAzD5Z7HUZ6h8ReIfo8Y5Smr5L/M5emGv6TEVwzRasU2SpJ0+bDtM88R
	 8h4u65+PSBe6dckX1K+uN8v2VBEZhZFmQE1kXPQJnGr6WgHdScJ91hekrIpu9spDUU
	 w/E3eq2zzOX8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/3] usb: deprecate the third argument of usb_maxpacket()
Date: Mon, 24 Nov 2025 14:20:44 -0500
Message-ID: <20251124192046.3812-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112420-barman-maybe-9927@gregkh>
References: <2025112420-barman-maybe-9927@gregkh>
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
index ffc16257899fd..b27d80d911cb5 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1964,21 +1964,17 @@ usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
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
 
@@ -1986,8 +1982,6 @@ usb_maxpacket(struct usb_device *udev, int pipe, int is_out)
 	return usb_endpoint_maxp(&ep->desc);
 }
 
-/* ----------------------------------------------------------------------- */
-
 /* translate USB error codes to codes user space understands */
 static inline int usb_translate_errors(int error_code)
 {
-- 
2.51.0


