Return-Path: <stable+bounces-220040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODOzCQZ1omlA3QQAu9opvQ
	(envelope-from <stable+bounces-220040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 05:54:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C20CB1C05D6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 05:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3200306688C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8400332D0DE;
	Sat, 28 Feb 2026 04:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnezsHDq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2795A29BD88
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 04:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772254461; cv=none; b=ImnYxCtujAlLQbC+Kj03g+mw+K3m5VwQnN4zq3tM2GTjdv/tX/LFGaKx5R5ZVxQVfu6L+YsgtRruRb6iAHjBPMreJjZM91IF1siOEQX9TmroSHkQ7SSGXwiDyROsqoQj65ROfsr80iM2GfOpQ58bRgfpbq9aXMyZlegwKQQwq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772254461; c=relaxed/simple;
	bh=/y6+SvznULPY90urUJMywEGb6ZhLM47gIP7T+y5akE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YWWuboA3tYsiNyP6CcbArfEPBSzKEEiSN7S65gApwKHB9E4XbMJM6qtd9S1sulrSDRMJjPzAHSnIKgoKqUML3XVeOsqD9Mn1eXjZU9mb85dUugwhVJMIHjxnIJ6G5rtWUAFEqTOtt6dvQ7o37EoyShut3ichb2teLYNcYfq/cWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnezsHDq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7982c3b7dfcso27643927b3.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 20:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772254458; x=1772859258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWHLiQPGuLNOIoRU+H9lZYNm5Ub8L3rxXj707dfRdFk=;
        b=bnezsHDq95nR+1WcppXltaN4ZLaFkAh7qdN7+Hj+vhLu3QQtufTjc/o5wj5qq8ciBW
         sQMGfzCFB1dF9HL2T+QXAXoMxIJlzyCH0EmKR+P1VzXMrK/bIgfdzZBdzOUHBO+J/tm8
         PvZBxXzYPmg8mA3CsPvBe8aGhNVpPWShRRmwVDiuF/0vO+czTvoG5/7p0MOJxeNdUJ61
         3LCGFLmBwCEC2F3hB1vHW/qS08WbrKptlszApGKIdreVUWPE/ef1iSr2fRh3AHDCB/YF
         t2I+OZb5c37R3UQKTJaw86fqx3eL2NpWcTW9bR/82JOJTlt0fHE90+w8URVHVWmGMv8L
         m5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772254458; x=1772859258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWHLiQPGuLNOIoRU+H9lZYNm5Ub8L3rxXj707dfRdFk=;
        b=td12Z7HDd6jVvPsJ572Gmy0Fnq+9sdIqvRiZ7UllzHfuFH2GgyQMDU5dAmxsXGJEXd
         Fuar4vRadwZhRQAxHdwaKM+6mE3EXzNtqVs1ABJlepwFNYn7WehDNUouZD59mqK8wiNU
         n2ACt59xDSDrblqVgjE1diFCATOmgvaM8Yu9nsEPI6qKBMR/ShA0Xi9RKTSwH8zA3I4D
         TTia1ecBOq565WuYoE4aC/cRKrhnWpiaKhEZilPQgkwLlc1hyyvRziYMr+LITL/zNedc
         RfYDBa8fKnKcIChN7Hy6BbPZ56uV9qbHvgbUoHegqUoDfBSOGyCD0opPK6RGBkgc/rkJ
         XT8A==
X-Gm-Message-State: AOJu0Yy1odUpqZMtdVL2lPbD7NwJ78lXuj9XSC52MEE5dOLl7IF7hNd2
	CV9FHWQJs48CG0M6beld/wxFnNF6e7Bd6E145hij4/6pkQ+loQFF4kz2ucynt8aZM4OuFg==
X-Gm-Gg: ATEYQzzkOMSa/5oG2qCWeLII0oxsZXRuG6hhDmy38RkOEqZYYkbn1HE2bywmraQGm0u
	1WwofZnTf+UOT4xXLwSYGbKra72/Icoqv0uTS4sO32UlD73dSUt8PXJFEfMejZ0KnkAV1+088K7
	92x7YPHEEpnA8NOqwQtnQG2tmkJ+rPrB2vJDopVVNOH7EwGEese4jTM7cWY0Cqizw/uLq3rgeCg
	gz3DeBm3KbKiKBm6uHKCTvq6LlktZJ1iaDAdsVJDDTupldJBquXliJ9fRSTRNF/DddZkFd4FSw3
	uDczK6sWB7gqIg47SvgeAwoR8jMrMfKR8ODYBh99z3LXf0tn7IlRDhyd/HZDqrHlrnGC8uEKRGU
	/+E8bRquVrJOCzf03DWt1BTbRwFSIfm1+7xfD+p34KEgRNOci7GvPIX9Y7EGy58IzcsCHGws3WZ
	HS3LrZTrRt7n6f2/qCkDIYJYO2F6fibpiZyhphuEaWBefLA7Y6yly0xA==
X-Received: by 2002:a05:690c:c50b:b0:796:2dfb:4af1 with SMTP id 00721157ae682-798854690f5mr45220647b3.9.1772254458385;
        Fri, 27 Feb 2026 20:54:18 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf8103sm29865967b3.27.2026.02.27.20.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 20:54:17 -0800 (PST)
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
	Alex Hung <alex.hung@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lijo Lazar <lijo.lazar@amd.com>,
	"chr[]" <chris@rudorff.com>,
	Sasha Levin <sashal@kernel.org>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.112 and 6.6 0/2] amdgpu: fix panic on old GPUs
Date: Fri, 27 Feb 2026 20:53:54 -0800
Message-ID: <20260228045356.3561-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,linuxfoundation.org,rudorff.com,kernel.org,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-220040-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C20CB1C05D6
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

v2: Add Signed-off-by.

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


