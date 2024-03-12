Return-Path: <stable+bounces-27418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B09878C54
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 02:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B2FB213C3
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 01:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB70A10E6;
	Tue, 12 Mar 2024 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYhAXa0c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCE67494
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207237; cv=none; b=RLyRfQdFtw1dcV11LxPXj6V2ztmWf6x04h6fkH6aVGJXZV35wVWWDfv6HBI3O7F4ODW+NJkHOEiZnF5VvBhqrAqaxzO6zPNcV4BtKdnwpNKYFYTz1Zj2ji0AYeW7+SQUvKiwqlb+Mw6Ebfjzn0EagmY6VluXv0NTAZWeUSUB+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207237; c=relaxed/simple;
	bh=4r6JczK4zI3K74a39D7+iL4uiScxtntnqph+kScT0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5A/GgJC28qPCPc6wqZLrb/fcO/SbwhsqevcQyFxYf1iSdlgyI6zwUYWZhkXjJ7NVEdCxtWUfg5unK/C9GwNAzPvVF/fyhEjgpv5Oo/DVjNTNs9kGugOE80uLSrpWPN3iuW+ovZ8LAEYQJc+0TgdYVMnn1P/fEQYS3AVq5Au89g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYhAXa0c; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710207236; x=1741743236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4r6JczK4zI3K74a39D7+iL4uiScxtntnqph+kScT0CE=;
  b=hYhAXa0c4GqfcWKQckkisI8FlDP7sFjowmbZQhINGah6w5LXfQN9CUO0
   pHlt4te7zQw6akS2I9lhPfLJPxifeA9wvT94zLarWu3LETLd6Csj8g7g7
   8MPlpG/vNbd/ZlLXoNmTu3B13YG41ydxngAcP0r+oOq2BeZcOYAFjhxmq
   CGzj2BYenMhAljoLvPuQsd1EDPs+C/sJes54Pik9PQ0QpkLlUr+2nfO53
   3bcOMS+qANYig4dTOAMaGJ28bvWfarSmrBEZewXq8UPcDeN1kMvC96PrD
   ylqEJQprrcnuj3W1aFHxfi8uIJsYPUGwiXdoFY/jqNv9uaCiaN/bCCu7H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5019135"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="5019135"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 18:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="15929402"
Received: from psdamle-mobl1.amr.corp.intel.com (HELO desk) ([10.255.229.113])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 18:33:54 -0700
Date: Mon, 11 Mar 2024 18:33:38 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: stable@vger.kernel.org, "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/7] x86/asm: Add _ASM_RIP() macro for x86-64 (%rip)
 suffix
Message-ID: <20240312013317.7k6vlhs6iqgxbbru@desk>
References: <20240226122237.198921-1-nik.borisov@suse.com>
 <20240226122237.198921-2-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226122237.198921-2-nik.borisov@suse.com>

On Mon, Feb 26, 2024 at 02:22:31PM +0200, Nikolay Borisov wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> [ Upstream commit 0576d1ed1e153bf34b54097e0561ede382ba88b0 ]

Looks like the correct sha is f87bc8dc7a7c438c70f97b4e51c76a183313272e

> Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
> useful for immediate memory references where one doesn't want gcc
> to possibly use a register indirection as it may in the case of an "m"
> constraint.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20210910195910.2542662-3-hpa@zytor.com
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

