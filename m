Return-Path: <stable+bounces-122995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C854A5A257
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4151D3AF177
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA122576A;
	Mon, 10 Mar 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LYFtNV1u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB9233D89;
	Mon, 10 Mar 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630740; cv=none; b=neZRrCYrxGhuUbXJuDu40arfTjGh/t9i2oiOKa97CvLv21s1UbwFrLLD7pwTniTZSLDCY+XHKdC7Iqtqrh3sd3jTfDygyR5t0jn51gv+wY1N1OjjnNWu4hJaDD4wTMqDTg/oIodh/FDK3rrlQhLW4bhwvziuV45q1IA1vVUa7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630740; c=relaxed/simple;
	bh=JBrkv2K45K8XepThi/pfHInjC9AgAdY/SKzKuNx0KQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVVWfSVE6gGTNqcV2sMO0sj8YIEB+iijxAfwRYMWC8yUZkqVD9YAGrockwvs7RpP/6PUIMFo5lKvNR7IKG876S02GsFF7fn5dla3T0eoZt6Hsr0y2XTxHJgK04AEsKe/i44w1KzTkH/kNB9Zg6A+RgMPKSYSbNlpzjwBGWHB32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LYFtNV1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C05C4CEEE;
	Mon, 10 Mar 2025 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630740;
	bh=JBrkv2K45K8XepThi/pfHInjC9AgAdY/SKzKuNx0KQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYFtNV1uVW3cOlifCLaj/8ZRgvb/TwaH6pLaXnVZW4M8HqVPBCKJEAPEFnYoDFwaS
	 P2b7A0oefrdCm7K5p70HqhjFD1htzHmUG0xMMDOVhSJdIpeRA3UgE4jKJR6Njod5dT
	 NPK/f8nhLbSfPHCSi5TXj7tZOXSULLaCHwV+RwsI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.15 517/620] drm/amd/display: Fix HPD after gpu reset
Date: Mon, 10 Mar 2025 18:06:03 +0100
Message-ID: <20250310170605.962519604@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Li <Roman.Li@amd.com>

commit 4de141b8b1b7991b607f77e5f4580e1c67c24717 upstream.

[Why]
DC is not using amdgpu_irq_get/put to manage the HPD interrupt refcounts.
So when amdgpu_irq_gpu_reset_resume_helper() reprograms all of the IRQs,
HPD gets disabled.

[How]
Use amdgpu_irq_get/put() for HPD init/fini in DM in order to sync refcounts

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f3dde2ff7fcaacd77884502e8f572f2328e9c745)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -885,6 +885,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_de
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int i;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -906,6 +907,12 @@ void amdgpu_dm_hpd_init(struct amdgpu_de
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	/* Update reference counts for HPDs */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
+		if (amdgpu_irq_get(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
+			drm_err(dev, "DM_IRQ: Failed get HPD for source=%d)!\n", i);
+	}
 }
 
 /**
@@ -921,6 +928,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_de
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
+	int i;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
@@ -937,4 +945,10 @@ void amdgpu_dm_hpd_fini(struct amdgpu_de
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	/* Update reference counts for HPDs */
+	for (i = DC_IRQ_SOURCE_HPD1; i <= adev->mode_info.num_hpd; i++) {
+		if (amdgpu_irq_put(adev, &adev->hpd_irq, i - DC_IRQ_SOURCE_HPD1))
+			drm_err(dev, "DM_IRQ: Failed put HPD for source=%d!\n", i);
+	}
 }



