Return-Path: <stable+bounces-47854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3CC8D7CA5
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 09:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D161C21AD2
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27C3BBD5;
	Mon,  3 Jun 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bY448ekL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F852F62
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400504; cv=none; b=hwoN31gR2JRdbv0iF+oIoiRMMuFRVaAhUup6W5Ss7iRapwM68SnruCJV3E+n8r9Uvyr4Kh3H566d4jG/u3R4zJAkIGPJylEPRhHxA53M4oiC5uyOWQ+uuQM+2L+xEjIITZS+MM1wX3YvRi33ZXnfzfX9tqLrIGa3Bnl7M/McLDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400504; c=relaxed/simple;
	bh=N0NmV9LhewgF3njvueUnBE3uN9KSCQPkqbIf4isVIaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yp53Ax8xJHoQ2kqzhCdIz2eg0cx/VWV1GBiDp5y5Ss0n5L0zGCY4m8ou9rDv0PVBn5lgOqG6AQJCgUNVyWkC0lVJYKXYfy71e8I3Icv0O+wJzejsEzYeNDqcRyta9JvYEThwAaxu+G2T2mE1xXJ4ed0S5f9zB5prUOBK7GU4BYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bY448ekL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717400503; x=1748936503;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=N0NmV9LhewgF3njvueUnBE3uN9KSCQPkqbIf4isVIaE=;
  b=bY448ekLTWFzOxhEButm+PGpS5yVXhlgxr1Itody4qwG9PRPzzbbfZTL
   8yz256JOCqx7D9igFATOa7KMoPIPJNXE+5WI9QxiVsuil/BLynuqg7SMf
   O3SOKjK5kWDxNZPhQNqtCJjtUSJwqa0HIGuSJpaAQDGUVAK7FoamQrTHA
   L03+FEs83hnj24TzGD/3PGyWZBo9NOLEp8ekDyL1EdMSGRgQflizEkmrA
   Aa7MrKosfF1FAlxsRDL7hl2IY9fosj1XjxX2/5zNmmDt98NeSvVRCha7y
   +Lv9rZ71tExDA7mVALy9CcusozW6iXd/HnNQgRAG6HMuNZ99OCj8OrBtx
   Q==;
X-CSE-ConnectionGUID: XIROAHv/QfqQtjYxoXLWEA==
X-CSE-MsgGUID: LOA4l/j/Taa9peqY2LBR7w==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17707401"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="17707401"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 00:41:43 -0700
X-CSE-ConnectionGUID: +iQtmzJkRLyDqYmsuCldjQ==
X-CSE-MsgGUID: JJtl7ytiT+W6qeMQAzRIJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36880014"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jun 2024 00:41:41 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sE2Ju-000LAP-0x;
	Mon, 03 Jun 2024 07:41:33 +0000
Date: Mon, 3 Jun 2024 15:41:09 +0800
From: kernel test robot <lkp@intel.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Documentation: mtd: spinand: macronix: Add support for
 serial NAND flash
Message-ID: <Zl1zlcVrTionWOCw@242c30a86391>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603073953.16399-1-linchengming884@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Documentation: mtd: spinand: macronix: Add support for serial NAND flash
Link: https://lore.kernel.org/stable/20240603073953.16399-1-linchengming884%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




