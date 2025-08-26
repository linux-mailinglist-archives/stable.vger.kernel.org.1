Return-Path: <stable+bounces-176423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA2B37209
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 20:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD20F1BA7C2A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83A61FECAB;
	Tue, 26 Aug 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcMnGWvU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647D31A57A
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232170; cv=none; b=VH6gPalCguqMAhudIH7CKcthGxlxmVueFKJxtN90XoFT9j+FaTBabKKK6VldfzJjYxqNIeFGM30uu+UUgNKx+OhzFa1I2ymn4Dcj+/2UT21WKIzypdCwqAqTai+5AHQ3hjcrXqqC5J0U61xyh36GQz+NTapkSoi4Ky+FL5mxKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232170; c=relaxed/simple;
	bh=GMRxymhNkZNBWq21//zBGy00Sx7UuiBXmuBQ2vhzYHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdgPIFQ4p0hpu4BRhVdhLTzNfffPLdh2zoJlrjAGM/sAibRKirvSwCszS9eJmXX2/yHMl5OtfYzTAza8rwHNIzdZ8o9P87h+znRw2gjMrrAKHOXsxidtGq6uSpguS045yXw3+lz/qginBGqr3Xw86NJsIKmxlu5RRZ0eLqWcwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcMnGWvU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c854b6459fso1905887f8f.3
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756232167; x=1756836967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ovZ5TqxkqtcU6jYMimb1HaGzBaZPG7b1ARCmJyeyr4=;
        b=VcMnGWvUZKOenvsEY3/EvE4I5wQu5srsn8iCWonPp/Vdj4xjopng7JjPH2vxC3otwD
         9mDfpjMjiL5ftp7oscnWeur/9+CjThnfskBc6ExKz0rORCJQXt1X/rF6uogNtECxYSFR
         PmXlSFlulqOiiQdh1FtHRNSazQVY2FUAuNthKxj06yHsB0yRTfe8NPYj/amHDOASWSRN
         T1b8AQhlOyRykwt2nILjYafq/VJ82dOwK1x0lPYPQ1vtFb2ScQul4fYGqm/uI1uNold2
         80Gi4FQruyrJrikYK46OkcN+t3LmYRBa6WUjfkIfaW0YDPlTyGnjtJ9g72HdJR9pRrv1
         SG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232167; x=1756836967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ovZ5TqxkqtcU6jYMimb1HaGzBaZPG7b1ARCmJyeyr4=;
        b=CAIe8XmKOgeD0kyExTQZEGTpcenXcW4Q3fnO8+rnJLG8zWRBsYsiIhQUoKNOr5QdP5
         ldGXe4611ofIv6BNpzhEk8ZbC/MrpDiTWqGeYp4raKWoxqYW8JVOSjNShB5K7tagtwTi
         pz/TS+Xdb0xbKlfs7ul4tI/qVjMt3B7jCgh0SqjwforGzd5PmJwPVM5HBF7KcoLALB5R
         a7XgNdQr/qKI7g8OGCUWR43eLr1D6u2LFV9UAUVZXTxTbDZjr+al7cgM62XEbblMjeIk
         uCTAt2xiAKZSFsZ90uHIgWCLbg0dAYxbCimvOzbWH7YZcqVjUw31GiUBfrLIsFqheZEK
         Zhgg==
X-Gm-Message-State: AOJu0YxaXrdkTDaYv8O65wq/MmWxVVYTtztylRd9X6ZjKEXKVIG/ZLEl
	j9Nr45tT8n/Yo7gM6CQRGRaq+VgdZE3V1QDGgpG24TIau1LLD2Lhb4Gf
X-Gm-Gg: ASbGncvc8/O1ni2SqloGZtiHk1fOMWaG2H0lEgijhMdKZfNsmKGlgW75YpddfMer34/
	9Fi9sVK+Gke3lkmUSA7ZnO8diraE3ZTE9ZDoVvIA4ILZBncBiH0orz77oGurzgu+VUkRhUwnGXV
	JcIvhrY/uhM5ezsOR4DaqjXNQkMuqCXBXsNrYUp1Unhu+s2KM4dicc0VJa8SbK4KZGv+4m0qpE8
	61FIqAE34hAGCLlNyTEF10z4WoHHjvyoEPKgCO0gfgm1Vlw824DiWipccNhd8wUcAEET9ahc0aF
	QBHIDBvLlgcnvUGUiOW3wrmyzF1AftAMyphoR974hzn3lkL4xEHuYIUJS9hc4tpZaV8NCJEWB8d
	e56BOBogG8HVkDv9JcKsibJxZmdx2EUHRWy2UTcqrBCBu5o14FVdjeRo=
X-Google-Smtp-Source: AGHT+IH/FUF9kWusU42/y1qH0umKF6TFuhQ3+OKqODzpuwWg+UIy9zjDK8o4KfQOlwfLjVfzDWJ1/Q==
X-Received: by 2002:a05:6000:4011:b0:3b9:13e4:9693 with SMTP id ffacd0b85a97d-3c5dcc0c457mr12083434f8f.52.1756232166595;
        Tue, 26 Aug 2025 11:16:06 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7116e1483sm17015900f8f.50.2025.08.26.11.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:16:05 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 6A01EBE2DE0; Tue, 26 Aug 2025 20:16:04 +0200 (CEST)
Date: Tue, 26 Aug 2025 20:16:04 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 6.6 028/587] fs: Prevent file descriptor table
 allocations exceeding INT_MAX
