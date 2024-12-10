Return-Path: <stable+bounces-100488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C7B9EBB84
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 22:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F31188884D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED29B23026B;
	Tue, 10 Dec 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="xBgOB9aM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FC230266
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 21:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864850; cv=none; b=NA+/M2KzClMtaptaYCpMD9iah144xmT8aio4rZuBFxKAq8sQs1U0bA4SdjLTlD8o1Ok7m1SdubmGhHEzD94cdr9eWqgkQsfZgCCUmRlczY212pSkx1W+Hg4Rhr3yvm9WmdbZTC5YGzylTHd5izfJtm8p4ZWCJlXureXzx5wWf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864850; c=relaxed/simple;
	bh=COY5HHbKdrm0H8OeENYgIVCEUFMsYzZzE6RetVw24ds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pl5ICoKT+NNuF7Ew8DNiknzte2wQJv79Vk6/kjpRVysOEC/WeEV4lZdvwP8FRbghgTn7t7HGGFKrsZVK5szh/7d48Afp1hfh3c02xkMlLbbBwcAejqlQ5pXA9tCVA8+g0LI0UhDsMvhy+B4YeVowFEfBEdU9iBB9Ceb82nj2E1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=xBgOB9aM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3863703258fso17060f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1733864846; x=1734469646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wjd5mjZBM5SyentL5NMNTj/P2LLUi79WsmIwDcHfCU=;
        b=xBgOB9aMG70NMUqEMzVcWbLVaprZuHVDLlZbVF23B3YBWzQSjERsMEDtDsF6PSKPKO
         wDTYth7Fyil0tmtkfVHg1C9QX0id5D4/3zzubtvLcHZQ4vIHLmJ30X3VXi+V1oIxnMdI
         u43jUZmGoBfTUjuQACM03iKOZaaOWG09KLXG4nDoHKchSfCB7kwkrSTgM80THXCQtuTV
         RbrwcDY+y7o11YxbIUxtT6ibgu3RDF+TbYGH/9gqYFJ6FOekoTdWVv41TI/n91warErB
         ydc4XhalZVx0otdrsPdBRELTh3uoqXE1bM/xio/Hvrey/gHoOi9BXgaciUhussgOwqRS
         pxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864846; x=1734469646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wjd5mjZBM5SyentL5NMNTj/P2LLUi79WsmIwDcHfCU=;
        b=vjY2+t07KGfEaXdvM4OaPrwScUtaT8ogAJXKufAKkjHV4LPMoq6acvcVYlKvc5SG/d
         Oi1BTD0oaG/dtFx6mPZk9FDAhRS2cqfExeCzg8IjoK/iFKPotO6b6ckJ47jmBZWTKiJZ
         2jPUEgHn2syKbLghQ3W0uhPS7skOIdiZMZrO3ng9jDrhtj3aP6E79GPuW4hm0LWJLwCk
         IT/vKOVhRFcfMEXN5YHMH9WyGuDFzqJGWxBeNC5odR7hcEpTDCQtPutS54Wa7Z5a3TSu
         m8yXxbMirNkbwWwfKYVNN94xTAHWW4PeNh1L9gmX1Hnm4KJZoBYBHk9gvPTDR9kO9wOb
         BHuA==
X-Gm-Message-State: AOJu0YxF3ilboKcLdLEe8eE50NoGtgKDBnd/FA1pC7n9xkUPZ/ihUv7Q
	jgXpa/cKbmC1uilLz2/2xJZtqyXIU+J10SQGzK3jBmvyXhs4OKm3sXuQPgIu5bk=
X-Gm-Gg: ASbGncsV82ipWY8jkucqypvp4xAbk4aTHuYNu1Il+pnNAaCjirLpTSd6JY1wfC4+9jF
	l5SFG7BxL4hZBV7271iGNOKlutlN6OJOcMmo08sedNurjA1bnALqsLES56T+Cl/69G7YL8C/gXZ
	mutz8I48Tq8DtAdbVTljeOkh5A1Ji/LoV7M+dQK9PZzahCEfryMNttge4F7WNpfimW5pa2Vt7OJ
	V8gz8ValnE+fFYxoa3zOvwmTN2OC6jlHWt0NzfaLTChQZhGe0N08QBAXw==
X-Google-Smtp-Source: AGHT+IHdS0e17jsxd8vjeCbCZutDjf+qK6fOxkdw3PQIJs5DvZS1sIjOv17r7XZb2ktONtRt78MWgQ==
X-Received: by 2002:a5d:6da6:0:b0:385:fa26:f0b5 with SMTP id ffacd0b85a97d-3864dee4060mr119439f8f.20.1733864846276;
        Tue, 10 Dec 2024 13:07:26 -0800 (PST)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::319:ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386220b047dsm16793444f8f.100.2024.12.10.13.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:07:26 -0800 (PST)
From: Matt Fleming <matt@readmodwrite.com>
X-Google-Original-From: Matt Fleming <mfleming@cloudflare.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Sebastian Ott <sebott@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] net/mlx5: unique names for per device caches
Date: Tue, 10 Dec 2024 21:07:23 +0000
Message-Id: <20241210210723.3227571-1-mfleming@cloudflare.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Ott <sebott@redhat.com>

[ Upstream commit 25872a079bbbe952eb660249cc9f40fa75623e68 ]

Add the device name to the per device kmem_cache names to
ensure their uniqueness. This fixes warnings like this:
"kmem_cache of name 'mlx5_fs_fgs' already exists".

Fixes: 4c39529663b9 ("slab: Warn on duplicate cache names when DEBUG_VM=y")
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20241023134146.28448-1-sebott@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---

This backport only needs applying to 6.12.y.

I also added a Fixes tag that was missing from the upstream commit

 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 6e4f8aaf8d2f..2eabfcc247c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3698,6 +3698,7 @@ void mlx5_fs_core_free(struct mlx5_core_dev *dev)
 int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 {
 	struct mlx5_flow_steering *steering;
+	char name[80];
 	int err = 0;
 
 	err = mlx5_init_fc_stats(dev);
@@ -3722,10 +3723,12 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 	else
 		steering->mode = MLX5_FLOW_STEERING_MODE_DMFS;
 
-	steering->fgs_cache = kmem_cache_create("mlx5_fs_fgs",
+	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", dev_name(dev->device));
+	steering->fgs_cache = kmem_cache_create(name,
 						sizeof(struct mlx5_flow_group), 0,
 						0, NULL);
-	steering->ftes_cache = kmem_cache_create("mlx5_fs_ftes", sizeof(struct fs_fte), 0,
+	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", dev_name(dev->device));
+	steering->ftes_cache = kmem_cache_create(name, sizeof(struct fs_fte), 0,
 						 0, NULL);
 	if (!steering->ftes_cache || !steering->fgs_cache) {
 		err = -ENOMEM;
-- 
2.34.1


