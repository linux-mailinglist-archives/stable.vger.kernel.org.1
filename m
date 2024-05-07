Return-Path: <stable+bounces-43196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05208BE973
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 18:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745D4292C75
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456116D4D8;
	Tue,  7 May 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B+KWgLH6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4D3E48F
	for <stable@vger.kernel.org>; Tue,  7 May 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099882; cv=none; b=thQgxVZiQrBzfFXMMHlcdRRRCeVp4J8rr5mRXQy/m87dxKSgrM/PnO7F0TuDmAoqEpvS8Jb4n73CSnhT9mVTdMqOo/9eHx8SiEFr5Dsje/y/ZrD8sz5ddvpB6IQEv3cxKeWNCglKoe5Mje4/vjoMboF/HDbiWxwV3/IVZRE3yVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099882; c=relaxed/simple;
	bh=LV19r+RdCbS6VdMILFArPFDoxtY76IPBUlNtwHHns6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSJrSiQqCZ2DjuxeDBkMr4Ax4jIJt0JDxqkgaLOQXVbUKqVav7pmlzQdfL35me1XoqNFDMfADpNOJStxJfwfoToMi2O2czD3Z44rLHH8bR5LC21Dt1bF6mdZFRwWpDgM2qZElISxZfeZnFwjhBCK/Ee/1NVqXGBcg8uH708iS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=B+KWgLH6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c96a298d5aso1556948b6e.3
        for <stable@vger.kernel.org>; Tue, 07 May 2024 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715099880; x=1715704680; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rq3E+hsLGSN+5MIZB3XZU6auyIYe/okJXkhSxXH/gFE=;
        b=B+KWgLH6/PDddvOApWbzfxjWnqHUuVinyluVIAySRCKE6nNiOTwugbzQit6wuPIRxW
         ORB1QltB2KajfvmRCuArb6/jZJ38dg0G5ItWpVNWomSDJeT4Izwrb8tPRQ9h0cZ1KtCp
         AIcQ7yHw0f8uOSQn89Du94eAR2+Zcxm+O/vFYKKSrfuDr+xYg2yd9y3Wzeb014r8YBSM
         SfkIHYxBWBeGS5H0kbdB9jGIi5KN8Xf0lXzP2GDSSWfWArKTKstnGvvbYWDQ8XYl2tp9
         Ny7vcuBtlpauQXWaHSQKZ1vDSSjJbM7khaIwjZRV8nhkggMiXHSxwTcYy12BeFVCNkuX
         yp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099880; x=1715704680;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq3E+hsLGSN+5MIZB3XZU6auyIYe/okJXkhSxXH/gFE=;
        b=MXxJgS9HxSXkLVsaAtC+OlsyOJaPN9Od+xuuCG0aPDRdKeOOjX3Xth3d2Jm9jlQVmO
         LhS7urgZMWUus08AppxZ0JOUJemvMO8K9erj+HXDX2tv4nlYQ8TVnzY+iVPuHce8Y1kK
         cnVqqyy1CgirRU2kWkdeMgSC/E5cYyGuNJdqogF10vteFMLVTJFPr7fK5fwfz3v/66pD
         D8eBeYs1yxk8s+fww9B28yM6UMEoamF5+tMA7tyCPHFjTykRZiGKeWd/aZ9FfrVx0y23
         13e0jLKXM+x4JioY3HMDpLDroQ0abdiYheFS1UGeYuJ1Fcdci0+BjkSCTyrFYb/7X72P
         U6rw==
X-Forwarded-Encrypted: i=1; AJvYcCV9rSGVf5CQU8Q+ynwV7C+G746LnqytfhlFyn7X9sNXneHFwQJ5EANE3rQRkbuoXurFZbFjgWDetmkiOtXuor78syMIHdXF
X-Gm-Message-State: AOJu0YwYzHwZDVanf3GeQ3gyAic7R1/0TIoILggwmpJ5lGXaxXtixhCU
	I93PN/IwGRufCEKsq9do9rfNe73ha8czZtdY6qZYtt5zOnJG3fMggHLSACIMNKE=
X-Google-Smtp-Source: AGHT+IE2aO/S3bXjWgK34KH3T6cSRhii++OQmAOeSN/94L/Njsbgg11/GQF1S4tybMrwZYT6KHLiBA==
X-Received: by 2002:a05:6808:8f7:b0:3c9:68d4:22a7 with SMTP id 5614622812f47-3c9852d2f46mr91679b6e.35.1715099880581;
        Tue, 07 May 2024 09:38:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id v2-20020a0cf902000000b0069b69c5f077sm4766905qvn.102.2024.05.07.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:37:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4NpH-0001Wi-6r;
	Tue, 07 May 2024 13:37:59 -0300
Date: Tue, 7 May 2024 13:37:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Konstantin Taranov <kotaranov@microsoft.com>,
	Brian Baboch <brian.baboch@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"florent.fourcot@wifirst.fr" <florent.fourcot@wifirst.fr>,
	"brian.baboch@wifirst.fr" <brian.baboch@wifirst.fr>
Subject: Re: Excessive memory usage when infiniband config is enabled
Message-ID: <20240507163759.GF4718@ziepe.ca>
References: <2b4f7f6e-9fe5-43a4-b62e-6e42be67d1d9@gmail.com>
 <20240507112730.GB78961@unreal>
 <8992c811-f8d9-4c95-8931-ee4a836d757e@gmail.com>
 <PAXPR83MB0557451B4EA24A7D2800DF6AB4E42@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <fa606d14-c35b-4d27-95fe-93e2192f1f52@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa606d14-c35b-4d27-95fe-93e2192f1f52@linux.dev>

On Tue, May 07, 2024 at 05:24:51PM +0200, Zhu Yanjun wrote:
> 在 2024/5/7 15:32, Konstantin Taranov 写道:
> > > Hello Leon,
> > > 
> > > I feel that it's a bug because I don't understand why is this module/option
> > > allocating 6GB of RAM without any explicit configuration or usage from us.
> > > It's also worth mentioning that we are using the default linux-image from
> > > Debian bookworm, and it took us a long time to understand the reason
> > > behind this memory increase by bisecting the kernel's config file.
> > > Moreover the documentation of the module doesn't mention anything
> > > regarding additional memory usage, we're talking about an increase of 6Gb
> > > which is huge since we're not using the option.
> > > So is that an expected behavior, to have this much increase in the memory
> > > consumption, when activating the RDMA option even if we're not using it ? If
> > > that's the case, perhaps it would be good to mention this in the
> > > documentation.
> > > 
> > > Thank you
> > > 
> > 
> > Hi Brian,
> > 
> > I do not think it is a bug. The high memory usage seems to come from these lines:
> > 	rsrc_size = irdma_calc_mem_rsrc_size(rf);
> > 	rf->mem_rsrc = vzalloc(rsrc_size);
> 
> Exactly. The memory usage is related with the number of QP.
> When on irdma, the Queue Pairs is 4092, Completion Queues is 8189, the
> memory usage is about 4194302.
> 
> The command "modprobe irdma limits_sel" will change QP numbers.
> 0 means minimum, up to 124 QPs.
> 
> Please use the command "modprobe irdma limits_sel=0" to make tests.
> Please let us know the test results.

It seems like a really unfortunate design choice in this driver to not
have dynamic memory allocation.

Burning 6G on every server that has your HW, regardless if any RDMA
apps are run, seems completely excessive.

Jason

