Return-Path: <stable+bounces-191536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B79C16925
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D131C2516B
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845C134E761;
	Tue, 28 Oct 2025 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cw8Fh5RN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38FF18C31
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678626; cv=none; b=sGaXy2dJr3gJpYxgT5YlhcWsMksfzaaAsBFczPcYF+UINJIDfipSmeqY7t7vl0hWHMQ1Xk5YkFfsSgBIiCfjQEpkV8GG8CR2PU7eR2SnHR30RqdnmvtkZxUdl5ilqbUUGYSYYqVgNgQHQXf8ILFJvQnALo9+JaRmr7pSsBtvv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678626; c=relaxed/simple;
	bh=nWfTqZP3/CNwFgkymho3UV1+afHy6tGym+OBmNeg1KM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hAhOZXMn+tzIYtkDA2waggkIO/7o+9Y7Zt8cE+nTRSfXWc8dbyn0EhwJv8hOk+bCXA1AgverTu6MZtqWk3dy7xNbAZvMPL2XC1d40pKoD/ikyNfsHQ7VhB+XrsC6UjSZFfNjLCn8mtxcDyhPNmWcyDj6gZRFJEDU2dWG0go94lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cw8Fh5RN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290cd61855eso54362145ad.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761678624; x=1762283424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dKmYj9Yio/TKjjo3MdLkJeEKLETaJdriEr5g0xrMLzs=;
        b=cw8Fh5RNyJ2V9dHJuSHA/dMuUw7RSq8/IBlshQvixyuhA9QDX1J1ga30yg9E3jvFW3
         z+Gx2wL9ljxz60/eM1Csk1Kh8HuCenrvLjVm6wM03S0RtCkMJCzNMZShiWmTw6LSBFSd
         3/iybyfR0C5gIQS8/D6dUPyEsNCW8Ntkj9/qbDaNGXH3T2lX30x/MfcJj/r38A4gKJCb
         0Rd4Ym43c/vHfJqZEb+cx5pDZ730vm9w09YPQHDz2aIlqfRv/sOLx++3ngA5Id2gCVJj
         55fCeS29vZG9JKZ3AVxJ867RTYLfZcg2wxWeQKdk3Bdml3tAfeAHhH+ABdIgmxkBRFhQ
         wEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678624; x=1762283424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKmYj9Yio/TKjjo3MdLkJeEKLETaJdriEr5g0xrMLzs=;
        b=KclLrf+7TwP1pzDlZ+si6YSTZEmd41teum9h0Y/gKdu5V03VFUzPG2pPab5SPlGA0u
         BiKT2i0i0kISdXPFhKPzm3Id7H0BKFFMba/XfXxw1/9wPj4AAX/mbNashA3pRC3s8iey
         ZbU6z5WfI/9kg3aBj3RL50Guuzm2FkNFiQGYck1W+L++kw9P/q8KmHkU2X8mt5p5+vmv
         AgePjrh4zstx4qpYa4VnEyE7kBzwViWmgo3BmWjeKcafYIJpxRL+O8GJLJOkHa8H2zl8
         J7vrecQiAOPkFZ6/rA9WqM7l52CiqTB9VyLjr4soxadaJAbhDXtcmxwy3bxvaXOp9U2H
         NadQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1QFodEW2d9/WqCfqU7uTQld3oBztqiEzwQsXcnNq2UyeI7TVqPhC2Qa7sJC8wBcXzkUoFrG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxfuCxnJkzyRxKQTw+M5GhwuAaKqV67GkgiBqUMVC6dZwgRs4H
	Vz+7WtJj04dqflc3VA9QGTfsvChAJRPYU+m1/eV3TAu9PN+SuHIb2w7vK9bM7hqkhj0SdkNTKd+
	e5tZ1roiWketNq5FDSJVIV4W3AbbYHZCUpIEHOA==
X-Google-Smtp-Source: AGHT+IHoA+/xXI9fzl3kptYGRMT9ubFjslD2sGL9QPl4+LylxBFMy1zqCRVgSQOB8Ay6n1ipp3kyRxf8KTocGr4A1yANqw==
X-Received: from plrt21.prod.google.com ([2002:a17:902:b215:b0:290:28e2:ce57])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2406:b0:28e:8c3a:fb02 with SMTP id d9443c01a7336-294dee12958mr3501255ad.14.1761678624199;
 Tue, 28 Oct 2025 12:10:24 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:10:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251028191020.413002-1-isaacmanjarres@google.com>
Subject: [PATCH v1] mm/mm_init: Fix hash table order logging in alloc_large_system_hash()
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, stable@vger.kernel.org, 
	kernel-team@android.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When emitting the order of the allocation for a hash table,
alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from
log base 2 of the allocation size. This is not correct if the
allocation size is smaller than a page, and yields a negative value
for the order as seen below:

TCP established hash table entries: 32 (order: -4, 256 bytes, linear)
TCP bind hash table entries: 32 (order: -2, 1024 bytes, linear)

Use get_order() to compute the order when emitting the hash table
information to correctly handle cases where the allocation size is
smaller than a page:

TCP established hash table entries: 32 (order: 0, 256 bytes, linear)
TCP bind hash table entries: 32 (order: 0, 1024 bytes, linear)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org # v5.4+
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c..7712d887b696 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2469,7 +2469,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 		panic("Failed to allocate %s hash table\n", tablename);
 
 	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
-		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
+		tablename, 1UL << log2qty, get_order(size), size,
 		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
 
 	if (_hash_shift)
-- 
2.51.1.851.g4ebd6896fd-goog


