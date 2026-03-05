Return-Path: <stable+bounces-223205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG6WGWyRqWmoAAEAu9opvQ
	(envelope-from <stable+bounces-223205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:21:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD19213328
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B11231402B9
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BACF21E091;
	Thu,  5 Mar 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4oo/Da1b"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DA246BD5
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720419; cv=none; b=CpUz+DY9FjI+7qrZNnwLYQiJYmIpeyoTIBRwfNBjxv8n+ChKCfVtpwBFOJW6Z+yjHB0R+fgVkxVm5BIeoEgXtJgBaWA+maIpo1COhUPrRfarSuzshTwXZyPZtseL1cXr8GVlIzn9aRefjaJJvWWj8Vub4Hq3z0/YAyZV9/8TcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720419; c=relaxed/simple;
	bh=PwCYRuwsKmQUe+2zlK2nZChMpzwmoFOf29G9MiF8OBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv5K8aOW9+UB/l2ifmxSXBNGY6R9RWyToZbUiNBdO+QoYH9IYYSag9b3rVST+Wsj0M+g4wNQEY6MUKbqUyWroMhwSBP4FkNCF7Z9YE2OR9hpB67ISUCmHwrhHVwH6gan6aqI7kC1peeX7Qi9L+HLrKM2o8HjK+H95znlFkAecc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4oo/Da1b; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a12f88d839so1094315e87.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 06:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772720416; x=1773325216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAuFRx7gtOPZDHLYd8gki/p+Ss0pYYeA/wECrBUdLlE=;
        b=4oo/Da1bpCa8KUfLicmCnGvLnWv6M6wxRkpEeW/utRG9zJGwakrfQDYrG5oPU7INl3
         MHGIkjvaIrkKTbhM5T9Ie4XQ8MCFzz/lO/wyFRWTBiGwLjxx7VfVfFYRT1fFiLfkKIRk
         JrgRCxfTW2QP3yGjPHAbqAPi5TfFDscTyGbc7hgo17eAbNXFzdU0553sNa31kEuAH3Sv
         yH1HX2v/4etlU68+6ktd8RxKJ2hVClCHZHQfCsXuAthM2FHcxUG9gHhyfeJcP4XtaJek
         aApRMoP1iUSD5rL9ZComaAc2ZMojbdO4vdWc2+o8sWIE3SHWTr7pF3S3O1t65laoTqm1
         Ih2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772720416; x=1773325216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAuFRx7gtOPZDHLYd8gki/p+Ss0pYYeA/wECrBUdLlE=;
        b=Y2mJ5fz2SSTqoOy2JnawW5GSs0FBjO3tVsmTGh36G1No4iMyy5TipQBb3Zlqu7YSmd
         SgRgh04akuV87n4F3jW8Xqo5xHWaM8sFh/qPJUSbtmZrQsAjIwePwuXYQ33R+G3XsJ3y
         P/LEOFMeL+OFd7ndZTOynOQ2UcLCU75uDvH6RL89S41SHVsNjoYJmwAYpMmynmpBW8c3
         2SG8pvEkyHdRKS5Q1sRDAZVQbIIej9BH8Hqi6lYSEWdTB83Rz+JZbhC4GptxKF9Gb0gf
         oqqckoEx1/f0arya8UelHVxQYP7JMw4Ki7GcfQCHxIPwkNP5kRRwhys5xHXfguxRWgL5
         AZZg==
X-Forwarded-Encrypted: i=1; AJvYcCWZh1kHOqeamhpkBZRsTTPP7qTqVEEIl5n7GYPJLraASASkjBVy/4UhaG/QIr/eRLyWtaKdUP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKLCpm14100HJrq7tQOp67FgPZN5TyX2r648djrTf0B+KS15q
	Cgaug1GbMGHXQNmAdJQQX++WV5Li0OEzg2p4mH2HfNK7CmHEsadclBSpl6Hp22KGIA==
X-Gm-Gg: ATEYQzygvHItpWPpok70jS/Fw17sF93bc4hd9JMhNEVscojoSqJAi6DFakgfdC6yGpJ
	zJ6t0XJEflBBGHQG575T7Tnmg/Ckt5418fed+KOMavqshzPF2nEQ6LV82B4PuLKl8oyCDbYLQfH
	qyN4oHbH7memeWvTeMrpC2O/RcnXSFAipE1hjz4ybppkKy3kf186AQr5GqGDdWNNOr/BuvPxPSk
	Z6+KeQClrtVkVMEGA04Q6F90Utm4c3mJ9XoNHVdXsl5y2OJPVC2xpdkoh3tuQDFlayddgPQw+xs
	OahQiB/r9ah16Df8mF2sbP3V0CkTEvyAvSkrRV0nAUPgwRloDA0H9/7rAKCZp5zhPvVSwIHNKJZ
	z7LtlmCirQmu3DRaMBlN7Y0JlBDKoiTLZ0xuciykTmadOD8EaYzHowxCpuKfzGX3Tc3zN+xXkN3
	JAMHjcV9uqnRfzcsgbf1qlqu3Gk7DB7vAEwzuQ7mKnM1Tc6pNil34pEV0=
X-Received: by 2002:a05:6512:145a:20b0:5a1:378c:11e8 with SMTP id 2adb3069b0e04-5a1378c1480mr17473e87.14.1772720415482;
        Thu, 05 Mar 2026 06:20:15 -0800 (PST)
Received: from google.com (27.69.88.34.bc.googleusercontent.com. [34.88.69.27])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13555df8csm249863e87.25.2026.03.05.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:20:14 -0800 (PST)
Date: Thu, 5 Mar 2026 14:20:13 +0000
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Fuad Tabba <tabba@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: pkvm: Fallback to level-3 mapping on host
 stage-2 fault
Message-ID: <frvqntoya3r5by3vx75eicvggmjnkrhqkxn62ealjjiuuuiwyw@rkngsfqxkxbn>
References: <20260305132751.2928138-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305132751.2928138-1-maz@kernel.org>
X-Rspamd-Queue-Id: BFD19213328
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223205-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qperret@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thursday 05 Mar 2026 at 13:27:51 (+0000), Marc Zyngier wrote:
> If, for any odd reason, we cannot converge to mapping size that is
> completely contained in a memblock region, we fail to install a S2
> mapping and go back to the faulting instruction. Rince, repeat.
> 
> This happens when faulting in regions that are smaller than a page
> or that do not have PAGE_SIZE-aligned boundaries (as witnessed on
> an O6 board that refuses to boot in protected mode).
> 
> In this situation, fallback to using a PAGE_SIZE mapping anyway --
> it isn't like we can go any lower.
> 
> Fixes: e728e705802fe ("KVM: arm64: Adjust range correctly during host stage-2 faults")
> Link: https://lore.kernel.org/r/86wlzr77cn.wl-maz@kernel.org
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> Cc: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 38f66a56a7665..d815265bd374f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -518,7 +518,7 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
>  		granule = kvm_granule_size(level);
>  		cur.start = ALIGN_DOWN(addr, granule);
>  		cur.end = cur.start + granule;
> -		if (!range_included(&cur, range))
> +		if (!range_included(&cur, range) && level < KVM_PGTABLE_LAST_LEVEL)
>  			continue;
>  		*range = cur;
>  		return 0;
> -- 
> 2.47.3
> 


Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin

