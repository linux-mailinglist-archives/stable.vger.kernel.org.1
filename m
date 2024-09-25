Return-Path: <stable+bounces-77724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDC398661E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040621C20EF3
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62054C618;
	Wed, 25 Sep 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4TuqaMQK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37235D520
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287787; cv=none; b=ovaQq8LUgXq8zHdM0Mb2ASOHuf56qVLNDPO+M941ZGSawoJil74apBsYtI9RKruLyp0HJlOOpaef+BHR7OoAuFs2KT7IFXk5QnMouQgeZf4i7sU1WzcvdiVk1MgytQ6s4ViWODrime359mSkUmL7FWM0HWkq3wQKROd4RAQVBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287787; c=relaxed/simple;
	bh=9nAQVB119pF0BSlnNkNRlicepgOcLNTZW62UZ794POQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOn53ir9sPK042Ox8gwsDgz8xkhtfX547rmLOwYHH+I+HhOJabzXsu6v19W8ElUfTnuAozEbqkSIkJR4bZ63b2FONnQPTkgfh8TKhsbR4nwHaJmUBZ+re23GwGnwX+RWmBUYjcNXoMtuYpJ6KhkgmYkh9om2cRAhPN1zx5OAznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4TuqaMQK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2077b48cb09so23795ad.0
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727287785; x=1727892585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mktGcg+00Brbnt0pk0H3o4goRGRAxKiBHgvJE84QPlE=;
        b=4TuqaMQKbEuW1nCTTHXsD8IQTlnq2YsVBoOdaOzfqSBv0PmK1Q2VoJUwXdtOJPVPSA
         4wr9asshRN8O8HIjMzL45zU9jaGSL+notydggng/xyLa584Ohxm8H6uQPZc3X02Gej2l
         zteLiBu2wt4uZqVupSfbYDiUS6/kyubdiZxqw6G8YlzreDDQ7yS8NVJCDj5libmFJw9N
         wZotdIjwHakVTzJ8UJeAki7knG276Ifi2IL0yB+QtilnNiZj5FD9Zrsqz6iTZWlJjeOn
         rrUCXGBOontNX8+YrAoMepQg0QigqXNxUZ0sJlg5czJaGjnbIjFE1htckpHlM0IjDOF6
         0+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287785; x=1727892585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mktGcg+00Brbnt0pk0H3o4goRGRAxKiBHgvJE84QPlE=;
        b=OJwW8IIIxKBTZcxgY3nMpM+/6eGKKDL1Go2QsgQhQr7jFd3/qlG/ihgEZgobzBshSz
         9mQlgPo4cCCdik2amcLj2/BqUthGEaXjg7IuBy1b1X6F7wvssYfNX5YqzIhkBYswpcwt
         12YEliucBhYXtl88T9iuHGg9WXKh8ODFAhCD7LrGKg+aGKvF6+q1QxzYiTGPrcgfBLKW
         8k1PIIFDfBAzQhQtMSsuc/pOjMxKTI/w2QwqD+Nv4gS7NCauOEbg5lfottYvavnSelDT
         c//M5wrKhEATeHHae0Xiew8ak0ftZH7/8/5FJ9fvdQ0qDDs4KFVW9ThaJmQKg6ZLf7eS
         uyOg==
X-Forwarded-Encrypted: i=1; AJvYcCUE7sN1N4aa0LQ/AXAoWfqGF1O1ZjvFVTlrNvlvY7z8XXCd+Tl3Fa/hokqixTyhZtU6cQ5tf5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKdJOUT1RMcQOw6M46fz3+3tc4fY4vaXtcDRfHIinp0EQc2bs
	sNcSURhVn1tmro8eT/TbS0MLqfXlwfdW/esAfSujdcEg+llRCcK0VLea28aHbw==
X-Google-Smtp-Source: AGHT+IGFELSN/2f2b5o9/JSklbzBmcsK4y0/eyugaO8Dr1aPVDaXSMvr5DgiqhnRMILqv8VLTMv6vg==
X-Received: by 2002:a17:903:2344:b0:207:14d2:d940 with SMTP id d9443c01a7336-20b1b35cdddmr186145ad.10.1727287785349;
        Wed, 25 Sep 2024 11:09:45 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e2d8fc3sm1803156a91.40.2024.09.25.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:09:44 -0700 (PDT)
Date: Wed, 25 Sep 2024 18:09:40 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yu-Ting Tseng <yutingtseng@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] binder: fix OOB in binder_add_freeze_work()
Message-ID: <ZvRR5NT51nSuBhb8@google.com>
References: <20240924184401.76043-1-cmllamas@google.com>
 <20240924184401.76043-3-cmllamas@google.com>
 <CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com>
 <ZvRM6RHstUiTSsk4@google.com>
 <CAH5fLggK3qZCXezUPg-xodUqeWRsVwZw=ywenvLAtfVRD3AgHw@mail.gmail.com>
 <ZvRRJiRe7zwyPeY7@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvRRJiRe7zwyPeY7@google.com>

On Wed, Sep 25, 2024 at 06:06:30PM +0000, Carlos Llamas wrote:
> On Wed, Sep 25, 2024 at 07:52:37PM +0200, Alice Ryhl wrote:
> > > > I reviewed some other code paths to verify whether there are other
> > > > problems with processes dying concurrently with operations on freeze
> > > > notifications. I didn't notice any other memory safety issues, but I
> > >
> > > Yeah most other paths are protected with binder_procs_lock mutex.
> > >
> > > > noticed that binder_request_freeze_notification returns EINVAL if you
> > > > try to use it with a node from a dead process. That seems problematic,
> > > > as this means that there's no way to invoke that command without
> > > > risking an EINVAL error if the remote process dies. We should not
> > > > return EINVAL errors on correct usage of the driver.
> > >
> > > Agreed, this should probably be -ESRCH or something. I'll add it to v2,
> > > thanks for the suggestion.
> > 
> > Well, maybe? I think it's best to not return errnos from these
> > commands at all, as they obscure how many commands were processed.
> 
> This is problematic, particularly when it's a multi-command buffer.
> Userspace doesn't really know which one failed and if any of them
> succeeded. Agreed.
> 
> > 
> > Since the node still exists even if the process dies, perhaps we can
> > just let you create the freeze notification even if it's dead? We can
> > make it end up in the same state as if you request a freeze
> > notification and the process then dies afterwards.
> 
> It's a dead node, there is no process associated with it. It would be
> incorrect to setup the notification as it doesn't have a frozen status
> anymore. We can't determine the ref->node->proc->is_frozen?
> 
> We could silently fail and skip the notification, but I don't know if
> userspace will attempt to release it later... and fail with EINVAL.
> 

FWIW, we already propagate errors when the target process or node is
dead in some other places. It makes sense to me to let userspace know
that we couldn't setup the frozen notification.

