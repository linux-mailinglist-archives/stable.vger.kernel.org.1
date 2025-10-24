Return-Path: <stable+bounces-189228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C8C0611E
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 13:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21F619A3A31
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0A307AFC;
	Fri, 24 Oct 2025 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So529veH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC452580E2
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306175; cv=none; b=Z7KngwFda+JPHHZySTyoeVMerOMS1ywIu0HHHC9gKkPVErcBME5LBwGJ2/6SVnEJm6Hco7LwHXAPuc8mpn/iiR8z4CVx7fqThzsOys9XigsX72Tid1q8gCZWI//UQTHaJ6xQHAWoX+Y7RUdMHVPQTNlpQHsEil2qpuLOuZyzmqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306175; c=relaxed/simple;
	bh=BSa+n0RHtBRMZcEWJek59r2Jv4nIb4dvimkE2lkcU5M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWT2oZHG98/TuYTn/iFfEC0TxOUxfQ5rRM8EZBoQONfhjqJrMJaKNTq3wu+2ifk85fjQzwlmYFkx/B71JT9tiSyfRZFTP9qeGgyaDjzAUSuFG59rykmduvj4N2J8Tgq/mr0afoy1JJ87jKZToJ6wy5vBgHuUXqEheYTZChm3398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So529veH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so19421175e9.1
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 04:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761306171; x=1761910971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYSOpLWf0KKSMlI5IP80glPUH7vqI7+Tr3W3w2SASQg=;
        b=So529veHjy38XsuZYlINGFEIeO+Brf0ht4wtROg2ZPr06pn5Tj2zewjpGottF/qylw
         NLSS/MzfNONDrBHY1aTs7s0xiwj1EYeC2Aslh+Wh6AO3oqE58oNquIxD8IuYVoZMxP3K
         txdHsSmh4st4vr+09ULp3XpJO7B7wjBmQrYX6A318YtmY3JSj/LAWgePlGL/weDcceIe
         /FGmRjVc7vXLMMX+ruo78ScnrN2Ui8QpNeZ6bgUTJAoiMwmpurGLHjml6CSuVx1kE7jm
         ynV0kbTs3hc/TE9dqBGnfliZ6uGf2b9qiqyyXUHKyCQhTYC6FkLuMLASkDdEYx10tHbs
         sjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761306171; x=1761910971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYSOpLWf0KKSMlI5IP80glPUH7vqI7+Tr3W3w2SASQg=;
        b=uJXut/Y31LYQ6tHzclNqgiowC3hJRyRjWg/j1DfkUyls1rNk/G0uOnqi+Km3qOsoiN
         JdWTySpkAP/G2HJW8r0zFkTlin9WbT5MA+tdEZcNmr85Ga2TByQlBEkwrVR6FoG1aEeh
         S7xZBHUxgGMscU3ogsTo83GfJAhSFE4BV/qVYzTlfxSSWHCBZnY0d5Twn6+c6pf+ulMb
         XsLZa0cOhWwv3S2y8hqsU/4Ra5DRpKppHvS1esJXAgz4DijSNPYCDkZx7QAqSQZ95rWM
         VP2yBip5MwhSnxZ/eEJ6fBIFoi9Wk84wEnBwW3M+K+ZcrrHsaFts8oh2sHXXkYJ6xrgr
         Sq8A==
X-Forwarded-Encrypted: i=1; AJvYcCVwirZMZwaJ9fAqA/ROjSLlqNvrPooAllkxxdxiRRMrcLvU2fnL2DtwAMJG3G45qHnKY2pggXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyea8htoEMF6BF63B6iCv7RhKGqyScX+FiupiJt0sdXWC97vgNz
	V8Yo3no5P79h6SraV3MY0dZ9TxIYzFdCWv3wB1vjvuIG09ZWwoWSiFSI
X-Gm-Gg: ASbGncuvEczdOhFAvLb709F02SF2OzKvIzU2VRS9SCxLjd/HS/a+R6nUKlCDIEylypc
	5MUmpxhhNsZ5oajcn6ggumEduoenXxdFt40T0ADYATgsA6y/BxV1tEkmy3CvK3GU+wFMynEGCNk
	BniwNQDHAguV6MlBmuYT1glk7hL2f4tMCoUox290n6LqljEtdV2kacPT2bMf71DA31AaXwfgtvV
	Fpdkz2lR2vBW+Lt4KdkFBNqxZtyKlfcXdzFWFH+PjdoBYInU96DvuDCHjuT3e6zczGARS81OXnY
	By/auHgTKoT9mEG0javcLTY5zRNDBMENWLkXPq+QyOgj6JNO+A5Q/9EJKTlmfCcvbAyBR3FY/N5
	o2SGnf/nZQ+/4igukQ/GNvI5vXRltwUt7ebCVyxRp8D7bzkJZnt9sjIAwxwq9
X-Google-Smtp-Source: AGHT+IFIUsw6TyOf0Ycr6/XFbQuoCfiAQ0G0a0V5A5EXttedAZG47NAs1I680hPCSVoLr15fOIrshA==
X-Received: by 2002:a05:600c:3e12:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-471178a74demr202375115e9.12.1761306171044;
        Fri, 24 Oct 2025 04:42:51 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ecadbsm9269121f8f.45.2025.10.24.04.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:42:50 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Oct 2025 13:42:48 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, rostedt@goodmis.org,
	andrey.grodzovsky@crowdstrike.com, mhiramat@kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/3] ftrace: Fix BPF fexit with livepatch
Message-ID: <aPtmOJ9jY3bGPvEq@krava>
References: <20251024071257.3956031-1-song@kernel.org>
 <20251024071257.3956031-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024071257.3956031-2-song@kernel.org>

On Fri, Oct 24, 2025 at 12:12:55AM -0700, Song Liu wrote:
> When livepatch is attached to the same function as bpf trampoline with
> a fexit program, bpf trampoline code calls register_ftrace_direct()
> twice. The first time will fail with -EAGAIN, and the second time it
> will succeed. This requires register_ftrace_direct() to unregister
> the address on the first attempt. Otherwise, the bpf trampoline cannot
> attach. Here is an easy way to reproduce this issue:
> 
>   insmod samples/livepatch/livepatch-sample.ko
>   bpftrace -e 'fexit:cmdline_proc_show {}'
>   ERROR: Unable to attach probe: fexit:vmlinux:cmdline_proc_show...
> 
> Fix this by cleaning up the hash when register_ftrace_function_nolock hits
> errors.
> 
> Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
> Cc: stable@vger.kernel.org # v6.6+
> Reported-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Closes: https://lore.kernel.org/live-patching/c5058315a39d4615b333e485893345be@crowdstrike.com/
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-and-tested-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/trace/ftrace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 42bd2ba68a82..7f432775a6b5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6048,6 +6048,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	ops->direct_call = addr;
>  
>  	err = register_ftrace_function_nolock(ops);
> +	if (err)
> +		remove_direct_functions_hash(hash, addr);

should this be handled by the caller of the register_ftrace_direct?
fops->hash is updated by ftrace_set_filter_ip in register_fentry

seems like it's should be caller responsibility, also you could do that
just for (err == -EAGAIN) case to address the use case directly

jirka

>  
>   out_unlock:
>  	mutex_unlock(&direct_mutex);
> -- 
> 2.47.3
> 
> 

