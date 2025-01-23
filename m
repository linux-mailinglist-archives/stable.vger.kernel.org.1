Return-Path: <stable+bounces-110270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8841A1A3F2
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 13:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B180D1881439
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76A20E307;
	Thu, 23 Jan 2025 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQKJVu3h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6D20CCCF
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737634278; cv=none; b=EeuCwlZpg5IXYqBXUSpSJsi2oeYKX9RLhGzjU8YFjENnXAjI/Q1E05DjQo480UBI0lYttolc0BkZ/2qE8T8R+s20g6B736zs+qYpaC1GH1jARe9KyJo13OU+F0jnkJSPRLwaAfj7l0LH5/mW3aFGDM2SfpGrToEsKFUp8T6fgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737634278; c=relaxed/simple;
	bh=4DUbtNxlktKbBBd1hn73LeWxk9EhHpL1qrkN3nyliIw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H9yoGal0L9Aj8BNGGfRO7sRGFl6cD+aWWZJBq8PELjExT5a569cLzA8KMeLGr27vjtbwWBEN06cwuIhcHxspcBMZgXb8hLWDfCAjYbJuyQthyugCCELeC4SkZQoHmXqU/SfZyD/U46SRTnWuHIY6chWIT4rNOCWPQQKyDCqS3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQKJVu3h; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737634276; x=1769170276;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=4DUbtNxlktKbBBd1hn73LeWxk9EhHpL1qrkN3nyliIw=;
  b=RQKJVu3h5Hby8/Ud+zK2YrHUQ44q4eT7Ny0tQWgTboo5Fg1ebrmjDF2O
   tsRfVN5eo5Y8xE8qP9jWCkihgqMqC8orF5SOhia2QjgiZHS8eFQge9ERt
   QI6GxU+VX0nO4s19DllhNGL/1StAD3KUcgNbHxdnYM8RYTFS6TNfFhJ5q
   PJ7of3DgFPyfiy8OBNq6QJkj05I0TKQbRBkGxHdIMW/O8mQlY07xPWyAr
   HK1EVzBLBqtgpT0A+t5k7c+viKfyC7yNMAt6TF1Ks7iAEy98gkY/tZNEZ
   duafa3gFaBJFaVUGCixy67ku1S1OXhM2MMxLOXT+cuEOcECZI6IAiu40v
   Q==;
X-CSE-ConnectionGUID: 8rRH5OUlRoCrqCIdW26eCA==
X-CSE-MsgGUID: g/jD660jQ0eLXTtS6Gxv5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41794847"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="41794847"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 04:11:15 -0800
X-CSE-ConnectionGUID: Bkf83a6GS26q5cIPsiXL3A==
X-CSE-MsgGUID: 49ZF+iQJSr6mNag5uYpiDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="138311028"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Jan 2025 04:11:15 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1taw3E-000b9P-13;
	Thu, 23 Jan 2025 12:11:12 +0000
Date: Thu, 23 Jan 2025 20:10:42 +0800
From: kernel test robot <lkp@intel.com>
To: Shubham Pushpkar <spushpka@cisco.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] drm/amd/display: Check link_index before accessing
 dc->links[]
Message-ID: <Z5IxwrG7d6QFi2AE@34f1432cedf0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123120822.1983325-1-spushpka@cisco.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] drm/amd/display: Check link_index before accessing dc->links[]
Link: https://lore.kernel.org/stable/20250123120822.1983325-1-spushpka%40cisco.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




