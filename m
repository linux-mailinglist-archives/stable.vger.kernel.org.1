Return-Path: <stable+bounces-136730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164E2A9CE1F
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292A39E6B8E
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE61A2557;
	Fri, 25 Apr 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHBtXhP8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DCA19F462
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598430; cv=none; b=dxUL+7dVwIqpdtqx3AGTvzj/SEg4cOb18KbwDFYG67SPAvNC6lSJ/z510/0tqPF/Tc+5DIVQlmJaf4OpreOf3eMe0l2Dk9aj8mypDvy/dreTGPmbVpuviMqGX3kv2C+KcLAOXO0ci/AUntgE0Jw5mxTw43uyS4LBMOm8SR0AKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598430; c=relaxed/simple;
	bh=gfj6qfAB2+A2B2FUesZrGJqPp4VulFSQvkvzvy8kgwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmybpX5Xtg7Q2Jry9TE8kGMkfHc7xf/n9JzVlQBkivDjehbfHMOIxA9SIVUBGPJcvSuBQ3s7DFRJ5puuBjwldsC9LmKb2BJov6Lluwd/dLuVI4qySvJA+PDEt0eD9brTP/+zZeO9nmT8PamR7YX8ToEJ/4Xiktwrvj10NUZwo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHBtXhP8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745598428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MhH+JzUZ4LUQs+r61lBHwV7dFz4bYUCQFljM9RbcvE=;
	b=RHBtXhP8da7XjrpJifMEMvv8WBYSqUbkxy6QHOGE7laRgDmWcre/qob9HHDoBjPQva6gxQ
	FQvffRNy8SlBxBZCDG9D443OS23CjdvsU6VDaZNhOzEzM+4/9BvFjmNJXp/2U5JuYVrpb+
	EkjTULrIyaWCjfwJYVtpzwFKYFyVkZ4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-XMTWmpbgNlKI_DZNFckd1g-1; Fri, 25 Apr 2025 12:27:04 -0400
X-MC-Unique: XMTWmpbgNlKI_DZNFckd1g-1
X-Mimecast-MFC-AGG-ID: XMTWmpbgNlKI_DZNFckd1g_1745598424
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6f0c089909aso44740336d6.2
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 09:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745598424; x=1746203224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MhH+JzUZ4LUQs+r61lBHwV7dFz4bYUCQFljM9RbcvE=;
        b=GOLabQNfL2+4ajCOJnVWyrOSqN4yLl1NoBf0V9xD7AvrnrrLDdlEnM9KI1rH0GLldn
         ra8/NY6B8KFiPBWVzNjomuVShroeb/ESg5fDQYiz2n8ErvNUPQZVdWD70/Fal+iH/JtB
         8twtHLNkvoR1daM34tc/Wjn6z7QsnIt9DlI6bJUBHvJA7FTAy5JkLIEyre2VECoI+MdW
         93XoiQPIcAfzPprUS2MK5bUbpC+d5JACytPK8TJySxw3pBS706Dx/Un6X77WJbp8B0ES
         TuyjpwYp/IOge7xZNC1BmJASr7HoeKMZ/okVjhP/jvD4KZ3O1ejm2oFHh3kA+OAIUWNE
         GCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDFTs21uNCNJ+azoDb1VurYoIC3kwa01wMU69FUjzxQL+TuE29zlZdB2xHXUM4//mrr7WBd2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLC4zeBNkOVZPtFjTEvhuBht8IMfIB6mISW9fu9cz2oMN9js99
	rn9rIazNH5C5KpzqODByuJouWC0WoeMLNixjxgJmqlCjC1uYfj28FYharncFudtmzBUUJ3uRod3
	+t+D/MW2qPXvkvZ5QyTTfVFMbFEbvM3D2iU+hjxMgOLoEw1CnrMioQQ==
