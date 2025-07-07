Return-Path: <stable+bounces-160359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702DAFB137
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237527A29FA
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C165428CF6F;
	Mon,  7 Jul 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByhxcOZk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38560288CBD
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884173; cv=none; b=itR3i9ZDeaDwQE7dzyj/zOqfSTitUZfWhOenX0/2g4isLwTi0zWdPmXF79luafvKJQgGts/b3swXHycUJHiTl1irZn95sK2IArG9MvVfGRxsWAipUCAgKfjz5poO7BRrJ/fd7HJLIS5F9tUU/Ka7Snt3NTM5RXsOyJXJk5WYaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884173; c=relaxed/simple;
	bh=E9S3jh/2VjAMfjbVRDllBRPI5TI4dFK4MQLJI30yohE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G68uXzi8ZeWwx28ZNj6ohCawrAx4Lfq8xI8Cfdl7Ry/8V7ObTZIr0dOnAX9JWmF/kYdFMO21HPzF/A32/0bNs5xF41OMXMeMR4g22Ih66mBlKdaUaRMDUUqMfQa4mTP6Tc3QRXb1MgPjzMtqW4VZfdzb6IIHd+CDPcXWVioY9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByhxcOZk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751884172; x=1783420172;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=E9S3jh/2VjAMfjbVRDllBRPI5TI4dFK4MQLJI30yohE=;
  b=ByhxcOZkeyfajhY3d15dtObsZ4a/vQLh0u4g/tQU5AtExhn8Y7TiQO9L
   M69Ym70Reb87c3T+NF9JmczoAs7kACQAsrVAVcGf0zYfeV1nXGUvsNnzS
   ksOeGOSCHnK6p2K0/zAjST6RsARYeUTnyMo+6QjCoEmEenyd/RVxG5uTi
   TpMIdma0xgKK/FKYkkYH85RWqMgAtxAvv1MxFTvphsNUPwHetrGG9mX56
   DeSguosnWu2rseUo5JCx7LyE43CrsJ6Xm5z2Z1DG53Rv8r3aIf1p+VLVJ
   E+vB74A1O0FYqj9TMAI9erFXKAuqwJu1f0Hxk2XXuvGlrgSJjAHTI639e
   w==;
X-CSE-ConnectionGUID: XcfnK/CmTMSF8oSTksBtaw==
X-CSE-MsgGUID: hpkduxQXSaGvXQQyuhUJVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="53980935"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="53980935"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 03:29:32 -0700
X-CSE-ConnectionGUID: oIF+c1ZuQpqYSKvICFjo4Q==
X-CSE-MsgGUID: xGKEezEASGiFES03bxQv0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="160833234"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 07 Jul 2025 03:29:31 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uYj6G-0000L5-24;
	Mon, 07 Jul 2025 10:29:28 +0000
Date: Mon, 7 Jul 2025 18:29:21 +0800
From: kernel test robot <lkp@intel.com>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
Message-ID: <aGuhgbnUQe-wgFZ1@319465d791e2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
Link: https://lore.kernel.org/stable/20250707-trip-point-v1-1-8f89d158eda0%40chromium.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




