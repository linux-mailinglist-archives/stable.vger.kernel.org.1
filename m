Return-Path: <stable+bounces-109375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1428A1514E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABABB1694EE
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B776B42AA6;
	Fri, 17 Jan 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMuraztk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC6B200BB2
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123014; cv=none; b=UDJPD26oLvTm8eZ4/fEXU4er80HzIuB8AdOIT4ly7eipBWFE87Rg/Y6Kc3bhdytBo68NFpLwph6SNnKju85Jeldvu62NlIl6IKZaSHbYY1e8+hudPd8GCk7PWZ9G6/XF0AQei3VbbL6Ym8IVw1JnNefNgbqHuyHNXV09sec+Q6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123014; c=relaxed/simple;
	bh=k6YK2Fh82YCBgNVV31Vn/3kW+W/L33C9birGbWFG8rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmBRbKeQu2O1692LWyF8YZrAoRxhl9RYbITcqQKgjbUXMiQxOof311mZYq+DbSqhLzlb48KpoPcx+R/z95tfLOx2xU1kNmrq+8opZ9IIIYtSZOFP3DTsFbhLKC39YDG2In0ZtggfZu9zFZoew/+MSI+uLwX2a44+5KYTJ4XBzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMuraztk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737123012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fX+9XADbSOdFXZoM2AZDs7eTNJG7HJm/jZRz93SA1bA=;
	b=KMuraztknAMY77rFBOExHdwyec8uTAOxZRuOTufOf8+gJsX6VbKFL8nQ+CckyhSNdMFCD8
	MIyUcoOgx1kX2bJkqWYCqTjpbSBXMsujlkZLT4oHe3xrLoS0MbK7sonmwYbatCyj72CVQN
	8UPRkLoVFrwlwXAgHyWmuj9UCOA5Tcc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-yIwleJr0PCCNhTtIMwyJPw-1; Fri,
 17 Jan 2025 09:10:06 -0500
X-MC-Unique: yIwleJr0PCCNhTtIMwyJPw-1
X-Mimecast-MFC-AGG-ID: yIwleJr0PCCNhTtIMwyJPw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 155881953956;
	Fri, 17 Jan 2025 14:10:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8580819560BF;
	Fri, 17 Jan 2025 14:09:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 17 Jan 2025 15:09:35 +0100 (CET)
Date: Fri, 17 Jan 2025 15:09:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org, andrii@kernel.org,
	jolsa@kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com,
	cyphar@cyphar.com, songliubraving@fb.com, yhs@fb.com,
	john.fastabend@gmail.com, peterz@infradead.org, tglx@linutronix.de,
	bp@alien8.de, daniel@iogearbox.net, ast@kernel.org,
	andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io,
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org,
	linux-api@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250117140924.GA21203@redhat.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <20250117013927.GB2610@redhat.com>
 <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117170229.f1e1a9f03a8547d31cd875db@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/17, Masami Hiramatsu wrote:
>
> On Fri, 17 Jan 2025 02:39:28 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > A note for the seccomp maintainers...
> >
> > I don't know what do you think, but I agree in advance that the very fact this
> > patch adds "#ifdef CONFIG_X86_64" into __secure_computing() doesn't look nice.
> >
>
> Indeed. in_ia32_syscall() depends arch/x86 too.
> We can add an inline function like;
>
> ``` uprobes.h
> static inline bool is_uprobe_syscall(int syscall)
> {

We can, and this is what I tried to suggest from the very beginning.
But I agree with Eyal who decided to send the most trivial fix for
-stable, we can add the helper later.

I don't think it should live in uprobes.h and I'd prefer something
like arch_seccomp_ignored(int) but I won't insist.

> 	// arch_is_uprobe_syscall check can be replaced by Kconfig,
> 	// something like CONFIG_ARCH_URETPROBE_SYSCALL.

Or sysctl or both. This is another issue.

> ``` arch/x86/include/asm/uprobes.h
> #define arch_is_uprobe_syscall(syscall) \
> 	(IS_ENABLED(CONFIG_X86_64) && syscall == __NR_uretprobe && !in_ia32_syscall())
> ```

This won't compile if IS_ENABLED(CONFIG_X86_64) == false, __NR_uretprobe
will be undefined.

> > The problem is that we need a simple patch for -stable which fixes the real
> > problem. We can cleanup this logic later, I think.
>
> Hmm, at least we should make it is_uprobe_syscall() in uprobes.h so that
> do not pollute the seccomp subsystem with #ifdef.

See above. But I won't insist.

Oleg.


