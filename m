Return-Path: <stable+bounces-189248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9EDC07D0B
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 20:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6D984F1939
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 18:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5634A77C;
	Fri, 24 Oct 2025 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWQafwot"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0D31A7F6
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331877; cv=none; b=QYlP7qdeaITjE2eOLAz3o3UP7mvkwuOzK3r/VVk/2K7TBxFU3swdGaCb7Glxg1rGVEEZln2iDZtvK8R5tFpSr4/xD0qgL+DsmlNkoZRxIZiGaOUEuddt0fm0q/E3aBclCcbIOux0oLstsnq76sAKS2J/tPhbcK2okt1UX5lGerk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331877; c=relaxed/simple;
	bh=zqrGjUJ698YClDJ3TmjkNWOOnDHqX8WFVTQRYlec0CU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohOwa0tsDWMug3M/W/kz0otgymvKuv7KmeJUn7FzGP7p12qQNql7h+KZAEXvLna9w0JaFFEHz2DXUIwbA7D71wsErzbDBBDnSCHE0inuI3jCLriMds92JJwR4bTgnXaLWNqfYgi3fUTi/CkTKB3/XN/BiQpS8B4Pb/yKAqXnpsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWQafwot; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so13173165e9.3
        for <stable@vger.kernel.org>; Fri, 24 Oct 2025 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761331874; x=1761936674; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7Zh6pNkF+WOivDtJP8tmFei4F0isWrVIg6ZCiyVzgI=;
        b=SWQafwotXo9+XoJUvyuIlOCHTeIhxPYjaTSZ8xKGyxAKqUSK5yRuq47LsJtKr4FE3m
         Z4ESjxMa/X5iXzyLApJ1gjTWJRMBHR7YSda1uXu41UiP+LSvK4+h1moCQLmt5PA3w+er
         X24/7OqsW0RKQIo1oLmMxkNP67GIodwIFwdHGdhxCYD9qcToSj+9JX4oP0SOq6OBbU7u
         TqLdF1rEUpaBfvsClTMkAgz3fa6JGmdm/B/iiewRLVXRKitS+2g7+C0xJ0D+IbVmTHHa
         PRlNi51i0UVD+Tv1FOsbPsp9dW9dXsq2i41UH2KECX1vGJeaKP3nY/S7ePVqplJEkBUS
         SdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331874; x=1761936674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Zh6pNkF+WOivDtJP8tmFei4F0isWrVIg6ZCiyVzgI=;
        b=wwmSF2Nb6O4aYtoLU8vYcX9/C8Lo8wDI7F93MmadOVSDyORySEqcIuMvlP/TB+V/Y5
         JiqaLHk/C3XYtGj1LXM0ezOiThMR8s8B1qijsrpus0fkMtBrkoYhIwg41QL2g56WwO5V
         9cpv6Qnmg94hSTzZmPLYa1FuVrkS8uqu/vn3vr9+n9YkeGGUCFsuURUHND74A6bumWyu
         E3Qy7iRP4kX4iDHMQMO/0tcNxk1HYPPMs1BoAxc4HpD3AtnNDEqdg9Y085yV2rG7xRFw
         WAS3/KBMopY5DoxKlQ9V5MU29oLBp4/SnTEZTIhZXYE4MK4rsK0kPPIvPwcXZ+w76Edo
         4ELA==
X-Forwarded-Encrypted: i=1; AJvYcCUrzmziPKm9FRQRRjn+jlsgfAMDcVuxcsDxPWP1cUs8e1F/69euAU8v5V/epWSdP5Fzy8Twzw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX15u4vd9SkDVRj8HU9xFiPoXuJrCBOLgv5PwEQs27fkff9E0g
	miU5zRL9UIcmYni5ux4DdgnaOi6OgGkk8Vym0sXJBlku+Nf337vpcLU4
X-Gm-Gg: ASbGncsrpE68o4tUVAqvVpC7viDuJQIpF3sdTnPt7hxxcg4npeucSY6Xm/OQYFZXFr3
	XLcmZ3zBh1ctKW3QvaZmg040IiyQk2fXDpbR0Fw1Q0JCyq9ERLbbBFy6GTLsdC3NPIYfPk7zFwX
	MXUN8eLtsmc6NRVUMzW8e/JWP0W+yX9HgwPwDFtqUOOeI9FQm+qX8ZPyLRZi+BQBqIZzIpwb6sf
	AhyoXHAuYzbwms40kNi3nQruI2/7Q3pN6xA9fIC+P68mQRem8KmWo4dT4GnhP8QUrXXbNLyWn3d
	bcsaHcitl1SV16u12CtIl7WIlcAvsACDCPkNkQcqoQUTxagn13kRQDgDE2KrtBtGrHnqXsBpWiq
	FfXkL/B4UcVg8E/9VdCmssYlaNN5MsPeCz+ZFKvHFcFeaHj8OMDaxG0kMzZ0DHDHN
