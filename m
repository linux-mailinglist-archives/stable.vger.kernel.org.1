Return-Path: <stable+bounces-96199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB8B9E1454
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64D8280E13
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330FD2500BD;
	Tue,  3 Dec 2024 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ddfl1Jau"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8702F5A
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211299; cv=none; b=h1xHzdlI0TFMChdcgj3rSenjgrXIzVPFU7e7MidBDS59/SVJZ516PU0+20zVmjWZAbSXihN+lv3XdlS78NPaRDfOkgVwgZoP6IK2b98Tbbu7nDptYGFw0BahyhMEKkxmkicdCmjhBodv1tXH+QaHonl87vsqPUjwew2Ll2HMZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211299; c=relaxed/simple;
	bh=DwfZQrGvNAgEk+BXTXx5LwvIRL/EbV1dof/TeTyYfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lYrDn2uoW8DacEtGwz+ToDMO4NBPnDs2o38y7sZ3tbrTtraUEbDoV1aI72Bx87V4Ay1LENtV15FQ6ONtMsDsaCYjmD9fFjsmXtBxrEvwZQAXXNo76yUfidNIiJdwcX/QR35gKuiWEiljZ/nKZA8nS5ezIK5vwi+VG2uZbIDN4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ddfl1Jau; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733211297; x=1764747297;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=DwfZQrGvNAgEk+BXTXx5LwvIRL/EbV1dof/TeTyYfsQ=;
  b=Ddfl1JaupO45SeHERuAVOYGmdk4Z8Ra/tvzgsLwMNlPKFth9XH6R0iP+
   lIKpJIz/cFDPs4k7Y4kRU2DUVzYuSr/CXrvvAzQ66Bc+MdJOFdP1SN7/V
   7Db0QjW0a/lSHZdnmR+ZNL/v8TV8xa4JJNrZLrMdi07Or8oUCrlYk1YoF
   KwRdQVpCx/0T1PbNkQ+wuspTRt8oc7sGdd7+Ro+D+A0Sh06q6zScqNDMF
   cpCyH+dDLqBA6AWZdTIfxlM4VbkEBW6DYervPoGhhvK0Ty8nwNr7iMtlF
   b5FYRSLrTyS7afMZWpilJHEjZyhZ3WL22BnpWO1bsVliMwjSF4No7LIdD
   A==;
X-CSE-ConnectionGUID: B8Koh3jOSxayuclfZS3SpQ==
X-CSE-MsgGUID: 9P/+BffSQ3e77r/zwi2JiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32765504"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="32765504"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:34:57 -0800
X-CSE-ConnectionGUID: MLLViTuOS0ucpUCSRS2XMQ==
X-CSE-MsgGUID: f5JUmM01QkWzGeCkCiODkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="130815795"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Dec 2024 23:34:56 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tINQr-0000HC-2l;
	Tue, 03 Dec 2024 07:34:53 +0000
Date: Tue, 3 Dec 2024 15:34:11 +0800
From: kernel test robot <lkp@intel.com>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next v2 2/5] virtio_ring: add 'flushed' as an
 argument to virtqueue_resize()
Message-ID: <Z060c-djhGZsC1c3@ff21b5d8d570>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203073025.67065-3-koichiro.den@canonical.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net-next v2 2/5] virtio_ring: add 'flushed' as an argument to virtqueue_resize()
Link: https://lore.kernel.org/stable/20241203073025.67065-3-koichiro.den%40canonical.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




