Return-Path: <stable+bounces-210267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE8D39F1F
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B785C3003F6B
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB328C5B1;
	Mon, 19 Jan 2026 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ge8IA847"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B728C849
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805666; cv=none; b=GLI+sPy6lRA5W+GEP6p31h+jl2tKkIsFwN5ce/CXbZUB4sN/wTDY0alFa3+p3iWYiujFrtF0xsUv2cqeY7EwfwP4D8f/POW9hZYCSqijGvlKaDTUGEX71NFRe9wdi1BSgJvwo+hpJzTJv++nX0crv5M9zAWmas6G50Te1/VI6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805666; c=relaxed/simple;
	bh=AVGq/UBh8osxtKffcOu0e4ZVOQLO3BWu42xnZIJYorQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fre8/tEEPVvv9/84fd0w6iEcmT9/d2xzu/DED7JDVDIUEBNTZBL9W2WTP/lMuuM4GS0x09VZy4aiKLvNs0fPtnows1UYE6S7LbjJz0ZysWKgkmlWxvzyYljCoApXnLSEJ6JAKvqoKJmejnpvgv0crEddnbnR06eQuC97T6he+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ge8IA847; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso25509975e9.2
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 22:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768805662; x=1769410462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bYHLPwOYCVLQKOrIZ4XF3JKi88YcvuIcEuOL/sfA0yI=;
        b=Ge8IA847FjXE+C4HmYT6nHsAXgZvADBANwGQmyvysvEkM//EbxG/qqTEv8RXQibpB+
         LdgLwLJNSMOyq9982dZcJmQxSHd727LTP9Tp7B2B7ZRs6BnACNfZ7dlzdjGT4I43/WHj
         wfnOJH1xUtfOOmwlQgSlrbOOlHeuJn5Uidlm+NNvAi0fM3UB5/HXf/GphUBy8jwHwwTf
         v66OjA1ckTc4QLeq6ZxcsvaXhbgcK7NE+2eHjOytv+eItiXttUm7m4RoOHksEs7WNkD0
         yT2qybegErOKcp0DsutHPpCcZa9VtwRPRMWkovMGq9NVifM36eYKnj8fIHD9wJaneHFR
         nyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768805662; x=1769410462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYHLPwOYCVLQKOrIZ4XF3JKi88YcvuIcEuOL/sfA0yI=;
        b=J0CrRfYWiAdUPNCA0AV8p0lKixPR5gP2nO3v2OnlUBQapGUdbHrASg0bQRfrN0FcV7
         xgCLtqIFC62U31SlS7qfp3rUEIYaKqqQf0HHvuymPJ0ryAmOv60P0XUp/c6u3Zd+BeSy
         DhfOYWZelZrGbd6uGUGCs7ktMpodS5kjcMcoK/IarbbJc/PVwff4507YuNHgxnGJ1O+s
         tCnij7nZRTQhVisVv1facu/+AmGQZqzJ89VjlNHoeYQuBqcaIhc0VGWp8pYL1RPA6MY9
         lD3Ct3iYi37PqYq/55/D+RfBzQSUaGOqy1uR/nJebVuw0VW3mI5FdVlUZDKyXLVo/Ffp
         UXRQ==
X-Gm-Message-State: AOJu0Yxi4dkgJRBIA6uF52XgqYROcAEPgesARkjjbl3SzlVtFj+7khIy
	5pnJ/2+tyCvDW++rC5wBfXNqmO4lqwq0OgDVonVzJcPM9TrZnMJ/PpRZ93SPC3mY1Uk5uENu1uY
	BvjQe
