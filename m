Return-Path: <stable+bounces-124074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3B7A5CD8D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BB21649EF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3BE263C80;
	Tue, 11 Mar 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UTtd72TQ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533AC25D8E8;
	Tue, 11 Mar 2025 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716872; cv=none; b=NlLk1ZKGMmvu+Z4WpIYVnu0wCeigxyRn1EvaApQ7vmIkdFG38s+ZimjwIDJG68xLO3JpefjirXDAgqWBmLtWb7ZCwNvFSZuMEPx0m6ELpGI/39Em0R7hDvIDWtOmHO5Sdp6SV+HC7OXoQ+5SkreIAncKv/TTIW1vR2RTFWM3ukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716872; c=relaxed/simple;
	bh=hMWF8zKKAHzWxlNZOG6AojB0SW5vtVKeB/kSm1RXJBQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AirOWn1wDmSnAN7slqEnMIkRtvHPn6ICyX1cTPBOnZvU+hxH8ke6o7E3YkzI3vhdX2cLUxF/m8tDzuWjT+JdnOtw+urS0Pf/ClUNFWYbs+pMNLeRzkSscD5fYnIa7VpBsqkq8fN41VgBj32BUAenxFWJr/122mqjcaKHT4jWFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UTtd72TQ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kFCH8u8gqei3C9HzLkQd8FkDTp/wkWzOvGSvNHUDtMU=; b=UTtd72TQQwb8/mx9eNv4tWX9E0
	11pC53OXOvy3eWDgM5mDn2n3ENG7jYq67mT7IBvpV7x/h1vYQbJNh63m+4/1HFFL2i7N4xtYAxfcl
	pGu6Pyt/XpcJcf2wIbV2QvZQJRZnxZoMlIqmx6a+cyX3KwACb5iu7r8tOrhBzj4ccYkT0FNGtBYaR
	bDaIN6E8CRaacXtioIEiWt4vS710W3IQ7jGio6hxB/vTRmAfgqV9l5qWgced3dGx5npuJli2DXhf4
	r/KbN81xPqcreQ0I5sB43+adtq6vf06WN5CkWf/sqh3mxHl3lnOc8sy3H1sgeOO0jCfkcIUJ8th/z
	xAvbSLIg==;
Received: from [189.7.87.170] (helo=janis.local)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ts47I-007Dal-O3; Tue, 11 Mar 2025 19:14:18 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 0/7] drm/v3d: Fix GPU reset issues on the Raspberry Pi 5
Date: Tue, 11 Mar 2025 15:13:42 -0300
Message-Id: <20250311-v3d-gpu-reset-fixes-v3-0-64f7a4247ec0@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFd90GcC/23NTQqDMBAF4KtI1p2STKyarnqP0kXIjw60KokNL
 eLdG4VSCi7fG943M4sukIvsXMwsuESRhj4HeSiY6XTfOiCbM0OOJ45YQpIW2vEJwUU3gaeXi4A
 WhTc1r4WwLC/H4LZDHl5vOXcUpyG8tydJrO3Xq3a9JIBDI7WqlLdWGXGhVt9JH83wYCuY8IdI3
 uwjmBFUUhnJPTem/EOWZfkAu8Y3cPwAAAA=
X-Change-ID: 20250224-v3d-gpu-reset-fixes-2d21fc70711d
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Phil Elwell <phil@raspberrypi.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, kernel-dev@igalia.com, stable@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Emma Anholt <emma@anholt.net>, "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=hMWF8zKKAHzWxlNZOG6AojB0SW5vtVKeB/kSm1RXJBQ=;
 b=owEBbQGS/pANAwAIAT/zDop2iPqqAcsmYgBn0H106U0gguzuVZSyJme+kJfLKsJedLNH4fVcB
 1JRRtoVIU2JATMEAAEIAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCZ9B9dAAKCRA/8w6Kdoj6
 qvSZCAC+F8R9aFT8L2oaT27i0oobToAT+U6ewrufIX7fDt3buiwjfWiodKvML0N8hziJ0H5f/hj
 5k4bcAfJYJbjYI+RzgdIAoLz5KwvaKXYonRvNq0VVrh4zvTZLnJkhuS7Je9iiNSNAnGoopFqSHY
 ixVLX/Zc1mkNnYGIoZgp7RRT91HloLABVOYkZCho8egOO/H7Bvn6ShRfL2VsGUsX2ycDvb4lpvw
 rPiIqIagqNzTnoGkrrFVXesOyR7FXZCHTbWIP2E+ICKeEn3LJ/a7FkqEonf6PMlqj/HtxCPCAz+
 f3inZhnhtEC81DRgmcn4oSx9bwyLaznS9pDt8CS84HaSlYuk
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

