Return-Path: <stable+bounces-230013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEztELeuwWmUUQQAu9opvQ
	(envelope-from <stable+bounces-230013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:20:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3762FDB14
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F763044B9D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 21:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8AE37DEB8;
	Mon, 23 Mar 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKvrDH6b"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686237CD55;
	Mon, 23 Mar 2026 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300806; cv=none; b=bkQZqU/wI9OtIBQSheJqlBkG6hG50JPluBbaosvA3nx93TfvN1rTglUNxw7XkLaFD0KQLC7woWAaqdQ9taF9fevfWF77y6GLvjSqvshI8pEbAZbry/rhftUNRyOuoaFutcsB6N8BkOOM6B/v8aoWJlux+d+BCbhCYL27X8KrGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300806; c=relaxed/simple;
	bh=HonpmE9sD5pe374xwAXzKjkB5sBO/ZduWmCfRwistFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0r/4cnmLjibxKHu9SEK56j3XA2UlsDBF34JnLUzXQ/h5sqCHBktTo55+k6uBDXFwteUr7z3sHaJgbLISOOFA3qehdqwxPFYxfL/GBzMXY1og1ykxj+uFfq2/loWdc/450uSLqTr2x+CSbr/Nab7oc2nPc4LqHYuzW1pxeaWG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKvrDH6b; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774300806; x=1805836806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HonpmE9sD5pe374xwAXzKjkB5sBO/ZduWmCfRwistFM=;
  b=kKvrDH6bmU7AMrEumtNXtv7pFHYn2nZIsd1MAzEkpVW+2BSRut3n/N9Z
   t+MWrFawZI0tTG7fIU08VQf4PKecW4czyUKWHSXIToFvmE7G5YEDHk/hg
   MzDHtri/m+zhETM/jzik8k1NuGerzHRWTaQdV5f1LMwX/q6W+rrdqsFW4
   4zr7Fr+UNVzCdi0nLOUZBOIFBuAou/+qumC4OizfQgKmNOaDgBosCMuyO
   nesDqZ7aWDik6BU8FdzraP0x2omMAiPwOjnAA6ot9js59OtcTNJskmF/v
   Br0OuTT8oMZP55xfyxFuLQfcmyFzZspnGOp7mQgbapHTngzX4iptxertP
   w==;
X-CSE-ConnectionGUID: IbN2XjY7QaKp0idIYCxmHQ==
X-CSE-MsgGUID: 8FCx3AyvTKCelchgHhyisw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="100762180"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="100762180"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 14:20:05 -0700
X-CSE-ConnectionGUID: XFgdg1YRT5qrYQe/rXCg/g==
X-CSE-MsgGUID: 3Ym9iAEFQ+aarZBIZN+QwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223211274"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Mar 2026 14:20:01 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4mgo-000000003Ev-3N1U;
	Mon, 23 Mar 2026 21:19:58 +0000
Date: Tue, 24 Mar 2026 05:19:52 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel J Blueman <daniel@quora.org>,
	Chris Mason <chris.mason@fusionio.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, Daniel J Blueman <daniel@quora.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Fix BTRFS arm64 tagged KASAN false-positive
Message-ID: <202603240559.BNndaqHO-lkp@intel.com>
References: <20260323061827.22903-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323061827.22903-1-daniel@quora.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-230013-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: CB3762FDB14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[also build test ERROR on linus/master v7.0-rc5 next-20260323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-J-Blueman/btrfs-Fix-BTRFS-arm64-tagged-KASAN-false-positive/20260323-181717
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20260323061827.22903-1-daniel%40quora.org
patch subject: [PATCH v2] btrfs: Fix BTRFS arm64 tagged KASAN false-positive
config: x86_64-randconfig-001-20260323 (https://download.01.org/0day-ci/archive/20260324/202603240559.BNndaqHO-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260324/202603240559.BNndaqHO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603240559.BNndaqHO-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__kasan_unpoison_range" [fs/btrfs/btrfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

