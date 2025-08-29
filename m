Return-Path: <stable+bounces-176704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBFAB3BAD7
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 14:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEB61894AB7
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35461313E35;
	Fri, 29 Aug 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNR/0UFc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FF229B1F;
	Fri, 29 Aug 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469340; cv=none; b=jHurU5W4fZD+BEPPGe5VqCkV9synfpY9Ap+qgW05qxarJKkQYquU2kyTqDANOLYPKIROZAOvW4WX9pSCpEK+QE/gbGoChrUxVEhzNoPkMyNNNlMwjkl5hIJoMNG0seLok2TgIXIA4wyArfvL2uxi0t5pAeLKBspA5P9ZPDxnwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469340; c=relaxed/simple;
	bh=X7Qp7FxOg1y6PkSZpFUYEzQiBPHiZ8aKkiR6aS9pUNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pa605L83S3QGohHmeGyoi2R7Y3MU3W8k/q8AuswbaRU88RGxw/VJoXJ3mxAGctmOBSAez7V+a6aM+6ESq7oQ8KqMbmhB3w5GdsSd/dYEsH1WsCMg3PO9WXUlRt2mEgUI6IC7uNiSUuKcZFqQ5lXYD+tu4cXAHlEwM8jZRvyoedY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNR/0UFc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77201f3d389so2159182b3a.2;
        Fri, 29 Aug 2025 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756469338; x=1757074138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssij9SY5ZHsEeenXlxMWFiz5iGlvdpqLAMZCmsyuD7w=;
        b=VNR/0UFcDZYzbRiyXM3sHNrOGTafDZToeRbrRbFHTw3GwSTxxpssmUO/88nU6uNOYI
         tPckSWtXH2/Ia7u5pqKL1vUcDlnYjERR4wgwLYr4yb8WOp2G9VXO+O8sffcb/C9a8zKY
         F6DGpzdmvn1czihzcmU0YdMiKzb+Qf2/f8FbYGYKuBBs1oScPYq6EPii0w1rOh+BhXcT
         DHEmXvA59KxNT44mgbsv4ylrVEMAPokmymF5ry4o1Yu88YuppqQV6LAmjX8/t2jVYjSB
         yd81JcpNw5ElxGo95kU2jQjRD1PJHIYyegeAwAh6LqTTD4RPPLiAURp7+111GjJVyfyK
         X37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756469338; x=1757074138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssij9SY5ZHsEeenXlxMWFiz5iGlvdpqLAMZCmsyuD7w=;
        b=NZDpwlo/ig2yjXuz2ao7UpoN5E4c0DqbkqcnPuQqq6dpXCV2THK0cfLpOGP0aacnKR
         I8s+zLf5QJy9IfH/xfGb5jqMZdsQapuzKv1QAQ6ExLlYR7iFwB2W9v5mptX48PP3w2iD
         bO7CsOqDVflEai8SM6JcoO0CmNK/81i9jX+lP1VsLgBlonSzTVZsyaRT3Map+a/Z+wa5
         jxapFmeuLKCfjhdFLIeXz1rfWnI6IhDDMY7iq4Te8FHNIrcIgVBy25uN7gH/4PNB7kXG
         Jt3wHmCH+u8mmJXOAxaq5Pzil14QT0rBHo18fBFdbI5FTCt05B54+KqITJPHpJnLgC/B
         iUnw==
X-Forwarded-Encrypted: i=1; AJvYcCUtjj6tZ+ytmd5zZ41pHl7/Hsy1QCBDqcf8Gyisu5PIRc5u8x1vYsISvwAIlro7kU75a5rzv5wSzoD4W9Y=@vger.kernel.org, AJvYcCWligREsaBNNqxyMNtwhBnOYKrETEpaBCY+d91Vdz+EiWpmy0zeweJJFsfzTFTQ53hTOgIaxtAR@vger.kernel.org
X-Gm-Message-State: AOJu0YzonywD02hmOZZB/s/CFM3kvfoo6uY/vqGd3VEQ9yWntV8/AsSl
	amxLF1SmUo/xKOJdE+crtLVlFp+9i4vWsUplT8Vz1z3zs42F/mI3cowo
X-Gm-Gg: ASbGncvSDhWfjX2Lzwa+p36Y/UmClZv50pgTqhS0ZAsVd9syZaPC1zMqbW4nGwPh2Hl
	zFwqTsO0a+ZJr3zlmu6ohdHrKf3au7iUxrAZPjTOHJ/BsDYQgmsO2FqGKg9KQeRePHBLFDm466r
	cA4a5upTMdXI8PZZglJWciFH6GyiZoQvKuNSLJj3bN2VYxUzpO9sfejS3U2pFY4gehKSOveaMfv
	FhW0+WxGjnkB48bg8Dc3GZhZ6qbvwFZaKCd2ZyGpdPJ33uS3XpX1kiSsNOOGj0tMIBkjFqM3cfF
	XBpGOLJvf4E1dvpDXgiylNUmiBiIkjrbs1TFzbzjeLsDbIm4wVSV+TTH1UsDaV7cX4xYnGg6USr
	sEFbpCOPbQVZAiFzbztZbhEP5bSCsoIWBgUw5JLTftmoPp9FMKOldHEUoINym4TKyTfbTf+iy5e
	zo7O8D0uIX8/eR3l60Nfl4LhbOfc9SwmYrNJbnpTpV06TNxzKDjfgWZxwP
X-Google-Smtp-Source: AGHT+IHbYa9s53mJukTIQKYLvNji7ERSt0sQ7BQvGh8tc2UnWpHzLZYJA4mp+CXJze8S58TN6eDCnQ==
X-Received: by 2002:a05:6a21:8906:b0:243:be7c:2d63 with SMTP id adf61e73a8af0-243be7c35f8mr4973218637.42.1756469337730;
        Fri, 29 Aug 2025 05:08:57 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4cd28aecd0sm2056031a12.30.2025.08.29.05.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:08:57 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] coresight: trbe: Fix incorrect error check for devm_kzalloc
Date: Fri, 29 Aug 2025 20:08:47 +0800
Message-Id: <20250829120847.2016087-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect use of IS_ERR() to check devm_kzalloc() return value.
devm_kzalloc() returns NULL on failure, not an error pointer.

This issue was introduced by commit 4277f035d227
("coresight: trbe: Add a representative coresight_platform_data for TRBE")
which replaced the original function but didn't update the error check.

Fixes: 4277f035d227 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 8267dd1a2130..caf873adfc3a 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1279,7 +1279,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 	 * into the device for that purpose.
 	 */
 	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
-	if (IS_ERR(desc.pdata))
+	if (!desc.pdata)
 		goto cpu_clear;
 
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
-- 
2.35.1


