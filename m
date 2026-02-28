Return-Path: <stable+bounces-220030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YACFGnpBomlz1QQAu9opvQ
	(envelope-from <stable+bounces-220030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:14:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3EB1BFA99
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6915E314D4B8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792F2E4263;
	Sat, 28 Feb 2026 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6vdSf29"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047BD2E11B0
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 01:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241156; cv=none; b=TiMTMbY0UBN3h4mdgyuKgz1lvcQhwyHJEUzooVv6gPWM0B9ElbeWEKDqzpPS0NVasoOAz4n9nEffHVlXPrD5Es9T681oaIOu7fDsBHdMclH9he2Xgu9vQs2mVTd2+7AJ5kO2qra7Sq8rfvaKAcnS8SDCiBpC/8ddTcls8kqeZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241156; c=relaxed/simple;
	bh=DYykreVSH7lKbkxIufoXB0xBqmTJQohzbHsIpsFJQyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QKX+RDIr9prlN1HIukNjuxMgExlrRL7SjJXs3WbV1hK6C00dMX5fpwRJn0jHtNALqFrw5q2teLvAvqr9YB6ppugVAtM6JcPywJxFJIXU9FjQSAI+s1wPHYiDKxDlqcPyQR1wEvhM1KwYgASVkjbvAhe7XF1Yw1dIk2OER/Vg7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6vdSf29; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a8fba3f769so12905635ad.2
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 17:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772241151; x=1772845951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaPoQfadeqAcC/F2pMAhUC8silyGRKBmTmyeCrPN6s8=;
        b=Q6vdSf29B7DuGl4dwBPsLc/On23z3f/YRn135l4zDsAR1RLXBSvgX0HlE4zmyvZ9CK
         t7dzXP/QXLzPkkFJFhGkPoegT6Q4HDUyD/9hPvw6CBpf42EZrFD9zKPgCF0OTBMrbVq4
         Vlf2xJQit3RKabArawa1LJpTN1dYSCRCH/MiLSV9KKUJle++teC7MHtWQEfj2EDG5Q3j
         djH+2YK2mdy6jpnoWPaX3aolFFspvYV66Cz5+tJG12oI6aYqvXr/njF+sIiPTr7EvgVt
         zsc2QJOH2maNV2e8r8bVKvGbMhgYeQgEQZAuLeuM5uy+uilQwyPhuRF0qaux5l28h0+X
         6y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772241151; x=1772845951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaPoQfadeqAcC/F2pMAhUC8silyGRKBmTmyeCrPN6s8=;
        b=c90yk1jr0oD+wxncLMnBQCRlrEg1+ixDRLT2/qPNHMdJcVfSaJEXqFEHMfRy2iIUBG
         QgUabmP0iWQiOi1kn64c3KK3FrzBc66sf9GbECCcJf13ffdYcfGWddb8vJrgKDLrLYpd
         mT2wfLtNX3GhIG1HMSDIwMNEqIpvtc9pAbXm8iXbA3U3K97icn9jtCa+k0MB99jQKqqU
         DzP5FukILCYDS6qI6Bxd/2xH5yHqlODKwfkczvEQnXxlnKGxQv90f+5d5viaCgQZ1YkY
         6TndLaNnCLZEonz9YJCBXep8uygJUo2EYoCyEMqCY1o2LSeS4LAFFnHLQI9EL3F8TRrb
         lnVw==
X-Gm-Message-State: AOJu0YxdndrpM7Nl5/DF+17rOmhJuTUlrlLYntNgF9CbVRgtufOeb47v
	Wx5BepZ6PdNiqk8To5PqTk86ivfdm292+pkEKPo3pzh/wQt0F+NFOXBgJS02I+9ZcZs=
X-Gm-Gg: ATEYQzycF6wRztiWG3T3bR7zfOl+0iZP/ubdGnzyoSRq8mVOVZ6Stwn6aIzBTjz0ZZp
	Y1DyTI2RJr4n4X6u4ZnnyUQWwH123Vpa+0vJH22+Arp0HfUp69VCE3Wu83BpMLSMiK0naEQGOeN
	x58YWsrRc8MTLD6c5J/bsTRDv46hURZuEipKPyVxvpfrM8L0+VH2rbb6KeL10dvHl5bJr1dS243
	9P4OfdGnLJFM6wkGRpBdaUvsNSItw9nPWxmf9gR89cCVSQVyDDR0a3zNCEx3EBxtmxV98MXPJ1k
	eeLYbv8O7y23GSD3l8X/Bmwb9chmyhqgwD5B/BNw0RCktU1UBnTYO5BmdlufZHzu7lb3xqWf7Wn
	YCdYC/8edMr/Xl9GSdEfTf2BU/o37yEV22NM2YyB3uVw+nsmZbdTrKTXvuyxjVNnlYosC0J0PBK
	cl2o68m6oyhBlivcU49FRf2DF+kIly9zxy9cGmVUHbDdbSoC7Ahek9Lw==
X-Received: by 2002:a17:902:d585:b0:2aa:d816:e1a4 with SMTP id d9443c01a7336-2ae2e4b0d3emr60789735ad.31.1772241151401;
        Fri, 27 Feb 2026 17:12:31 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f46c2sm75772845ad.89.2026.02.27.17.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 17:12:30 -0800 (PST)
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
	Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Eliav Farber <farbere@amazon.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhigang Luo <Zhigang.Luo@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Hersen Wu <hersenxs.wu@amd.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.1 0/2] prepare to fix panic on old GPUs
Date: Fri, 27 Feb 2026 17:12:11 -0800
Message-ID: <20260228011213.423524-1-rosenp@gmail.com>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220030-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,kernel.org,amazon.com,linuxfoundation.org,web.de,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
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
X-Rspamd-Queue-Id: DE3EB1BFA99
X-Rspamd-Action: no action

In order to backport upstream fixes for black screen on boot with DC
and old GPUs, These two commits need backporting for 6.1.

Related: https://lore.kernel.org/stable/20260225215013.11224-1-rosenp@gmail.com/

Alex Deucher (2):
  drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()
  drm/amdgpu: clarify DC checks

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 32 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  2 +-
 8 files changed, 25 insertions(+), 21 deletions(-)

--
2.53.0


