Return-Path: <stable+bounces-232629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFeFGeVpzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:42:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 921683733AC
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D49E93043152
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6A1FECBA;
	Wed,  1 Apr 2026 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeAlCE0b"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20131A9F87
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003990; cv=none; b=pRq/H7ROssvWrG+MIQz5KjoU7Zu79qmwEV0l8AjkUgGz97zbO836uqGxrSxk6GKpaqJcu89OqRuf8oDJ3fvuz7Yf8mpvsTBJOATrVGa8H9DjbsiYjTXo9VUA26/NjwmBxoOZ6pGIGopT06ahDifRelCYuRMuoZzcnFZ2HkqFx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003990; c=relaxed/simple;
	bh=NZJRkaTJpI1Vf+sGzChIbc9lasjvdkae3wVAdxFTZiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ly+yq9wiDr4A6zno1iAYfAW3390c0ZohtvB7odRfZIybEDxC+mvgc0PsrQGGyD59V4tnjSLMHyA7nHsHKsCcJR4d3jvWwFFX2OYgr33I5YThA42I7fWamlhO/KQ4l2eZScJQcHw2kRW1WaCf7lQybx0VO23JolmXQBdeeHFqe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeAlCE0b; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127380532eeso650812c88.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003985; x=1775608785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xynl6l4IZX6SF8kreSc2FtsN0XosoMomLgf109DsfAw=;
        b=OeAlCE0b5CEcKUNF5z5Q6ZJ+h69ZozZl4XctVjl20SIeD9OSakoKRF0MGxM0RzNuT4
         mib1/JJ80uCDxEXjg0/B4+dpl/KYuUCUg5j8qCP79GgpTJqfIXiuYygb/QnfJPoRItjh
         a0QQS2wuKB0EDH2hYp4cOkU1Ue0ToQe9ADFp+/86B9FKb5xsohyRzrQnLZ4RBrSdOf4a
         8/NdAhp51dSEjpZ81jzxK06JJqduq3LTDiN9J1QSUJAQwAwUQx9c/jjNxYEr/RPv1bqo
         1ltNT6VfdrTkWX0LoXRCIPKfl/Uy+M5eak5g/cvqLyx212ll0Rrwr0YpP26fJt3+9mom
         ukxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003985; x=1775608785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xynl6l4IZX6SF8kreSc2FtsN0XosoMomLgf109DsfAw=;
        b=oDiGwUCeUtRn7ZBgwy7yJYg/qwv4yho5xdsaYyrnYCHZYtf6EL9CSsbyxiy6G8tryZ
         CFNbplE1PsojltgikMYRfKJqGOkEk02vYKHZbvJiAKoTbVX1NTnMAC2hvfAxTwct5h7b
         pymG8cACjKKnep8JKPRihFCWFckT0IdIdFPixMelxJhSrmYGD66V8wq/cPRJtUU0RKd0
         khDGiav5VV4d9Myr24fA5MQvgu878RAz26dqdJn/BTtE5Sl2xKHpUUn77i4Y9GTKaCjf
         5miPMsO+K1jpENC4aqxCwXGcc//0Nj/UZYG5NNCJ2Pz1wcrvaE4USBmcOOzzqhMYJZPl
         oG3A==
X-Gm-Message-State: AOJu0YzNneY52womOBh78hvKqSkxHCu0Ks83ov01EvGT7+MshcSulduP
	+x8xBRlyoa8TIH4LbZG1/wXvuZog72WH0ECDIAtyP0989tYRexpDkhzzQBGCy0xP
X-Gm-Gg: ATEYQzzmzRTsqD8ncnBJITKD/VMAFfsgnOPTju8E47U949uaK2YYi/B3/jddvOa7+jX
	mdwMmCkdlw+jCt/HJVViJhQOw2uOEHwrFgXZmIaqpY7DAxTEEcrW7+NnLLZjPs7R5Jo/HL8O0Np
	7HLO4vuoK10A5y/wZtrEt+DKo7P97NnVj38w9Wph+UvGEXc/elQFwdCHStGZia7mMWDV1Uujq51
	KF4j2jUNQwvep95zKnBrPrAbCpENC28fMZVVbbJTb1swXWmfs9mHm1b+mYGBAwm54hRjDsc9vNz
	4Q7BUzjRrIC1Zj96jxrBfK2dqo+HcafrQX2wl8pXN6yeR53gXCbyqcYMRylpp+9UsyeABB6OizU
	tpP96wraIDU11N5GW+baVwPgAZO+1plP5pwMBVb09VJmHdZA1Ijwb619mtfxoljsF1yDraQJ/3d
	KmAa2D8dTebGk/RhwdMVJNlZEgFCbzOsIWgj/SeUX3BbKjGmCzKBoCo9A=
X-Received: by 2002:a05:7022:68a5:b0:128:bc19:813d with SMTP id a92af1059eb24-12be65537f5mr896596c88.27.1775003984637;
        Tue, 31 Mar 2026 17:39:44 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:44 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 09/10] drm/amd: Disable ASPM on SI
Date: Tue, 31 Mar 2026 17:39:07 -0700
Message-ID: <20260401003908.3438-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232629-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 921683733AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 7bdd91abf0cb3ea78160e2e78fb58b12f6a38d55 ]

Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
It's unclear if this is a platform-specific or GPU-specific issue.
Disable ASPM on SI for the time being.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb3c6bfe2e6c..12d7e45a4245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1761,6 +1761,13 @@ static bool amdgpu_device_pcie_dynamic_switching_supported(struct amdgpu_device
 
 static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 {
+	/* Enabling ASPM causes randoms hangs on Tahiti and Oland on Zen4.
+	 * It's unclear if this is a platform-specific or GPU-specific issue.
+	 * Disable ASPM on SI for the time being.
+	 */
+	if (adev->family == AMDGPU_FAMILY_SI)
+		return true;
+
 #if IS_ENABLED(CONFIG_X86)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
-- 
2.53.0


