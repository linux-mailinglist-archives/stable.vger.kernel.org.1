Return-Path: <stable+bounces-121262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31A3A54F2A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4203B473B
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9276211713;
	Thu,  6 Mar 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVdFBJAv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B420F08C;
	Thu,  6 Mar 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274934; cv=none; b=FCPqSVFWN7UFpTtSKJBEqgU3NF9tqZDGLk3JMKTQDeRAuFRuObkV96YkuRzH2Ed6aK9rBX9mwFTE+mJCQET5KyWromjMnOBxa/rOQBS8pCCU3ycsDxxcH+wp3VfB2sIrdK7KG2k7fu7otUTD5MYwEgcNvlBrkasQZXxtiwLhgJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274934; c=relaxed/simple;
	bh=aQePbAYdZXrXbAi42yBry4e/Wzyfvuk6yi8cLF4DVrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBc/QcXudW9BNAulT4aGTO07ORU8TyL7xxanRzwRlTt4jH9A4ANslJRPfrjhRTSUOBsU7y1IVQKhCyWFSlCMAOuGnf8s6k1pEb8dalwRKRcGUifMlRdc4rS+ETt3MAnpvJAdniFuX3ilEKptK/fNv0Pspdj6hxRCx99xw97Smi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVdFBJAv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741274932; x=1772810932;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aQePbAYdZXrXbAi42yBry4e/Wzyfvuk6yi8cLF4DVrA=;
  b=JVdFBJAv/2+8QabO0JHgPEWeZKXiD1cI9bWryE+p/Z/F+mPrIAndgecw
   cFkATHQFOPcGdzU37e/BjjuC/wG19jb2DBEQAmSO0Mo6hOd9xUJd1uu8y
   nw+TdhybFEr0SV1inODwhZaIUyfeIDsTygnQA0DlkT0H+Nqpt2FbBe6UJ
   YphCkzizLiNMfvjNQsdR4KQJe+8Q6neFDOk36fg0VVTuLUeVxVy731WKn
   pMuuYx0XTRm/a6zBlo+MEZcSdMyOqCvT1wBuv76NSuymNRY6MMJnP7xiw
   JXHSFcXHp1VZGAPTOgLNcbyqGTRGbJtVV8uyLoWIqofCHnWhn31pany1y
   A==;
X-CSE-ConnectionGUID: gprz+VCuSwGtTAS0K3qxZg==
X-CSE-MsgGUID: yddHbs4ATeOMNEr3JVHDVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52934889"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52934889"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 07:28:29 -0800
X-CSE-ConnectionGUID: kUJrh9qhSHSEAUO6xIXRkQ==
X-CSE-MsgGUID: Q1S6lfyHTLi8Yj4rLsKI5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119058098"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa006.jf.intel.com with ESMTP; 06 Mar 2025 07:28:28 -0800
Message-ID: <22876af7-4f9a-40ce-aa9d-2bcab89ce8ae@linux.intel.com>
Date: Thu, 6 Mar 2025 17:29:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] usb: xhci: Don't skip on Stopped - Length Invalid
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
 stable@vger.kernel.org
References: <20250306144954.3507700-1-mathias.nyman@linux.intel.com>
 <20250306144954.3507700-4-mathias.nyman@linux.intel.com>
 <2025030611-twister-synapse-8a99@gregkh>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <2025030611-twister-synapse-8a99@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6.3.2025 16.52, Greg KH wrote:
> On Thu, Mar 06, 2025 at 04:49:42PM +0200, Mathias Nyman wrote:
> Why is a patch cc: stable burried here in a series for linux-next?  It
> will be many many weeks before it gets out to anyone else, is that
> intentional?
> 
> Same for the other commit in this series tagged that way.

These are both kind of half theoretical issues that have been
around for years without more complaints. No need to rush them to
stable. Balance between regression risk vs adding them to stable.

This patch for example states:

"I had no luck producing this sequence of completion events so there
  is no compelling demonstration of any resulting disaster. It may be
  a very rare, obscure condition. The sole motivation for this patch
  is that if such unlikely event does occur, I'd rather risk reporting
  a cancelled partially done isoc frame as empty than gamble with UA"

Thanks
Mathias


