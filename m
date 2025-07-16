Return-Path: <stable+bounces-163095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B06B072E1
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44E1018911AE
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFDE2F1FF1;
	Wed, 16 Jul 2025 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HvbrLASY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C01D5CED
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660820; cv=none; b=ETPs7k1fP9mOlSphKWWZf5kG3x7qnBL2aYY3lBRYl77u72vLgQxEF4/vpGd2ncF5hj0pG0vv+WUHQW1zvihyfJMCFSbfETLDfjw5U95RUwZh+wnWV+gQH/muVnyKhv5EuiLCU2S+VAMrz1pCZN81D2gmLy58aFRmWjJuDt3h8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660820; c=relaxed/simple;
	bh=viO8rwTsUKi5COCCYybRz82V9Iu+VK1O25yYaxUyd9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a15ZHPKf9YSzN8FhWLQSOdm1+nOSwCnkz6/8g/LnAf49I1ZTypDnJyj2pQntFSY/BOnl4cODrIR6RRvpyhkf8AavnOU2CV/1omzsY7y0gHE9l4MyzYJqcWP8Dz0Uk1bL5wmkah0Dyo9ANDw3eULMX/Q4swH283zbge/TnEua/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HvbrLASY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so473778f8f.1
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752660817; x=1753265617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpt+9Qss+w8E1DAkR9uyV13yqefTDDIaUlADRRVU5Is=;
        b=HvbrLASYEUwfMU5sI36ciEtwM8I9t8AOaYZ1Y8zyEWDP8PWELsQ3dEBFRTXQdRqp1U
         D9Gff0gxtdPIUq9s0w0p9TyC+cxqR2HZ8CjB1ogNtkg08xzl4x4n7+ZypaETtW3PeMWF
         I5orscw2AwDCpA04Pv36Vo4ZAWhf4QOD7Tk9bkF7RrvFDMuihSab0KISdn4iDuIwytni
         p7FqZFM+C/UXiwntmiNTmUSa4jZlH4J6W3FZC3pZUtBiot2PNMGJ6zsGkA86/83SzVdE
         pLNFWy+qa9fbEgsYf4CJhM6N5abmRseeVr8oVFelM5GhFE6yIuTm8WpptL68KZDUa1/7
         +wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660817; x=1753265617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpt+9Qss+w8E1DAkR9uyV13yqefTDDIaUlADRRVU5Is=;
        b=ptunQUFsgcOYN4O40Bl/MC6rQapXnvt8iZhaNHj5UaxApQ6BNVsYG8JRdw9O+Cg7Uw
         HfDMtBcf+KG15RK1LWLLVKd3N8ZXEOoeEAyEMq2BiWZUusHM6Zcmz7pCfnGgRV9pC0uG
         aQcewu+j8RwkRqOPbVFICuUrjhuZzsfctEXqJWsGgcdlIVXgR4rX7LU5HbZfOthdBmUW
         /pk4fDCAybqjtoRYvhrM5Rg+k4/y/MjvqVEYSGkp9nAioq6LJYVH+4KZspOeDUoKBPWx
         4s6+2xwdBXD/9qtHLT1lSNpsCWsiiO9cJefbokzZpSpmqvKakwKvs9Y8sRxhlw5D2GJ4
         O2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWxkcQRYUAePmfyzA7UgvBlr8qL0IzXtd1AcQX3c8bC96B2aXUgCuy7xEwTmSFo9nHvXTPLghI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7l6V9ftUZguIlGJ4CY3zw3fW1JlEaLLboUyACzTlSUhpAn1Bs
	p3KfSwVvZSZ+WEon9v/2pMpXsBhlpIVRIeJu+oZNRzdqII6EsU8F+aIzZsfrRJCEVp8=
