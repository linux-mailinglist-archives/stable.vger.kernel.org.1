Return-Path: <stable+bounces-95425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC089D8C0F
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 19:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404FE285FFE
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E6B1B3943;
	Mon, 25 Nov 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3At2AOR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA563C
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558549; cv=none; b=HDCa+ka8Le0HLDB6j9AMeSyynY4UaItDehe+JWs/e2sknG37s75OXInQqsYdI2+0DXnYIrdeckOfZOgOZZX2cxm6BKhtmkQ16Rrnnjfv12SIDViCZY7tf8tu4KlKM/H1NBeJu9Yzm5WkWbgS4Pg7RWrg7FzcxYw3B44CgcAGL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558549; c=relaxed/simple;
	bh=lMyBohe3rcLUjmK9aHoDpg0DmzqA+/JK02mx3yFKkCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LwG/aTwnmFslna56BtG+xBNSrn2WpbK6vaoIA941B7Wo7o2XTlOrtaUCrRBdSonZ950D05g2Yy/1xtLfvSmLO1nvh1AI2x+SzQo7ZA87XQK4JmGJ2zcN2L1ZVt7LZfFWVzzQQk2U7YJLbBUdd4teaKH1kXRgj4bx2SmlEbG0PBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3At2AOR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732558547; x=1764094547;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=lMyBohe3rcLUjmK9aHoDpg0DmzqA+/JK02mx3yFKkCI=;
  b=i3At2AORGev328YnuFJVvu+cxw/Az8tYTEDxRYUTv4+UOoXKlV3xQmZV
   nAVKZ21slw/2zBr/EzHe853t+Kz/7od/8fwxLTCnb9ibcArxuBi59FjVB
   i4VTtQP0+CH9xtdCpbjOXu11kKrwjHdwkuTSn9SEfLbPWas4sM8NTc2L7
   44eypqzxzwNXPElROKU++S+2hnnpLfoO0diW9NnhDn7sIDvxfKnhoZJr0
   ogcp6oYXBxqJwfuvbrMnd6d3q36uOJsKNBop+V+PfduqL652rrTxBl4PF
   NuaWVY/1rUp+pwtAEQE+dL9WGHkkXgPA3P58T/iOB4t5Sojfr43VZJ819
   Q==;
X-CSE-ConnectionGUID: jr2f6qJaQ5uft6J7mentAw==
X-CSE-MsgGUID: h1aAOl2iSJG4IJ2IJOj+Ow==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43343020"
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="43343020"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 10:15:46 -0800
X-CSE-ConnectionGUID: 2sp21Wc1QQ26pzQd6xLnlw==
X-CSE-MsgGUID: tmS3tHIfSEqaTnN0HJnDWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,183,1728975600"; 
   d="scan'208";a="91307209"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Nov 2024 10:15:45 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFdcc-0006g5-2H;
	Mon, 25 Nov 2024 18:15:42 +0000
Date: Tue, 26 Nov 2024 02:14:52 +0800
From: kernel test robot <lkp@intel.com>
To: David Sterba <dsterba@suse.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Message-ID: <Z0S-nDeLVE3Zpmv4@4ea3db86afe5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125180729.13148-1-dsterba@suse.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Link: https://lore.kernel.org/stable/20241125180729.13148-1-dsterba%40suse.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




