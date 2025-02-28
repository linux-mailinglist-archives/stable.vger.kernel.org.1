Return-Path: <stable+bounces-119962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B05A49EB9
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 17:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AF13A122A
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8FA270EC0;
	Fri, 28 Feb 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOtbig1y"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C526FD9F;
	Fri, 28 Feb 2025 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759944; cv=none; b=VHxZvxW3NHB09Hx27T0nDV+N8Cp6yFZ1OokXHtX7R3YxjmIfyiDlw/o/X4l0q9k+PgDZAapTXsiFRsewdFL7N+8m1NW4uQ2Mr17ut4If9c4BV/diOQNTrtkESjRvCDKpAK6kLriaBLbUvN7Xf3gBurrTZYipYkW3grz17LfekBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759944; c=relaxed/simple;
	bh=LTLvtGeYL4XvHXpRRiCpmpMx6e+FAaai3tPRX+PUS3Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECYT2Ayh9OlizzQAiUfTRGTA/Q+IfklIgiz/jriVCn2VruZYvRzZSVhC13mUeT9TrVWRVUgxlp5meHZnMEgVDdsxbPDhO6eUPK0z60Rk6gtSkXO7zfcQm7O5mVaN5oGrvI5OE8ZfExcJ4fwmfPYupRQ/kf9ZaqeXz+wbiHLTWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOtbig1y; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-548409cd2a8so2378863e87.3;
        Fri, 28 Feb 2025 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740759939; x=1741364739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhXr4TnCA5jbl50+NUvjqkpZysAKnfjV2gvofW855yQ=;
        b=cOtbig1y6NUyiYSWtESSAEK4bzsiVMUcm85Lg2GRKzPpCuoEgr4z5FYD77FlP5mo2h
         jRrPmpoD6kp1rKnz81InX4l2dwX2DCHSemuCHEN4RrYcnbdVDgsBtAbuVLE1KF441oO2
         WnLy98jr6ng3TbSG4CY/H1tornpLgdObL8gtA4CU+pYz/F+/DJGifadvGuSqfm9w33HG
         1Uu/0DnZJUcIWuFf+S4X5mROhoaGxdYCJADJvJHg8bhkdWto6XVVGrsb22YhdHkGx6Y7
         GPamnBHlaXnShNu2OncsSMi+GX4pF0z8LyY7nArAUOgXgdbfKJQaFEPJxPLGuFrLVtZH
         mvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759939; x=1741364739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhXr4TnCA5jbl50+NUvjqkpZysAKnfjV2gvofW855yQ=;
        b=rWgzi1JYJ5lzVTx7s0DyizBYv/tVJbItyCE5ibZ2UMvKFHgbxOgSnzHP2JU197mvoJ
         /nJm7sFOZroNt1ch7kbzEVEsURD+IjYXL5yl/8hcPrHkd/2EIaF+fEsJu0kEWzaIo4+J
         V54SLzIWzSUokBnlX6cLgmIDkxcSv5DkEhf8VkhVr6V6lxD5XktmCsPHwivHfgMXXfXq
         aKRRoVDieggbwk478wq5O+TA/EHyUUA13/TRWOGmn031r5sZ8v/lvgjxNCLQpdwkz+Bq
         XEa/cB4CTTj6SKdbAyTTQ+TTlVnvl30OKyrcaGibNRfbLSmb4V+SXIX8Eh3i/7D21gOY
         QsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUh8tHMYaC/Wu1nUnoNW+xthIPr2l+WxP4gkmNj7BwFlKCDxbA07tIoHWr/W2NFH0NtbzjhjzvnFCCIzs=@vger.kernel.org, AJvYcCVo59ZRWQJi6CuJOPP/eYOIsf25Oj9Cl5R5iw8GhTLSd9Lp+2oFDpRWaLJ9nuOdTW2aCkoFmotu@vger.kernel.org, AJvYcCW6/WWRVqcK9/OSqIytN+wjnjsVly6515ZVYcdLWvZTEzRRESunwKXuMXSA97EBPOD+ND1U@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8eyYELC8fuIJ6WMC4fBhwgFdjwawFF0AllGhcqn/skxWIvOpS
	9mugs1M5X63cb74Ob8VVamPfSfOXbPWpeFre2i2gsisuIaPe2mpJB4sYu5nW
X-Gm-Gg: ASbGncvH1nK4YlgpXW9iL65WLQpJZ1vZ+ZOqc+Doo7IxUGLiUbaTCjGe3TtKs8r5sC3
	lbyY39kCGAgrSWlSEZu0qbRdbdDw7q55Ddiej/0ExBAljNhOSwbFP0d6apjMk2nl9QSnhU0RXCj
	Hz+z653TA/U9WtXCsJ/5V0fzmjeQKc2vNg4IKfthkMHZJOdejU+4QxEBU+ugriL07Vjt2zfzVXm
	hRRuR/Nr3RD27kssMTU+wKUxTQJ75b2zp6GxQfAz86jJ61oRGHadDXRgH4xz/xkwY9re4YgBp2x
	++IZEVhn8hGedPnyPhSx2E3+AVEuAXslQ/hHF2XIXeHq4uMw
