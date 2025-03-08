Return-Path: <stable+bounces-121542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6A9A57B0A
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 15:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A676D16E916
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 14:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A08F1DC997;
	Sat,  8 Mar 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DHmpM7ZW"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39013E02A;
	Sat,  8 Mar 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741444463; cv=none; b=V4NatbiFC/9IGsXG2K023OQCafVed8Gjd7WuoBa0V8ehqmjmSFBDbt/xPAePCxZkjBIYke+4nULXXzfoV+FCDZzPbT6jCaeEmezJ64iZYrBuQoXcmeMdyC3BpF8BTVjbFDW2Ku3xgUdarLtn0quh0IZsmVv3gTcryNj0cWuGpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741444463; c=relaxed/simple;
	bh=pdNymSlsbpe8uVRSyKz81wI5yqC96/2ZvFYAx5+wgKs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XQ5ZfvOmMhGQxSMmIgzt60kuPUDz/9MeFYNmoi0ejjfiqGRj3f3sD2YUUCOIO17ByDOCotmNSOV9yviCMfvWDoLCOCgFTFLQE9fuqdMoybN+84UySqUJKv9OIF+1pkB/Bo75/gSVxyyGDvmIlK3PFjvHevjIUCsKtV0w4HwLQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DHmpM7ZW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vu0h/BCZvBL2GttHEpScRi6sdoInP2Ddqbir3Sw4qwo=; b=DHmpM7ZW7ivLe4KvO/AohFXhco
	LghEwzKuJ/aU59zQkP+lkMBnid+VJdtNaIRRYnE0dB9iRHOZhmtJLz1NHw5AT6svh069zLWkr3zbt
	4WVtg8esuS5iFJQ66OILyfV2DVfJvTQuFLCytUszq70ZID/iygt2neUoOz4N171q8vTgDWpnuLzX9
	BF6JnSxmWsqyT3RUm4uL9Wq9B04Eu5BGph1E46UCOQw8sdVEsD5aNpA8W2Z1SL3bVHjq8XXxlcJmI
	5xiLqMuCuRo1UtkK1LGDA/S3xj8zwXAI/s7UDlsaw13wDkxuIdTGoVJYb1ew6D0iWAboKAd6jss8F
	eoTal3LQ==;
Received: from [189.7.87.170] (helo=1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tqvFi-005pPS-2E; Sat, 08 Mar 2025 15:34:16 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/6] drm/v3d: Fix GPU reset issues on the Raspberry Pi 5
Date: Sat, 08 Mar 2025 11:33:39 -0300
Message-Id: <20250308-v3d-gpu-reset-fixes-v2-0-2939c30f0cc4@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAERVzGcC/22NwQ6CMBBEf4Xs2TXtoiCc/A/DoWkX2ESBtNhoS
 P/dSuLN45vJm9kgsBcO0BYbeI4SZJ4y0KEAO5ppYBSXGUjRWRGdMJYOh+WJngOv2MuLA5Ij3dt
 a1Vo7yObieS+yeOsyjxLW2b/3k6i/6W+v+rsXNSq8lKapmt65xuqrDOYu5mjnB3QppQ8xfNHJt
 wAAAA==
X-Change-ID: 20250224-v3d-gpu-reset-fixes-2d21fc70711d
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: Phil Elwell <phil@raspberrypi.com>, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com, stable@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>, devicetree@vger.kernel.org, 
 Emma Anholt <emma@anholt.net>, "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=pdNymSlsbpe8uVRSyKz81wI5yqC96/2ZvFYAx5+wgKs=;
 b=owEBbQGS/pANAwAIAT/zDop2iPqqAcsmYgBnzFVhxOl0dBvgSRGBD6facP8e1yDnsOI/56cJm
 DhXl25Ttt6JATMEAAEIAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCZ8xVYQAKCRA/8w6Kdoj6
 qqF+CACWPzSiYa3KsgTdGppJj6XUu5UqF7sw7+rMZhqkCgU2dFAeDuRZLMZMROq/kOToDUCMsXF
 nG22Oy2uGnqF8NeeUqW3wx1f9cotjSdo4ZSPxoNJz1WSkfp5EcZfTysZ3djWJH75kZok+cdaVfI
 XC+el5cj34gYPVTsGzpDiUpvZKXS3khVVGuGk2u5hk4QUEUUjSbufDokuSHvC2fNKeONNh49Uzt
 sRRaqU6MiYZolgukxvvOnXZeis7JFF12x0P3oBAwurZsOuz9DlGh+V54SaOu6jT+xeaAG0ofhUI
 GiUGMO5wJvkh6iPPimrVVUxVkbPfDlBVFe6Z5seDFPyyXzJo
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA

This series addresses GPU reset issues reported in [1], where running a
long compute job would trigger repeated GPU resets, leading to a UI
freeze.

Patches #1 and #2 prevent the same faulty job from being resubmitted in a
loop, mitigating the first cause of the issue.

However, the issue isn't entirely solved. Even with only a single GPU
reset, the UI still freezes on the Raspberry Pi 5, indicating a GPU hang.
Patches #3 to #5 address this by properly configuring the V3D_SMS
registers, which are required for power management and resets in V3D 7.1.

Patch #6 updates the DT maintainership, replacing Emma with the current
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

---
Maíra Canal (6):
      drm/v3d: Don't run jobs that have errors flagged in its fence
      drm/v3d: Set job pointer to NULL when the job's fence has an error
      drm/v3d: Associate a V3D tech revision to all supported devices
      dt-bindings: gpu: v3d: Add SMS to the registers' list
      drm/v3d: Use V3D_SMS registers for power on/off and reset on V3D 7.x
      dt-bindings: gpu: Add V3D driver maintainer as DT maintainer

 .../devicetree/bindings/gpu/brcm,bcm-v3d.yaml      |  62 +++++++++-
 drivers/gpu/drm/v3d/v3d_debugfs.c                  | 126 ++++++++++-----------
 drivers/gpu/drm/v3d/v3d_drv.c                      |  62 +++++++++-
 drivers/gpu/drm/v3d/v3d_drv.h                      |  22 +++-
 drivers/gpu/drm/v3d/v3d_gem.c                      |  27 ++++-
 drivers/gpu/drm/v3d/v3d_irq.c                      |   6 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |   4 +-
 drivers/gpu/drm/v3d/v3d_regs.h                     |  26 +++++
 drivers/gpu/drm/v3d/v3d_sched.c                    |  29 ++++-
 9 files changed, 271 insertions(+), 93 deletions(-)
---
base-commit: 2c7aafc05c8330be4c5f0092b79843507a5e1023
change-id: 20250224-v3d-gpu-reset-fixes-2d21fc70711d


