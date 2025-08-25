Return-Path: <stable+bounces-172875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB3B346FE
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1F95E2E30
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867BF2FDC51;
	Mon, 25 Aug 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUvCdNYm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8132FA0CC;
	Mon, 25 Aug 2025 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138732; cv=none; b=Ctc/OjtF1wDVFqGhx1guqkcneG4LKGN3hSOYpesAYKiWROHywyVjismkgBdebJc4OrhCT2TadFbC5+fqu4+5LxhJL45sb0RqKwcikqlMPxEiD55NTdCTh3ZvoS1B2nAD4KIgFsri+hq69NgsysbER6Uegk/24Ih6/15+60Ei3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138732; c=relaxed/simple;
	bh=p/rAtQoQGdnv48fONoTfapUdPW4tCsDg7LF+H+IeD+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz/P926r2l76QJt9DRkPpk3QGb8btpLJHjHtK4n9/Cs1JpO8H1f4Usmh1mJ92kjS0/0ld7WorUhvM2DWgMzbcatJ8PEDV2vvLT5iDur3FJMHqQUD9omB3bCSK2kbm1cijfyrCyMTupIlF4DESwPu0Mu4uagQuFk2z7vAQMRf7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUvCdNYm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77053017462so1209272b3a.1;
        Mon, 25 Aug 2025 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756138730; x=1756743530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlupHTCaeWk9ty8cyG5BDMuBJjhBMKn4mUppCZ+fHyk=;
        b=gUvCdNYm11Iy2bN+yijLAUM1u2kSG32i+OSxww3eIDWs4JnYtThXDEZHz2LrQXagj0
         WCVn9kQJk0SI/gz3vFWaYyIejanPPRnBBoFzI22ZP7Z3XdEy8vUO01/EEuanjRRaQ1QT
         9j1JNu6JDgQjjg3+D4UosZhT0TmNQGU6LB7TNwAVKcMYmBsIDXu79GOBaInIeWPCF+40
         9X8SmX5kXC2VSgHMRBKq76dJwC89fd1lGpB2f7P0J1YaERE4HdE80Xc8xNA7JTSKOupu
         hhBQ1XkRJfB4FwtemLXDOE+V4lPwlp/MfqmhxYjMEy5MAFXpdnOjQmVXExbpb68IYsgz
         k0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138730; x=1756743530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlupHTCaeWk9ty8cyG5BDMuBJjhBMKn4mUppCZ+fHyk=;
        b=D6Rqp2XYe8Soswrlr1x3Ec6ASoaZ+GAy0tYbRY+QXTatw8JD9fKUUkn72up8fUfWpR
         cpK6LStnwiV4PamCVfjfJANr783OyLPpjaDZAeEykgttx9cK7yGN/9arUAdion/O+0SN
         gXlYW/+vKH7xsksFI+2CfEE4fofFYvpN5XCQOoZD8Lb6QoydDwoU0x8AUR2RHms4lGK8
         Cac/Z7gz7wR7AihPnmrAIPG7meAbxukoOy1SoXIHL49zzZpRIG4vOVwk6Fb/JZz8zN8g
         cGpYuT82zz8VpxMWu2iwlMR2oXLpV47ALsLA479fwnq4RdVbb8Wdk0SP6s01lkjMhmQP
         cpWg==
X-Forwarded-Encrypted: i=1; AJvYcCUVGgye5qszLRBDneWlHYFKhqr/0qGS6wJc+rAifV4Ray7Jw1na2OGxXTQe3hrGUMvaEOOBBTziAULkJSU=@vger.kernel.org, AJvYcCW2CtZ3KLBFiN0qBKFyuxNsK0iPS4xJi8G1HzEy7O31z3Y3a9zfW924fZ2uK7vSTEzE4zsIJBwJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxglqIkOm6FA9EVU6OFbhTNl6vD+Pdj7FzUzP2PFrusjGItpcUY
	1xPlsdiNWh7SUrMHi7w6Ki6mX53b/x8k5YCdlqUcJeQqohS2/HiyxHKGED4+Zmge
