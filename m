Return-Path: <stable+bounces-131762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68045A80CC1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0047B189E9C1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A404185935;
	Tue,  8 Apr 2025 13:40:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAC84D13;
	Tue,  8 Apr 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119649; cv=none; b=CfjOTf0Iep5b0QHOiC66MixHZCOky3/9aIhc/ZrQIQ7DkuoSpGgRMT7+6THGlGLL+GThih3FV0F9IyMHXQEKDA858ZFfaSz9AMcOCYMx61KKhqLsJNeN8+xS4LC3hNuXz6rajVWVWkTnucVJGsru9abW2Cp/8wNGVYCDdYK4KXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119649; c=relaxed/simple;
	bh=E/1CzfaIaTfWHWtXucnbLS715xlC08uJliaTiB34jJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPg0+IHMnE2N4IH8BxTOolsfxPN6JzF0xrgkIr1SilMjw66pd8RenlHgz71lpkmxfKs7Q8FmgxIICDeqzP/AABKQZDkafdJK7l2N0Iz3v1QCqFwYk+u5jBL+jeDU9clO0Q1fFu24P5FMTbQrgVcGZtwi0/ZiQut0pkFHrpVEQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so8462347a12.2;
        Tue, 08 Apr 2025 06:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744119646; x=1744724446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKKzeLEJKtPh7DQtoUcyzgMud917LdiI3JYFAFi05B4=;
        b=fyVYIVbMfP3hC9875mF+HgOuLlxqYL8e169IatyS4pk1zY8ih3JjXljq4VffxtAP9M
         ojR286n3yhfZhJsYnXYkL6iLgglKU2TDB6oPGzfGr67BTZx79UxTrW/wpkNESrYCVw9d
         0dsz2+nfeVuVPhyAtMBMpe+mIIGidSCsWqeL2IfjM+nSZqJbSmyCgVexOzfWjNAvVE1i
         Bjoc7HhWIWY4iIxckXnhVhj7elB7WqfyknzPPRl5lasD7TqNkjaahFk3TYWTxsefZScy
         qQW67r9li7io4/d1a/iR4Dv/g0c1EIIrh+RxdOIBjE+BYr5tAHKMm+git9b/QltA4leL
         oOYw==
X-Forwarded-Encrypted: i=1; AJvYcCVE7EYfunbUeZgs6gdzbCRsnPnI+q9XDXX+Bhn19jRGtAWkT7PNvqE7F96a++r6ZlEExcnaURR+@vger.kernel.org, AJvYcCW/DrAjU1fDLyuVJDiywFcvYMkvwgdAR6+Q7n+WYqmlg3ZJiongXHOkW3adGBjiii3v4FvwGFuELs91GbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRnTybM5Esa1BKtRUAGWSZa0VoLjLX+1JwdFnPBI3bhPHzNJYF
	BcNRfohnAN+Ojdfn47KVgmVBxQrNOhqvnh5VVq2dowjYDOedE81X
X-Gm-Gg: ASbGncskjo69MIMqsV/3RnIAsj5+DJFLIc9Nx+yMGFppJO/WjVRU5VGsGTsWgH7Pb77
	TvWnPoCiEkhBuyZyKnR1ci/5QKd0fCFX70VjNreqdrIbU1cnS7f/qS0WAJ8M69+aZZMdnQ6KJjW
	+evhqS+Ax6Rog+2yx8y4Bmo0eYGKIdPkoaKlDKlZZaJiZW6JDCDcG1HEV8h0qhvFNGy59Sh2wHQ
	XBUrNy0lFLNtUmMG7aJQyByXWWIDTwszTWkkKhXZB7OZme4iwPrdTeW0pCwTDjsm0+msbLLnsKp
	evwCt9RlYYD1nu8kefCR7F6yEcMwRqmhcKI=
X-Google-Smtp-Source: AGHT+IHYqBqa8m3BSGokig3RFZCUAeA2NY23MTv4GB6+nbzTFSj5E7ZylesIHXbOL9RPJenMhxu9Bw==
X-Received: by 2002:a05:6402:50c8:b0:5ed:1d7d:f326 with SMTP id 4fb4d7f45d1cf-5f0b5ebb731mr12888344a12.10.1744119645580;
        Tue, 08 Apr 2025 06:40:45 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088085983sm8240556a12.64.2025.04.08.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:40:45 -0700 (PDT)
Date: Tue, 8 Apr 2025 06:40:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
	kernel-team@meta.com, stable@vger.kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] sched_ext: Use kvzalloc for large exit_dump allocation
Message-ID: <Z/UnWnvmUVy8jilG@gmail.com>
References: <20250408-scx-v2-1-1979fc040903@debian.org>
 <Z_UI2AHtkIGS4bZR@gpd3>
 <Z/UTzPoI7+LElhEE@gmail.com>
 <Z_Ugy6NDFBscP9Ef@gpd3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_Ugy6NDFBscP9Ef@gpd3>

On Tue, Apr 08, 2025 at 03:12:43PM +0200, Andrea Righi wrote:
> On Tue, Apr 08, 2025 at 05:17:16AM -0700, Breno Leitao wrote:
> > Hello Andrea,
> > 
> > On Tue, Apr 08, 2025 at 01:30:32PM +0200, Andrea Righi wrote:
> > > Hi Breno,
> > > 
> > > I already acked even the buggy version, so this one looks good. :)
> > > 
> > > On Tue, Apr 08, 2025 at 04:09:02AM -0700, Breno Leitao wrote:
> > > > Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> > > > can require large contiguous memory (up to order=9) depending on the
> > > 
> > > BTW, from where this order=9 is coming from? exit_dump_len is 32K by
> > > default, but a BPF scheduler can arbitrarily set it to any value via
> > > ops->exit_dump_len, so it could be even bigger than an order 9 allocation.
> > 
> > You are absolutely correct, this allocation could be of any size.
> > 
> > I've got this problem because I was monitoring the Meta fleet, and saw
> > a bunch of allocation failures and decided to investigate. In this case
> > specifically, the users were using order=9 (512 pages), but, again, this
> > could be even bigger.
> 
> I see, makes sense. Maybe we can rephrase this part to not mention the
> order=9 allocation and avoid potential confusion.

Sure! I will send a v3 later today, then.

