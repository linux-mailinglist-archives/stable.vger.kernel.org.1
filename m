Return-Path: <stable+bounces-256524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJFTMBcwGWq9sQgAu9opvQ
	(envelope-from <stable+bounces-256524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:20:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403DA5FDDBD
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FEC6300E3DD
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2E3A5423;
	Fri, 29 May 2026 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dwwfo7HW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410332B13A;
	Fri, 29 May 2026 06:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035576; cv=none; b=EseYOPzYIsjqJ33rWmsn9/pEjr5PwLpG9YIbo9dgXYkIKFnx7TyWDrUwk+LvNwwy9oTAj//3C5sHRRCNshq/pr5T6kNfpuBBIcR13z2Wqs0tg4hmfQQ5WVW8GnyB8b2EsGvNyfC9P1MMd5c0ZDiUfcoX4rkFVHmCeO9FNAacMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035576; c=relaxed/simple;
	bh=mLrKjWWivQT6KcJ50KEr/lOyLOkCG5rptxpC8LkCVHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWkVhKUBUb6Ra59CcUlJkbOMG4vNteOymeiU8zgMG6lNnnhmBuvVRRqPVugedvqe8q9LVplPvFjwDdjypIkmzJD0nMG3HcWi2NoUXi9h4/VRh9SGpgzan3FAL+SfiTfQHd2MG750HywuJCG6dNfMnTWRapd4qtGEhk/ygk1A8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dwwfo7HW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780035575; x=1811571575;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mLrKjWWivQT6KcJ50KEr/lOyLOkCG5rptxpC8LkCVHQ=;
  b=Dwwfo7HWSUBoGrX10clqLurgJ++cz2AQP5JW457/3Kv4hBb1wge5mkr6
   c94wuBYqOYDGIqcqfkMnc/Xa/+sLLsA1gsTw4pdNM+JRz2NSd5vajbTfV
   31olYqrkwoQuwswMv++XtpgJ82kemuymNW9aEa+diGL5DM0sCZiJO54N4
   7VbeZXAqxAAyb35cofxI4mjyzz5dvqjTJCXEHNZgJw6n1q6q1vnSl4pk7
   rFJ4F3cYrJgQEJKjZ3g1rsi0BeCH4QNWj5wYlTwUXlsO/E35i3qIEtWwB
   rs1fX34lliK3Rp3ikQnzdvtshcm8heeaC9py12MByI2q+5tcZuorDUSo/
   g==;
X-CSE-ConnectionGUID: UxhihgRPSVGpQMHtSFT1Ow==
X-CSE-MsgGUID: 39VkjPggThGZTkPn94LOSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80782643"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="80782643"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 23:19:35 -0700
X-CSE-ConnectionGUID: wugcElarQpOJoAatsPLsvw==
X-CSE-MsgGUID: OCxStORMRa2YKIjvxUWkhg==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 28 May 2026 23:19:32 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSqZ8-000000000p3-1WhS;
	Fri, 29 May 2026 06:19:30 +0000
Date: Fri, 29 May 2026 08:18:54 +0200
From: kernel test robot <lkp@intel.com>
To: Hyunwoo Kim <imv4bel@gmail.com>, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, brauner@kernel.org,
	cmllamas@google.com, aliceryhl@google.com, mo@sdhn.cc,
	wedsonaf@gmail.com, Liam.Howlett@oracle.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH] rust_binder: use a u64 stride when cleaning up the
 offsets array
Message-ID: <202605290823.20jvlxFD-lkp@intel.com>
References: <ahjpn-3WQTywTdyj@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahjpn-3WQTywTdyj@v4bel>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256524-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,android.com,kernel.org,google.com,sdhn.cc,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,git-scm.com:url,01.org:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 403DA5FDDBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hyunwoo,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus linus/master v7.1-rc5 next-20260528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hyunwoo-Kim/rust_binder-use-a-u64-stride-when-cleaning-up-the-offsets-array/20260529-092450
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/ahjpn-3WQTywTdyj%40v4bel
patch subject: [PATCH] rust_binder: use a u64 stride when cleaning up the offsets array
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260529/202605290823.20jvlxFD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605290823.20jvlxFD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605290823.20jvlxFD-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j384 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in drivers/android/binder/allocation.rs:412:
        }
    
        fn cleanup_object(&self, index_offset: usize) -> Result {
   -        let offset: usize = self.alloc.read::<u64>(index_offset)?.try_into().map_err(|_| EINVAL)?;
   +        let offset: usize = self
   +            .alloc
   +            .read::<u64>(index_offset)?
   +            .try_into()
   +            .map_err(|_| EINVAL)?;
            let header = self.read::<BinderObjectHeader>(offset)?;
            match header.type_ {
                BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
>> Diff in drivers/android/binder/allocation.rs:412:
        }
    
        fn cleanup_object(&self, index_offset: usize) -> Result {
   -        let offset: usize = self.alloc.read::<u64>(index_offset)?.try_into().map_err(|_| EINVAL)?;
   +        let offset: usize = self
   +            .alloc
   +            .read::<u64>(index_offset)?
   +            .try_into()
   +            .map_err(|_| EINVAL)?;
            let header = self.read::<BinderObjectHeader>(offset)?;
            match header.type_ {
                BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make[2]: *** [Makefile:1954: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

