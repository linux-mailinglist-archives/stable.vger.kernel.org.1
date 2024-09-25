Return-Path: <stable+bounces-77316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E11985BB9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6C91F28BF5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD091C331F;
	Wed, 25 Sep 2024 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnzxXBtx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD331C331B;
	Wed, 25 Sep 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265148; cv=none; b=pmsvPb0al3qy5XV6StAMSAlll4DTDo8SYLWrWSWwZF44ZqRhVi5VxBacMPsoSSw0V8OBzwHvTLs5LOZpxe6BBHFucDwDJNpmn/vPzY1N4wqTVeDgEyqVT6UpzVm64N32ffceVw/vV5G1HUWibotoWHh9ff8owe1tKUoeL+O/n0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265148; c=relaxed/simple;
	bh=1wf2WDGiH5QE7gMwpHD8l7o5wijPCUgUy0SkWKGpZUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHNU1poLP/aJFEe1P/lrHHcz/veVsQNuMEsMHqTrDliVXYZRbYe0PlFdVJNRy0GWvnn43VeVGjUBAj9P+g9gUKOsrXPXOjS5N1uYW1AeEzj2KCLHL/Hl3MalYmfNYWHAeM67woNGFnw9VOhCcfFiVn+DYZmRUcywSCWaA6nRmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnzxXBtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B535AC4CECF;
	Wed, 25 Sep 2024 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265148;
	bh=1wf2WDGiH5QE7gMwpHD8l7o5wijPCUgUy0SkWKGpZUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnzxXBtxEloEzA5BkisMpj39YMkfZK1fZYArWCfaOPzgWhoRSdj4/ZLF9k1ot+04B
	 r/OY15YhUwulpqtb3OxQBx8w33K4YnKPhbZKE0JYj9bP8I3cJKRO2qtKwCk3TLP32o
	 Qp2wCPidorGSLhvldRef8ZLCH4qhYrhDYvNfNkVLbJY1BtAG52pio2PpfIoozDc4mb
	 ZYHdukWEZsZ8MSShClGxwoe581OFilvD39VIaF+mPPu/07CRZv7YRsFWuwVBpueUA0
	 C6IgjgmAK0d3RualMUJekY8gGwKNsIVH7PoRU8xq87N2xGQzqRrCiXpVCEI+WsHPEK
	 8hD5zMCUVx3DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Jagmeet Randhawa <jagmeet.randhawa@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 218/244] drm/xe: Drop warn on xe_guc_pc_gucrc_disable in guc pc fini
Date: Wed, 25 Sep 2024 07:27:19 -0400
Message-ID: <20240925113641.1297102-218-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit a323782567812ee925e9b7926445532c7afe331b ]

Not a big deal if CT is down as driver is unloading, no need to warn.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Jagmeet Randhawa <jagmeet.randhawa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240820172958.1095143-4-matthew.brost@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index ccd574e948aa3..034b29984d5ed 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -1042,7 +1042,7 @@ static void xe_guc_pc_fini_hw(void *arg)
 		return;
 
 	XE_WARN_ON(xe_force_wake_get(gt_to_fw(pc_to_gt(pc)), XE_FORCEWAKE_ALL));
-	XE_WARN_ON(xe_guc_pc_gucrc_disable(pc));
+	xe_guc_pc_gucrc_disable(pc);
 	XE_WARN_ON(xe_guc_pc_stop(pc));
 
 	/* Bind requested freq to mert_freq_cap before unload */
-- 
2.43.0


