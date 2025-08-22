Return-Path: <stable+bounces-172381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD414B31812
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2019EAA43F2
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C162FB61A;
	Fri, 22 Aug 2025 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iY9HN6yV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0A2FB60B
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866319; cv=none; b=qdaZ8TXteKTQ7jd6V6YLueRLRYBoz/t04/SV1BfPNCEyPYCo3tZ8nnqw5iZrROaX5dMVqUciwvfvMiKtXIRCNngk5i7RM+o+Kc9RvEQJiOBkfCj8Q5lTLt11KLJEOGf8TtYhwaluhWCeQAxuawoEMuluD081R2PK5a06cqLMepM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866319; c=relaxed/simple;
	bh=0DC9VqNFSaFwDNCOeBpxZBqscy4hBWxJM3rKCgjsS9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oloRlXmbyjUmEofc9XKUiCUxacVMWurzX77n9jBjnEUuJyKQTKxPV+QglTg1Q3EF5D318sW/Cj1qccypL8quFa6vPP52Yl0DntoU0Qdalm+b8tolVijoipPpP08nSr10+ekZuyJGFlz2oppry4BKQfoE+VHTK1ExL+UYSEVCID4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iY9HN6yV; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755866318; x=1787402318;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=0DC9VqNFSaFwDNCOeBpxZBqscy4hBWxJM3rKCgjsS9o=;
  b=iY9HN6yVxI8TEXoIedT1UPw2rle3pk/lXewv4XrIaIiGe9aMEGb3JcVC
   3K4FJx+xMcrKH2qhtoKTGkkbl2JySo6/A97bkNf/MsslyAV/XC/BuEpV3
   7i0lB76BUqdYMdcs1yMqe6iPWEAjCPLdMR3SJK049lQVIUehG5G44pE27
   4DlzDRWRVQZ8D8QQhK8htDaN+NjUkyil+oElzdUND7V2YE4QdYzHe19Ed
   aKkT+QMErvYCPNBLd0pr/dUMk9EDUxTrw0LX2jChwNSTmavZNlPC/8mm5
   3oseRrrU3x3w3M5cL5yiCc/pYQDczVZufJdbVMCVJG/tedHr/T6vMxqUA
   g==;
X-CSE-ConnectionGUID: FLWnB1QLRcO0KBMjfJcOLQ==
X-CSE-MsgGUID: LHStrOILSMCpy/SgJieImw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58096272"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58096272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:38:38 -0700
X-CSE-ConnectionGUID: ockQzc0GSb2n4XgrsYUpTg==
X-CSE-MsgGUID: CycRpZ0ETnaGMVnT9tbISQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168897632"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 22 Aug 2025 05:38:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upR2N-000LFv-10;
	Fri, 22 Aug 2025 12:38:32 +0000
Date: Fri, 22 Aug 2025 20:38:08 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
Message-ID: <aKhksPl4YOTlfF8O@ad180832a305>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822123605.757306-1-quic_shuaz@quicinc.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v8] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw
Link: https://lore.kernel.org/stable/20250822123605.757306-1-quic_shuaz%40quicinc.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




