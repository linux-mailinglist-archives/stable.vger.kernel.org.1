Return-Path: <stable+bounces-232619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOjJKappzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:41:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B80373378
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47CDD301DAE8
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B51D5146;
	Wed,  1 Apr 2026 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sB6phQen"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184831B4223
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003971; cv=none; b=aAkcjdMUZSx6PG06xm2R8JNxHT/947XHKvouU9Wv3iZVJvMMIYgKE4iT11KcmYHv70ShKnTXu4jfzhO9Laany0cDzZuWVNpXXoL6hLzmmYMzmq6N92Pkr82LajyQLWqqm8C9H3SicENxIk9xbZIZ4bGkyyO3kJwBoCmvp9dNRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003971; c=relaxed/simple;
	bh=Iu95Q+NMH3dREDfdIyiqugCme8KTLIv3g3UMo5V3ieo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L0ySKKe1lVA+L679s+Zsw86xJK3TaOZDOswHJ+RnIJCAAg4AH788H5YK4eiHnJvzfl3ioinxPQWJGVMXu5hoAK2Hhttijmu2D8mWeuKALrt8iR8SflxLf1gwS8Ttns7fv+9rLL1A+RfbS6d28ePcoCKuBBc3TR1Sdv00vIcTD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sB6phQen; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so1463784eec.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003969; x=1775608769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ojh5tnUEiYmVdPjcqv3/1ea9VGb3tz1tyyEb2cwTcr4=;
        b=sB6phQenRY8UMPYCTX37W2+gNQ/aojKdzh8i9RCd+2+YfjS3WARVGk7AJ5Lxucdsn8
         xFUs8+fnaWzKBIHwEp+l+97RFybPoyoJZcMyX0Ij2SCIG/6Fw2N2pnABYjux0/unbTkF
         GMtNRo58XSVMqkL4eabqGsXru+epeeiBukGvHoOrhbuxU83bxuhsB2VK72uEMo3fSQw8
         R+BjdgJ5dafCmcn/VderP1o0VQBgK2sK/u/kDXaJhRWJevc32zqlXpDzUQN0hoy3VtsE
         rySk/8LawWb5n4TjlgfOPYcbIf0G6Gk+Utl0Khwuxq0EcjZnaC6O5dfLhIBtZp02qjii
         pXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003969; x=1775608769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojh5tnUEiYmVdPjcqv3/1ea9VGb3tz1tyyEb2cwTcr4=;
        b=T05XiFgw+Kg0b5FPQC3khY8TmzHkAAICyFCzOyB0hgsjAgwgMHNKAM2IZ+lSsuRRoV
         fxv/bcfoyqaz5nkwrrcMDbqkgNWgyMAH+Tb/xJK5KdgH/2IMJkwO6wvGwxz8r5qVch2F
         QX6L+fn8GnTZs1JGHG61Tt6PnEuynmkl1pZXGOjuIUztjPlpktMvtFp7wmkGgPURAydx
         oUeqyqoqoENYrcLcFDQe33CBOGS0h06a53+pVi8M3dvWNFnB6STnJiuEoQHFUQnq2a3N
         PXf/oHumLEDMncDdSvS9F0bjqJe+6ElDWsgC/BolZn8mBvhTbBCYvtuFe2hqyX1i6hXE
         5aZQ==
X-Gm-Message-State: AOJu0YxrlwK/gpXAYO1ORXFoPJMNXABOSj0X9lZ6YIwZXpKegMTacIIW
	g62K5fDPRhqLH1qJTzyqdoWngxXP/cTjAjRjcrM6HnjAc3f17KUeJ6v+NyQ19cXB
X-Gm-Gg: ATEYQzyJgEhpyTPsdwtY1/GptIbZU+6beZIDsiZwaOfV0CPEPj4lqf/ALaXKRaTRnFH
	uc07Yf5y7U4BhTg9i4VkbiksuMWpOHTZ/vJ8c8FH8RHnH4yJFr3YoDk2j3Cb7qyq4ryX734XBxj
	8vUCbjaG1NUhEgQ55Kfi7T4x+AXb/o74XkcFqajxY6fONRoks7nrZglzBGu/p/eGcNye9/fQ6d0
	GCrRT/nQn8Etwe92QT+bDCXWuzHfYy882g6gftyBWjeJ+mVfWr6ZXiTHlEr+T1W6KzFblZ/l9SH
	8ZWJCp/jWDPu6/grwQPqxJyXFS/x6mK1G3RjIG7LWdhaxbuVzMIgCPKhRqi3VBvG509nncxhSu4
	8Y75IQFRFT/uy2mEKVHkgGtuAn15gCDoGHxkz3nh70wHO5X1T98kWZIKCOUloJn+26cIRZB78ce
	L6K0w8TJAok6iloNCOnXQdWHD0v7h1aHeimzs64BT3WVRmxQDzaYXDiYs=
X-Received: by 2002:a05:7300:4309:b0:2c5:b23e:48a5 with SMTP id 5a478bee46e88-2c9309866f8mr836144eec.1.1775003967392;
        Tue, 31 Mar 2026 17:39:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 00/10] drm: amdgpu: backport suspend fixes for CI
Date: Tue, 31 Mar 2026 17:38:58 -0700
Message-ID: <20260401003908.3438-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232619-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
X-Rspamd-Queue-Id: 10B80373378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Work that completed in kernel 6.18 resulted in working suspend with DC
on old hardware. This series aims to backport it to 6.12 to have working
suspend there as well.

All commits were applied with git cherry-pick, the only changes being
adding upstream commit, and signing off.

Tested on AMD HD7750 with:
radeon.si_support=0 amdgpu.si_support=1 amdgpu.dc=1
on Arch Linux.

v2: add extra upstream fix.

Charlene Liu (1):
  drm/amd/display: Correct logic check error for fastboot

Kenneth Feng (2):
  drm/amd/amdgpu: decouple ASPM with pcie dpm
  drm/amd/amdgpu: disable ASPM in some situations

Timur Kristóf (7):
  drm/amd/display: Disable fastboot on DCE 6 too
  drm/amd/display: Reject modes with too high pixel clock on DCE6-10
  drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4
  drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
  drm/amd/display: Adjust DCE 8-10 clock, don't overclock by 15%
  drm/amd/display: Disable scaling on DCE6 for now
  drm/amd: Disable ASPM on SI

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 39 +++++++++++-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 20 ++++---
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  |  5 ++
 .../drm/amd/display/dc/dce60/dce60_resource.c | 59 +++++++++++++------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 +-
 .../dc/resource/dce100/dce100_resource.c      | 10 +++-
 .../dc/resource/dce80/dce80_resource.c        | 10 +++-
 7 files changed, 117 insertions(+), 32 deletions(-)

--
2.53.0


