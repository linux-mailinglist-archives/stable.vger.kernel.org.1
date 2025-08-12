Return-Path: <stable+bounces-167993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DD5B232E3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C97D2A55E9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699632EAB97;
	Tue, 12 Aug 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xrOgxzic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A0280037;
	Tue, 12 Aug 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022682; cv=none; b=HPw2+WL0rLFHhAX/p2Hs9rS375+44YbSvlzKZ8LBa7o/UHSH6NZDoriGKx884jRORNC1fglHgtPZ2LbSG7f4afcuZ2Lqr4xSJJoEtXsZl7ItMvHd8HHlZqGY3vGaUmkFASieVITiEEcYUA32kSvdemapmKo0MjJUls8TLkss6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022682; c=relaxed/simple;
	bh=q2HYOIx8WYGMS3KyYcGcxCLgC9ELia8iyWhoh1/ziUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFwlcXa3wGfQHU3rH5lVwXJL0p6sN8lWhWQ2ccIu444PyP2rwfYGBj3MeY9aEY/igM9IqGRiLNXtfcqAhuHhsVdcEyuBTPTbB31ZmPK0JX+e96jX1Ouk+otxjmt2fcREuXubvDGCGTsoN86qnsvfTr/iAuF5rPLkbF6WW/qcU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xrOgxzic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720F8C4CEF0;
	Tue, 12 Aug 2025 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022681;
	bh=q2HYOIx8WYGMS3KyYcGcxCLgC9ELia8iyWhoh1/ziUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xrOgxzic0oJxzWz3YdtZKQEfOFGisVbxjjeGenQivoNKu2tnzm8spJZ+LbDG0Gm2j
	 ayfN4wZpC2jm5g/iFrCqk0+Pbd8HW3aGRT1ZDYqpKSeQU3TeG4ezGwEqaifqo9QLiT
	 Nv8xD+uv6TnA0qlx0E0k1kovqAcTOxCVcewIhsX8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukasz Laguna <lukasz.laguna@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 228/369] drm/xe/vf: Disable CSC support on VF
Date: Tue, 12 Aug 2025 19:28:45 +0200
Message-ID: <20250812173023.338176089@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukasz Laguna <lukasz.laguna@intel.com>

[ Upstream commit f62408efc8669b82541295a4611494c8c8c52684 ]

CSC is not accessible by VF drivers, so disable its support flag on VF
to prevent further initialization attempts.

Fixes: e02cea83d32d ("drm/xe/gsc: add Battlemage support")
Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://lore.kernel.org/r/20250729123437.5933-1-lukasz.laguna@intel.com
(cherry picked from commit 552dbba1caaf0cb40ce961806d757615e26ec668)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 82da51a6616a..2e1d6d248d2e 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -549,6 +549,7 @@ static void update_device_info(struct xe_device *xe)
 	/* disable features that are not available/applicable to VFs */
 	if (IS_SRIOV_VF(xe)) {
 		xe->info.probe_display = 0;
+		xe->info.has_heci_cscfi = 0;
 		xe->info.has_heci_gscfi = 0;
 		xe->info.skip_guc_pc = 1;
 		xe->info.skip_pcode = 1;
-- 
2.39.5




