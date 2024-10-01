Return-Path: <stable+bounces-78448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0566198B9DD
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE94B2812AB
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C781A0AF3;
	Tue,  1 Oct 2024 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCGxXMzR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2F19F429;
	Tue,  1 Oct 2024 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779314; cv=none; b=nPPW6MfxBjhzRJPCY0Nqshw0PHHdnkyKw3xtBShn4qSA66McHcTDcdJSToqhyxZOCi1mADx69GW3XkBX+TktSQhYD4B6oAL1EHR7A6Ukwxqd/vvUuXSJP2KjD8TELKaFEyyt9cUmv/slBXr2++h17jn1Una0K1AUV3u4DmeIZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779314; c=relaxed/simple;
	bh=3Gj1hgvY9P7eaOCRcE7QQXrpLnua94BE71VWtrO3It0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeA15usrLN+Ufy4cBESR2ZIz/DOuhglAH9/uug8j1v90pS+Lkm9uBXfps0Z1algivs6CaGnjIXmNepPqe0AaerdXAv3DF1q9ZwqNUAboyZxXJhU88R5wEH0jufNdj7LSV1VpCbXUxRCNtE6vzYgN9bHeu43APV1ftuuYe/gFAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCGxXMzR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b95359440so15235345ad.0;
        Tue, 01 Oct 2024 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727779313; x=1728384113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLP/0R/qMH5dr0opriCBNJUpL7J8DlQGDOnz8+wpL28=;
        b=dCGxXMzR6B/MFOrf+eVdAkEJd5xH2Xxx3o9jBbAsYvUFJLOUF7ffgZT38Zkpj7/Lrh
         7mQs7F0G9C5qjJRgAX3rZ+iovQjiqcd/iITeuGpeyKdo0P21/x67Xd7WRHq3Itrb2gbi
         Bz2lWfOIX4BsTN8pEecJAUI43ZO8LUjir2KKe53wJkxpIwjmT0ULKra1TXfTaTZbXETZ
         LG75nDrA3uczYnEowyODHec2fADJWwrmO9BsVywMLXd+1lxUWyAMcQq6ZJbWJQYs8FfW
         1F/wkhdzXlgWbYJTKvvCQ76g/W/cfzYPjG9v+hB/Poc2GIg1tpsUwPj7XTb6VKkMEtkC
         YwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727779313; x=1728384113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLP/0R/qMH5dr0opriCBNJUpL7J8DlQGDOnz8+wpL28=;
        b=WZ8H4GLQelJpZWJya9CgVweXVgK7c0trn/rF8TEoUWLPPUrIMnQQMZqDHHRc+fxxev
         T8Q+C52COidYzs9t7S0Vr8pU3FRGB2JlG7e80viZq13HDksR3pfZhTmyQuRfi7ZHacNJ
         RFBBud6xYwSnNbN8JBoj+BUvkGCl7+P/hg+O41RNb3qB+S13zeY2upHJFKWmZo59kuRR
         iAkZD+b5et2jxLtu9MKkW2cREAlhRkujyNxPuwyxwKDGHubIITVbOMQ3iFX8G+Bxq7k2
         gC6kFpIdMy+ixUizVOXy7kmYAz+2hZAxry+9QQQ48y2WwJ+blsfg2heXkeYcGQmoVrzW
         RYMw==
X-Forwarded-Encrypted: i=1; AJvYcCXSa6nMTkGO+eAOF0Od7vFVT1KdTfrQByg0Fog5rXfEzoJnA/S0oDp1pB0ZDGpCjw/eacim+OGy0vT/dL4CoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuctlUWVT/E2qC+gemm0CkPQnJdoYSbx+cSVjZVDtWYKqCfxTh
	mnoV/nb3XTMGxNVBtXifTs2E/IcsA9eyX5LC8cX/odMvzc/us/L/
X-Google-Smtp-Source: AGHT+IG0DBH1guwKwQCu1xsDfBN1yGjCjV824CnmfVWedh/uZu+dZK91r1rBml1FEVoPV+/dSoONxA==
X-Received: by 2002:a17:903:2307:b0:20b:5046:35b with SMTP id d9443c01a7336-20b5046080bmr190442675ad.57.1727779312736;
        Tue, 01 Oct 2024 03:41:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:70a4:8eee:1d3f:e71d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc99sm9727584a91.11.2024.10.01.03.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 03:41:52 -0700 (PDT)
Date: Tue, 1 Oct 2024 03:41:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	dlechner@baylibre.com
Subject: Re: Patch "Input: ims-pcu - fix calling interruptible mutex" has
 been added to the 6.11-stable tree
Message-ID: <ZvvR7d_IaOhAeRv9@google.com>
References: <20240930232429.2569091-1-sashal@kernel.org>
 <Zvu7yZx5XW2nXmxU@google.com>
 <2024100130-stereo-diner-11ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100130-stereo-diner-11ba@gregkh>

On Tue, Oct 01, 2024 at 11:33:12AM +0200, Greg KH wrote:
> On Tue, Oct 01, 2024 at 02:07:21AM -0700, Dmitry Torokhov wrote:
> > On Mon, Sep 30, 2024 at 07:24:28PM -0400, Sasha Levin wrote:
> > > This is a note to let you know that I've just added the patch titled
> > > 
> > >     Input: ims-pcu - fix calling interruptible mutex
> > > 
> > > to the 6.11-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > 
> > > The filename of the patch is:
> > >      input-ims-pcu-fix-calling-interruptible-mutex.patch
> > > and it can be found in the queue-6.11 subdirectory.
> > > 
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > > 
> > 
> > Did you manage to pick up 703f12672e1f ("Input: ims-pcu - switch to
> > using cleanup functions") for stable? I would love to see the
> > justification for that... 
> 
> It already is in the 6.11 kernel tree, so why would this fix, which
> says:
> 
> > > commit c137195362a652adfbc6a538b78a40b043de6eb0
> > > Author: David Lechner <dlechner@baylibre.com>
> > > Date:   Tue Sep 10 16:58:47 2024 -0500
> > > 
> > >     Input: ims-pcu - fix calling interruptible mutex
> > >     
> > >     [ Upstream commit 82abef590eb31d373e632743262ee7c42f49c289 ]
> > >     
> > >     Fix calling scoped_cond_guard() with mutex instead of mutex_intr.
> > >     
> > >     scoped_cond_guard(mutex, ...) will call mutex_lock() instead of
> > >     mutex_lock_interruptible().
> > >     
> > >     Fixes: 703f12672e1f ("Input: ims-pcu - switch to using cleanup functions")
> 
> This is a bugfix for the 6.11 tree, not be applicable to the 6.11.y
> releases?

Oh, my bad, I did not realize 703f12672e1f made into 6.11. Sorry about
this.

-- 
Dmitry

