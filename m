Return-Path: <stable+bounces-167117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137EAB2225F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10661560CAE
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DA52E7F11;
	Tue, 12 Aug 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Jl5Y9VlQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BD72E7632
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989454; cv=none; b=A5SypcFQ+vs2I7g6yhFFEp6n3mdNhjcpHv0l7rL16Uo2tiy/OHULGArkbkvbj9I5omc/m8hOUZZ0rKro9dq1yXnl/0H7Jgx5Jojt+kPJD6Df+UuEcD2WHC//ofSQRiOzNCgPQ7FFsMjSWn7/1y6tp5fBZEyeP4030IvAokktTzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989454; c=relaxed/simple;
	bh=jX+YEQB0b2jg/94uudyOzj3RkscIhZDeVVogCJzZ67M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrLdkxRXWyZ3aR7vCIaJlEY9mpUMMXrmCBgoe3/sPPsV0cS/NKeJ9jhJm4vcJlV3vy1ISML6r3B3My7vnbgwypMVrmk1awJub7N5eXhMZ3eNIxwld+DmqKS2oDcw0bmAFzmXEn7yD4rcisLBHNFYUn6zOnsd/TGgotbNBV7ASs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Jl5Y9VlQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-456127fa3d6so7959695e9.1
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754989451; x=1755594251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkDi9sQ4u1Zsf5AcaPzYnSO2sPwb0elGC7q2l8b77oI=;
        b=Jl5Y9VlQtRQgQ0wZapz6JmbwaoLFP6lFy1uOBPSW6zPTVaSiKkYXXB5/Yhgdk1f51I
         aGHyOg6b4cD8a3Kr7Ltqg58lvN+v4yVURDZMvVqtbPkIaw3tKOPS79iH014g3A5A0JkP
         Wxlpf89JlXrZlcWb8ktgo63426JPiVwEdADeP2uBM7vGnck3b1cZCsZme+0fdyfH0amo
         4TJtqmOuYApTj/a32MhsDZ6q9cKshyt/wnYvQlLGX42XnybAOXYgbsRvjsQPwNYum9TN
         OsFDUVTpnM5jppqVIzV4necufmbZruyzAhpGOmYdU+A3roIz1SWpvAEgdYX+XbURfzjB
         HqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989451; x=1755594251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkDi9sQ4u1Zsf5AcaPzYnSO2sPwb0elGC7q2l8b77oI=;
        b=GlBRNblG9WJFN0yt+NZRDq46V6ALg+jpHv7kY6LgxAiR5CPHHB9pq/pQcfdXRBk9tW
         uhhjpNMw1hIJLJh5Nn8B75ePz5GSyuNo7ojTYh2v/VFaE9YRAkb94v4eCz64QtIcS4cp
         AQPrIwt8OHpOpXIht2fE5FtNYvCw6rlU69Iolc11XLUSLf+jBSFzjcVmEJP7tzvvjkNd
         eFSKT56PyqGRKhzXxIQUXIjDHuHWtZt2vdNnoNI6mKlk7TPOsxsBgK7OkBZYR53s3eIf
         sMUUgQFE2vBSUvh/Ophq1zhzc2lvcaY1Va05Sm2fEOPZSc4XNeMJRwpJjfbCfVlvV7ny
         Vq/A==
X-Gm-Message-State: AOJu0Yz0h9h5jIHQhMrgaVFLFL8y8MMY5qpU8dAJWRhX/Ypd6bk2yWZl
	Zmn7ypblwvsI2bv0S7WpAaukyAy0DD4dS9GkU9J/zx1c17ue5JeSMrDw+gUQDfePhsc=
X-Gm-Gg: ASbGncvD2n66EYED06rc+X7lAapaotuk2HGX77sY1kSXEXYcbYnBpoh1geJvRMJm3rS
	uilcvH4DmLOeCd0/G3brH4wh7UoaemWk9dHT4uk6LbjYK8Br+Y0DK2JW18CYbbUuO2U1ddu7KPS
	9eawxhtknXnxSE4nbzlb/KjcTTbXqwGSkxjzS21jndI7dJX5SrNSmRQf9VF3cXCt/Nvy0sJVoxb
	io5UuMQJl+yw5Td06mkxmTOkbzTSMpips6weyzJ4ZD4YFvdvqumBk9tmX4GN/6se+YamY0U79OX
	OvtbxdEDmhXrG3TeFNiVQCdcIXHjouBU8wI4qNoTaAaN9NBuMH6rO/JNoEyBr7UpdGRE0sVRzrR
	LK8MhVbx4ZtH90aPjCFnLGd6IPtvLnA==
X-Google-Smtp-Source: AGHT+IFBefRRbVz8mjWqcsAPH9QQgYekCVsZTS4QORs3XTzsM/mOl+JX5+dSUj2YaHIFPPZ1EW6gKQ==
X-Received: by 2002:a05:600c:608c:b0:458:a753:f3a1 with SMTP id 5b1f17b1804b1-45a1404e5b0mr2724695e9.3.1754989450650;
        Tue, 12 Aug 2025 02:04:10 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8113:2b11:8f42:672f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a053a9019sm104340625e9.21.2025.08.12.02.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:04:10 -0700 (PDT)
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
Subject: [PATCH 2/2] riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id
Date: Tue, 12 Aug 2025 11:02:56 +0200
Message-ID: <20250812090256.757273-4-rkrcmar@ventanamicro.com>
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

Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 6e1554d89681..9883a55d61b5 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1763,7 +1763,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		 */
 		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
 			/* Load current CPU number in R0 */
-			emit_ld(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
+			emit_lw(bpf_to_rv_reg(BPF_REG_0, ctx), offsetof(struct thread_info, cpu),
 				RV_REG_TP, ctx);
 			break;
 		}
-- 
2.50.0


