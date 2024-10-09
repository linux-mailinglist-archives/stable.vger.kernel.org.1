Return-Path: <stable+bounces-83218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E832B996C66
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7511C209B3
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B03198E83;
	Wed,  9 Oct 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SoWsRSuI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF333CD2
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481207; cv=none; b=UrXUTNJCg3VeXoJv/z01luDIy6A5mx/OB6WhVtvy1NtVMxU8go2cqgCVKrVK31CBpIyskneG1bs6GG0uKgfmHsXA+naDHq5wKp1vZS6ceAIQQu2NiTBFihaL1Si86+5OMJB4Dc48bVfzeaZ65tcvjhFPHMqzb9I8JxI+0blUoxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481207; c=relaxed/simple;
	bh=eGQ9JgqGVrwJY3mrgu04xhJ/sCOafI0xQMgik9kN2qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyI6zoaKkhwaIncY9MPSS/mNgxQj1s9yQvXvVoamPsR5BJaB5y+xOd4I5mpuOAVaNhNzX9OHZ9ePgR95UbYK7LO3LOZSYWPm2oQ1f8CtJgED57wzQ5IjY34qObAf7R3lrnRwmpFfJdYq4peQMtg9JGzYjVs+RrgXfi5qLKmeCsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SoWsRSuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AEFC4CEC5;
	Wed,  9 Oct 2024 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728481207;
	bh=eGQ9JgqGVrwJY3mrgu04xhJ/sCOafI0xQMgik9kN2qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoWsRSuItSXc07XGkPdxjYXSXv11uEXcjCasMAf2tgRrtTFaruVrCUtarNpgFT33n
	 MZCM89GaNBbLE/4r/UwJii4Q8er0pWZ583WAYcd5R83ZfGDvPbDLHGKiPeT0cH2t23
	 ujB3RocgE5UG7bvmre+Hlt/c3TAAb8LpELCfWjxk=
Date: Wed, 9 Oct 2024 15:40:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huang Ying <ying.huang@intel.com>
Cc: stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10.y] resource: fix region_intersects() vs
 add_memory_driver_managed()
Message-ID: <2024100930-childcare-kindred-1f46@gregkh>
References: <2024100732-disinfect-spied-83fc@gregkh>
 <20241009011035.728697-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009011035.728697-1-ying.huang@intel.com>

On Wed, Oct 09, 2024 at 09:10:35AM +0800, Huang Ying wrote:
> On a system with CXL memory, the resource tree (/proc/iomem) related to
> CXL memory may look like something as follows.

<snip>

You forgot to list what the git id of this commit in Linus's tree is :(

Please fix up and resend all backports with that information.

thanks,

greg k-h

