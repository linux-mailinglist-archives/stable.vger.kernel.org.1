Return-Path: <stable+bounces-144127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A1AAB4DA9
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671E186695E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D01F582F;
	Tue, 13 May 2025 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zqhnyyub"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808111F5437
	for <stable@vger.kernel.org>; Tue, 13 May 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123651; cv=none; b=r1ECPcDiRUgvThOaGgHdVg52/0ZlCw1vCsD4jxhg2RqsNUwb82IS909tZyUP6VDcg/Jewi/+4Ag78nCuGC5fc+ig0iD+BheBxPqBQ2PlsTypnBIoZhYv7+7iSlm3AiiiNcWI+Zwdn2rIgSI1DAqEdqgSFWGfKSq4PHdgg15gJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123651; c=relaxed/simple;
	bh=JeHSIXfqlD33ki/2XnfHM0IKxV8H/qfQUSwwS94FDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pOrxkAUC8aWWE/zuD8CMh9cBx56P8CIjM6Z+ogcL2i125QyAg7WAXt38hEcaeysZq2I4bqU11XSSx9lIrtiBx0vodrMpkcCmTxNubPGOT1N2m2mcH9YUsX6WKvFqDIiMJSk9U6ntKD+ELo9KR6Nd95QIEyYo2HF+XTuRyJxgGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zqhnyyub; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747123649; x=1778659649;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=JeHSIXfqlD33ki/2XnfHM0IKxV8H/qfQUSwwS94FDZk=;
  b=ZqhnyyubXdQeZp/HIcxBNW1OH8zHDS1uqt8F0yJisNWF3tgUThZVcPdX
   e6ua0MS8RbR0GMinihEzA5UVgeyIc0a/gh7xkuNXArYT9DDi8JOZMWY10
   kxEraUwn5ZQuzGwA4LEw6zpGzYEE2Q0io7deJjmsR4xBbaI0F2hEO51+J
   nBU4wCopFunKFxycukDuIb2rCpZP60uTxfdCOR5TC9SR11SVrUTvcwCrE
   7nUC7nM5QGDRYhdX2H+0ZyWoZrf58q3+ZGn22TidZxR/+05A4iALaJZN1
   qwLN5oBlHltasp1T4feBG0ALDbHQbp5Egjzl66tabteKM/xLFuzSBnCFM
   g==;
X-CSE-ConnectionGUID: WINHjbrRQXuhqAbw8UKzxQ==
X-CSE-MsgGUID: Y5dyo5E9QEe4n9d3ttNMWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="49118985"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="49118985"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 01:07:29 -0700
X-CSE-ConnectionGUID: fWNmBkA4ReSPXTAYPQr9mQ==
X-CSE-MsgGUID: kmY9YDTWRj6An0zMFTplKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="168555352"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 13 May 2025 01:07:28 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uEkfd-000Fqx-2g;
	Tue, 13 May 2025 08:07:25 +0000
Date: Tue, 13 May 2025 16:07:02 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH for 6.6] mm/migrate: correct nr_failed in
 migrate_pages_sync()
Message-ID: <aCL9pl7ntFRtm3dv@75fa4dc5d8b3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513080521.252543-1-chenhuacai@loongson.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH for 6.6] mm/migrate: correct nr_failed in migrate_pages_sync()
Link: https://lore.kernel.org/stable/20250513080521.252543-1-chenhuacai%40loongson.cn

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




