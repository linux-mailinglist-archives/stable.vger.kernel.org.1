Return-Path: <stable+bounces-22595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFB85DCC7
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1965DB22CA5
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD678B7C;
	Wed, 21 Feb 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkD3OPPA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DD78B53;
	Wed, 21 Feb 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523859; cv=none; b=CtqOJv7crfqm0nAdkp0rcnoCBXnbEYihNmD9Ic1JOAODlBL5T0uuRtBLJK3oSa2UJK60+flAOLho2ZWSldKjNYLsXz8V52KzRigX7GwBRbNCLiBchbPdKij7z/+76DzEPrUAyfFBMZsoR9N9gHZ0mvN80iq/QZ+YJu5ksIbP5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523859; c=relaxed/simple;
	bh=z2CwmBzqwLH6iBFmWX2JuZB7IBUinK/KLo8kGuxcsbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UK7UG51l9QgJ8Yt0AC1767qquisUGOQvPrh++otBYp/aqq6XccNvVglOGNyMiAlN9M+/HSS32mb3IWUZ1nhYQK8tJiZhCQjuGwhjkRuKet+ErjTBNLldAwzqNHrR/3rFBzIclf/P0DhFvA/6H3Q+Wt7Z5X826s+niPgsT1M5a0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkD3OPPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031F6C433F1;
	Wed, 21 Feb 2024 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523859;
	bh=z2CwmBzqwLH6iBFmWX2JuZB7IBUinK/KLo8kGuxcsbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkD3OPPAi1x5JkUKcAk0SuAlpQEBgn51c+OG4ioJ59rXIkOlHayK43PuL7w17fy8g
	 qczLsRYVrcHAewsitpFqVEAoyqlOnfmn/agwG11bN/NgZNRn5TpnEDN9W2uDFea4aP
	 LwEfIiYUjBR2fjzh2dcX5O04avWiKhaTzaF99WSo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 5.10 075/379] drm/tidss: Fix atomic_flush check
Date: Wed, 21 Feb 2024 14:04:14 +0100
Message-ID: <20240221125957.130119342@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

commit 95d4b471953411854f9c80b568da7fcf753f3801 upstream.

tidss_crtc_atomic_flush() checks if the crtc is enabled, and if not,
returns immediately as there's no reason to do any register changes.

However, the code checks for 'crtc->state->enable', which does not
reflect the actual HW state. We should instead look at the
'crtc->state->active' flag.

This causes the tidss_crtc_atomic_flush() to proceed with the flush even
if the active state is false, which then causes us to hit the
WARN_ON(!crtc->state->event) check.

Fix this by checking the active flag, and while at it, fix the related
debug print which had "active" and "needs modeset" wrong way.

Cc:  <stable@vger.kernel.org>
Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Link: https://lore.kernel.org/r/20231109-tidss-probe-v2-10-ac91b5ea35c0@ideasonboard.com
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tidss/tidss_crtc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -168,13 +168,13 @@ static void tidss_crtc_atomic_flush(stru
 	struct tidss_device *tidss = to_tidss(ddev);
 	unsigned long flags;
 
-	dev_dbg(ddev->dev,
-		"%s: %s enabled %d, needs modeset %d, event %p\n", __func__,
-		crtc->name, drm_atomic_crtc_needs_modeset(crtc->state),
-		crtc->state->enable, crtc->state->event);
+	dev_dbg(ddev->dev, "%s: %s is %sactive, %s modeset, event %p\n",
+		__func__, crtc->name, crtc->state->active ? "" : "not ",
+		drm_atomic_crtc_needs_modeset(crtc->state) ? "needs" : "doesn't need",
+		crtc->state->event);
 
 	/* There is nothing to do if CRTC is not going to be enabled. */
-	if (!crtc->state->enable)
+	if (!crtc->state->active)
 		return;
 
 	/*



