Return-Path: <stable+bounces-92205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38999C5042
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 09:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669EBB2C694
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA320B21D;
	Tue, 12 Nov 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFEEiQrB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDE1A726D;
	Tue, 12 Nov 2024 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398044; cv=none; b=T11CIHzYRMIpcVZRzGDnfBvttzHkKVuMII3HfEjxa/hwSuxiRNW2xe4upoeEonlAIZ6Tx2iA6/eBBwyy+3wFHqOOFCifeCL7XJbfItcz7f/qQlDkwPehbFRmePowlCzeZb2i1Y0ZvRciydHigQe4chI4HzsCLIJjKQsas+ehucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398044; c=relaxed/simple;
	bh=FsexyE56mHGsJare4t64T2PH3naAM01ZKetwFqsQThI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ghvwh3xJ9mr3Ycn6WVZSFqq2zZBf+HHJNUKTBJrQKwlbKbLg6dKS7BbE5RgoCTqFRBwnoLbH3k62L0bgOxU87wKhosSqstf2+Gj3zpjrmiOXjMHqZP4gMChuuS0Xz1bfHiXuZc00cLNxAZj1GZ+lcgjxyFYVWV0dO0SDvc+y6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFEEiQrB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c805a0753so51116195ad.0;
        Mon, 11 Nov 2024 23:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731398043; x=1732002843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuWrfgsQNTJ716oVrGfZpRhEFToaTIMrYD6gaLXxeaM=;
        b=CFEEiQrBJdxVNoOUDhgYsLQc7V2uq2U3D9aeHbzAQtdeZCABGS7mZ7fasL4zhQCBk2
         ZnBvIzaQ9RICgnMCaw6WrtFK1aY2miLWrNN1sNA1giUqeOJjEpTohBPhskw64pQqsErN
         4GkHckkQP8qJLuyzXPYnXHJRGeuYq4VBdc45/dlagXEKNvrn34KOtnTotu1SEOsEaAwE
         19KqO1YvS+FmwOwh4s/P+Xy6krDu4rYH4OUeCnkZaOaQHZGOQBmX8AFAWJ8had6FM4w5
         f+nzTHmyFZim0O5458895ZO8jgOUPtG+2/6m8WzLU8DZWSFS8/6rBN3NYkgprse9qFLc
         5bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731398043; x=1732002843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuWrfgsQNTJ716oVrGfZpRhEFToaTIMrYD6gaLXxeaM=;
        b=nh0irI42UYMVT9h0BXbVf8loqdOTRoLwGxFIdzGaETQwlv97TbAFxaqd+ep6yAp5mo
         U0w2MWdzJXaiTw+w6ITy3i6rxk+QoJbg6L6h/SSJhP3QOOJBmkV8POQPyJSo8LR7b9xy
         I/7WU0y+mSkxStG7SrXwbH5Z73Iyb1VoimF3XvNXd7uIAbH9FBffUmwcrXviLWWZ9asr
         FD0jdxuZsf0kXi+5MdZdDAqiDzpDVKup5DP1XZMJDfZBf5fqtEef+owQSSvstZ6nNupQ
         UuUrHjswptOqI3cUPg6ObHgwcKnPNoqpliMZPXdlGomQGbQ5lTFgNo/faeJ/EH0i6YVq
         YurQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVQNPZ+9TjmSuPoxCES4shAY1Viwc7XuGKjhKYDn2gQFckaTaFPK/T08sp2yoSJCYqMH9xikgW@vger.kernel.org, AJvYcCXrzSrVIBNvS5AUxHWxzGLErnKg/t0YBZALXSdWtd9T7bYqxKE3uUjGIUUSKl0TW1U4YXrOCw3i6EC85TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGX2Sj3G+/5RvZBy4mTbYyOcxQTFgDJVk5IK7+eIeoev19UGiv
	omI8gz2j29UG154JTmsBrOIPyndgOT8447ebmLDiGjo/mOekL7HP
X-Google-Smtp-Source: AGHT+IHPcZFOF0VLKgPkcEkYLMgH2BDqOjgsATgTZyQxwWDBFqv9hjd6OidpQsZvBIsz52G33B8qGQ==
X-Received: by 2002:a17:902:dacf:b0:20c:c01d:54a8 with SMTP id d9443c01a7336-21183d1b658mr217602935ad.16.1731398042766;
        Mon, 11 Nov 2024 23:54:02 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6c137sm87719485ad.249.2024.11.11.23.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 23:54:02 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 16A89802EC;
	Tue, 12 Nov 2024 16:00:31 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] mtd: spi-nor: core: replace dummy buswidth from addr to data
Date: Tue, 12 Nov 2024 15:52:42 +0800
Message-Id: <20241112075242.174010-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241112075242.174010-1-linchengming884@gmail.com>
References: <20241112075242.174010-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

The default dummy cycle for Macronix SPI NOR flash in Octal Output
Read Mode(1-1-8) is 20.

Currently, the dummy buswidth is set according to the address bus width.
In the 1-1-8 mode, this means the dummy buswidth is 1. When converting
dummy cycles to bytes, this results in 20 x 1 / 8 = 2 bytes, causing the
host to read data 4 cycles too early.

Since the protocol data buswidth is always greater than or equal to the
address buswidth. Setting the dummy buswidth to match the data buswidth
increases the likelihood that the dummy cycle-to-byte conversion will be
divisible, preventing the host from reading data prematurely.

Fixes: 0e30f47232ab5 ("mtd: spi-nor: add support for DTR protocol")
Cc: stable@vger.kernel.org
Reviewd-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f9c189ed7353..c7aceaa8a43f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -89,7 +89,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->dummy.nbytes)
-		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+		op->dummy.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
 	if (op->data.nbytes)
 		op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
-- 
2.25.1


