Return-Path: <stable+bounces-217185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGs4JzvblGl7IQIAu9opvQ
	(envelope-from <stable+bounces-217185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:18:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D12150ACB
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 22:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A28FE30221CF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31D2F617D;
	Tue, 17 Feb 2026 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="de+IlAQd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E12F5308;
	Tue, 17 Feb 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771363095; cv=none; b=dr2V9N/85hrgjT2OjDGUsbtv7JFiQPfc8P+st62/B10oOiy7fPvr1dQmFFCPF+WOA8DUAsfiqDpqVYmPAWF9WREexGzqtjmiuhhAObfneW1+fHYT3zug95m8fjZ3UIi6iDcrwVjKZPc4+z3CKbLb+zA4qjAD8TSYcjZ/ev0BKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771363095; c=relaxed/simple;
	bh=ZohkSzNrI1aHnsD72W2wMAvwZYjTdr/MX/TjDGlyz/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r43rP6dW0nnKhMZUdSRkDIQ29EoVblQdOkcQxfc6gr6QGXvIF+rC3B71tMHqFXI9I+RMVqX2b/8og/5dSNq6b0pnxHwzC34Ll8JGr5etyYYL79HMA+t2Wh3tDDAkoNxbO5ATqvsZ0M6vRpx9d4nsc8Uq5PXzJCU7hB6ZhorUEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=de+IlAQd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771363091; x=1802899091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZohkSzNrI1aHnsD72W2wMAvwZYjTdr/MX/TjDGlyz/M=;
  b=de+IlAQdrnJ0DNeMtLEjej4FcWN+9S+/Stkyv2kj84tMcu3DoLNPsJG5
   ykGjjf1GU5cTxYr0XMB+gwoyBf4rSk8hB8dZqDgDMkf5HqrAcr7HumHJ/
   EH4XcawGnpoccLVK8xGfXHiDJ9uBv/VChO5COdfg5INQOrBG4xjRuRqbp
   pAk9+1y58TQpPMUP0df6QzmJY3PbEVb+VaIbmnDTgMDf23+56A0m1gLRl
   LxoNZvLFMo890T9ysWbyovdROwaKDFh4I9TKx8NHNOlZFaxlvepKGC4Hd
   /t9deOc7pnQzajlpa5dEl5rI9sVmsls9MP4N/aG7RSHsLfTtp0uOAER0n
   Q==;
X-CSE-ConnectionGUID: bi2zrYHRQ5WbVUOz6RuioA==
X-CSE-MsgGUID: 0C9j3tmXTMaOv1CwTGAO0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="97903376"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="97903376"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 13:18:11 -0800
X-CSE-ConnectionGUID: yxqFdQuKSOeef8cfUtANyA==
X-CSE-MsgGUID: gkj+1tp8SEGb/vuS/jObQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; 
   d="scan'208";a="251696798"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by orviesa001.jf.intel.com with ESMTP; 17 Feb 2026 13:18:07 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vsSSK-000000003Ir-3iLC;
	Tue, 17 Feb 2026 21:18:04 +0000
Date: Tue, 17 Feb 2026 22:17:06 +0100
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>, Jann Horn <jannh@google.com>
Cc: oe-kbuild-all@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org, Alice Ryhl <aliceryhl@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] rust_binder: avoid reading the written value in
 offsets array
Message-ID: <202602172222.mGDpJK77-lkp@intel.com>
References: <20260217-binder-vma-check-v1-2-1a2b37f7b762@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-binder-vma-check-v1-2-1a2b37f7b762@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217185-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08D12150ACB
X-Rspamd-Action: no action

Hi Alice,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0f2acd3148e0ef42bdacbd477f90e8533f96b2ac]

url:    https://github.com/intel-lab-lkp/linux/commits/Alice-Ryhl/rust_binder-check-ownership-before-using-vma/20260217-222439
base:   0f2acd3148e0ef42bdacbd477f90e8533f96b2ac
patch link:    https://lore.kernel.org/r/20260217-binder-vma-check-v1-2-1a2b37f7b762%40google.com
patch subject: [PATCH 2/2] rust_binder: avoid reading the written value in offsets array
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260217/202602172222.mGDpJK77-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260217/202602172222.mGDpJK77-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602172222.mGDpJK77-lkp@intel.com/

All errors (new ones prefixed by >>):

   PATH=/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   INFO PATH=/opt/cross/rustc-1.88.0-bindgen-0.72.1/cargo/bin:/opt/cross/clang-20/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 12h /usr/bin/make KCFLAGS=\ -fno-crash-diagnostics\ -Wno-error=return-type\ -Wreturn-type\ -funsigned-char\ -Wundef\ -falign-functions=64 W=1 --keep-going LLVM=1 -j32 -C source O=/kbuild/obj/consumer/x86_64-rhel-9.4-rust ARCH=x86_64 SHELL=/bin/bash rustfmtcheck 
   make: Entering directory '/kbuild/src/consumer'
   make[1]: Entering directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
>> Diff in drivers/android/binder/thread.rs:1018:
            if offsets_size > 0 {
                let mut offsets_reader =
                    UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
   -                .reader();
   +                    .reader();
    
                let offsets_start = aligned_data_size;
                let offsets_end = aligned_data_size + offsets_size;
>> Diff in drivers/android/binder/thread.rs:1018:
            if offsets_size > 0 {
                let mut offsets_reader =
                    UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
   -                .reader();
   +                    .reader();
    
                let offsets_start = aligned_data_size;
                let offsets_end = aligned_data_size + offsets_size;
   make[2]: *** [Makefile:1903: rustfmt] Error 123
   make[2]: Target 'rustfmtcheck' not remade because of errors.
   make[1]: Leaving directory '/kbuild/obj/consumer/x86_64-rhel-9.4-rust'
   make[1]: *** [Makefile:248: __sub-make] Error 2
   make[1]: Target 'rustfmtcheck' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2
   make: Target 'rustfmtcheck' not remade because of errors.
   make: Leaving directory '/kbuild/src/consumer'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