X-Gm-Gg: ASbGnctGWkO0mHK+IKMip0/K0I85Pjuf+yL5oBWpy0HipNoqaH2PiGssLCD6mV2LF5C
	BK5BIiYbWw4SoJq24seq/TEdet08lQykvNwmwSdioDlERc93P+ITGNPGvj1wrjCAl2orA4xkJgq
	HiOb29bdG+XGMffdsyEalRXuONo4c9plygYpW+8grHVw6ACHVJ+47GCtjaZX4lnSDfqMgPOZ8hE
	i1K1JUcpeVNKL54HFI7VrtB8U6t608NXnPM8WGN17KmR5ZQBBB2+NQTr/HJdwV4KW0WEc/QfEdT
	5HfWSe8fOsyjsxd9pnkv2/vqKWxWMKv2YF6H+KdlTZVvnP9MafsJXGmvzEdewQda1N1EM6rewtq
	Kf680EUY3yMP57gs2PF9s8a4RSWBluBG3ZQ0s8l8u79p4w4DboZxsyqV9XLIM
X-Google-Smtp-Source: AGHT+IFb7x0FHZfUPJ1wZ6JfXOrSOGAtixKMgVkVGQtPT4Ho/IegHATmPfyAfPSeEwyj7QoVspRwuQ==
X-Received: by 2002:a17:902:c94d:b0:235:ed02:288b with SMTP id d9443c01a7336-2462ef40318mr156684765ad.30.1756138729750;
        Mon, 25 Aug 2025 09:18:49 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f13esm72701465ad.148.2025.08.25.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:18:49 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:18:42 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
	glittao@gmail.com, jserv@ccns.ncku.edu.tw, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when
 counts are equal
Message-ID: <aKyM4jZqy8/G2DGq@visitorckw-System-Product-Name>
References: <20250825013419.240278-2-visitorckw@gmail.com>
 <20250825144838.4081382-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825144838.4081382-1-joshua.hahnjy@gmail.com>

Hi Joshua,

On Mon, Aug 25, 2025 at 07:48:36AM -0700, Joshua Hahn wrote:
> On Mon, 25 Aug 2025 09:34:18 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> 
> > The comparison function cmp_loc_by_count() used for sorting stack trace
> > locations in debugfs currently returns -1 if a->count > b->count and 1
> > otherwise. This breaks the antisymmetry property required by sort(),
> > because when two counts are equal, both cmp(a, b) and cmp(b, a) return
> > 1.
> > 
> > This can lead to undefined or incorrect ordering results. Fix it by
> > explicitly returning 0 when the counts are equal, ensuring that the
> > comparison function follows the expected mathematical properties.
> > 
> > Fixes: 553c0369b3e1 ("mm/slub: sort debugfs output by frequency of stack traces")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
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
> 
> Hello Kuan-Wei,
> 
> This is a great catch! I was thinking that in addition to separating out the
> == case, we can also simplify the behavior by just opting to use the
> cmp_int macro, which is defined in the <linux/sort.h> header, which is
> already included in mm/slub.c. For the description, we have:
> 
>  * Return: 1 if the left argument is greater than the right one; 0 if the
>  * arguments are equal; -1 if the left argument is less than the right one.
> 
> So in this case, we can replace the entire code block above with:
> 
> return cmp_int(loc2->count, loc1->count);
> 
> or
> 
> return -1 * cmp_int(loc1->count, loc2->count);
> 
> if you prefer to keep the position of loc1 and loc2. I guess we do lose
> some interpretability of what -1 and 1 would refer to here, but I think
> a comment should be able to take care of that.
> 
> Please let me know what you think. I hope you have a great day!
> Joshua

Thanks for the suggestion!
If we're going with the cmp_int() macro, I personally prefer
return cmp_int(loc2->count, loc1->count);
this avoids the need to explain the extra * (-1), and I think cmp_int()
is simple enough to be easily understood by readers.
That said, both options work fine for me.

Regards,
Kuan-Wei

