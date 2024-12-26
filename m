Return-Path: <stable+bounces-106179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802749FCF23
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 00:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AC53A039A
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669D11C3F1C;
	Thu, 26 Dec 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMTWVS0l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278314A0A3;
	Thu, 26 Dec 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735255870; cv=none; b=Yb68gEjSFyC6mvgrD++TLcVs2YhNZq3R5sYdE8AiTJPqQEcqoJ0QjCe76quUbqAckeSwb3mR+hjocXIZe71iPPHgTldQ5hMKm93UpmQNoG3pwYu0B0OyvBPnCTZG4w0rAUfAnmDLFmwcCUQLdjic3jnDH9p0dfUtnjUuBWy2q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735255870; c=relaxed/simple;
	bh=FeK1Mls2SIsS7vrOJ+4ipEz/GICQEV63ehcLAVorveU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1VzHF4f2a1Jmx8Z2Of0f8MhrDhSnZzt5iZpgNAJp1tkggD9BA/5FIj5wjo1tBhdEy/Uy2Hgcu1wLcfvDFu9hDN0wuGeVz9xiBGxr06zERoAGqsJulVeoDQa35aBvUitBU84yB1XVn14dXmnxjZ3suIq36ObhwoGRqzayD4t8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMTWVS0l; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efded08c79so6353553a91.0;
        Thu, 26 Dec 2024 15:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735255866; x=1735860666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kLv3i0F8oV6VEkHswooSetE7hPOYGpCT7QiQv9dslCc=;
        b=GMTWVS0lLNe/+IAyYUuE6TyXUEXp56Yx2uxHhbGFw112Koo1eMNqvdj+r4YWLHk77Y
         vlMzZKCmOUlbWSl6wxIHm7Et3GYAs/32DXrmc5btasWaVzE2wQqphYFZvxXu5qz2TikX
         eLQtcW4JUnVbGcqYIQrsRzPJdW4CTKomPorJTDm5+p+GlWyRt1NH3qDjwjxMEGfOMvSY
         w2F4HVCLAWKO/SZ3X2p8RbD0fW42HU6B48bjP1y0keN6Lj3nu91thoGCD/lgHWndb4Q6
         c8Ojn+OzVV8uJv3oC26DD7NVIe97uE8OMfB86YycrFWXL72XFrfuOrxrXVy+xLmmGwZw
         augw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735255866; x=1735860666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLv3i0F8oV6VEkHswooSetE7hPOYGpCT7QiQv9dslCc=;
        b=UYj3YTIf++DPnT/HnEfDltq8R084NPbJX1bBh4wbykhKgzA97RfAKAz/ddcyptK+4D
         Scgkj5ROAbI3HPAzFSGRjIl6sBgPQwNezhT27V3LsVT/xwXwrnEpXd8+CAVQhPLc7ibi
         L+H1D6mOySA53SNaXDPJ0eUn9unVFcwVLJa+WjebIlZnxf0dbGH+j9sFCveFXdoFfuFF
         j63FCQcGLBMBUYKGGmu43Vob5TFP1sFXq/6TRZjs7xovaa0OhZgpVk0YHbJ5lC95zk/6
         eEkbiAsbyQqC/vsKwfoabLeqB/kSn3jCY56dCpWEITGKw7wM3vJMwVGYFjQp7+qiqwAl
         Y22w==
X-Forwarded-Encrypted: i=1; AJvYcCW+VJcQEP/IODUipkm473+4r1QPDK/t7nTqtqVjHmoE3p8EHXp/EtB7++FuY/yY9513YlDS7RbTsKGf8Po=@vger.kernel.org, AJvYcCXabJR3BDyDdTW3ZMmH837FUKNGPKXqmne/igVbeZYMrWz+cxQZuPqIOzmbZl7Hm31qG6zPROKM@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGU2iDirqd0TLD7ZsYW/93hGgWxBu3Kjcv/OHCCfg6vRgJpNI
	3i6M4bVqA/WlzD9JQcBHs+5LU3ibh5uMEHhWiTrKen5RKoQM9cju
