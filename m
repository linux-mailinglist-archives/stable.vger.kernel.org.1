Return-Path: <stable+bounces-130784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE279A805BF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9FE47AC7FE
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A1269CEB;
	Tue,  8 Apr 2025 12:17:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A5263F4D;
	Tue,  8 Apr 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114643; cv=none; b=ia0fxTyylg/7nLIFHl4fHR3HsS1FToHFP1RIguM3ZPRO98aj4SD9r87FtyfjrnJ/nF9W/mRRizUSd6y9vppgcYa8O1c840GRHCmwgOVYwZjG1ZNMCySxd4wdZSKUyDEaO5NOd/cC4H20Qq9Q0Y24xxLA6k3ctkCkxJzom/7q4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114643; c=relaxed/simple;
	bh=U6p8SdK5Of739muSFYwDwMYUjP02LQgT2LP4ul25gsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUIQ8t15H4bokz9MGwDefp2YjrshwS1DgbGzSFmN8dqmqtuoSMOOd9To5A/6NyF5an8LRPsPg0fbslsCdEFP46vuwT071/Q7rKsYXoU/BP1ymaBENrXKmfsqU3/D7xVdcXy+uymwCEX639vb2GuCLWRenny3cdccugwiaRWY5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so10178635a12.1;
        Tue, 08 Apr 2025 05:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744114640; x=1744719440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNsydl7md1y4Nb0tCrKFrlIHVPhyzWyrPJ9rFWgBSaE=;
        b=e4RHmaWGBdZId53y+mEfR3ubkZ25SXI5ZkOxfRBPTgsQA/bXpC4ouMCBJftHZ451tg
         fCMfy3Td0FievRSKZV3PYXphJ5OHxWZyJ9GgTlpipJKXPCsY8ZTYgVq5guflQbnq3G02
         orFG067hwTNpXp8dtEIw+ILedm21SUzFyMyCEhFly1DZjXlRW4ZfPw4SA3KDg/aEWHQi
         2jIe5JROlX+Ou+rv1M3pebGnHrcSKPO+CjPF0UBMAAHwnzZ+5T1VHQH1eyBRqUQWRSwE
         nPu2paJY/BTbTVVECVoFqh+LrGuQaVziUG4lByWeQsZhs2dRSO7TCNbjXv74EBqEF5wX
         Rx8A==
X-Forwarded-Encrypted: i=1; AJvYcCUqv26s8u/zgF+nIONXNFY1ga3j78Klpnkm2NFjEvpDi8qqiegQrU76FaD8qL16stWr7WLTuAnBDe5z/vs=@vger.kernel.org, AJvYcCVgdaPCNv/z6UnIoEiDqKjrHRaXdoj40Eja6vRuVHot5mt+FoV/ryHEGdnQkUvYK97w2cFhQhWh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9tAwTvhlhGfMovml99Ka1i5J+RVIfOorB9R7muixZt6nMWq3
	3I/70XYn8OdcjX1qSTvgu+tLh2X9tK5FpTQzT1pwMsGY9c8mbAUU
X-Gm-Gg: ASbGncteiJNQoEmnGfcw34zaKbWZlgJafn8av/3LoOSk+yYOYs7fioPJv6WV+7b+ibR
	tMbReOMUaTo9bJijDhZkGYuzf+00pRskGvtXC8OJ4ADu+L5gERhLQQLht70GPkNzWbDrr8l3NHq
	MIIIU/jW1RuvRXLu6+QpJlK/XifWX+WkNJSmCACUBL7VmML8QkZW/rqWr25nWyX6pOcOrIhFZZq
	nu0BPB/W14yj78nZtCUgRsOJu26WV8qH6K0jUCE5ZO1XAijP5V1pUX6TSwsrZej4L04Z4hpb7Pg
	rDIyEruqnAY/g89QEM2WBqtkPGUdugMUVAxd
X-Google-Smtp-Source: AGHT+IF2XGoy9tYFECepepWqPifMJJJeJD1I4oP3E7mGhMUrh8bLpbtZafML/bqsSoyCkRsrJnRzSA==
X-Received: by 2002:a05:6402:13d3:b0:5e6:e68c:9d66 with SMTP id 4fb4d7f45d1cf-5f0b5db9cd7mr14121997a12.8.1744114640012;
        Tue, 08 Apr 2025 05:17:20 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087f0a0f3sm8454077a12.43.2025.04.08.05.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 05:17:19 -0700 (PDT)
Date: Tue, 8 Apr 2025 05:17:16 -0700
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
Message-ID: <Z/UTzPoI7+LElhEE@gmail.com>
References: <20250408-scx-v2-1-1979fc040903@debian.org>
 <Z_UI2AHtkIGS4bZR@gpd3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_UI2AHtkIGS4bZR@gpd3>

Hello Andrea,

On Tue, Apr 08, 2025 at 01:30:32PM +0200, Andrea Righi wrote:
> Hi Breno,
> 
> I already acked even the buggy version, so this one looks good. :)
> 
> On Tue, Apr 08, 2025 at 04:09:02AM -0700, Breno Leitao wrote:
> > Replace kzalloc with kvzalloc for the exit_dump buffer allocation, which
> > can require large contiguous memory (up to order=9) depending on the
> 
> BTW, from where this order=9 is coming from? exit_dump_len is 32K by
> default, but a BPF scheduler can arbitrarily set it to any value via
> ops->exit_dump_len, so it could be even bigger than an order 9 allocation.

You are absolutely correct, this allocation could be of any size.

I've got this problem because I was monitoring the Meta fleet, and saw
a bunch of allocation failures and decided to investigate. In this case
specifically, the users were using order=9 (512 pages), but, again, this
could be even bigger.

Thanks for the review,
--breno

