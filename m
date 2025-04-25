Return-Path: <stable+bounces-136726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21545A9CDCE
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 18:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052034A6EAC
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9918DB24;
	Fri, 25 Apr 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7fyJsID"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889618D649;
	Fri, 25 Apr 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597314; cv=none; b=DfiP/c6qewc6weVBil6pcVGj1kdgWtS3KoBw3zRLezg1CXlQT6b3QjQjvX2HZwv6gQRDCDF+CgUICkCz9UnqQM1scIKPoNTuIXRo1ez2+NukUDSY8IDM7r/czNIoTSF53ktoi6iizWCx0ozew5G+c8o8NNHCD1uputeOKQVCSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597314; c=relaxed/simple;
	bh=L2GzxIA56nfM+cDgMgMMSOWe5dN+/yidKvdmYvhSKfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU/DvNZJmGfkwMDG1mxQN753pNH0TWia6/ldFdgOwFoujIVf4eVZMKTpu0xbfB41mKACc89ZTPRQELdHUF0/ePIW8yYoQDdsyyMV4qDgP/Dk8oqVZwdJavVslLP9Yp42VNVdX3G7j7ryRJ8zd0QTI63YhH3oEmY8W6GB0paCPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7fyJsID; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22da3b26532so24062545ad.0;
        Fri, 25 Apr 2025 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745597312; x=1746202112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i5pNyASVzOvo7de5opodmAAp0f24p09fWkyNMVBg/4c=;
        b=R7fyJsIDs1QPKdRZvJ3njPzf5SV+F50V9xH8x1hWbOecp0acNV7sSvwr+XKRmIkG7R
         w6OPApiBYiidHzBxUTIpl7EwZvO1hXD1BnRAVXjPwSdOLMbDJ08LhwyhthR7xhLn9l9i
         hgQPPnrtNXCZ7na2W4dZG5Pes8TWyJNCiA4r405/dcdJqrXJBKSwfbH4HXEPOKDRKMbd
         zr/DvRSUx9LvuLMCJNI7fEmnEF5e589I/v0QFPPvoc+tGIvPmnjbnNfsUrAdXwtQPWwK
         kkHYyGT6H4a8Fg685ZC1gjlli2kiX+cMbTqkzguZJnlI3x/jxYOCsjxhdIZyov3/h2mT
         IosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597312; x=1746202112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5pNyASVzOvo7de5opodmAAp0f24p09fWkyNMVBg/4c=;
        b=sSMH1VaarqqpPec28ikcjewuw+zf/WtjzZUUyqizPGFbozHHi9l0Y+1nDFiEwoeDN1
         yb9bFEqY0LGcG+VyQU+ELNN8yPfgSMq+lDIKO5Uk/cSiT+Runyt+Tk+tJRiJUxhzc2+7
         WzqjUbsVnAG+EJbap1f/ROgIVECcJ9Ze1z9Qzw8JqYwStszoPHRt+bt6/EYJxN69YUHa
         qJ64H4k57boZesMC3p449NSc7Zx1zPlBezeVajZKAumWQ7JcpvODdWaXIcdBmSwNaX2g
         icft3kCURgF6GZdm1gW6hl1ozWYizwzoz7Hb0z9i0S6iyioxRpASiRZ6T8OWTZYtJJij
         893Q==
X-Forwarded-Encrypted: i=1; AJvYcCV29vZEM49wiBFSXP55wwQVCBwzmYUTe6REp1gHJlZUG4Cw5KtCBzWEOpt3WLL3PWzGUFhg+RnE@vger.kernel.org, AJvYcCVn6Q+dkqaZSJXdGOEMvmOlNBvqCTDGHsCYEciGFgfYd9KcOqJjlzLHroMp52QiFGBdpfsVOOXFQ5CoDA0=@vger.kernel.org, AJvYcCWKeCyRZ/3PuwbI9QR8gsLjXO5qQuwkxWBT+sfJ8lOG0+DRmZ84CATJ3yF5M1hVuptQSPupLcLm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2ljge6V0PGL6au7Ok/BfVMbQf+/rZWUFPcL+pq+g7jBD3kYx
	/dxIQ8or6GzwUi72R7xrIJcYO9CRPFtwTCt6DNrFq/EyvrFNzINA
X-Gm-Gg: ASbGncujxH7nJ5H4wOqzu/AV007pX0JP/GMJcgi40YMZYA2jzvCJfvY9LjCkfem70rY
	XL60uveyIWrOypgV2AUwl9IOXvp/tEqdMcYg95VwaCi+X8m5YrmOCTU5G5S2nJj3cw/yr0X3o6Y
	pz7gOf00e44rfU/v1hHcTm3UNotbKcB8NCjXf+0dYtHjJm9zQCfdATdvk9g4tqivikJkxFL4hSe
	h9J8eIOpGuY3goFs1dCKeXjZq+XVEi1ChlVI5DdF0vlWdZsP8yptEQjKMzCnCotsezYleyVbMVK
	VjjFxusyvBrqjWqaBUGBEBaY0PhT+q8qmJAgVlJnBb2mmJ8=
X-Google-Smtp-Source: AGHT+IEDnCojjqBFupUvzzEwiunkDr1ppd44q2OkPVWtrj2YUpLPC11441r/ohtaDxUPakVfJZSnow==
X-Received: by 2002:a17:902:f683:b0:223:62f5:fd44 with SMTP id d9443c01a7336-22dbf62c38emr46955105ad.40.1745597311720;
        Fri, 25 Apr 2025 09:08:31 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:e00f:8820:97a7:c371])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7b08sm34009365ad.114.2025.04.25.09.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:08:30 -0700 (PDT)
Date: Fri, 25 Apr 2025 09:08:29 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <aAuzfQe08tFJclNJ@pop-os.localdomain>
References: <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
 <aAf/K7F9TmCJIT+N@pop-os.localdomain>
 <20250422214716.5e181523@frodo.int.wylie.me.uk>
 <aAgO59L0ccXl6kUs@pop-os.localdomain>
 <20250423105131.7ab46a47@frodo.int.wylie.me.uk>
 <aAlAakEUu4XSEdXF@pop-os.localdomain>
 <20250424135331.02511131@frodo.int.wylie.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424135331.02511131@frodo.int.wylie.me.uk>

On Thu, Apr 24, 2025 at 01:53:31PM +0100, Alan J. Wylie wrote:
> > On Tue, Apr 22, 2025 at 07:20:24PM +0200, Holger Hoffstätte wrote:
> 
> > Meanwhile, if you could provide a reliable (and ideally minimum)
> > reproducer, it would help me a lot to debug.
> 
> I've found a reproducer. Below is a stripped down version of the shell script
> that I posted in my initial report.
> 
> Running this in a 1 second loop is enough to cause the panic very quickly.
> 
> It seems a bit of network traffic is needed, too.

Excellent! Now I can try it on my side instead of bothering you. :)

I will check if applying all patches here could make crash and warning
go away. And of course, I need to really understand why the crash still
happened even after the qlen check adding to htb_qlen_notify(), which is
unexpected to me.

Thanks a lot!

