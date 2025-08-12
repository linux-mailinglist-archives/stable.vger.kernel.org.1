Return-Path: <stable+bounces-167116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9ACB2224F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6147A905D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD812E7BBE;
	Tue, 12 Aug 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="g+0Y/5nx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7A2E7624
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989453; cv=none; b=Sb5JJ6vp1kPPkGHTLqRF5fH1+oJewP6C06sNcYjB02cfbIjLSJ5Qe5M9Kq9fbNWmFIk9NSfwQfCid0FuA/p/oc5CZ4Th70ovREPLX07DnQeLQgmpTCOc4WA+AcYjnZAgbwlwrljADUzNqFyP84R81/WHz+zoMBtrcJ/fqvtCW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989453; c=relaxed/simple;
	bh=E5jcBn3sV2aUmuDFeWJOAnGKn2umqAnu8zd+iJy0J4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+DAanee7EAmYWHeFLQxQ23aopXBENrJPH+i2206j+adhku3FSRwf90Q7slxav1qKf1b6RyZZKshGvcokG2n377kIUpkeHddw6QfV9OXJlH6+G74NZ9yS1XPzr4Drf9JmLZVNFE5XUX2FdCDZ77+8E9KNUI79VZpTbIbvTrxCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=g+0Y/5nx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7889ea74cso115968f8f.1
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754989449; x=1755594249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itAcwp1tL7JmEvs/VclPDqKZmFhrZKHjpN5MTKoCPt8=;
        b=g+0Y/5nxI1+6uP6XdS3aPL4AeXdC1cEHVM68osydwLIWeNx/8Np6qZ8JpmBcC6EZX2
         M/tFhL/EAsPQlqdqR2Mmep+eUN8qmjY9D7y9uMXFkJ52y7894mJMcCWqFb4IxwlWaHIM
         3anI6IZMb5CfmV//P+/MkLJXU1sE85hZ685H7QmqnEsrW4XM7i3p8oNpG2KMe3gHhv/8
         od29EXkFggrunFq7XfDDj+pfCO2yrcZDe0kXgK/oOvt08FfldpigfLg50QeFu098P50r
         i/UmuD2WBookjo80ZG3ILwlnH8wxrynGZ7O7f8u9I7yPJ9T+BygdTZYkpB1zCWK90tCm
         G8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989449; x=1755594249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itAcwp1tL7JmEvs/VclPDqKZmFhrZKHjpN5MTKoCPt8=;
        b=Ra9EltZWDzz2rG0ZFPYowNW/KAKi0RuPX2XHZhBjzj+bMQ63DR7lRLyPVBak9QSf9m
         4NqFgF/KsKNF786knlSCB/x7tb8yNOnwg4SZ3wYlUWTBxsEr+GZD6UyZo5LQp8UUMtPF
         XIl3dqQa7VfD2f95ym6mJqC6iOtirGOKZpv/6+P3b75oGSQLHIuFlTC3xJB9GCHH/v6N
         ptRlNnIiz9JDLbaTVyjj9t9ZEBP+aScfIe4+KbbIhB9VMirlGyBs7Os+02AHn5duC/PT
         zpTNhFBQyVVfcblkuCRieo5rI1LVYELKPrNQdi2YPAye5QYcx9LgbXphRXNSIBYdklBU
         BmPA==
X-Gm-Message-State: AOJu0YxSWiqTOjfqsNEZpC+FM+pMn5RJISbiDde6UobLFhsc+n/IRshx
	lWPXiE7MVVRQOhWrZwkvCpRBo/XrG5Pul8QUXpGsfkrljW7sgeNoxZxCWIeQWKPOpNU=
X-Gm-Gg: ASbGncugI06iNslwdj/G6wIjYJTVouOgVeLx9ga5NkXUibt9Gd82wT9bqycTE2eSaeH
	TfYRFxToKULXAYabkiz07YIFKUTNGZcCOeUs6kp6Bg4shIW9xNjE93+/QuTWOw3/57DxnFKjj+V
	lNmvjYS17eaPqq6A3VLeU9GVTKehEyztjivljVuw8NWzeLeUjXimwbaO6LyDPdUdZOoZC2sMBZY
	A6lLTpWIKAp16kyMmVg9vQN8VX+RLvkIp6wKjhwVXViccatgbVrIFwOl5fd3K/zz2FEBUDgbagZ
	G0Bv45z1KocatJ0BRGAxo/Yf2C6XUErvjKrENEd0YJNCdo17jePGz8bJnLBB1tnygJNshvCMP+Y
	LKGGerglNr0TpxiCfOvZj61jc8jZLjg==
X-Google-Smtp-Source: AGHT+IEKfx5/IibgOl7zdUM/KxazaaZ9Kt824Zr9oOR+gNUohGNLWWuXxmaBUI2dt+CetFzava53Sw==
X-Received: by 2002:a05:6000:2c10:b0:3b7:99a8:bf6d with SMTP id ffacd0b85a97d-3b9142bcf85mr298562f8f.11.1754989449200;
        Tue, 12 Aug 2025 02:04:09 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e5887b7fsm287090205e9.30.2025.08.12.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:04:08 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: bpf@vger.kernel.org
Cc: stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
Date: Tue, 12 Aug 2025 11:02:55 +0200
Message-ID: <20250812090256.757273-3-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

emit_ld is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
The struct currently has a hole after cpu, so little endian accesses
seemed fine.

Fixes: 19c56d4e5be1 ("riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 10e01ff06312..6e1554d89681 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1356,7 +1356,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 				emit_mv(rd, rs, ctx);
 #ifdef CONFIG_SMP
 			/* Load current CPU number in T1 */
-			emit_ld(RV_REG_T1, offsetof(struct thread_info, cpu),
+			emit_lw(RV_REG_T1, offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			/* Load address of __per_cpu_offset array in T2 */
 			emit_addr(RV_REG_T2, (u64)&__per_cpu_offset, extra_pass, ctx);
-- 
2.50.0


