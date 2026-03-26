Return-Path: <stable+bounces-230553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKx1AevGxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:53:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC3A33D423
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B470530E8516
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D22EC0AE;
	Thu, 26 Mar 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itt+1pTF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2522424C
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568881; cv=none; b=MEIrudmi6DxyEjRf3GGAMz6FEckO+E/Nwl0nM6ICbPYlaDS3zT8zEUdOfxnRV5SJi85yXPS+InaOh0fe0naRTK+QUp4CYCWkhl3SMBmZQCplPcec1vFYg+Gb/S1gk9y+pZ5Tl8vK1/YYzYig0YTTTmgDWssbGUcT8X8refLtdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568881; c=relaxed/simple;
	bh=NZJRkaTJpI1Vf+sGzChIbc9lasjvdkae3wVAdxFTZiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWM6PGXV6IwTlh7XvIyIO6US6a8CBGL2SHwHY5TcmL4uiy/x4TrGaeFHGJ5tZj0V7HMuwPUMvPj6PoeKUhfKkLPGFVqNn9onff5aLri231bbD9YS136YX+VaKpO4l6DeKbKAZx4suGV+OvMjfxbkR9OQTbvcdd2q6lHclahYslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itt+1pTF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so670401a12.0
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568874; x=1775173674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xynl6l4IZX6SF8kreSc2FtsN0XosoMomLgf109DsfAw=;
        b=itt+1pTFQdtHRowKFkl5BNdkawW8X1XjU/x/zPN568xwPtFAUZLURtrbzyjSG8DYOU
         GkJYRDUdo0AaS8hASsbSjzBzPzaUx4cnovzAsDKW/NueZHDQO8WSy9OCrOQixKDdXBZv
         Hvi9dHYxIpQP0nztcrfeyE5F8iKaYBGQ0fxZhGD99IZcc4544qzPbi+K8jQmkUKPMElm
         wry2qi8x9cgZYH2sQh2u1psvl/XaDuFxldx0R5RsQhwoKDwYLzilf3gVACPDbWqLQ43n
         GjBc20WqOlmIKs7tjwkyGutF1v18iHsVHGJ5tyVcHrwZ+gLVJol5BmTXDLYsCrgfPFk1
         DanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568874; x=1775173674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xynl6l4IZX6SF8kreSc2FtsN0XosoMomLgf109DsfAw=;
        b=FlvinJbLQPOhQhjSnLWUWTZZ+KgpWRfNaf+MN+0Zm+lfpQp8sJB1qaKDTwOTNR8aaL
         xwT75w3KslrAybCbKMUDWqxySPklM3oxvHb6rY98bE0vd9qK+NFQ6syCcSSqRrlsNaGN
         fzniXp7dB+yPUr2gPXtdfcVYJLtmnGy+rP7DlgBPl0TqdneEPj1zz3sY/7VEJ5EKuwBt
         sE5pziG0jBUUsIx/45tPYFNx1VaH0lAIx+wIzm0xXoNKHo7VCFDf13Dz2hFIhks65Xao
         aZXxFySrqllPx2nlbePFiqiSsdGWo7BHQqvMt6rInfHvpwwjb836exk+tbZVGK8qxdSP
         yX2w==
X-Gm-Message-State: AOJu0YyPN00+gJ6MG4igp/ZJ624qECyoqNoXTBALAqCyui5kvEPpX6qT
	aqTJoMjxXnzxJfY9Nn0MezP2/wTsxjLC6Heu/yg0+RomqW5eEfAZpyXA1UIyq2kY
X-Gm-Gg: ATEYQzwOyjixrEsBWtuoyrAxk4u/RF7LRoeMacNO26m839WcZUmLY7lT/rZsxGBY+G7
	d18aagWRSS01Rey4zyatYW932GEE7gQS95FhNNcIOgRX4XGrmdKpdeATHqPQG7+4DtUUJhn7RVF
	gEqRng1MulE48ptv3kjTnVsPy43aZQ5PNyG2KLlbUpUlwcreBUaKSyllwZk7sm100NW4iXGYJZM
	v90/lYcrz1ipQsVlHZQdaKPRdZ9xa3XfUZ8MAJ60ZC0bJnEM0RyBSOiqUsH3f0lQLnBT8b0hhOC
	+dAav+i4J+lIdD9HDNZ/kQ2nv1K5aiuSCi8oauuGqFhNdQ7kaedxthFaSsxcJbb3QzIEBFlntFL
	+bZnj38w+z28syfZHgZT3r4/tEftFrO21/jzeJgBO2BxET/kF/s7Gg9mTqBLvayYEghr9kN4HXZ
	MkA7Rwub4Xvu8No0zlwzNgNy7MXXVwXk0icLCKp2lWwmUSkY5DdAzuTlY=
X-Received: by 2002:a05:6a20:94cb:b0:398:9820:f6cc with SMTP id adf61e73a8af0-39c87bcf3e0mr492459637.55.1774568874123;
        Thu, 26 Mar 2026 16:47:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:53 -0700 (PDT)
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
Subject: [PATCH for 6.12 9/9] drm/amd: Disable ASPM on SI
Date: Thu, 26 Mar 2026 16:47:16 -0700
Message-ID: <20260326234716.16723-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-230553-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 6EC3A33D423
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


