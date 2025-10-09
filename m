Return-Path: <stable+bounces-183674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6FBC81E1
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 10:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615243B88CA
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC12D23A6;
	Thu,  9 Oct 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eu3Zxawj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579182D0C7A
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999640; cv=none; b=jbliVhHnJGIlCHCMRmNQ0JF909DyNQmJWoktjse2ee2yxnfavg3eINknziPrc4LmUidAyNuwxcwTrO7LgyrXpdw0hYsFdx7DRpTaD7/ONud1xGI4V4PFQV2LMSVv7toXVDyKDIHA/FLL26ZNFOmeGXJ6eWPL4VnJxLgehpfZfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999640; c=relaxed/simple;
	bh=t7ELEe4w61rM6xWYOTqFrVYxtgRcsdyr476Zu9Kz1pg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hop8aqKvUzhf/oP2ZJMQgnePUBcqHtigOMLHxGFzfrfpL3cEXyAye13qcRhRFjXHhkegIz+yGl1CgyAUBvTCfq+TQmmi8JZbxI8/I6LDnWs46nOUp8dFt/RffsL/3P6BwKZqnJ6JdH+OG1Qk0KItFJOD8Cid/SDtNIBL6Io5bo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eu3Zxawj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759999640; x=1791535640;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=t7ELEe4w61rM6xWYOTqFrVYxtgRcsdyr476Zu9Kz1pg=;
  b=eu3Zxawjb3eyiIYyWqSk315Gg/JAFHKoAtHjfHAAKx4PCocHNG/euiD3
   V9E3/2TmW/UJXjQUVcy9NlMo9S7cmN2mNl67G8GYl/0n5UTKDn++ghboL
   SYuQmeBAaAjlJCywcRfBOKZu06tAg6ArFbGYZuaZIu3QZDhc5vzvz2B7T
   OAkcDFfSNXl86D08xJE734it+p9VwBVHP16XHvfmKhiVxOAUCoawKYYDc
   /nRzV5ma+VUZxeD1Sue/CIS6yObEBa000RTw2HP0MOt3pDVYkH4cKyJ3n
   CCsFR/OOY+RUSDAark7PPHgzQPd4FdXXlNkSIyDZ0yAaOKLKfrKA3K/Zt
   g==;
X-CSE-ConnectionGUID: 6Dq7PSLYTcyBs8ijFKNZpg==
X-CSE-MsgGUID: htrRrwXsS76dX87NktWEgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66030814"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66030814"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 01:47:19 -0700
X-CSE-ConnectionGUID: qTkZKg2zQFux2CK7ok5DVA==
X-CSE-MsgGUID: pxoTrjd0Qhm5qid3Dp6n+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="181088639"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Oct 2025 01:47:18 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6mIt-0000LX-2I;
	Thu, 09 Oct 2025 08:47:15 +0000
Date: Thu, 9 Oct 2025 16:46:43 +0800
From: kernel test robot <lkp@intel.com>
To: pip-izony <eeodqql09@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Bluetooth: bfusb: Fix buffer over-read in rx processing
 loop
Message-ID: <aOd2c2twr_9GHjSA@d0417ff97f04>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007232941.3742133-2-eeodqql09@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Bluetooth: bfusb: Fix buffer over-read in rx processing loop
Link: https://lore.kernel.org/stable/20251007232941.3742133-2-eeodqql09%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




