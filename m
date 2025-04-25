Return-Path: <stable+bounces-136675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DACA9C2CB
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC44C2AC0
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E1230BD8;
	Fri, 25 Apr 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PJDrg37I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9822A800
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571738; cv=none; b=YbZLvBS8lm9CBRfwl0ICYNNog6DChninnOtDbPpBcXgRuSNqjcLSzHVktb14H9i/o3GoZ60OOu1QfBMQBK6kKAm+qe+4zy1nSTU2PHkMltg0n8OzzC7cnySkfEqSS0DWC+EEV58bF5cs1SSu5OvF4lvvlxz6g87YCSuHl/BsdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571738; c=relaxed/simple;
	bh=cigjLGVrA/i3iKo0ZUO3ckDz+7QoGQ7Izg/Jz2mNid8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6kRBeNfsuzXPmgoKY2G9yQFsJQqr+cyUM+xwPIsA57X2qe4gbNbJDzsa9qbqsAg9+wtR8vt4eXRH1YEbDy8Oi0gYEUFeh+emQ5Xo8lMsOCPD6+DpkozlBFbBd9fWsJDtvSGGdeWHvj/T0AokXfLa2xjm7vT7X8hKjpUoH7irpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PJDrg37I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso1112243f8f.2
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 02:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745571734; x=1746176534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUtCax9Xz79pqocOKSO+PWNehk8nJoFSaWWNyZR+sqk=;
        b=PJDrg37ILkoHM0ANI0DtAkyi22HhLrHmRsQ1VyWmcUofSoVWr0ITZheUjp1G3rpFS2
         Cl8ieJIdiRaTgQCbkVDYym7kB9xoc+LOeJFK38uYr4j5tDWKNLcgK185TSV17ujU73rU
         z9Zv1UaE754RO2I9g33UsVZZ3WIk6rDGclbz7jt86Sruxq7uWj4H+qWPgv0XEG92frNz
         JvfIxmeglBUBchdhZ++45OSeL/iqdatSdIzjZBW/AxPSaANrbzRkJnPS9A2RUqReBMYg
         BCBMrm2PZw8en8NpXKlQM2eg8nBA57AWtdBGkOQ3Pk0j6qm/BKyrAW17bvn+9NUgxdfL
         KY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571734; x=1746176534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUtCax9Xz79pqocOKSO+PWNehk8nJoFSaWWNyZR+sqk=;
        b=t5XaWhcCDI1BtjQN76vKJimff09pu50xr6CgxIz0+xGaNS6v5LaArh9s3FJHrgziPC
         Id48BtU1WtwDDqcZYzOQXc06ym7U6yxdKIz1SRMD/2ZCBJnZM+INkKct67nyPE+LUeRX
         ibHa4VPTYvfZtb2+ztHRLChP1O/P5f6smQdh24oWg2ejF4Pt41UZlYDlFzoQIFJvbF1p
         Rc+XuFZSlp7TTVgfjB86kkEzOkVQdUqkJloDc/YrdV2Zl+5XpG7QaxJFPOUqwe3Z/WEP
         sHmsQFJnXCvLMc2KjMiJMvfgkhqdAJXl5GCzIg1zY5It7APgw6SGeEIX3rMncUnGAxvO
         3jOA==
X-Forwarded-Encrypted: i=1; AJvYcCW3pr8yMmU9MmCfivfszrLfdJSHE30VGJcQSZqgkLV5FSFa8xk1MupqKf5dAwz+SfqtcjVD98o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ki6JbIv4DoS9qHwJ6Jt0TqyPPNkdy5rpA3x3QNUQMmtuuBQU
	pUKgUgrHEo0wBZLjzgIgcHb6rrZ9X1C/kHBaJ3Xsuhh0x6cXbD+JQJQ+Q7plvD0=
X-Gm-Gg: ASbGncsc7Aw9dBCl6CfT63X2H0KXR8FfO9f52HFcTMsimUCXUleX6BjQ5UozU4I6LjJ
	14l6Zdq9EYis/t1sMUCujcQBWhG8LqNfpqpdich2B7otM0zGPLyci5rPGlKxX717gc7vFYNQQB5
	5cMuV5BQKvszgKa4avK+LnnphtfIYRDHTwpULGJFWQyfh1bQJybGNKbiTpb9IZMUB6SXTlWti69
	2OydcAi3yLNUaPGtHYVMKixnwKUtbCyxldZhfTgls5ezV4KUI/FFkX1pOIEpkpky0Vw+m2lkG7w
	YOF2fOW2MRHtczuPRRiciI/npZJElZa5IgavhR4vJZ8=
