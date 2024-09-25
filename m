Return-Path: <stable+bounces-77721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFCF9865EC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 19:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F25288045
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835A5C603;
	Wed, 25 Sep 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnDwKmEK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1CB1870
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286512; cv=none; b=Itcm8UuSqskro48+Zwnd/Fn5KxZztQC/cntQhHk3pKPtR/1vL01N8QiqEfwtvdJ27Wl6Q3X39F1gRkoZJ+3zYtiARb0CXkCUJxD0DibI2wODwE9XVzffwXtiP0rt9B0ZtJcg9a5RcYYDf49xrYpIUKALQmJ2UprzkwhLlUNQMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286512; c=relaxed/simple;
	bh=s+Fsq6c0E4UqhDF+GTJIyrIlBaNJKj4Eto+OjSrKVpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqXEQeqzB74/Goe0E0PQgdXgb9I/0KRbCCmtPIHPPOYyu88anqSF8as6G5MkXl19JXSbWciqaIuA4Nu/c9pOZc9QmIPTXYjsT+0AFkhiHKrwFxn8L3jVtT3utFelpPedrvb00ok99S+gTXyH7eAqj/RJfeBI+/5qK0pnMHtYDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bnDwKmEK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2056aa5cefcso17675ad.0
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 10:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727286510; x=1727891310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ozwTA3TD6zQfqCMRip8pZ83VBEALnmG9iDzNvfVVggI=;
        b=bnDwKmEKswx1XNmNjHhO6J1B8VRHNuYvbGmWukW5e3VLNwWjKiH9zrRQR9hxZ87Igx
         ppN55h7nIyO2da3Zw5gwIjBsUzFbKC5erbEAxpZXnA/zo/Wtavb+4txewVrTpqOP8/BK
         ya9nTq9MsNBPaNJb0/xltOzS4uo37RtXx0jZFvIYMJxehGCiFfEJgKywmy9AYTsQSTl3
         OwOQNNRyWz8j2oX9ywUB4KemybXAjJSeOXUUYSTpwMLPzkxKcibwlCmgDFGs74ZTbqxn
         bRyETbgvGVOgSAv1g1mIcXCxyMCwJaZO6ne8h4PT+RAs2l3KNEuSsEE3mmG6v4pdhgkr
         aqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286510; x=1727891310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozwTA3TD6zQfqCMRip8pZ83VBEALnmG9iDzNvfVVggI=;
        b=AKBJkmnnlw6M6G2jtoMdYCp/o282TdRJDXVXU4p8OF01kyv2IOxO6W1TFoZ4aDKf0g
         FATfuaUrz/XBpxZF1lfgKavlOC5aXwtJ1B3SMJNp4ROcl4N/vxYukPFH/vEM2lJ6RST4
         QdqHmXHJJw7gyAd1K7f2mL+nrtlTKRWDMM9pmDTi7j2eBCE0PmZ/RX7nh8XnLUofmkfc
         hlG0HbdnJcxxL5Z7LsLzto6ASM/6BQeIiDpkLfUyqQzkYhjWwogzl6+fDwJG9+ZN3X/d
         rvNK0JytLB83sLmVNYaVlDx7XnjOLxBJpb4zEVLKU9/ND+UM8GezFmiSszSd4nWDjdJn
         QxvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw3q3kEjxNQt8fjHtlGN6viepaqTewzTcT1JQbGmdUKxY3ihs0akJYimPK5v0KejzMbhjNsQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDcPn3YI27I83I1kbBcCngZuNJi8WFcf51yOK3ayeHvaOx+CQ
	+gRZkw1wOG8nCejGLlVt5O64AkJSyxswdSx+jh40B4yHdcuz4R5W6lj/Yo9dCQ==
X-Google-Smtp-Source: AGHT+IFutEWYBK/Nvgcz2Tx6c1LNM5iBgzNMwt4bAnNvki4icwmyytR7tK14mV2RcwMW77JMVHQ4NA==
X-Received: by 2002:a17:902:e84f:b0:205:937f:3add with SMTP id d9443c01a7336-20b1b4c13d0mr46215ad.1.1727286509972;
        Wed, 25 Sep 2024 10:48:29 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b0f8b1d1dsm6606605ad.298.2024.09.25.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:48:29 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:48:25 +0000
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
Message-ID: <ZvRM6RHstUiTSsk4@google.com>
References: <20240924184401.76043-1-cmllamas@google.com>
 <20240924184401.76043-3-cmllamas@google.com>
 <CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com>

On Wed, Sep 25, 2024 at 10:02:51AM +0200, 'Alice Ryhl' via kernel-team wrote:
> On Tue, Sep 24, 2024 at 8:44 PM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > In binder_add_freeze_work() we iterate over the proc->nodes with the
> > proc->inner_lock held. However, this lock is temporarily dropped to
> > acquire the node->lock first (lock nesting order). This can race with
> > binder_deferred_release() which removes the nodes from the proc->nodes
> > rbtree and adds them into binder_dead_nodes list. This leads to a broken
> > iteration in binder_add_freeze_work() as rb_next() will use data from
> > binder_dead_nodes, triggering an out-of-bounds access:
> >
> >   ==================================================================
> >   BUG: KASAN: global-out-of-bounds in rb_next+0xfc/0x124
> >   Read of size 8 at addr ffffcb84285f7170 by task freeze/660
> >
> >   CPU: 8 UID: 0 PID: 660 Comm: freeze Not tainted 6.11.0-07343-ga727812a8d45 #18
> >   Hardware name: linux,dummy-virt (DT)
> >   Call trace:
> >    rb_next+0xfc/0x124
> >    binder_add_freeze_work+0x344/0x534
> >    binder_ioctl+0x1e70/0x25ac
> >    __arm64_sys_ioctl+0x124/0x190
> >
> >   The buggy address belongs to the variable:
> >    binder_dead_nodes+0x10/0x40
> >   [...]
> >   ==================================================================
> >
> > This is possible because proc->nodes (rbtree) and binder_dead_nodes
> > (list) share entries in binder_node through a union:
> >
> >         struct binder_node {
> >         [...]
> >                 union {
> >                         struct rb_node rb_node;
> >                         struct hlist_node dead_node;
> >                 };
> >
> > Fix the race by checking that the proc is still alive. If not, simply
> > break out of the iteration.
> >
> > Fixes: d579b04a52a1 ("binder: frozen notification")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> This change LGTM.
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> I reviewed some other code paths to verify whether there are other
> problems with processes dying concurrently with operations on freeze
> notifications. I didn't notice any other memory safety issues, but I

Yeah most other paths are protected with binder_procs_lock mutex.

> noticed that binder_request_freeze_notification returns EINVAL if you
> try to use it with a node from a dead process. That seems problematic,
> as this means that there's no way to invoke that command without
> risking an EINVAL error if the remote process dies. We should not
> return EINVAL errors on correct usage of the driver.

Agreed, this should probably be -ESRCH or something. I'll add it to v2,
thanks for the suggestion.

Cheers,
Carlos Llamas

