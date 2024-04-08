Return-Path: <stable+bounces-36329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F64089B8F4
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 09:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE0D1F21A4F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 07:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C325722338;
	Mon,  8 Apr 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvbXUeOz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0A524CA
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562192; cv=none; b=VoKxTw8DR7S8IC74AVjvTifPo6TKCvTdoiQVtYpT9Td/MgO1UP+xEvefZBrS48jepebX6Eyo1GLKuxJbocIkJLxUG44MurJyrM/SdrLc9r40T+jmW6p9UqZbPZ13FnlXy0O5yPkDNebe6AYzgMkUTIITctO3AwkmmWSkyP63XaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562192; c=relaxed/simple;
	bh=hGKx87mS30I6i/SFRTfaedfwCqJqwxWtgPG/H2yCvWs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YSKbxQjJ78vEbOMDnFvP+VzCzHvMjm+vYgmGvUlU/17BNieA2TM9wl7nxxReKakI672t6JdJIeJsL2sjfw+2XtuERdf0ojaFNJUmpslJ98Ho8aeIzk8N+E25VORrMHPQnUG9HdNFkxZYTWFL4mae4r62eVe2lTjJUueXMKmaalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvbXUeOz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712562191; x=1744098191;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=hGKx87mS30I6i/SFRTfaedfwCqJqwxWtgPG/H2yCvWs=;
  b=fvbXUeOz3NDjYR1bzHqmPNmqJNDYglE5Kril28O+3MX7j0v+feKCvDD8
   QWSyDZ4ZoJypJK5oGzvwl1ee9SF0/Q+RtgRpkzxyc2X9HZTy5JQ+fisOc
   +4sgMQHXo0DSernyhXPkjfagMLVCdt/HRO79ofWKMw0zQ8rLkU2nyGC7T
   9OX4AGrnjiPaEjYtWQ5R8BmDykE4Yc2bfF6DIfv5avEXeVayVUaL0daF8
   YgXig8nP/G9vIIa7dtMBmv7CiOAb9y1/b5EXfLpGoaCngyCv0tm/uD8XR
   XcnKn7CM0dIWIApoEQFmmKqtetpEABTazzbzMZow2IHA1ikkChDPzg26t
   w==;
X-CSE-ConnectionGUID: E23oIDSeS2KhKBw286VD5Q==
X-CSE-MsgGUID: UW5k1lPrQta51Gk7Xx7SzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11600428"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="11600428"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 00:43:11 -0700
X-CSE-ConnectionGUID: XrnmOACKQhGQJt+f9iuh1g==
X-CSE-MsgGUID: v63TopqOQSOKj5RsHxGntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="42975662"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Apr 2024 00:43:10 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtjel-00053U-1u;
	Mon, 08 Apr 2024 07:43:07 +0000
Date: Mon, 8 Apr 2024 15:42:22 +0800
From: kernel test robot <lkp@intel.com>
To: vsntk18@gmail.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 02/10] x86/sev: Save and print negotiated GHCB
 protocol version
Message-ID: <ZhOf3gYfasVSd-wR@92629a18465e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408074049.7049-3-vsntk18@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v5 02/10] x86/sev: Save and print negotiated GHCB protocol version
Link: https://lore.kernel.org/stable/20240408074049.7049-3-vsntk18%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




