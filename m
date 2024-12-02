Return-Path: <stable+bounces-95931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC789DFBA1
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4000B28175D
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB45C1F9431;
	Mon,  2 Dec 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b="YZCkkwv0"
X-Original-To: stable@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C101F9E6;
	Mon,  2 Dec 2024 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126884; cv=none; b=BrbAp8poBxqmBo+ZRTLdEj7UORQP1xF/qnJ9lRhq/Wx+Y/FrwLatojAmw1/1kt8Rh552O38svA0y0W8zLiDKO6MNBzKzks5/6d0YjPTZA/V2eybrcSbnxD7w9ZRnGu+Cxa46HK9t3ovF96Aiw6MlEqlYreNygapN0ux/7hs5vrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126884; c=relaxed/simple;
	bh=MSW5BTDyePFiKoa+mbURS90jRDsWlUIgeZx3jybnPRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rGrBEG47MqqSWswZlEbZy0MiCJM8e/12vAHXD0AS8rFZJwTNAgpxnGQV+AxueHjiZLbosVRJcDdBDtMoSWnxkexZ7VSL9YpkyaVGNECcqGGj/C2YdXFMIKBM7XR8ReZqi2v5LUdgtRoj0Lw3XtqseFBHeC974q4K6a5GlBtSfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru; spf=pass smtp.mailfrom=itb.spb.ru; dkim=pass (1024-bit key) header.d=itb.spb.ru header.i=@itb.spb.ru header.b=YZCkkwv0; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=itb.spb.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itb.spb.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id D4E786486C;
	Mon,  2 Dec 2024 11:02:12 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2720:0:640:5aee:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 803B560F03;
	Mon,  2 Dec 2024 11:02:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id f1ZvNeGOfiE0-wjjuYp10;
	Mon, 02 Dec 2024 11:02:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itb.spb.ru; s=mail;
	t=1733126523; bh=fAvlWEkjGOo1q72idjWA0Eucb8ySH4M7IRqqfWdyYRE=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=YZCkkwv0CsBqEe9B3jleawzwSzgsrdVWTohT8pxpvgP4vnYIybRWF2MoGiOFsWpJQ
	 t0u4obNc4EDN19bYamRefun5j7kg56DW7YghxnRW/uriBhWV6+C1yP0KyoU19KYt1S
	 1oQXmUZu5CD2fgaGtmHWiO4v5D1Gf56aQFBvbB0w=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@itb.spb.ru
From: Ivan Stepchenko <sid@itb.spb.ru>
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Ivan Stepchenko <sid@itb.spb.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tim Huang <Tim.Huang@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alexander Richards <electrodeyt@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Rex Zhu <Rex.Zhu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	lvc-project@linuxtesting.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] drm: amd: Fix potential NULL pointer dereference in atomctrl_get_smc_sclk_range_table
Date: Mon,  2 Dec 2024 11:00:43 +0300
Message-Id: <20241202080043.5343-1-sid@itb.spb.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function atomctrl_get_smc_sclk_range_table() does not check the return
value of smu_atom_get_data_table(). If smu_atom_get_data_table() fails to
retrieve SMU_Info table, it returns NULL which is later dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a23eefa2f461 ("drm/amd/powerplay: enable dpm for baffin.")
Cc: stable@vger.kernel.org
Signed-off-by: Ivan Stepchenko <sid@itb.spb.ru>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index fe24219c3bf4..4bd92fd782be 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -992,6 +992,8 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwmgr *hwmgr, struct pp_atom_ctr
 			GetIndexIntoMasterTable(DATA, SMU_Info),
 			&size, &frev, &crev);
 
+	if (!psmu_info)
+		return -EINVAL;
 
 	for (i = 0; i < psmu_info->ucSclkEntryNum; i++) {
 		table->entry[i].ucVco_setting = psmu_info->asSclkFcwRangeEntry[i].ucVco_setting;
-- 
2.34.1


