Return-Path: <stable+bounces-6836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771E814D73
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2311C237A6
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6613DBBF;
	Fri, 15 Dec 2023 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1KQ7BIL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1713DBB9
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d350dff621so6918825ad.1
        for <stable@vger.kernel.org>; Fri, 15 Dec 2023 08:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702658806; x=1703263606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEFbv48kStn7YQWxBmbzN7WZhe1SNeOtsv98Z9G0G2E=;
        b=g1KQ7BILH1e7Bt4tdBLaOLRId4khfBdWuA3zaThpOKkR9+te/YBEhE5kXCVef+Ytsq
         JMx7SZzIzvd3dZIV+yqRQRAiqPtyXrwswrzgQy9HCivrDaXSuOdiu+O6BJy7IfaRjYjk
         TQk4j12xtoyL7djhzba10mKDtdIcCgEDYP0JuVeqVt9sNkV1TSOzfP0K6/PU3Ze8GopM
         4tro19VxcsJySCWhfsDzFDCgmwb+kGyqjczbkxGSX7P1Cd818YoD76ZtMoyrsvkILO5k
         /KIBQlyAyaLV6XBPuGc4/UEZWpCq9csWxsAQc2W1QRS2Q89BhEu7Zuuhow+iE4vUeHcI
         kJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702658806; x=1703263606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEFbv48kStn7YQWxBmbzN7WZhe1SNeOtsv98Z9G0G2E=;
        b=jg7Ln7k7CQ1tDLvH2vRm+bVhRA0dkRuv6NJzbOinYhUWtc/+caSEh45hKQoOS8hIbB
         Y4kHq5+75lhFjDC1B7sAI2Nr75j9Ly9i3ATLSQV3HlmLccZhMKH6agLub9zMg/tvxvqq
         4KbJ6e6gjwbBAXeju7JYMFh7KQNTEfzshelWoBBozmj6pMyYpLz6MtNLmH5Ezb7Utv+5
         DawLJuafi+44x8t8NpuFiEyrUnEdzYwU7WoVFs7eGFI3riyXciwe8znRm+IAwygYgxnB
         NxEJLB8bBwTK0NFDoAYih/Xjhy24H75U+mrHX33SACU2UDZYrRHxklevAmv3LrM0IGoj
         2fNA==
X-Gm-Message-State: AOJu0YzbGXhUEy2OLmn8YfV8bUzMAvtvcucqW6MykCk7GRzSkRlWl7sR
	nebudz3T1kQBz2MJardSIEbwPw==
X-Google-Smtp-Source: AGHT+IFGjAkcJFnGpwwP2PRLjvwL8vWvSu6SbY4TnbFhmBE2lnAtBIQEWpv8HKBtkuHU0LyXY4gR7Q==
X-Received: by 2002:a17:902:8a88:b0:1d0:6ffd:9e24 with SMTP id p8-20020a1709028a8800b001d06ffd9e24mr10624156plo.118.1702658805910;
        Fri, 15 Dec 2023 08:46:45 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b001cf570b10dasm3248155plo.65.2023.12.15.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:46:45 -0800 (PST)
Date: Fri, 15 Dec 2023 16:46:42 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10 0/2] checkpatch: fix repeated word annoyance
Message-ID: <ZXyC8n13M2F9KC-0@google.com>
References: <20231214181505.2780546-1-cmllamas@google.com>
 <2023121442-cold-scraggly-f19b@gregkh>
 <ZXtLdyHSamRjH94u@google.com>
 <2023121506-cavity-snowstorm-c7a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121506-cavity-snowstorm-c7a3@gregkh>

On Fri, Dec 15, 2023 at 08:15:01AM +0100, Greg KH wrote:
> On Thu, Dec 14, 2023 at 06:37:43PM +0000, Carlos Llamas wrote:
> > On Thu, Dec 14, 2023 at 07:23:28PM +0100, Greg KH wrote:
> > > On Thu, Dec 14, 2023 at 06:15:02PM +0000, Carlos Llamas wrote:
> > > > The checkpatch.pl in v5.10.y still triggers lots of false positives for
> > > > REPEATED_WORD warnings, particularly for commit logs. Can we please
> > > > backport these two fixes?
> > > 
> > > Why is older versions of checkpatch being used?  Why not always use the
> > > latest version, much like perf is handled?
> > > 
> > > No new code should be written against older kernels, so who is using
> > > this old tool?
> > 
> > This is a minor annoyance when working directly with the v5.10 stable
> > tree and doing e.g ./scripts/checkpatch.pl -g HEAD. I suppose it makes
> > sense to always prefer the top-of-tree scripts. However, this could be
> > inconvenient for some scenarios were master needs to be pulled
> > separately.
> 
> It makes more sense to use the newer version of the tool, especially as
> you are probably having it review backports of newer patches, which
> obviously, should follow the newer checkpatch settings, not the older
> ones :)

Yes, that is the use-case we have. We'll switch to the latest version so
please ignore these patches then. Sorry for the noise.

--
Carlos Llamas

