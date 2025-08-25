Return-Path: <stable+bounces-172878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD8B34967
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 19:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1087B1A807B7
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE4305E29;
	Mon, 25 Aug 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajEUK1Ti"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568E3019CD;
	Mon, 25 Aug 2025 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144496; cv=none; b=FEKOOQVcESG4yPUaFQHi1iKxxN0TcEMIgc0aiodfynbUWqN/P8PsuWXOfHoilMqZ3W4d66mgV6VeNphHFIJMllRGVPuWOqYcb09883r+6Gax56dLqcsx1tf0d3xMyRAr8+xyl4YTuqdqybDxWy/tK06ghM4uQayypt5eZsxDj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144496; c=relaxed/simple;
	bh=Jo0jztRLJE2KbbyR4ObT+rd1uD7ix0PGgyGFcQ8Xtmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjbHVIYomX9xVAOahahH2O2av7LEJNdigWxkveI2fqrtKl4je+oMbyXjwtx2k+iGp/7d53DxQeTiBrr3qJkBV8L8EnEUmDoWSNwJws2atB46XPpvzY8HR/5bLgSsRs/wg/zD9qTJEvaungZRH7TCJApqqmxB70SmovXsLZ4bZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajEUK1Ti; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47174aec0eso3046358a12.2;
        Mon, 25 Aug 2025 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756144494; x=1756749294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PALG1f/QrrclDqeCnjMHSh9ak08P++xF1J9dcSjVu/Q=;
        b=ajEUK1TiWYalIXLmifonDfcDzINhzTWK6j3sIQ0z6IEu/RNolmr9C+gfHPkTMT9Ns6
         nH8cpVsiQMXgjTGvdMVoKDI4Z/t6yYwWjYf5yAvnUG5rif69skJbggekyDZ0lvSlErOA
         /+76tpPWVwJ73Fr6dXJAWhFzjItumIxpcFjvV9riRK629INu9Y5qfqarCwojG1Fhrb1I
         AknARJrZLm/dgPu4zDF0BmyV2JA+8bGqDFFGFAdLu5Fi8sfbbff/SN2j7bm4BE87hSNL
         HgFkueOwyy/o1ZoIOR6OmtCO+myj8erXnt9HZvMro9flIMXdQ3BVg4gVm8Hfa4uGA9Qi
         kFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144494; x=1756749294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PALG1f/QrrclDqeCnjMHSh9ak08P++xF1J9dcSjVu/Q=;
        b=edCiMbjRvN/MzAtVW07w+VYo8TrZUEUg1txZvuG5x8+MKYeK2YrHMSN/Q4ZiIRKQpx
         zQsIsnXHygwgNyQpH4b0np6EPhvwdBL41APRR7ZM88h7SWLyNsI4H29O2UZZfhBUPFRa
         LM/QSZevL2ui9paFTg+jI4rqWo/vW8I28ZleftfQuJ8caTAA2SNO2xszEDOEaKp496qv
         OG9AVv+G88MXMq9PMVCGIuLoWLhizoKXNDcHnHzgfl7Djpge6k+p1ymQ63uKAh3g3vQt
         rNdX3h48iCgqWXo1Hz3EPSqdfysSnw1V74DtsNbW3A0rOJXY/EoLKjZs7mbcXACVXsfW
         0zpg==
X-Forwarded-Encrypted: i=1; AJvYcCVIBRb0GVqP27Vhb8U1wLzJYTpYrJJ29UOrqYkO43iZ1hvbj6yQU3Mv3W8XxKRU8JhU58BsHHvltLJDiXA=@vger.kernel.org, AJvYcCXpq9RVZh6scfGuIlnGoLcUB6YDZlhTJ3s7bEO3azcm0DyWbUSbJKBDWAZJlSUaT4W0L7Nb2kDc@vger.kernel.org
X-Gm-Message-State: AOJu0YwwoW8QGMXhIJ04LPb8Ltzopd7U1ZKaa+ZqnfSrnHntCNnD8fMe
	nJP6qGUWe3P1X4RKeGRHgacyge1AkteAcSGPiPd9u+kBw6yyDCerl+uT8Cncv2mn
