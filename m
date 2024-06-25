Return-Path: <stable+bounces-55767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E12E916914
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901431C25736
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CDB1607B0;
	Tue, 25 Jun 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KquyFErL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C461607A7
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322543; cv=none; b=O1iPyJPiQkXnJNIzhdOWSmlS1xXoVs7syKrky0M2ADEuY8DO7vr6YYxE9g6LIe4M7BytGRpLjaT2NE3fiauO4bALuDsQ7Cw8CPJw+pf1dESSw461L0qXDDl0tbmPGm243nYGAml+7MPeBXeRnrROoMIfvuL/rDmNGlehLgrsS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322543; c=relaxed/simple;
	bh=oTfBBNjrMxF3+8EUNWyVBjiZ5mWolPrdKFpf/4v3430=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h1CL1yI36HzJzqpRmBi4GHoCETI+OmGlO2DwY+m727ARYT1xLgf4tDsEpSQS2nmSaGL3QMjje81WQYfl70m+RiQLiro1VOk7J5OEQejV1DgOnJ3Dp63VN902/LSi1phDSH3k68E2D0rDmoGs5BJZTaR5SM5eO0roqgpyhcW+puc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KquyFErL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719322541; x=1750858541;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=oTfBBNjrMxF3+8EUNWyVBjiZ5mWolPrdKFpf/4v3430=;
  b=KquyFErLihq87ucSzMRneCvmtKWB/GkR/e5d3csFOR3SBo9JPcD7goYr
   FBxX9Gia0n2J7siiGu9RshGO3jQmd4bWVj897Wvp3CgqMP25/LCYT/xpE
   mOKugRYVD8lkFzzg64a7G4wAYGM/jGtpw3o7W/wKG9evhn9iN8zNzRzmX
   428Hg3hFIvKFH7XReXrHK4C7Jkn7kta2ubYC5OPB54GjXJ0nmT5rKNfy4
   hqGaIGq7SY1XgCw8m02eCEnUjG9kIYT3MXhnuUYVXaPtKIQUPRDc0NPTQ
   9uVGjGQtLtbFZmKU7AA0Btqw4Mt7ueBNyXjRW/vpdz35L+PEW7bFTU/Fh
   w==;
X-CSE-ConnectionGUID: s9bHd258RSS3oAbTheFKrA==
X-CSE-MsgGUID: 0HXcr7T0RX+/0/75mmLETg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="38852487"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="38852487"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 06:35:41 -0700
X-CSE-ConnectionGUID: gIsbdLTnSSSmWPogy2ViJQ==
X-CSE-MsgGUID: 4VqUwGXQTWOrfGw33zUOAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48089741"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jun 2024 06:35:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sM6Ke-000EPy-0p;
	Tue, 25 Jun 2024 13:35:36 +0000
Date: Tue, 25 Jun 2024 21:35:35 +0800
From: kernel test robot <lkp@intel.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net 1/1] igc: Fix double reset adapter triggered from a
 single taprio cmd
Message-ID: <ZnrHp7CgfLecibDl@6715f18d4702>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net 1/1] igc: Fix double reset adapter triggered from a single taprio cmd
Link: https://lore.kernel.org/stable/20240625082656.2702440-1-faizal.abdul.rahim%40linux.intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