Message-ID: <aK355BFz6ErdVI7j@eldamar.lan>
References: <20250826110952.942403671@linuxfoundation.org>
 <20250826110953.666871765@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826110953.666871765@linuxfoundation.org>

Hi Greg,

On Tue, Aug 26, 2025 at 01:02:57PM +0200, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sasha Levin <sashal@kernel.org>
> 
> commit 04a2c4b4511d186b0fce685da21085a5d4acd370 upstream.
> 
> When sysctl_nr_open is set to a very high value (for example, 1073741816
> as set by systemd), processes attempting to use file descriptors near
> the limit can trigger massive memory allocation attempts that exceed
> INT_MAX, resulting in a WARNING in mm/slub.c:
> 
>   WARNING: CPU: 0 PID: 44 at mm/slub.c:5027 __kvmalloc_node_noprof+0x21a/0x288
> 
> This happens because kvmalloc_array() and kvmalloc() check if the
> requested size exceeds INT_MAX and emit a warning when the allocation is
> not flagged with __GFP_NOWARN.
> 
> Specifically, when nr_open is set to 1073741816 (0x3ffffff8) and a
> process calls dup2(oldfd, 1073741880), the kernel attempts to allocate:
> - File descriptor array: 1073741880 * 8 bytes = 8,589,935,040 bytes
> - Multiple bitmaps: ~400MB
> - Total allocation size: > 8GB (exceeding INT_MAX = 2,147,483,647)
> 
> Reproducer:
> 1. Set /proc/sys/fs/nr_open to 1073741816:
>    # echo 1073741816 > /proc/sys/fs/nr_open
> 
> 2. Run a program that uses a high file descriptor:
>    #include <unistd.h>
>    #include <sys/resource.h>
> 
>    int main() {
>        struct rlimit rlim = {1073741824, 1073741824};
>        setrlimit(RLIMIT_NOFILE, &rlim);
>        dup2(2, 1073741880);  // Triggers the warning
>        return 0;
>    }
> 
> 3. Observe WARNING in dmesg at mm/slub.c:5027
> 
> systemd commit a8b627a introduced automatic bumping of fs.nr_open to the
> maximum possible value. The rationale was that systems with memory
> control groups (memcg) no longer need separate file descriptor limits
> since memory is properly accounted. However, this change overlooked
> that:
> 
> 1. The kernel's allocation functions still enforce INT_MAX as a maximum
>    size regardless of memcg accounting
> 2. Programs and tests that legitimately test file descriptor limits can
>    inadvertently trigger massive allocations
> 3. The resulting allocations (>8GB) are impractical and will always fail
> 
> systemd's algorithm starts with INT_MAX and keeps halving the value
> until the kernel accepts it. On most systems, this results in nr_open
> being set to 1073741816 (0x3ffffff8), which is just under 1GB of file
> descriptors.
> 
> While processes rarely use file descriptors near this limit in normal
> operation, certain selftests (like
> tools/testing/selftests/core/unshare_test.c) and programs that test file
> descriptor limits can trigger this issue.
> 
> Fix this by adding a check in alloc_fdtable() to ensure the requested
> allocation size does not exceed INT_MAX. This causes the operation to
> fail with -EMFILE instead of triggering a kernel warning and avoids the
> impractical >8GB memory allocation request.
> 
> Fixes: 9cfe015aa424 ("get rid of NR_OPEN and introduce a sysctl_nr_open")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Link: https://lore.kernel.org/20250629074021.1038845-1-sashal@kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/file.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -126,6 +126,21 @@ static struct fdtable * alloc_fdtable(un
>  	if (unlikely(nr > sysctl_nr_open))
>  		nr = ((sysctl_nr_open - 1) | (BITS_PER_LONG - 1)) + 1;
>  
> +	/*
> +	 * Check if the allocation size would exceed INT_MAX. kvmalloc_array()
> +	 * and kvmalloc() will warn if the allocation size is greater than
> +	 * INT_MAX, as filp_cachep objects are not __GFP_NOWARN.
> +	 *
> +	 * This can happen when sysctl_nr_open is set to a very high value and
> +	 * a process tries to use a file descriptor near that limit. For example,
> +	 * if sysctl_nr_open is set to 1073741816 (0x3ffffff8) - which is what
> +	 * systemd typically sets it to - then trying to use a file descriptor
> +	 * close to that value will require allocating a file descriptor table
> +	 * that exceeds 8GB in size.
> +	 */
> +	if (unlikely(nr > INT_MAX / sizeof(struct file *)))
> +		return ERR_PTR(-EMFILE);
> +
>  	fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL_ACCOUNT);
>  	if (!fdt)
>  		goto out;

I see you picked this commit for the current stable series, but TTBOMK
this introduces a regression as it was as well present in 6.12.43:

https://lore.kernel.org/regressions/20250825152725.43133-1-zcgao@amazon.com/

and the current 6.12.44 contains a followup. If I'm not mistaken Sasha
has picked up 1d3b4bec3ce5 ("alloc_fdtable(): change calling
conventions.") to fix that.

So unless I'm wrong, if you pick up 04a2c4b4511d ("fs: Prevent file
descriptor table allocations exceeding INT_MAX"), then as well
1d3b4bec3ce5 ("alloc_fdtable(): change calling conventions.")  is
needed.

Regards,
Salvatore

