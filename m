Return-Path: <stable+bounces-60349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B108A9331A5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 21:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18ECB1F27871
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328F61A01C6;
	Tue, 16 Jul 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2EdW6pF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D0199EAD
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156445; cv=none; b=M9HaEh7bIDsGWYI1cytKRgW9xHeQe37tmVxZHHEpGEJbxcEMHnpGNPWKfklqmV27o4V8tfFnYNFrfvYZliDyXHD+NSbwvMKkuTzqBpfBP0VwZS+6tAhz4hV3Nyu1h1OdrGM4xpaB9h9LZDCrMHKF2K818E55pqkf/tP2q51cEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156445; c=relaxed/simple;
	bh=ONdOPjP1ZxwPyFqnXLVblo1/rd9gwa8+jkpt10wtAAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKjfsUKdlxGAsHA/Zv0fpUzgdLKSouhCIh7shIaZBp1IBtTQTUCinR39PsBK92AhuehZYjnTdAqI4Ren+TcaWAe4vbtHM4YLA0Ssae355AGROLvpyfTXZm6iBCweMYd6JudYvl+OduE7C70uqcPj4AX101zsk94bOT/ujxxcZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2EdW6pF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b0ebd1ef9so3890650b3a.2
        for <stable@vger.kernel.org>; Tue, 16 Jul 2024 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721156443; x=1721761243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wL+J48/48eftQx3s/74feVaBQmL9uhfQ6tfPQGa8SRw=;
        b=i2EdW6pF2QeN4lruNK8UNG6G6X/0tJff1n7jd2M0PzpWgll1Axl/hgtVG/ZDfCjDDO
         MczIPVGkdbxv6q0WTf3G7pOdiAxzVgx7JBdW0UTj7deK3K4vef5876CFIBhV9FYQ8yQc
         5z6T/kNPkRPmWnEMie+cl8NzPqk5+lkFJzY4qwm7y37E67Cz/7ojAR6M660O/wmtNhBs
         58aujMHx/UauLK6ph5ttHlux4LDOr8ZbXkGsajNf+gCBjqiRXQ5KJaj0KLoMNB9fC2a7
         Z2dNYzVwHEwgDOTVH5DqKotdMqXZbRr+BN/V5JxUM7gejNpeqL2xdOCPBbd1Drq0kCy8
         kuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156443; x=1721761243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wL+J48/48eftQx3s/74feVaBQmL9uhfQ6tfPQGa8SRw=;
        b=QzojnFHNf4LofIJBa5QsiTWI59MJ4y9K5ujoLA2RDKeM/cJTJn4uZ0OameAgZmLRO7
         AV/2k+n/iMfJpujIjy+TBRrPUBKkE1/EyX0jTSQ9e4Bo29xKJZQVAdUZx8HiI52zMXrE
         64UcNe39gaoBlgU4yIF50XJfCASAQwrB6ysr3W/fSCfFlQGmS6QQcjjgrXk05LUlaf8X
         XvX1xu6vhVlH84Fj2aPKpo7cGaQi9Stb/b5phjojAB3uLatw2p2VhNb3c1eAbB7AD9K9
         QQUKynpN0SOdmvKNMY6iwi17O9EOefCYCNNBUcmIzakYIZVRR+ug/TFzz2vNsQXQogK6
         KwLA==
X-Forwarded-Encrypted: i=1; AJvYcCX1/gzuDmPnZWArR7jeNCOEud5mOixPle3z5XD+uQ9a6caXnXgDLkmKJb+60zPrw2Yg9+UdEh+qsIG8eLb8ZYu1U4SZpWXf
X-Gm-Message-State: AOJu0YyNBeahnG6f8pezi7HaUDo0jdgi1HvwnPf5rDXtDPfPvFcE69Ec
	UUtcwYKwaYd82FPMhac9s5PgWShh3CoBFTF5FVj9DkBfZl/SKwvBLxi3Gy6TIw==
X-Google-Smtp-Source: AGHT+IEvsJuvzF74MkCd2qxt8Rw9jsVyQecuJMgsIpva9L79ZyLmwIiDd6+JUgQtUXWH2+XRJTfKEg==
X-Received: by 2002:a05:6a00:1d26:b0:70a:ed94:8ac9 with SMTP id d2e1a72fcca58-70c1fbd4ed8mr2935978b3a.9.1721156442421;
        Tue, 16 Jul 2024 12:00:42 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ebb6749sm6657318b3a.58.2024.07.16.12.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:00:41 -0700 (PDT)
Date: Tue, 16 Jul 2024 19:00:37 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org,
	syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com
Subject: Re: [PATCH] binder: fix descriptor lookup for context manager
Message-ID: <ZpbDVXiiVVxyx84X@google.com>
References: <000000000000601513061d51ea72@google.com>
 <20240716042856.871184-1-cmllamas@google.com>
 <CAHRSSEwkXhuGj0PKXEG1AjKFcJRKeE=QFHWzDUFBBVaS92ApSA@mail.gmail.com>
 <ZpbAlnAeCv-eiNzF@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpbAlnAeCv-eiNzF@google.com>

On Tue, Jul 16, 2024 at 06:48:54PM +0000, Carlos Llamas wrote:
> On Tue, Jul 16, 2024 at 10:40:20AM -0700, Todd Kjos wrote:
> > If context manager doesn't need to be bit 0 anymore, then why do we
> > bother to prefer bit 0? Does it matter?
> > 
> > It would simplify the code below if the offset is always 0 since you
> > wouldn't need an offset at all.
> 
> Yes, it would make things simplier if references to the context manager
> could get any descriptor id. However, there seems to be an expectation
> from libbinder that this descriptor would be zero. At least according to
> some folks more familiar with userspace binder than myself.
> 
> I think we can revisit this expectation though and also look closer at
> the scenario of a context manager "swap". The procs can still reach the
> new context manager using descriptor 0. However, this may cause some
> issues with operations with refs such as BC_INCREFS/BC_DECREFS.
> 
> AFAICT, the context manager doesn't even need a reference. But while we
> dig furhter into this I think the best option is to keep the behavior
> the same for now: reserve descriptor zero for the context manager node
> unless it's already taken. Changing this is non-trivial IMO.
> 
> --
> Carlos Llamas

Also, we need to consider that references to regular nodes (not context
manager) cannot get descriptor zero assigned to them for obvious
reasons. So descriptor zero is always reserved for the context manager,
but there might be certain scenarios in which references to the context
manager get a non-zero descriptor.

