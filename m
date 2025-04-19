Return-Path: <stable+bounces-134668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4731EA940E4
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 03:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB0846101F
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB3824A3;
	Sat, 19 Apr 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLQC8NGy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB852CCDB;
	Sat, 19 Apr 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745026262; cv=none; b=dhBUWtMMqeido0v7Qr8NrFQ/oXvzcS3x9RIzlDsZWHPxsL05AAcLoA9qecOXKiNuCQiYwpE/yScAcrln95R89Gv1tgZmdFfdyT4R3N1bmU2TvE7pYnUaUtSYMaBGnIFMxvYAf6DaQ3AjcsDYnlJHae7V8h5jbK7py+7ILUvh/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745026262; c=relaxed/simple;
	bh=h1I7azrs9dgpknSH+P+IhNbPLmtlQBazARRV3ngykeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JaQhHuVQUi7dOpg7GFFhCQsjMOxdKPUa5kt9GyYeNS1dIy8vvdkwBlRrIP7iUBAr5gloRBKi0ZdZpZ4lq9Tf6qLXHQIupOGZb2xlMqqMi8FML/8fgSBRvWPYR1pipR7GCSVBCrwLzTbYEBKrktPuhvNg36GV/DVzS5Jb188H5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLQC8NGy; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecf0e07954so34018896d6.1;
        Fri, 18 Apr 2025 18:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745026260; x=1745631060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWCtJ50FKxjfzSVOv6So7GDOtXW1AyTUmdzzwtUL1F4=;
        b=GLQC8NGylaCfazuoAtW2WciQiwwURW3PbJUrDE7C25uNk38KJcdpQaB+GxNUX9q5bn
         +d3fFwmIt2/C9jX2RVuFyhx+CfFICxOqqHV+2QhZhxGX/7CSbjAC0Q9oi+Zz2qfVQbMG
         Wqx/IPdL0uPi8LsWmgJA7ATIH32NSMhE3SH5V8aHgaYUEibqmYEEtXPiRE7E/tGsSB/7
         Xk/YpA+LtuplCHLhZXbYR2pVpZe6TTLjwkMZsE9YrCozg37iV2EVJRqozk7zeg1JVhk5
         w544nFS3IKtrEQgFILT9VrZ2EUpeHkapqMA+w0C6IjKxCYlKPx2jExjWIGRHBoyV06a6
         4MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745026260; x=1745631060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWCtJ50FKxjfzSVOv6So7GDOtXW1AyTUmdzzwtUL1F4=;
        b=EoW+T3XVwq7MPgCia+ZcC+aRuPCL5v7PFkd3RL6y2tiS+Jy7O9hUlhjwmIHXn1T7fX
         o61WzZ9bxgr3YZmlQrp369fJZ1fsbEyBRL6Bqn8YMnNx1jVXFWUdgZt5RaqHHJ2b0AKh
         ARvaif8qjvmO4fo3gVEBWmVIzSfqvHg9+xit4WFX5qdP4Wxj7CZMnaEMpm+p08t9O4xy
         3yTYe0+RtGeU92BDvtKWaJ+3Wb69Y79Bj2fDKeSfrT5iuGRYuyqpA78Y9aBJONyb996u
         Qre4BZ6jSqOsClyJVWPipIdRsjKiEbyyj+aZtLUEg/spii+xH5SymTyS5Nh+F8aJ6jxD
         qicQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVFbD56kv2xyYOzQ6glPkUbbMWxPMCsaHi+n57JkJa/og8vDYRYTk0UAcsfc1yvlIqlA6EYVID3Dc9cA0=@vger.kernel.org, AJvYcCV0yzYIZcxwSq1KdtFBE8VLLPs+czLSLkp8SMuQ0hBj6cbNMWexMszEv1vi9VuNjVoSPyJJa24P@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQJZNvbeXj3lhKye3dQVhMVIK/Y0Iw5lIviubqHO7ENnXwfH4
	h2yrEQkUcKDLo/X5NksWVmrqaDc/D/RkFQ4fA8WBQiMrDDt6Bdyu
X-Gm-Gg: ASbGncs3qPGw00z1ciuLXqLcA05RRLn/3tX34MhI5DjeIqG/pARAD/a+n4F8efROqV5
	48hIb70WxeJEoV/VoNNqAUSFS719+ZFUaiTztKxbp49JM3jEVGxN3qj5EMizTrBLfxgA3fNdo10
	gZaaHCuKEY4Qz3DL3mrE3l2ifyf6xlm/0sRo5SV7p1kGlexZuG/YVuczRSIQ/LgI45cdiv73eZp
	+M+QOd4vbRo+FBm6ZAoE442iRh7PbMP77z5X6+v/yc2kNNmSIzcYQzpxv7YlLMqEHbeSorfOEuU
	XdC4p3qBSbd8pM7HTfTuqU9o0HvNCiahZYzA3rz6RNMrCyqcclFLTuw=
X-Google-Smtp-Source: AGHT+IH2dNoQ71LMwjqMyD04yE+yHrJLLk5w9rj2a4E+sh5ENZAdgWvNcZAqjqEj/zzrNb4XcWw+Iw==
X-Received: by 2002:a05:6214:c88:b0:6ed:1659:76b0 with SMTP id 6a1803df08f44-6f2c456cd92mr69394846d6.20.1745026259950;
        Fri, 18 Apr 2025 18:30:59 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af14b9sm16649266d6.21.2025.04.18.18.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 18:30:59 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	gshahrouzi@gmail.com,
	jacobsfeder@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	sergio.paracuellos@gmail.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: Correct handling of tx_fifo_depth for size validation
Date: Fri, 18 Apr 2025 21:29:37 -0400
Message-ID: <20250419012937.674924-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove erroneous subtraction of 4 from the total FIFO depth read from
device tree. The stored depth is for checking against total capacity,
not initial vacancy. This prevented writes near the FIFO's full size.

The check performed just before data transfer, which uses live reads of
the TDFV register to determine current vacancy, correctly handles the
initial Depth - 4 hardware state and subsequent FIFO fullness.

Fixes: 4a965c5f89de ("staging: add driver for Xilinx AXI-Stream FIFO v4.1 IP core")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 76db29e4d2828..351f983ef9149 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -770,9 +770,6 @@ static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 		goto end;
 	}
 
-	/* IP sets TDFV to fifo depth - 4 so we will do the same */
-	fifo->tx_fifo_depth -= 4;
-
 	ret = get_dts_property(fifo, "xlnx,use-rx-data", &fifo->has_rx_fifo);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,use-rx-data property\n");
-- 
2.43.0


