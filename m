Return-Path: <stable+bounces-154588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B4ADDEBA
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC61177693
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 22:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79F82949F3;
	Tue, 17 Jun 2025 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zn/aF4E/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F912F5312
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199340; cv=none; b=XgOlK5OkNdSHM/jMG4wGnuZ6yPZkfnkHl51pLUmjBM6tD5UOlA6PTJ/PeA5YKbMhA7klDDzs+pXXthdeAcX02iJDWmVMWtb0SFwLNjmwVHCQD2xtvIwM6iT3+ZHAjXASVo7auvEQTn3mANRDoWRq5vvqUm4h399WAlQOppb4Sao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199340; c=relaxed/simple;
	bh=/4Z85qLiOhrFNWNtp4uVTiF3dKWrPY9wrRNfbZmguZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnNcsV6kDhMLtEH9ZMZyeZ8TuXqzQECb7lvcatsxDRjAwuf3iiz7I8M7SMXF50pp2yAtldsgG1SOE+odEjaeEIuV/7STGrSEYgaE2vINUxPYn1dU5yK9S5JGVuaSz+4eHLZWpv3cajhIXc1OxrTC6a1pFGFc0EgMhTidcrt7Aw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zn/aF4E/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso102390a12.1
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1750199338; x=1750804138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3N7YOdKa5o/LDuwU1IaHWnPevk35pPCx13T0ozSKakU=;
        b=zn/aF4E/a6FsJJj2X/wjlDiZ2x/qHjKZWS73G/tlIPOonGTn6U5BHPAW/vRz+EoTNl
         ucYwqXoQSUkRckcGLgHXoPkQwOXTATdsohL7Nk/DMv787NRkU2ZmSxc5KVBiadt35S2r
         fpp1cDT9blCWlUtgU3PvmNMZih3icroDZOqbzSU2h4n28nheVGoc22mc8H9tuSqjr5/v
         S3p3xmw2HbVEPn79+rlV6YN7NinO61/6H5O888Diqu3eOlCgsDLup6UDkFbxtmo/X+ri
         zg17Ob8s+C2gpB1OahafzoJHgT3wNuVpS4suJIs2WteUdSegSIVrLiug/g8ffFeiNSBf
         sT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199338; x=1750804138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3N7YOdKa5o/LDuwU1IaHWnPevk35pPCx13T0ozSKakU=;
        b=k/tcf7/ixlH+eQgwrYdssgQ2Hek6F2jA9UCAEpQTfkJ2++S6/aMK4OrqPlL12Pub7r
         jGTIuVmyyGcAZ456fSvcLaOGFMTp/WUpU8AMVsvyalyMHDg5A085Z+UBHp5Ys7j1/Hf0
         2lzNsMHWcyt453LCimj1a+TPWjapwCx8hHQ4XqGmJIE1nIDtptMgIRdKR1ffeZ+Rhtez
         jT9iZBlgO96RyfleQZIg4qjGtVghkjbrxXa7LC8fyX7F3t0ho00VY7bcNAAXl0F3YiS+
         GFfkCx+xHU6Yn4yE4gTM6m1H7MVS5Gqcg2Xs7cnTd04Tn9rURfTxRu+8oHjarusHRhNJ
         Di+A==
X-Forwarded-Encrypted: i=1; AJvYcCWwvQxTemWVEEr0oMeQyZrYhrBfFAIjKXLXJi29hUQf6dvs6qe207RtL2LPN5ayXXndSY1v4LY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rPmYsaFkMyNMjWM7R4Au1CUZjzYfZ8nZglotQUpMXqA3S1XC
	8e/NNhG3wUi3KUIpsdxGfeC9xNS3ddWXYbYrdmIzswa5IQAnpE5BUAyPtN29z8Yb6HYg9HYj9Nk
	c0B1j
X-Gm-Gg: ASbGnctYlR9DqL9oieVVsN6UEdMwUv2WMudOciy0bb7KcnfHKcxa1W4syaR6e/vnvBf
	n01rgO//DiJE9O76OgjXujpfkP4gMFk2W+BhDqKIscAAqk8JE1ow1HjB3L82JKpgPD1rqywCZ0s
	gAfMas8axS4yFWicRwU8blR6Ky3Mn48c3BhRNkrFD8DetMrtajNLCEwF2Oy5HrDUczrPDNmBo9x
	VTFJtTbAxLQXFpQBbzE7gKDzHZQ0iFgjZaX32mmBIo21T7wnYMi30WU38moiBw5RFh2HGtnYLxo
	bmYUFQQ/J0cNIVcZCyWpJ+esp6VFi8iVDKrI7PiYx+01TMzO//jIhR0ZE9Q2S4pI6BHlQC1DuaS
	CZJgXEH9WiwOtmuKBSS/rmA58VbvWf0aY7MvdBQ==
