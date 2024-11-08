Return-Path: <stable+bounces-91911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683D09C197B
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 10:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FC283F03
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C181DFE3F;
	Fri,  8 Nov 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcVXJlS7"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEC193060
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059161; cv=none; b=B2CzW7BdecEGKTYGtXOjxtzqCYXBYg/3u1LxQcF3fg/Ucv4iVNUn09j5Lk83QyBWkRyE4ANtA4yDkBp8nOpvRZlAzafp115nDiwson7ogzM+QigqOcTxwe1FgN1BvwZ4riR+fKJgZp/yWemzwEVl+m28ScVLTjEC/+J8BXNlyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059161; c=relaxed/simple;
	bh=XWLHBu5ep21al5qhSca2w9xbi6vzV3nJZox+0jJptQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ttPyOlj28T7x9RCdP4DwfWi2s7P6IQh0ClExRDlEdgKkuhENhtvUQOfQAuFhBOI7MAK/AvhJMFFNW/IGdXq/4D1IvhzB68FBBwT347fo/Ils7KtSCYhpHmeKi27qKrPEwJIU9BkH/EjY08zi59pwdDhijyDoy0nFAhUE9C5UiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcVXJlS7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731059160; x=1762595160;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=XWLHBu5ep21al5qhSca2w9xbi6vzV3nJZox+0jJptQ4=;
  b=lcVXJlS7wPYERYe8pOEo9byjB6kZwlLDQ6gFFzHsSZs93P3MO1PKcpVa
   4UD/k/ve/jGpXMOr/5Tx1B17uYZuVkvp+a3h79khnLDlzMg3oL2t57ZXl
   9Qtp3JAU0aGFtSODDLdBjeb2epTgZLWqgGBncPHRjkFpdEPp8MQUFJR+n
   N0tRkAuJuCQV64ooph4RWcYni8M7WUDPYUftLrpVNdBH+8qByVgETqjCU
   BLfc0v9FxJcnQFE41KdkAdrKDyBekhGJUW703Y/nnVkOJcLNAY4bUxVwx
   xDTcSkeOamfn45jtEk6wCnhKkBqbqmttxllgmnNGCM1ys4z2koUbOxALO
   w==;
X-CSE-ConnectionGUID: 3OsrQYFGRKWB2Hf9BoA6Xg==
X-CSE-MsgGUID: QeJsn8bTRtyBh/4c1O05Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="34874599"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="34874599"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 01:45:59 -0800
X-CSE-ConnectionGUID: QRKrxpKmTdq/iPDGYT3XYw==
X-CSE-MsgGUID: I2o+kIeySZmfMZPv1zd6vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="90119340"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Nov 2024 01:45:58 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9LYy-000rHW-0O;
	Fri, 08 Nov 2024 09:45:56 +0000
Date: Fri, 8 Nov 2024 17:45:26 +0800
From: kernel test robot <lkp@intel.com>
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] USB: core: remove dead code in do_proc_bulk()
Message-ID: <Zy3dtuBq-EPJ1Efo@7253daef1eba>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108094255.2133-1-rex.nie@jaguarmicro.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] USB: core: remove dead code in do_proc_bulk()
Link: https://lore.kernel.org/stable/20241108094255.2133-1-rex.nie%40jaguarmicro.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




