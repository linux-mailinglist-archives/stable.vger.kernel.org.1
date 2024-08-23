Return-Path: <stable+bounces-69922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16A95C2C4
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 03:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999BC285449
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C912B72;
	Fri, 23 Aug 2024 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nlv5emgE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175AE156CE;
	Fri, 23 Aug 2024 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376320; cv=none; b=ENqWH5KpfeyS1d2bnoBwLoNh+z2Xsn3+ABa0NL8/7uI6VvYO9s6YtfuQ6Pxnq9f1JPD8bfCHcB+K3tDBD3NZzhz4ndpvzguieIibME2vHQcUla/5le2AgKGjDIqBd0aL6cV8g+wsqekiPNba/ZZOupjK3dA4Vjiu2Hwxmk11ZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376320; c=relaxed/simple;
	bh=cNssFY/smdK84S8mMYG78PAZJPDF3GvHhnLG2R3/D4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyglGiZ7NbVj0/rbwJcO8BvcOEMkaUJd7rRmsugk6WeMrwAfmHTJ82Xhi9YgT1Nuop7r51DUlOVrK1acGT3rzrjbYYbxVfWy4VNX/Lrx2xNYKJdheDwQNTCP7I/B3BsNT0lPcfMoHZ/KQx8xR+55JXz8euxXSOe7FxedL9ljyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nlv5emgE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714226888dfso1323417b3a.1;
        Thu, 22 Aug 2024 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724376318; x=1724981118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v3pBCzCZNQLif4YukFJaiLhSqZdnuWl/6RUhK8F11TI=;
        b=Nlv5emgE/wYCSKMt5VpUsYKLRHU0VmApRuG84OFtGnL0rtenm0zWssnokO3tqPH7Bl
         MOO6KtoYcTruvZRGeI539758baHf0InwdXf2i26gxBPYDymvG//l9KitS4zkAtky4naN
         cu4R0LfjO9eIRZ1Rzgv8Tpl7yjagP0fotI1WsEqMGAfz0xttZ228yEDlsPTUu1x8Ze25
         k2EZ8Gjew7dwNS4xehXoitHN40QMoPK7SgxVxQMz+cgKR+Qz019mAoHBssyoBhJYQ7K+
         lOwD16DOBLN6CuCNqF9uQuvSu48Lfcplyt8zBJ2iIBOEFy6Uqke7r3+dwbR+xpWvU4F8
         XJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724376318; x=1724981118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3pBCzCZNQLif4YukFJaiLhSqZdnuWl/6RUhK8F11TI=;
        b=Qb1lUPNbZhYnDwYpbcv0le7A+5cY6MtLonXVWxOS2aSeR9+Wq1k6NqELK1FG17lG+o
         odZcQzhbHDKe/xwVQBHMuvYKl5Aygsu0n91lJONf1B0ohPwrPpPkALefF04bWAYSYaLB
         c4XeV549PlSKVTaM/nLU9y3oO0jG05YN/qwTGh1lxALTTJylpv9hfRVECU4Z6I3hV4+o
         /HVFe0RX3cPc+RumYPdtDylMaWF2NyeB06wdJpk69OS73ZTWHT/gvIW8jcDmYuMqDGj5
         3EbQYiifnIhTipcZPFTE6xt5ciKQpn27CoQMCivwgkaq1LOl/GzJXlU/DqQQBRN6TxxK
         Zj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5iB/5EmvKjo9hWRthGGsJ5NAmgKpbvaOmN3zBRO2qKYf88tn8rS/vD7qGmfFK5d+vzVd6H8ZsGKnKotQ=@vger.kernel.org, AJvYcCW9CXhwsfGz3Lr/Ph40J6K12kSsg7zB/qDJhfualIDTPERZfXQczMgf3ruy+2OwSJfTMcrEaXgP@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZfA2OAlGrcctg5gYeBuXXpZtINvrpP8SqSmiK84t0VT8t8oP
	1/MJh0zSpjf07hSPcmAnPQxEcUgCz2jIGpGbKBjgB9ISj65720VC
X-Google-Smtp-Source: AGHT+IEy0Kz3ZxiH+FJBPaEIk4mATOrE/FZAxxKL8nDtUCKABY7WsKvL8aClMmkQ5fhEWDrGqLFobQ==
X-Received: by 2002:a05:6a00:690c:b0:705:a13b:e740 with SMTP id d2e1a72fcca58-7144587e4e7mr664994b3a.19.1724376318105;
        Thu, 22 Aug 2024 18:25:18 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ccdb:6951:7a5:be1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0d2esm2035410b3a.99.2024.08.22.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 18:25:17 -0700 (PDT)
Date: Thu, 22 Aug 2024 18:25:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
Message-ID: <Zsfk-9lf1sRMgBqE@google.com>
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
 <ZsfRqT9d6Qp_Pva5@google.com>
 <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>
 <2024082318-labored-blunderer-a897@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082318-labored-blunderer-a897@gregkh>

On Fri, Aug 23, 2024 at 09:14:12AM +0800, Greg Kroah-Hartman wrote:
> On Fri, Aug 23, 2024 at 08:46:12AM +0800, Zijun Hu wrote:
> > On 2024/8/23 08:02, Dmitry Torokhov wrote:
> > > Hi,
> > > 
> > > On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
> > >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> > >>
> > >> An uninitialized variable @data.have_async may be used as analyzed
> > >> by the following inline comments:
> > >>
> > >> static int __device_attach(struct device *dev, bool allow_async)
> > >> {
> > >> 	// if @allow_async is true.
> > >>
> > >> 	...
> > >> 	struct device_attach_data data = {
> > >> 		.dev = dev,
> > >> 		.check_async = allow_async,
> > >> 		.want_async = false,
> > >> 	};
> > >> 	// @data.have_async is not initialized.
> > > 
> > > No, in the presence of a structure initializer fields not explicitly
> > > initialized will be set to 0 by the compiler.
> > > 
> > really?
> > do all C compilers have such behavior ?
> 
> Oh wait, if this were static, then yes, it would all be set to 0, sorry,
> I misread this.
> 
> This is on the stack so it needs to be zeroed out explicitly.  We should
> set the whole thing to 0 and then set only the fields we want to
> override to ensure it's all correct.

No we do not. ISO/IEC 9899:201x 6.7.9 Initialization:

"21 If there are fewer initializers in a brace-enclosed list than there
are elements or members of an aggregate, or fewer characters in a string
literal used to initialize an array of known size than there are
elements in the array, the remainder of the aggregate shall be
initialized implicitly the same as objects that have static storage
duration."

That is why you can 0-initialize a structure by doing:

	struct s s1 = { 0 };

or even

	struct s s1 = { };

Thanks.

-- 
Dmitry

