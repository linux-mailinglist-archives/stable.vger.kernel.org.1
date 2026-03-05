Return-Path: <stable+bounces-223202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHOeFhePqWni/gAAu9opvQ
	(envelope-from <stable+bounces-223202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:11:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B605F2130C8
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6183084C8E
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14439FCC2;
	Thu,  5 Mar 2026 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="f0W4rEQ0"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E003822AE;
	Thu,  5 Mar 2026 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719519; cv=pass; b=gu3HsOp5XaTPsiqBeL6Pyc4oSCDeP7y/Pu5BXZBGHx7SJabGXkoh5YgLQ96HkQLgvooEuhnKHhB9hRImFiP0eNph5h7SAaSa4MpqcyHHQ+TJzvrcpkPuVHxXqPny3OW5yBplOI9uKL3BALeJR/5DT9ZfJErhJeBSocT8xOGXFR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719519; c=relaxed/simple;
	bh=zo9ICmTJ/ruw8rwMQCav2Za6ilf7Jpw6Q77SEGEuej4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBE2l27vuSctv9NgpfLYzlcY9qcSmEVi4XtkwgCspDj/A5p3B6nGu3wSQRFrM4TCe5ls9iptouQ9Cgd0HFccyBCaTi7uvPa9WKw7uTIbFf4w6Ha9j3YFgiopFWI9umHze5CO5fgII3TPdXB7vyDGffUewtuY+t8v3i2ihrofjcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=f0W4rEQ0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1772719487; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SGEtm2X71A+Zyvsz5IuYt3BPaHHGg3SqwTpkKm9Y3/lX1wNIv8E9qEk/3Hc6jpy243OY/6Cjy3TAUNwBZqrDX+oX5zW96CV6M9127KwunTW2rtZkBuKwRvqEDJOKErPc82d4DzmDFIwtLTRwEx4cA2REbiN37tMvQaGgZEttRsU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772719487; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gAoqOfLsjvGAIEVnBkB+50AbTiOBL94J1GrFZbXASB4=; 
	b=Mj9xgBNkAMn0HcxKRpQOExWDvb+XIFkRp6ELXLWTew4z/DZcn0BqQYtw+1/vHy3uVxcEZMi4cv2BAggwBgz+qKzT1F1s6WKRlAvYq+568IdMtGVidTnzedufPCB/TQ64dvsgxAe+rkPEP5sP871aW4gxYXGbp6XbwKAne0Kcap4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772719487;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=gAoqOfLsjvGAIEVnBkB+50AbTiOBL94J1GrFZbXASB4=;
	b=f0W4rEQ08ZywSsP+kdYI+S5tmXKhECqgjXahaVo2IK3BCzxSRFY58URU4e0WKMjd
	1glPNPig5iL3LX32ve/OXP6Q5QTqDFIDvye3eTkw4dBS8tgLGRVkoWrCYXLghDlHEdY
	KGwZqd5zAVnGkCrYXQ58WIP5nYOheC6ujM7c/qS4=
Received: by mx.zohomail.com with SMTPS id 1772719484031333.1251227233647;
	Thu, 5 Mar 2026 06:04:44 -0800 (PST)
Date: Thu, 5 Mar 2026 14:04:24 +0000
From: Yao Zi <me@ziyao.cc>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: <andrew.cooper3@citrix.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<stable@vger.kernel.org>, <tglx@kernel.org>, <x86@kernel.org>,
	David Wang <davidwang@zhaoxin.com>, <lukelin@viacpu.com>,
	<brucechang@via-alliance.com>,
	"TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>, <cooperyan@zhaoxin.com>,
	<benjaminpan@viatech.com>, <TimGuo-oc@zhaoxin.com>,
	<QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
	"CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin
 C4600
Message-ID: <aamNaEcpOAH17QWA@pie>
References: <20260228173704.62460-1-me@ziyao.cc>
 <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70139192-54e5-4a4b-bc96-1fe3ec4f7a0b@zhaoxin.com>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: B605F2130C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.84 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223202-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	NEURAL_SPAM(0.00)[0.951];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziyao.cc:dkim]
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Mar 05, 2026 at 05:03:07PM +0800, Tony W Wang-oc wrote:
> Thank you for submitting the patch to fix the Zhaoxin CPU issue.
> 
> After internal clarification, we have confirmed that this is an
> issue with the ZX-C CPU ucode:
> When modifying CR4.FSGSBASE bit 16, the ucode propagates its
> value to another MSR register. During execution of FSGSBASE-related
> instructions, the hardware actually checks whether this MSR
> register's bit is set to determine whether to generate a #UD
> exception.
> When the CPU enters SMM mode and then returns via RSM, the CR4
> register is restored but the value of CR4.FSGSBASE is not
> re-propagated to the MSR register.
> As a result, after enabling CR4.FSGSBASE, once the CPU goes
> through SMM mode, executing FSGSBASE-related instructions will
> trigger a #UD exception.

Thanks for confirming the issue and the explanation!

> This issue exists only on ZX-C CPUs, which have two different
> CPU vendor IDs and distinct FMS values. The following patch can
> be used to identify ZX-C CPUs and properly handle this issue:

However, I agree with Andrew that a ucode update, if possible, would
be the preferred way of fixing the issue up.

> --- a/arch/x86/kernel/cpu/centaur.c
> +++ b/arch/x86/kernel/cpu/centaur.c
> @@ -201,6 +201,11 @@ static void init_centaur(struct cpuinfo_x86 *c)
>         set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
>  #endif
> 
> +       if (c->x86 == 6 && c->x86_model == 15 && c->x86_stepping >= 14) {

Are this condition and the one below in zhaoxin.c precise enough to
recognize all and only the affected ZX-C models, without mistaking
unaffected designs even from VIA? Please see also my concerns raised
previously[1].

Though I haven't tried yet, since reproduction of the problem requires
entrance to SMM at least once, it may be hard to detect the quirk by
executing rdfsbase and seeing whether it traps. So if the conditions are
precise enough and a microcode fix isn't appropriate, I'd like to stick
with CPUID matching in v2.

David, Andrew, is it okay for you?

> +               pr_warn_once("CPU has broken FSGSBASE support; clear
> FSGSBASE feature\n");
> +               setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> +       }
> +
>         init_ia32_feat_ctl(c);
>  }
> 
> diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
> index 031379b7d4fa..6a2d6df307ee 100644
> --- a/arch/x86/kernel/cpu/zhaoxin.c
> +++ b/arch/x86/kernel/cpu/zhaoxin.c
> @@ -89,6 +89,11 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
>         set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
>  #endif
> 
> +       if (c->x86 == 6 && c->x86_model == 25 && c->x86_stepping <= 3) {
> +               pr_warn_once("CPU has broken FSGSBASE support; clear
> FSGSBASE feature\n");
> +               setup_clear_cpu_cap(X86_FEATURE_FSGSBASE);
> +       }
> +
>         init_ia32_feat_ctl(c);
>  }
> 
> Sincerely
> TonyWWang-oc

Much thanks for the information.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/lkml/aaQCLOMdJCWNF-dA@pie/