This series addresses GPU reset issues reported in [1], where running a
long compute job would trigger repeated GPU resets, leading to a UI
freeze.

Patches #1 and #2 prevent the same faulty job from being resubmitted in a
loop, mitigating the first cause of the issue.

However, the issue isn't entirely solved. Even with only a single GPU
reset, the UI still freezes on the Raspberry Pi 5, indicating a GPU hang.
Patches #3 to #6 address this by properly configuring the V3D_SMS
registers, which are required for power management and resets in V3D 7.1.

Patch #7 updates the DT maintainership, replacing Emma with the current
v3d driver maintainer.

[1] https://github.com/raspberrypi/linux/issues/6660

Best Regards,
- Maíra

---
v1 -> v2:
- [1/6, 2/6, 5/6] Add Iago's R-b (Iago Toral)
- [3/6] Use V3D_GEN_* macros consistently throughout the driver (Phil Elwell)
- [3/6] Don't add Iago's R-b in 3/6 due to changes in the patch
- [4/6] Add per-compatible restrictions to enforce per‐SoC register rules (Conor Dooley)
- [6/6] Add Emma's A-b, collected through IRC (Emma Anholt)
- [6/6] Add Rob's A-b (Rob Herring)
- Link to v1: https://lore.kernel.org/r/20250226-v3d-gpu-reset-fixes-v1-0-83a969fdd9c1@igalia.com

v2 -> v3:
- [3/7] Add Iago's R-b (Iago Toral)
- [4/7, 5/7] Separate the patches to ease the reviewing process -> Now,
  PATCH 4/7 only adds the per-compatible rules and PATCH 5/7 adds the
  SMS registers
- [4/7] `allOf` goes above `additionalProperties` (Krzysztof Kozlowski)
- [4/7, 5/7] Sync `reg` and `reg-names` items (Krzysztof Kozlowski)
- Link to v2: https://lore.kernel.org/r/20250308-v3d-gpu-reset-fixes-v2-0-2939c30f0cc4@igalia.com

---
Maíra Canal (7):
      drm/v3d: Don't run jobs that have errors flagged in its fence
      drm/v3d: Set job pointer to NULL when the job's fence has an error
      drm/v3d: Associate a V3D tech revision to all supported devices
      dt-bindings: gpu: v3d: Add per-compatible register restrictions
      dt-bindings: gpu: v3d: Add SMS register to BCM2712 compatible
      drm/v3d: Use V3D_SMS registers for power on/off and reset on V3D 7.x
      dt-bindings: gpu: Add V3D driver maintainer as DT maintainer

 .../devicetree/bindings/gpu/brcm,bcm-v3d.yaml      |  77 +++++++++++--
 drivers/gpu/drm/v3d/v3d_debugfs.c                  | 126 ++++++++++-----------
 drivers/gpu/drm/v3d/v3d_drv.c                      |  62 +++++++++-
 drivers/gpu/drm/v3d/v3d_drv.h                      |  22 +++-
 drivers/gpu/drm/v3d/v3d_gem.c                      |  27 ++++-
 drivers/gpu/drm/v3d/v3d_irq.c                      |   6 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |   4 +-
 drivers/gpu/drm/v3d/v3d_regs.h                     |  26 +++++
 drivers/gpu/drm/v3d/v3d_sched.c                    |  29 ++++-
 9 files changed, 281 insertions(+), 98 deletions(-)
---
base-commit: 9e75b6ef407fee5d4ed8021cd7ddd9d6a8f7b0e8
change-id: 20250224-v3d-gpu-reset-fixes-2d21fc70711d


