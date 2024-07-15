Return-Path: <stable+bounces-59261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDAA930C8A
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 04:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF111C20B84
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235C95258;
	Mon, 15 Jul 2024 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjIJPNdv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC14C9A
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721009617; cv=none; b=ZJWxuquL2UNNyaicIuYrwCx4QJ1LXrCScazQkkW7fm9rEcmoaulO3E/xAD/MJ0/bD24l9624Y1Nk+1mOI/9mcTDYe9ZnyGzkWjr7R5T5p0gOTdjH8vdP2V6BX3arjp/vJAubDj9QSFqsdYJxmP2BI2YX8braB90QJgNWjHHOqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721009617; c=relaxed/simple;
	bh=e0uvzaOCXdANb3s7pw3Uw4jYcQ+GH1eDFIwJQy5e3oY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R3JoIcCvjzy/0MY1s1pxkjxp7J66yMXi+kHavb86LWCF9DWRrqmWMrvM7ZBxt1D5X3nXUOInB6qaRM/H5ZmsPzNKLEH2POhivJA31W78DkN0iiCRMuN3plWjAu37UOuK7kJHfZwYhGiH8DDyCpRYaW+Qnk/PJSKO+1fclMBvC7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjIJPNdv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721009616; x=1752545616;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=e0uvzaOCXdANb3s7pw3Uw4jYcQ+GH1eDFIwJQy5e3oY=;
  b=UjIJPNdvLesDmiQw9QKEaJxjYbRTNTllYEzslW/r0c8aWY+ma33d/jeV
   alaps6xe+HFCS4U88ljLa7R+nRMaETzcgzKH9LLRBrirx5ZumskKlRP57
   5EnfMBx9dJmBls/i/TIRd11xgmkpY3mxzjkbz90ZAeT+5BqhfC6akQFc2
   TtXpMtVlhK6wLnXwieUo4sQL4ZNF/Eioedq+TewAHIXhBCqU7j3Atkk1K
   g6uXCER19slycTgg0WN4Ea2WnQ0h+hHzja70DmHfsrHab2h5ohjR5jvyY
   QoPm/dqrI9SWldLJ9Rafm5aSC9gpOq79J3d+YJQOcS1PS/0VXwtDo66YK
   Q==;
X-CSE-ConnectionGUID: na0VAQhgTnu7NiAvOVWVAg==
X-CSE-MsgGUID: Xb1uAfOHQQeEoxqDUbMELA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="40901847"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="40901847"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 19:13:36 -0700
X-CSE-ConnectionGUID: UGfzAzmZQKOpvTPVMLvFUQ==
X-CSE-MsgGUID: wBRO0O1SRTykJA+VCwB0tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="54296977"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Jul 2024 19:13:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTBDX-000dsH-35;
	Mon, 15 Jul 2024 02:13:31 +0000
Date: Mon, 15 Jul 2024 10:13:18 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible
 string
Message-ID: <ZpSFvh0iTHUb1rTu@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721008436-24288-2-git-send-email-hongxing.zhu@nxp.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/4] dt-bindings: ata: Add i.MX8QM AHCI compatible string
Link: https://lore.kernel.org/stable/1721008436-24288-2-git-send-email-hongxing.zhu%40nxp.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




