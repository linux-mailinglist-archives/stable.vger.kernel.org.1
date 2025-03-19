Return-Path: <stable+bounces-125588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C7A6954C
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB64463D77
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8B91E1025;
	Wed, 19 Mar 2025 16:46:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A891E2850
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402778; cv=none; b=GG4kgjCeilANAkfb2dBZtT+a0lZqov/HQ5yAcf54MUlif7xHcjm14UjjlMrh/XTmm6Q5jqYOJG7L2nE8SvmkK0IpVaPUKHDQ13d19d3l3/1p1YFzxWR+ImW99wfa3XNfpsCs+6bVTdZ2wEaQWMP6/L3v2QkpStAg2Kk77MJM7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402778; c=relaxed/simple;
	bh=fpvHJdekxgPEvB0ATNh0JaH9/Tms0pdcrkDJK3iXu3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW4/hbcGV7YpWfbkKMHUIb7KdtVghJEwwY55jXwur9QSUqS7EWVjD25xf+9b7OkEvpJqyJejyorFpel6qQXg/K3/zkx28Ws1WqdrlNnfFzeoZx5tpyAMRiiIVEnd48Xa9OPEioA10fjRNnkwAJ5uAX9YwuS6eu3lsCNcQlNvPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52JGk2JF018902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:46:03 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 65BAC2E010B; Wed, 19 Mar 2025 12:46:02 -0400 (EDT)
Date: Wed, 19 Mar 2025 12:46:02 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Jakub Acs <acsjakub@amazon.com>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH] ext4: fix OOB read when checking dotdot dir
Message-ID: <20250319164602.GC1061595@mit.edu>
References: <20250319110134.10071-1-acsjakub@amazon.com>
 <20250319130543.GA1061595@mit.edu>
 <CAHk-=wgzYVZ0ZNvcqC+yToX6nFx+SNZqTcyEvzm2RMP-TU-Dqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgzYVZ0ZNvcqC+yToX6nFx+SNZqTcyEvzm2RMP-TU-Dqw@mail.gmail.com>

On Wed, Mar 19, 2025 at 09:28:56AM -0700, Linus Torvalds wrote:
> Why would you use 'strcmp()' when you just checked that the length is one?
> 
> IOW, if you are talking about "a bit more optimized", please just check
> 
>         de->name[0] == '.'
> 
> after you've checked that the length is 1.

Yes, good point.  My suggestion was to optimize htings by avoid
calling strcmp() in most cases, but you're absolutely correct that we
could do even better by *never* calling strcmp().

						- Ted

