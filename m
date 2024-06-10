Return-Path: <stable+bounces-50085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B74901F56
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0A71F21F42
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2817B3E5;
	Mon, 10 Jun 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaRT+orH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1E7B3E1
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015078; cv=none; b=fZOwhF0rtMVLwb351mRhVjWneltZ9A/0AXesXMKHmejwQlJgP82hn1MF205mfFD4F+dN5WU+cdPFtEp5Kz/2aUOR0EcxIcorQ6BqwCfr5OIFMLsoqREot2oKn7H2ZPApjKoUGo3hIq5k4nbfw0ynf6rkkWLKh1LLsKxmWU6hfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015078; c=relaxed/simple;
	bh=MC6khLPufpswWxVYieTKWL9MPGDSTVH7EZoVtMu3Y8A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YsIycG/1gPess2en9eTD+914E4bRP6QC4xEBLpXw8Qf9bd0mN3Jbi5jpGWjtSxOAecCO0ki9wMSWOUnfG3G7ENow24yUr5mzaByQ/6xJnfhjxUkOaLeGG5gAApH+HMejpVOYMi6CGRqL7zpsofgKvJSfOuSv4pk2pcJOrw8aB00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaRT+orH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718015076; x=1749551076;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=MC6khLPufpswWxVYieTKWL9MPGDSTVH7EZoVtMu3Y8A=;
  b=EaRT+orHPGaOdidvF4eIogYQZlq0o9Pw9vfzgScy7vVT7ABD+kr8efGx
   qeCO6GnrVZTjlJ6wNWF87mVCi3Uu5p/n1ajImk6ZrNv/AKTJ1PUposmWv
   zPPr3+mvWPSz61jEZERkALPy1RzKqhrRlWSGPVartGomgUaXQ3sMq5yqA
   dC6HYUolaLxZXE515dQOeEfWJYQHlep5ZqRW7SK3kKA+kGQl4NzpmHx4c
   jakTsUJ4Vs4ylQ56s/sqIujLeicj0RD13WJ6p94112qB0z7fz+P52OIO9
   bHnJpGXiZ915Nz/0C5AKZI2+FzZCjueQAPbwrOin/knIk35E3lXJ1CXtW
   A==;
X-CSE-ConnectionGUID: wECCIRE2QUWqX9mTPSSCOQ==
X-CSE-MsgGUID: Ut0iOyYPSWeMJuEuSpxv1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14462788"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14462788"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 03:24:36 -0700
X-CSE-ConnectionGUID: mVdqfQO+Ru+DUZT72fEl3Q==
X-CSE-MsgGUID: mMTwvW3MT6WzVBx1RwtnWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39563747"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2024 03:24:35 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGcCW-00024H-1e;
	Mon, 10 Jun 2024 10:24:32 +0000
Date: Mon, 10 Jun 2024 18:23:46 +0800
From: kernel test robot <lkp@intel.com>
To: vsntk18@gmail.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 02/10] x86/sev: Save and print negotiated GHCB
 protocol version
Message-ID: <ZmbUMkwcVT7hEkxF@242c30a86391>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610102113.20969-3-vsntk18@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v6 02/10] x86/sev: Save and print negotiated GHCB protocol version
Link: https://lore.kernel.org/stable/20240610102113.20969-3-vsntk18%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




