Return-Path: <stable+bounces-69343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DCD9550EF
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3721C21D79
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 18:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121C1C37B4;
	Fri, 16 Aug 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hGBrV5wd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF21C233F
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833220; cv=none; b=a3TXwpWU9zgtpcKU2qf/XtkRCEk8TwosuEGYt8keJXz/kpydLO8QE7cu4+a1ZITjtmZBgwctOXe/ny4uZVhxjheVVJDns3mwi++EWbKmXWzXEeA11kHNieXOwvcWW++erDrpW/QOf7G6bc/sSMKKYR+/ykWDnE1Qj9h8vNYZuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833220; c=relaxed/simple;
	bh=14oGGY2z7Ig4G/bUH0GyshgmvYLNY0V6WCaG3ka+EAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT3HT4wgyge+wCF6DbrJ2qFD8wEw4K71Blier5jk6zRVCFqWygHcyAtL3FO/cdumpheEEjw+xtLG4L/iigRDcEcv2xp6k48MaoaZwzTSJYo7g3F78t0yW9DOqTgChSWIa6XJHPXpA8ghddrwwprtDqdRG7AL+LvbzN1DJ1Ov2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hGBrV5wd; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-842f04589f3so652882241.2
        for <stable@vger.kernel.org>; Fri, 16 Aug 2024 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723833217; x=1724438017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MSj1ciHmClYtImv/kj46bRHE8rpnNrCKdm6pfAirTk=;
        b=hGBrV5wdEgBmmrAxozVPCbdgj0tn7v9xwpgFUzvuydcfHPPxNTJPDE4wWt5shDoqa5
         aWKvSlmiG8STdEZRkz3pEyz10QHEwKxibk6ywfQSyPd0hBJvm00ZBVsP/5D6Fd2zWPAB
         dh57wT7xC6mxIYDsOr1rmYTNNHKwXo/eJo/gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833217; x=1724438017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MSj1ciHmClYtImv/kj46bRHE8rpnNrCKdm6pfAirTk=;
        b=pfnFVCdtAri5RKzWAJni85qYq4H0yFr9Dnt6K2+T/xLplP3FJUr52+3/1UD6DsGGtj
         EsitmYNQKVwvVmjt00FDOCX9cjgwxvXv1ymiFBoQHjCvs/PjGM2uWtRy1ILkmXW/rBu1
         L5LIZMDKSDM5jCQBww56Ia5Ot4pqW0egsRJbV2/cpUc1RWiWI1qHoSmzobUnvt7n1ew5
         gz9bTKW6g157PIyunRzj+EU/UGAsvaXFpZegOOjqPGy4W4d+EeH4yUNESouUNqR0S+Zx
         udXHfNlqKS3LiYyvxS+JMai+KKpjG/9Nuy2J/FBYkzv9K13dRFagyq2rJDRdWWs4S0lW
         Fzog==
X-Forwarded-Encrypted: i=1; AJvYcCXIYvItiistMUyFrQPtUBODEt+22bkGVuFrLuTOc4sTsxEHhBdbPRba0TRf9jWqe8U37qlXPMZEnwV3BB6G7aw7Wpk0Q1B5
X-Gm-Message-State: AOJu0YzwrpBMCXAl2lMJEf9yITdMwt3y78Gat7snnTVvlJRjFCnu39/a
	Vfuk69JU4+bE6EclgIY4l763QXYnCL7zqKvvzR5kOIyujkSmYlszyy8DHPYKOQ==
X-Google-Smtp-Source: AGHT+IGwMcyf/LhSnfAPtHBYspzrmDF7f6Af8FNN5mB3N1Tsvbz//Z31h0D4G0XY2Rq+SiWw4Kk6Jw==
X-Received: by 2002:a05:6102:4190:b0:48f:96a8:fa33 with SMTP id ada2fe7eead31-497799408a4mr4251629137.11.1723833217410;
        Fri, 16 Aug 2024 11:33:37 -0700 (PDT)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe26c71sm20164106d6.61.2024.08.16.11.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:33:37 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	ian.forbes@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	Christian Heusel <christian@heusel.eu>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] drm/vmwgfx: Disable coherent dumb buffers without 3d
Date: Fri, 16 Aug 2024 14:32:07 -0400
Message-ID: <20240816183332.31961-4-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816183332.31961-1-zack.rusin@broadcom.com>
References: <20240816183332.31961-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coherent surfaces make only sense if the host renders to them using
accelerated apis. Without 3d the entire content of dumb buffers stays
in the guest making all of the extra work they're doing to synchronize
between guest and host useless.

Configurations without 3d also tend to run with very low graphics
memory limits. The pinned console fb, mob cursors and graphical login
manager tend to run out of 16MB graphics memory that those guests use.

Fix it by making sure the coherent dumb buffers are only used on
configs with 3d enabled.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
Reported-by: Christian Heusel <christian@heusel.eu>
Closes: https://lore.kernel.org/all/0d0330f3-2ac0-4cd5-8075-7f1cbaf72a8e@heusel.eu
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.9+
Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: Martin Krastev <martin.krastev@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 8ae6a761c900..1625b30d9970 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2283,9 +2283,11 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	/*
 	 * Without mob support we're just going to use raw memory buffer
 	 * because we wouldn't be able to support full surface coherency
-	 * without mobs
+	 * without mobs. There also no reason to support surface coherency
+	 * without 3d (i.e. gpu usage on the host) because then all the
+	 * contents is going to be rendered guest side.
 	 */
-	if (!dev_priv->has_mob) {
+	if (!dev_priv->has_mob || !vmw_supports_3d(dev_priv)) {
 		int cpp = DIV_ROUND_UP(args->bpp, 8);
 
 		switch (cpp) {
-- 
2.43.0


