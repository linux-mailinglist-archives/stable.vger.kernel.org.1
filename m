Return-Path: <stable+bounces-241979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFPJCfO88mlbtwEAu9opvQ
	(envelope-from <stable+bounces-241979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:22:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB749C479
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1C91301A28B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3294F261B9B;
	Thu, 30 Apr 2026 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lJ7cmyo1"
X-Original-To: stable@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCE288C30;
	Thu, 30 Apr 2026 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515740; cv=none; b=FthI0BtAxRAlG1HZ74eRyAgSd9x7ZXkxu3eqMujzjJ2RbUipvVyeqAUgNDgxk3tlq1OZWzzjY40vQMqT3e4t1WJf990Hv9nUYKkSsolMXBVyMC7Lb1d/tMm0lujo1AICf+suBM/TJUJQ+RtVAfsVMMXI2dBpq8Uk2lesT3UcnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515740; c=relaxed/simple;
	bh=kskXGl60052vWFg2uJaxvo0jP+mKoelIHMmuGjmHezA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HayZE5hrLqqjqJPTz09V1jMRAWjX+VqbRCGUI0zJuRjv7GkES+AYMEH8WH5GGKLE85gjFiuqwErVAnLRzSbZE9bVFFNBupiLrUyKOdgPKydiRqiAMRL1E/ZUuUTwfSSEZvFhhluQd8yA82uqDkSoIugzji09UO2CYaNz+arHdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lJ7cmyo1; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777515728; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=H46ycR2cIdd55PmtPaTFZw2OcVc3hi3Ihdl6EegFnqI=;
	b=lJ7cmyo1tUN1B8eGVCIvY1nnLRNPxZMKHVZiM4AE38UAZxzxsyRWn92/OeuMd77bK3YEOZwkWA2HJSUH+DAc4mee6C6OqaiaWHbG7uuKGUC/PVw1r3PZH3D8Z83pX43dXQdDvs1GFglTxU3GsrgVDyLYeDWbGVNUwgdcEEh42Jw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X1za2vT_1777515727;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X1za2vT_1777515727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Apr 2026 10:22:08 +0800
Date: Thu, 30 Apr 2026 10:22:07 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Fuad Tabba <tabba@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, vdonnefort@google.com, 
	catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] KVM: arm64: Make EL2 exception entry and exit
 context-synchronization events
Message-ID: <ygj3ik6y6kqggfnoyz72klhk3ttv72qv2ob4qferjdo7wvtxc7@zvhup2sqtc2p>
References: <20260428103008.696141-1-tabba@google.com>
 <20260428103008.696141-2-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428103008.696141-2-tabba@google.com>
X-Rspamd-Queue-Id: 90EB749C479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241979-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yaoyuan@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 11:30:01AM +0800, Fuad Tabba wrote:
> SCTLR_EL2.EIS and SCTLR_EL2.EOS control whether exception entry and
> exit at EL2 are Context Synchronisation Events (CSEs). Per ARM DDI
> 0487 M.b, EIS is governed by D1.4.2 rule RBBSRF (p. D1-7205) and EOS
> by D1.4.4.1 rule RBWCFK (p. D1-7209). D24.2.175 (p. D24-9754):
>
>   - !FEAT_ExS: the bit is RES1, so the entry/exit is unconditionally
>     a CSE.
>   - FEAT_ExS: the reset value is architecturally UNKNOWN; software
>     must set the bit to make the entry/exit a CSE.
>
> INIT_SCTLR_EL2_MMU_ON in arch/arm64/include/asm/sysreg.h sets neither
> bit. KVM/arm64 hot paths rely on ERET from EL2 being a CSE, and on
> synchronous EL1->EL2 entry being a CSE, to elide explicit ISBs after
> MSRs to context-switching system registers (HCR_EL2, HFGxTR_EL2,
> HCRX_EL2, ZCR_EL2, CPACR_EL1, CPTR_EL2, SCTLR_EL1, ptrauth keys,
> etc.); examples include the activate-traps path,
> ptrauth_switch_to_guest, and the FPSIMD trap re-enable in
> kvm_hyp_handle_fpsimd. On FEAT_ExS hardware those reliances are not
> architecturally backed unless EOS=1 (and, for entry, EIS=1), and
> whether they hold today depends on firmware initialisation outside
> the kernel's control.
>
> Make the guarantee explicit: include SCTLR_ELx_EIS | SCTLR_ELx_EOS in
> INIT_SCTLR_EL2_MMU_ON so that EL2 exception entry and exit are
> unconditionally CSEs regardless of whether FEAT_ExS is implemented.
> This matches the pairing in arch/arm64/kvm/config.c which treats EIS
> and EOS together as RES1 under !FEAT_ExS.
>
> INIT_SCTLR_EL2_MMU_OFF is left unchanged: that path is used during
> very early EL2 init and the EL2 MMU-off transition, neither of which
> relies on these bits in the same way.
>
> Fixes: fe2c8d19189e ("KVM: arm64: Turn SCTLR_ELx_FLAGS into INIT_SCTLR_EL2_MMU_ON")
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 736561480f36..7aa08d59d494 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -844,7 +844,7 @@
>  #define INIT_SCTLR_EL2_MMU_ON						\
>  	(SCTLR_ELx_M  | SCTLR_ELx_C | SCTLR_ELx_SA | SCTLR_ELx_I |	\
>  	 SCTLR_ELx_IESB | SCTLR_ELx_WXN | ENDIAN_SET_EL2 |		\

Hi Fuad,

> -	 SCTLR_ELx_ITFSB | SCTLR_EL2_RES1)
> +	 SCTLR_ELx_ITFSB | SCTLR_ELx_EIS | SCTLR_ELx_EOS | SCTLR_EL2_RES1)

LGTM.

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

>
>  #define INIT_SCTLR_EL2_MMU_OFF \
>  	(SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
> --
> 2.54.0.545.g6539524ca2-goog
>

