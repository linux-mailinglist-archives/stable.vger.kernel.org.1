Return-Path: <stable+bounces-132375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9EBA875F7
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 05:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70661890898
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365917A31C;
	Mon, 14 Apr 2025 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7CJ1T6u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BE3188733
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744599666; cv=none; b=X6808mJ+/tfYgQ4WKwa/kQzPsQq5kJ85DTqwaVQuyooho/bYpOvvtaqb7a/YkjwWQkZv8LmZSEQ1PcmalkmCQJmdqWhoiT8yVetEO1bFPK0kEYrFnyh7EBAYgcpUEx7mY8pW9m47mcgVC1CersIPIw0w6QiZkjv7WEfB1VzV8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744599666; c=relaxed/simple;
	bh=bvfWSha/lqaZKIGxSuvk1g5T1BiWKc9sAkLuijlTDqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UFGlzMLvmhJ5d2pF9yjiZ0xGK+EivFfOKfeFreg/tz6gfeECNtiG9fIYz4Ui4+Hk0z31QrM511O50oFjQnNn/tKBFohtNPsYfv/bw86mUHqsNW+O0romvZ/rTMuiRaB7GK8CykW98xskw0lqNJQHF5n1Sve/sHLObwPhJg5RVYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7CJ1T6u; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744599664; x=1776135664;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=bvfWSha/lqaZKIGxSuvk1g5T1BiWKc9sAkLuijlTDqc=;
  b=Z7CJ1T6uc8/z+r+4Oh4XmpYQ+7srIh6rDk6a652u34CWEDwfC37PzGlg
   m4XMcaBpDeVEAN4Gru5pBn3C8v0CTPGFc8+nk+roS45eN3I/ZKzWc8JAJ
   ik/72UbCgoelJas6j4m+LW7B1WoNVsVsVNRLV7sMe6qG4QcZ5ssXRSWsZ
   3J1ibq9o85Oh/fqHCs63NoszYuRftHjcXaOvWPpN0my3cChsbyf6a6Kqq
   ji8iQCdBhv0K9E8PXiU0DvxjV6gustX4VDnnN1WskJfsQcrAejvtmjNgz
   A7i6RzosIDy9DYgrqVhf4miGHRiwg+yIgGmpc0Qqlaj8N5VVC9bm2QAd7
   w==;
X-CSE-ConnectionGUID: UivCiUpoRau8pkB9j4PLLw==
X-CSE-MsgGUID: 3jLQB1a9QLWjqNUJ9LK9GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="56716259"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="56716259"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2025 20:01:02 -0700
X-CSE-ConnectionGUID: KxGE4ZKHQv+sQ+NoxEBbdA==
X-CSE-MsgGUID: Y1dUyUALTaOeNj+l1eV4UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="129663287"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 13 Apr 2025 20:01:01 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u4A4A-000DKo-1L;
	Mon, 14 Apr 2025 03:00:58 +0000
Date: Mon, 14 Apr 2025 11:00:23 +0800
From: kernel test robot <lkp@intel.com>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/5] net: ch9200: remove extraneous return that prevents
 error propagation
Message-ID: <Z_x6R_oaCR2Cs5CQ@6bf5cb62fcc2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412183829.41342-3-qasdev00@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/5] net: ch9200: remove extraneous return that prevents error propagation
Link: https://lore.kernel.org/stable/20250412183829.41342-3-qasdev00%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




