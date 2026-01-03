Return-Path: <stable+bounces-204532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D22CEFCD8
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 09:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B38D300F9F8
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9929B22F;
	Sat,  3 Jan 2026 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1HD2Tv4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E124E4D4
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767429378; cv=none; b=kfW02ml1FHyTIaM/bXphfAiDDGV4ARZ9np8v4mslmhXhpJEVFhAHuXoqO9Usa/Lau5GDQxRQEWeC6jg1baX5xlCJwkEYJo7I9GUfWk3PiYw33TePe6Vk/2XG5R1ga8RH3naAt3R2cEzXYuRznm0/ne8cLsaxnDh/5qJetAItyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767429378; c=relaxed/simple;
	bh=NpM6N3dB6LYTm/Ib/IXLfe1vFqAJ1cYJOFeYExidG2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mj19CZekC5cLoXG0w5Z04DUeAeaQ0OUVbYTvpjzgxuV2qk8zc1K22mr8OvD6Ie3TUZNNfXt6BvG6b+gbY7+JIFPnfK7kBZxqxjEabSgs8q9PQtEaKzAGNcb2XePG4Sje5oO0J4JiEsq+Y3cyj7YIla8m/NV6LIGl6Hxwine5O/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1HD2Tv4; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a12ed4d205so110947145ad.0
        for <stable@vger.kernel.org>; Sat, 03 Jan 2026 00:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767429376; x=1768034176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qhIF6Cy3ZRyASZaEaq3YB/3km+X/4fWw4hEpneLsPY=;
        b=L1HD2Tv4zQMD8dsSyd7sMawC4Vg20TjfZ3UyXuU2hGovINrMHE19PwPGIz++j/iOoB
         N/hxjcIypwwHxjE2W//o8gkzly5iwDQIcDVF10MyU8kEgWgg/FIJqRs0rrz/pR8f0a2B
         oqkwfRkdAWyvr0xoD3brEqrRTT7pKyQzAvVPP/PMo4rzA9um1t7GvjcdcbzxxAe1Ulhk
         IGwcjseYm8Y6vr0iPdObexx9VoMoZir9/Ux7pp5cFF+Wq67DSQqMzcgk7H92Ee5jbeSI
         kQLr5AZRkXKDEBSzOYZ6CgIklCqFX4whrEM/PPOQcjFMQ7LwQDIrQtrhB2d2qT5H2pNA
         Kv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767429376; x=1768034176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qhIF6Cy3ZRyASZaEaq3YB/3km+X/4fWw4hEpneLsPY=;
        b=F95853lFlCzdLKc43QEhIOcN1Jf0kKxs/mdpAKLRkggA5odf8YCHFnCC8XWlkicUZo
         K0O5XS9beWIeS7s8aMkaX5ObuQQd1jCbitnNavm8n5tLYEjrUD+6LcYX8PILB5JA61H0
         iS9eRUrXBarkNE71pQ+6WFbBosyJYDdPwdZkreeh+FXvEBkqBlbOu/tEbmRZwarvQuoy
         pM02pAUPBUcn9C4BvAQ9c1fGHj17ixrCQ0COeHL7P/Oz276Rf+SqCYBe93wusqyI5Vbz
         nsRLeMXD+YBqmHB3otLqqfY7+gmxSk+6wX2fbUjCTRazU/5jAkPdmpEeE+WeNlL2bG3j
         DisA==
X-Forwarded-Encrypted: i=1; AJvYcCVJU1LTtv5P0VyOjlv2pOyEfawFgcYfdSc8vQCGWUmhnaOvIvYCGQDCk9u63HGnv49gIaoWTO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gFwNzwgUkurEb/VGMNXfhn3v1KxcoOq4I4sQd7B44pldHX/4
	0+My8jG9OhfK5UvKPVTdG41gfi3Q+NB8l7VBJXt9obmq0b7EGIov1OSM
X-Gm-Gg: AY/fxX5cbcNvXy4DLoPBgmVCS10GyPGNqgHTC29kStaJqQboPfkpaTY5YDmu3BJGc3K
	Gk7W6rjXm86lSA5NXMcKIWoJr3Kw9Jfnq/NyQkUhq4GgqlI3AQC5Rq4jFQLKkWwtE2mEFQYf3AH
	Qu39yKYxVsUSeIyc5wUhtyQAb6wz1e/yTyV2z1TngT6+pctjTbn4sAQjmclp+Cjabb7HMLyPlqc
	Pqa+rRqHd1qOA/uPJ18r3vPJnBYCcRZ/cj/zCbBEpNqtLmrIZvVyVd0poeT26ettflg8n8j0bLU
	aRS8K9YXF+F89BGFK0yYfddc4Stg0HzKJYPWLm04ITQrJeN0ABodihVriMdaoafUlTy0pLND4RU
	IPBD+6G5E+iuLufms/PXvzJxaWgHuEIfd6DpC25sSdt2lQ8CLR/OUEuxazNr3WLj8PB+Y6E/lrw
	GWfyqwyXvqPC8=
X-Google-Smtp-Source: AGHT+IGmEq6m23Z77xulKx/k1G/qMf9pwiQxKB+COGw8frzJpc5oE9+668CB3ihoaz0ETIdQnmiI0g==
X-Received: by 2002:a17:903:1105:b0:2a0:f83d:c321 with SMTP id d9443c01a7336-2a2f23289cemr418868565ad.23.1767429376187;
        Sat, 03 Jan 2026 00:36:16 -0800 (PST)
Received: from ymm.. ([120.192.15.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cbe5sm401796705ad.60.2026.01.03.00.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 00:36:15 -0800 (PST)
From: Aaron Yang <qxy238@gmail.com>
X-Google-Original-From: Aaron Yang <aaronyang238@qq.com>
To: qxy238@gmail.com
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v2] LoongArch: BPF: Zero-extend bpf_tail_call() index
Date: Sat,  3 Jan 2026 16:36:08 +0800
Message-ID: <20260103083608.10914-1-aaronyang238@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengqi Chen <hengqi.chen@gmail.com>

The bpf_tail_call() index should be treated as a u32 value. Let's
zero-extend it to avoid calling wrong BPF progs. See similar fixes
for x86 [1]) and arm64 ([2]) for more details.

  [1]: https://github.com/torvalds/linux/commit/90caccdd8cc0215705f18b92771b449b01e2474a
  [2]: https://github.com/torvalds/linux/commit/16338a9b3ac30740d49f5dfed81bac0ffa53b9c7

Cc: stable@vger.kernel.org
Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 5352d0c30fb2..766ded335fd8 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -280,6 +280,8 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
 	 *	 goto out;
 	 */
 	tc_ninsn = insn ? ctx->offset[insn+1] - ctx->offset[insn] : ctx->offset[0];
+	emit_zext_32(ctx, a2, true);
+
 	off = offsetof(struct bpf_array, map.max_entries);
 	emit_insn(ctx, ldwu, t1, a1, off);
 	/* bgeu $a2, $t1, jmp_offset */
-- 
2.43.0


