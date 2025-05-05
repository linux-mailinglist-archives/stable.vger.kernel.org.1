Return-Path: <stable+bounces-139575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12464AA8B4D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 05:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ACC1892217
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 03:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE2319AD89;
	Mon,  5 May 2025 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vlra3CA6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573212AE6C
	for <stable@vger.kernel.org>; Mon,  5 May 2025 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746416205; cv=none; b=mSXvSiCYfcUJkPE5imDSeB8Lgq3iyEQ4KhE4NjilDdiL48mLYxfJddyHRaRVg0jXjvKZNb22FSvvmfWGNYSCFy7alY5hxDfBrjwBxJLezakHF1g8I4OJPGegQYQYelHhJBtvveOSecHv5RP/69KEbJ8oRKe6HpBXg6R80nZ4C8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746416205; c=relaxed/simple;
	bh=LqY+ZsVFiDMShzfJsZlYwj1VjZDSIUQygm2FcZcsmHo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VM7OsE13aKmLaTJkuxydaD84UrCAg41uy8Dlgvl7rQ/qQnPsBLF7+eujEkjn4blpjT1ynLLCZHSen4PWEijtUBV2HaISQCaCSgomSQlFh0Hah/2XO5z2eQxKLodpgGsj53ih0kS/Qs03LtB4KafVe6McGYlY/5PLQLaw+WR0Ci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vlra3CA6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746416204; x=1777952204;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=LqY+ZsVFiDMShzfJsZlYwj1VjZDSIUQygm2FcZcsmHo=;
  b=Vlra3CA6eZ0ZIADW03oMsXTmbyETie+PKXgXf8xd3YfOJpdO7nH/2wQs
   MvSWZcQqkV9m9cLu+gg7vLhtyCLlp8DlMhO0qRsB0NhqNj3tjyoNaSg8h
   rg0t4yqLbLjrvaSIZGWEqfwNwgncTJp0/66Ii9yCvV5SFHE1M8618QbNr
   Be7Bgc/nqc3RaOr+YYNHnPR2VlndogEDe9SqdW9sXUvqIIGi/4dEywfst
   vqXqGZ3yj/afFgQLzac2bdYFqpN3f/vZ0SyecunQxz8sfhqeiutGrXw2N
   ragAHwK6RL2AOqEjfAIwVf0tmEMLHTRIsjAiUtRzlsjKNoLjktM8ZS6PE
   Q==;
X-CSE-ConnectionGUID: mPU+kAAcT+iI3hDZSQUlwA==
X-CSE-MsgGUID: 5Gjh8jF6QUiD5qMGQi9VoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="51830578"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="51830578"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 20:36:44 -0700
X-CSE-ConnectionGUID: GivGozg0Qnm/Osm2WWKbbQ==
X-CSE-MsgGUID: pj2599elRPy1HOAq/qTHSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="139135124"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 04 May 2025 20:36:43 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uBmdE-0005R7-0k;
	Mon, 05 May 2025 03:36:40 +0000
Date: Mon, 5 May 2025 11:36:26 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v4.1] x86/sev: Fix making shared pages private during
 kdump
Message-ID: <aBgyOsMvDRW9yYE4@92092d2942b5>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504062642.144584-1-Ashish.Kalra@amd.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH v4.1] x86/sev: Fix making shared pages private during kdump
Link: https://lore.kernel.org/stable/20250504062642.144584-1-Ashish.Kalra%40amd.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




