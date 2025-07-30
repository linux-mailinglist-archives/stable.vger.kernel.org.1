Return-Path: <stable+bounces-165544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE24B16452
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66587B4ED1
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D42DAFA9;
	Wed, 30 Jul 2025 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b="KIrBxwcq"
X-Original-To: stable@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0762DECB3
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892004; cv=none; b=Gu26S8t3ZAPqC5Z0FIIcoIaw460I6INyoj1MBZyr1U5q9lUj5zr7Rs55C5PVcllr7GGSBgcjcgTkmh+/jEz0yMU8BhSxJviD3qv6a2eO6kOZ2aF7YTq78rxUSjTGi2uWdZDdSAGVEKQF+bQRC4GzdrS6u04WTaK+xUaUrbqvYsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892004; c=relaxed/simple;
	bh=Mnasfro9zaP010Sw6oikQFW/qB20gm4T/Lc08Lp2RyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmINRlfd2qyiXZqs3XY9oeXPsBlBFk7sgNliSg3ydbgFJrxIr8ra6VF3IpP7IzM4GIh4LFM6uy9aMej9qwseW2oRNEMQV5FcfT0VBkcYgDyolPhTyGN4Z4BZxyzlPvlQcCZtz1VpRCekwOY5r0icl/BBNyjKrmY66+lfJy2gsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=nicusor.huhulea@siemens.com header.b=KIrBxwcq; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202507301613123537867424870ff5b2
        for <stable@vger.kernel.org>;
        Wed, 30 Jul 2025 18:13:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=nicusor.huhulea@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SM18kxHUwUOMwVIKh7FMbuWbiK+t9G6vHIfzFyWk3rk=;
 b=KIrBxwcqCMFleJ5qRPVb0wv3K58/GG0o58C4dCCy6FcUj+sNOYa/UVG8PCswiIMv9ZanP0
 +BgzxeMZqgMoYsXp3/wAyTJYVuwZ8pl/WqGh36F2wLg6Bu8Z15JW7otMKdjRayAtHGikUQqt
 r7KQaqsU/dkUvwM5JNjMNToG5Sx+vaZB6mindv/8EAkDJ4AfafMLenAZJkPVhlHj3qCNBWcT
 S7LX5340SuNBV/si9AWLB8hwvHZwB4mMjsAXKrD5Pe84I0x1blKP2DeARP9TBh+Ci2CmNeKL
 hErGA6pUytr3yevUp6odglx8BbZedmYV22HKQOLfANkfht8tGHh/J1Yw==;
From: Nicusor Huhulea <nicusor.huhulea@siemens.com>
To: stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: cip-dev@lists.cip-project.org,
	imre.deak@intel.com,
	jouni.hogander@intel.com,
	neil.armstrong@linaro.org,
	jani.nikula@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tvrtko.ursulin@linux.intel.com,
	laurentiu.palcu@oss.nxp.com,
	cedric.hombourger@siemens.com,
	shrikant.bobade@siemens.com,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nicusor Huhulea <nicusor.huhulea@siemens.com>
Subject: [PATCH 1/5] drm/i915: Fix HPD polling, reenabling the output poll work as needed
Date: Wed, 30 Jul 2025 19:11:02 +0300
Message-Id: <20250730161106.80725-2-nicusor.huhulea@siemens.com>
In-Reply-To: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
References: <20250730161106.80725-1-nicusor.huhulea@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1331196:519-21489:flowmailer

From: Imre Deak <imre.deak@intel.com>

commit 50452f2f76852322620b63e62922b85e955abe94 upstream.

While this commit is not a direct cherry-pick, the critical fix(two lines)
was adapted and applied.

After the commit in the Fixes: line below, HPD polling stopped working
on i915, since after that change calling drm_kms_helper_poll_enable()
doesn't restart drm_mode_config::output_poll_work if the work was
stopped (no connectors needing polling) and enabling polling for a
connector (during runtime suspend or detecting an HPD IRQ storm).

After the above change calling drm_kms_helper_poll_enable() is a nop
after it's been called already and polling for some connectors was
disabled/re-enabled.

Fix this by calling drm_kms_helper_poll_reschedule() added in the
previous patch instead, which reschedules the work whenever expected.

Fixes: d33a54e3991d ("drm/probe_helper: sort out poll_running vs poll_enabled")
Cc: stable@vger.kernel.org # 6.4+
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230822113015.41224-2-imre.deak@intel.com
Signed-off-by: Nicusor Huhulea <nicusor.huhulea@siemens.com>
---
 drivers/gpu/drm/i915/display/intel_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
index f7a2f485b177..6ba2d7b0cd1b 100644
--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
@@ -208,7 +208,7 @@ intel_hpd_irq_storm_switch_to_polling(struct drm_i915_private *dev_priv)
 
 	/* Enable polling and queue hotplug re-enabling. */
 	if (hpd_disabled) {
-		drm_kms_helper_poll_enable(dev);
+		drm_kms_helper_poll_reschedule(&dev_priv->drm);
 		mod_delayed_work(system_wq, &dev_priv->display.hotplug.reenable_work,
 				 msecs_to_jiffies(HPD_STORM_REENABLE_DELAY));
 	}
@@ -638,7 +638,7 @@ static void i915_hpd_poll_init_work(struct work_struct *work)
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (enabled)
-		drm_kms_helper_poll_enable(dev);
+		drm_kms_helper_poll_reschedule(&dev_priv->drm);
 
 	mutex_unlock(&dev->mode_config.mutex);
 
-- 
2.39.2


