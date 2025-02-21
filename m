Return-Path: <stable+bounces-118538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7DFA3EA57
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 02:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1462F7AA2A4
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 01:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53640155C96;
	Fri, 21 Feb 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xktfs3jx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722102AD0F
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102572; cv=none; b=Y3oZD5X6hwcXDKB2jfC96qI+Y0SrZqRdtH/OM64QgkX6FAheLj8etf5yqDHdXu+6rWDHNZHQeOdSxFSdcIYCWstf8b/GBYCFdWS6I/n9U68cntHJ1eGFN2T89fKmHdMNMJxE4aQtm89ETDs9qhgUCxmObZyVoOxz5b4ZuR2FwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102572; c=relaxed/simple;
	bh=VjuLqY+ZIiObLtVOYjkYfJS6vZpBkUGJI20W9ndzbaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObN7LGDqhzpGNzuJrtcQZTU/WA+OV6yaQQRsv88ikNlrQo7PPoHZvdTRs/3iEYasw8rbSJR6TGz432l7QNQh6JagDgUnYMN6tjEWXOSGtPDgPHLeMK/pzD7PTqWi9BQKGgTp9Knuvm8SaPd4Miu8GKyGKtnI2O1Q8qwf//SvjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xktfs3jx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740102569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReQaqT7YyFR6yUBjN3GEKsiJ157l6bNf2zhu1ytH118=;
	b=Xktfs3jxy5aDfNYO+sDjdqdOi3VR8n612zg5JPwS3+PlmfEGTsJ0k46iuoBHq0TBJ6KMyZ
	GpZYIkk+alSEoy2a+1UXJ8Lmq69BWycoeiHoG/0bhI3KHjM1vQ7Iiu2Rq35K8S9IKYZRrg
	+ChuPP2fv9qeKBRhAFE0sx91QUyMCXY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ZFf9BWfhOaW4SRlvXcIAIA-1; Thu, 20 Feb 2025 20:49:27 -0500
X-MC-Unique: ZFf9BWfhOaW4SRlvXcIAIA-1
X-Mimecast-MFC-AGG-ID: ZFf9BWfhOaW4SRlvXcIAIA_1740102567
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e65e656c41so29767866d6.1
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 17:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740102567; x=1740707367;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReQaqT7YyFR6yUBjN3GEKsiJ157l6bNf2zhu1ytH118=;
        b=AxuvGrnQuMuL5KJxi07TTu3CdkKB1CVsCRaxbTQeuZ0dhzmdXBmDR1xlVpEr2znAKI
         1g9tcHc8eZpTAiEaCzjlw8yZfbX4KbFk5W/Kds0L/JXAQL6k7x1GAKlfSX7ZKK5VL0GK
         /bukwlcbpx9km/y+EkKGbVrb9Ok68QYgetuPxlQ90DNFvAC8Wgs2H1hLqb7wbMxTTvVy
         9VDG290O86ZCG8VMUSDETfChRRx/Da96IHy741sqzofTxN8/Lp0rFvk4LQ2G7MVnlJBB
         oMXL4Ho8xDhtf84Qi54ZQcxxUeErmQ5IaWpdpZVOxUrnq4gGTL8OD/8aj4qKCjcs/tFO
         tmpw==
X-Forwarded-Encrypted: i=1; AJvYcCVdfpyRaUPSdNkDOwRLsFwqIRzNLvEoxzmHm5YxTfoRVPwF+fb4pMYT49IC1UVfCJbYCONoQVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMrBOX4EXlmjFGDU0F6ZbP292nYDhBZWFUpuNH7RaWzZ/BELo
	7ThNEj4x7eHW/WaAN1RjUrIsfasXixAI961nBI6Bwzvix8U6jxjTbmH1ANqh/62P9yhVlzakHyZ
	iHU9zNNe6Es8oGvdoN8/FSksR62LGBh44tu+gWjezVT74TQoDM8hViQ==
X-Gm-Gg: ASbGncuF/FnsrVka6AuPQuJfMu0Xu9ygibJLybb2/50XY+oOzF+T+icQ8ilJOfL3TYw
	HlfWdSqYtK3+FneW2EEutt0dVPM1h8dAElVMAfbwPLXPZAQcZ3qLWqQjxQDnxQ03elqp0jhaN0n
	fd9XvZPbsHs+R2v4kc0YnxycBFM7+u3fqaaxlWPkemQ+vn0+ZPdTvE6/sfN6Hnop1Oj73vlSXlM
	xIOvv0c8gTfTZ5E36GfS9EhY2EBJK3BobrcWEuNQWqCxsTS4VLKpZiE972BSK/5/ExnMg==