X-Gm-Gg: AY/fxX6ZVDuq1LtVtYO/DNqP4NZGLXSf0kmtoRveceMG8PemSuFP/KdtTR5iHiCkX2w
	n5HQLn98SJ2yY3wogP0+c0Eni/GYErUss5b2hsII8xlCZIjHKYuQ4o9T3E6nO8bTJVi83i55z9D
	uw8z1B/SzHMTcDabF8mp2NsTKpQQIsELDydArQ901CaA4XhPQK/KP1VrkD5zjVbCeZaFduc3sYu
	0KW1AN64nOW8AGPYLDWg073776zyo6nbKe1NXobTzczygesDR0G/e27+VZHg9N7sZhDdc887KT5
	3HsMvb+5Hx1fYtb4EBIUUrYa5YoPgg3tiZie3aiD2XAEtKfnSV7ROCBGeuAG7OoVPeYeTXnrknY
	PFhqRoyT5gym8XqTtYPfPTb9FhsicZpC0MJprrntu7ZkaGB71Grs6U80VjijzM5dCy/6nUxzBLf
	p5k9Qx4MINtqbe6g==
X-Received: by 2002:a05:600c:458d:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4801e34209cmr109631735e9.22.1768805661850;
        Sun, 18 Jan 2026 22:54:21 -0800 (PST)
Received: from localhost ([2401:e180:8d80:2a2e:c146:9b66:e2fa:21e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ab97csm85863245ad.11.2026.01.18.22.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 22:54:21 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.18 1/1] selftests/bpf: Fix selftest verif_scale_strobemeta failure with llvm22
Date: Mon, 19 Jan 2026 14:54:13 +0800
Message-ID: <20260119065414.20562-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

commit 4f8543b5f20f851cedbb23f8eade159871d84e2a upstream.

With latest llvm22, I hit the verif_scale_strobemeta selftest failure
below:
  $ ./test_progs -n 618
  libbpf: prog 'on_event': BPF program load failed: -E2BIG
  libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
  BPF program is too large. Processed 1000001 insn
  verification time 7019091 usec
  stack depth 488
  processed 1000001 insns (limit 1000000) max_states_per_insn 28 total_states 33927 peak_states 12813 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'on_event': failed to load: -E2BIG
  libbpf: failed to load object 'strobemeta.bpf.o'
  scale_test:FAIL:expect_success unexpected error: -7 (errno 7)
  #618     verif_scale_strobemeta:FAIL

But if I increase the verificaiton insn limit from 1M to 10M, the above
test_progs run actually will succeed. The below is the result from veristat:
  $ ./veristat strobemeta.bpf.o
  Processing 'strobemeta.bpf.o'...
  File              Program   Verdict  Duration (us)    Insns  States  Program size  Jited size
  ----------------  --------  -------  -------------  -------  ------  ------------  ----------
  strobemeta.bpf.o  on_event  success       90250893  9777685  358230         15954       80794
  ----------------  --------  -------  -------------  -------  ------  ------------  ----------
  Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.

Further debugging shows the llvm commit [1] is responsible for the verificaiton
failure as it tries to convert certain switch statement to if-condition. Such
change may cause different transformation compared to original switch statement.

In bpf program strobemeta.c case, the initial llvm ir for read_int_var() function is
  define internal void @read_int_var(ptr noundef %0, i64 noundef %1, ptr noundef %2,
      ptr noundef %3, ptr noundef %4) #2 !dbg !535 {
    %6 = alloca ptr, align 8
    %7 = alloca i64, align 8
    %8 = alloca ptr, align 8
    %9 = alloca ptr, align 8
    %10 = alloca ptr, align 8
    %11 = alloca ptr, align 8
    %12 = alloca i32, align 4
    ...
    %20 = icmp ne ptr %19, null, !dbg !561
    br i1 %20, label %22, label %21, !dbg !562

  21:                                               ; preds = %5
    store i32 1, ptr %12, align 4
    br label %48, !dbg !563

  22:
    %23 = load ptr, ptr %9, align 8, !dbg !564
    ...

  47:                                               ; preds = %38, %22
    store i32 0, ptr %12, align 4, !dbg !588
    br label %48, !dbg !588

  48:                                               ; preds = %47, %21
    call void @llvm.lifetime.end.p0(ptr %11) #4, !dbg !588
    %49 = load i32, ptr %12, align 4
    switch i32 %49, label %51 [
      i32 0, label %50
      i32 1, label %50
    ]

  50:                                               ; preds = %48, %48
    ret void, !dbg !589

  51:                                               ; preds = %48
    unreachable
  }

