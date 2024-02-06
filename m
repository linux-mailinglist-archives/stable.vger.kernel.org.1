Return-Path: <stable+bounces-19005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EA84BCF6
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 19:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48117B22077
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A36AA0;
	Tue,  6 Feb 2024 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xa4FWO0z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F0F134CE
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244296; cv=none; b=N0M/xtPacM62x7rcLLVC1ymYL1XA0HCj7ARXqZ6nUf5NbrbC7jmr5/iFZ7eMEfvOEJIbH+PLdSDQXNZ2OiWRYIdRn5xHFiME0EzN4VyqiGd1tdaBqvUUCkaJr+89713nAqmbtx7H/Jhjg1uWH7N2eNrAlp2hrtSVJbDg5e5YanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244296; c=relaxed/simple;
	bh=pmWezV8DDfkcSOpsm6toLBHNZtcKWNcg72DZzuPaLyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kiIN8WnJ5qrIibTVGy8exNzuXMI8vmjmohrpYCe+hCZIp346hTb62EPSfgLVTt3zFNzEccnIlOuPeOAzxnmPRfT/4EHcNA1mtMP1RJmwRcb4DfnLyixbkRQXWivA97DevX4SX45Bv5s6Ywc39O+I+OBEXdyy0rmH6FnZRB3bScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xa4FWO0z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707244295; x=1738780295;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=pmWezV8DDfkcSOpsm6toLBHNZtcKWNcg72DZzuPaLyc=;
  b=Xa4FWO0zqEO8Ngqw9S8P5LIXNMv2qn08RC5YW8JM/y+kKjwpOskkdbta
   27MGskfDmpTPLN2YbrfXxF+VSAl+arR1ZoUFTX92XxOTfVZWlxF68scRI
   7d69syKqLc07T9+Zz7ghm5k/eDqBWQ4cVJhQ7QGctOt5hKpgf1/neSrIY
   AXVD97YCsgjFL0a5N0RnyYJswkugTV84AVuNVlStDQf/NJ7Gnov9Mycl8
   F1FG9c3bcQhQL/m7qjX+8RUvw22UCrqXDvy1JFApV/1VLiA8ptERNnzi8
   6lF+hNnx7m3En/yMNqyT5THKzybMn30Y+pCKPVZl3VcC13ywu4m9tyNuq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="979599"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="979599"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 10:31:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1097177"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Feb 2024 10:31:16 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXQDx-0001ge-1u;
	Tue, 06 Feb 2024 18:31:13 +0000
Date: Wed, 7 Feb 2024 02:30:24 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
Message-ID: <ZcJ6wN-EhIafZpd7@ddcdc6924185>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206182559.32264-1-ryncsn@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] mm/swap: fix race when skipping swapcache
Link: https://lore.kernel.org/stable/20240206182559.32264-1-ryncsn%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




