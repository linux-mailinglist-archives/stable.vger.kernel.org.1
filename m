Return-Path: <stable+bounces-100857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525879EE179
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8652832B8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB520C491;
	Thu, 12 Dec 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHp+AMp1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04720B21D
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992831; cv=none; b=cZY5SGAaRIMO9ap3CCAazUR17ehIJmmf/M2sq5KVqmfhxVuKgtUKjk6DjpKv5pVBbSHAB67UowniAD5+71C4Aq6tIbmSUkJBIR+FZSDy2WHDq1b4qyWLCDV8Tg6f6GlTnUYorOGVQsogKfsb5KnjmtbrWE6TQvDrQFRnTvqGMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992831; c=relaxed/simple;
	bh=ZDojWym5GBv5R9yl8MqCmrOpTt/TfkaPvfHV/COpoRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLC5JTd4HUy7bb2JsCFZkt+6rqyvputjpCY7Me6Loh2RTfZvADlRBXFEFqcU1qOHLc1olYfWar2G2hvBVII8A/iZ0aqc8jTLdiAFE6guE+N8/UcdcQkZIVjRMs6BQhIuW15mwZOwSZJtD0+Wf7y/1J357gaqbhVKFhrYEMnxZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CHp+AMp1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso259388a91.1
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 00:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733992829; x=1734597629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWnOyqMKYaLNw6Hjh/NencQVmGDX4lNAVG9msfdiC/g=;
        b=CHp+AMp1F4Sn6VJ4Q8dDcpOnC+djvmzMNIouc+c0j80JDC2qr6+4luDLWxrHLe40T8
         FAC4/hxtBRCt2FXM53i+42XgdtbpXhEXrolrZpEdH+N807gZyyUS797d0niW6POXyMut
         pHgyEzVf31YgIgPh45oEq18H6P7hF4yoA7kh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992829; x=1734597629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWnOyqMKYaLNw6Hjh/NencQVmGDX4lNAVG9msfdiC/g=;
        b=rvcRRbrCIZoZT/reyBttCDJjpabCemc5qtMfWvu7yF/NUSSeHe/X88V0V6Aq/EmVpr
         w7B/hMGNQXNVOqIZ8zBnTgLT8xkTllUgPzO36T76/BDzSugfzcabrVgd8+RnQ2FWjUKM
         1Q5LrfQoWPCHy2hZ0mmxhcLGZfTb51eBYQwIYrssC9HU+3KrlQ6QzMgkO0i8+0bCyNc3
         wDaS3ogfWjiw66PEuZAWXY9Bu8hj//FWNbBv88edQzL5jgDJ/PnSBkc6YgWI+1IxJJPs
         VrbRwDXh+e7qyFRyQ6zerwZ73RkH580RD7FD/VFdSFHH2mpul0rVpYoP+8QdHgnDKEyF
         mnYA==
X-Forwarded-Encrypted: i=1; AJvYcCVTiHdw/k+n48eiJYYZL4blfA7EUqB/I0KsbZVGi28M6xFCBRry2YwWvfcUFlAl8HepxNnZKZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFZYmQSjgkcGD224jnY8huPY9U16+KUuZ6TJ2a8rZd6ErOw1G
	mGYHgC1mLKbvjqGNvThhMI+eC5o3s9Z8bZ2lVPVb1H84QhdFl6t0F2SdtH4Yew==
X-Gm-Gg: ASbGncvXQkqeEbpipnGl4RrHTt+BNncA4r1g0minQWYc8nZQlqSlzAS5hIeD51V5Fhr
	GKFU3mfjAjl2EMFDnrgh3VYkOnIF3UZZOOYHrKt9D+oIlHRklowbGBpt9AX9ZBpYSYsW0440xO0
	B7mfK2mWW1cE8LGGgKhKwU5rwR2Kpg0+oVqVh6ceey5Bgp2S88dGwVxJj30tz7HbwZb4Ch9+ikC
	tpf2uJGkR/zwDs4bESpCIIyHHCeGasp8CyWymw3nCThKk6nUH1lIS3WgV9M
X-Google-Smtp-Source: AGHT+IHfRdA7DXcXsyfYZ7mXYWJ3DFgW9qmw73u8i42U0YD/ReVoBFeuWqarOqaaR0lOjX1xHZ+9dg==
X-Received: by 2002:a17:90b:48cd:b0:2ee:fc08:1bc1 with SMTP id 98e67ed59e1d1-2f128044e4dmr9716305a91.37.1733992829190;
        Thu, 12 Dec 2024 00:40:29 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2d7e:d20a:98ca:2039])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d91a4asm724745a91.6.2024.12.12.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 00:40:28 -0800 (PST)
Date: Thu, 12 Dec 2024 17:40:24 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org, 
	senozhatsky@chromium.org, minchan@kernel.org, caiqingfu@ruijie.com.cn
Subject: Re: + zram-panic-when-use-ext4-over-zram.patch added to
 mm-hotfixes-unstable branch
