Return-Path: <stable+bounces-210237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09695D39949
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 20:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63B243008EBF
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038D246782;
	Sun, 18 Jan 2026 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/h2neuv"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895A6225402
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768762910; cv=none; b=u55u11sYs1acOL5F9KRSHp1y3osaGolRLk62otP/IBlnbcqxdb3J10HSD2fOmwiPDKYDUJIva/ZxxL5Xm4xhB/BDGF7bhZspT0srZXSoRLQq8kVA2jh18hfaSNlWcW511wH9blLgGXvIfklP8Ow2+sRGqpT0RMTEFqftVGDqtlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768762910; c=relaxed/simple;
	bh=nMNE6iEfpLstIa10M3kB5FyebBEQOg86SBYePsQerOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryJ5Lm1Mgmd6xyptSAjaScUKv4IK1QTQlvJMYk19kl5MEorAmjEOBWBvt0SrjFsgA5r4z97UBrNRG7fZMu3Gc+pG1j5RSrrBGuTmBhG2pnPQebUIQiT6ta3fJjWy+eZMRklnxeVStx52qUytqsrRATTudYoNB6As+ii6ADYM53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/h2neuv; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-404308dd5d6so1516093fac.1
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 11:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768762908; x=1769367708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNjMslMWG3mKls0Rz/DOZ4WWtAb1rKfHE/u7ZXd1FlU=;
        b=P/h2neuv1Bz0cRKC12bIKzQLhdxWjZFdlaR4oGOEqBL9siHjXHNrWAsRxles7S26rI
         v5r694kAn3BLPTMjgAMEGZYlz3USSfBN+WyQXGI0gxC23yX/Cv4y8IcenIVlc4E7e5iD
         7ymYvTHBr/sBsrl9hhwRjU/D49XLLbLJillZaHZ478FUAzRECm+JGod841ne3ibSAi86
         E0CXBilcEpJXLRYQ0QlydZyYjlwczCy288v/UVijhLv3TI7OnIkZPy5nfubR9jEhqsRw
         WKd64BfMV1ofJ8epHAwCIrWXPvl8MNqcq98d8leudomacXkLns2uy1uWa9kX2a0uvy8/
         3a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768762908; x=1769367708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNjMslMWG3mKls0Rz/DOZ4WWtAb1rKfHE/u7ZXd1FlU=;
        b=kH2xMuJQZTzF3UOBC7J3IlZ39phUPCJq5HJ26uCBeRJAkn941dikbAoWKBKxWiY79Y
         imSYTcTYKPhA/Il4ZrpMKBrV/Bs4TRA+jhbnyuSDh/cE1TP69CKeN1AU24kkIwK0kTtY
         B05k8DsnDkbUT55/U6gjQ0DWbv7UC9muDgHdsIGks/kXndPJoJSv3YHQvx2Pcp5w9a0K
         /mPzw6iuAb0hjK4OEry6ULZiu5DWU/ew81AnOLWl9TmjXc3ZiZSAlK+irZuW8NLPnW1e
         adluKZszvPMPOl5g+BnoMFKfaLgxKsA9jJvFLEzQxnoNKY0YFSqjvtSkFBguJCmqzpxS
         Gtvw==
X-Forwarded-Encrypted: i=1; AJvYcCXaKCf/2nnHMjxPNBFKw+h0ml8UtUPPngpiyzp6646DElqYXHIQBbnSle3umQV4HBUKkI5jg/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdexzQKDpXQFH7Y9mpNNaTDzX+oxknnYZ4rh46uxGlf35mtYw
	x+K0cEVFTG6F9u4uKvTnj7bpsAlzrl7T8GSUgBrFtGqI55+Og7ZPRZgiiGEMuw==
X-Gm-Gg: AY/fxX4HgfxWV0T1NGNqxvmCiLzjUCN8hz13Bijj/noeuZNbeZ/A5IgdqJuIH84TvRF
	OnSkchIMYX7hiaeseDWMcG5zLP1qS4GKXnnIat5S5F3NOmTjG4mH2yJNrdqTc9W9NoCq95ZYvIS
	oU7JvjPaPDvObZlxWzpT1HXaYtFa7xa1698Akb5KIb5JvFamAHXe04cIgr9rouNHFkkzdyTcaBw
	LhrlxYmV7gsuozLWvXwI3lKpy+QbJwhMyeh0IMoWYSuW/tT6Vva5s+uixRtoLofx5gT3IBmoEfH
	OzLuQVQrbatjlyuqODYy6albRHOw6Jw6lJPIbdXyfUkOiFas6ol6BYwvhwuIsE+1zV4R1B6y/kk
	umSL2lxbyRDVQDdB1F/6HRf5wD1WYjdJctx74nuPtQ3Tsp4l8Si9jBvUL0FWRPR5CGvnaPjZR/H
	DRRRqmUBik1yEuGp7EK7f7hWJWkamhwUmemi0gwU5Sr9M=
X-Received: by 2002:a05:6871:3319:b0:2e8:f5d6:2247 with SMTP id 586e51a60fabf-4044cfc720cmr4766960fac.32.1768762908380;
        Sun, 18 Jan 2026 11:01:48 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bd14883sm5530224fac.12.2026.01.18.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 11:01:47 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: markus.elfring@web.de
Cc: almaz.alexandrovich@paragon-software.com,
	jiashengjiangcool@gmail.com,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2] fs/ntfs3: Fix infinite loop in hdr_find_split due to zero-sized entry
Date: Sun, 18 Jan 2026 19:01:45 +0000
Message-Id: <20260118190145.41997-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <65bf90b1-8806-4f8c-b7e7-d90193d28e88@web.de>
References: <65bf90b1-8806-4f8c-b7e7-d90193d28e88@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function hdr_find_split iterates over index entries to calculate a
split point. The loop increments the offset 'o' by 'esize', which is
derived directly from the on-disk 'e->size' field.

If a corrupted or malicious filesystem image contains an index entry
with a size of 0, the variable 'o' will fail to advance. This results
in an infinite loop if the condition 'o < used_2' remains true, causing
a kernel hang (Denial of Service).

This patch adds a sanity check to ensure 'esize' is at least the size
of the NTFS_DE structure, consistent with validation logic in sibling
functions like hdr_find_e.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Add a Fixes tag.
---
 fs/ntfs3/index.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 7157cfd70fdc..da6927e6d360 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -577,6 +577,9 @@ static const struct NTFS_DE *hdr_find_split(const struct INDEX_HDR *hdr)
 			return p;
 
 		esize = le16_to_cpu(e->size);
+
+		if (esize < sizeof(struct NTFS_DE))
+			return NULL;
 	}
 
 	return e;
-- 
2.25.1