X-Gm-Gg: ASbGncsCZzWzmer8Q7UYf/Yjt0nDq1OcwZ5cLukqHKZ7+Pt2XuvlLOSPDZHRXwniWWH
	kblYMgvBRjGTyYGAnpVD1XGdbYBcgW7QHTwgo4V8Bl+8hJm3vOIYl60P2u2KXaZVkRq4OzGV/h1
	CjvIeZ4p40PGv7WFwD/+E4qc3426Cs8BAlkyq95zrufuLDlif6rvMIglqaF2ZyFQZTLB+wyMNgm
	mpdiA45EFVxlpjlfpR/ZrOVm56QfSqXWMhNUw4bCQjK6/baA6EpuSLuS1Rf8PfyKSXgWvG6ZAzD
	S3h5TPGJo/SQpxTVnyO2c37suRkdJA9qzInUBTjmms2Ds8lPTaOP7ntMinoW3JqCOm3k9V2NReo
	8oIXKyQrHcVlVt9FNKLkXBd54nOdn1av1NFE5dkYfsRa/g8I70AvvK6iQ53Fc
X-Google-Smtp-Source: AGHT+IHqyWefoCtbS0gX6KgX4uuDcl9YGbvjxjelXwm8qZs/hpL1be/XcwM8tdZuLvSL5dxbQ4v1JQ==
X-Received: by 2002:a17:902:ef01:b0:240:52c8:2552 with SMTP id d9443c01a7336-2462ef6f40dmr182941865ad.43.1756144493845;
        Mon, 25 Aug 2025 10:54:53 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885efc8sm73686345ad.90.2025.08.25.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:54:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 01:54:49 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com,
	roman.gushchin@linux.dev, harry.yoo@oracle.com, glittao@gmail.com,
	jserv@ccns.ncku.edu.tw, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when
 counts are equal
Message-ID: <aKyjaTUneWQgwsV5@visitorckw-System-Product-Name>
References: <20250825013419.240278-1-visitorckw@gmail.com>
 <20250825013419.240278-2-visitorckw@gmail.com>
 <eb2fa38c-d963-4466-8702-e7017557e718@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb2fa38c-d963-4466-8702-e7017557e718@suse.cz>

Hi Vlastimil,

On Mon, Aug 25, 2025 at 07:28:17PM +0200, Vlastimil Babka wrote:
> On 8/25/25 03:34, Kuan-Wei Chiu wrote:
> > The comparison function cmp_loc_by_count() used for sorting stack trace
> > locations in debugfs currently returns -1 if a->count > b->count and 1
> > otherwise. This breaks the antisymmetry property required by sort(),
> > because when two counts are equal, both cmp(a, b) and cmp(b, a) return
> > 1.
> 
> Good catch.
> 
> > This can lead to undefined or incorrect ordering results. Fix it by
> 
> Wonder if it can really affect anything in practice other than swapping
> needlessly some records with an equal count?
> 
It could result in some elements being incorrectly ordered, similar to
what happened before in ACPI causing issues with s2idle [1][2]. But in
this case, the worst impact is just the display order not matching the
count, so it's not too critical.

[1]: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com/
[2]: https://lore.kernel.org/lkml/20240701205639.117194-1-visitorckw@gmail.com/

> > explicitly returning 0 when the counts are equal, ensuring that the
> > comparison function follows the expected mathematical properties.
> 
> Agreed with the cmp_int() suggestion for a v2.
> 
I'll make that change in v2.

> > Fixes: 553c0369b3e1 ("mm/slub: sort debugfs output by frequency of stack traces")
> > Cc: stable@vger.kernel.org
> 
> I don't think it can cause any serious bugs so Cc: stable is unnecessary.
> 
I'll drop it in v2.

Regards,
Kuan-Wei

> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Thanks!
> 
> > ---
> >  mm/slub.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 30003763d224..c91b3744adbc 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -7718,8 +7718,9 @@ static int cmp_loc_by_count(const void *a, const void *b, const void *data)
> >  
> >  	if (loc1->count > loc2->count)
> >  		return -1;
> > -	else
> > +	if (loc1->count < loc2->count)
> >  		return 1;
> > +	return 0;
> >  }
> >  
> >  static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
> 

