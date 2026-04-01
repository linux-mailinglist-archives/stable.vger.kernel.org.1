Return-Path: <stable+bounces-232620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OhGKdRpzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:41:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D09373397
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A90E3035D72
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF901C5D44;
	Wed,  1 Apr 2026 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEupFSMQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50351D7E5C
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003973; cv=none; b=t5p2ZXjS50WBUqPdmppWdbKHzkmynsQvPYwDwp9pXafXNFXzQBNvlAdacMj9G3rtjL0qONGw0CTIDxfKI8GdDrumFbWwcpsfP+QHl9VoLk8zSt5FgKekddkg9rMjFeKwlj5qGg9ZTnWyq1B0+fcCThikAqoWZSIUPUji5vTTVO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003973; c=relaxed/simple;
	bh=whw5ih33RKzhzjxmn7G9KhAZAEVLCxqBpYjISYPPjr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLRO+HapGuynVa2RCS/9IHeALTFCUWga8Y4a/J4GtY0cmDos8Ytv8NkJCCbxiXQzvTlmvGnAHYL1TY4pq9yiYQjxF8La5uR6ZXT8ahjo7EbDq/WZE8+T4UQGfI7KVQUhEELpErRXMFOIWd66cnsrErfLKfKidkgHA0kACXhpi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEupFSMQ; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c5b3d8eab1so3444556eec.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003971; x=1775608771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
        b=FEupFSMQ76otu0Y63VStrJR/Qt08ko22ysU72l+Ss52pxnJSB4Rdq/qMyXMfSU4blh
         VIZMFv/F5KaF28zHDLSecsLAc5qdYeCCf6z85OJhWVTB7fWasR1wYq2jxkMFJ2xeoB/l
         UtyyqamH9+aiV9G/iru2H9XNgPzrpE1MPFeh8IMd/wjbGM8wj5OiQi3l1nLCyrNalNs4
         Ryb/jM37NQZ0lwP0hsPn/u83EPB0OzvYLBmj3+JMCXVDr8LIMpnVjBLGeVFZ/9tcPUEl
         J5YUOdPzyjOw7S8NkU8RRHqLaWJ7OaZfWXiWcfhQ4d18Okh+OjJeic7r8359tIArQb+4
         E4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003971; x=1775608771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlXNZ6YErxvr6V0/1Nzao8eMwm0DA+edMLaU07KmQkY=;
        b=NrEIvWCNaC0TEck91awZvVhqpObUEGzPFXAVRBkCanVQGjYkEMoCdDmcIcSRcUC8Qk
         emIu4trgwa/PcZ7vI6R7OUBgyAFzUwLC1V41NHSXwAemm7s21ESSwjc2TEqpVzuf+QGH
         cVCqSaexigphCzKi2OhyQbVzOuapPjPvAOiX2eqdcnR6DUdst9CO7XM1k2DPqmEDrQ9Q
         oapzVHBNNuM7dwXTXUrivIwoNSoOuIOaB5IEcmsZoTYk/uDgd2YFk9uGW8xq+lhESVuc
         aKEumPcC3zEvnl4IVZ25PDWEzyOP1HfgjIl8vdrzXi/Nm+WlAl9PThHNz7C4R+zOF9or
         Cbzw==
X-Gm-Message-State: AOJu0YxaPsnGJKjXnEnhil+qhuKP4ADbHmFKSeO+71VYHCJmDUy3ieev
	PeT2L79D7Zmn63nItVtkYIHptZfUtK9J6tmu76W9y4W/8E/iLDmoL5tVHiw20lvl
X-Gm-Gg: ATEYQzwlQsYZy88QGZPgYBSyrYuezBFb/iNXmnfQ3U/z2ur/Xlb7YNwWmmA/ZuL3iSM
	3sdlOlIF393sSS+Hhwo8vbnFlpmsGYbpeKxTepQU830LAWPB4O2EXdnU5dbifbz2N8s70FY0Td5
	Vul3Pzpl4sMh0uNfbFJBeW+MkEHsiMVv8gXovlJLGpmM2+oSBrGM+K1wc+1SAQERVyyjnCmQ/2D
	qBl+TKLyoaXCQlAoUKL6kbHiJhxIpjMFNF5kM4KO3D8en2GivKQ2pETOGpSxQYSf8+QzCs0zumY
	mViizkp+pjNwI/0RsvJcngIQ3dEm/iD2+ja25BnMoJ1qB7Gr6INf0i2jMUjOTUBzTz/YkjoOXn5
	/IVzONIAo+LINJKySPJTkJWQCqBwDXOEE9Zdf0E3Wpt5eKJcCg8FD18BQKzfDGmL6ALKfX72YMT
	A2UnIg0y+eUQFMuLdfPzAc3YRNRuM12OGvrNxKtKHWUSRqIBXU7q55MlE=
X-Received: by 2002:a05:7300:8626:b0:2c0:cc90:a71 with SMTP id 5a478bee46e88-2c930e6a365mr1054199eec.8.1775003970551;
        Tue, 31 Mar 2026 17:39:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:29 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 01/10] drm/amd/amdgpu: decouple ASPM with pcie dpm
Date: Tue, 31 Mar 2026 17:38:59 -0700
Message-ID: <20260401003908.3438-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232620-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22D09373397
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


