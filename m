Return-Path: <stable+bounces-2809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB337FAACF
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 21:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7121C20D87
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A4345975;
	Mon, 27 Nov 2023 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9kHaG0T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A41A1
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701115310; x=1732651310;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=YC/hFxU0zG+tWLTPsC699l2X/RL/GB/BOWl0FxV2NBg=;
  b=F9kHaG0TRJdrh1QPgkknDn7zInIAmDSF0RN++Ngvxl8HPHY7lQL070kZ
   d+jM65n6KtMC6hG3k9NUB5M0BYCR2Qkjx5AzdFr0azd8E0tiC64q5W50F
   uWYOEqmKS3QpFo9yBhYDOnir7zdoGKxKIkeyJkAbY4I7xjQxpMud0vOFa
   Bf1iSWwAOcXOmEq+r/8bd1j2S6TXATXwIXHjNvmfEsVPsCqqRqzU7ICsT
   jkDeqvpjTjeZgi1tg6aedKKzEYRbTV9aBguzT2JJU3/Xhb6vmjYgqpeST
   CaO0utfENSZiFBcoQHtpLfTuA9InZeiLoblNoUl8zgd5VJ5Hb4rBSEJvj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="395598488"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="395598488"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 12:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16391442"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Nov 2023 12:01:48 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r7hne-0006cJ-0j;
	Mon, 27 Nov 2023 20:01:46 +0000
Date: Tue, 28 Nov 2023 04:01:12 +0800
From: kernel test robot <lkp@intel.com>
To: Malcolm Hart <malcolm@5harts.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS
 E1504FA
Message-ID: <ZWT1iCfCz46F82xa@520bc4c78bef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y1nt1bx.fsf@5harts.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS E1504FA
Link: https://lore.kernel.org/stable/875y1nt1bx.fsf%405harts.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




