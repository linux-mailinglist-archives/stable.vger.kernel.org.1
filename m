Return-Path: <stable+bounces-140648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14671AAAE6A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2AB7B4D90
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E61238CEB7;
	Mon,  5 May 2025 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5WUiQf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7066336AADD;
	Mon,  5 May 2025 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485778; cv=none; b=Q7QoHkLjT97tkWR5NQgyzLTG1yN+aYKXEZI3Kqio1OZQiWaTskA0YnGmOT8621K78VDxxy3/lqDg7JGu3WBu+DozM1Vcl08RkYlm4XwkEdi/NvboGODzJBaBkEzo/qBMF8zRPvq2rWpsQuyeu3BR3iAHtObCO4mNs3BovkijJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485778; c=relaxed/simple;
	bh=L3J2k0XYHN23Rq/RpMF8JSWvtYRT5nuLPd31jZByzMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lM6ADhJALAmkUgwNpvmVpAEnknLaukxIUxS7DDKWiPU9DyFXtfIeNhBl2xtU7b64Kw5+fnXbOfki9UbQvS1jCj/T2i5pI3FnIcrNREMV7xBmg06SvY6itrqYX8tpeG1XH4F1HrmgX4MOVV1Fm5ldzXGdTxZhXshEpXX71C0YxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5WUiQf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA99C4CEF2;
	Mon,  5 May 2025 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485776;
	bh=L3J2k0XYHN23Rq/RpMF8JSWvtYRT5nuLPd31jZByzMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5WUiQf/1jk4Bd3uppcrHK7yYpPz27ZtHkP9Fmznbo6D8ZDog4m5oCToT3V3kGs00
	 YHGfuWyPq3Bpl+m52+rkJVdMy3VEaUVxfkcwUpcV8fx8X90IwyzP2bQjKzKszcDvzJ
	 4WK6Hx2yBFRv2E2Pq/dCwQzImw16pmFJCCWPKjxmJ0YrtCpNrv+7zgleZeyeBG3YF6
	 eGNJbtlGHfnvsY1XFyrvbv3OXSANfvX8yUOoIsP0eGJ9h2DwgSSn1RgswLV7mahFp8
	 3iMPN+mMIX8c/7qFqVqQPvIIeKyl6AOkmoaVxy3uF9c0UYPX0GPJfIOe7A+CP1V4nr
	 RGhgyX+dyA8AQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 478/486] drm/xe: Do not attempt to bootstrap VF in execlists mode
Date: Mon,  5 May 2025 18:39:14 -0400
Message-Id: <20250505223922.2682012-478-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Maarten Lankhorst <dev@lankhorst.se>

[ Upstream commit f3b59457808f61d88178b0afa67cbd017d7ce79e ]

It was mentioned in a review that there is a possibility of choosing
to load the module with VF in execlists mode.

Of course this doesn't work, just bomb out as hard as possible.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241210083111.230484-12-dev@lankhorst.se
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_vf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
index 7ddbfeaf494ac..29badbd829ab6 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_vf.c
@@ -235,6 +235,9 @@ int xe_gt_sriov_vf_bootstrap(struct xe_gt *gt)
 {
 	int err;
 
+	if (!xe_device_uc_enabled(gt_to_xe(gt)))
+		return -ENODEV;
+
 	err = vf_reset_guc_state(gt);
 	if (unlikely(err))
 		return err;
-- 
2.39.5