X-Gm-Gg: ASbGnctqS5OmFrs/EUIBHqqHZ9K48SU9TscQR24/Mwp3s/r4T9YQmtw2VSlAgppQjKN
	9mLQda4AiokhfjAbw4LTH3YLySQRG+v77idjmX7IondLLQj053dibaryofvfQ6rIpsy5bK+r3ry
	9CB5dBYN8DLxuVKZxXap3/gXpG2NnRnehCX1kQgU7Hk1ViF1iUCrhs84Ew1fY6gpBuV497T5bvP
	Lo+RCoSfj5ldjmUk9qtoteaLef725KOxZVFA4IBIUJjRxnXQnYkD5Rm1EBa7iWhDNGqaNXXXXY7
	xLU=
X-Received: by 2002:a05:6214:c2a:b0:6e6:65a6:79a4 with SMTP id 6a1803df08f44-6f4d1f9e216mr223336d6.44.1745598424277;
        Fri, 25 Apr 2025 09:27:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrsTAOZevjGCechpgS5uQE6KpTPiMl2lEp9QFsRSucLuWkkusPkRPE26kdYaQ3TBFsbWONiw==
X-Received: by 2002:a05:6214:c2a:b0:6e6:65a6:79a4 with SMTP id 6a1803df08f44-6f4d1f9e216mr222976d6.44.1745598423934;
        Fri, 25 Apr 2025 09:27:03 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c08ef0cdsm23874656d6.18.2025.04.25.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:27:03 -0700 (PDT)
Date: Fri, 25 Apr 2025 12:27:00 -0400
From: Peter Xu <peterx@redhat.com>
To: James Houghton <jthoughton@google.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-stable <stable@vger.kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/2] mm/userfaultfd: Fix uninitialized output field for
 -EAGAIN race
Message-ID: <aAu31E7CSbhw6Yh9@x1.local>
References: <20250424215729.194656-1-peterx@redhat.com>
 <20250424215729.194656-2-peterx@redhat.com>
 <23e2d207-58ac-49d3-b93e-4105a0624f9d@redhat.com>
 <CADrL8HVhMhG6_nSwLfVr4g8XpjA9xh+maLPrC1=jv+L6LNxxkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HVhMhG6_nSwLfVr4g8XpjA9xh+maLPrC1=jv+L6LNxxkA@mail.gmail.com>

On Fri, Apr 25, 2025 at 11:54:47AM -0400, James Houghton wrote:
> On Fri, Apr 25, 2025 at 11:12 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 24.04.25 23:57, Peter Xu wrote:
> > > While discussing some userfaultfd relevant issues recently, Andrea noticed
> > > a potential ABI breakage with -EAGAIN on almost all userfaultfd ioctl()s.
> >
> > I guess we talk about e.g., "man UFFDIO_COPY" documentation:
> >
> > "The copy field is used by the kernel to return the number of bytes that
> > was actually copied,  or an  error  (a  negated errno-style value).  The
> > copy field is output-only; it is not read by the UFFDIO_COPY operation."
> >
> > I assume -EINVAL/-ESRCH/-EFAULT are excluded from that rule, because
> > there is no sense in user-space trying again on these errors either way.
> > Well, there are cases where we would store -EFAULT, when we receive it
> > from mfill_atomic_copy().
> >
> > So if we store -EAGAIN to copy.copy it says "we didn't copy anything".
> > (probably just storing 0 would have been better, but I am sure there was
> > a reason to indicate negative errors in addition to returning an error)
> 
> IMHO, it makes more sense to store 0 than -EAGAIN (at least it will
> mean that my userspace[1] won't break).
> 
> Userspace will need to know from where to restart the ioctl, and if we
> put -EAGAIN in `mapped`/`copy`/etc., userspace will need to know that
> -EAGAIN actually means 0 anyway.

Yes agreed, the API might be easier to follow if the kernel will only
update >=0 values to copy.copy and only if -EAGAIN is returned, so that
errno will be the only source of truth on the type of error that userapp
must check first. For now, we may need to stick with the current API.

-- 
Peter Xu


