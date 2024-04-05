Return-Path: <stable+bounces-36158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD6789A5F3
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 23:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A22283469
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71763174EF5;
	Fri,  5 Apr 2024 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUw5HXKk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299EB1DA32
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351465; cv=none; b=DMMVMfaFC+G5pYbk6MdL+sX25OG8RTqBYXwaT8kAc7JNmaKohJJEezHhOmIYcaJlNRexdDFasSU7+nb9+EuOLARdTVK1al4CG75dT/pQnApAiXTcrg4PKQH2RqXZLYQoIspHcw4z5vzT5OHVVJgZCJqgF5rgdDBCC7Kni12n1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351465; c=relaxed/simple;
	bh=gG7QCupzZcdNLVSnPGpXsTkJhgCvn3H0xsGFMy+Ti0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VPSY5HENAGFhQGy/cTTA3dpGfu+p8i6A2nVlbcJmQC0R4y9e6nEGhZ+JQk5+s1YjICCz+OJO0MaVrkLrCJPmJnHgBfqqnDXaOijzw7PALYKiKVhx+sZ0v6ktYQgNxpgbdT+QIK7Ju213ud4PG82HEfUkX0soFGvY34EdmF5u0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUw5HXKk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712351463; x=1743887463;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=gG7QCupzZcdNLVSnPGpXsTkJhgCvn3H0xsGFMy+Ti0E=;
  b=GUw5HXKkDUc/qJSjaHzYwkWqSNi4XYhSJF2Lo9mSRzyrBQ+82aRtHjoB
   OUS/67Y9Wn2yI21khhhkUpZQTBRyaxZwPnAjJudLliIgApunv+NCsh4/A
   uUv/pzqN++1XhoREF9bti+Csvk1eu5D0Z/B9j7vwb2Cmye2dwdXZYHqFw
   ITT/Wx2RBOzb1tHwBK1lCtJtkteJYwavHDvzvrUflnWcxOg7Ch14HQBxC
   Den8mq3XdzVw2c2Dg4kVFOxlhup9KlcdT2K0b/0guhe7piR6H2QcLBVOf
   aq3QTR7b50rwamjlMOiNJnQkpGtCPWJQjOsOLeHYo7fqC9b7g4AufBs3H
   A==;
X-CSE-ConnectionGUID: fTnqAcG4RyqdnHSUvfY+Rw==
X-CSE-MsgGUID: HR6K4nycSiKFOPEiMTH9TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18262993"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="18262993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 14:11:03 -0700
X-CSE-ConnectionGUID: mt/OdeRHRP+2QsUMdKEq8g==
X-CSE-MsgGUID: rrXJgKYYTIaos6HLxomsKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="56761506"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Apr 2024 14:11:02 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsqpv-0002iQ-0C;
	Fri, 05 Apr 2024 21:10:59 +0000
Date: Sat, 6 Apr 2024 05:10:21 +0800
From: kernel test robot <lkp@intel.com>
To: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] ext4: fix i_data_sem unlock order in
 ext4_ind_migrate()
Message-ID: <ZhBovSEZahi5bvEy@92629a18465e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405210803.9152-1-mish.uxin2012@yandex.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Link: https://lore.kernel.org/stable/20240405210803.9152-1-mish.uxin2012%40yandex.ru

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




