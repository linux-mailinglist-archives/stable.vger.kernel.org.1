Return-Path: <stable+bounces-232622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMlSAiVqzGlXSwYAu9opvQ
	(envelope-from <stable+bounces-232622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:43:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB83733E2
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06DED30931B8
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E171DED4C;
	Wed,  1 Apr 2026 00:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB+Y3RjW"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625DE1E9B35
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775003976; cv=none; b=CtFve0PHQngOkqk6gjHHEl3/D4wJuCiZ7s5X8QhJPrs9+aHvUmCRMFivRJbgz7mOLs1IqGyoIbFGyw9X0QtqrXMEE86si/50pzxG1iTOuhiv8F+nc4YTFS32mCktmKHTs5f8bq5FGqMzY6cH+tN1bsLDGxBYKa+TMLFuCX574wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775003976; c=relaxed/simple;
	bh=RwoqpXy71D2hq/9YeKiguZNaZPXik4kFxfn+hYcauuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCj5p4Wa2/7J2w7+pSzdaYacCrR2XtHhD23GQFksBpvEn9/8lcKWhSPfyYfv4MBdoZL1OTGddWK+2P3RpHwZuD5A4yhnkncFuDOaTN6VWyqJqTZJ1vS9ie3q1329Cty+FjoUbz5imP/V3vw9mO7soYuFob3aktYBVIFO8F2R9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB+Y3RjW; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c54c68db4dso5251156eec.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 17:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775003974; x=1775608774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
        b=kB+Y3RjWJvfExWLWEitujv6umsPzILuUB+MgLvr+YJf5AltpY334IEgPatFUXX7LQK
         /OsXug6SDwuBglg87qZfCkKaYbPVctbjXYbYWZZlZiEAi8IN/yQ3seikpR8/WHXx+7Yz
         hREuNUEf0Brf5SB7mkft6b30/3M/TTQ8ofvk7yMvOvrap41Vi+sD63z3dXhBi57WZ+7+
         JBovm1oNYnV33H1OW56hZaqllBaSaK3PlrxEqoCIf1Tybu1JMNwDKyQjoJMGTgNLz8t0
         AeLbZfsjFVTTkt3SXetRHYbM70rIDYErF/PHRGOg/tIIkFoG/Ayip0fytm+9JsIUA/mW
         QRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775003974; x=1775608774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izF33sGDSHxUIsJEwsnSvCBwPxbglhEjEwQBj49A0mg=;
        b=ole3/+dOEYj/15yIgt/cgiD66yHsxEMB05OGRziEsUS2nEAGtGJfMGrpBq5IuyGJ/w
         eGdCNOok+kgK1zf0YdSZTQC1N0jdQNsMFunGDTZp+13cGhTqOF3pPFyFHIZiYRjIjQDn
         R3hSh+lTB/Z6/v9dKW/NH7Jkqo3xpgH2F8cFYbp9dXOAmnifP81MWQT72WkBNqUOdY+u
         UGWHlXjEcNqtEJ4ZoNKe+w1l5qpt/OAK3fGKmTGZXe+iGYnm9jrJZYLVtK9BrDyf9zhb
         3monRcGVo8on4rTu61H0yQiGff6dRduXsh+kaNFjT6LkQjLBgETwC5LVZIHktzKtIC5L
         ZjQQ==
X-Gm-Message-State: AOJu0YwbBi94yf+4JJR+Vv/DSglZqURLnY43R5PygrpHLBPOxSzchKtx
	8xHjsu1v6bk+9nZn80effXh5Xd+HZb8BAdERePn+wUqNAh6lyEzv9o8NCnNR9FSK
X-Gm-Gg: ATEYQzwhAkV3FKvwWyQx6ukuolqOeOSlfe6dl2pqSmmdWMQlfmuuXiKymZTSJ0H82dy
	n4bjGARSgJlw2obYPKJbzZ6V1wHC6tzrVFc+rTfi7fZOhY1LGdcmhmgnwDeTJj43BJYwG5OIc+d
	wyRM2ZJVdIIVpr+B7CRyVrqWTgUVtXgrgvURqtt/HSTYFtM5tmx3Bh6p0phF3z3j9CbeO+SKFbp
	IpOJOWDX+ajzQz+jrnvztC6R0FzTAOeSw650/8X2PRWgIL/972ZyC9YkCPscZi1S1RZHdfwYGiX
	yPP/f+fkqnRm7LEYZvaqk3WAFmThhVUlHMCKh5a/TeH4o5Lsq3Y5QeT5Z+MYvUE9S2cb4zsINkb
	pZq063xFoO25H0epPtlpMhPdTNLAWPVzl9bIcjsdcaXZx5QmbGmPhVkWL7gaGa7ikozcrLtF5hq
	okiuAfPNTyd2j/ZimSmEtknDEtqPYhv3UPjRh6bhUzyOG3eQfzzSXMaHQ=
X-Received: by 2002:a05:7300:5b83:b0:2c1:6cfd:73dc with SMTP id 5a478bee46e88-2c9327a1ac9mr827510eec.17.1775003973981;
        Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 17:39:33 -0700 (PDT)
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
Subject: [PATCHv2 for 6.12 03/10] drm/amd/display: Disable fastboot on DCE 6 too
Date: Tue, 31 Mar 2026 17:39:01 -0700
Message-ID: <20260401003908.3438-4-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232622-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1BB83733E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 7495962cbceb967e095233a5673ea71f3bcdee7e ]

It already didn't work on DCE 8,
so there is no reason to assume it would on DCE 6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index df69e0cebf78..7dc99c85b8ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1910,10 +1910,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 
 	get_edp_streams(context, edp_streams, &edp_stream_num);
 
-	// Check fastboot support, disable on DCE8 because of blank screens
-	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
-		    dc->ctx->dce_version != DCE_VERSION_8_3) {
+	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
+	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
 		for (i = 0; i < edp_num; i++) {
 			edp_link = edp_links[i];
 			if (edp_link != edp_streams[0]->link)
-- 
2.53.0


