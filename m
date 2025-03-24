Return-Path: <stable+bounces-125863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1EA6D660
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A483B0128
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A62D7BF;
	Mon, 24 Mar 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFkI7PVE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3D25D20E
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805493; cv=none; b=rAjumpcWEFbZF1yHStildlHeCTwSH2L97s38qOOQpqcseO9YmJqPai5q/+iPtOFpXbwIkyP2B7IYfiQdkJjl5UyqOu5CWLo/kRUaFkyLJexTEGfaKok+uXAOEqKNuS93emxe0Y1a2xTWy3pGLFmqM5WB1qQgQpV7qXYt6XC6nxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805493; c=relaxed/simple;
	bh=5Hy7eCfggzSKsua8sWNkzHN+AazWrLqLGteqJWFuBto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRNwUd3oP1BbIPukEWMim6BrSrCmXzHLiywC7hD9VnNpYsFIcMKz3mlU1b/x3I1e9Xi/Nb1qnCPXhrNS6559DrDbQac9QxnsUHymxD7E56O5w/D+CAJCfUMCT5/sGgxPBNDSKf+Z8/6sTSuxB7H4fsUHxKnHYeipTAESSs88vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFkI7PVE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913b539aabso2150018f8f.2
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742805490; x=1743410290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8crvv1DnTAIhN9IwGfudPOXUjLvEiE3lOXStQ82280=;
        b=JFkI7PVEn883XkM5FgYZATC8QRIE6Hyma0T0LnAu6Q0CWY3EFP0yTsnDSJj8kzgIBS
         MNGFyoaP4lXR4/A8i5V6xkrlTA1y7PWIagzeZ+dIxpfuRzWv4fg57DMQ0LbyK74wGx2f
         rkR3BpJkFoNONmPE1gSoWh61B4TEVgcCiA/W0QZN+h0Vdcm+jzG0pScdHxdqvGDZ7aAg
         7iSDVLzht/s+AUVGkl+1j3EQL4cPGQ0NyH+MzouMyw8uUpCSbSWKPtfGQRC51zDayzpk
         3ajX95cdMcj7AfnkTkFB/RXlc7ajkyKzoAp+LOjyiOimWSiiEYqZ5CcXraC3F2fBgncS
         GDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805490; x=1743410290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8crvv1DnTAIhN9IwGfudPOXUjLvEiE3lOXStQ82280=;
        b=QxRTvavn6Ibi7BqC4dOrCX8uyeQHGToT1UckzR/jcGvcsmsMdl92B19qp/DVg1ogG8
         ZOdWEgcAO/iAB7Ai4h8AYdlC16tsbwN7vO7bfSouX7BuahCKImFP/YLIsNMy93SrYj9g
         /7yRmZS2F/lDLj3dfadpG/O81cL0krfsWBbw39BO2Ncp5hFP98c6+KlFR6eFJXrxXYZL
         9MpsRmcp6ICbVkv8p9c1YYNiqAoMWDEuQnpUzoZNbcO0t9gMGHgj3yJPJtlw9z7Gks/q
         8hU+j0sLd1dULjDcvU+/+tyrc6GyhwjPsHLwbKcWib/TSzX3fdqMOqwB2pDizlHa2B8T
         b2IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoIfmuylVfXe5Jr3UBIsEAT09hS8UMq8E+baqwqER+cOPXTDDdTZeyhvzdEv4WErO9jIdXf1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqhLe+pHPUPDUlCoBN71aBdoaJrdV08q4Uq6sFg98Hxz3ZpT0
	g6dhibbBMcRsDEgA5XFDzWu9wnWi5EvqLW18O3toUk0Jd4l3DvjA
X-Gm-Gg: ASbGncvjlzDhXQEuCw4eI9c7GMQe4I/TrHROS0LSxWlra2sqOZa99iF/KLWcU8vB3S7
	OaD7yPCH5sKWxrZs9qGJo3EDyeWmnDJ20+1sFSH5WtF0Mu8fnHI7uBWNVnpqpwLIj6zg1DM7QS7
	G1Cw9kcbNvBf542oenH4BddduZc/F+zTVoHCyXW2PeIPuQhFGDE/EqBBidCwidyxrNZbL4YW3JH
	OBHxWbJcBCXtXVQJDRcgpldSptPZgAfpY1LpF16u0hk31Xq6j9PzyAKIQz3vOBdPDptBOTHLgld
	yLtmNqk8RSkE7K2BYaN4iqa7HSZjYernFb05DURAh/sDkoIvVEEBHf3tu5WGXg==
X-Google-Smtp-Source: AGHT+IGs1HJeKkqJjMiO8rC3KSzg7HG6dWeZwb3bbz3SIfkpzJ0mP0jvFr5APzI9VrO18/uz84mVqQ==
X-Received: by 2002:a5d:64a5:0:b0:391:31f2:b99e with SMTP id ffacd0b85a97d-3997f900bd7mr10503751f8f.2.1742805490200;
        Mon, 24 Mar 2025 01:38:10 -0700 (PDT)
Received: from arrakis.kwizart.net (home.kwizart.net. [82.65.38.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3c2csm10078670f8f.46.2025.03.24.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:38:09 -0700 (PDT)
From: Nicolas Chauvet <kwizart@gmail.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Nicolas Chauvet <kwizart@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] [RFC] drm/i915/gvt: Fix opregion_header->signature size
Date: Mon, 24 Mar 2025 09:30:02 +0100
Message-ID: <20250324083755.12489-3-kwizart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324083755.12489-1-kwizart@gmail.com>
References: <20250324083755.12489-1-kwizart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enlarge the signature field to accept the string termination.

Cc: stable@vger.kernel.org
Fixes: 93615d59912 ("Revert drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]")
Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 drivers/gpu/drm/i915/gvt/opregion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 9a8ead6039e2..0f11cd6ba383 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -43,7 +43,7 @@
 #define DEVICE_TYPE_EFP4   0x10
 
 struct opregion_header {
-	u8 signature[16];
+	u8 signature[32];
 	u32 size;
 	u32 opregion_ver;
 	u8 bios_ver[32];
-- 
2.49.0


