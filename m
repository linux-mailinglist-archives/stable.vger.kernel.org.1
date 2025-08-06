Return-Path: <stable+bounces-166693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D72EB1C405
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C970218A3F1E
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 10:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E831F03FB;
	Wed,  6 Aug 2025 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="TXTmBTe3"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-37.ptr.blmpb.com (sg-1-37.ptr.blmpb.com [118.26.132.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C7367
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474723; cv=none; b=hTuMlbluvRTTFU4snK5lUcRIyqzcLkSTPYgzJM1znmAyKgCTZMRf9v1luJeLbMxdlGBnFoUq+WTwmamMMweLCH4GSrQgEngaa4YlgmQaMObLTn6ch408rIM54fW7dMvO3QzhNFqZA+rArNpWWHLm0V7B3Uh+dGz7hxXrDpBc4Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474723; c=relaxed/simple;
	bh=B6sQ1NetsPTmtFsLdHDYYBU+L1q12bILqn6b3beWkGs=;
	h=Cc:From:To:Date:Message-Id:In-Reply-To:Content-Type:Subject:
	 Mime-Version:References; b=grvMAZST1fqic6x/XQVgMhv7JGaDYGvL4niEdvOFUwiSvsUeweJmofZ26jult4JLs5RlzmLim4sxyWkhAYjaqiMjyoJ7gtB0IPyuIdDWGCpuEAQkTlcmY0oth0CcVtCTGGyzFEQJ/ujOdCgqKvWymmEcTm9LjwrMwud+D0o4WO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=TXTmBTe3; arc=none smtp.client-ip=118.26.132.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1754474707;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HAuif9gFjp03a1ED0sRYhN2Xh+Oo5vYjt6vdU6y4qaw=;
 b=TXTmBTe33mszmANQficYSPl82udgMtn/ERcp3bvHMULbkLB+iKJfuYQ8Q9FGac5AsEtR3a
 K6GACDuM8lcDfkiBMHfyQQoKdWjXI5NIT5F97VfnNr30VqCHY5P8N7o6h2KNb4uES9KOGj
 U9CqhvjdIKvBrxBpFkKLP90Or0vwvgWWuclFafJol5k9B2fnfVwOstmjHY0L6faXSTamF5
 wVIa2GXEHx0Nn7QYYwPCeIB55n7qgThSfM7PPoehSYdD2hRCXqqAj9PC9uCnEhqfyGGOFh
 hIDEoQzMGvWqmsVPmct0tQmOGBvQIjcNAHSxhgetQwUmToDE1mnMZDQztODsHw==
Cc: <kvm@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, "Anup Patel" <anup@brainfault.org>, 
	"Atish Patra" <atishp@atishpatra.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
	<stable@vger.kernel.org>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
To: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
	<kvm-riscv@lists.infradead.org>
Date: Wed, 6 Aug 2025 18:05:02 +0800
Message-Id: <3d7df3b0-27c5-47a2-a4a1-dde168e7848e@lanxincomputing.com>
X-Lms-Return-Path: <lba+2689328d1+65a5a5+vger.kernel.org+liujingqi@lanxincomputing.com>
In-Reply-To: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
Content-Transfer-Encoding: quoted-printable
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Wed, 06 Aug 2025 18:05:03 +0800
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Subject: Re: [PATCH] RISC-V: KVM: fix stack overrun when loading vlenb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>

On 8/5/2025 6:44 PM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> The userspace load can put up to 2048 bits into an xlen bit stack
> buffer.  We want only xlen bits, so check the size beforehand.
>
> Fixes: 2fa290372dfe ("RISC-V: KVM: add 'vlenb' Vector CSR")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>
> ---
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty
>   arch/riscv/kvm/vcpu_vector.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index a5f88cb717f3..05f3cc2d8e31 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -182,6 +182,8 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vc=
pu,
>   		struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_context;
>   		unsigned long reg_val;
>  =20
> +		if (reg_size !=3D sizeof(reg_val))
> +			return -EINVAL;
>   		if (copy_from_user(&reg_val, uaddr, reg_size))
>   			return -EFAULT;
>   		if (reg_val !=3D cntx->vector.vlenb)

