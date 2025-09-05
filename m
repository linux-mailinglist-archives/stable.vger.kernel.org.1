Return-Path: <stable+bounces-177793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C957B45385
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD534175154
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A400F2701CF;
	Fri,  5 Sep 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLL8gUpc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F26263C91
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065198; cv=none; b=bcYlAZuQysaBhet4CMqF9+TRBVsClCOT2PD2ZfxEP/ssQPNAWEoD1KP4YESpQWjIZei8oDIL2K+TzohsDz748YE31VWemznyxRjto+Lxl2bkq+eiDp6RcQBYuwrbprNCJbNDs2Ckj78Cfl50ubABL+l5CwQwI0/d+3RVVwmpIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065198; c=relaxed/simple;
	bh=MA8fCiCSigtIxeZ870qPOgmeUwlUaY+3NeE3700kiw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qyg05YYwwv6MQ+rZP6822StNtKtZGhi5C97mQUNqizVhxJzjSgEEfjQ7/olDAkgzmwIULJn9DwqJxmwdmeRTxsvnmGQm3ziVmjfvEDXiNACpk7nHt40ZpeyIW2tTPN1bPdln+hw7QS5lt7IOOdFK3hJxBgw1lWyiEUAIL27gUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLL8gUpc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757065196; x=1788601196;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=MA8fCiCSigtIxeZ870qPOgmeUwlUaY+3NeE3700kiw0=;
  b=JLL8gUpcrpuaV9dgkNZuVSMCLJtUlCzKAbwz8wx7wEal1nBwi6CQwGO6
   bpJlQUSgmVtD/+NpWE/Rr4a01618NomlZ7s4fNeRuUEYLQcnX6TQmKkzv
   FO5/tau/gBKFDBQqcJd/nOdLDai5TVWJXTa0RElDbZbL72efV2XswHtYb
   vPL8v5L0URoux3EcHr+9Icgoum/IVbjAIK4dQr30638gnESccitudFn6M
   YAn8Y/RO103RoDHbnCpk/JROHAxWNUJ8y4PIsgHlUPp+Exr1iUJ3rUK5/
   /rSJKCkH6ReQRDQztAnk9/eR8raVSLPu2W4R0zW9wrLv4TTuloq2kons6
   g==;
X-CSE-ConnectionGUID: 1lVB9COCQXS7F7u9l2AXmA==
X-CSE-MsgGUID: p5qeXwBaQDCwI2JcQa3CJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63240274"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="63240274"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 02:39:56 -0700
X-CSE-ConnectionGUID: cWy4ieXcSKyaheCcBI/UDg==
X-CSE-MsgGUID: 0mjX9urGRQagUjou1vue7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="176450807"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2025 02:39:55 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuSvA-0000Gd-2e;
	Fri, 05 Sep 2025 09:39:52 +0000
Date: Fri, 5 Sep 2025 17:39:24 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] mm/memcg: v1: account event registrations and drop
 world-writable cgroup.event_control
Message-ID: <aLqvzCiPCGzA5eYo@b7823f61de85>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905093851.80596-1-disclosure@aisle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] mm/memcg: v1: account event registrations and drop world-writable cgroup.event_control
Link: https://lore.kernel.org/stable/20250905093851.80596-1-disclosure%40aisle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