X-Received: by 2002:a05:6214:230e:b0:6e6:6caf:e6f5 with SMTP id 6a1803df08f44-6e6ae7f686cmr19650496d6.13.1740102567049;
        Thu, 20 Feb 2025 17:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ3hTUOIK5Y81kSs6HZbVEqO+XYLZJOLfVD+JhLPPtobgIjBqYeyCrh/BXefIFsMMf2oo66Q==
X-Received: by 2002:a05:6214:230e:b0:6e6:6caf:e6f5 with SMTP id 6a1803df08f44-6e6ae7f686cmr19650276d6.13.1740102566712;
        Thu, 20 Feb 2025 17:49:26 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3faasm92209016d6.57.2025.02.20.17.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 17:49:26 -0800 (PST)
Date: Thu, 20 Feb 2025 20:49:22 -0500
From: Peter Xu <peterx@redhat.com>
To: Barry Song <21cnbao@gmail.com>
Cc: david@redhat.com, Liam.Howlett@oracle.com, aarcange@redhat.com,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	bgeffon@google.com, brauner@kernel.org, hughd@google.com,
	jannh@google.com, kaleshsingh@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lokeshgidra@google.com, mhocko@suse.com, ngeoffray@google.com,
	rppt@kernel.org, ryan.roberts@arm.com, shuah@kernel.org,
	surenb@google.com, v-songbaohua@oppo.com, viro@zeniv.linux.org.uk,
	willy@infradead.org, zhangpeng362@huawei.com,
	zhengtangquan@oppo.com, yuzhao@google.com, stable@vger.kernel.org
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
Message-ID: <Z7fbom4rxRu-NX81@x1.local>
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com>
 <Z7e7iYNvGweeGsRU@x1.local>
 <CAGsJ_4zXMj3hxazV1R-e9kCi_q-UDyYDhU6onWQRtRNgEEV3rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zXMj3hxazV1R-e9kCi_q-UDyYDhU6onWQRtRNgEEV3rw@mail.gmail.com>

On Fri, Feb 21, 2025 at 01:07:24PM +1300, Barry Song wrote:
> On Fri, Feb 21, 2025 at 12:32 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 10:21:01PM +1300, Barry Song wrote:
> > > 2. src_anon_vma and its lock – swapcache doesn’t require it（folio is not mapped）
> >
> > Could you help explain what guarantees the rmap walk not happen on a
> > swapcache page?
> >
> > I'm not familiar with this path, though at least I see damon can start a
> > rmap walk on PageAnon almost with no locking..  some explanations would be
> > appreciated.
> 
> I am observing the following in folio_referenced(), which the anon_vma lock
> was originally intended to protect.
> 
>         if (!pra.mapcount)
>                 return 0;
> 
> I assume all other rmap walks should do the same?

Yes normally there'll be a folio_mapcount() check, however..

> 
> int folio_referenced(struct folio *folio, int is_locked,
>                      struct mem_cgroup *memcg, unsigned long *vm_flags)
> {
> 
>         bool we_locked = false;
>         struct folio_referenced_arg pra = {
>                 .mapcount = folio_mapcount(folio),
>                 .memcg = memcg,
>         };
> 
>         struct rmap_walk_control rwc = {
>                 .rmap_one = folio_referenced_one,
>                 .arg = (void *)&pra,
>                 .anon_lock = folio_lock_anon_vma_read,
>                 .try_lock = true,
>                 .invalid_vma = invalid_folio_referenced_vma,
>         };
> 
>         *vm_flags = 0;
>         if (!pra.mapcount)
>                 return 0;
>         ...
> }
> 
> By the way, since the folio has been under reclamation in this case and
> isn't in the lru, this should also prevent the rmap walk, right?

.. I'm not sure whether it's always working.

The thing is anon doesn't even require folio lock held during (1) checking
mapcount and (2) doing the rmap walk, in all similar cases as above.  I see
nothing blocks it from a concurrent thread zapping that last mapcount:

               thread 1                         thread 2
               --------                         --------
        [whatever scanner] 
           check folio_mapcount(), non-zero
                                                zap the last map.. then mapcount==0
           rmap_walk()

Not sure if I missed something.

The other thing is IIUC swapcache page can also have chance to be faulted
in but only if a read not write.  I actually had a feeling that your
reproducer triggered that exact path, causing a read swap in, reusing the
swapcache page, and hit the sanity check there somehow (even as mentioned
in the other reply, I don't yet know why the 1st check didn't seem to
work.. as we do check folio->index twice..).

Said that, I'm not sure if above concern will happen in this specific case,
as UIFFDIO_MOVE is pretty special, that we check exclusive bit first in swp
entry so we know it's definitely not mapped elsewhere, meanwhile if we hold
pgtable lock so maybe it can't get mapped back.. it is just still tricky,
at least we do some dances all over releasing and retaking locks.

We could either justify that's safe, or maybe still ok and simpler if we
could take anon_vma write lock, making sure nobody will be able to read the
folio->index when it's prone to an update.

Thanks,

-- 
Peter Xu


