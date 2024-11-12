Return-Path: <stable+bounces-92854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8999C64C8
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 00:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B5E2838DD
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 23:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6C1531C4;
	Tue, 12 Nov 2024 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8NBNGta"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127E205ABD
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452670; cv=none; b=aH1GFoVUHExP3TXvU5gR24J2NhqMMx23NtASn/ihfyvVQAqvlEk68bVb9AcaRowW4qZv3r9INbJydIoYFUV8CZqrnUTSjUA1ihHpbFU7ELTeU3L8fvjLvYG5oijRQp339kqlfHaHrpsEOgUmFBP1OCz2fmIKFyCF+sOt0oYRgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452670; c=relaxed/simple;
	bh=M8QZHdkR0C/TG//Jvt6IIv8ZeuA/WUQAchDPKwDVZpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCajT3F6JaFZz/YqgMlnAxp8nmsvufCL436Hbtjy9wIMMcd8s3JGlac1Sy1qrth8BUpTZNoBIQgr8Hu/XBcl3HgGyVIXJ2aWuKxKoEUQdWs2yelZci35lvoeUiU7Y8hN/ZJPHvFthJ/1ktuScsqvuVBVThhI4bo2c4vRmS3dB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8NBNGta; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca4877690so26485ad.1
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 15:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731452668; x=1732057468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGcmcooZ3eXi2btPtJV6KWC5Ib7k9JOuUxsYyFpp28w=;
        b=X8NBNGtap8j/pQDYpbgxQyYFoFhMz/9CYkXOhUIujbN6hM6mbFmElOLrmTj3SIwHoV
         LAPuPHlti+K0DCcG4gpJ6H+fOXSEAYxnnfk/zUkmO+r5RfGu5x/0lFuNGOjhibh4I3HI
         wJwlNM6z3kMSRXmCu70bvrZSmAR4B3xwVlJ2TLDTvdbi6KzT1wEOl/fap7EKKCkr5AfG
         dlFbZmJpiXLa6qG8pw8fkvomtsX/ymApAwz4XFMtj4SHBgTDgOaMTzFYorPR8OrEQkna
         1ufTNBR2SFyxF8z9tCciRB4z1AUixg1CdmRdwP+lMlnWUhKT9E2DE3esnQhBQg7SgxbL
         h9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452668; x=1732057468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGcmcooZ3eXi2btPtJV6KWC5Ib7k9JOuUxsYyFpp28w=;
        b=dvzG/gWJbPCPqitKuivuriPpPCyJOvBqDgC0mxpIeFed8w6DhoTQnM9INaqv6pcECs
         onnoM44XUK6WaqdVqMRCL29v4vKRu1lNLjqHNcpOZA2eBLpdKeOCqOId6Nn92JZ7qBZz
         6nLkDQNWhbPRJvdq+y3FU877qoEfsOAB5NjgzVl+HO2y5wliiGtBh9LesCdzRmJKWhv2
         RH5K2iF/HUWA/3Dc9KDnxGIH/1g72CQ/IXAPp7Ul6IIl2msQu3ox0hDfNtEyBKlumCN0
         uRp5w0rB6v7hZad/UgzNwEwFclfOTYXjGDO/7Z/lMZHU1ThmsMABOH9YFgH40MmOrGW1
         xq+A==
X-Gm-Message-State: AOJu0YwM8zLrobeRNzTn+d28M5Ae1MUUZBBRx8wb0hfsAhHfn459oj9q
	G1m62oZPdwE7UzrpepaMV85IsuQyueJLPoDC+354lKToy2haissaCbo57bw5UyFsBxWVPlYmSjA
	imy0H
X-Gm-Gg: ASbGnctWMwoK7ordZeCykmJ5QE1egi1+fyCutGveCmAFp5i9EBtAWXztTLHoZc02Cfd
	Jwtm8y9e3nGbqqEAr8MCXVs2jD7LxbchNP6quifHkQRB3uTC1uTzh5C/U/aDcoEYUYYn09DMKCB
	pt8x3rseMJoNLPnCijZu/A9VLN34EdASBotnjx0PAQvSbfk2x0F5UYhcanCknXoOsZBwyxuf8W5
	QMRiB98N0CBcDfBiThNKAlYGRq1uhINZPeUhwox
