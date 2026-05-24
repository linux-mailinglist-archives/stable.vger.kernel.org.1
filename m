Return-Path: <stable+bounces-254042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF0kGxwgE2on8AYAu9opvQ
	(envelope-from <stable+bounces-254042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:58:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1D5C3059
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6026A3018AD1
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF539D6E5;
	Sun, 24 May 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgS9ROuT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5AD39B94F
	for <stable@vger.kernel.org>; Sun, 24 May 2026 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779638266; cv=none; b=aiEwzIhL+m6rn7VEVcNMavxBwG7gujV489ci5l5uMSFYv9x8S634DuH0y6w9CBrA6TBOukA6oJibWeLAMuztcwrNlxnkILdYIhDqN1LScltc+TZByipRt/ssfyqoNmhZ6rSjfiSbIh1A9hgDggHlorqBt+gjMD9He+1MMhLJs40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779638266; c=relaxed/simple;
	bh=4XyxSzDh/MH7gtFpuUEyWHv0AWwOrbUWrt5ubgaMhyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPkut9F/6S1FAq+A/OOtLSLaZN5K5Lim2k78/nY8IaKWC5XThnk097D8Bd46TgCtk28FxfFS8SQJMnpguntRljwYdJ2uScvachL4qULxUfgFCj/pSM9gN9+lkW2SBrAw8H2x01H3C6u6AOt7EnGuEbmQw1BsZERXghbd9+YLsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgS9ROuT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36900945df5so4434174a91.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779638263; x=1780243063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wuu4460x4/FBZThRE+KXHL2JDpzAJY9WR1Xg237ETeE=;
        b=GgS9ROuTljY3YJjiXSVO9t+CoodTfhdBmj1mI3Gf5qQ/0GmDJsAyK0PSuGdnTJcprY
         3rSjj1Te3tnGvGHMLugwX1Wndbe5Y6roP4uI4BR/7IJToDssiV+D7xi+YUhSFFePFmjE
         TkuusQFlzSFRl1VHvo+lck49nG1576QyhGPbFvoJD4xa100qNlC2FJWarc3lAL4t6EBJ
         6LI7nN5wthypgU6GShaO+m+e3XStFoPdjobpCkCBePHMQLled7eLtCzqXCrd8sj1zlzF
         v6GGv+6NXDaT9xRU6w3sWd3eRDJo1ms0KgKj6gJbPxxiVQ+QGceVFT0AXBVRmsr7KsBR
         2RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779638263; x=1780243063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuu4460x4/FBZThRE+KXHL2JDpzAJY9WR1Xg237ETeE=;
        b=ZDaxLGA1MwKnOXvCWpe88UsUYesymYsEhmZNs2FI4UdvGAwNmHD/SG0umL8JZ//xbH
         nRwbKoWUXKPbIuR28xTQDZ9CSq4XByM17ELTiJgO8tJqQxHDZZFHMmtbdAneIlbodG2T
         KX8xyHrMYD8g/ayo792eF9SLGAUd8H534uATEDyI/IbE8a4WRvw6YwlZIZ+HXsZjqqiJ
         HyEY2RMZVJFrE9mqkiFkOQWn9MyCJOgLq/pdNuczshKSTCVIst6ckqAy6jX+gPnaOMYo
         M5n2rYh6DTxBNnuDaFoZYjhUxDG1r9qRPKVEC/oXpOoh/N6zqurPtVdNHaJpdyYZtKAE
         P/Fw==
X-Forwarded-Encrypted: i=1; AFNElJ97GLzn/35TeqTYykWQkP3FSlFo9DDJAGhnzjjXI9aR+GZXdmj5ac4yxDgEaJFOACm5tTdRwo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3MTwmnd4vzZAK6PNz/Ahm3r/ZEg2Z/QUdf1cpnI2KmW/lIj3
	ry2iiIvqO2tU1Xe1OI6+6iV+YrfGWEBll+Ov3O1Q/1ep2E51tGkGvU0=
X-Gm-Gg: Acq92OHRVsVDGcdiO7M0D7SJFZkEAjCBoRMkSczFfhSs7UyTdR2PLgRmHEeC3nXgvG0
	Uu1+JB7UtBeklBeEYiptv0JVxB1fu90J24ozuQUKuLB73EuXePFQMYKNGY66177aPwxe4TKALYJ
	qyIaTN96PjX3MfMkfe8cqlZJtTnV4NR/q6q8WbYi7skBrfrgaZOzTGfMVgCCuWmxLf3ib7rW8ba
	/IfEaL4E6bFdcmZjJ1DqCgbBrajlkKDZmzRwAhYj7Yt0UddKxiYX/63/FiFES78Zkvb3fwyLheX
	hsNJGLMLc6BTew9JLfXcQM0R8idDC/YFXie7CE6S//fnGU4sKOyxEmxCMYnglGKE3BP53Z04nyt
	jcEzBECUcEn05D2GEKP5hxhAJ/VKte70XvlVBLNdKhHriVds50OEf7isMYzqQCxw09Pm8d5JgUN
	0pg2tUl3BtKdZM6CLHkd09QI6Lj2MV1vjYZGin1jpbG4RagiUx/OeAiQyNmwDujtpVGIqLLbE=
X-Received: by 2002:a17:90b:544f:b0:36a:b560:5c61 with SMTP id 98e67ed59e1d1-36ab560606bmr3756342a91.7.1779638262720;
        Sun, 24 May 2026 08:57:42 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71ecf799sm7169671a91.8.2026.05.24.08.57.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 08:57:41 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/gma500: clean up modeset on backlight init failure
Date: Mon, 25 May 2026 00:57:11 +0900
Message-ID: <20260524155735.13865-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254042-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BEE1D5C3059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

psb_driver_load() initializes KMS polling before it attempts to
initialize backlight support. If gma_backlight_init() fails, the
function returns directly and skips psb_driver_unload(), leaving
drm_kms_helper_poll_fini() uncalled.

Use the existing error path so the partially initialized modeset state
is unwound before probe fails.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 1f90b1232773 ("drm/gma500: Refactor backlight support (v2)")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 005ab7f535..7218026fe2 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -406,7 +406,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (ret)
-		return ret;
+		goto out_err;
 	psb_intel_opregion_enable_asle(dev);
 
 	return devm_add_action_or_reset(dev->dev, psb_device_release, dev);
-- 
2.47.1