X-Google-Smtp-Source: AGHT+IGOJ2HowDuzFPdE49LeeFFxM4Ibpy622YXnKRZJ9nZeLtPjH2GSOXup26UH/HX1uoAiAita+A==
X-Received: by 2002:a05:600c:64c4:b0:471:60c:1501 with SMTP id 5b1f17b1804b1-475d2ecaedemr36421515e9.28.1761331873671;
        Fri, 24 Oct 2025 11:51:13 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d4b923sm87163955e9.14.2025.10.24.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:51:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Oct 2025 20:51:11 +0200
To: Song Liu <songliubraving@meta.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"andrey.grodzovsky@crowdstrike.com" <andrey.grodzovsky@crowdstrike.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] ftrace: Fix BPF fexit with livepatch
Message-ID: <aPvKnzOFQWVr1E4Y@krava>
References: <20251024071257.3956031-1-song@kernel.org>
 <20251024071257.3956031-2-song@kernel.org>
 <aPtmOJ9jY3bGPvEq@krava>
 <F4D3E33F-C7AB-4F98-9E63-B22B845D7FC2@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F4D3E33F-C7AB-4F98-9E63-B22B845D7FC2@meta.com>

On Fri, Oct 24, 2025 at 03:42:44PM +0000, Song Liu wrote:
> 
> 
> > On Oct 24, 2025, at 4:42 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > On Fri, Oct 24, 2025 at 12:12:55AM -0700, Song Liu wrote:
> >> When livepatch is attached to the same function as bpf trampoline with
> >> a fexit program, bpf trampoline code calls register_ftrace_direct()
> >> twice. The first time will fail with -EAGAIN, and the second time it
> >> will succeed. This requires register_ftrace_direct() to unregister
> >> the address on the first attempt. Otherwise, the bpf trampoline cannot
> >> attach. Here is an easy way to reproduce this issue:
> >> 
> >>  insmod samples/livepatch/livepatch-sample.ko
> >>  bpftrace -e 'fexit:cmdline_proc_show {}'
> >>  ERROR: Unable to attach probe: fexit:vmlinux:cmdline_proc_show...
> >> 
> >> Fix this by cleaning up the hash when register_ftrace_function_nolock hits
> >> errors.
> >> 
> >> Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
> >> Cc: stable@vger.kernel.org # v6.6+
> >> Reported-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> >> Closes: https://lore.kernel.org/live-patching/c5058315a39d4615b333e485893345be@crowdstrike.com/ 
> >> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> >> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >> Acked-and-tested-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> ---
> >> kernel/trace/ftrace.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >> index 42bd2ba68a82..7f432775a6b5 100644
> >> --- a/kernel/trace/ftrace.c
> >> +++ b/kernel/trace/ftrace.c
> >> @@ -6048,6 +6048,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >> ops->direct_call = addr;
> >> 
> >> err = register_ftrace_function_nolock(ops);
> >> + if (err)
> >> + remove_direct_functions_hash(hash, addr);
> > 
> > should this be handled by the caller of the register_ftrace_direct?
> > fops->hash is updated by ftrace_set_filter_ip in register_fentry
> 
> We need to clean up here. This is because register_ftrace_direct added 
> the new entries to direct_functions. It need to clean these entries 
> for the caller so that the next call of register_ftrace_direct can 
> work. 
> 
> > seems like it's should be caller responsibility, also you could do that
> > just for (err == -EAGAIN) case to address the use case directly
> 
> The cleanup is valid for any error cases, as we need to remove unused
> entries from direct_functions. 

I see, I wonder then we could use free_hash to restore original
direct_functions, something like:

	if (err) {
		call_direct_funcs = rcu_assign_pointer(free_hash);
		free_hash = new_hash;
	}

we'd need to keep new_hash value

but feel free to ignore, removal is also fine ;-)

thanks,
jirka