X-Google-Smtp-Source: AGHT+IH9Adp7KVCe1dIB54ciUppQCSTOfdY/Fpe9p7WGaoQb5fXtwqTYHTw3SzH3gfOqEsKuhxarPA==
X-Received: by 2002:a17:90b:52d0:b0:30e:3737:7c87 with SMTP id 98e67ed59e1d1-3157c71770dmr313026a91.5.1750199338280;
        Tue, 17 Jun 2025 15:28:58 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88eb80sm85874875ad.5.2025.06.17.15.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 15:28:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uRenW-00000000Avl-3saH;
	Wed, 18 Jun 2025 08:28:54 +1000
Date: Wed, 18 Jun 2025 08:28:54 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christian Theune <ct@flyingcircus.io>
Cc: Carlos Maiolino <cem@kernel.org>, stable@vger.kernel.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	regressions@lists.linux.dev
Subject: Re: temporary hung tasks on XFS since updating to 6.6.92
Message-ID: <aFHsJmPhK6hBfEPC@dread.disaster.area>
References: <M1JxD6k5Sdxnq-pztTdv_FZwURA8AaT9qWNFUYGCmhiTRQFESfH7xqdOqQjz-oKQiin8pQckoNhfNyCHu-cxEQ==@protonmail.internalid>
 <14E1A49D-23BF-4929-A679-E6D5C8977D40@flyingcircus.io>
 <umhydsim2pkxhtux5hizyahwd6hy36yct5znt6u6ewo4fojvgy@zn4gkroozwes>
 <Z9Ih4yZoepxhmmH5Jrd1bCz35l6iPh5g2J61q2NR7loEdQb_aRquKdD1xLaE_5SPMlkBM8zLdVfdPvvKuNBrGQ==@protonmail.internalid>
 <3E218629-EA2C-4FD1-B2DB-AA6E40D422EE@flyingcircus.io>
 <g7wcgkxdlbshztwihayxma7xkxe23nic7zcreb3eyg3yeld5cu@yk7l2e4ibajk>
 <01751810-C689-4270-8797-FC0D632B6AB6@flyingcircus.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01751810-C689-4270-8797-FC0D632B6AB6@flyingcircus.io>

On Mon, Jun 16, 2025 at 12:09:21PM +0200, Christian Theune wrote:
> > Can you share the xfs_info of one of these filesystems? I'm curious about the FS
> > geometry.
> 
> Sure:
> 
> # xfs_info /
> meta-data=/dev/disk/by-label/root isize=512    agcount=21, agsize=655040 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=1, rmapbt=0
>          =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
>          =                       exchange=0
> data     =                       bsize=4096   blocks=13106171, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=0
> log      =internal log           bsize=4096   blocks=16384, version=2
>          =                       sectsz=512   sunit=0 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0

From the logs, it was /dev/vda1 that was getting hung up, so I'm
going to assume the workload is hitting the root partition, not:

> # xfs_info /tmp/
> meta-data=/dev/vdb1              isize=512    agcount=8, agsize=229376 blks

... this one that has a small log.

IOWs, I don't think the log size is a contributing factor here.

The indication from the logs is that the system is hung up waiting
on slow journal writes. e.g. there are processes hung waiting for
transaction reservations (i.e. no journal space available). Journal
space is backed up on metadata writeback trying to force the journal
to stable storage (which is blocked waiting for journal IO
completion so it can issue more journal IO) and getting blocked so
it can't make progress, either.

I think part of the issue is that journal writes issue device cache
flushes and FUA writes, both of which require written data to be
on stable storage before returning.

All this points to whatever storage is backing these VMs is
extremely slow at guaranteeing persistence of data and eventually it
can't keep up with the application making changes to the filesystem.
When the journal IO latency gets high enough you start to see things
backing up and stall warnings appearing.

IOWs, this does not look like a filesystem issue from the
information presented, just storage that can't keep up with the rate
at which the filesystem can make modifications in memory. When the
fs finally starts to throttle on the slow storage, that's when you
notice just how slow the storage actually is...

[ Historical note: this is exactly the sort of thing we have seen
for years with hardware RAID5/6 adapters with large amounts of NVRAM
and random write workloads. They run as fast as NVRAM can sink the
4kB random writes, then when the NVRAM fills, they have to wait for
hundreds of MB of cached 4kB random writes to be written to the
RAID5/6 luns at 50-100 IOPS. This causes the exact same "filesystem
is hung" symptoms as you are describing in this thread. ]

> >>> There has been a few improvements though during Linux 6.9 on the log performance,
> >>> but I can't tell if you have any of those improvements around.
> >>> I'd suggest you trying to run a newer upstream kernel, otherwise you'll get very
> >>> limited support from the upstream community. If you can't, I'd suggest you
> >>> reporting this issue to your vendor, so they can track what you are/are not
> >>> using in your current kernel.
> >> 
> >> Yeah, we’ve started upgrading selected/affected projects to 6.12, to see whether this improves things.

Keep in mind that if the problem is persistent write performance of
the storage, upgrading the kernel will not make it go away. It may
make it worse, because other optimisations we've made in the mean
time could mean the journal fills faster and pushes into the
persistent IO backlog latency issue sooner and more frequently....

-Dave.

-- 
Dave Chinner
david@fromorbit.com

