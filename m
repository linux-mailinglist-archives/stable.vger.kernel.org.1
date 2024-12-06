Return-Path: <stable+bounces-99006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C42D49E6D9B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445B2188189D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2789E1FF7D2;
	Fri,  6 Dec 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxJdm4/4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4811FF7A1
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733485953; cv=none; b=Fq4r1t6RmvScZa9emmja3QQ/mdVZEZIFEd5wxw9L+q9DrBziemO7Iyx5BDkLLiqeDjnf0+aLC+ouIPiMAfFHLy8VNPoX2FatjhleSEZD3lu7wIr4BrUeqsdrylkJpPjnJhPkctTYrSaUqtjJpz5u90peXVJYu3qFDP8pt4We3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733485953; c=relaxed/simple;
	bh=fvR19Fke+nqsX8G1M7vQ81Me4p4pbkSD1dYSS3UM4zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0p29BKdrTY3OK9ujiaBGwfgVWvNEg//bdxhrHEA6D8k1X3AtanXbh1bx4Z97NG676hwyG9u8kO9n7YH918WC+bHCrdg7EznNcC/rfgoue21diPqmr/HsrTEsa23iWLDoQucbYkjSHq/xY9ginMBv48R3auCh7iM66tS+2RXrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxJdm4/4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733485951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gppRjBK2ayDqLXJbDav8bMCH+p/FKEHFZICRNK1hGng=;
	b=XxJdm4/4Ddwo3iTdc0GrEYeqrQv0iBfpfaUzMSXI75QWsqhv2pMKqE3WnVH2S0bmrQ9B6+
	uc3cjO4RI3B3L7zfV6I4M+CAXNzfAhbPJJz/BbqoAHUNs9/0M6qf4xjobNrNTmchaOo3B7
	UaWfUNWhZqIjnzjbF6punKrgF1zALLE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-ENwAxsbaOkSeO5nLZWaGhg-1; Fri,
 06 Dec 2024 06:52:25 -0500
X-MC-Unique: ENwAxsbaOkSeO5nLZWaGhg-1
X-Mimecast-MFC-AGG-ID: ENwAxsbaOkSeO5nLZWaGhg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 499E21956055;
	Fri,  6 Dec 2024 11:52:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 571B31956095;
	Fri,  6 Dec 2024 11:52:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Dec 2024 12:52:00 +0100 (CET)
Date: Fri, 6 Dec 2024 12:51:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v5 01/16] x86/stackprotector: Work around strict Clang
 TLS symbol requirements
Message-ID: <20241206115154.GA32491@redhat.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
 <20241105155801.1779119-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155801.1779119-2-brgerst@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/05, Brian Gerst wrote:
>
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -468,6 +468,9 @@ SECTIONS
>  . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
>  	   "kernel image bigger than KERNEL_IMAGE_SIZE");
>
> +/* needed for Clang - see arch/x86/entry/entry.S */
> +PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);

Don't we need the simple fix below?

without this patch I can't build the kernel with CONFIG_STACKPROTECTOR=n.

Oleg.

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index fab3ac9a4574..2ff48645bab9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -472,8 +472,10 @@ SECTIONS
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
 
+#ifdef CONFIG_STACKPROTECTOR
 /* needed for Clang - see arch/x86/entry/entry.S */
 PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
+#endif
 
 #ifdef CONFIG_X86_64
 /*


