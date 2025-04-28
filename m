Return-Path: <stable+bounces-136976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B2A9FDD7
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 01:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50985A8007
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE614214237;
	Mon, 28 Apr 2025 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl1U3RmC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F418BBBB;
	Mon, 28 Apr 2025 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745883485; cv=none; b=oInX2e1Yec7JB2BMFYQGNh5v3ltx5usFiMoueT5x+rnw0Tes3iHi/Cg+dDyisWX79l3a8Ht0LQ+VSizZYoMRMBrl6Dzubn+kFTqeU51LQEFDVf30BwKDDa07ZMnJrJ4NpEtc4eo8OWkFm6S7mfdHpnd2xh/hhdqDQuuSSo4cRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745883485; c=relaxed/simple;
	bh=oQ3FbEePiwGWAsASS7Z4SAIJv7xHO9jREHRK/Aibiy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lf7FK5W22Xdx9RkTN72quGPU1yHvhFsqkC7MQLiGcL4IUQyrLEEPZVQv1ebmc/fP281bmiD0WRZiMKdr9tWP/NjiOeYg7oRI3wOMRTKeFMnVqGHJ/OgyiuTvuNj5TMoMb4Mdzu7mW+9+HrPobW6JenHmbEzRILsygY/Ccnl0LSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl1U3RmC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2260c91576aso45732545ad.3;
        Mon, 28 Apr 2025 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745883483; x=1746488283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLf00+i5WXU9IavHUl6p2C33/ZAJdIRYZ+FKsvR9muY=;
        b=Dl1U3RmCcCXb2kWn6LJ4noVAJoFYY+Mk+krek9ULb0tLSK5gsza3I2cDdaBQ83uBRU
         i+ovQnt64jUQimD52PJbyKhbKdh13S2LiiHHhaAZWUmwUZ3lVYzE0RXyw4xBeLOytQ4L
         ogYTbiAjKjPuzoqU1AQgnW+pv34Jxho4+2rJtYOyCwhb+75MoJsSgZS4EnqXNXTteDGn
         6Vqc8aKnbKepJ4DwMZXyIjfyFsm6uVUtujryxPWeiLPtB/93GqfDa0fUPCGFUhP9yj1F
         a86tPwoTMgpF11EgC8lKX3rwodfJOeRlt54zDeLzrN0I7u1dsK15eSfBu6tZBqGX5q1R
         QBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745883483; x=1746488283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLf00+i5WXU9IavHUl6p2C33/ZAJdIRYZ+FKsvR9muY=;
        b=MIhQ65ve+7NUQ091epkYM0SPvOqECkQzoEOWbPaXntjJGxhIexka2HgWK2fIzWVuQx
         GxBxhlRopgsffolgJveGtDSrt422XWMeeDLlHnNf3Ur/WAkdSVvFCvf9N5l+5xjcM+EX
         eZdaMo/3rRXg8C9O2g3NEhlrM5MZnLBvzWQ1um+EQ2yqFRQQxu2MXy715xuEvVMZtWxh
         LzvnZLZpLQ9TjTh4Hq1BUGS+kVXgxaLsQ0WyEbCGPOrQp4AQLK3KFITlU3oNhuQwHDmk
         RiNSRUBVyEerDLp6uNLVvaFMMBKznqHVIEM0tZbYMKkZmRP4zN9Vrom/uT2mIeJV1z6j
         ZiAg==
X-Forwarded-Encrypted: i=1; AJvYcCUC8LYWyQ8LOIrtDNV6pJ9r75TUYyKtVFF/bzTTKkaj2GhMxban5BhmPhu7pO6gNaXQkjjzlpaL@vger.kernel.org, AJvYcCX5tUMgF4XAa1W9v3QVzstu85N4F5iVlUl/zRd9VudusBElSglncrbwsnRzDYByMWbf69m0njdC+0gutSQ=@vger.kernel.org, AJvYcCXZg4D5eMvrQ8AFORP/hvwoi25KseXkmETy1xgoqcOyokBuiDBkZRZNGxiC45sFSRYNfsgamKrN@vger.kernel.org
X-Gm-Message-State: AOJu0YyRmtaCJWRuIEgdd0LJk3GPkmV5EmCtjs/K/El0eyHU+QziV62p
	aEMjCfx8uXutAgMpAbWjwNNhVmYBQ4HzW9gJpZeDJnc1eKryEE8M
X-Gm-Gg: ASbGnctp7Q0qMyR7CwkD931t3FtNlseyZU9PAn3mMvxMYKs+5mznkbJU5owbX+6dNxV
	tgGsu/fI1xhulOg4s77g8fevQn2q795mSPylSWyLGnKSZs3IqLH2L03ND+FqJvndvQk+8C6nm1d
	w4pR1kRrxJxBxJve7OzZj812j5NzyaMwgHrH7DUNYQtxQ8t6jbQ7Z4UJa7Xttc12a7Ac4kRq4WE
	ttxQ3cDM/gUm3pDokb2jU+wYGAqbOjsUnW+B2sV12shR1JgBPIhor8hGnbDeXToHiDO00ATLBW6
	LSGzfM1a/BJJ9MGpmlrDoHQJR8LhoEHvRmvS0Kg20M0C
X-Google-Smtp-Source: AGHT+IGkMQz3emXbltwBn1k0bQRrPQBRYhRx9PCGAj8+J4ESGupWLyylRHbo8KPGmReOdBEw7WzX+Q==
X-Received: by 2002:a17:902:c453:b0:22d:e57a:2795 with SMTP id d9443c01a7336-22de57a2dc4mr22963185ad.47.1745883483560;
        Mon, 28 Apr 2025 16:38:03 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76dd2sm90073895ad.26.2025.04.28.16.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:38:02 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:38:02 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
	"Alan J. Wylie" <alan@wylie.me.uk>,
	Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <aBARWmQi6/reosTF@pop-os.localdomain>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
 <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
 <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
 <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
 <2025042831-professor-crazy-ad07@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042831-professor-crazy-ad07@gregkh>

Hi Greg,

On Mon, Apr 28, 2025 at 01:45:14PM +0200, Greg KH wrote:
> 
> Can someone send me a patch series that does the right thing here?
> After reading this thread I'm confused as to what is needed to be done.
> 

I just sent out a fix for the regression reported here, so after it gets
merged, I will send you a list of commits (probably 2, since we don't
backport selftests) that need to go for -stable.

Sorry for the regression and confusion here.

Thanks!

