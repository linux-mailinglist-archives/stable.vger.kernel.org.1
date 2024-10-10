Return-Path: <stable+bounces-83288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16DA99799A
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 02:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A971F22BBF
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147729A2;
	Thu, 10 Oct 2024 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjNkqLuC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273DB1DFCB
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 00:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520177; cv=none; b=dYux8CNgB9hL93AcwmUBlOLPm6BbP191I68uQSe2r5789YFBPJUBXJ+L/BkiH/0PBbG0hSGKNXWABrFc+WlVQ6+mZVJQh89WpncjB1yTSCyMu1UU7vpx44ueD8/RB9rbloyZiZ0YLo6agkVmaPKcELhx0Sk27nDxkmvSFBBmGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520177; c=relaxed/simple;
	bh=3oQhAQ1sSuDs5zDVha5yOqu43kWiECfAIG2YKgAiggE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bi8lwKwxgbKXLCXPjpl6/rEbrrxUsNMOQRdWkpOLX6OB0XnzsAUn1zZ9BrsuDgRYR8g4ASKHhyd494vfb/F1K24G2GsWBRQxzE+OKfPGfl9aOWqG9ZoD6J+2fD0D4mGBlbwGe9+1eJSc76nBa/Bva7C4VwqZaxUSpLF8PDq2CBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjNkqLuC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728520175; x=1760056175;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3oQhAQ1sSuDs5zDVha5yOqu43kWiECfAIG2YKgAiggE=;
  b=NjNkqLuCKRC0SDjKiMwCdNJqB4ALqykw/ayrKC3eK+W05FH/RD6CiXxX
   9T73HMS30Tnskv+XRFfn6X3C+zhonZyAH4zk0nSaEG8iK9mGUPnVN5TLq
   TGkALwAy1+3hoVzQhOo9LejpfgNpppbuRo+matZxcElSkomqq3qWrWY4q
   45vgEmZYpEwXyPfZhX8Qzbz9jvm0MZk/LXKdAtdYuNthrYN/qOGgHFRgw
   nnEwu9ZyI0S1iqqHfHnSZquxTU3FaMYDW9EJflF77weOJI4CMmGn1mM9/
   ILxCTwtVs+AxS92cz+NeKW+c1oQyol7aaSI4ByJUFMpZWE1vUoIcWLUKc
   w==;
X-CSE-ConnectionGUID: RC+0cUVPTPqpYYBx109TuA==
X-CSE-MsgGUID: NP9ADT/jQoimY0SR5EBCpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38498875"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="38498875"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 17:29:35 -0700
X-CSE-ConnectionGUID: IkKUJFvSQUeIjf4mobqZDA==
X-CSE-MsgGUID: jiyyoIYkR8eYOWEkl/HVEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="80981569"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 17:29:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,  Dan Williams <dan.j.williams@intel.com>,  David
 Hildenbrand <david@redhat.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Dave Jiang
 <dave.jiang@intel.com>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Alistair Popple <apopple@nvidia.com>,  Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas
 <bhelgaas@google.com>,  Baoquan He <bhe@redhat.com>,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10.y] resource: fix region_intersects() vs
 add_memory_driver_managed()
In-Reply-To: <2024100930-childcare-kindred-1f46@gregkh> (Greg KH's message of
	"Wed, 9 Oct 2024 15:40:04 +0200")
References: <2024100732-disinfect-spied-83fc@gregkh>
	<20241009011035.728697-1-ying.huang@intel.com>
	<2024100930-childcare-kindred-1f46@gregkh>
Date: Thu, 10 Oct 2024 08:25:58 +0800
Message-ID: <87bjzsn6qx.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Oct 09, 2024 at 09:10:35AM +0800, Huang Ying wrote:
>> On a system with CXL memory, the resource tree (/proc/iomem) related to
>> CXL memory may look like something as follows.
>
> <snip>
>
> You forgot to list what the git id of this commit in Linus's tree is :(

Sorry about that!

> Please fix up and resend all backports with that information.

Sure.  Will do that.

--
Best Regards,
Huang, Ying

