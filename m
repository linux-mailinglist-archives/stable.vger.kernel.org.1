Return-Path: <stable+bounces-272377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7t0UDWC3TGplogEAu9opvQ
	(envelope-from <stable+bounces-272377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:22:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67471906C
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 10:22:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=aqC1KGd5;
	dmarc=pass (policy=reject) header.from=canonical.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272377-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272377-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCE87301D4FF
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA3431D39A;
	Tue,  7 Jul 2026 08:21:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C142C237C;
	Tue,  7 Jul 2026 08:21:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412495; cv=none; b=fIcjoM7ZiHilHY+8daXFrJE/7ZSJtNTGIhP/mJG75NCUVkGb0/V1MVaq6vY2FibrZIrpbQET0bhfTuAteVQQibpHOI6W//HFRVAY3H5IixxF8bth76oSB4/mAHus5aIDU2NP3qb2R3ZIGER2kY2qaRxwFbmaFrgfBjs910CPZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412495; c=relaxed/simple;
	bh=kETmYOc5Y5R2f+aEsC3VA7txJkkcZXPhwxFxo7VeYgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHJxDZHknteTMDCwaXblQ74DNpAxuTwMJRRuBBmCcXrpTA7RdZUqqFvuwaftiTtBQFliQiunB5LHYRMnrhZSi+qsVIMDnx/XT8BOV2bGSdnuz8gU5phUPi2+CkdPJCmH5sHtF0/v0bQCItCA5kIArxXm3oHFkzUESPPxwOo6XN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=aqC1KGd5; arc=none smtp.client-ip=185.125.188.120
Received: from [192.168.1.7] (unknown [120.238.231.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0FE01408C2;
	Tue,  7 Jul 2026 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1783412491;
	bh=aNNNIkpjkV4G09smVjhidBNe4nWgPtemlA8/+5cHQAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=aqC1KGd59OZwMJhjRE4DbAjRibf92EX59xnmALodD0cDdk8EFLYrkdf1Ygq58ewIs
	 GHVNCpxu8RCPQKgCoyx8CWBH4JxD/3mZUHssW+2DY1lQH+scILaUbMOEDRw1Mfh37i
	 Kxsc/U4pfFbocok68CzExkeib+qEDi9daZE/pGka5AOF4pdCq87mHZo+xPtyYkRnRs
	 5msOqP62nRO2Ce5J/RQzy3FrAAlYT2v9ie8IjhQPBEbxrusYuc6n9bfxhXFpk6RUnZ
	 IBi9Y1xV7SxEXk20nS/uD9C12qXrS9Ut/RsWhQhQkJmRaL8gA1mHoAmNDu8ps9VnWS
	 HAoUdTXbNtSqn5gGeBGZpPcZT3Ibrjd6FjqUWJwxDpbUf2WSFPFYIxMdIMoDNubsVm
	 RyfXysjq2G/TO7e1YFAIeSiYn0l7wSwwOVTyanJ2ZmqFm20ZdmAwtW2zkuLBOery4k
	 GYY8wx5ji7aNG/EdclB9KCm4dfp0GJlt2yClH9SMvfhFcFPxP5XOLPRBnUp3g8fWiQ
	 Fb3q+mQmhSDK33OAHEBPqEHcmpULMV+3S3Vn5d1h8irBTxx3u890x6VyPAy36WKvcB
	 Uqji0EFcWQbYzA/RlXmYW5IEnBJFwV2pPJrHu0BDZX5r1lWJdsuOGgsosMrou7an7s
	 b2IQJQkEmsnbDgrb75L7VOHU=
Message-ID: <881386ac-5a70-4141-9de3-cb9ef7a7bab2@canonical.com>
Date: Tue, 7 Jul 2026 16:21:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: NACK: [PATCH] selftests/rseq: Fix a buliding error for riscv arch
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, shuah@kernel.org,
 paulmck@kernel.org, boqun@kernel.org, zhouquan@iscas.ac.cn,
 ajones@ventanamicro.com, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: stable@vger.kernel.org
References: <20260707081720.36510-1-hui.wang@canonical.com>
Content-Language: en-US
From: Hui Wang <hui.wang@canonical.com>
In-Reply-To: <20260707081720.36510-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272377-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hui.wang@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mathieu.desnoyers@efficios.com,m:peterz@infradead.org,m:shuah@kernel.org,m:paulmck@kernel.org,m:boqun@kernel.org,m:zhouquan@iscas.ac.cn,m:ajones@ventanamicro.com,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.wang@canonical.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:from_mime,canonical.com:email,canonical.com:mid,canonical.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E67471906C

There is a typo in the subject, will send a v2 to fix it.

On 7/7/26 16:17, Hui Wang wrote:
> RISC-V rseq selftests include asm/fence.h from tools/arch/riscv,
> but the rseq Makefile only adds tools/include in the CFLAGS, this
> results in the building failure both for native and cross build:
>
>      In file included from rseq.h:131,
>                       from rseq.c:37:
>      rseq-riscv.h:11:10: fatal error: asm/fence.h: No such file or directory
>
> To fix it, add the matching tools/arch/$(ARCH)/include path in the
> CFLAGS and derive ARCH from SUBARCH for standalone native builds where
> ARCH is not set.
>
> Fixes: c92786e179e0 ("KVM: riscv: selftests: Use the existing RISCV_FENCE macro in `rseq-riscv.h`")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   tools/testing/selftests/rseq/Makefile | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 50d69e22ee7a..aba6317f6cb8 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -5,9 +5,13 @@ CLANG_FLAGS += -no-integrated-as
>   endif
>   
>   top_srcdir = ../../../..
> +include $(top_srcdir)/scripts/subarch.include
> +ARCH ?= $(SUBARCH)
> +LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>   
>   CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
> -	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
> +	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include \
> +	  -I$(LINUX_TOOL_ARCH_INCLUDE)
>   LDLIBS += -lpthread -ldl
>   
>   # Own dependencies because we only want to build against 1st prerequisite, but

