Return-Path: <stable+bounces-105115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8C9F5EA9
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFA718941C4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 06:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41B21552E4;
	Wed, 18 Dec 2024 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hy9HjBrz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531F14D430
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734503716; cv=none; b=tch5QIXWIx1pgkBSm4fo1dektlQseLOLgDWVlhcesql2y6XkBdHsfhi5PxLzkxubZdyd0vvqf6nzmxi4pjbnid+GvDdUkGmaYUz3xeN3s9CxWUe54rA/r/5M+CHHtYX7HJhnpmwivjjm5lkj2HvvrIu33KWj+mq9XC1RXS0j5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734503716; c=relaxed/simple;
	bh=nIhca6dFPdehfPioCdVRlv65tO18N6wNh9Y7YKETetI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lkYG2xN1M3bZQVXituQvYGWPsAClSF9QkPdmyB9VDoNXclUGsze75f0PwoxF7iQiQbJ9Kj1gdKNHemzSqYJgcT1nQtiQ/CdLcuKSPjd3MeuPf+wm5/hBw1D6WnyJpPdVFzO+tSjENhABRsLmZfj2qv0fhmAQQ0++/OYm8O0+cmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hy9HjBrz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734503714; x=1766039714;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=nIhca6dFPdehfPioCdVRlv65tO18N6wNh9Y7YKETetI=;
  b=Hy9HjBrzPdzW6eQTlRPyxMq8SA39y4n8pmZyttGdZZdLF1hKz3Bobl2f
   XmzlTd6z0wWs8UiKoVvclRxpMgh99eEAC9A5cYSYGWS8pidlwDXSrgwoH
   wqIy6KU8TcFi26At0oQqPbQXCBGdc6Wv3cSqnu4AdBEr+8bKwF1PFMcmv
   K47PHBtTWHagIzi+F3En5HUX7BtXy9gl3JDoZQrtLB3ZCQrdEnJakFPFv
   MWxG1htkyE9hYbetmL0DTsW6hGo27kYTi2pL0XP9JSScGpZz/HQ71fMvQ
   IO5EEDU8FCxgFoIo5VNodjtfqL3c4Eddt8BzAA04f0A08YYude1SlM8lB
   Q==;
X-CSE-ConnectionGUID: OAzVUPnLTyea1PwDSRwj2A==
X-CSE-MsgGUID: wGufaccwSg6UrNfbFuPmvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34844104"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="34844104"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 22:35:14 -0800
X-CSE-ConnectionGUID: 4CdvrCrVSlijyUcNcbvrgQ==
X-CSE-MsgGUID: 9kOStjoqT/25GnMklkaL+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98225557"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Dec 2024 22:35:14 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNneJ-000G9q-0P;
	Wed, 18 Dec 2024 06:35:11 +0000
Date: Wed, 18 Dec 2024 14:34:21 +0800
From: kernel test robot <lkp@intel.com>
To: yangge1116@126.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] replace free hugepage folios after migration
Message-ID: <Z2Js7fFgqOjnD020@e44086dd48ba>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1734503588-16254-1-git-send-email-yangge1116@126.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] replace free hugepage folios after migration
Link: https://lore.kernel.org/stable/1734503588-16254-1-git-send-email-yangge1116%40126.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




