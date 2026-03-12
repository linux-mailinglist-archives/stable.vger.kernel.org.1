Return-Path: <stable+bounces-225220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBlMH58xs2ntSwAAu9opvQ
	(envelope-from <stable+bounces-225220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:35:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD9927A107
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50DF030E9597
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C33EF67C;
	Thu, 12 Mar 2026 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JcTYpUWp"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730851B4F0A;
	Thu, 12 Mar 2026 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351304; cv=none; b=HrE0Zx2F0/45jQP4cW8wQsoWRi/1TU80F2ZrdqK2yWMv9TF4U7HO3D4234VrDWtKQUEEGAYdBw3OBWKYs+9CXDCiObeOD85zHuXmfNLy2acrj+60GyT+h5DLbPgJbCI7RjTOSHPNU16MznzAqJOUrAuC0UUCGsjb2FxuPeKWeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351304; c=relaxed/simple;
	bh=hMV8b2zX+MF3vz/Lexi8nix/0TRXQp0tGvL+/FqMPR8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V54LAXQiifGmiYOtFOIFg+vJ1nBRyRjLL6WzcumwjpPNcOMRjlO3LGksIYdUyZqyXR57MElnRxAbKKAQxVpY8/3gSwlof2WJbFTf26vxNwWRWk9ftNxT1JB0aWAf7cl5PcrHS2ME7OdqjDjRB0LB5eX+je6gcmNZFLC7f1pbitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JcTYpUWp; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VGnkNRbRIEFHMah1+akqFhtLH6g58Zk2y++AAOv+YdQ=; b=JcTYpUWpKsT87x8t8maCHWrVl2
	iiDgVs7oxAxrgH8T/lzBgDAsjOrIUXPimx82x6BiwB5lI37BJfhc2dKoIBNMWpkRwxDh/6akGFR3/
	RMfy62dcd+Y6hv9IdwpS+H2uhjFP6IPllzelrMU0voGT3W5J/IUicx9AttbtcKfk0/nJafcchbUr2
	B88Zmj+GxUuenVVg+IP+2r1d9oPr3IzYyPiapPA5HqeZa2BeakADYgH1h37N9JVlWG9dsjHM5sbVv
	dn1t21EreEcj3exSnXT03ur/2l1dH8hN+DDUEhptRT9Bw9VbULQG9xn7gUI0X7MDXvgOGwn4yM+7i
	y7uvj/7Q==;
Received: from [189.7.87.203] (helo=[10.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w0ng3-00ElyQ-So; Thu, 12 Mar 2026 22:34:44 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v7 0/5] Power Management for Raspberry Pi V3D GPU
Date: Thu, 12 Mar 2026 18:34:22 -0300
Message-Id: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQwWrDMAwG4FcpPs/Dkm3F6WnvMXawYyU1LElJS
 rZR8u5zCmMZwez4C+kT0l3MPCWexfl0FxMvaU7jkEP1dBLNxQ8dyxRzFqjQqgqdXHSU1/GDJ9n
 7wXfc83CTzCHkDhObmkQevU7cps8H+/qW8yXNt3H6emxZYKv+Ay4glaycamvEAMq4l9T59+Sfm
 7EXm7jgTtFQUDArSmO0FBTUZA6K/lFIAVBB0VkxDK4y7CBGOihmp2BJMVlpfIuxBYqG8aDYXwV
 BFxS7/cW7oB1w0FV9UGivlL5L20WKnG6jrh3ZP8q6rt9ohgtEFwIAAA==
X-Change-ID: 20250728-v3d-power-management-eebb2024dc96
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Chema Casanova <jmcasanova@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5519; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=hMV8b2zX+MF3vz/Lexi8nix/0TRXQp0tGvL+/FqMPR8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpszFrEGGWyOVcQm7udLKS1zmPWmwoOU9YViVjW
 7PoQukmHcKJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCabMxawAKCRA/8w6Kdoj6
 qgWdCACjr0YreuHpelFvJIcCxNHwOB1hbj0qDzl289Ol4tsiSyYNtVRfbluX8HWhhcW4+TFoBY0
 m28eUDwyO4+UWQTWa+jVnwGyMWQ3qxXA05tCIbI7JLybqUPtrcb1V+vhn+ZLQYbv3J3RTbNKs+0
 4R+kpxyk7ShC4eivqobVVV8YYxWpXoxdfUv7+KhG2hmgganhsbWPDgu+Rc01bzFYKoWTd06KfI2
 cneUalofeGnv8OsvTBA4QQnGx7EMPs2adhYqeG8hJA0u9c8SMJrGT5NBiAU9IugVaaXb1Ohwa8Z
 uT+DuFNGsOggJi96C5Dg8x1ni2G7laEqQDyndq7WbU0+9Ubk
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225220-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,kernel.org,broadcom.com,gmx.net,igalia.com,raspberrypi.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_SPAM(0.00)[0.040];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2AD9927A107
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series introduces Runtime Power Management (PM) support for the
Raspberry Pi V3D GPU.

Currently, the V3D clock remains enabled for the entire system uptime,
even when the GPU is idle. With the introduction of Runtime PM, the
clock can now be disabled during idle periods. For example, with this
series applied to a Raspberry Pi 5, if we check `vcgencmd measure_clock
v3d`, we get:

(idle)

$ vcgencmd measure_clock v3d
frequency(0)=0

(running glmark2)

$ vcgencmd measure_clock v3d
frequency(0)=960016128

Best regards,
- Maíra

v1 -> v2: https://lore.kernel.org/r/20250728-v3d-power-management-v1-0-780f922b1048@igalia.com

- [1/5] NEW PATCH: "clk: bcm: rpi: Add missing logs if firmware fails" (Stefan Wahren)
- [2/5] Remove the "Fixes:" tag (Stefan Wahren)
- [2/5] dev_err_ratelimited() instead of dev_err() (Stefan Wahren)
- [2/5] Instead of logging the clock ID, use clk_hw_get_name(hw) to log the name (Stefan Wahren)
- [2/5] Add a newline character at the end of the log message (Stefan Wahren)
- [2/5] Use CLK_IS_CRITICAL for all clocks that can't be disabled (Maxime Ripard)
- [3/5] NEW PATCH: "clk: bcm: rpi: Maximize V3D clock"
- [4/5] Use devm_reset_control_get_optional_exclusive() (Philipp Zabel)
- [4/5] Make sure that resources are cleaned in the inverse order of allocation (Philipp Zabel)

v2 -> v3: https://lore.kernel.org/r/20250731-v3d-power-management-v2-0-032d56b01964@igalia.com

- Rebased on top of drm-misc-next
- Patches "[PATCH v2 1/5] clk: bcm: rpi: Add missing logs if firmware
  fails", "[PATCH v2 2/5] clk: bcm: rpi: Turn firmware clock on/off when
  preparing/unpreparing", and "[PATCH v2 3/5] clk: bcm: rpi: Maximize
  V3D clock" were applied to clk-next.
- [1/4] NEW PATCH: "clk: bcm: rpi: Let V3D consumers manage clock rate"
- [2/4] NEW PATCH: "clk: bcm: rpi: Mark PIXEL_CLK and HEVC_CLK as CLK_IGNORE_UNUSED"
- [3/4] Add Philipp's R-b (Philipp Zabel)
- [4/4] s/DRM_ERROR/drm_err
- [4/4] Set the clock rate to 0 during suspend and to the maximum rate during resume

v3 -> v4: https://lore.kernel.org/r/20260116-v3d-power-management-v3-0-4e1874e81dd6@igalia.com

- Rebased on top of drm-misc-next
- [1/6, 3/6] Add Melissa's A-b (Melissa Wen)
- [2/6] NEW PATCH: "clk: bcm: rpi: Add a comment about RPI_FIRMWARE_SET_CLOCK_STATE
  behavior" (Stefan Wahren)
- [4/6] NEW PATCH: "drm/v3d: Use devm_reset_control_get_optional_exclusive()" (Melissa Wen)
- [5/6] Include more context in the commit message (Melissa Wen)
- [5/6, 6/6] Instead of creating the function v3d_gem_allocate(), use v3d_gem_init()
  and move HW initialization out of it (Melissa Wen)

v4 -> v5: https://lore.kernel.org/r/20260126-v3d-power-management-v4-0-caf2df16d4e2@igalia.com

- [2/7] Add Stefan's A-b (Stefan Wahren)
- [2/7, 5/7, 6/7] Add Melissa's R-b (Melissa Wen)
- [4/7] NEW PATCH: "pmdomain: bcm: bcm2835-power: Increase ASB control timeout"
- [7/7] Remove redundant pm_runtime_mark_last_busy() from v3d_pm_runtime_put()
- [7/7] Use pm_runtime_get_if_active() in v3d_mmu_flush_all() instead of
  pm_runtime_get_noresume() + pm_runtime_active()
- [7/7] Add missing PM runtime calls to v3d_perfmon_start() and v3d_perfmon_stop()

v5 -> v6: https://lore.kernel.org/r/20260213-v3d-power-management-v5-0-7a8b381eb379@igalia.com

- [1/6] NEW PATCH: "clk: bcm: rpi: Manage clock rate in prepare/unprepare
  callbacks" (Maxime Ripard)
    - Replaces "clk: bcm: rpi: Let V3D consumers manage clock rate" and
      "clk: bcm: rpi: Add a comment about RPI_FIRMWARE_SET_CLOCK_STATE
      behavior" 
- [6/6] Stop setting min and max clock rates directly in v3d (Maxime Ripard)

v6 -> v7: https://lore.kernel.org/r/20260218-v3d-power-management-v6-0-40683fd39865@igalia.com

- Drop commit "[PATCH v6 2/6] clk: bcm: rpi: Mark PIXEL_CLK and HEVC_CLK as CLK_IGNORE_UNUSED"
- [1/5] Add comment about why is okay to set the clock's rate at prepare/unprepare (Maxime Ripard)
- [1/5] Use clk_hw_get_rate_range() (Maxime Ripard)
- [2/5] Add Stefan's R-b and stable tag (Stefan Wahren)
- [3/5] Add Philipp's R-b (Philipp Zabel)
- [5/5] Keep the alphabetical order in the Makefile (Stefan Wahren)
- [5/5] Propagate `reset_control_assert()` error (Stefan Wahren)
- [5/5] Add v3d_init_hw_state() before v3d_mmu_set_page_table()
- [5/5] Stop any active perfmon during suspend

---
Maíra Canal (5):
      clk: bcm: rpi: Manage clock rate in prepare/unprepare callbacks
      pmdomain: bcm: bcm2835-power: Increase ASB control timeout
      drm/v3d: Use devm_reset_control_get_optional_exclusive()
      drm/v3d: Allocate all resources before enabling the clock
      drm/v3d: Introduce Runtime Power Management

 drivers/clk/bcm/clk-raspberrypi.c    |  38 ++++++++-
 drivers/gpu/drm/v3d/Makefile         |   1 +
 drivers/gpu/drm/v3d/v3d_debugfs.c    |  23 ++++-
 drivers/gpu/drm/v3d/v3d_drv.c        | 160 +++++++++++++++++------------------
 drivers/gpu/drm/v3d/v3d_drv.h        |  18 ++++
 drivers/gpu/drm/v3d/v3d_gem.c        |  18 ++--
 drivers/gpu/drm/v3d/v3d_irq.c        |  15 ++--
 drivers/gpu/drm/v3d/v3d_mmu.c        |  10 ++-
 drivers/gpu/drm/v3d/v3d_perfmon.c    |  18 +++-
 drivers/gpu/drm/v3d/v3d_power.c      |  88 +++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_submit.c     |  19 ++++-
 drivers/pmdomain/bcm/bcm2835-power.c |   5 +-
 12 files changed, 291 insertions(+), 122 deletions(-)
---
base-commit: ece3e8980907818c72dc9faa7bbaf40488ef1824
change-id: 20250728-v3d-power-management-eebb2024dc96


