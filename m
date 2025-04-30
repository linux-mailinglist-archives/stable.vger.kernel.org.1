Return-Path: <stable+bounces-139120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D6AA4585
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76855189F1AF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0A71DF277;
	Wed, 30 Apr 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAQfo9h9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227C20E6F3
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002023; cv=none; b=T7Ca73Ri9FKWtmPLDHhKVUmHHAwUsr19UKpQzeGRz+5A+vtlYsMznascU9/pdhBZ/khs8plUIpbgKkef62rZTtYtPg1IiUyPOVydAK13t5qaMqy51tSPECBGjgI+GaBcdG01NcoZl9SG/cK7wBlG3PieEtAZWKR6A77+ABP386Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002023; c=relaxed/simple;
	bh=q/+LbTSQVvyaeB39OvKh0Z7Kl8kt7PrkIv1p18GWNcw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cm4PYT4zHC/Bq+d6Uk+brnIRX3G1xgt/yLOcmg041d4qmQSn97kNF6HFqlRYCygprzdoHC67nKJ5m51sbbk3iyVYdbkISKUrq1QJFoCAZxpayhRSK3sx2neSVnmgZx65mZ9obHxlB1XREMIbntTMCNwxpRcK//EMi+5AfUuSqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAQfo9h9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746002022; x=1777538022;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=q/+LbTSQVvyaeB39OvKh0Z7Kl8kt7PrkIv1p18GWNcw=;
  b=ZAQfo9h9lLBq0LCx24ytklnNK035M30D1XQWLugkUpaijRwe+bou5wB0
   3Xl3Ygqea7vdDTlgNrgnz3Pms0RMfbjHvS0t2947Ecos0STxC2mxR7mgA
   /0VfI6Dx5ui+esXygKDpaXEmEd9XSGE1g4YFT48ank+L7YbFUpM7e87Xf
   JXFuIji9H2YQmlRVf8WJq+M+sM5llMYbuwun/ZvrwVB6N1CaDk+lnr2CA
   OJ2S7UQ+2kH6HIxzF5U0oGJ/lWVZK9U0cdA2KRgkMkDnGzhzs8xIz1bEx
   /wsHEflzJV3M6Zcxp3MWqAWzJhieZXNZJaxXwv7GwVVibJQXDl50RiI+f
   w==;
X-CSE-ConnectionGUID: 99zO7b2MTu6sNvY9Xa2N9Q==
X-CSE-MsgGUID: Z+PPztxYQpeOpFeQR/+gtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47533838"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47533838"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 01:33:41 -0700
X-CSE-ConnectionGUID: GnwQGHcEQZObHbtoB7M8SA==
X-CSE-MsgGUID: jPt/TgquT02V7Sfv6js0fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="165000784"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Apr 2025 01:33:39 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uA2sr-0003Iz-1Y;
	Wed, 30 Apr 2025 08:33:37 +0000
Date: Wed, 30 Apr 2025 16:32:58 +0800
From: kernel test robot <lkp@intel.com>
To: Ezra Khuzadi <ekhuzadi@uci.edu>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: sound/pci/hda: add quirk for HP Spectre x360 15-eb0xxx
Message-ID: <aBHgOsqA4qfe7LbN@c757f733ca9e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPXr0uxh0c_2b2-zJF=N8T6DfccfyvOQRX0X0VO24dS7YsxzzQ@mail.gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: sound/pci/hda: add quirk for HP Spectre x360 15-eb0xxx
Link: https://lore.kernel.org/stable/CAPXr0uxh0c_2b2-zJF%3DN8T6DfccfyvOQRX0X0VO24dS7YsxzzQ%40mail.gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




