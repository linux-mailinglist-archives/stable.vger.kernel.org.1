Return-Path: <stable+bounces-104426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CF9F41DF
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99FAC188C27A
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF9C15533F;
	Tue, 17 Dec 2024 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gkps6dHi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A9155A30
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411623; cv=none; b=OE/Hha6D5Vj2zoIr4Cgro62vPxL6HcdPrmBJ0Ikjw17YvmsGQ2QTuNuVb4NeQK+PFwQ+k6JJppVDGbiGLkGpZ8QKS8L/GBiY2DHHTBZlyGahVWbv2N0v3EIUKbubS5Fn2q3o3uCXabP3G+/czn6rC3udW2B5svB5J6LLKgm6hLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411623; c=relaxed/simple;
	bh=sXr55O7+VrwSmdzqpu9DqbaHrugZJPrvbnP67L8sbZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tOOVDJcKfeZT3zvq/W/IW4DWK6BEkjqgQ13eX551NF6F+Af5OHQRXPwwAIj6Zbj9Ze6Fo0r/iSG7XmEHCq3/01WsZ20LJIpeWg8llPb7HaHG8IyV5MlDzRzTYzh8vcKH8sEMQZnY1tSiWk35ZqUv0qy2Wz48RFVeqOUU4RD5XQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gkps6dHi; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3863c36a731so3469864f8f.1
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 21:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734411619; x=1735016419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MdPLGP20ShGmqTBZSio9WvX6t8pN8HosL8dCIPo6zx0=;
        b=gkps6dHit8Bpt/HXWZgf1YAmhLUaYQ+qsyvOHk4Zf/ssm1aV9w4RFDTwp4IY43sU+z
         oB7ukTBJfQ53q7SEqSGKgQWDS65qQjBrENKQeo79iUH9809kWxc47waqUuldt+4Xf0cp
         aTbGaREjYn3vpZaH2fktpr+L4H/tMW/PM46KhAJt4ibhjW+wulFLL4DRlmIRN6fH1Uzl
         ckHZiWIWQP8oM25pKG+/fzOdo3A4X1nnr6lPy3hLL0xozJpVr3LCxa94Q9xU3bYM7DSc
         bOYKefPc/RiGodEyJ/OwJoEycAO3/5VVXpt9tQ0fCubxGNUjsz5cNyNfuA/D9N0+Vv9U
         ykww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734411619; x=1735016419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdPLGP20ShGmqTBZSio9WvX6t8pN8HosL8dCIPo6zx0=;
        b=fMW1iharYJhKjbSfX3YYB+uAd5GTtN9koc38qqEBpYtmOl9vWuSyuH03J2cgA+jmk/
         Qman4me50IoiCzN7CFhxFhBbWU9bvWCINmwnfv2vV05XRw+HQsJp5GDhM12rSQQp471t
         P/mCZ9JqipoZ3n+3igwHKtqODe6ZqmKSniTKoH4Ts90riErbvDTHQWBqcaGTz4meqgD3
         DRljgMK3faEuxQ+39LP5ATKh0Zy/+1ShQzpXk3hFIcNYL8hyRWRSP4VqUcieByJhoyh1
         jkGn86t694Yxf3ZejCrTeBlwF1WCygQ+MeqaKVQcBKqthSvvc0WxNVBvF/Za3DnSEeIR
         jxyA==
X-Gm-Message-State: AOJu0YxHTPC+Xrlu0LPwQuzBO+NvUeyictbIEEpQ1o7vHQSBh811BxkQ
	pU2NqY5Z+cno/paZn+YlWnVi6zTPsEhc+uBJHxH9wiR0pQjuIc6fWy/CQJ+QcNuBbZuO2tzKDCj
	pU4xfvA==
X-Gm-Gg: ASbGncsXYb0GaGpFABoiaO9Mz2hItZJK9dl6orjzMNCH6PS+JvBDEcliIXscsVnpB1s
	oASgOtOD6TZ1Bsk7mMKivRChr1N2fiDj9rMZsJj8vB/gsZ4q8eB9Zo5hDemm1VorsfqRBLxP2l5
	Akzip3hRAscwCzHtDb2F/DBR8MSjAm/sfP/bPNMM+SDsOsvyfw5XNpYKQ4ThsQxmarFmQL8lhIW
	tW30giN46HmdI3cIO8iiiPiHe3UKnCD4d8587C0JOyugn80DsiofDRLQZw=
X-Google-Smtp-Source: AGHT+IEtuWv0FHIApdcs3cOQekrj4Z3uN4axoUKzoRdeFUtNXF/HsQfhXqnHq4side54nCTWN5D3aQ==
X-Received: by 2002:a05:6000:4615:b0:385:de8d:c0f5 with SMTP id ffacd0b85a97d-38880acd81fmr12358021f8f.16.1734411619210;
        Mon, 16 Dec 2024 21:00:19 -0800 (PST)
Received: from localhost ([2401:e180:8862:6db6:63ae:a60b:ac30:803a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048d1338sm285485285a.124.2024.12.16.21.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 21:00:17 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Lonial Con <kongln9170@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 6.1 5.15 5.10] bpf: sync_linked_regs() must preserve subreg_def
Date: Tue, 17 Dec 2024 13:00:03 +0800
Message-ID: <20241217050005.33680-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit e9bd9c498cb0f5843996dbe5cbce7a1836a83c70 ]

Range propagation must not affect subreg_def marks, otherwise the
following example is rewritten by verifier incorrectly when
BPF_F_TEST_RND_HI32 flag is set:

  0: call bpf_ktime_get_ns                   call bpf_ktime_get_ns
  1: r0 &= 0x7fffffff       after verifier   r0 &= 0x7fffffff
  2: w1 = w0                rewrites         w1 = w0
  3: if w0 < 10 goto +0     -------------->  r11 = 0x2f5674a6     (r)
  4: r1 >>= 32                               r11 <<= 32           (r)
  5: r0 = r1                                 r1 |= r11            (r)
  6: exit;                                   if w0 < 0xa goto pc+0
                                             r1 >>= 32 r0 = r1
                                             exit

(or zero extension of w1 at (2) is missing for architectures that
 require zero extension for upper register half).

The following happens w/o this patch:
- r0 is marked as not a subreg at (0);
- w1 is marked as subreg at (2);
- w1 subreg_def is overridden at (3) by copy_register_state();
- w1 is read at (5) but mark_insn_zext() does not mark (2)
  for zero extension, because w1 subreg_def is not set;
- because of BPF_F_TEST_RND_HI32 flag verifier inserts random
  value for hi32 bits of (2) (marked (r));
- this random value is read at (5).

Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Closes: https://lore.kernel.org/bpf/7e2aa30a62d740db182c170fdd8f81c596df280d.camel@gmail.com
Link: https://lore.kernel.org/bpf/20240924210844.1758441-1-eddyz87@gmail.com
shung-hsi.yu: sync_linked_regs() was called find_equal_scalars() before commit
4bf79f9be434 ("bpf: Track equal scalars history on per-instruction level"), and
modification is done because there is only a single call to
copy_register_state() before commit 98d7ca374ba4 ("bpf: Track delta between
"linked" registers.").
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3f47cfa17141..a3c3c66ca047 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14497,8 +14497,11 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 	struct bpf_reg_state *reg;
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id)
+		if (reg->type == SCALAR_VALUE && reg->id == known_reg->id) {
+			s32 saved_subreg_def = reg->subreg_def;
 			copy_register_state(reg, known_reg);
+			reg->subreg_def = saved_subreg_def;
+		}
 	}));
 }
 
-- 
2.47.1


