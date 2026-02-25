Return-Path: <stable+bounces-219717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKCUDNhun2nSbwQAu9opvQ
	(envelope-from <stable+bounces-219717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:51:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4E19E09B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEDC930500E3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B823195FB;
	Wed, 25 Feb 2026 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYozquLv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43593318EC7
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056233; cv=none; b=tzRomSqWs3f7RnTPWEpuu+s27CzBeu2g1zKdr22mF4Wy1EVplX1mz2bwVaLVJNnAD1BzVrofkvqsIBI4aagPr1M6qCF+R1f4kaJYC6Vtaw9rVL/9OESScUTPNFX+j2aafsluCXT6rsOg+2anBS5KUVnsP6bnXhaAyHK9QGV1ahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056233; c=relaxed/simple;
	bh=64cynlr6Kqb6YOOksERA8WvAKt3pKhi4b67bhMB+SmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YufiLvzOeLgOzmyxvjnjzIXtE/Filo6PE0Pxixhb5BZPyPbjIWqlx2ZLlfdtmz0h6pgNBaOu1Ywlj+ITl/CbuqynkcrSTg3oHnEkdXMPtoxihjCkKTe2EDv2GEAf+XWDabiQ/B1FW89nzM2VcEbIz+R9SkFbNnXVCJKptyPrV68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYozquLv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8272c559597so197039b3a.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772056231; x=1772661031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+0HTxMeqTjjKK+AV+/0N3w+kuUR+oo3BRlsZmyUWtc=;
        b=SYozquLv3YHBhyxcgxZ87hWCClRQtYul1JH1Ve2/WFplkbaMxsqJ9LiS5qwYjFIQsa
         YAlDNbqpZjz+4Kq41p5wZUFZ1/ZXn7YIOhbKbT6F7MkQPeRrELSMzcTbntcWvkwsAO0/
         anuEteKMKlomE2uW6sbLdtYb5pJC601jZtcU6991hbNklT+SxFAD1Yupu+6bRHKeX2G8
         BTgdlXfyDR7jjUAluyfeklSLsVAxM4ZrAgVs286Res2mE7LTqv7C8tkYJ148kQbIcf/L
         gu4NXBOhs0WDDf4/+HvVeJmNXdOl/ykeF4pTSyf7C7pztrZDCBtqyfC6+PqKI/JVMUla
         k2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772056231; x=1772661031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+0HTxMeqTjjKK+AV+/0N3w+kuUR+oo3BRlsZmyUWtc=;
        b=Ep7Y8lAjHuHzgZB/FyFDycD2MOyEqlcu2QBq4+Pw4V+ClmZKfn3qk6+0H7EgTS+jsy
         m7r7cPIjz+dvT5+1FHDkL3B8x6HvA6MGJzPsa57HWULfiD5tHblbxOUB3bJ1URK78DF8
         yz0O5IhWcAEPz812X/w3dDtixFtvk8I62eAIumjmGuMM5fj+BYlfiaqUZVCbnNbFktKI
         feqguhPdMm7nI80gY80PxWWiHH28vEVn9CsYMZOyQ6w5FXalwMRBBtv23cd9ZY6Uj6XO
         xyDd34i2AjuTSdASPvxqefwzIFcIy7uhPhQcf0cGl2BjGyiZ9nbTqUPNNJkUR8PYSY3P
         D08A==
X-Gm-Message-State: AOJu0YxSCZuhso1FlGWMvhp1cza0sgbVOmOKFu2aQMsPnJBbXEK/xUTw
	FOJw3wb39VpXzvPhr/TVlv/uRBYBDhxOC7Yk/kvcfJdPuiC4tvHGjKyvKwt64UUG
X-Gm-Gg: ATEYQzx4lZ+fr1PduttZ8C5d4ggBbsAK/0PlJTksodyPh5+eBomvSdbcfd3yiANqBtt
	G9aQcAvOhs6dkwkA+vr92+6H3vemH0Nku3dAsU+OpE4AjstzwWF47rToNAUa4Gq1TfXFCVZSM1Q
	Ey4es5SyceDHBgfDv7znB+FhVoUxSHd5OMkAFvEv1sZ6ZaHGeck1JlT1rfxTs4rf29MwefHSLmN
	3MuxHrOnlUdIXLSDEt9mAAybfcfdnbrqf8V9f7nAOIvdNaRhUwAgyrck/NK52iOfAz72alEON4z
	COnabu7/PbyWDaeXuY7vnR+M5sLcLFC4fMCyr8Q5EJ3jBeGj1GEY0QOcgK9IEPVw12pFXyDDIPJ
	pba2zAm8emPx2DOzi/R3DiA+5xYthTWU+fm00/5Ty+JLE/pFW977jqOcmt2n/UOIFmFK/9ZbQj4
	b+y+hQAaJvW/NZblntspypHNAe8AJZkDPM6wu/crxa1qYmm8ogaLyruIK/uz/4ZIfh
X-Received: by 2002:a05:6a21:e90:b0:389:8f3f:50d0 with SMTP id adf61e73a8af0-395b496d418mr16743637.60.1772056231247;
        Wed, 25 Feb 2026 13:50:31 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa8059bcsm11990a12.18.2026.02.25.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 13:50:30 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kenneth Feng <kenneth.feng@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Hung <alex.hung@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	"chr[]" <chris@rudorff.com>,
	Sasha Levin <sashal@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 and 6.6 0/2] amdgpu: fix panic on old GPUs
Date: Wed, 25 Feb 2026 13:50:11 -0800
Message-ID: <20260225215013.11224-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,linuxfoundation.org,rudorff.com,kernel.org,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-219717-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FB4E19E09B
X-Rspamd-Action: no action

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

Timur Kristóf (2):
  drm/amd/display: Add pixel_clock to amd_pp_display_configuration
  drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)

 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
 .../drm/amd/display/dc/dm_services_types.h    |  2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
 10 files changed, 101 insertions(+), 60 deletions(-)

--
2.53.0


