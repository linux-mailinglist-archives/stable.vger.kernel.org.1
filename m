Return-Path: <stable+bounces-223838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GALlLQXnr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:40:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 171DF248A9E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B557131A1545
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45363438FE7;
	Tue, 10 Mar 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJEJ7iZ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBE42DFFD
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134864; cv=none; b=thYKrYCNyMU5Dxxg/kOjadgm+fOxid5VQp5DGUsIrtlNMGfakV127PzwAgPYu+9eyju2o3iowHJO1sRFCUoVoxwAQ4WgncRsAmISky+vojRI6KNDUJPo+TzmUwD/jkMusguuTXwSkHJMaPbKn2vhE5kq2dQu9eafCMhavh1Sm20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134864; c=relaxed/simple;
	bh=D7ObvPSYJaCOfp/8eCZNwv9y3mCkOjCMhOnGCGubwyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgbFUuQbTteKNSTIR9rsv2BeFX1y5uAcLcuuwsbV+LMlf76YCVmotQAkA0I2ZOuGC7Qu9f/C/ToWI0LKFV+983uxkeGNG7kJIIcetpI6+wmu7zqOxMBuOkuwrAl0zvzoKfVZUHvbQCylmekH7p/+e/R7hYUWVN2zc2lfRuRNmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJEJ7iZ4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so19785765e9.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773134861; x=1773739661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6mbdjmVIwUUAco7q5KTIV1hgiOZLKIqNBms+EgWnbs=;
        b=dJEJ7iZ4eGs1jVg8LvOJQImv+xYpF8TqlR5j3/QZKCIkZWES7pDz0qTR06jGsBOON3
         /ssv6GoP96+0R9JodRigRBb9TCkyRdT7kGl7xXhGYhK3ZvZfR1biHnaW5KwLJdjtuGVY
         Xe2aVCJHy5G/uUqByN37NkklM3zHVR38TSNsOxRmzi9n5rB+fOk7sFd8PXYuR4EeiIi/
         UNSNrjmfvzJ/gExMQXYKk/XbZogDDbHftt4R9iZfUFK8nrVargFXo5qsUdarlwGbeCWt
         WeJCnxsz9ZAO9B8meczTEVuTRHD1Aoa+mRC821tc1PaVgSXal2SJab9tto+xwudnvwwW
         VFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134861; x=1773739661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6mbdjmVIwUUAco7q5KTIV1hgiOZLKIqNBms+EgWnbs=;
        b=SnMJ/aMr4ZMrX+XE/+9UjkkEllUI6V/xbgymRii5X3mC1y+XEmOzYQQKZTuUjZt59D
         sPucXFMFauRmba8E7EVe3otDrnr2QqeYQwMgHlcXAj6zEd0yw6GDIIfYu/zHX2qwmPIA
         3/1t+qppQlIy/lL994xwQkkpNwQB1Kijx8ZBZ230sJuqcB6CKz2rZD2rkBxujgVx1Eb4
         9zyC4BKP+qKPQRr1M+36I/tq8Gcky6r8Vw1r0qVDj7X2er/1CRPOe/9emAx054YAY9VI
         h/LIqpBGf736L4RqW6JfX2pHet6KkP+PSvKplTDdDJSYWZz/vbBjzFb1P9an8jwYxLUe
         L2UA==
X-Forwarded-Encrypted: i=1; AJvYcCUYjNYeUNxp4t2EdioyoKdiIOTt+6HrssNJAa4r6AntCpRcXJjcQ1yacrvEWxYNDrAin6tTwZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1gRKixoGTZomIysohgCChEYV8kmGg39TtDaDZdp0BUi8s2u1
	TqUGNDk+RsqrErRc4RA1u8QUh/0sPXe9MS0BakRFIYLAaErV1s52sXEhqZy2rMrhyw==
