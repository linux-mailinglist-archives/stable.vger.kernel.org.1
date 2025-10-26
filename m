Return-Path: <stable+bounces-189764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1A7C0A552
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 10:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A163AE1F9
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A7F23EA8D;
	Sun, 26 Oct 2025 09:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml0MAfpw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEC126C02
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470369; cv=none; b=i3eQ38EzreimuRsSAbrmJmsQHwGqHP/WENXmteM4TDV5+r5io9HkuNP8miQtVezrHuEArx2gOHTg/4FSJA6rf0LdnA/XoCQssbxupN1evVINInqmTVYTv0g38C2M7/55RsoXAUJxYoH9LtEl/Gyat/YczkYlWpe6MsTLweWOcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470369; c=relaxed/simple;
	bh=m5dBsLXxcjfd/Jg1/TXpqHofhyi2GbaizAwo22sE+Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nE+PusK6RaHO3xM/iTbY7nXgL3Ciqn5WtiIafyXRYdtZsUYh7U2YPPG0Trv5TLyk+xIDJb8Zj0skpY7KmGRQjW49NtVK1H5jgdOU9GRXFK7Lj1giYT4kj5rA0rOYm390bnMOAtFbqgArkzdStQT9Uzv65PkNGON2jw3PnealoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml0MAfpw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so2851461a91.2
        for <stable@vger.kernel.org>; Sun, 26 Oct 2025 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761470367; x=1762075167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udg3CwQcBQ0BBJcZyhfktrzA11lxinS2ppEpd97MHiI=;
        b=Ml0MAfpwNv3AzOq4d0mscFCR4XbuUZTc5LaQIziZ3sXzatAdnA/iSDuLm6LfVqmHFR
         KGqYc6CM6Mc43M2cyXKmib4L/LsyAB5g7v83jjDFrvh2sgd4W8G0kFr6RHbwF9LF5hrR
         NLgDNhYpL09IvciYyQLgkIvB1Kj0DSS1p2P6D9bI5Rv65dGV7963YnrBfUZyHS0sCXUn
         lZusZ5ba/efn9DM0tV5AKCEmABeSA59u5ulEp4zSmIcyXuRcu8F3fSwmD+PebSs7alk+
         KbizxaRy9+h3qr8bSEJvyW64j/rDeFRpinfhsboK4Zq8poE5EHKAvTLxIHIMY8n8VNVO
         Ceew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761470367; x=1762075167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udg3CwQcBQ0BBJcZyhfktrzA11lxinS2ppEpd97MHiI=;
        b=He/4unzbikH4XDLooFXs/fmwQuWvXWaa6ujfDmExm53Gk1H7SK9lmaiDPH7R9MRpAc
         xBQHZSN8QCX1RXlINxJ4WO+tUAq7VAZiirSmU5f4qHSPTkJmJ6RPsxgKaQML8Wo0q85n
         HoLL/NGLD7X3isMsRVEo3FBaMfSMAmdcNAHqsDONr/gFXehqOFgTiiZePNMipbN62d9J
         nPpCgUmRecBh8NSpwbR/mq1zKAp29utyeYKshq3MPYm3+QqsxOgu4rqlitS1gHwURLfo
         KWN04uzy6QN9ljs/oqu0xGgkspmquCpvEDlPM+XLXuQQQtva8MjGeGO1t3M3oyUqdN2H
         Ging==
X-Forwarded-Encrypted: i=1; AJvYcCVEby3X30GOjnJbcdXhkqSbYfVO2r7WIKyjgR3DlCb60IwSwXpQE+Yr9yBSsaVLckyR05td6NU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7/qBvusIgsVQWUDc+w4yA7hNzwvSGZH44a9VI4RJ4NDw/06C
	znnkd3L0lPQAk0jMrdsgGINCY+pSIyXFd/yhLg09oqvVcdijS4NGtpex
X-Gm-Gg: ASbGncv56MIaE6TpJ4kr0JC167+bPWMs8KpbBQwpHYOIuKG4W50y7rThN0Se9qqmn2i
	YgQCpoljMeKL5QBVvXpUPdI8KR820wOEUELUIvU3Q/QJdMafjoLOCRVRmd+0WjAqHcT61WEQwwo
	5dduyzepRHZw8BDpBVz5RBJWT0ZaAAMuPMqA/3RQX/R8nsSDfnMqvBSxlh0uWCs5uEte12j34Rq
	RjvxuQrGscUg/vuV36m0VxFmo1MxMST1rL6TwgCZ2if8SkS5pEehmYN0Ny81g2ns6QYfhXLsBo4
	j/gJQTTeCJvIxxj4C25SOm+CqUNv5LlmsN0REewRxMTxWARqIAgPsipmJjR8vikXgfQ3M1doz/j
	oofQ4vCq8UknPCbghsf1gswBxJ8EKLZNl8K9r/F4XBlH/ng7jts8FrTKGkkS/6Md4J/xkoi9TK+
	H9gPvzinvDSmruFicOylybgg==
X-Google-Smtp-Source: AGHT+IH6eN+njVM8GBwTsi7fLGE3YNfCJKSism0LE4927eZ8Rab/oS7OTOf02WSA0mHpx2ydqTM/Bg==
X-Received: by 2002:a17:90b:4c48:b0:32e:936f:ad7 with SMTP id 98e67ed59e1d1-33bcf8f8737mr8845587a91.27.1761470367609;
        Sun, 26 Oct 2025 02:19:27 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fee418419sm1947131a91.12.2025.10.26.02.19.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 02:19:27 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] riscv: Fix memory leak in module_frob_arch_sections()
Date: Sun, 26 Oct 2025 17:19:08 +0800
Message-Id: <20251026091912.39727-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code directly overwrites the scratch pointer with the
return value of kvrealloc(). If kvrealloc() fails and returns NULL,
the original buffer becomes unreachable, causing a memory leak.

Fix this by using a temporary variable to store kvrealloc()'s return
value and only update the scratch pointer on success.

Found via static anlaysis and this is similar to commit 42378a9ca553
("bpf, verifier: Fix memory leak in array reallocation for stack state")

Fixes: be17c0df6795 ("riscv: module: Optimize PLT/GOT entry counting")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/riscv/kernel/module-sections.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index 75551ac6504c..1675cbad8619 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -119,6 +119,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	unsigned int num_plts = 0;
 	unsigned int num_gots = 0;
 	Elf_Rela *scratch = NULL;
+	Elf_Rela *new_scratch;
 	size_t scratch_size = 0;
 	int i;
 
@@ -168,9 +169,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		scratch_size_needed = (num_scratch_relas + num_relas) * sizeof(*scratch);
 		if (scratch_size_needed > scratch_size) {
 			scratch_size = scratch_size_needed;
-			scratch = kvrealloc(scratch, scratch_size, GFP_KERNEL);
-			if (!scratch)
+			new_scratch = kvrealloc(scratch, scratch_size, GFP_KERNEL);
+			if (!new_scratch) {
+				kvfree(scratch);
 				return -ENOMEM;
+			}
+			scratch = new_scratch;
 		}
 
 		for (size_t j = 0; j < num_relas; j++)
-- 
2.39.5 (Apple Git-154)


