Return-Path: <stable+bounces-110314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA38A1A90E
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A9C3A532A
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F91494B3;
	Thu, 23 Jan 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XciGOaTD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713271474A2
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654045; cv=none; b=jefHHkSxDjEFOc2WE3HUuNoIEvMVLNdOwdbI1/m1BaukuQUVIzv954FQQZi50q8E6zVN5xHw0JoB2ZNH7LVu9an/TvaOMjb8kLSOUYXgDEEbE7zHUDKwp6ikdajEsEDnZVfyn/JJAozL8zHAcWldnzteKhbNK0L800uebz3064U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654045; c=relaxed/simple;
	bh=7cjd1Yc0hl2CQdFqJ9Y9P/NXJ/ttmM66Cy4jphvpv58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpG1++mvuoZofG3+18YZ2i2DhfYOgWuTaOhCAlY5PXyzOPN2D8DsVLNRq74T37XZepH3IlPzzpkfui0iADToErrwobXUDuYJcVQ9ujHRE/j1i4m44C0TqPzwTGnuS1kn7E55atCeGMFQ9NgxNof2VJe4sMqeZR56gd3CQWO88Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XciGOaTD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737654042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3XAX29t0p8K//ChrZkKS09FKeW39YxcTgnGMJjcmuk=;
	b=XciGOaTDlOwzTclb/t3tFZOs0joBn8FsLe1O6m+bx3pdushLCKgqAUfiYAHkc83VswZL3g
	If94zPydMq+N0NGxQkfzItfze1s+ztWAYK0sAmDlo0BlumyGh1D8aMTAr40vRwid3roe89
	jz7zth7LQaYMpqj9OAnW9x2rnu1udOs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-EupyfJ6SMFmMVVLhuinn_w-1; Thu, 23 Jan 2025 12:40:40 -0500
X-MC-Unique: EupyfJ6SMFmMVVLhuinn_w-1
X-Mimecast-MFC-AGG-ID: EupyfJ6SMFmMVVLhuinn_w
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d89a389ee9so27246826d6.2
        for <stable@vger.kernel.org>; Thu, 23 Jan 2025 09:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654040; x=1738258840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3XAX29t0p8K//ChrZkKS09FKeW39YxcTgnGMJjcmuk=;
        b=X5yS64g+vPZYBd6pvLxuLHUfm4h/OT60TU/WzSoj8nlaAUlExGlWMkPbrW7gyUEBql
         hVP144wG9Dj13wwNNlo0RQwdCltfB3utphSxDAqOFaSpW9IaRogT+CSbsQDe20P1zxHz
         nGh+R8f1Bao2o5tELeZEd+594nPiyvjoiHHv5bQGXMv2M4zKxwqtKqEtbfwtANUVpx0L
         r+hVv2Z93lZ37YQSaMcw3CDION0A8ijleGIl6kzWTK26cnQXcABCdYP9kHZBQz/9J2SW
         Ubk8uUsH5ibZkZJC1Cu9g7OpixzyRKowqHH1ID1oZgSM6ZTW+CPmdZd8mnW7izxKKCfk
         nyGw==
X-Forwarded-Encrypted: i=1; AJvYcCV7yHSg5WBpKlm548HVQmd7QVrPQuVKZzAF0NV0upJfNb5bxznp5mBgNgyCNE/o3XjDB88lR8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3Otj3cY2ioVZRTUd7EzbXS5zYaiTFIR4a9AU23TgVSP49i/Y
	N6gVArTWscO68dJuMD8icflIb3sx4lpCJMBJa12LlqiW/Pf0cmKa+vtuCW3mVh9fbdm4BZnQ7sI
	vJMKWq0VljNHUfqju/VRPswTrK7ikAjP9HQPFRAVq75ITwiziQ86xAQ==
X-Gm-Gg: ASbGncsbI0Fo2rd6Oa3NSAGGINrXwzQKO06gLliyd4liTijnTMpxJUGmHGTYueuUCz8
	sYRwPINQgGWRZlyJ43BxiVvKmGCsM/LBZfSuMDZwzFGrDae2Ka7NdeZrmGX9VhFcUrP/0jnlOvu
	EMoxsj52Arms8pc/XxMG12NPsxEUmcwE43SgjasaCY1DRckuUNtlXF3Pva1SuUUx2on7aEu2PsI
	Y1pYxY+htTCQK7iamSO7wGXPaHo3r+lOPA3xbejqa1ulmH5xj+EQQhl2U7jqLjAkQlsGolgSlZo
	FN1kB4kq9zKxKr12UkEs6luVmovekBQ=
X-Received: by 2002:a05:6214:1310:b0:6d8:9bbe:392d with SMTP id 6a1803df08f44-6e1b217141amr290342916d6.6.1737654040281;
        Thu, 23 Jan 2025 09:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp4As9pxJYPHqbJe7dQDEW7PkmFEro8NdCnUdEyw6JKRvfiOBNyNiaILOnexjjY4E1VYRsDQ==
X-Received: by 2002:a05:6214:1310:b0:6d8:9bbe:392d with SMTP id 6a1803df08f44-6e1b217141amr290342656d6.6.1737654039996;
        Thu, 23 Jan 2025 09:40:39 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20514ee9bsm694376d6.30.2025.01.23.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:40:39 -0800 (PST)
Date: Thu, 23 Jan 2025 12:40:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Message-ID: <Z5J_FLry1C2d3BKv@x1n>
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
 <20250107144755.1871363-2-ryan.roberts@arm.com>
 <850479be-000a-45a7-9669-491d4200a988@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <850479be-000a-45a7-9669-491d4200a988@arm.com>

On Thu, Jan 23, 2025 at 02:38:46PM +0000, Ryan Roberts wrote:
> > @@ -5470,7 +5471,18 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
> >  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> >  
> >  	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
> > -	set_huge_pte_at(mm, new_addr, dst_pte, pte, sz);
> > +
> > +	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
> > +		huge_pte_clear(mm, new_addr, dst_pte, sz);
> 
> This is checking if the source huge_pte is a uffd-wp marker and clearing the
> destination if so. The destination could have previously held arbitrary valid
> mappings, I guess?

I think it should be all cleared.  I didn't check all mremap paths, but for
MREMAP_FIXED at least there should be:

	if (flags & MREMAP_FIXED) {
		/*
		 * In mremap_to().
		 * VMA is moved to dst address, and munmap dst first.
		 * do_munmap will check if dst is sealed.
		 */
		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
		if (ret)
			goto out;
	}

It also doesn't sound right to leave anything in dest range, e.g. if there
can be any leftover dest ptes in move_page_tables(), then it means
HPAGE_P[MU]D won't work, as they install huge entries directly.  For that I
do see a hint in the comment too in that path:

move_normal_pud():
	/*
	 * The destination pud shouldn't be established, free_pgtables()
	 * should have released it.
	 */
	if (WARN_ON_ONCE(!pud_none(*new_pud)))
		return false;

PMD path has similar implications.

Thanks,

-- 
Peter Xu