Message-ID: <3awo2svbnsv2mvozhaqspwztgxhifphj7ffpmykc35py6wp6ol@xlt2q5qgv6c3>
References: <20241130030456.37C2BC4CECF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130030456.37C2BC4CECF@smtp.kernel.org>

On (24/11/29 19:04), Andrew Morton wrote:
> [   52.073080 ] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [   52.073511 ] Modules linked in:
> [   52.074094 ] CPU: 0 UID: 0 PID: 3825 Comm: a.out Not tainted 6.12.0-07749-g28eb75e178d3-dirty #3
> [   52.074672 ] Hardware name: linux,dummy-virt (DT)
> [   52.075128 ] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   52.075619 ] pc : obj_malloc+0x5c/0x160
> [   52.076402 ] lr : zs_malloc+0x200/0x570
> [   52.076630 ] sp : ffff80008dd335f0
> [   52.076797 ] x29: ffff80008dd335f0 x28: ffff000004104a00 x27: ffff000004dfc400
> [   52.077319 ] x26: 000000000000ca18 x25: ffff00003fcaf0e0 x24: ffff000006925cf0
> [   52.077785 ] x23: 0000000000000c0a x22: ffff0000032ee780 x21: ffff000006925cf0
> [   52.078257 ] x20: 0000000000088000 x19: 0000000000000000 x18: 0000000000fffc18
> [   52.078701 ] x17: 00000000fffffffd x16: 0000000000000803 x15: 00000000fffffffe
> [   52.079203 ] x14: 000000001824429d x13: ffff000006e84000 x12: ffff000006e83fec
> [   52.079711 ] x11: ffff000006e83000 x10: 00000000000002a5 x9 : ffff000006e83ff3
> [   52.080269 ] x8 : 0000000000000001 x7 : 0000000017e80000 x6 : 0000000000017e80
> [   52.080724 ] x5 : 0000000000000003 x4 : ffff00000402a5e8 x3 : 0000000000000066
> [   52.081081 ] x2 : ffff000006925cf0 x1 : ffff00000402a5e8 x0 : ffff000004104a00
> [   52.081595 ] Call trace:
> [   52.081925 ]  obj_malloc+0x5c/0x160 (P)
> [   52.082220 ]  zs_malloc+0x200/0x570 (L)
> [   52.082504 ]  zs_malloc+0x200/0x570
> [   52.082716 ]  zram_submit_bio+0x788/0x9e8
> [   52.083017 ]  __submit_bio+0x1c4/0x338
> [   52.083343 ]  submit_bio_noacct_nocheck+0x128/0x2c0
> [   52.083518 ]  submit_bio_noacct+0x1c8/0x308
> [   52.083722 ]  submit_bio+0xa8/0x14c
> [   52.083942 ]  submit_bh_wbc+0x140/0x1bc
> [   52.084088 ]  __block_write_full_folio+0x23c/0x5f0
> [   52.084232 ]  block_write_full_folio+0x134/0x21c
> [   52.084524 ]  write_cache_pages+0x64/0xd4
> [   52.084778 ]  blkdev_writepages+0x50/0x8c
> [   52.085040 ]  do_writepages+0x80/0x2b0
> [   52.085292 ]  filemap_fdatawrite_wbc+0x6c/0x90
> [   52.085597 ]  __filemap_fdatawrite_range+0x64/0x94
> [   52.085900 ]  filemap_fdatawrite+0x1c/0x28
> [   52.086158 ]  sync_bdevs+0x170/0x17c
> [   52.086374 ]  ksys_sync+0x6c/0xb8
> [   52.086597 ]  __arm64_sys_sync+0x10/0x20
> [   52.086847 ]  invoke_syscall+0x44/0x100
> [   52.087230 ]  el0_svc_common.constprop.0+0x40/0xe0
> [   52.087550 ]  do_el0_svc+0x1c/0x28
> [   52.087690 ]  el0_svc+0x30/0xd0
> [   52.087818 ]  el0t_64_sync_handler+0xc8/0xcc
> [   52.088046 ]  el0t_64_sync+0x198/0x19c
> [   52.088500 ] Code: 110004a5 6b0500df f9401273 54000160 (f9401664)
> [   52.089097 ] ---[ end trace 0000000000000000  ]---
> 
> When using ext4 on zram, the following panic occasionally occurs under
> high memory usage
> 
> The reason is that when the handle is obtained using the slow path, it
> will be re-compressed.  If the data in the page changes, the compressed
> length may exceed the previous one.  Overflow occurred when writing to
> zs_object, which then caused the panic.
> 
> Comment the fast path and force the slow path.  Adding a large number of
> read and write file systems can quickly reproduce it.
> 
> The solution is to re-obtain the handle after re-compression if the length
> is different from the previous one.

Andrew, I'm leaning toward asking you to drop this patch.  zram cannot
(nor should probably) do anything about upper layer modifying the page
data during write().  It's a bug in the upper layer which zram should
not hide.

