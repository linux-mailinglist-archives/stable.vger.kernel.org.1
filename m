Return-Path: <stable+bounces-220029-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHkgH19Bomlz1QQAu9opvQ
	(envelope-from <stable+bounces-220029-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:14:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F206D1BFA8B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B3AC313EFA8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10E426F2B9;
	Sat, 28 Feb 2026 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lkn2NIEj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0062D6E72
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241155; cv=none; b=f7ThdIrT5p4f1p7NXdnVgWP4BtlPoKjDIx3IEdOpMZabrFnN1UYNMHjvJuOBm8qp7E30fRPmEwpB0L2T7EsbUG5fY5vWJMr7qRBq+raZczD8J6LoynnThpiOmfQR6u3NR9p/j8GAT3hmC9BSf0nkz4Pf6yQq0dq/++VyojiI2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241155; c=relaxed/simple;
	bh=2fgpAJxAhO7eMnf/Eh+Xn8+D54I0ZQC9KZDqKhydZMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XK+oEcfQVyAA0oNQ5aDar3EjGhnBLs5Kql1RaenqMW13X+27fwafL1oJnTr/hKkUpkbTul51zjjynuDfk1mNFsBTAEbzzYKbGEQbqCKCvtcHQtq7XfrGrxrw87OiqItyOiFqO7f1DRbne+2e4tSyxAXfj0NQlrB1tUVE76XbDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lkn2NIEj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso1430878b3a.1
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 17:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772241153; x=1772845953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVWvXlolIB1z5Wdh/ZWEpJ69krVbfULM/4hKT6Ylcj4=;
        b=Lkn2NIEjgmom/2ypClCi9VR5H5pqVuD591tbVVeCLwW0HQSlfqUk0dGUW0Q/+YxjRV
         YF/heraX2+JeFkFGlPCx1bClrW8kHP4D/IKoTQriDHLVs3++3A+Qen3WmZGUuWC/QnaU
         TTJwv8kM2pLFiYgO+3s2jRZ5+990S4nUvjQ6Dt5vIIm6Ti6XTz5Y9PIYwitckNzwAKEW
         qcQ3CDPt3jnLif16a2ppdyaIntXTbnb8Bs3S3v0wKhspjJfvMMtAyWFIzpt1o7KDDIwn
         RFkR2IR9cyO+o+rf8LHrOrEtFkJULCq0urs78a2E9mkZYl01W+xpdvJpVwHH5nbSz3c+
         lSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772241153; x=1772845953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UVWvXlolIB1z5Wdh/ZWEpJ69krVbfULM/4hKT6Ylcj4=;
        b=iShCRx6cPzonyBdln+0lhsPoZrWS0ZxzDkeX99CqS1ReOSI9AkoXbLLqdnAhMK1HFs
         9CGxyqgMn1orEeDtpx6SoVQIxJ8g/ccB6V3Nbsck+mpTtcmAyPND9qbgyt/WH9tEJO0F
         evccEje6tO2sB1M0fTssHjLgKY2ok55rda7+mILB2lKrk5+3qm+hyGnegQ23Rd966Lrt
         uD5dlWNePedrbFjnIsq4tyW+mh+YuH43yW44h6R5gWnQOZgkU51Y6g5iUKu+wWJb4w2f
         HZqeIDId5q2O5zvNkXBKAtO3NxfK17PPiUBzdTGwPAr1A1+oTW7JunxYg3R3q5sLcGHq
         7w7A==
X-Gm-Message-State: AOJu0Yw3RwSxnBBobK3MUW7iEC0skiHtXVhqK/yH58De+kTIl3txdOjj
	H8arsR5mTeUDj8iM3qaQwGoEodQ75VSGgGrLV4naX2mDJiqMM4GyukFKaLN8p+d3wBE=
X-Gm-Gg: ATEYQzwm/b7ZrhOp6w/Dh3KHBdwnpVN5GG2sfBIsyJE6G6NcRzc2HxcCMprsRQchHYU
	mqAmlaeQ4JNz8bhAyidg0JRjF+0zg5xSzbXk/hjM7Cka/sHuOdw5nPL+VABC5198r0lyn0G48qX
	XLeSEa0ul5n6Qltb5WUS45RDr6XKM5wtDFskVzCB9W7akh5YT6vtNW43pwDros5/WqKCkRzC8Mu
	OwhHynKgbqYMjJD7HFXJa2+N9m3KjWUUjfXywthmbKpRT+yeWxESkKo6MeJ7W9LV5reFkvJ249L
	WPHbQeqvotg+cUGV2BJrTaDE/s1F3uxMzjtDmvyL6KOTjaG7SIa4wg3GVHsUeT6MZ3ymaHBdULL
	znUYPJw8qz7ew5Rj667sb2i9D9zUliJ6UJB84XmSEwLByU7HYloAxcg9E7pac021JP+wpKSeTTI
	qML+Z/Xwv/hJOVFKhwp48Zh4Yyh2GEk+ZiujUkUTQOeSXbPnIQ6rOuBw==
X-Received: by 2002:a05:6a20:56a3:b0:395:1200:3abd with SMTP id adf61e73a8af0-395c3b45943mr4205836637.62.1772241153329;
        Fri, 27 Feb 2026 17:12:33 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f46c2sm75772845ad.89.2026.02.27.17.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 17:12:32 -0800 (PST)
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
Subject: [PATCH for 6.1 1/2] drm/amdgpu: use proper DC check in amdgpu_display_supported_domains()
Date: Fri, 27 Feb 2026 17:12:12 -0800
Message-ID: <20260228011213.423524-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228011213.423524-1-rosenp@gmail.com>
References: <20260228011213.423524-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220029-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: F206D1BFA8B
X-Rspamd-Action: no action

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 96ce96f8773da4814622fd97e5226915a2c30706 ]

amdgpu_device_asic_has_dc_support() just checks the asic itself.
amdgpu_device_has_dc_support() is a runtime check which not
only checks the asic, but also other things in the driver
like whether virtual display is enabled.  We want the latter
here.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index cd0bccc95205..98cce09684f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -534,7 +534,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 */
 	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type) &&
+	    amdgpu_device_has_dc_support(adev) &&
 	    adev->mode_info.gpu_vm_support)
 		domain |= AMDGPU_GEM_DOMAIN_GTT;
 #endif
-- 
2.53.0


