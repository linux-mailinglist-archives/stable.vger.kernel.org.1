Return-Path: <stable+bounces-19046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AF184C473
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 06:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D4F1C24E36
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 05:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E5714A8B;
	Wed,  7 Feb 2024 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xV2t9THj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F231CF8A
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284783; cv=none; b=YEACaBsuPV78VxpdciQFEuTOGMWv21x+3+2xQEmSR3omRnfGsdMiAfvsnbRrcGNS/myr0zkbOeKjMPgK3l1/k5nRmh3oxGq8g7+K/TSr6KNkJmMiIjsWwM0eC+RPq/2t8Pea7+8Cs1ewEnRz1cQzw/2DztaxFKMzwLkLOxVlm7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284783; c=relaxed/simple;
	bh=binrH5Mir+QNhaTwp+L3ihjHixBG0oRt+1Oj4M7+3Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDJVk0xR6DajhFpokfbKmizIm28KqoYqRNLuuPQfp9ZPBNN/NUwHEn6d0WkK2ZPYU365I/jWb8YINDhLMftjXxNIrGm8IsEM/Wc+gFpnUDW2/CjrGt/xIwoOFSip5XJ9Wlf/f7U0O1SgKYRHn0Fqn4Cb72MfIJI1+RAWKva1FF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xV2t9THj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55fbbfbc0f5so2471845a12.0
        for <stable@vger.kernel.org>; Tue, 06 Feb 2024 21:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707284780; x=1707889580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kalDtVLZWTvATUBZIpX4S68OWyGb0GfwWS+1uj6sqPM=;
        b=xV2t9THj5IlouhUdC4WXhH0+eNU03QmbA4eb4wSlQeIJKV4Lw5RDm45KM2Qfn++MOt
         kyLwRj3foXoQzjFWo/L5wVMzxOoaLFqqsLQsB7qCBXYUJM4DaPsCPMNej9Jp+h/h66Hn
         HPz+ZTGaDXbjWy6ca78AbIW+hqVUhWsd6hGZlxdluKMQ3hu3Np9rL24QceGol7eVWnKC
         PT8TBnpmOKGi5FkyYsUVNEk4AEeiebtJzx+CVN0IrSmkzU9/3R7vuIVUtoI7Np5TMO+U
         H75Sq6HFIZXreceDVCxZJARiJ8fhsIm0i8WSDeqsd5MyFD72wR02ReCE5f98ldxrzYRj
         dYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707284780; x=1707889580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kalDtVLZWTvATUBZIpX4S68OWyGb0GfwWS+1uj6sqPM=;
        b=wlLEtNaAU5Kcio781F6t/X4sM9qpSL+14FvV/VYp1zDAz/OocwJjHtTIDyn7zeOllC
         RZ7ar9w9XuUFz0PCw58s7li+3rIjap+uAEr7WCDF+ViRz+B//+k/6bq8D5Apb0AZ92PE
         KVPZWCps4g07tUZWl3aTaANLP0qLywRn3EWjYmY38Y682ggaiXuXixAit7qvONIqTFaM
         suFwSb9BdPkJmCCudgnLSiBunM9Urld+ReB4I7phhkq55xTeNswld1+muX0ZncAA2DTC
         HRAXtK682ge7Kmbg/Zk8i3ksmcXEhDK+OIhuxb6AfHF9UVcyQC8K9G1mo5R2zVhsFtYJ
         sPdw==
X-Gm-Message-State: AOJu0YwNNnTUicyxAAp/HWsBjwQuC5eGRR35eqsliWpp7YU6d2Ne9pDO
	ud1c4T+nZe6iKXjCWNDv0vVji6THVkHk4dTsFQZN4l3EH5wO1wDJBaf80Jcf7xrgm4HNRRdPrIb
	vLG8mbB4422g/KfuDgIECMCTlN49yPYP7wwgr
X-Google-Smtp-Source: AGHT+IFrLEabmaF36oojZfoiOrcXwVRBSuGaGdzZQae/d43gq43MN9/eZpjPs0LhyOJ5wi57hxk+MUec9DV2G9tNc+g=
X-Received: by 2002:a17:906:310b:b0:a38:63a0:5947 with SMTP id
 11-20020a170906310b00b00a3863a05947mr995896ejx.20.1707284779457; Tue, 06 Feb
 2024 21:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207033857.3820921-1-chengming.zhou@linux.dev> <CAF8kJuOCbuFemoFNUYeNGYzYJ7eGLka6Y6OvSg8h61vXUfYdLw@mail.gmail.com>
In-Reply-To: <CAF8kJuOCbuFemoFNUYeNGYzYJ7eGLka6Y6OvSg8h61vXUfYdLw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 6 Feb 2024 21:45:41 -0800
Message-ID: <CAJD7tkbc7j8B3X8YfQ9r00D3ojJvJg+YwNuAF6P=jyCyrGy_=Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm/zswap: invalidate old entry when store fail or !zswap_enabled
To: Chris Li <chrisl@kernel.org>
Cc: chengming.zhou@linux.dev, hannes@cmpxchg.org, nphamcs@gmail.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chengming Zhou <zhouchengming@bytedance.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > @@ -1608,14 +1598,12 @@ bool zswap_store(struct folio *folio)
> >         /* map */
> >         spin_lock(&tree->lock);
> >         /*
> > -        * A duplicate entry should have been removed at the beginning of this
> > -        * function. Since the swap entry should be pinned, if a duplicate is
> > -        * found again here it means that something went wrong in the swap
> > -        * cache.
> > +        * The folio may have been dirtied again, invalidate the
> > +        * possibly stale entry before inserting the new entry.
> >          */
> > -       while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> > -               WARN_ON(1);
> > +       if (zswap_rb_insert(&tree->rbroot, entry, &dupentry) == -EEXIST) {
> >                 zswap_invalidate_entry(tree, dupentry);
> > +               VM_WARN_ON(zswap_rb_insert(&tree->rbroot, entry, &dupentry));
>
> It seems there is only one path called zswap_rb_insert() and there is
> no loop to repeat the insert any more. Can we have the
> zswap_rb_insert() install the entry and return the dupentry? We can
> still just call zswap_invalidate_entry() on the duplicate. The mapping
> of the dupentry has been removed when  zswap_rb_insert() returns. That
> will save a repeat lookup on the duplicate case.
> After this change, the zswap_rb_insert() will map to the xarray
> xa_store() pretty nicely.

I brought this up in v1 [1]. We agreed to leave it as-is for now since
we expect the xarray conversion soon-ish. No need to update
zswap_rb_insert() only to replace it with xa_store() later anyway.

[1] https://lore.kernel.org/lkml/ZcFne336KJdbrvvS@google.com/

