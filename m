Return-Path: <stable+bounces-95772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5339E9DBF04
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 05:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1774A2819A0
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 04:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966901547F3;
	Fri, 29 Nov 2024 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8R7ARbQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A52914
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732854398; cv=none; b=m/iorZx7U5eyTA5uzBgIqzY7X/nN7NBBeAheHwxGxESR87aUBpA8ybkxo9sLE2AMB3Jo419QnmyWWv49gMROhVzzDwcdwgUwlqV91MbzqfpVo5wdtz2jQ1Xm5nUfqo9DbaCxbf9nPf297JYcqTNXmgqA7vEFOyBlfM8S/2BQ3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732854398; c=relaxed/simple;
	bh=0s4InliC6VAvu6bYSTO0TI4H7F1qiAT6qTeTPxYWch4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsuHM/CZsgsH+hdpB1nFLR7m4K2OpSDN2aptPUgbxaltCllBBfenAR9dVPlhxHWVMocHeyYHiO/ufj8fcOqdG8nNwNR/hOHvaozSTZB2YwXMDoWroJ1FXihZU8IM5tbzUu2z3wvn9oAgeAZnqIgS9UCijqeNAZ9sclJoABEuCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8R7ARbQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732854397; x=1764390397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0s4InliC6VAvu6bYSTO0TI4H7F1qiAT6qTeTPxYWch4=;
  b=C8R7ARbQxEsgk4mjlSgCkO8YRQhRf7AAVzSR2hyJW6NHSRYP6vvYrV6P
   3J6D+HEpIZoxkDBTBD+BzKh/7LXpCLfrWW996McqztHzZx7c9hP3HExBJ
   rzLN8khRrIaGT5bCjS4KawX1UFCfvrmnQevXLSzIgcR2Gkrer8ByjnljX
   3rLMRSgeD85gaLhlMUsD6ulYDPi/+MgNi3km8ml986bIogsc2LS8xH9H4
   PiqEGZSjFPNyAFk4Fkmd9U1ko4Y6p7MMQA8RgprxnE+csHLmB+AGu4m7j
   D8L3IOgMEbyoChzlufv3Jykt6WQc6KpR1L2TVqDi1XBhnwnjc7BKlIOQh
   w==;
X-CSE-ConnectionGUID: HMqfzKgATRG+76leOA+OgQ==
X-CSE-MsgGUID: UN01NnkxTR2jCu7Fm0by6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33028018"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="33028018"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 20:26:36 -0800
X-CSE-ConnectionGUID: rpl4Y5T+Thy0tlTqzqppyw==
X-CSE-MsgGUID: TxGKJZhHQqqP+fHo5jULyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92567174"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 28 Nov 2024 20:26:33 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 29 Nov 2024 06:26:32 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	stable@vger.kernel.org,
	syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com
Subject: [PATCH 1/2] drm/modes: Avoid divide by zero harder in drm_mode_vrefresh()
Date: Fri, 29 Nov 2024 06:26:28 +0200
Message-ID: <20241129042629.18280-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129042629.18280-1-ville.syrjala@linux.intel.com>
References: <20241129042629.18280-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

drm_mode_vrefresh() is trying to avoid divide by zero
by checking whether htotal or vtotal are zero. But we may
still end up with a div-by-zero of vtotal*htotal*...

Cc: stable@vger.kernel.org
Reported-by: syzbot+622bba18029bcde672e1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_modes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 6ba167a33461..71573b85d924 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1287,14 +1287,11 @@ EXPORT_SYMBOL(drm_mode_set_name);
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
@@ -1302,6 +1299,12 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
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
-- 
2.45.2


