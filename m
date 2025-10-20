Return-Path: <stable+bounces-188135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CC0BF2098
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 959AC34D903
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4EF24168D;
	Mon, 20 Oct 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVNe/PLM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03967149E17
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973274; cv=none; b=OH+zHI33OIR5FToY9rEJyOeJ9GojYsSOBAaUxAgcaXnWS53fuNXmViEoPAoa7WiyHbcC0PG+qpXjAJM+ZFtTcFSeFz72AoXUJYtlsSjnJ54PN7FnAJ0A3F+bdMHh8cH2K5qzmdmgAUT0RB/c48lilJULIYalVPsSR1C0ZcBf2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973274; c=relaxed/simple;
	bh=vLJ6nVrrFHG2HYJmabRbMGOw/7MUIewRcCP9ikJT+y4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=clcMTSgmF5xyyaV+jIeaXHQENKfjWmDc0uo45weJ8WqwJdlFNlaBWhSdpPStYCutI5WYmBtQfJwEuqmnvULbdZBL+YiY5pApcRGAYJmfjlNIwXTuSUVs7EB14T2ichTR2wnl/+VHlea0BJxEtUhfDzvlIAcEce4eiIoHjHK+6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVNe/PLM; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760973273; x=1792509273;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=vLJ6nVrrFHG2HYJmabRbMGOw/7MUIewRcCP9ikJT+y4=;
  b=JVNe/PLMmG2pw/zmI3ysYZdWryH5Mxg62ML5xLviUF5+ZKfV/d8uZ1jV
   I1faZ86mzRY46cPmnttYDdr7ph8xs0s3j7/5wOqHNJ1bU8HGCI+6i17XY
   AOVu76VQSNa0KxT+h7wwgbTfQ39I0V/80Ajh1ezsIi5iZ2qlEffp2rS7T
   nccTtScTB5roscMIp6m6oUJQaxJyY3D6R5G4ngB0CcxDcX2R4U/gvfDeN
   c8AVXHNufL9Pob33Vr3eFd7tSv4q+0wzkcR0Ilq3tyBCEmPeqm1Ub91Yw
   nuBrKc0cXm0tNbv/xq1gXPD/KcWdJKBhI7MQBs8XvRnQ5h5GIiNEcUujX
   w==;
X-CSE-ConnectionGUID: K3xgcdFOTEqUwzbx0n9dQA==
X-CSE-MsgGUID: zIsEZTnwTQ2HC74xGcug7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74526305"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="74526305"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 08:14:32 -0700
X-CSE-ConnectionGUID: jDEOJHbFQ/O5wrAMZLr/gQ==
X-CSE-MsgGUID: v9bIdW3kQkq3gd+XEGEBSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183194989"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 20 Oct 2025 08:14:32 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vArac-0009w9-1o;
	Mon, 20 Oct 2025 15:14:27 +0000
Date: Mon, 20 Oct 2025 23:13:40 +0800
From: kernel test robot <lkp@intel.com>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] rtc: amlogic-a4: fix double free caused by devm
Message-ID: <aPZRpDqWDPPVR8C0@c50de720c4f1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020150956.491-1-vulab@iscas.ac.cn>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] rtc: amlogic-a4: fix double free caused by devm
Link: https://lore.kernel.org/stable/20251020150956.491-1-vulab%40iscas.ac.cn

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




