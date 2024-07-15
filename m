Return-Path: <stable+bounces-59374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB8E931D22
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731331C21B83
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E5B13C9CD;
	Mon, 15 Jul 2024 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWplKzem"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591B13B791
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721082112; cv=none; b=XC7IkxTEC0h0D06cZb64R3tYd6JtCoBpdJsWio7Vo1V95nbtRdUK0vKyfXGj7z0QPBDZ2VrcJ832NH+b3C+eZAg2liQDSLMtlS6ApR0CIQkk5MSa9ZwW8u+lvhXu/5fjxj8Ch1KNgSzpi1Ygi2YT06t5uZgay7lslMlfJp2UsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721082112; c=relaxed/simple;
	bh=ngdjgUJXky3VHvdEx1HlSdhKUC14SCUQRFpJ5WWPihI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tql3yDmCZheyOagAE+8TAUNQ5L28lgniWQ/+BKisNGGCmSosXD/lm1q4mGaw19t1fLjFLdAh0vyBfaerEvzratsrfxj5Qo391bwWR1eyJQqW5xeuldCRMPQJXAuQg2/uepREDdDhvbAWNJOXlJ/aFMaC61ibRUjnC4tQMhO70zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWplKzem; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721082110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSAEoL90D2rESPJlR69imt1VdlcdBUDuG1SRzwUyeIM=;
	b=gWplKzemf2uKodaPtzZMfhGuktxQX7cD+yMsRl+yytRToMIlJR2vJatBLLbUw/9DSqmYPS
	gmlbyQ6toBxFCLI1ShaZshoq+FZ/3QFHx+IvZ6IgGE2IEeiwnPRg93/O2b+jiD8qAxJjRY
	HgnN4Lp79x4uuAgpkiZttzHaXeHl4FY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Jg_asFbhPNqtDQQ-7dk6HQ-1; Mon, 15 Jul 2024 18:21:48 -0400
X-MC-Unique: Jg_asFbhPNqtDQQ-7dk6HQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-80ba1cbd94eso383054239f.1
        for <stable@vger.kernel.org>; Mon, 15 Jul 2024 15:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721082107; x=1721686907;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSAEoL90D2rESPJlR69imt1VdlcdBUDuG1SRzwUyeIM=;
        b=MoKhYmmWCE41Ok6qb0yBgXF36KUHCWlwt2s7Jkn7CO0xmwvU11i1r0aRq/CgfWYDoR
         4N5H0fEt19E18YVHokrKf2tsb6R/TNU2JM0LLdwrZYygMecJPY9O72ahGnkOsQakt0Lo
         MdGrirKXuuvEsIVQVyuLn7Z+de6r+xb+cKGLRG2Z+D+c4xhroYY+lgwsHmyGLVcy+dqB
         U2LXb/EPFAfktioPtD3TEF28AKV8WljIyjKSGqDBQyiA74YZYVM2qInkLrUJbRhi7Wpk
         25TgeQQB/NE/gGpNChRZOgdEqoN0iBWkQgsCBUnhAsvTUk9ei/bDJiAS6uNFW517Ghxl
         VRIw==
X-Forwarded-Encrypted: i=1; AJvYcCX1anCkicEu8pnxk/Nv4WMujkmZ+u4rlLiEO4ZWQD87Y6UOKvwgs90u/AV1M/7nkJcm/Ex54/b+pzf+Zi5PydPV5eIaWfgT
X-Gm-Message-State: AOJu0YwHOcGAPiiGdT1baYJis2WbBFIB+6mrJZZzSxFM+V5B2HX8zvZp
	O7WINNZv3n7EFJAicXWxXBr0U2WWzElexjjR9EwiPZbAm0EIRoxGnJywzj2aDe4RiiRbTy3mfmA
	cgb+dKOC/FExk6zKGbmzQ+RECXcAaLHfrsvSkw6phwpUt7Fu51h1eBw==
X-Received: by 2002:a05:6602:164a:b0:7fd:5a50:b215 with SMTP id ca18e2360f4ac-815744480f8mr74236339f.3.1721082107645;
        Mon, 15 Jul 2024 15:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH56AwbTBEr+fC4H4bofZFcNEN2qYObHuoInT4K+ZAkNVsvEwJ48WyEwxwjmu/zT5AlH3QSuw==
X-Received: by 2002:a05:6602:164a:b0:7fd:5a50:b215 with SMTP id ca18e2360f4ac-815744480f8mr74233839f.3.1721082107313;
        Mon, 15 Jul 2024 15:21:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-80e11f90077sm158091939f.18.2024.07.15.15.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 15:21:46 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:21:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Leah Rumancik <leah.rumancik@gmail.com>, Sasha Levin
 <sashal@kernel.org>, stable@vger.kernel.org, Miaohe Lin
 <linmiaohe@huawei.com>, Thorvald Natvig <thorvald@google.com>, Jane Chu
 <jane.chu@oracle.com>, Christian Brauner <brauner@kernel.org>, Heiko
 Carstens <hca@linux.ibm.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mateusz Guzik
 <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, Muchun Song
 <muchun.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>, Peng Zhang
 <zhangpeng.00@bytedance.com>, Tycho Andersen <tandersen@netflix.com>,
 Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6] fork: defer linking file vma until vma is fully
 initialized
Message-ID: <20240715162145.6e13cbff.alex.williamson@redhat.com>
In-Reply-To: <20240715203541.389415-1-axelrasmussen@google.com>
References: <CACzhbgRoMEAzkEVZPMEHR2JsNn5ZNw1SwKqP1FVzej4g_87snQ@mail.gmail.com>
	<20240715203541.389415-1-axelrasmussen@google.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 13:35:41 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> I tried out Sasha's suggestion. Note that *just* taking
> aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") is not sufficient, we also
> need b7c5e64fec ("vfio: Create vfio_fs_type with inode per device").
> 
> But, the good news is both of those apply more or less cleanly to 6.6. And, at
> least under a very basic test which exercises VFIO memory mapping, things seem
> to work properly with that change.
> 
> I would agree with Leah that these seem a bit big to be stable fixes. But, I'm
> encouraged by the fact that Sasha suggested taking them. If there are no big
> objections (Alex? :) ) I can send the backport patches this week.
> 

If you were to take those, I think you'd also want:

d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault")

which helps avoid a potential regression in VM startup latency vs
faulting each page of the VMA.  Ideally we'd have had huge_fault
working for pfnmaps before this conversion to avoid the latter commit.

I'm a bit confused by the lineage here though, 35e351780fa9 ("fork:
defer linking file vma until vma is fully initialized") entered v6.9
whereas these vfio changes all came in v6.10, so why does the v6.6
backport end up with dependencies on these newer commits?  Is there
something that needs to be fixed in v6.9-stable as well?

Aside from the size of aac6db75a9 in particular, I'm not aware of any
outstanding issues that would otherwise dissuade backport to
v6.6-stable.  Thanks,

Alex