X-Google-Smtp-Source: AGHT+IFna21yxorFsIsk3fBISDfBJed+oeKfLzGr7m+Mk2HE5gJwcZopqbFpuVreIN6DkPqWVUKzKg==
X-Received: by 2002:a05:6512:398e:b0:548:91f6:4328 with SMTP id 2adb3069b0e04-5494c11b516mr1850636e87.15.1740759938890;
        Fri, 28 Feb 2025 08:25:38 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cb6ccsm546497e87.212.2025.02.28.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:25:38 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 28 Feb 2025 17:25:35 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v1 2/2] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
Message-ID: <Z8Hjf8avoBDMjD9q@pc636>
References: <20250228121356.336871-1-urezki@gmail.com>
 <20250228121356.336871-2-urezki@gmail.com>
 <c4d0005d-ae34-40d4-80a0-67ca904cdae1@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d0005d-ae34-40d4-80a0-67ca904cdae1@suse.cz>

On Fri, Feb 28, 2025 at 03:42:02PM +0100, Vlastimil Babka wrote:
> On 2/28/25 13:13, Uladzislau Rezki (Sony) wrote:
> > Currently kvfree_rcu() APIs use a system workqueue which is
> > "system_unbound_wq" to driver RCU machinery to reclaim a memory.
> > 
> > Recently, it has been noted that the following kernel warning can
> > be observed:
> > 
> > <snip>
> > workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
> >   WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
> >   Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) ...
> >   CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
> >   Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
> >   Workqueue: nvme-wq nvme_scan_work
> >   RIP: 0010:check_flush_dependency+0x112/0x120
> >   Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 ...
> >   RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
> >   RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
> >   RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
> >   RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
> >   R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
> >   R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
> >   FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
> >   CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
> >   PKRU: 55555554
> >   Call Trace:
> >    <TASK>
> >    ? __warn+0xa4/0x140
> >    ? check_flush_dependency+0x112/0x120
> >    ? report_bug+0xe1/0x140
> >    ? check_flush_dependency+0x112/0x120
> >    ? handle_bug+0x5e/0x90
> >    ? exc_invalid_op+0x16/0x40
> >    ? asm_exc_invalid_op+0x16/0x20
> >    ? timer_recalc_next_expiry+0x190/0x190
> >    ? check_flush_dependency+0x112/0x120
> >    ? check_flush_dependency+0x112/0x120
> >    __flush_work.llvm.1643880146586177030+0x174/0x2c0
> >    flush_rcu_work+0x28/0x30
> >    kvfree_rcu_barrier+0x12f/0x160
> >    kmem_cache_destroy+0x18/0x120
> >    bioset_exit+0x10c/0x150
> >    disk_release.llvm.6740012984264378178+0x61/0xd0
> >    device_release+0x4f/0x90
> >    kobject_put+0x95/0x180
> >    nvme_put_ns+0x23/0xc0
> >    nvme_remove_invalid_namespaces+0xb3/0xd0
> >    nvme_scan_work+0x342/0x490
> >    process_scheduled_works+0x1a2/0x370
> >    worker_thread+0x2ff/0x390
> >    ? pwq_release_workfn+0x1e0/0x1e0
> >    kthread+0xb1/0xe0
> >    ? __kthread_parkme+0x70/0x70
> >    ret_from_fork+0x30/0x40
> >    ? __kthread_parkme+0x70/0x70
> >    ret_from_fork_asm+0x11/0x20
> >    </TASK>
> >   ---[ end trace 0000000000000000 ]---
> > <snip>
> > 
> > To address this switch to use of independent WQ_MEM_RECLAIM
> > workqueue, so the rules are not violated from workqueue framework
> > point of view.
> > 
> > Apart of that, since kvfree_rcu() does reclaim memory it is worth
> > to go with WQ_MEM_RECLAIM type of wq because it is designed for
> > this purpose.
> > 
> > Cc: <stable@vger.kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> stable is sufficient, no need for greg himself too
> 
> > Cc: Keith Busch <kbusch@kernel.org>
> > Closes: https://www.spinics.net/lists/kernel/msg5563270.html
> 
> lore pls :)
> 
Thanks, got it. I tried but did not find the link :)

> > Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> > Reported-by: Keith Busch <kbusch@kernel.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> fixed locally and pushed to slab/for-next-fixes
> thanks!
>
Thanks!

--
Uladzislau Rezki

