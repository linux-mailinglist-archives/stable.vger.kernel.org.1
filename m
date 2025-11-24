Return-Path: <stable+bounces-196784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECDC82393
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 20:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9CB14EA70C
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD82D97AF;
	Mon, 24 Nov 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk0ta74g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD462D5957
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010641; cv=none; b=eGLMzKxuFLqNpDZqZCwCb8sQjq9NgMIEPpSU/YScLAumVBOhhjsaUnoy0QpklcetsXO/zYI//TjFfRtLYEnsPC2QfAfP7jBLlm+ubluXb4Lu6ptR6Sky3mDH9rAn3WPk3zpmv/FmcpPT2FMrchiMeZl4oCTcXE5jMz+LQgPVi1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010641; c=relaxed/simple;
	bh=Pf0cNJ06VSGcrSxCWtrtQlzhCjHPrdvifLANAkB+Gic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GW0lpU9EVrxdN3WftpoZ6ZIYiOduHUXNQLAdH8JGRNAbLjLvAPSk3kGbTmO0UJwbgiQtTi6dlnTKjiCb3vLc3+XdnVSaAqIiEyzYXWFpSzOKV6x8YAdsI7DncsMiSVHB02pTgSnYYIZ53nGgRkdxIIn3j5CfNWGiFyePjJp58I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk0ta74g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3544C4CEF1;
	Mon, 24 Nov 2025 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764010641;
	bh=Pf0cNJ06VSGcrSxCWtrtQlzhCjHPrdvifLANAkB+Gic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rk0ta74g6zEVV5Q0RGf2dn2euJ6MTC9iagGbbXR7PvvNsj6YLK/cbtnFA2NW1x1cw
	 f4ouBMjHI2XkFBD1tl8HWi9QyleCpg69GxrQnZt+txzuKUzdVle4uR/TT+0mAWShPm
	 1nq4pIMdvcX6tOdVEKz4D5be0x+hTh2CPc0H3iFZzM7Or5SLtXhaj/dMiO8IfS1Ic6
	 NNAEAglOtxZZAMcBYoQkSwhD4LPzSqd2V3g1BcHbX5q/cqOxlaB6jCbVoOHhLEoyFr
	 5nXDdOaOGePxi/YuFnMtd8JzZBv8Zelzzki9Eu3RpX2IY9yIzGMBvIRYaJaSZNms/E
	 PAQUulAG6DGYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] usb: deprecate the third argument of usb_maxpacket()
Date: Mon, 24 Nov 2025 13:57:16 -0500
Message-ID: <20251124185718.4192041-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112420-cleaver-backlight-0d73@gregkh>
References: <2025112420-cleaver-backlight-0d73@gregkh>
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
index a0477454ad569..bf5f2ead49c43 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1980,21 +1980,17 @@ usb_pipe_endpoint(struct usb_device *dev, unsigned int pipe)
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
 
@@ -2002,8 +1998,6 @@ usb_maxpacket(struct usb_device *udev, int pipe, int is_out)
 	return usb_endpoint_maxp(&ep->desc);
 }
 
-/* ----------------------------------------------------------------------- */
-
 /* translate USB error codes to codes user space understands */
 static inline int usb_translate_errors(int error_code)
 {
-- 
2.51.0


