Return-Path: <stable+bounces-134866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9474A95363
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066EB1682FF
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5071A0BFE;
	Mon, 21 Apr 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="Okviei8X"
X-Original-To: stable@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348C2136672
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745248189; cv=none; b=aI/XyvwfFsgSiqt/dMIonMdPW+Ga9rehKCEYATXsR6cxFzpFzd2Z2insp5JRhtfT0a3iOUlT2gKL24qhASqrHr4Kns59cr7SKkV3EAa2uX7Ksq/0xiPjKR7wurw10SJoCOQ/ymueD7fisuexciyHBy+HDRS3Iv148LEaSJQVfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745248189; c=relaxed/simple;
	bh=Mxlmt4OMFp+4CmM5qiqrCkALSFahEOttbOImrEbkWRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0uZXjoCVlV9Fi+utdXudzdws9rehXeRJqZbhJag04h6CrQ0M/qX/M6GacmJ6YbHdfDvnCZeV7rR1Kx1SHdIhYnSGnGQ4dNkJyL6Pkbvesn9TP3eoJFek0d98GUbx9dwv9QQLqfkzPIjgHeXkFIQzV32/KPgXWdkWvfTxuDLLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=Okviei8X; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 7924A1C0E8A
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 18:09:35 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1745248170; x=
	1746112171; bh=Mxlmt4OMFp+4CmM5qiqrCkALSFahEOttbOImrEbkWRQ=; b=O
	kviei8X5pu27Neevc+pPCIG1BgzuGmNxfelYRg+TB/HynxKACaoElMYAm7lHZre1
	ejaky+v+E+FJEz4jq60+HR2RnzQHvw0t8cesrSFKdmVIJqXQs7Cz7Fzxgnk8ucXe
	XDowa+6K5KHI8DUvqjfk0F8+kkwwNGe9Zj2m7RiZhc=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SGsTjsL3Lk6p for <stable@vger.kernel.org>;
	Mon, 21 Apr 2025 18:09:30 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id D4DA01C08C3;
	Mon, 21 Apr 2025 18:09:11 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sasha Levin <sashal@kernel.org>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Victor Zhao <Victor.Zhao@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: restrict the hw sched jobs upper bound
Date: Mon, 21 Apr 2025 15:09:03 +0000
Message-ID: <20250421150905.732842-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amdgpu_sched_hw_submission parameter controls the number of hardware
jobs that can be scheduled concurrently per ring. This value is later
multiplied by ring->max_dw to compute buffer offsets or command patch
regions.

If amdgpu_sched_hw_submission is set too high (by user input via module
parameter), the multiplication can overflow, resulting in corrupted memory
offsets or ring buffer overflows.

Clamp amdgpu_sched_hw_submission to a practical upper bound (e.g. 2^16)
to prevent arithmetic overflow when computing ring buffer offsets during
initialization, especially in jpeg_v1_0_start().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org # v5.9+
Fixes: 5d5bd5e32e6e ("drm/amdgpu: restrict the hw sched jobs number to power of two")
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 018dfccd771b..69217a021b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2056,6 +2056,10 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
 		dev_warn(adev->dev, "sched hw submission jobs (%d) must be at least 2\n",
 			 amdgpu_sched_hw_submission);
 		amdgpu_sched_hw_submission = 2;
+	} else if (amdgpu_sched_hw_submission > 65536) {
+		dev_warn(adev->dev, "sched hw submission jobs (%d) is too large\n",
+			 amdgpu_sched_hw_submission);
+		amdgpu_sched_hw_submission = 65536;
 	} else if (!is_power_of_2(amdgpu_sched_hw_submission)) {
 		dev_warn(adev->dev, "sched hw submission jobs (%d) must be a power of 2\n",
 			 amdgpu_sched_hw_submission);
-- 
2.43.0


