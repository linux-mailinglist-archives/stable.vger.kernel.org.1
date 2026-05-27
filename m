Return-Path: <stable+bounces-254610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPbGG74GF2qn1gcAu9opvQ
	(envelope-from <stable+bounces-254610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:59:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4AB5E661F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10DC1307D676
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD2B428821;
	Wed, 27 May 2026 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="NUC5Kp21"
X-Original-To: stable@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1C4266A4
	for <stable@vger.kernel.org>; Wed, 27 May 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893467; cv=none; b=Z5uJ9s6orJMwLL81Nii9zBwUyhyM9nt0h4uIeMngRBqIqteA1MGC++dxPW5bbQcekicOGxhwfhGKuliYJK1fxOVOT1vuyJmUkaV0pUm4Z5m5aQQeYGvRCbg4bGzabr2GEgIgKe+hup7YDV2WbDqbQZipPAquimlgfWAY1lKxzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893467; c=relaxed/simple;
	bh=XNyPsb+TFiYQDwDp3iTF0vhl3mMW0BkoN5XmTN5npQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNXUYsR2uMWHZvpE7oWB0uA+uO4cqQ3AaXzTj8B5TZK3fdUab8S/N6srJVlziHTDaaR8pjOrpO40Qk3ZAzS0EOw0VPLGFIu4S/z2xgr7GUHBdWgUm9UV0150P253mvJtQh//+iUI5d2z4ES5p8pma91h/qdc0L3QzJh/38FFzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=NUC5Kp21; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1779893105;
	bh=R4e4bdB71D+rq0MJ2lvVyJlXVRDcaBHIexttwo3qq34=;
	h=From:To:Cc:Subject:Date:From;
	b=NUC5Kp21I/KuQUswq4kDO14XalWMmoxqCreq87QbBYxkBhpHfORVgCCBDETkT/L3q
	 MlBmFD+RLxhukaymxD5uxg6bDgjIiwTt0L5IzfWNrLm8vrJFM4B3VZR8jMFK1AkPna
	 KTqsiMI6C1nx45v1h14AXZFH6DnJkw1Y6lDpl/Pk=
Received: from stargazer (unknown [IPv6:2409:8a4c:e1b:e231:5a6e:b99e:242d:222b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id BCAEB6597E;
	Wed, 27 May 2026 10:45:03 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y 0/8] drm/amd: Backport FPU Guard Move from DML to DC
Date: Wed, 27 May 2026 22:44:20 +0800
Message-ID: <20260527144428.1095001-1-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xry111.site,reject];
	R_DKIM_ALLOW(-0.20)[xry111.site:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254610-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xry111@xry111.site,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[xry111.site:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3C4AB5E661F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The change from my commit c97a7dccb3ed ("drm/amd/display/dml2: Guard
dml21_map_dc_state_into_dml_display_cfg with DC_FP_START") was dropped
in the commit e6a8a000cfe6 ("drm/amd/display: Rename dml2 to dml2_0
folder") for some reason I don't know, so on 6.19.y and 7.0.y the
original issue (9070XT fails to work on LoongArch) has regressed.

As I've mentioned in my commit message, it was only an incomplete and
temporary solution.  As the mainline already contains the move of FPU
guard which should ultimately resolve the issue, it seems better to
just backport the final fix instead of adding the temporary ad-hoc
change back.

Tested with 9070XT (where the original issue manifested) and 5500XT.

Ovidiu Bunea (1):
  drm/amd/display: Add min clock init for DML21 mode programming

Rafal Ostrowski (4):
  drm/amd/display: Move FPU Guards From DML To DC - Part 1
  drm/amd/display: Move FPU Guards From DML To DC - Part 2
  drm/amd/display: Move FPU Guards From DML To DC - Part 3
  drm/amd/display: Move dml2_destroy to non-FPU compilation unit

Srinivasan Shanmugam (1):
  drm/amd/display: Fix dc_is_fp_enabled name mismatch

Wayne Lin (1):
  drm/amd/display: Fix fpu guard warning

Xi Ruoyao (1):
  drm/amd/display: Backport dml21 DC_RUN_WITH_PREEMPTION_ENABLED
    addition from DC 3.2.373

 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |   25 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.h    |   17 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |    2 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |    2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    5 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   75 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   15 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |    2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |    6 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |    6 +-
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   72 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |   25 +
 .../dml2_0/dml21/dml21_translation_helper.h   |    1 +
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |  391 +--
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   |   30 -
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |  379 +++
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.h       |   60 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   34 +-
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  |   19 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    4 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    7 +
 .../dc/resource/dcn31/dcn31_resource.c        |    7 +
 .../dc/resource/dcn315/dcn315_resource.c      |    7 +
 .../dc/resource/dcn316/dcn316_resource.c      |    7 +
 .../dc/resource/dcn35/dcn35_resource.c        |   10 +-
 .../dc/resource/dcn35/dcn35_resource.h        |    1 +
 .../dc/resource/dcn351/dcn351_resource.c      |   10 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   30 +-
 .../dc/resource/dcn42/dcn42_resource.c        | 2355 +++++++++++++++++
 31 files changed, 3076 insertions(+), 534 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper_fpu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c

-- 
2.54.0