X-Google-Smtp-Source: AGHT+IHcaRb5pcjKTG+Y5h3Ih/yrwWqsjNfb1VbBSCFlmYmzhEmDkPcseYoWUd0DAhovc+dqSuA5vA==
X-Received: by 2002:a05:6000:2505:b0:391:412b:e23f with SMTP id ffacd0b85a97d-3a074e1a1bfmr1145277f8f.15.1745571733688;
        Fri, 25 Apr 2025 02:02:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073ca4f88sm1689934f8f.29.2025.04.25.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 02:02:13 -0700 (PDT)
Date: Fri, 25 Apr 2025 11:02:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Ryo Takakura <ryotkkr98@gmail.com>,
	alex@ghiti.fr, aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, jirislaby@kernel.org,
	john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, samuel.holland@sifive.com,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <aAtPk6vxmIBdp1NT@pathway.suse.cz>
References: <20250405043833.397020-1-ryotkkr98@gmail.com>
 <20250405044338.397237-1-ryotkkr98@gmail.com>
 <2025040553-video-declared-7d54@gregkh>
 <397723b7-9f04-4cb1-b718-2396ea9d1b91@suse.cz>
 <2025042202-compare-entrap-0089@gregkh>
 <a7cf9864-6810-43d8-a7f6-f71cc1ee081c@suse.cz>
 <2025042252-geology-causation-a455@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042252-geology-causation-a455@gregkh>

On Tue 2025-04-22 15:16:21, Greg KH wrote:
> On Tue, Apr 22, 2025 at 03:07:54PM +0200, Vlastimil Babka wrote:
> > On 4/22/25 12:50, Greg KH wrote:
> > > On Tue, Apr 22, 2025 at 12:20:42PM +0200, Vlastimil Babka wrote:
> > >> 
> > >> I admit it's surprising to see such a request as AFAIK it's normally done to
> > >> mix stable fixes and new features in the same series (especially when the
> > >> patches depend on each other), and ordering the fixes first and marking only
> > >> them as stable should be sufficient. We do that all the time in -mm. I
> > >> thought that stable works with stable marked commits primarily, not series?
> > > 
> > > Yes, but when picking which "branch" to apply a series to, what would
> > > you do if you have some "fix some bugs, then add some new features" in a
> > > single patch series?  The one to go to -final or the one for the next
> > > -rc1?
> > 
> > As a maintainer I could split it myself.
> 
> You must not have that many patches to review, remember, some of us get
> a few more than others ;)
> 
> > > I see a lot of bugfixes delayed until -rc1 because of this issue, and
> > > it's really not a good idea at all.
> > 
> > In my experience, most of the time these fixes are created because a dev:
> > 
> > - works on the code to implement the feature part
> > - while working at the code, spots an existing bug
> > - the bug can be old (Fixes: commit a number of releases ago)
> > - wants to be helpful so isolates the fix separately as an early patch of
> > the series and marks stable because the bug can be serious enough in theory
> > - at the same time there are no known reports of the bug being hit in the wild
> > 
> > In that case I don't see the urgency to fix it ASAP (unless it's e.g.
> > something obviously dangerously exploitable) so it might not be such a bad
> > idea just to put everything towards next rc1.
> 
> Yes, but then look at the huge number of "bugfixes" that land in -rc1.
> Is that ok or not?  I don't know...
>
> > This very thread seems to be a good example of the above. I see the later
> > version added a
> > Fixes: 45c054d0815b ("tty: serial: add driver for the SiFive UART")
> > which is a v5.2 commit.
> 
> Agreed, but delaying a known-fix for weeks/months feels bad to me.

I personally push rc1 regression fixes ASAP. But it has a cost.
I do extra careful review, testing, and still I am nervous of causing
a regression which might leak to a stable release.

IMHO, it is perfectly fine to delay fixes for bugs which
were there for months or years. For example, this patch fixes
a bug which has been in the driver since the beginning (2019).

I think that the root of the problem is in the view of the stable release
process. I am pretty conservative. My experience is that some problems
are caught only in the -rc phase when the kernel gets more testing.
I am not sure if stable -rc kernels get the same amount of testing.

Best Regards,
Petr

