Return-Path: <stable+bounces-12303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2A4832FC0
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 21:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3355B282F59
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 20:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAD941A9A;
	Fri, 19 Jan 2024 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VhQWwBY+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9F53E3E
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696219; cv=none; b=D6izTvK0PJZKliFbTPAvStkZnvLGmQxauehKYcQMBA77HEvHzo6sMtoIH8H97uD0j0X2Akoo4CXKgS8HhY9RT23UFzNQ/g7SE0VVYKFCoE6dxXef62nQuoQMVfrWE2+0O6iTtB3zIViEbo7Xre37PPawN/VueXV8bX3y0eyCxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696219; c=relaxed/simple;
	bh=8OYZqPISIFN5KLjECVoHCt1uNlCy0BijTW360W4wa40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX5LA7xwepIxgsUWap+LU6JmfovtHDk48nUce5snb71bFV7rhCX5ajUQcK7RreDnfOcJidG6R9S/lu/xmQHGrbyuXPh6yLKYDMMkP8v064TFSQT7H8Z8IXNWbA8CWGfAbi5qUhZgFgdJTXIWdznNxzvA2qVLfiDjwNWVwKrFfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VhQWwBY+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso412996466b.0
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 12:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1705696211; x=1706301011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uDGXTncqm9MB3BL9Zt8G5ddcs+43LzaU9pS4N/bFZaw=;
        b=VhQWwBY+pdHZlWirKg0fqls4o1bwQvRHX+CK8OX7R8Kby4h2cFtIfTPohDR/ZO1+/J
         kv0bCHdgSLWHUMQdqG95IdOcCQJ7wx17N8vbvkIxVBgfKnzLEzelTWw1CPfskU9MiZ1C
         V0EPi9GmWu3vvnwxCO7QQ3yBe8qNGhR8IZWNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705696211; x=1706301011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDGXTncqm9MB3BL9Zt8G5ddcs+43LzaU9pS4N/bFZaw=;
        b=HkSweNPorBIOeagyhsJNc8VancWc1al6N7vDF177OnqW7U//VOCIXgyvEsSM1JOZ+G
         9fnOsCPT/tSBJDrSHiJSNf0rtJJY6ojDqX4vVMa3Obw7W3X0cR4q34Sj8u11tAfsy2w4
         pyRAN4YjTWJFKl3jhNBWKfSf/nW9j3NTIhU2CDxUVys5X7gciAXbosirBGyIqL1iEt/j
         /dEgkNjpBBSNthGj4HEjShiztFaQ0hqhJOgEiBmbqfabtsKJp6QgYKf0R6r2AmUay543
         mPr9vk087bxM5LlDY88H1p7MJGAYvkZTLoyxrNaSPHURg9afUZiL+77nHpTQnLk1EtJi
         T9Kg==
X-Gm-Message-State: AOJu0YxyzUv+ozbG0/Om9yTvSQDDCu00SMOCnDLKnbV6jM6W6xgFJpxT
	61W92J4cxKpbeDFM1GAMQsWgNnxdp0FYMuVEqoVSl376VWjvZFP0exH68aLB0AXHXSV/FdRfXvf
	wKcw5OBO04fHukOn1Kc4utt/9q7zpiwW5x7CFqw==
X-Google-Smtp-Source: AGHT+IEAii7Y/IUup/E21nLLKZG3h7YMWqAccABZoHNHDmiuXaqhXigJUCgpyKgYEXNLdxgQ8bTu70xR/vO2hJ2VpyM=
X-Received: by 2002:a17:906:714f:b0:a23:62fd:e2f6 with SMTP id
 z15-20020a170906714f00b00a2362fde2f6mr445811ejj.30.1705696210888; Fri, 19 Jan
 2024 12:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
 <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com> <CAOQ4uxiob0t4YDpEZ4urfro=NrXF+FH_Bvt9DbD1cHbJAWf88A@mail.gmail.com>
In-Reply-To: <CAOQ4uxiob0t4YDpEZ4urfro=NrXF+FH_Bvt9DbD1cHbJAWf88A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Jan 2024 21:29:59 +0100
Message-ID: <CAJfpeguFY8KX9kXPBgz5imVTV4A0R+aqS_SRiwdoPXPqR_B_xg@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Larsson <alexl@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 20:06, Amir Goldstein <amir73il@gmail.com> wrote:

> How about checking xwhiteouts xattrs along with impure and
> origin xattrs in ovl_get_inode()?
>
> Then there will be no overhead in readdir and no need for
> marking the layer root?
>
> Miklos, would that be acceptable?

It's certainly a good idea, but doesn't really address my worry.  The
minor performance impact is not what bothers me most.  It's the fact
that in the common case the result of these calls are discarded.
That's just plain ugly, IMO.

My preferred alternative would be a mount option.  Amir, Alex, would
you both be okay with that?

Thanks,
Miklos

