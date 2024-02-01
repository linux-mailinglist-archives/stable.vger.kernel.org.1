Return-Path: <stable+bounces-17568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EB84530B
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 09:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C7FB29F59
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 08:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87515A4B2;
	Thu,  1 Feb 2024 08:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B9SxSMq0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA226AFA
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777174; cv=none; b=q82i4is0CjSGzMJW+CuI0Gn7z+svS989whHdH5HlZqdNxriAOki2hCcDzXOrMhGvjNXjqhyAXUmnfDMfyDPJYKGfRNhdvpt121h7B/HOS7OHr+QbMQbmUXdX3hGsnEjJb/Wdzjv32wqHU/qjQ9NuqWUdp6llFYfmnq0RuMLnpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777174; c=relaxed/simple;
	bh=WhHLaquxSvpLxMqDcJI+B8ZV32ULLbVr0/BiZffkAKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MROKe+jzAK9u5a1qib7zqHxZS9FpWc6fw6QKlx3BNt/VW7WcRE7Q1ngk8OM+7U76mCXJiPFTllh/p8TmiprO1EK/2earM6oOPXxgqeB7aSgPlIxZf0OTFJlybJVDeVAaJ/1tOw9VOQGxQSEEMWPKLR1+vFpsYn3B4NeerBVvZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=B9SxSMq0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so772034a12.2
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706777170; x=1707381970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8RQuQpDR9bvXppaCq3EKf/0/oBG7i7aNL/9+3uvW6Y=;
        b=B9SxSMq0Baj2Ser8cffWnwqIz07InxAu+3/Rqf7qXs9l05LRtCv1yzS1fiOlRDTATg
         TzYx5PQGeId6RvZ86jWoCkbOyi/k8qWmOVgkMX9DyMzqd8t3eDTBf8GSVNM2G5gt16DO
         MeHG1AH+vWtZ7jlFnpvwJT/PupVoITTgwrFK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777170; x=1707381970;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8RQuQpDR9bvXppaCq3EKf/0/oBG7i7aNL/9+3uvW6Y=;
        b=gwxBpAbAvleY0MUEXtqJhrBOxtInNQBRDrFY0HulD/JZSwjDniCK8l4wu8RC9oHCPw
         QC/mVywDk56UY2RUovw3Xsf7pFzCBG71JOAcRo08wTxGfq8I3ULB8isfkoSWYm/WEOgY
         2447yMs6D915sAgYuN+uC9OJVTGJjbjlZ3zF5Ak/YbUxfp41R2M98f9yXqlm6+bpE3LJ
         drWMljAz/Yc02aP/WRfcaXU5TEtFfKtN6voc9e/gY/KCtdjRZ4mP/51jpcDgmubWkA2A
         fM85k+l6ZqH+7ENNruXPqalvlsa+vObab9ZuMQ8KHzfA30eKI5lUNcc0ZGnVJ6mJRM4L
         Y9yw==
X-Gm-Message-State: AOJu0YwKbtUAxx3zqgkL+ilVEAbkU4KDcwCwaDouwIBoyUbDyy4GEdKg
	wreApvkuysSobJ57ds+bYDkUU9GurYIJjfHKbTi3O7YwyGUq3Orzq3ozAF/cAjkiuBjQTztFvWN
	lmVk+aGN8KFdgdtXkQJE/MvNr70jmGWMRqUkRr7F2yW/28qt0
X-Google-Smtp-Source: AGHT+IGzI2SKXNcEklhfyYiVeZDiu9TDvZ2RVihxZU6McTXdUxv6VA8s8Kba6ycgFRFfRumir3Y3TPWJ5uSj3dMK+fc=
X-Received: by 2002:a17:906:da06:b0:a35:edda:ca8b with SMTP id
 fi6-20020a170906da0600b00a35eddaca8bmr2859628ejb.76.1706777170641; Thu, 01
 Feb 2024 00:46:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-2-bschubert@ddn.com>
In-Reply-To: <20240131230827.207552-2-bschubert@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 09:45:59 +0100
Message-ID: <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com, 
	Hao Xu <howeyxu@tencent.com>, stable@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
>
> There were multiple issues with direct_io_allow_mmap:
> - fuse_link_write_file() was missing, resulting in warnings in
>   fuse_write_file_get() and EIO from msync()
> - "vma->vm_ops = &fuse_file_vm_ops" was not set, but especially
>   fuse_page_mkwrite is needed.
>
> The semantics of invalidate_inode_pages2() is so far not clearly defined
> in fuse_file_mmap. It dates back to
> commit 3121bfe76311 ("fuse: fix "direct_io" private mmap")
> Though, as direct_io_allow_mmap is a new feature, that was for MAP_PRIVATE
> only. As invalidate_inode_pages2() is calling into fuse_launder_folio()
> and writes out dirty pages, it should be safe to call
> invalidate_inode_pages2 for MAP_PRIVATE and MAP_SHARED as well.

Did you test with fsx (various versions can be found in LTP/xfstests)?
 It's very good at finding  mapped vs. non-mapped bugs.

Thanks,
Miklos

