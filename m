Return-Path: <stable+bounces-272766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jxmTN8PXTmoYVQIAu9opvQ
	(envelope-from <stable+bounces-272766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 01:05:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262172B09E
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 01:05:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Dya7nyRR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272766-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272766-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A06430209C6
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 23:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9399E38B14B;
	Wed,  8 Jul 2026 23:05:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535AE202963;
	Wed,  8 Jul 2026 23:05:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551936; cv=none; b=sb/MdfwIuh2xc+y/hb/8wI+PmeNzdiL54xoqRGr+Dt2lhMTmjbmdbyhxMGFyZQRvKIZNLLA1tE98ViR4HXmLPoJJlbPfdeojfItwLb/eTtPisKiGkU9sYHr4zcyTYf6Dw4rld49tBlSHAJ+/C43qkaYI/UgvqTVKCePlgSyqIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551936; c=relaxed/simple;
	bh=tgRB4vpOHqIrNfeLhZuFV5Qr1AO3OMMcO0TxW4/vi8g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J2RVCAtifUaQTrdJcKTTqqlwcF5xN+QeT4QGY26IBeqE3z/4Qcu05UMSD3liOyLouUAYs+zEuTA5CUF1QQvhqZNqQ87LztcAUZAVI6YpPRJz8gDTppQV/vMh/P3mz7pHg9GByIv4Nq1hx+mofuL0w1GXHUNQBO0NvqQRw0fXsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dya7nyRR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548651F000E9;
	Wed,  8 Jul 2026 23:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783551935;
	bh=IQw8Fmyq60Hd93Fj+TzQiJzIQ3vI9pEs45BmOecGf9Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Dya7nyRRTuBslB+p/TsWw7zZcOhWHzgKIIwPb2YT7ucCHpOmXS9+bk+2OgvBT7lYu
	 Q40PAZgcaBLTPbN/9AaAdmpr7XHolSCU/K1WyvJh4JCIQljF1/CATw9mVrut8Vb8N9
	 Jtdv3Tx1NbVypq99qB7ubYoeO13CsHjhayb49AffwHk40tdUDuwcr/0pYJgMPMnQsg
	 Dgu4gsi4uAvjC/oc5iI6eqGtfv3XoZP/mo04kGwm029YGnNehetoFjcoHB1u+AU/wc
	 40IVffo8Gzg23/ygelihPQ2Viq3mE7xc4kSeej34ryNdt3mPmbxM1maY5z7BeSBXjj
	 V+C+BGlci8hMA==
Date: Wed, 8 Jul 2026 17:05:29 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Hui Wang <hui.wang@canonical.com>
cc: mathieu.desnoyers@efficios.com, peterz@infradead.org, shuah@kernel.org, 
    paulmck@kernel.org, boqun@kernel.org, zhouquan@iscas.ac.cn, 
    ajones@ventanamicro.com, linux-kselftest@vger.kernel.org, 
    linux-riscv@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] selftests/rseq: Fix a building error for riscv arch
In-Reply-To: <20260707082348.36896-1-hui.wang@canonical.com>
Message-ID: <073d4140-ac91-1b5d-26a2-f519d6a2792b@kernel.org>
References: <20260707082348.36896-1-hui.wang@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272766-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hui.wang@canonical.com,m:mathieu.desnoyers@efficios.com,m:peterz@infradead.org,m:shuah@kernel.org,m:paulmck@kernel.org,m:boqun@kernel.org,m:zhouquan@iscas.ac.cn,m:ajones@ventanamicro.com,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7262172B09E

On Tue, 7 Jul 2026, Hui Wang wrote:

> RISC-V rseq selftests include asm/fence.h from tools/arch/riscv,
> but the rseq Makefile only adds tools/include in the CFLAGS, this
> results in the building failure both for native and cross build:
> 
>     In file included from rseq.h:131,
>                      from rseq.c:37:
>     rseq-riscv.h:11:10: fatal error: asm/fence.h: No such file or directory
> 
> To fix it, add the matching tools/arch/$(ARCH)/include path in the
> CFLAGS and derive ARCH from SUBARCH for standalone native builds where
> ARCH is not set.
> 
> Fixes: c92786e179e0 ("KVM: riscv: selftests: Use the existing RISCV_FENCE macro in `rseq-riscv.h`")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Wang <hui.wang@canonical.com>

Thanks, queued for v7.2-rc.


- Paul

