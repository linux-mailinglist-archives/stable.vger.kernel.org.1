Return-Path: <stable+bounces-189941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64117C0C6DF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 09:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35DF94F31FE
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1E2F3632;
	Mon, 27 Oct 2025 08:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etBaUrra"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642662ED844
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554639; cv=none; b=bpHoDOvZzdUJsrt6D0ppY6DXN0PnSN+gRLQS0T2W7tdfqrR0aNTOMtyMJaUqHRD7zh1SAoWu1lRLyd2AWbRYKJkmr7MpdrMXPoRBDGQZ0ym+gEUFdBkpU7f4ZUFYXrLARu+AHg2vZMIFeeOtZ9IslJAcocO7FrJjuG6ghrudAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554639; c=relaxed/simple;
	bh=6GhP5nzTlCJfW037vP9XgllmDGxPVLYMDiLoDoeZNf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DqADf00f8Qbv17pDV8T1Gk+Hw3SHAoN31KIrCISq2mcPpwAOs2ZcHIyP91gId96brfp6IF7g8JPFmfmKejx90SXE8Ya2PvW6tn9d6rd0zcu54qxMtgrdXqS16LYbgkhD5PWq9e2KnZc8aqNEur+J4CngC5P8+gOGPccm7Eucq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etBaUrra; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so3183789a12.0
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554636; x=1762159436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XdBHtrgp03ghVnsbwdnfe2LK03D2az8OLXtLHgvnDs=;
        b=etBaUrral7HiRlkJR5xaCp3MNIXyZm0xW2f6n99fj0EjBEICuBayIANI1njiuZgH3J
         MIkNOYCgvHo8FqzquFQ8dMygzlTiohEzoGRM/64fb+dj2XdVyKj5d16NKCWpWHOw0n7O
         lNI8DOrgVGAQjMP1JPDB5qQ7S6uMo1GQEYC7MYrFVe0YM5TCuCPhEzTjuR6n+Klle5tB
         Wib4R7WXeJRiPtw0Mc32FYsEputC4mB/WT8GzIFvzMNdgxCXKPPrOA4bqy/csF1vScOf
         c1stI8wv//WN0snEiNTTguzLBmvkor+9Vh7a/H1xfkXZrNNOaaPSp2lRzziPH2/1ctgQ
         QIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554636; x=1762159436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XdBHtrgp03ghVnsbwdnfe2LK03D2az8OLXtLHgvnDs=;
        b=K97YovvBr4H7B2OhcnVu65kgoyKo94o9o0mkVoLlUvKzSpojVQSmKBYTXRqwBSx1SD
         lV/MeFkFA3boMPa/NAk4CKNzxrdlmQCrGPr/Z0XiOohan/VjXZFe3U8gAuri5LnGvCTp
         kgWkvN9wQ4+NqTTR4HiYKYpgR/c3cDsNLUcDa7VSMztnNVzQR+0vRuQ6UkkgrTDrGLmT
         DGJxk/0DoLNCDXYT08eDu/ebFF7HK3n3hnRyMCSkeLyukTALU2K4vs20Avtr5r1Kf4e8
         I9Upm6VDpDbhtQOWwMDN4c8iRt+rWd3Nt1wm8Ry41HIFlNl8oOiupw61E1tu+3uq8Z1r
         QvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi2rvU/X/znpBJ8QksI73HPJhhl864AELMtuZaAOgD5dVAkTp5elU0T1pZcNCCgmKxX00sd/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50nOJYWwD/YKKTGWJZAUU+pSu3XMvmyf73OoriYuHc0qiJ+tx
	MT+wsNmSX45LD3otZu2Ug5eO6KO+3qVDo1EX+Mkt7AGGK50HKnNSmSFC
X-Gm-Gg: ASbGncu60YkBF2Ye+tOwxYiGVrQ/FNiJiERh3s1Busq2E9g+liRxfvW3tnBVP25vzUo
	IrSz6odxuVYwtg9AFMfOgp8P5soWUvDgHUljhTinTxBqavb+evwfiUSaOrxleFIhYYK3pvF+lY4
	UHPX8H2Bk1aXt26z3x25RPx/VLgFkCrb94LEJvawCtXPvhL9FSEtm5Zr97CskMDyQzatuaDRn+Y
	QUpndWShNLvUinhMud+YSk+81AeQ7fYCHc1qDFoEmZwcDQrw2cgRvH3wJYzf10T2H2F1/bNGloA
	xaddWx5kaGWdRuLVmPEj0J5mF5zL+LzXwvB4ncsJP60rCH+5ALGunQN7nMxDyD2TmiY/uKqf8V8
	GS2gw0veOJSPx61yfGvzqy/f4ZRVPOjCim/7VyDB/Rj3NkHaVfnbi8KFmmMY7ra7xDG8llSXXa9
	+wnpyLuynn//PhgQDLUavqdUXwoOQvmStT
X-Google-Smtp-Source: AGHT+IHJsL6+kpoPk8x1PWb0mqg3iHOZS6wR/zv/DBqOZ8GMqq9D0VqdZrEygNgekK2sc9hwLF1zkA==
X-Received: by 2002:a17:902:c952:b0:290:a3ba:1a8b with SMTP id d9443c01a7336-29465525229mr183633555ad.24.1761554636181;
        Mon, 27 Oct 2025 01:43:56 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e4349fsm73037945ad.107.2025.10.27.01.43.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 01:43:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Paul Mackerras <paulus@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] video: valkyriefb: Fix reference count leak in valkyriefb_init
Date: Mon, 27 Oct 2025 16:43:37 +0800
Message-Id: <20251027084340.79419-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_find_node_by_name() function returns a device tree node with its
reference count incremented. The caller is responsible for calling
of_node_put() to release this reference when done.

Found via static analysis.

Fixes: cc5d0189b9ba ("[PATCH] powerpc: Remove device_node addrs/n_addr")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/video/fbdev/valkyriefb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 91d070ef6989..6ff059ee1694 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -329,11 +329,13 @@ static int __init valkyriefb_init(void)
 
 		if (of_address_to_resource(dp, 0, &r)) {
 			printk(KERN_ERR "can't find address for valkyrie\n");
+			of_node_put(dp);
 			return 0;
 		}
 
 		frame_buffer_phys = r.start;
 		cmap_regs_phys = r.start + 0x304000;
+		of_node_put(dp);
 	}
 #endif /* ppc (!CONFIG_MAC) */
 
-- 
2.39.5 (Apple Git-154)


