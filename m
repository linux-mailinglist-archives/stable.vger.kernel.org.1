Return-Path: <stable+bounces-182906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3820BAFC91
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 11:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158147B10AF
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 09:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6843279782;
	Wed,  1 Oct 2025 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="RXDWkZy1"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD0239E67;
	Wed,  1 Oct 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759309683; cv=none; b=n/cw6bjHKFAQa/p71JPH89bhegq/hfGE1CvANRPjWssjwpAwCp1NR+lJ6BG3jQ8WrZJS2WMnEPcGtHI+l/DTb2D3XOeUUCWWhshjnhwRdtxsu36T/5Wip4BfMVMJmZwSWpQgb9eD0v/bLEF9LW9ffLTcamOWa664vjpSB6x4hCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759309683; c=relaxed/simple;
	bh=mzA2wfqe4qhLk9P03nBHLrjAgyXRLL77w450Dy43nQk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMj/tMyC2LbK+FqzF3jzgGhg3J2J81RcaHn6psLRWM/hHmaN7BV0o7iUgBSZa9v+sAp59HDvH2DTXfMU1XOa9PbYUGNyclQ4TGbfND+DprBxyyMxn1gadNZW+2a+8U8zbmBwdmcoQJNZTHvPJhGPhTY8/bJPjy7Qs5VQqdv5bxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=RXDWkZy1; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759309682; x=1790845682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+nXW15w+7dBN6EUXm7aFj+3+vhO7ZTN7faFbVeZpUQ=;
  b=RXDWkZy1pwJbG1OnCX2sDZl03JGCOiWeWpOpoZQPlLouzidgHWaFYRUG
   TxQkSmIRUnrNtb18mIVHdVPVXWdqTtu+eioz503/OLma3+8ZyVDpCrbeA
   uYNHRgrwq/aToo4SklbQVYtBT3nz/aCPk5ABjiPZ1Rk8DAXXZxl+6CUqi
   GX3m+0HJX8ung+lYW341rdT95LThZ6/4VXvqpq0nA+WfGIWSYakOdKNhH
   X9HTZWkFaiPf1uaXIJcM5Z6+JfsQno1e2O1GPIarDpsY4/TZn9h2+wziP
   rFCz0U72+O7rR5h6yKhMfWh7HztaPmR9EyaFpurfix/Iu1rqnMTuvCFEz
   w==;
X-CSE-ConnectionGUID: 92LAiI7pQ+aZpl4wa2XNgA==
X-CSE-MsgGUID: vs7DOnDiQkCkBcYNAumq0Q==
X-IronPort-AV: E=Sophos;i="6.18,306,1751241600"; 
   d="scan'208";a="4068769"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 09:08:00 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:7533]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.10:2525] with esmtp (Farcaster)
 id 56bfb667-8496-4537-9162-31c05f1cace1; Wed, 1 Oct 2025 09:08:00 +0000 (UTC)
X-Farcaster-Flow-ID: 56bfb667-8496-4537-9162-31c05f1cace1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 1 Oct 2025 09:07:59 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 1 Oct 2025
 09:07:58 +0000
Date: Wed, 1 Oct 2025 09:07:55 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: David Hildenbrand <david@redhat.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Xu Xin
	<xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Peter Xu
	<peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mm/ksm: fix flag-dropping behavior in ksm_madvise
Message-ID: <20251001090755.GA66706@dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com>
References: <20250930130023.60106-1-acsjakub@amazon.de>
 <85f852f9-8577-4230-adc7-c52e7f479454@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85f852f9-8577-4230-adc7-c52e7f479454@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Tue, Sep 30, 2025 at 05:32:25PM +0200, David Hildenbrand wrote:
> If we want a smaller patch for easier backporting, we could split
> off the VM_MERGEABLE change into a separate patch and do all the
> other ones for consistency in another
> 
> Reading what we do VM_HIGH_ARCH_BIT_* , we use BIT(), which does
> 
> 	#define BIT(nr)		(UL(1) << (nr))
> 
> So likely we should just clean it all up an use e.g.,
> 
> #define VM_NONE		0
> #define VM_READ		BIT(0)
> #define VM_WRITE	BIT(1)
> 
> etc.
> 
> So likely it's best to do in a first fix
> 	#define VM_MERGEABLE	BIT(31)
> 
> And in a follow-up cleanup patch convert all the other ones.

Sent in v3: 
https://lore.kernel.org/all/20251001090353.57523-1-acsjakub@amazon.de/

It's the first time I sent a series, please let me know if I did
something wrong :)

> 
> Sorry for not thinking about BIT() earlier
> 

No worries :)

Kind Regards,
Jakub



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


