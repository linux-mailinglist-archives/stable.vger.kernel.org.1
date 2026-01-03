Return-Path: <stable+bounces-204531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA3DCEFCD5
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2C92300B027
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C829B22F;
	Sat,  3 Jan 2026 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stgl7CTp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D8229A312
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767429306; cv=none; b=Ozx6lL3EqIuAYRImGWM3LfIACANgm8TLw48nzdTWQDghtts/goG3hpqAX9iaXJ2xyoBlwJ2eY6e2JLPkxN2nD7dSGcsciDidD5v2aihpr7W/ChIYWXG382am3rw7R3ymSLOCE4p7v4yJfAURvzCRBmnP3UcaCjjhVjZje2q2+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767429306; c=relaxed/simple;
	bh=NpM6N3dB6LYTm/Ib/IXLfe1vFqAJ1cYJOFeYExidG2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PcSpzVJpfBKyFGuGndDl0VdIoLzgzGCvxo2htri5Nq+gbGjP9fhdJNauu01eUKIxidCFVTRazlRaWOuJ96tIG6AFHReWQIKiVphmMMXcFQG1p9pn8Gm9yn2Xb9XHeZQumr808QF9MzenEfEGhrRdFgcWGyF3IYrwpNi2n33Ttso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stgl7CTp; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso19838656b3a.2
        for <stable@vger.kernel.org>; Sat, 03 Jan 2026 00:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767429303; x=1768034103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qhIF6Cy3ZRyASZaEaq3YB/3km+X/4fWw4hEpneLsPY=;
        b=Stgl7CTpGES3EMcbHyREnxCKIJKq+kuC5q5BVIwmvwPJuJpOB8CooUiVEuNxZD3uYP
         6pt4LFjcYbAt3ctGcbxaUNFqewU4o4C7agrhQvStKoNSlGrJOR76EFW3xaCN1eM17muW
         Hk2erGA3Q5sKjYIs++tmZ4PaqG4bC4ZlAyNzIh4n9Vs+cWu5idni2r4Vv3TQ3r5ZTutl
         OBiDG6+ClviUzdbaXuHUBFDinOsW8H4in7soFwqhRPEQbEXrZv+6Mp2LgF6BWicArLyT
         MyFobNSIF9D1lAWVYVgA4yrDr5j6e9k0WU4iMc8q6sgo68pT1BZAd1cEL2wj02BQ8+Rp
         CtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767429303; x=1768034103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qhIF6Cy3ZRyASZaEaq3YB/3km+X/4fWw4hEpneLsPY=;
        b=JNwav8fDYX/0vt8OTPodm3EwAFoP+RB1U45GbM3UIrMey6jRZPGU32HLacniMa0z2q
         7khcS9iQOcyviagtN8JzoJB9ykg06CrjE/GsgUg4ynWI8Exsv2Q8iuG8NOHMj9wJx6NX
         qjGTgePeYHzDsoE9EyIV+qebDkI4k5mL3KkxfzZ4L6WP4YZCzgTd1r6w5CixTJG2h2BZ
         49gPDU5A6zIf0QDm2EjLsIx96I5tw8h6TMDxE41doqjt85MD/tqRfgAqk+2Xp3JflYW1
         wV8FQP6bOOwirNVeeARzfDZPx5GTMhiDkF9JP25n2B7etr1MDaO8yV0Y9cKjSb0x91Va
         96Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXOvNdDR1Mm5RfZWBtK2tVDKHTIEdk4FxYT8ZaeZtzm7RWn7QMvcA34KtizN7BlKtTMzbw3fq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5b15G20VXTpIA+tb/H3SMJo5JFubzmLfeK4++ESGn1Abb20YM
	KUF+bapr7/hw8lIVPVX2ZSowVukw/6xHgwzERIWHfRduyfcqDp7nRFwFDKt/Srhf1d+QQBhO
X-Gm-Gg: AY/fxX4k50KM0lF7VvMqPXtb7jV1353BhZjBQG3K9VBU6ex6IGeH5HMcYD/jdS6eYn3
	bGAy+6JQlzcTFWDEsrvsDrClcOodVh5Jij7jzzSP0Ixk9+e0OiYbxD5+hk3+cbmFN5/XWq76Pgr
	adl7v4rnuqt1/gidQYOtds/H6NAZO9Hs8CLRvuKIemG3QmCNZolyHVKom25h7h2Rs71phTbEZs+
	7EbnR16P/F2kbX40n7MGOxz7o0sM7JK0iNOxAg+/GKNFrPzF0VJYow4C0/KkKcFj2q85Lbnmu77
	KGeomhkBkW4DOh4r3MP1oKgUwkgc93eIbVBZX+zTm5yQu9yXhf6j4IGcS4bDkRXzC9Kv7d/nS+2
	2wYvMEol7AJBlQoMyvSEisVlm3FoodheHKfkGOPvqhUuM3fEjRY6wNfySE6gbiYmYNJL0GjwSUA
	m5Xrk+3ExS7t4=
X-Google-Smtp-Source: AGHT+IHUtqtty/VtHSgmc026MF4CaRztjM1XP8TFk789rI3KF6DtSazGuOKQZfS8bwFmggSzp+M8tA==
X-Received: by 2002:a05:6a20:7d9f:b0:359:c3:c2ec with SMTP id adf61e73a8af0-376a92c71d6mr44602946637.35.1767429303426;
        Sat, 03 Jan 2026 00:35:03 -0800 (PST)
Received: from ymm.. ([120.192.15.12])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961e045sm36366670a12.1.2026.01.03.00.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 00:35:03 -0800 (PST)
From: Aaron Yang <qxy238@gmail.com>
X-Google-Original-From: Aaron Yang <aaronyang238@qq.com>
To: qxy238@gmail.com
Cc: Hengqi Chen <hengqi.chen@gmail.com>,
	stable@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v1] LoongArch: BPF: Zero-extend bpf_tail_call() index
Date: Sat,  3 Jan 2026 16:34:54 +0800
Message-ID: <20260103083454.10350-1-aaronyang238@qq.com>
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