X-Google-Smtp-Source: AGHT+IHOy09+IsPJGVNT6MLd6Ag2vBUkiSWhTo9lb9O6NU0vAC5+WyRM3S3Z/m5iZlqrTpgtb91ezw==
X-Received: by 2002:a17:903:192:b0:20c:e8df:2500 with SMTP id d9443c01a7336-211b6ffbb98mr262825ad.3.1731452667677;
        Tue, 12 Nov 2024 15:04:27 -0800 (PST)
Received: from google.com ([2620:15c:2d3:205:d954:735:c86e:9b56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5ea0d5sm11198004a12.47.2024.11.12.15.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:04:27 -0800 (PST)
Date: Tue, 12 Nov 2024 15:04:22 -0800
From: Peter Collingbourne <pcc@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Qun-Wei Lin <qun-wei.lin@mediatek.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 5.4 462/462] mm: krealloc: Fix MTE false alarm in
 __do_krealloc
Message-ID: <ZzPe9ossmfQP_s77@google.com>
References: <20241106120331.497003148@linuxfoundation.org>
 <20241106120342.916487840@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106120342.916487840@linuxfoundation.org>

On Wed, Nov 06, 2024 at 01:05:55PM +0100, Greg Kroah-Hartman wrote:
> 5.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> 
> commit 704573851b51808b45dae2d62059d1d8189138a2 upstream.
> 
> This patch addresses an issue introduced by commit 1a83a716ec233 ("mm:
> krealloc: consider spare memory for __GFP_ZERO") which causes MTE
> (Memory Tagging Extension) to falsely report a slab-out-of-bounds error.
> 
> The problem occurs when zeroing out spare memory in __do_krealloc. The
> original code only considered software-based KASAN and did not account
> for MTE. It does not reset the KASAN tag before calling memset, leading
> to a mismatch between the pointer tag and the memory tag, resulting
> in a false positive.
> 
> Example of the error:
> ==================================================================
> swapper/0: BUG: KASAN: slab-out-of-bounds in __memset+0x84/0x188
> swapper/0: Write at addr f4ffff8005f0fdf0 by task swapper/0/1
> swapper/0: Pointer tag: [f4], memory tag: [fe]
> swapper/0:
> swapper/0: CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.
> swapper/0: Hardware name: MT6991(ENG) (DT)
> swapper/0: Call trace:
> swapper/0:  dump_backtrace+0xfc/0x17c
> swapper/0:  show_stack+0x18/0x28
> swapper/0:  dump_stack_lvl+0x40/0xa0
> swapper/0:  print_report+0x1b8/0x71c
> swapper/0:  kasan_report+0xec/0x14c
> swapper/0:  __do_kernel_fault+0x60/0x29c
> swapper/0:  do_bad_area+0x30/0xdc
> swapper/0:  do_tag_check_fault+0x20/0x34
> swapper/0:  do_mem_abort+0x58/0x104
> swapper/0:  el1_abort+0x3c/0x5c
> swapper/0:  el1h_64_sync_handler+0x80/0xcc
> swapper/0:  el1h_64_sync+0x68/0x6c
> swapper/0:  __memset+0x84/0x188
> swapper/0:  btf_populate_kfunc_set+0x280/0x3d8
> swapper/0:  __register_btf_kfunc_id_set+0x43c/0x468
> swapper/0:  register_btf_kfunc_id_set+0x48/0x60
> swapper/0:  register_nf_nat_bpf+0x1c/0x40
> swapper/0:  nf_nat_init+0xc0/0x128
> swapper/0:  do_one_initcall+0x184/0x464
> swapper/0:  do_initcall_level+0xdc/0x1b0
> swapper/0:  do_initcalls+0x70/0xc0
> swapper/0:  do_basic_setup+0x1c/0x28
> swapper/0:  kernel_init_freeable+0x144/0x1b8
> swapper/0:  kernel_init+0x20/0x1a8
> swapper/0:  ret_from_fork+0x10/0x20
> ==================================================================
> 
> Fixes: 1a83a716ec233 ("mm: krealloc: consider spare memory for __GFP_ZERO")
> Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/slab_common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Greg,

Can this be picked up for the other stable trees as well please? The
patch that caused MTE false positives is in linux-5.10.y, linux-5.15.y,
linux-6.1.y and linux-6.6.y but this fix is not. I checked that it
applies cleanly to all of them.

Peter

