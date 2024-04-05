Return-Path: <stable+bounces-36122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666AC89A09F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C7D1C237B3
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722016F8E3;
	Fri,  5 Apr 2024 15:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JwDdb8Me"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA116F27B
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329398; cv=none; b=hJop80bT8tgVPjTjtZtpyoeBmrAKAkWS/UAVx5nJqGcS1htw51EuH7TczjJ17K4RCsJ6E1F9j3IGWPiQEBtu6k9B3RHy27Fr0Wrewh35+skuod+p5pqrq17Tt11JUj2kKhIs4PZWkc+PdQ9s5NQWyTw3M8V5v3vxwnVn9mtHdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329398; c=relaxed/simple;
	bh=elpgrkgYkYB2F+aWdNFZOfsIVYqRpMqvDKWw6OHEzEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L1XaBbOTBKGVH/T8nnR/pWPRR8cFPRsrVvdtCNuxhTEPu7vwxzlfZkIA7HfKOoIYEkhW7odvPemPU78lMCX+rbkDI6EctoCLOu1cnJ7N0jGdpWMF9wi7N73SQy40NhhPLUOazObtVL0OOmDDp3BvKb9EUbE2Opgh4hcCmgN/5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JwDdb8Me; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e2bfac15c2so13523845ad.0
        for <stable@vger.kernel.org>; Fri, 05 Apr 2024 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712329396; x=1712934196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DS0VVZvbIZOzvgJdpngFNsbKnS413GQYGLPC1MauL3k=;
        b=JwDdb8Me7pm2ijCSZN4wWvLB5ve5xV8pYINi5HidJ9nRKHmrdMaWVlgh9XjtPsmXkF
         Wlejz3GZYsaV3JJXxIHGi0zHQdSjgwyLyXyDGFfnNQWoc4FrtsvFwk4AOwRiAkC546NM
         Zu2N0pzLJzWewDnuz0Te40vxQ67+TJxuKQEaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329396; x=1712934196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DS0VVZvbIZOzvgJdpngFNsbKnS413GQYGLPC1MauL3k=;
        b=sepM1FnAt6S3nXwbsxczBfu/KYLViTNPSGsHRdKr2a5dsDiw2LW0nWFGMZkxa4L2AI
         ag+2MVzh/B440iOeRxmAA8PVqRCvJSoNyxF986+Lgen7dUa31NP11Qlz62U3bZBpX00Q
         Nq5Qcgv03R9YTMClGxrapS15V6f1/tCFg/CbavJ7TOOKp8gSjyZYju8jt8F59uAoCrkq
         HcP96B8+ZCPap+/BVI804CmTgkoZqQzlFz6O3z9MfWxioobpYS5Zm+HqQcyKx11OgjWH
         RjCAM2FOifVHvzoiFVaD+j4lOqG7fdVh1BAlyMP5REnlWjgGlWq0VueJGvTlqv/oZThF
         JU8w==
X-Forwarded-Encrypted: i=1; AJvYcCVQCa8mM7KPsN4y8ZiaDGMG2oodtxiVW5UWKJP4Pj5UIkQcFDbLjzE47mlzC/tikZvd+7W691Y7CPQqniaSCzd+0yM23TIy
X-Gm-Message-State: AOJu0YyXEtDBwWA7fJ/kk1Xna8njaeUbb1MalBP6k0ASYcI4CR9CnwjU
	g4LEb/1X5UyHjeR266EWJdKmaDImXgZGxyTYLhz51fgxsHSl0N23cdsmOtdeVA==
X-Google-Smtp-Source: AGHT+IEm1RWL5J3li8ZFIxACZ9U9J1josIzuaLBcG7JV6BAY3xX+NEe5ik8qvLJPXlpPs+7xjqv2Gg==
X-Received: by 2002:a17:902:f706:b0:1e3:c32c:a0fe with SMTP id h6-20020a170902f70600b001e3c32ca0femr2137102plo.36.1712329396490;
        Fri, 05 Apr 2024 08:03:16 -0700 (PDT)
Received: from localhost (99-151-34-247.lightspeed.austtx.sbcglobal.net. [99.151.34.247])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001e219142f18sm1189888plg.114.2024.04.05.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:03:16 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	zack.rusin@broadcom.com,
	martin.krastev@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Ian Forbes <ian.forbes@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/vmwgfx: Don't memcmp equivalent pointers
Date: Fri,  5 Apr 2024 10:02:45 -0500
Message-Id: <20240405150245.1797-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328190716.27367-1-ian.forbes@broadcom.com>
References: <20240328190716.27367-1-ian.forbes@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These pointers are frequently the same and memcmp does not compare the
pointers before comparing their contents so this was wasting cycles
comparing 16 KiB of memory which will always be equal.

Fixes: bb6780aa5a1d ("drm/vmwgfx: Diff cursors when using cmds")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Cc: <stable@vger.kernel.org> # v6.2+
---
v2: Fix code and commit message formatting.
--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index cd4925346ed4..ef0af10c4968 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -216,7 +216,7 @@ static bool vmw_du_cursor_plane_has_changed(struct vmw_plane_state *old_vps,
 	new_image = vmw_du_cursor_plane_acquire_image(new_vps);
 
 	changed = false;
-	if (old_image && new_image)
+	if (old_image && new_image && old_image != new_image)
 		changed = memcmp(old_image, new_image, size) != 0;
 
 	return changed;
-- 
2.34.1


