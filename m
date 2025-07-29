Return-Path: <stable+bounces-165051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF613B14CB2
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FCA543828
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780628C013;
	Tue, 29 Jul 2025 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlFmBsX7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF331289E0B
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 11:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787141; cv=none; b=Ka6+/ubG2Ir42632bBAl3tFNuSqEUAP/uqFIsAV0eiD/7YI3Qu3ElWvtMfQswwNK3jQuCpxCvjMvKX4ow7y/MK6zsd0Wk9lo2A0W9gxXuuCjBXku8ts/dQiIe0CiYNvCr3ylCEY4fCvPsUEZzWvk/604EqQJcrv0NK19WSdJY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787141; c=relaxed/simple;
	bh=J6pUgHT41C3Vivm3o3boU9DDKpnNUXsM9GOyzVDtYJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtZT5N3HdM1emW/sqF1BDctPrUHtZALbEnmQVAv7iVi9cbIpS+iJUhf5pw0spOEw/n2sAQ0CZ/hpLt7usSIy7aVs1UAMaeG/IaSjy+hYCjKfy3bhAuKII89BoNe9wyDmumdOqkpehnTKnpQDwm8gAEkHdTaipPx/1sCqR+uXRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlFmBsX7; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b34a71d9208so4019502a12.3
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753787138; x=1754391938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qVjAx/GPjljGiOQfDzA/cI0gXeEo2lcWvHyzfRGgd18=;
        b=IlFmBsX7bxr+xxtEARl1cu3Qe++CjYO1Q18wukO2N4W42t+/QaKCMpcfJMM4mItcYu
         f1487bjL3OdAZUc7sbEsKHYY3Kw0PsTxV7AforwWdaiMHG5uRg+2KzPWaAZ3A+jAGQJ0
         +EarHmImO3dQBD/JFu1ry2I+WvW/7hhzdyuUMvPfJv7ZBZF7dozfs+i6AKCmsjLBQX87
         BjHvwu2zsCy8Jm6tJN2te3uJuEEMHjVb0rE8LDDf0jtjSSSXsSH976+7r6Gl4mFXv2C4
         tfMQ2CH/xvyCyJXKIpUowjxR5H8G3GSA8v5jpT0P5+Tau7czoMpP6ECgp8AvwblLZvfq
         +ZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787138; x=1754391938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVjAx/GPjljGiOQfDzA/cI0gXeEo2lcWvHyzfRGgd18=;
        b=hYTl2qvO7iIkB5avbQTO++pdYBrgXacW09zdapHUMrs7bMfrEXwVT480s1lxy5F+Z8
         9jCaWwrcgcKNg7O+zr1p8FvAGhLJSfG455fKoKe0NfqSQcNvyv7jL1bjESAE24fyuXVL
         +v0TqB2ud9rEJc01RHowTXFqwEVLVq1ZH69l1oyeLI9Lm8z0Lr7PjtGCv1CO1+sp+1p2
         95XX6dDmO9KazVPA5DRsf211wLhIJUwB8WRDpoJuKPR6LtyjGG0n7BQ4YLPgg/bs9Kqn
         Y3QWNjhjQkbdLkjpdDjtbUwhwUKoi95jv4Om1t2AJ5b1uK5+hPc3ttbjNA6CQQqRnzkb
         T05w==
X-Forwarded-Encrypted: i=1; AJvYcCWsa0gZES62BAjZXJFV0Aad+w0xMSU7OwHn3MaMsgemiiI2kRKdUID5W4qNb0J4LPB2HIRgvGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi85Fyg7qebEbU+M0CbZhbGSUVEnXRif++QaAsIlbcMkwJ/KSq
	/e8EzF+qnpi+TOhmZ0EEaRMvuQThx0FPptkyjQApfJO9P01TvXJEtfU=
