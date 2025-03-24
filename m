Return-Path: <stable+bounces-125864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4CEA6D657
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 09:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94E316C9E2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CDF25D20E;
	Mon, 24 Mar 2025 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QESLY/HB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013D200CB
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805495; cv=none; b=hPxAzH5NGFKem4azy5vkQWTwsNBl1jRwu1j6k0R9VdPHVRfjGSzWx3lgsXYNWbntAEOl/KYvESUy3/KwEivYc1RXfYpu737BF4pHfWNvfpOulCQ8jZfFjD94ZH/zRikbNHgB0Xy5Tqm2xs8PQldgWCz5f1PVUZhoc/RqbLeg8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805495; c=relaxed/simple;
	bh=V+iAJHmCjKXKm3jNNPcTsPQ4y/mm5ddJVSsTpik9WyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onJDjKne6x67YEBppAH7ZosWmrkrp1EUAX1PPkzlHzFzuRE3mCWMNHnT4j9fPaJcO65RZVioHDJf0eR1KXTRaF/wLi68O545ajsO/PX+81zvN7Nc17TytnPxf6LBk5kUklcC76O+QLbXjpq04u9R/KajDIzMSbK1EUSR5k/7hXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QESLY/HB; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39ac56756f6so214115f8f.2
        for <stable@vger.kernel.org>; Mon, 24 Mar 2025 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742805492; x=1743410292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo36faXWgJSYin25nWEbPgzyVTPsJ7mvs6BrtN1N+6U=;
        b=QESLY/HBjoAxyXrua7/uB2GfrB1BGXQxhskikiiQY+ILtW5LRcfzn/gnzXLYvOtbz3
         C0F2fityQ9L8IspFxN8FsFpa5XB61NN/yseM0Mxj+xTqzdtKE/t5SgFVJ6wjhvskGey7
         RkSZq84EC5o8QN7/wjCmrCIyfpGtJ+pkegfSLX0UKMeR5EXgfar5IH/vENZQmJHbs82Y
         Q4v1oQ+yklNpyaEzbxy2lVRTD90ujfr56g0Xm4X07j13rhuigPSTiCj3tQFxOtyQD2Fl
         MQBhUANj0/G+4VqIKH3lMf6V8nIxxZg1kDmhmHCuyJvHKBfJCM5pPerKBB8immtpsKzU
         +gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805492; x=1743410292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo36faXWgJSYin25nWEbPgzyVTPsJ7mvs6BrtN1N+6U=;
        b=BrbY05fExKmlsuCGheHS0L5Ho5cWKB+/0g7Pi+xLvVkBrRTemP+4XE2HIjwdrj7gKa
         nzvhDZ8Q09Gt06/yp7vQ3xdJE/qWL2oaK2JnkYe7aq+q5jZcOynlpYjN51l9PtFTpgJC
         mJyP2xSwDUfxc+MDUre0iqkkBzfmm4zMfqNK9VHcYQ3uFJuKK6X+qGGg1sN7Xytmk2g4
         xtigQ7eNWrX+cJsEsNruVnijU5Qufyf3DTk42QgFcKP2F/7vWA57EMrexGoFwxPDbNgN
         ItlptR6jOase48oDi4l1OmHC3YDdzQaAFnI4TFkl8OXOkk4I0hhbNdUae68D79xK1hOH
         CSCg==
X-Forwarded-Encrypted: i=1; AJvYcCVM69uam6m5kBkVkQ3leUmCJ3VcW18bhl2HF3/RM7k2zvuxG3ABGb+rsMRdWjUPsWdLcgEoLJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8JHeQ44twYKr2wWs5zICKUGnx/LZbZ7n2uojjCJoS5FzKqifd
	JyGygJIFL3YozZA2jk3PnEkp/+l95bGw/+a7UNzq0MjzVfE6uGHQ
X-Gm-Gg: ASbGnctJ1eCX7Lew12xKWJd2SCq9kQP5w4/w3NPDr6IxOY6IZw+UVxRIaphoqh4cwY2
	XM56t00mOq3N04I243nqb6ZaHs4dmE/ATGtRR8XXA1l7HLL0ce1mEBQL3j45pavBgdYCgaIRHZI
	zLY7/Vi4d6gpXq69zlRTK31B97+y0jc4AtfOm1cjZuzrc8BLDL8mCfk2ulgulivsyWQN48iQbQO
	uKT5czDQxtcLQqcFj7fQGoEESA0uGqEahjGfLGbJuy+C1KwooVZFjIPsX1zwLfqZ6uM3yKp8SmY
	JO7hScNB2niIWV17dgdMG+ArZKo//TsxTcqwj5xZNb0Dg139d3qNV9MTVNikDA==
X-Google-Smtp-Source: AGHT+IEw5mdv8FL358skMxjisWjCdC/BAuRG+DyLB91/bT3eZDVOOe8LXI3JZNkgSPKO2RFD6mg2Nw==
X-Received: by 2002:a05:6000:2810:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-3997f91d048mr7465614f8f.33.1742805491464;
        Mon, 24 Mar 2025 01:38:11 -0700 (PDT)
Received: from arrakis.kwizart.net (home.kwizart.net. [82.65.38.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3c2csm10078670f8f.46.2025.03.24.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:38:10 -0700 (PDT)
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
Subject: [PATCH 3/3] [RFC] drm/i915/gvt: change OPREGION_SIGNATURE name
Date: Mon, 24 Mar 2025 09:30:03 +0100
Message-ID: <20250324083755.12489-4-kwizart@gmail.com>
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

Change the OPREGION_SIGNATURE name so it fit into the
opregion_header->signature size.

Cc: stable@vger.kernel.org
Fixes: 93615d59912 ("Revert drm/i915/gvt: Fix out-of-bounds buffer write into opregion->signature[]")
Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 drivers/gpu/drm/i915/gvt/opregion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 0f11cd6ba383..0bd02dfaceb1 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -32,7 +32,7 @@
 #define _INTEL_BIOS_PRIVATE
 #include "display/intel_vbt_defs.h"
 
-#define OPREGION_SIGNATURE "IntelGraphicsMem"
+#define OPREGION_SIGNATURE "IntelGFXMem"
 #define MBOX_VBT      (1<<3)
 
 /* device handle */
-- 
2.49.0


