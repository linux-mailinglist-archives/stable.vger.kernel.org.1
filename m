Return-Path: <stable+bounces-107341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC05A02B5D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233747A0F4E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A81D7999;
	Mon,  6 Jan 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oDdTdDqW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB2142E77;
	Mon,  6 Jan 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178174; cv=none; b=u6lGENjA/OfGfem/1YAyIRvRkz5fLLucNo7q8JVXpJSpBSPfyjNzg6qCnwBR58ZvNdjJKAGzf/+UwLcFOQRP5zb+sRc6CM56jZLSXAY5G070og8zs20OG4qui6x5s0pk0W3Q9Vbs2vaRdrCPCf3SeAoyusJFFD0bGBPvUfOxSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178174; c=relaxed/simple;
	bh=2frVFjWSbkIubBzKNYupB6dSL2ceq3SjJXSzF2FjfH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a4TCXbei5Vp1Oymi/oduUehbcPTYjyY1NJmU8bVSqHve7xwIev44o9RAx+fl8oHqGOcIwqG6tLyo1/qEYh36w8We2eeo/MBaaWxEoNjiJbT5IxC6c9Pf6S++h8O1GOtfkym9t0GWvSQKs/wYuof4Lf88vtRUJu2CXSbQ+kipNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oDdTdDqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E55C4CED2;
	Mon,  6 Jan 2025 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178174;
	bh=2frVFjWSbkIubBzKNYupB6dSL2ceq3SjJXSzF2FjfH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDdTdDqWnkLT7e2qVNrKlW7Kjxh395987Elh9m/BTse/ipD9RmQP/NLxQF7AYoHLv
	 H/RLGMULUJyU6C8q+ODdpap+lBP91eLhXGQYDy36rOE7/8IozplkciCst9gfZPIuNO
	 HeKTgLOG8MMEkLWREH88UcDEFkHz+pToNOFriBnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.10 030/138] drm/modes: Avoid divide by zero harder in drm_mode_vrefresh()
Date: Mon,  6 Jan 2025 16:15:54 +0100
Message-ID: <20250106151134.359390379@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
References: <20250106151133.209718681@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 9398332f23fab10c5ec57c168b44e72997d6318e upstream.

drm_mode_vrefresh() is trying to avoid divide by zero
by checking whether htotal or vtotal are zero. But we may
still end up with a div-by-zero of vtotal*htotal*...

Cc: stable@vger.kernel.org
Reported-by: syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241129042629.18280-2-ville.syrjala@linux.intel.com
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_modes.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -757,14 +757,11 @@ EXPORT_SYMBOL(drm_mode_set_name);
  */
 int drm_mode_vrefresh(const struct drm_display_mode *mode)
 {
-	unsigned int num, den;
+	unsigned int num = 1, den = 1;
 
 	if (mode->htotal == 0 || mode->vtotal == 0)
 		return 0;
 
-	num = mode->clock;
-	den = mode->htotal * mode->vtotal;
-
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
@@ -772,6 +769,12 @@ int drm_mode_vrefresh(const struct drm_d
 	if (mode->vscan > 1)
 		den *= mode->vscan;
 
+	if (check_mul_overflow(mode->clock, num, &num))
+		return 0;
+
+	if (check_mul_overflow(mode->htotal * mode->vtotal, den, &den))
+		return 0;
+
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }
 EXPORT_SYMBOL(drm_mode_vrefresh);



