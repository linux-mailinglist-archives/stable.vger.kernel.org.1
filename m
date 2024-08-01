Return-Path: <stable+bounces-64969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1AE943D18
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5EBB21A23
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E421C17A;
	Thu,  1 Aug 2024 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw5vuE5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2E321C175;
	Thu,  1 Aug 2024 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471794; cv=none; b=p20PUDLzN4JJIAsdMXqLD0mMq9U0xfVTcB5xbJb1cwWmMFEYB99x37xyuySslWyIxhS1atRAPgNKtagrAzUjWm25XG7mDYIa1yp4ljlqcV3nsS5+6czuVUeeLk16Ncxol3y+TuMM/ldGiS0DG5sAlyWpkMioiADblA5+4OIZf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471794; c=relaxed/simple;
	bh=a/aRreavIK3CM2UoNbBDxmCTSG3uc8Vn32mLDBmZ5Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLKz97w2bvC9S+h31fx2VXKjsBcA38Cdc23KLpqPSoAjLLoiBjS/nHD4+4YlW4XzbTTM/+oyD1jfy7PvyLsMxvOW1Mn9p0zR7GQxVEhp/8c32n6lnuANIiysqNuIRw1Nt3SN+RNHuB4TUVRXqGLg3YevkWV7YQDMgnkQ+Sa70o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw5vuE5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03190C32786;
	Thu,  1 Aug 2024 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471793;
	bh=a/aRreavIK3CM2UoNbBDxmCTSG3uc8Vn32mLDBmZ5Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gw5vuE5Rp1padZZLtjuderSd6YuniO+IrWNeYnirzpT0Yn8gERmD4DXAc8rWI46XG
	 i5ilellfiEHMzmuFNl/F9j6FWdHfg4FlT/3JjDtBhrQyRNEtbvymfoAqzjiYN8RX6Y
	 t1bOgQyw94bIsOnJDVgjTCxUchQic1qZCQMIqOW8WNhZUVdslDPJYMy3zPo7wnaRh0
	 xCd9/dEMdtNjLIkoq7HcDe71vxm9+bcDF+o9MvFmy6efzVj/Fpp170i9/WKuwOvofK
	 dd5nUd/a9iXJyCUDmvD0OB16ENcdpFnreJjqei54ZUYnvCl+T/6aeKi6jcREOhFgJ9
	 +Dgg2CjqrFHAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Lin.Cao" <lincao12@amd.com>,
	Jonathan Kim <jonathan.kim@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 23/83] drm/amdkfd: Check debug trap enable before write dbg_ev_file
Date: Wed, 31 Jul 2024 20:17:38 -0400
Message-ID: <20240801002107.3934037-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: "Lin.Cao" <lincao12@amd.com>

[ Upstream commit 547033b593063eb85bfdf9b25a5f1b8fd1911be2 ]

In interrupt context, write dbg_ev_file will be run by work queue. It
will cause write dbg_ev_file execution after debug_trap_disable, which
will cause NULL pointer access.
v2: cancel work "debug_event_workarea" before set dbg_ev_file as NULL.

Signed-off-by: Lin.Cao <lincao12@amd.com>
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 9ec750666382f..94aaf2fc556ca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -103,7 +103,8 @@ void debug_event_write_work_handler(struct work_struct *work)
 			struct kfd_process,
 			debug_event_workarea);
 
-	kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
+	if (process->debug_trap_enabled && process->dbg_ev_file)
+		kernel_write(process->dbg_ev_file, &write_data, 1, &pos);
 }
 
 /* update process/device/queue exception status, write to descriptor
@@ -645,6 +646,7 @@ int kfd_dbg_trap_disable(struct kfd_process *target)
 	else if (target->runtime_info.runtime_state != DEBUG_RUNTIME_STATE_DISABLED)
 		target->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
 
+	cancel_work_sync(&target->debug_event_workarea);
 	fput(target->dbg_ev_file);
 	target->dbg_ev_file = NULL;
 
-- 
2.43.0


