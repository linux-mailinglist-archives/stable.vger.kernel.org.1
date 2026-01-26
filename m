Return-Path: <stable+bounces-211686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIZULBnOd2mxlQEAu9opvQ
	(envelope-from <stable+bounces-211686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:27:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEEE8D0D4
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 21:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66ABB3034290
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 20:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2C2D59E8;
	Mon, 26 Jan 2026 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UF0k3RRl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0C2D5926;
	Mon, 26 Jan 2026 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459083; cv=none; b=AcMlv83fIAnDpZLMeVSMmoBtGRLqVX2onnRoyowpn3pQpJcspUo1vQzgJu2ZtF4c8/NSM+sktLjj26qOFw8ZwnCKcCFDw0/HJy4dQNdE+rPFeSXwrV0n4BPObCF+dsI4ZQG9LmCMHgPbvjDqKfBTY3DkmmODfFALCfgtRtNitzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459083; c=relaxed/simple;
	bh=HXqLkJLfB4QpAF+2zY1c3MiKjnN3UGNcItZ6zKmZGKk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KbwNZNeMNewC6ak6LcvJIDd+l9l0Cv+A7WIf52QwFpwKGK933Wy5mmBTxZ1YCMp8ce5izW5k9VKW2q/ptA9VI6AzVFQGYDPLbv1vxQNhCpWVuo99XSiYVltt3ICgGHu6kUWTw1MLK93GEt8kaQFBx+5st+lbXySBRWevkDDG8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UF0k3RRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8D5C116C6;
	Mon, 26 Jan 2026 20:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769459083;
	bh=HXqLkJLfB4QpAF+2zY1c3MiKjnN3UGNcItZ6zKmZGKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UF0k3RRlk69fbzVty76Sm2HABR9nbwZU7EvgkGOYGmdiOIr5oIhUg1/6Ocei7M6QK
	 d+2MK2HbKiXkJGoODvsnARrib4qcqI4IywbEgzga6abr0X516OxMLQ13V3tDz+rhyu
	 qCBbKdfPAhsYRMMyt5DTQ/YF7PlNzkzFHV7+5+U8=
Date: Mon, 26 Jan 2026 12:24:40 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Marco Elver
 <elver@google.com>, LKML <linux-kernel@vger.kernel.org>, Alexander
 Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jann Horn
 <jannh@google.com>, kasan-dev@googlegroups.com, stable
 <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] x86_32 boot hang in 6.19-rc7 caused by
 b505f1944535 ("x86/kfence: avoid writing L1TF-vulnerable PTEs")
Message-Id: <20260126122440.78e7ffebd5257e5ce00fa35a@linux-foundation.org>
In-Reply-To: <CAKFNMokwjw68ubYQM9WkzOuH51wLznHpEOMSqtMoV1Rn9JV_gw@mail.gmail.com>
References: <20260106180426.710013-1-andrew.cooper3@citrix.com>
	<20260107151700.c7b9051929548391e92cfb3e@linux-foundation.org>
	<CAKFNMokwjw68ubYQM9WkzOuH51wLznHpEOMSqtMoV1Rn9JV_gw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	TAGGED_FROM(0.00)[bounces-211686-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.30.226.201:received,100.90.174.1:received];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:mid,linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FEEE8D0D4
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 04:07:04 +0900 Ryusuke Konishi <konishi.ryusuke@gmail.com> wrote:

> Hi All,
> 
> I am reporting a boot regression in v6.19-rc7 on an x86_32
> environment. The kernel hangs immediately after "Booting the kernel"
> and does not produce any early console output.
> 
> A git bisect identified the following commit as the first bad commit:
> b505f1944535 ("x86/kfence: avoid writing L1TF-vulnerable PTEs")

Thanks.  b505f1944535 had cc:stable so let's add some cc's to alert
-stable maintainers.

I see that b505f1944535 prevented a Xen warning, but did it have any
other runtime effects?  If not, a prompt revert may be the way to
proceed for now.

> Environment and Config:
> - Guest Arch: x86_32  (one of my test VMs)
> - Memory Config: # CONFIG_X86_PAE is not set
> - KFENCE Config: CONFIG_KFENCE=y
> - Host/Hypervisor: x86_64 host running KVM
> 
> The system fails to boot at a very early stage. I have confirmed that
> reverting commit b505f1944535 on top of v6.19-rc7 completely resolves
> the issue, and the kernel boots normally.
> 
> Could you please verify if this change is compatible with x86_32
> (non-PAE) configurations?
> I am happy to provide my full .config or test any potential fixes.
> 
> Best regards,
> Ryusuke Konishi

