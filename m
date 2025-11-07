Return-Path: <stable+bounces-192680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 522B4C3E62F
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 04:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618794E88C7
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 03:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C4828003A;
	Fri,  7 Nov 2025 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzFuZOYY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC032227599
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486872; cv=none; b=PvTRnu/QTl6QaxrQolgmmTuc094g0+G6tVH6XO7AQqRaHWsdFfztkv6Z5PGesvDLfNHAvp+rqYSOn4lrap3/gClYZh9MVBor5NxAhHQeG+wJAvX34KCpckDaWrYXjTpq1AbOh/9/vX4V94oXbBm2T/97h4cYJKmm7arzxgFOo/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486872; c=relaxed/simple;
	bh=s4gDsQXTGLmkO86GK80L1Mh9JJwBgH9BfFIwQ8B9k2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pQ8bU4wW+lMysFryEryDXuLFVMYBSffL3ggLlmC9ashZ8RA31Lr0xW/zVHygNA1HHrljP3MkUDvLCsTzLh+//TwLPp/cyOzrffyd8+Yw3uR9VcsitWu7DwmXXKKbUZeAkSSRfmRGcx67G9JhFwQcr+JIU3Za7Xba0DKsCH0FOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzFuZOYY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762486871; x=1794022871;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=s4gDsQXTGLmkO86GK80L1Mh9JJwBgH9BfFIwQ8B9k2M=;
  b=UzFuZOYYWoCwn1nWyYdzEwdeh4zt1WkBmthbzUcdktzf67NuWi0KApWs
   u4BbVypP5WUbYozn5ropY/C7rX4pcTxYEvU1YJCJyQAYKORVzO7HoOuHu
   aBLbKBJgzBy4nbAJ9f5M+MOYXb+QcDsZ6k/gdDzhGK4FfKx0NMUEYTJzP
   1zz0BOTh2M0K3ra1vto8Rt5/wwQAJLTatzNPI5otOA1TQxkQ6fZJotxQc
   WRvQ9D6po7HnG1YXVVedjNFQ4RML0De3hDFczRx7l7tGD296LlB/PEbTN
   Z6kPayH/1tyyM5nZYvKh3nteCNKDBFJZgvGcZls0ECIyAbM4vnuiP1V+q
   Q==;
X-CSE-ConnectionGUID: VgsoFDZZTFWBNBRqb3XpPg==
X-CSE-MsgGUID: hwGlSqrNRjaalTKxGcwQuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="63844860"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="63844860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 19:41:09 -0800
X-CSE-ConnectionGUID: IcqZYJ5ZSXykh/6Za6enVg==
X-CSE-MsgGUID: 3fFEqD7hQGeSAy3/e0nnfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="192200538"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Nov 2025 19:41:07 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vHDLW-000Ufg-0D;
	Fri, 07 Nov 2025 03:41:06 +0000
Date: Fri, 7 Nov 2025 11:40:59 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 1/2] Bluetooth: qca: Fix delayed hw_error handling due
 to missing wakeup during SSR
Message-ID: <aQ1qS9-MyXH-N5Jx@4b976af397a4>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107033924.3707495-2-quic_shuaz@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 1/2] Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup during SSR
Link: https://lore.kernel.org/stable/20251107033924.3707495-2-quic_shuaz%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




