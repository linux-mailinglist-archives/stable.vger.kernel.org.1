Return-Path: <stable+bounces-230545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFVDOdjFxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:48:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90433D3B2
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43467304C077
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE50495E5;
	Thu, 26 Mar 2026 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGpMWln7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CA2FFFA4
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568859; cv=none; b=MDvmdWHEhN96jtllTOVoyl7doN/6XKNlBxLOk1tJbEXt63mE+EhwRIm/bWaPyGcsWQemyJaayLi3j2Z+fDEafr0qoptfr6O+QfbhECXQGt+JnxmSsSsh96ftgSDMVQmOpo1EotEoOdD70WKIuNP85tk+15qWKgAVgDqZpuJE91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568859; c=relaxed/simple;
	bh=whw5ih33RKzhzjxmn7G9KhAZAEVLCxqBpYjISYPPjr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2DTTHRysRzo93phy8yFy7Bs9Zethxhs4Fyl9q7MX2jngQSzoZW9LouHgqhbs6pRMsjbwbeayX7A6r02MIpW67tx+otjs9uVgbIvupGW8HzIjFcwXwWI/uqRonjP90P3Ej8foCJkiRJ7S2NV9pwNTD9oHCYuTBQ3/M3gmlWVyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGpMWln7; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c76864f4e58so40365a12.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568857; x=1775173657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
        b=iGpMWln7/gOOyCIdyrY9IIUUPax5Ihg/SM+WiQH4tbDBnzgKkOgyijltbnfQzKuxoI
         Nf6iKem0iDX178mCpgy2Q/1zh21o03DWP7tDI5i/Q4UweSvJAF/G27pPtywGRN6E3i9m
         xNZn6OafPbZf0Oh7f4gS7Q9X2XaXFau+YKvd6SbP8XjbAZXMeIOFagOrlUNcY5X898No
         rvixebWR/ttU56QDQXdJ8Kd9Y6rwvSIl8aQHBXRyf/2hKYBCYj8eExoi8AM0N//JJ8Cl
         Q9INmzygXWkURZxVJ9UGE4hrTpOKlra4Q0LJ5tlJ0nO6xm2xybHLflqnLOYOYVyV/G+v
         HTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568857; x=1775173657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
        b=o0zNJihV4B6n3VoxLes9qZG/PZAG6N9e25XDk1r9IxL5VzcP4W1nRps70jxltnGQw3
         z2Zi6qbkB59uViMrVcJ6bg+bgymPYh77H5r3L7pICgAX3cefH8NgQfjO/dVsEtA+bpaO
         j1XXxg5RNgNPbf9lDXeYqIzmscKL44sjpRpTuqKdgZZsZ1FMkVNVU63SbgLC+2KQMxjg
         kf3A8Wdr5NR512CRPJHRXyF0V+zSyhrqoEJZsxbfwNDGXenksidT54Gmvf+Bgnwcdtbn
         6BV8fE+CzQbpN+xX/RzTA3hOndvAeotP1XqbATMtzQQwuy0p861umLj/S0XF2bYqDN7D
         Yr/Q==
X-Gm-Message-State: AOJu0YwCC+5Vyo7AXJA9FmDcpgw5AQ3e2pbdHbjD+nCXY1hWwIRQAByl
	MerxOSeqrE02xiWxJZuxNUC38My8E9op4oAhlFFGoJkx37lG/gtEGgQmKJKciH3Z
X-Gm-Gg: ATEYQzy4njhnj/zBGPMGl49dqzCkCL/F6qNxluUteJBQZGzm+ANZLqh4EZitrCKddmk
	MRAmstuigXEaRs1Z/oxWWlZvCO4oclW7IGWRp9fbFgkm9WLpVXlpojW2V3oeobA9coo4Eqik1/1
	8+ONoYaF4GdelOothopPnj7pKyB67qQYj2uDVXcl3rzp9Y4EeovcTospPh5BYnzY2FnLhLOVVrK
	cfKS5Mt3osZs97g7lsoOxdp7TAMHjOuIsK/lKd6aiqMIA6xhOeYDvNb/0/yFF0s+seat6KAh+Dh
	8VPCjWl0py4VUBKy2Pmuiy48PHc3G54j/oB/f5h77PEGjB0fU+UJAciD6P8giYG3qEoCrjFmCoi
	IJYNUEcy23ixwji5spGqhsoAJfEUMcLAUVy07aRR5QmdFtEob4X7KiRmrno0TPIvsP4H8cO4odn
	Ao0iboljjYQ9tBA+vhXJVMPJVN64/uNzsN2iCFxNsj57EweBXRscWCR/A=
X-Received: by 2002:a05:6a20:3d83:b0:398:4bf2:4285 with SMTP id adf61e73a8af0-39c877fe4bamr553257637.16.1774568857439;
        Thu, 26 Mar 2026 16:47:37 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:36 -0700 (PDT)
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
Subject: [PATCH for 6.12 1/9] drm/amd/amdgpu: decouple ASPM with pcie dpm
Date: Thu, 26 Mar 2026 16:47:08 -0700
Message-ID: <20260326234716.16723-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,linux.ie,ffwll.ch,linuxfoundation.org,windriver.com,igalia.com,gmail.com,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-230545-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 5B90433D3B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit df0e722fbdbedb6f2b682dc2fad9e0c221e3622d ]

ASPM doesn't need to be disabled if pcie dpm is disabled.
So ASPM can be independantly enabled.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d5e6d5ec69c8..dbee43c58741 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1782,8 +1782,6 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 	}
 	if (adev->flags & AMD_IS_APU)
 		return false;
-	if (!(adev->pm.pp_feature & PP_PCIE_DPM_MASK))
-		return false;
 	return pcie_aspm_enabled(adev->pdev);
 }
 
-- 
2.53.0


