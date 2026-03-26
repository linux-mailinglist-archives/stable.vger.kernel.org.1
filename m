Return-Path: <stable+bounces-230544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKVAHbvFxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:48:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D12AC33D391
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F0D3303CE38
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42542773E4;
	Thu, 26 Mar 2026 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/35t8fI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85F1F03DE
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568857; cv=none; b=Uh6bYYS/OjrOXJ/2kW1iyFQOaTzuuFUw1viYgYxZ9Hh63bi0s0K4I9sOT5u30Zrrdplz18ak377zxxxf7cQVp0cN+CFjbjIpJNn2wJ2NY4lKjsv7F0T+Rh1i/zI3vPW/8v9D0HtJ0HmY0W5zYzeor37CSyrhTjsRu8UWF4PcYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568857; c=relaxed/simple;
	bh=ozmh3QbLf1cZ17USPITVQl5g1vdgQp79kXwp6BBn+8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HGD5+btI8mmptP5LEdk5H4TYchNUVEPIqy3nr9P60+MvUduWDWW4e5MGUKJ4dy3meRNKOSdep6QP9EXrLGvzfP0S8RyqZ7heDeNCtGDP+sUE3N2maxmQJ2TObFZsxNBUxsvlmMbKJF0QFaEjUM/wIwUgP0Zam+t1KoRwJO8386M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/35t8fI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c74f0c3fc16so572057a12.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568855; x=1775173655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5DHuKVgXN+dD1YajVE7A08pLyTvO/MeTPUKN+QQ6x/Q=;
        b=r/35t8fItdYTFh99+k9in1oMTUEIxs6UZKD86hca7IIPE6uO+SlmFBjpV3eksvptAr
         wF4jWqdXM7hWZmvhe/p2OQfwfeerFPGnGXFfAzHiRKUBxroxfJtOjmM+5BgG6Np7jqDD
         dXBpgIFgNoEVwCJK1NAuUyFOEv9cat6PhjXN5b7tU2fhIEqN0Zi5CufQhcYMjtq6rnux
         rSk+od9vYhbiiHTcG89yyy0BHobDrzwkyOG0GtKjA+g/qOY9kKNyAfzdti1B0F1uyHUM
         8snKKNOaiAe39IBYDj7ecYZNzGqCpuez4S9VwSia9+mBzI47Pj/DoUU1NBIHzrQ4K93z
         eqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568855; x=1775173655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DHuKVgXN+dD1YajVE7A08pLyTvO/MeTPUKN+QQ6x/Q=;
        b=Te7pNv1x0cDIFoOmccN104/e3F7LUmLYkApIgTr4dTkfqwISbg91JxkxB3+Y/AvxAk
         h15o7nbDqLX9qWefDurof76JUsLObrdKAR3OUbjNCujpfbrKyNh7atBEPRFshSup1gIS
         VKz7m+h1lc6kI9ohqvyg9E5tLk9ofAPz89gYYzB0IwU3sLPQ+oQbi+SkzTbQDKyxebqT
         qo/ECbc0vm53iU8G4TGO/sU/1Ju0JpnNaUKMwYPHwrrX+D4sbFmeB1AQVtDmn1BZ8lQh
         NgM2rRpSVAzBVeM8HWTkMWBreOi+3VC0cq677fC0JfU2Qx7bLm/ef26lNkWpH+pVgcdS
         bRrw==
X-Gm-Message-State: AOJu0Yyu5W/jpYVlaC6sZBQUcrU16DSjZM9UmbOz3WFjjP6JcapkLYpP
	Z0NtFiNdoTrWDpe/YGu47zGDifU3DB6+qSqwv2M5tu7Fawm73jBy1RMqB1mCn3OC
X-Gm-Gg: ATEYQzzE22PYoJoTW4H/isGwIzRq35dWsnO8T+4hGMsNiKYyEKTZM/hEoux3tEKE/il
	/5zN0nEpCC66La5LquOHPVYQDn8ejS2sB1eiuRFa+fRZZmpy0LXQWrKZCnoh/cX4Iat56+Ax2Bh
	AHzXS7Lja8zYT7eYYhbH4Mer8v1g2tTqwQ0nKgaL0C5/adSQGz7kG5q043uE0lqujf22uW8xHV8
	QTQhQO+hDsKTmUaaf3efYvTdnw1VX7TXR+WB0YU5mrBHnWy5ThvSs+evJjhDz5YGMS5bVTYPJIm
	kpd7kkZq67LFPZj/Ej/YDiBgKSE5pCJhDJxtwEO7AOgUTc3gesEYkTcIIDX4aCTmA5J2uHatNhI
	YOn2+37lUM4wt2CTeTWBZQLcV/tkJNrc49sStFAJQvKbt9AfB5pZATESg/Zq7H60rg/PgZXWw7R
	8OQdeng8qwDaDJZspr1e+T8WKbq3RmY6Td1vkgcjmTHwn1ItTg7BD8hX0vKaWmguquIw==
X-Received: by 2002:a05:6a20:60d3:b0:39c:14c1:43f6 with SMTP id adf61e73a8af0-39c87c0b0b5mr394562637.61.1774568855408;
        Thu, 26 Mar 2026 16:47:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bin Lan <bin.lan.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <Mario.Limonciello@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Roman Li <Roman.Li@amd.com>,
	Eric Yang <Eric.Yang2@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Mauro Rossi <issor.oruam@gmail.com>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 0/9] drm: amdgpu: backport suspend fixes for
Date: Thu, 26 Mar 2026 16:47:07 -0700
Message-ID: <20260326234716.16723-1-rosenp@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-230544-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
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
X-Rspamd-Queue-Id: D12AC33D391
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


