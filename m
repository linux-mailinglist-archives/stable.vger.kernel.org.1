Return-Path: <stable+bounces-23620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431838670A7
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6921F2BF15
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E555C3F;
	Mon, 26 Feb 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbrKNxep"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190CF55C3A
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942047; cv=none; b=KAuHSl+a7ZG8RrbQecmVWp4L+HZKSGvaFXFCG+iK8t7Mk85xbFqHfEA+5BBrjYPPRoRw94wNCWnCe+8rQP6gLiL53OU5PFw+Ut8cPZhAzl36ZohDteZGePJ5Dw3RKLcWFlFDD60ODjw0PObsS0E60jD3dzVjLWRilxmJ144xwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942047; c=relaxed/simple;
	bh=b8D1jJeVWFMsEuKIR1ZDQ5C3ot38iIGz2r/2NBrqE1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LTXYK4puAVtLd05eTC7/POgpodav8bMc3mR1NfJbf2tmJrM3Qq7nrXLSpjOuCgrJ/gZr15QrR78dXZ7sYga3s0V7dw8y0HR8iRqMznX8Xm2LxMczYM2tZm1ZzMqJxkTHsxhIvKD7K7khWY0SPkKowyO9P97zaZVbDKSTO/OQBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbrKNxep; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708942046; x=1740478046;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=b8D1jJeVWFMsEuKIR1ZDQ5C3ot38iIGz2r/2NBrqE1A=;
  b=bbrKNxepxFGDdCVvbTag1XoHVB2SeL63/fEHYzLorke4+NwM3J1j+5d1
   ysWnuU2ri2Eq2DnwCzdrZQtZtB1F0C231/78q+6AIRNRCgplch8oDPrpu
   0tRG2NTfDBdQsmXiCsS7m/VysIW2BZBuFVAfKG0FZPRCghgkV73L3x/u+
   VJsXRVvv4KpsBXnV3dawFGA83b7K0hm63GlsQdLbBGeeJr/mVkj3RSjEQ
   dG6WM+aqcN3QZ9rnwau3E4h554/0Dkz7P7HAlWU/lKTkj0ApOXdhV6iDU
   8AtZzWNwnkXyq5yHSf2xpZHXUKMgWwhdWD4q86sDIunJD/FYEp8XoRobf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14633989"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14633989"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 02:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="29797194"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 26 Feb 2024 02:07:24 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reXtJ-000AEx-2R;
	Mon, 26 Feb 2024 10:07:21 +0000
Date: Mon, 26 Feb 2024 18:06:25 +0800
From: kernel test robot <lkp@intel.com>
To: "$(name)" <qirui.001@bytedance.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] x86/speculation: Support intra-function call
 validation
Message-ID: <ZdxioSgYZiIOez3p@fdb2c0c3c270>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226094101.95544-4-qirui.001@bytedance.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 3/3] x86/speculation: Support intra-function call validation
Link: https://lore.kernel.org/stable/20240226094101.95544-4-qirui.001%40bytedance.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




