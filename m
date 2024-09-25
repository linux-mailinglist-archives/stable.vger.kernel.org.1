Return-Path: <stable+bounces-77723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 779D398661B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 20:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03804B20AD5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89F54F5FB;
	Wed, 25 Sep 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z2SRAPIZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F529422
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287596; cv=none; b=BEHcGT6L3v7VeHIhMjhLO6B+0pIGkVB0D2bpJiBGh+uS69AYU5VOkbbVgXn86YWuj7esCPqgqUmuHgnh0+U85c1xNdK506XunNIb/t5ukxsGSwbiC2SmTTJBu6hXuKDEmIifhJxHWS5tzkesBTLdvPFV+Uz430CQcM0q5r/66ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287596; c=relaxed/simple;
	bh=8FM853O/xOnJhRw7rCIPF51Oa3PsbkkAWA8nLKhbyOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpVAPf7d4LcsznZ7FfjgcU7YM9mSAIuOl+c7CbsKzqGAxoyrCPuTcIyYTEa7CkKuH7X3xenvpn/osr6m1WywUd3IYFUarWzP+9KCdInoGvj2f9h44EqTAEqN3f1wuKV4pykDaBa9HhBEMVJM1/koLtCoTag+6tmWmrPjwMJSVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z2SRAPIZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b061b7299so17905ad.1
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727287594; x=1727892394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBAK5aOUmdCmbfri/vDAAdY5vRacp/oc7d/jle6FXSs=;
        b=z2SRAPIZyZ2NJ/7BDD0RP+YQzqOzXoJyFu5pMCJKtY7GDpLn5Jn2q5dwv30EeQ1gWE
         Kio2ExxzzN+S/T93nHq0qqvmwA5I8fXM/1XcjXW/NG/NCxGVvDweO7yRomtUA2C6Uy4j
         Yz4XUDpWZS9M4TVr3GZSVzRGL5VgT6HMaY+GL+XuglKwLqvGXj1ADUPbUKC/zyCLQCwb
         PiYRbYLu/Bp08POGh4/7rEEMGXya3EbDBVumUrlKNGMymV/cPsC/XWrCuZzUAeUHbRTu
         sLwZrfqfYaRncBsN1ASqrJ18mIwDTyVu/XjEfjv3uJ2+XDfFgwhVjg/VRDY3WCh5vs2F
         vy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287594; x=1727892394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBAK5aOUmdCmbfri/vDAAdY5vRacp/oc7d/jle6FXSs=;
        b=pHpjQsZWcHYVaGbbUI+hPXHpxKX44edIx6HOlhHUwMTxGupOZlNx0Z3xc3EEtFnAeU
         gr8DqsXqSR7aKdvMEYDkr1QgOVAviMWmVKLNbmN0/nsRPiGAfvPBGOOpSG23SfoBOvWC
         IBaBhFr6+Cpw/7jWxI0OKQTLOKvW8vPBSmHNoLOoCnxGucgRvo415JOH0I7Gle2gdM3Q
         fWaDB64oYHFCBF4r6x3WugHOaKNMni/QpKcvO5gb8qnW5zUTXWWjso1a7Fyxo8PaEQ4X
         kXtPzd8tC6ErsjqMvVaVscPelq5hePdhM8mwGe/zLSu3Qo34RU4PLdrclF+jzdVJu/wN
         Rz2A==
X-Forwarded-Encrypted: i=1; AJvYcCVnT+dTSpzi27euGpfWMQ8OtH8catgBbo9YfAIgBYm9dgaSxmfX67OcBSAGX/0imhZve0bWxyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjf75QeSclYkUSIqipvt7IK6z+ZRl2fcK/OERASlwkmQtdcrY
	P50yNHCxgNP8X9onYUosrwpmTZslG3rVl4twcqQrE+EhRsN+GtTQ8vYceN2dOA==
X-Google-Smtp-Source: AGHT+IFGKDJgA12uAkHuZ0wHB3Za4zjd3kHGLCz1m0SLQxt/jhoyGSCD6ZSxtXolCX0utVeV7sLwJw==
X-Received: by 2002:a17:902:d2cc:b0:1fb:19fb:a1f0 with SMTP id d9443c01a7336-20b1b3011f9mr185265ad.4.1727287594195;
        Wed, 25 Sep 2024 11:06:34 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc8342dfsm2997374b3a.3.2024.09.25.11.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:06:33 -0700 (PDT)
Date: Wed, 25 Sep 2024 18:06:30 +0000
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
Message-ID: <ZvRRJiRe7zwyPeY7@google.com>
References: <20240924184401.76043-1-cmllamas@google.com>
 <20240924184401.76043-3-cmllamas@google.com>
 <CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com>
 <ZvRM6RHstUiTSsk4@google.com>
 <CAH5fLggK3qZCXezUPg-xodUqeWRsVwZw=ywenvLAtfVRD3AgHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggK3qZCXezUPg-xodUqeWRsVwZw=ywenvLAtfVRD3AgHw@mail.gmail.com>

On Wed, Sep 25, 2024 at 07:52:37PM +0200, Alice Ryhl wrote:
> > > I reviewed some other code paths to verify whether there are other
> > > problems with processes dying concurrently with operations on freeze
> > > notifications. I didn't notice any other memory safety issues, but I
> >
> > Yeah most other paths are protected with binder_procs_lock mutex.
> >
> > > noticed that binder_request_freeze_notification returns EINVAL if you
> > > try to use it with a node from a dead process. That seems problematic,
> > > as this means that there's no way to invoke that command without
> > > risking an EINVAL error if the remote process dies. We should not
> > > return EINVAL errors on correct usage of the driver.
> >
> > Agreed, this should probably be -ESRCH or something. I'll add it to v2,
> > thanks for the suggestion.
> 
> Well, maybe? I think it's best to not return errnos from these
> commands at all, as they obscure how many commands were processed.

This is problematic, particularly when it's a multi-command buffer.
Userspace doesn't really know which one failed and if any of them
succeeded. Agreed.

> 
> Since the node still exists even if the process dies, perhaps we can
> just let you create the freeze notification even if it's dead? We can
> make it end up in the same state as if you request a freeze
> notification and the process then dies afterwards.

It's a dead node, there is no process associated with it. It would be
incorrect to setup the notification as it doesn't have a frozen status
anymore. We can't determine the ref->node->proc->is_frozen?

We could silently fail and skip the notification, but I don't know if
userspace will attempt to release it later... and fail with EINVAL.

--
Carlos Llamas

