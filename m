Return-Path: <stable+bounces-227657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEsWAHUwvmmqIwMAu9opvQ
	(envelope-from <stable+bounces-227657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:45:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F952E3734
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195FF3036D50
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 05:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F64362149;
	Sat, 21 Mar 2026 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbdhZMzM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADB136166E
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 05:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071914; cv=none; b=XiFPT5mBjFM4fPajBC7fsqmmJTG+YLQdpDZlj2phVS8xV5Sv24izXDMq9m6ZeBDwfzk1O1Y4HFTNwM/H1PsT+TR18YLKhLxzKI4XYR6L+CDd24q7i4T5PE0pSIJGhuE9tc64E1GsN2rdc20iV0jU7eufoSo8THgxmsszqXGyEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071914; c=relaxed/simple;
	bh=qYprSBkgrq0RDsBtVFpodoGnR1zbb4e/sQXUrkm795I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ApWfOBWYWCP7XgiQyfeJ6jJzXC/PYxMfDBdPa75f6bqnefpnUiZXkfIDH45rnco5kISmFx9aX9i3gr1g9rwsDxV1IYLQEf9sJd298SV0kcdBmWRJdPa38L7Nvor6Iuxfi0ESEf3wNKyBGuJ2xJXOA9oF73mZVttnrisj7RrCFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbdhZMzM; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c73ba417c6eso1031467a12.3
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774071912; x=1774676712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=21zbRPn53NtO4HKBeb/Qwdup+vsCpA2EHYoiuByr0qI=;
        b=cbdhZMzMqH0Oh7lfBlzNCOOrgwxkI3wUmcCltpmybRf4U4Q3Srl46cKNe4qV91AUo2
         sODEtCr25s1iPDOFmTSF4rAvNW5rWgnT4Plit9D8I0Ze7ZeibasieLEEe1NVOyehJ5tL
         IGArFCx4vyXiOFelPlrtQa8qiIVfW3tjWqeie/aIx9i0hcGxbQfnY/FifJ31TVnpnGKq
         s8Z2ZceR6+eO0tE1SLR6yDxvJnrPpW27plGBRcJs3k4qkAxGgWCLF+9cZdGkZMCV8iO2
         MBwxY9KViQRBFvsFlALYTcgtXld0wM4qFxIyxQHrnLxLBwDs3JRiAMejKNoPSAWcsk9D
         iYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774071912; x=1774676712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21zbRPn53NtO4HKBeb/Qwdup+vsCpA2EHYoiuByr0qI=;
        b=Do35tUibP0PsF1e0WXzBC+xj89Lqdnjp+ND8oeDUbzcW7psz7HKutFDQfTo5suc6zU
         HuOx0/mRKk9gpD4nd27wbE+BuKvTnPZgfnhjm6tdlCK5KIrT/JwFuAb34K/PogP1QNBT
         cBhAzgNdlzpqAoDvAzkda05vnwPUxa7wyUDnAskn0daM7BwJDw0V+7YLvotijR1gSfXW
         TN0TkRuf5jrIlaVu21BHLYMainDkdyxdC87TH7cEXXwioSb0tBsLrM44yKk2eeUUZDOP
         hWDmSRio/W2ep8j85wod/IQ1hUv/z43qDbbQZ9k+sTauqCWB4JrWTdOZ3GJrwI5qoWvP
         efBg==
X-Gm-Message-State: AOJu0YxzMukQ/xurRN9V/dDcE9ARbq4G43LD0lNf6rMk61odn3Ig5Qbe
	5ZYGv5FEJPasgP1hRkSlr6a3QbzjWsUgynwdxXz7vxJcJwzossO9rtBXcrwmPPmw
X-Gm-Gg: ATEYQzzPHqWPPFFX/l53TUjGjCi9P3sd7bFmC9X++ntuxzaoBnI8uEK+ERJJyJv6d4T
	u4JGEP3HISA2mudWGqKmAxwmIub5M/i0kUU8yXU/XfENjeWkqSHE8MiTmyQ9NawrPh7PsrxA98p
	3W+SFn/a7GSikEmVw4d4E3lZC2ubMfdOGEW96CaNFFfzRXKusTcOaZIysl08wp2RrO5h7us7s2k
	hV0nUvVUl9BIIvR5WrVIeNW58Hu2iXTp0W9T0vUg4NCFraZnK3+s3syJSdNvCqNf3PK0pohaf7c
	MLaFaZnjaf3BjpGvwdTK5R5qv38EtBs7yq0Ku9T1RzgWQUHROYXlnLMj3IsL57R9lfuegUX3tm/
	LYJuqZTuU3V97v0oVSeyaGwQVjj0tr0m7AwPxt+y1qFFNDlVBhoraruYPloGJBcBXVOX5+y0cQX
	3XcDUcsxvdGOxXpWY2gtaGOVrH/I9Tqk68pGJertqWjbViaF0dk9sN+nI=
X-Received: by 2002:a05:6300:83cf:10b0:398:7949:38fd with SMTP id adf61e73a8af0-39bcecb0ba5mr3559729637.57.1774071912212;
        Fri, 20 Mar 2026 22:45:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm4338783b3a.37.2026.03.20.22.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:45:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Evan Quan <evan.quan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Zhigang Luo <Zhigang.Luo@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	decce6 <decce6@proton.me>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 for 6.1 0/4] amdgpu: fix panic on old GPUs
Date: Fri, 20 Mar 2026 22:44:49 -0700
Message-ID: <20260321054453.19683-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,kernel.org,linuxfoundation.org,web.de,proton.me,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227657-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53F952E3734
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Because of incomplete backports to stable kernels, DC ended up breaking
on older GCN 1 GPUs. This patchset adds the missing upstream commits to
at least fix the panic/black screen on boot.

They are applicable to 6.12, 6.6, and 6.1 as those are the currently
supported kernels that 7009e3af0474aca5f64262b3c72fb6e23b232f9b got
backported to.

6.1 needs two extra backports for these two commits to be cherry-picked
cleanly. Those are

96ce96f8773da4814622fd97e5226915a2c30706
d09ef243035b75a6d403ebfeb7e87fa20d7e25c6

v3: Add those commits to this series and sign them off.
v2: Add Signed-off-by.

Alex Deucher (2):
  drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()
  drm/amdgpu: clarify DC checks

Timur Kristóf (2):
  drm/amd/display: Add pixel_clock to amd_pp_display_configuration
  drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 32 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
 .../drm/amd/display/dc/dm_services_types.h    |  2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 13 +---
 17 files changed, 126 insertions(+), 81 deletions(-)

--
2.53.0