Note that the above 'switch' statement is added by clang frontend.
Without [1], the switch statement will survive until SelectionDag,
so the switch statement acts like a 'barrier' and prevents some
transformation involved with both 'before' and 'after' the switch statement.

But with [1], the switch statement will be removed during middle end
optimization and later middle end passes (esp. after inlining) have more
freedom to reorder the code.

The following is the related source code:

  static void *calc_location(struct strobe_value_loc *loc, void *tls_base):
        bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
        /* if pointer has (void *)-1 value, then TLS wasn't initialized yet */
        return tls_ptr && tls_ptr != (void *)-1
                ? tls_ptr + tls_index.offset
                : NULL;

  In read_int_var() func, we have:
        void *location = calc_location(&cfg->int_locs[idx], tls_base);
        if (!location)
                return;

        bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
        ...

The static func calc_location() is called inside read_int_var(). The asm code
without [1]:
     77: .123....89 (85) call bpf_probe_read_user#112
     78: ........89 (79) r1 = *(u64 *)(r10 -368)
     79: .1......89 (79) r2 = *(u64 *)(r10 -8)
     80: .12.....89 (bf) r3 = r2
     81: .123....89 (0f) r3 += r1
     82: ..23....89 (07) r2 += 1
     83: ..23....89 (79) r4 = *(u64 *)(r10 -464)
     84: ..234...89 (a5) if r2 < 0x2 goto pc+13
     85: ...34...89 (15) if r3 == 0x0 goto pc+12
     86: ...3....89 (bf) r1 = r10
     87: .1.3....89 (07) r1 += -400
     88: .1.3....89 (b4) w2 = 16
In this case, 'r2 < 0x2' and 'r3 == 0x0' go to null 'locaiton' place,
so the verifier actually prefers to do verification first at 'r1 = r10' etc.

The asm code with [1]:
    119: .123....89 (85) call bpf_probe_read_user#112
    120: ........89 (79) r1 = *(u64 *)(r10 -368)
    121: .1......89 (79) r2 = *(u64 *)(r10 -8)
    122: .12.....89 (bf) r3 = r2
    123: .123....89 (0f) r3 += r1
    124: ..23....89 (07) r2 += -1
    125: ..23....89 (a5) if r2 < 0xfffffffe goto pc+6
    126: ........89 (05) goto pc+17
    ...
    144: ........89 (b4) w1 = 0
    145: .1......89 (6b) *(u16 *)(r8 +80) = r1
In this case, if 'r2 < 0xfffffffe' is true, the control will go to
non-null 'location' branch, so 'goto pc+17' will actually go to
null 'location' branch. This seems causing tremendous amount of
verificaiton state.

To fix the issue, rewrite the following code
  return tls_ptr && tls_ptr != (void *)-1
                ? tls_ptr + tls_index.offset
                : NULL;
to if/then statement and hopefully these explicit if/then statements
are sticky during middle-end optimizations.

Test with llvm20 and llvm21 as well and all strobemeta related selftests
are passed.

  [1] https://github.com/llvm/llvm-project/pull/161000

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20251014051639.1996331-1-yonghong.song@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Verified to fix the failure on stable 6.18 with GitHub action[1], the
BPF selftests suite still fails because of verif_scale_pyperf600, which
is unrelated and due to a different known issue[2].

1: https://github.com/shunghsiyu/libbpf/actions/runs/21024448443/job/60533518903
2: https://lore.kernel.org/all/c8c590b2-40b2-4cc0-9eb7-410dbd080a49@linux.dev/
---
 tools/testing/selftests/bpf/progs/strobemeta.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index a5c74d31a244..6e1918deaf26 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -330,9 +330,9 @@ static void *calc_location(struct strobe_value_loc *loc, void *tls_base)
 	}
 	bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
 	/* if pointer has (void *)-1 value, then TLS wasn't initialized yet */
-	return tls_ptr && tls_ptr != (void *)-1
-		? tls_ptr + tls_index.offset
-		: NULL;
+	if (!tls_ptr || tls_ptr == (void *)-1)
+		return NULL;
+	return tls_ptr + tls_index.offset;
 }
 
 #ifdef SUBPROGS
-- 
2.52.0


