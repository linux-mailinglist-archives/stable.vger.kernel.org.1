Return-Path: <stable+bounces-100063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277C79E8444
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 09:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49261884A4E
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A413AD22;
	Sun,  8 Dec 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9DT5tYB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798982488
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733647355; cv=none; b=CAGXQIXSDNlCIe45wvVD7QSJXKQOUkjgHHJVJJ2mTNyKhSb8Z3yPK9yo0Q4F9KxVd8XKf8B8U4Uy8zfidxsZyJCyLa8YzmHNCEjWTzT2rH+9FnE6bCSykVEj9TvYGVzJi0NkvOzumGLEsLUcJx4z94yxSPW50uqIWQXdD439mX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733647355; c=relaxed/simple;
	bh=0SIJDo6MX/QEQO85LU0ihdjDe1Dt56/YEKfiRIPfEqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JiDBn0DWYLyTfKrJahHsvuxN2lZsOuJhMAFDzaciOO80TRmRd7p84o87jC/xXKPRffISKlMisT1rVG42Z/V0/CIxlaamAvtreg0iWQzOsFtSX8ybhULR005Tww2yu4U1PfJiSOnDun6h7YbTJFY7cqrI042Q+HKND9AqIG4CoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9DT5tYB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733647354; x=1765183354;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=0SIJDo6MX/QEQO85LU0ihdjDe1Dt56/YEKfiRIPfEqc=;
  b=J9DT5tYBw3+TWOQ3zPz5YbMfk62+zkNhPn8oqj5ltD3KnwMYtDenbktf
   7x0QNJD5WcRR1qeMtuAwOl5kfRqFnzrqV+Awhb5xdi7brmn3onZ2IVPbc
   hagEnINA/5k+AfmnexiGlKoYWsYXLjjEFtcE48lsFJ7Z9h9gGoeDVDGkd
   88w30ZBO7wLR6lYYE0+/bimbtPivdzKT++BUM/v6P049KFAMB+15pfsNi
   4ni6kZ426l6S/VcQGLfHYmGJxjgK1EKge5RF2OsXUGfaXxvhOG1P0J35Y
   B4TyIwTc/J7+2efttN1xw7ZSlNhqwVDpUwz5DKmyLx+Gqq+cGrH+wyX25
   A==;
X-CSE-ConnectionGUID: enZ6sa0/ScSxmoazmmVtnQ==
X-CSE-MsgGUID: zeIr2bL7S3SVcycvyrma+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="44557421"
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="44557421"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 00:42:32 -0800
X-CSE-ConnectionGUID: +5h7JRTCSDeNb6ox4Uv6/Q==
X-CSE-MsgGUID: CT4riyY+TTWJONpXklhAGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,217,1728975600"; 
   d="scan'208";a="94888291"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Dec 2024 00:42:30 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKCs0-0003Dx-0N;
	Sun, 08 Dec 2024 08:42:28 +0000
Date: Sun, 8 Dec 2024 16:42:18 +0800
From: kernel test robot <lkp@intel.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6.1] KVM: x86/mmu: Ensure that kvm_release_pfn_clean()
 takes exact pfn from kvm_faultin_pfn()
Message-ID: <Z1Vb6mMqvlZHBQ8z@a512c14b2e7e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208083743.77295-1-kniv@yandex-team.ru>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v2 6.1] KVM: x86/mmu: Ensure that kvm_release_pfn_clean() takes exact pfn from kvm_faultin_pfn()
Link: https://lore.kernel.org/stable/20241208083743.77295-1-kniv%40yandex-team.ru

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