X-Gm-Gg: ASbGnctcuD1FD4vtXv3bcAD91JGTNYcSTw3ZCnhqswQATK19ZQME8fMGEjehG1hlsPC
	n49rWk+lu+vuPgH8aoKl/Q/Us6SeyOWz2xlzm/JhIGs3OQZSrBq8RU5s0qPncv2uEKFTBZVpGIC
	A/3OR/vSQH/i01F9ht8JUjbVze/p5oz2WfE7c+61ak2XDtRFV1BZNhGoKtNTQFzfwkYVkf0ZSVn
	0CrZ3b/s6wBlztmf6OrGTDqWDOnwNxzZAJz7Y1KvTaJGwCXdBliLP5UxW7BoOeZBJCSAKLkg/t4
	rRu/9yeVRMarYa0gbw/GHCczacsoAWwzdki3M0DCkxH0h3cIW23P9i4BHVSW0iH2BQpC2pq0gnl
	BZ5MYtHrDJJdiwnGhhRiZurPNKibLU1ZP2K3Yw9SQUHxD/w0=
X-Google-Smtp-Source: AGHT+IHqe/AzSltctTUR8ILGEpGESU6BloFfOZH1jyFHxcaPp3B17lsKfauNv79LiMDN0igXk3HRpw==
X-Received: by 2002:a5d:5d12:0:b0:3b6:99:5611 with SMTP id ffacd0b85a97d-3b60953f531mr6013335f8f.20.1752660817083;
        Wed, 16 Jul 2025 03:13:37 -0700 (PDT)
Received: from u94a (114-140-120-56.adsl.fetnet.net. [114.140.120.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc21e7sm17430699f8f.36.2025.07.16.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 03:13:36 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:13:26 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, 
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
Message-ID: <4goguotzo5jh4224ox7oaan5l4mh2mt4y54j2bpbeba45umzws@7is5vdizr6m3>
References: <20250524041335.4046126-1-yonghong.song@linux.dev>
 <20250524041340.4046304-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524041340.4046304-1-yonghong.song@linux.dev>

Hi Andrii and Yonghong,

On Fri, May 23, 2025 at 09:13:40PM -0700, Yonghong Song wrote:
> Add two tests:
>   - one test has 'rX <op> r10' where rX is not r10, and
>   - another test has 'rX <op> rY' where rX and rY are not r10
>     but there is an early insn 'rX = r10'.
> 
> Without previous verifier change, both tests will fail.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)

I was looking this commit (5ffb537e416e) since it was a BPF selftest
test for CVE-2025-38279, but upon looking I found that the commit
differs from the patch, there is an extra hunk that changed
kernel/bpf/verifier.c that wasn't found the Yonghong's original patch.

I suppose it was meant to be squashed into the previous commit
e2d2115e56c4 "bpf: Do not include stack ptr register in precision
backtracking bookkeeping"?

Since stable backports got only e2d2115e56c4, but not the 5ffb537e416e
here with the extra change for kernel/bpf/verifier.c, I'd guess the
backtracking logic in the stable kernel isn't correct at the moment,
so I'll send 5ffb537e416e "selftests/bpf: Add tests with stack ptr
register in conditional jmp" to stable as well. Let me know if that's
not the right thing to do.

Shung-Hsi

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 98c52829936e..a7d6e0c5928b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16456,6 +16456,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 
 		if (src_reg->type == PTR_TO_STACK)
 			insn_flags |= INSN_F_SRC_REG_STACK;
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	} else {
 		if (insn->src_reg != BPF_REG_0) {
 			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -16465,10 +16467,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		memset(src_reg, 0, sizeof(*src_reg));
 		src_reg->type = SCALAR_VALUE;
 		__mark_reg_known(src_reg, insn->imm);
+
+		if (dst_reg->type == PTR_TO_STACK)
+			insn_flags |= INSN_F_DST_REG_STACK;
 	}
 
-	if (dst_reg->type == PTR_TO_STACK)
-		insn_flags |= INSN_F_DST_REG_STACK;
 	if (insn_flags) {
 		err = push_insn_history(env, this_branch, insn_flags, 0);
 		if (err)

> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
...