X-Gm-Gg: ATEYQzyTEgF6SFjip7HiTBfk9ps+jv9qT9b5V2CGiKGEPyePJTVcIHlqH6qmesuAIBC
	gblN3/gOx9YuTml6UbPMQHpbxiazWOQf2KY6bPMa0YDn3OJL05Uajgp/37k3ppqfDPpspbPsXIq
	ZhAd9bItJT3gtc31nwd2FIfPJBo611xof7CH+8lL1yQX0Fp3pfYdL+kfmQrn3nIc/PfneZ7aWPf
	7wgTlVa7hEk14e6sP6FH0WXxRMByCgVpvcuVX6bguk5iMnVnPnGGka/3SyN5fkB7/Cbt3KO9qqN
	onxcXIXQHEbBWghPDVikL+SEiYK5wlpXJMT3Vipg2Lmkvqhq6CWVBNaRo2+ZwnI28i/dDHTBExu
	1KH3abSRZJf9xjl49VJGy7nj9jP0sernIuXEnExM/0g3PYtDrIZReEca8uRsQiD458gPOqhO1fc
	YAv1dIsKraakoQbO4lTuV+i40ReOS4HCpCgo+IjdRPLE0jlKTO86kqz8kQ5LTEHyNx/8XnhBdFU
	RJN3g==
X-Received: by 2002:a05:600c:500d:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4852695b9f7mr235710785e9.16.1773134860464;
        Tue, 10 Mar 2026 02:27:40 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853f8f9938sm31136055e9.23.2026.03.10.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:27:39 -0700 (PDT)
Date: Tue, 10 Mar 2026 09:27:35 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Joey Gouly <joey.gouly@arm.com>, Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Quentin Perret <qperret@google.com>, Fuad Tabba <tabba@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: pkvm: Don't reprobe for ICH_VTR_EL2.TDS on
 CPU hotplug
Message-ID: <aa_kBwF3dv8L6TD8@google.com>
References: <20260310085433.3936742-1-maz@kernel.org>
 <5a5afd0a-de2d-4697-a5ba-0e470ddb20f2@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5afd0a-de2d-4697-a5ba-0e470ddb20f2@arm.com>
X-Rspamd-Queue-Id: 171DF248A9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223838-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 09:17:43AM +0000, Suzuki K Poulose wrote:
> On 10/03/2026 08:54, Marc Zyngier wrote:
> > Hotplugging a CPU off and back on fails with pKVM, as we try to
> > probe for ICH_VTR_EL2.TDS. In a non-VHE setup, this is achieved
> > by using an EL2 stub helper. However, the stubs are out of reach
> > once pKVM has deprivileged the kernel. The CPU never boots.
> > 
> > Since pKVM doesn't allow late onlining of CPUs, we can detect
> > that protected mode is enforced early on, and return the current
> > state of the capability.
> > 
> > Fixes: 2a28810cbb8b2 ("KVM: arm64: GICv3: Detect and work around the lack of ICV_DIR_EL1 trapping")
> > Reported-by: Vincent Donnefort <vdonnefort@google.com>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >   arch/arm64/kernel/cpufeature.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index c31f8e17732a3..947ff71b3b66b 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2345,6 +2345,9 @@ static bool can_trap_icv_dir_el1(const struct arm64_cpu_capabilities *entry,
> >   	    !is_midr_in_range_list(has_vgic_v3))
> >   		return false;
> > +	if (system_capabilities_finalized() && is_protected_kvm_enabled())
> > +		return cpus_have_final_cap(ARM64_HAS_ICH_HCR_EL2_TDIR);
> 
> Is it a worth adding a comment here ? Otherwise this looks very odd -
> Returning the system state of a capability for a "hotplugged" CPU.
> 
> Otherwise
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Tested-by: Vincent Donnefort <vdonnefort@google.com>

> 
> 
> > +
> >   	if (is_kernel_in_hyp_mode())
> >   		res.a1 = read_sysreg_s(SYS_ICH_VTR_EL2);
> >   	else
> 

