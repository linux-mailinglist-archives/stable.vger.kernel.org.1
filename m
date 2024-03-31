Return-Path: <stable+bounces-33870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FAA893604
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 23:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF9EB21067
	for <lists+stable@lfdr.de>; Sun, 31 Mar 2024 21:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F6145FF0;
	Sun, 31 Mar 2024 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBO5O64K"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C81E521
	for <stable@vger.kernel.org>; Sun, 31 Mar 2024 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711922025; cv=none; b=jbVYJh8lhUidH6V+Pm8UgEBbSxXhtMBbIPpjSLDR+TcYkYMs9Vl0ydnRFFqvK2/e4ot6xw0zBAOrJ8FhCOCSvi3YH0S156p8AO/2001dnrOgNrEy4+ko4gQfcALSYlx7qLgHogrwGbzqEUR0meyqTnNYdFyP0DlM/IATz4tKbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711922025; c=relaxed/simple;
	bh=iUjp/GuKJIkRs21rfS8tj1eku0kuRdLcqfM9/gF2pLg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hOpH22uG5smv9tJvdxRghXhkvFwO/xqnuB9Q7K2r8qAC4DMe3vrOyL5mHhnwSXET4UStTJt694edMKffKXA0b2OTYCOvJHHLD2LM12pPoMSDYqV8JoyaJI4ctEZBvyhoW98KvQCnXioEbydZM5Xx/zeq4GHuYB55yZqdmWqgqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBO5O64K; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711922023; x=1743458023;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=iUjp/GuKJIkRs21rfS8tj1eku0kuRdLcqfM9/gF2pLg=;
  b=RBO5O64KxcUZrUnMsUyMCRbiUFIPpFx7yZuwSVWQtnad7FIBT8KnN8DW
   mXKih83/IWsamHgocQDnNDUlW+CrbTEXcoi0l7jyKnr49oPGr41sVjOf2
   ViIIiNbQg4LBMs+eiK1EwDTcoAjxFPcIrhdDC90tt1a6uKwYkjeYZkdko
   kxayWqFJM7TU9Fu9C9fqD5S+/kzkswAWCVyn4JPSPJwhEGDy2U95kB9Fm
   2mu1gfgSCWJaIzdojLJBiDxZQTLull7tx1LhAxeyHDBPYfk2mucf9lOs6
   8Xm61mMTpiZULl9DD7uXIE54njg3PZldOxRqZCBCZTiyKrgQ3hQOjxsmr
   A==;
X-CSE-ConnectionGUID: MC7DBwMaQOKq7UXuZPDQZg==
X-CSE-MsgGUID: QCS/5qSUQIWgmgkE0ld5iQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6936888"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6936888"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 14:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="22202449"
Received: from lkp-server01.sh.intel.com (HELO 3d808bfd2502) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 31 Mar 2024 14:53:42 -0700
Received: from kbuild by 3d808bfd2502 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rr37T-0001RG-0K;
	Sun, 31 Mar 2024 21:53:39 +0000
Date: Mon, 1 Apr 2024 05:53:19 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] aio: Fix null ptr deref in aio_complete() wakeup
Message-ID: <ZgnbTzVKNnsBkWGJ@ef6127956eaa>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331215212.522544-1-kent.overstreet@linux.dev>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] aio: Fix null ptr deref in aio_complete() wakeup
Link: https://lore.kernel.org/stable/20240331215212.522544-1-kent.overstreet%40linux.dev

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




