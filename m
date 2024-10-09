Return-Path: <stable+bounces-83130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBBC995EAE
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA78CB20F2F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 04:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDC150997;
	Wed,  9 Oct 2024 04:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YrmLkbFD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99873C24
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728448928; cv=none; b=JbZaOWuaFoNhM4URyxc3sDSf3s0iS7bXuT31Ib1zGgVnb6pJ5Cww4xaLySV17AN3ZZgtP2koREYQRrTdN2IurPFujq9HTcqQFzTYKNi0SzTDdelI7NllN+s1v1EWY+vuBHK/6ZndbrcB2SIcZTIRKb73xMvFDrqCdp+EfnbFckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728448928; c=relaxed/simple;
	bh=a+rWlwIZkZ4+HfV9XaZWN7Ljm/6zFfoL2xZwab0F+VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJgFlil9JmsIIsEvXdG3dM8w9SPdNR3J3++WrVU516F6u8fqniuGunbTAHgvwihtu3Lav6pqESRJz5Lo0prfMECwfVdqPrbuDsIAluPuKTa0Cu2uCIEaQdVuKtGG2m8Hpv2KEViy0jYWvuty5NO4MoU7d6MKB9O59NMgzeTMKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YrmLkbFD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db54269325so5257650a12.2
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 21:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728448926; x=1729053726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIzTrp2ittgndngjDwtNUg0nqs0QuTiv6Z4V9JopCuU=;
        b=YrmLkbFDXt+fw22zRCXzoB+3Hn3eAl6nsfoqdcHgQf889x63DrNEGby1idVkiZaUDN
         niACClO89ljZR0Sj7MfB+2vrb20A1Uqaw6G4UtV/Abx0jBZJwlf1U14o+lJzRf5yNAen
         no+DffcL1CD5R0G3mhHBfICFX05tWfS5odq/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728448926; x=1729053726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIzTrp2ittgndngjDwtNUg0nqs0QuTiv6Z4V9JopCuU=;
        b=hkIhAnTXoGfcDneiZGs53C3kAvbqasrtmm+RaJUdJD7v2SBTMJyhcVxpN36Vkk6R2S
         xwG87MMv8jLtnlZ8GQzrVwmu82TxL+Ldzs5gzuIW9KCJB8jqUbNk3Rbx1VV6c1CbDmvI
         tkQZ+gmo0X67EcCdolYvb710ZW+qWw6ErsiXrAdYUgZaBhNdjUOxHFF6GlLAy6weM3Bh
         iE/H77hWCAHdhRdoeyJTiRppXAwTSZUb9ne6QE/PwEiviDbzdVcvHvhNzsxZUxg46OWv
         9ojjpkWB1tdSSUeK6WCenoQxjdR6nuA7vfYzepEqL2awLmhnW6GNggc4tQaLPV21HSFY
         X0GQ==
X-Gm-Message-State: AOJu0YyuI8ivw7J8F6US7S6UkIKTsi5icB7POsPhhPIUemuHXs6i3919
	oR1+G0yOL53Tg6F2oVeduwT+xBAOc9JY3nBpWWj01QeHqwSvg/ZO6Gp6EujR1ohofdiI8x0iRrx
	9jA==
X-Google-Smtp-Source: AGHT+IFlrXCpRkPuibo1tabjYUt2ThR6KcxSiFCk+s6E6ee/+vMKY1SwxMYRG4jQk4HhzYIPWqiYfg==
X-Received: by 2002:a05:6a21:6f83:b0:1d7:31b8:b8f6 with SMTP id adf61e73a8af0-1d8a3c5e4c5mr1962504637.33.1728448925767;
        Tue, 08 Oct 2024 21:42:05 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c37515sm6517801a12.75.2024.10.08.21.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:42:05 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.10.y 1/2] zram: free secondary algorithms names
Date: Wed,  9 Oct 2024 13:41:56 +0900
Message-ID: <20241009044157.784907-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <2024100723-covenant-chef-b766@gregkh>
References: <2024100723-covenant-chef-b766@gregkh>
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
index 3acd7006ad2c..f66c03ebba74 100644
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


