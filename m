Return-Path: <stable+bounces-230551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMezOMHGxWmgBgUAu9opvQ
	(envelope-from <stable+bounces-230551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:52:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E633D405
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1828230D84C9
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03C342C92;
	Thu, 26 Mar 2026 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdQ1VVwB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C88D30596D
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568875; cv=none; b=XJg1v1VWXgkPsPeLgltag4WaCSeYVP66cbYe7oZsjIaXDIEf7+xD/wgzRAn5iEwhgCCtvO4M4TPMbx1iity/TBElLjt+aQDo3/J8nV5etiHD7Bh1KZQUc8bQ+N8SeJ0uzQngM74G9Do1679g33GGJwtidnEgElAPYJ4Gptdh888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568875; c=relaxed/simple;
	bh=mQkiW4SfMzS137EmyrdOnE67zcpG0+2zfv8kd36ZGCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlmhDDZZg2zJ97zM14ccy/eJM9qrSUr+6Y8qeVXeU6gBE+tFId+Cp8/X02H6iLW4wg+XdnT00jd6l56f55qzSp/UXbd9G0msurz4l67lTkrVbtfwUFOeIIxd5q63aYU8sIhr//rBq96TmtN446o8mvxfhSFKlNA6AA5nLu2QGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdQ1VVwB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829a9d08644so798399b3a.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568872; x=1775173672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
        b=SdQ1VVwBAY8AZrB4tlI5vEp3JaEECyx+DQYQjWk5/omoRpNEJxl7P3iNyasnpRjgMn
         0hhrOH5DEQBHH0BK7UYaJzAFF177pCZ4CK5TCokb/y+e5ptil2VnrnSid1CA88+SP4xE
         XnvmuzKeAXEf7siBReq0MCR+NcV1aDlBOmScgMw0Rk1a9AsQ06WplUXouZiYDP+2wptw
         JTi4/2I1SjluzROCRlhzYu+XXT/4ypY67TqAQEYT6a9aHZ3MI6iPaDSZ+0GdPjbEHC05
         74YdiLnqvGfptsNc1SwBXgVo4hsrJb53NTgPLRO0jp/HfPO/lM4xMLz3kWtzDYq6ZQd5
         4Viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568872; x=1775173672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/3ZOVQYuvF8/v5An1EVVsLN1VlAxvgYs14Kv3HQDNc=;
        b=H14C1UGvQLIl7C1QFUKE/FSk6z5iYt24CbuunMl4RAEvvnXstir29e8ca+oH05nYfh
         GuKEAckJ+VpfVW6yegv2tKDIzKGKT3lDH2lyKfwcozccMiMA2+AExDQHl3V2CITFkBP5
         eYTUcaGI8HPWMc+9unuUaD/AKauWUT+/RWSWqpOOa66NoX1nfARGxuAZ+Cwoe+vZgq21
         7KR/WE6QmDKyV1VseTkOkG+FPisU/y3sbLyy5g+XxMlQxdwX4QH8rJZXAahXy4XBP3Xj
         inMSRPk4beJxhjIOWA++RLyz9ycGlXAiba4XlZsOsPu6qWcO268+Lvdw4XRSwjl+5bQt
         MQsQ==
X-Gm-Message-State: AOJu0YwA6/JaGBmD5S+kZQ6/crhty0G8zl1pyoV6dmA/O39Aek4nTSv7
	axzBVIyLgpZY0H9DafytrpDuuCO6J7MaC8HB6cee4M9M2yPQ5OkmfP+1jdMsVQ/N
X-Gm-Gg: ATEYQzxqv29wtamIPleYod2WrqBRobc1/CNkf+HkOvY6oEqPoi6od2sNxxr+5EohQlG
	ZsnTuuK5Wef40p/7qZhV8PkQsfqNn/kQ4L5tWhiotclnpHdxNuxuI8sBFil2HVBG0UNPJ8T+qxR
	5lTyetlJQdT1lub1cSHu9x0yY+X9F+a/IMkN6Vzu11VG01SDKefA5PY5omGligTObVGKOU1Qcmg
	ZhuDSiKX6KnNovOVZwmQU+WCw8D5yX4DAyx0ArNsgZWOt5JvsVrR4fp9+2gGJnPs+GsQxMKLB4S
	11U+FfSI8fnO8hILDskNMndWsKZjsq8MNhjCkU8QDpcKLQ7ECaofLFxIP86pfjPs2+K/NSteHoD
	qnG9w1mw5oR9oke7IqXatogkN0D5KG8lERBx7lr0gzQv9aUsaZd/xdnyOUQx8uZeoFyFmn5q/ee
	hmLtUAAxQiqACG+93QOPcdGCvJEGC3ySQhCEv27nyx74u++jfuaS0uNHI=
X-Received: by 2002:a05:6a20:3ca3:b0:398:a060:a97b with SMTP id adf61e73a8af0-39c877b2c2fmr512115637.1.1774568872136;
        Thu, 26 Mar 2026 16:47:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:47:51 -0700 (PDT)
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
Subject: [PATCH for 6.12 8/9] drm/amd/display: Disable scaling on DCE6 for now
Date: Thu, 26 Mar 2026 16:47:15 -0700
Message-ID: <20260326234716.16723-9-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-230551-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 5D5E633D405
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 0e190a0446ec517666dab4691b296a9b758e590f ]

Scaling doesn't work on DCE6 at the moment, the current
register programming produces incorrect output when using
fractional scaling (between 100-200%) on resolutions higher
than 1080p.

Disable it until we figure out how to program it properly.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 978c024c97ba..3f9ea4fdc7d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -404,13 +404,13 @@ static const struct dc_plane_cap plane_cap = {
 	},
 
 	.max_upscale_factor = {
-			.argb8888 = 16000,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	},
 
 	.max_downscale_factor = {
-			.argb8888 = 250,
+			.argb8888 = 1,
 			.nv12 = 1,
 			.fp16 = 1
 	}
-- 
2.53.0


