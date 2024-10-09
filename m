Return-Path: <stable+bounces-83132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C730995EB4
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2086B21920
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A65143748;
	Wed,  9 Oct 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cZr2MeAQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56AD38DD3
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728449207; cv=none; b=aIv2VTogHq8Vx5iElt3KzJOa/hrL47I3AoUmoRs9CZhOlsOJ2bg2sH8y9bY3b2BA+O5NXXMAg0wDiL/jOW3Ny0u3oEZ/mc0Z6rhEVTdTqQy3GrqbZOsWwbnLrsIJt7AqZLQMxJf6l51IYqN7MU1ZTJbInFpqYQ0BrgKDaOJ+NSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728449207; c=relaxed/simple;
	bh=lQsLuLFWijCFhhZxVqsqNdoAQrmOcpUDOZI1iHXNbXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy5d4lJ1z/WgDfB1gXeB3ypGm+oqyp4Xglaf//EJeaMSmyLSXs3LnoaQm3I2MR8G11N6tUfEuLYX1joC4s8jPn8UoxOaZHwZp7AbvHa0l6PtLuBuEKyuCpbhblVbQp5uyvdVqa9YZlQ5G/hhTh6h4EXMO2/hL2f5Z2DH8Sx77vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cZr2MeAQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e27f9d2354so1278831a91.0
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 21:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728449205; x=1729054005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ubh09Xh/XUoLAn95MjKYBJM4Qvd6ehJts1LkDoI2UiM=;
        b=cZr2MeAQRaDVpv6lGUz7bYjCgIeh/1wo3HMFzgzmdXdp1unSRJLJev4IXMHKGRLoxq
         DSSwf2GjsRPuGw/0HrHyosSM+Uviveq+qfP77kPM3q5nczVTOGmX8wAgquYb9oRCFHpd
         HwiVZfNtNFZOvaN2g1+AEqXSLe8sM374XpNU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728449205; x=1729054005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ubh09Xh/XUoLAn95MjKYBJM4Qvd6ehJts1LkDoI2UiM=;
        b=vSmlqTYt+Ne2xTvexIS6nL1WSPeb4SJtosoh3H4j5Oo0NGie6k/1U3dWwCoHZ2/OuU
         In59OdawNkMqdH4NwPwak66rgVr/tNcjfYW6S41ZPs4pPFEh+zpjo4VYXctG9m2POTMY
         DVpeYmWv75bPCM7XkHH0GIywCy8h9Lf1Wl3BTcaB+wkgnPZ4UwzPuX9YSPwnZeurN4oU
         WQZbrphOwXhkuri5tQyRkH2e8h5jqWKejbXGU8aWq477uI6G5OeOb8YUhecku03LlKo9
         Np3c/4kR+O8AWSq22NpfQkvWV6GEqerECxC1/27lGlqaG0hWS/0tH/z+Qn5kogOme03w
         jLWg==
X-Gm-Message-State: AOJu0YzUddBXxkkH0oNWomu2Nr8UYP4bVIVgb2ZpxNFio8wzOgMMrlcO
	Drvehk6N+1s5PrHzWAwPbpAg2E2Y9px3lz1Qo+Emy+xeO4mOvuk+U948BG/YH1dm1lZgVbXLQeV
	NJw==
X-Google-Smtp-Source: AGHT+IFSVGHBu9IEW2WYY191yh8vb/F4/NK6TOyY0ekC2WXT0rPJG9XGRLn8u3C0Ws+fF7gZVrM8Jg==
X-Received: by 2002:a17:90a:c083:b0:2e0:74c9:ecf1 with SMTP id 98e67ed59e1d1-2e2a232c3f3mr1623212a91.10.1728449204990;
        Tue, 08 Oct 2024 21:46:44 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5aaad8bsm529187a91.38.2024.10.08.21.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:46:44 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.11.y 1/2] zram: free secondary algorithms names
Date: Wed,  9 Oct 2024 13:46:38 +0900
Message-ID: <20241009044639.812634-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <2024100723-syndrome-yeast-a812@gregkh>
References: <2024100723-syndrome-yeast-a812@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to kfree() secondary algorithms names when reset zram device that
had multi-streams, otherwise we leak memory.

[senozhatsky@chromium.org: kfree(NULL) is legal]
  Link: https://lkml.kernel.org/r/20240917013021.868769-1-senozhatsky@chromium.org
Link: https://lkml.kernel.org/r/20240911025600.3681789-1-senozhatsky@chromium.org
Fixes: 001d92735701 ("zram: add recompression algorithm sysfs knob")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 684826f8271ad97580b138b9ffd462005e470b99)
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index efcb8d9d274c..1a875ac43d56 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1989,6 +1989,11 @@ static void zram_destroy_comps(struct zram *zram)
 		zcomp_destroy(comp);
 		zram->num_active_comps--;
 	}
+
+	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+		kfree(zram->comp_algs[prio]);
+		zram->comp_algs[prio] = NULL;
+	}
 }
 
 static void zram_reset_device(struct zram *zram)
-- 
2.47.0.rc0.187.ge670bccf7e-goog