X-Gm-Gg: ASbGncsxI5WYSkyK//EHrmj+d7nNoNxEGFJvMOIAzWi4YFhuowu1ksuSU/jBXIs4LxQ
	jB+UdVRcoDikqPw9EMduEqHhWCnduNdUV2kp6+R6iJ0/lg6/sj0gOAQk3C3XOLwBgxOnykFt3dq
	arnrrNVg8YhM74sjcbZpTO9YbaEJEkPiqcbgRo7ihG8b2sE21PPwze96r4K9JwKnuBgxrOO10KF
	zO0RgnCyYDls0OeZBXZhRws+zE/8l3ISzPdKaCyport//wKSHZ34DVsTLDv5jsKO9cYF7jjL4Cc
	+JhO0MS0
X-Google-Smtp-Source: AGHT+IGcbbx1BsmDb8Eeab5wdwR6nnFwd35Vwa57Ne8234uX+CyUDrJi1Oe+VxHagZLNZAZ+8U4whw==
X-Received: by 2002:a17:90b:4c0a:b0:2ee:f22a:61dd with SMTP id 98e67ed59e1d1-2f452ee08e5mr34270717a91.32.1735255866183;
        Thu, 26 Dec 2024 15:31:06 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447883b0csm16060410a91.42.2024.12.26.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 15:31:05 -0800 (PST)
Date: Fri, 27 Dec 2024 07:31:01 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: peterz@infradead.org, shile.zhang@linux.alibaba.com, mingo@kernel.org,
	rostedt@goodmis.org, jpoimboe@kernel.org, jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] scripts/sorttable: Fix orc_sort_cmp() to maintain
 symmetry and transitivity
Message-ID: <Z23nNV+zM101SltV@visitorckw-System-Product-Name>
References: <20241226140332.2670689-1-visitorckw@gmail.com>
 <20241226133738.36561a6b556550a3f50fc5b3@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226133738.36561a6b556550a3f50fc5b3@linux-foundation.org>

Hi Andrew,

On Thu, Dec 26, 2024 at 01:37:38PM -0800, Andrew Morton wrote:
> On Thu, 26 Dec 2024 22:03:32 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> > The orc_sort_cmp() function, used with qsort(), previously violated the
> > symmetry and transitivity rules required by the C standard.
> > Specifically, when both entries are ORC_TYPE_UNDEFINED, it could result
> > in both a < b and b < a, which breaks the required symmetry and
> > transitivity. This can lead to undefined behavior and incorrect sorting
> > results, potentially causing memory corruption in glibc
> > implementations [1].
> > 
> > Symmetry: If x < y, then y > x.
> > Transitivity: If x < y and y < z, then x < z.
> > 
> > Fix the comparison logic to return 0 when both entries are
> > ORC_TYPE_UNDEFINED, ensuring compliance with qsort() requirements.
> > 
> > Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> > Fixes: 57fa18994285 ("scripts/sorttable: Implement build-time ORC unwind table sorting")
> > Fixes: fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in two")
> 
> Two Fixes:, years apart.  This is problematic for stable tree
> maintainers - what do they do if their kernel has one of the above
> commits but not the other?
>
TL;DR:
Any kernel containing either of the two commits requires a fix.

> Can we please clarify this?  Which kernel version(s) need the fix?
> 
The issue originally appeared in commit 57fa18994285
("scripts/sorttable: Implement build-time ORC unwind table sorting"),
where the comparison function was:

    return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;

It was later updated in commit fb799447ae29 ("x86,objtool: Split
UNWIND_HINT_EMPTY in two") to:

    return orc_a->type == ORC_TYPE_UNDEFINED ? -1 : 1;

Both commits introduce the need for a fix, as the comparison logic in
both cases violates symmetry and transitivity.

> Or perhaps this should have been presented as two separate patches.
> 
For 6.1.y and earlier kernels, applying this patch directly is likely
to cause conflicts. A separate patch tailored to those versions will be
required. Please correct me if I'm mistaken, but my understanding is
that after this patch lands in Linus' tree, I should submit additional
patches for 6.1 and earlier versions to the stable mailing list with
the appropriate subject prefix.

Regards,
Kuan-Wei