X-Gm-Gg: ASbGncsuRBeeVKydUE6fjqX11nvdz3kgH+SOpuzX7q82B9c2Qviha8QpkcqUhSwkG6p
	2wCBHG+rsWmOjGR+mrSp4vnxTjqCio7gHBwoI17IsZZR2YCrtZFjsJBDaEdofkbHHx6j3HCJXwJ
	+PpRgx68rdO/QRbys6aPnr7HYYbh7EDODJZaWdTRQfhb/Kd3PTGrqVNRrsuvRQVwshIzNLkp6Qq
	F/YTa0/v6ghsJ7Fu5EIKKOL8WH1qfe6OS4miKDJNNEdV9BwyInGuH2WGDndNXt18huoo9+/0bkn
	7WAf38T++q7BRaW43Qq0CXcPdmuIaWE/N5Pozf6rYYTSWgs7d/1VXnlxqgXlBQdmJCVhlMzS7DR
	eQbL0IEI//7DxxqyDaAnIQEDAzE44fZsrraB/1VSB9F0iNSCXpw==
X-Google-Smtp-Source: AGHT+IF1ELZzJKdpQslsUHi7FZQ5vUSYWawTXVGHtqhOkWX4nj43CqxoSKZ3XPID7VpCyiElBn61Iw==
X-Received: by 2002:a17:903:15c8:b0:23f:f071:1069 with SMTP id d9443c01a7336-23ff0711244mr131983075ad.16.1753787137829;
        Tue, 29 Jul 2025 04:05:37 -0700 (PDT)
Received: from git-send-email.moeko.lan ([139.227.17.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bc1fsm75929025ad.5.2025.07.29.04.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:05:37 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH 6.12 0/4] drm/xe: Fix xe_force_wake_get return handling
Date: Tue, 29 Jul 2025 19:05:21 +0800
Message-ID: <20250729110525.49838-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes the xe driver probe fail with -ETIMEDOUT issue in
linux 6.12.35 and later version. The failure is caused by commit
d42b44736ea2 ("drm/xe/gt: Update handling of xe_force_wake_get return"),
which  incorrectly handles the return value of xe_force_wake_get as
"refcounted domain mask" (as introduced in 6.13), rather than status
code (as used in 6.12).

In 6.12 stable kernel, xe_force_wake_get still returns a status code.
The update incorrectly treats the return value as a mask, causing the
return value of 0 to be misinterpreted as an error. As a result, the
driver probe fails with -ETIMEDOUT in xe_pci_probe -> xe_device_probe
-> xe_gt_init_hwconfig -> xe_force_wake_get.

[ 1254.323172] xe 0000:00:02.0: [drm] Found ALDERLAKE_P (device ID 46a6) display version 13.00 stepping D0
[ 1254.323175] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] ALDERLAKE_P  46a6:000c dgfx:0 gfx:Xe_LP (12.00) media:Xe_M (12.00) display:yes dma_m_s:39 tc:1 gscfi:0 cscfi:0
[ 1254.323275] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] Stepping = (G:C0, M:C0, B:**)
[ 1254.323328] xe 0000:00:02.0: [drm:xe_pci_probe [xe]] SR-IOV support: no (mode: none)
[ 1254.323379] xe 0000:00:02.0: [drm:intel_pch_type [xe]] Found Alder Lake PCH
[ 1254.323475] xe 0000:00:02.0: probe with driver xe failed with error -110

Similar return handling issue cause by API mismatch are also found in:
Commit 95a75ed2b005 ("drm/xe/tests/mocs: Update xe_force_wake_get() return handling")
Commit 9ffd6ec2de08 ("drm/xe/devcoredump: Update handling of xe_force_wake_get return")

This patchset fixes them by reverting them all.

Additionally, commit deb05f8431f3 ("drm/xe/forcewake: Add a helper
xe_force_wake_ref_has_domain()") is also reverted as it is not needed in
6.12.


Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5373
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>


Tomita Moeko (4):
  Revert "drm/xe/gt: Update handling of xe_force_wake_get return"
  Revert "drm/xe/tests/mocs: Update xe_force_wake_get() return handling"
  Revert "drm/xe/devcoredump: Update handling of xe_force_wake_get
    return"
  Revert "drm/xe/forcewake: Add a helper xe_force_wake_ref_has_domain()"

 drivers/gpu/drm/xe/tests/xe_mocs.c  |  21 +++---
 drivers/gpu/drm/xe/xe_devcoredump.c |  14 ++--
 drivers/gpu/drm/xe/xe_force_wake.h  |  16 -----
 drivers/gpu/drm/xe/xe_gt.c          | 105 +++++++++++++---------------
 4 files changed, 63 insertions(+), 93 deletions(-)

-- 
2.47.2


