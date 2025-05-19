Return-Path: <stable+bounces-144872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD53BABC149
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B27F3AF4E8
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E528467D;
	Mon, 19 May 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpJh8D1L"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942BB8634A
	for <stable@vger.kernel.org>; Mon, 19 May 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666179; cv=none; b=YBkJzJ2lZ2E9T9roiWjoYsELfJqwG42W/fdbYwWN8Gm777r7ZQTGJVjU3wV5KbCGDRyjr+L+8A8DqxPE+WOCIWWd/1k9oGVlUgQkDiT3I52DBgDO7QdCi3OOhZyb+g7OaDnvDdN7ponJQuR5DPH4wrcyOo6BIqDqjB9rWBAKvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666179; c=relaxed/simple;
	bh=zMosCpXMZg9Kwf+8UHJ16nJVF7aQJvW5XabpAHbqxKc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Fqf6YOkAPpqcUvOSl9QtS7k8l+ngtVhuSUUWVKFQXxTJ13xJuVExvao5Jez9IARe31y1jtnXTUeNJdCyM4r6SNR3ly8/dN4lZqs/RT6F1XbYrVTgXNwjh5ApDU9rbsyhWUZK89S3pdIJh2/QJun70p/e/u9GTJd1vpE+e99goaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpJh8D1L; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747666177; x=1779202177;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=zMosCpXMZg9Kwf+8UHJ16nJVF7aQJvW5XabpAHbqxKc=;
  b=VpJh8D1LHgAQ9TitbjC8viJ4383F93CIMrtI+bORQB+O3QWoIU6n/k4s
   2JH3IV4GyFdFwlVPrrc+2Pphc7ZXAJKUblgL8dagxGO3EibZ5ZNpUSRl6
   TofK9511LlgPRe/9B4is3vyT0gyorelBDOY+u1uXrmfijq8bKJ3HSauqf
   xGjZseXQJvFlPByalIyuBovRWXZYKofRkvGwIDVK8yC5NADIA1GTtDYXZ
   2IFr/NXy/TSw3rxVSLWs0UGSDTL5uNYYlNAa/4+mpBY6uKlN4brhu0ahQ
   k8z3qSQB5pO4zHklGpfLCayiSIP9IlVz7A0ez7AO057Fa3OQMCpwIJArY
   A==;
X-CSE-ConnectionGUID: 1f/d7+OFSwedSjnc/5UDHA==
X-CSE-MsgGUID: 3sqwmaQuRxqKk78D/d6zlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49707593"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49707593"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 07:49:37 -0700
X-CSE-ConnectionGUID: UBPQZA0TSku2j5Kw6iEQ6A==
X-CSE-MsgGUID: lcm2BxzWS6GuVrJkvvTZTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="144644926"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 19 May 2025 07:49:36 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uH1o6-000Laq-0B;
	Mon, 19 May 2025 14:49:34 +0000
Date: Mon, 19 May 2025 22:49:16 +0800
From: kernel test robot <lkp@intel.com>
To: chalianis1@gmail.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] phy: dp83869: fix interrupts issue when using with
 an optical fiber sfp. to correctly clear the interrupts both status
 registers must be read.
Message-ID: <aCtE7CWr28egBglZ@8c81029db2be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519144701.92264-1-chalianis1@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] phy: dp83869: fix interrupts issue when using with an optical fiber sfp. to correctly clear the interrupts both status registers must be read.
Link: https://lore.kernel.org/stable/20250519144701.92264-1-chalianis1%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




