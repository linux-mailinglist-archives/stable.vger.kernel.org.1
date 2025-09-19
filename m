Return-Path: <stable+bounces-180685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D96B8ADBD
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3F51CC366F
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA9256C6C;
	Fri, 19 Sep 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDqRi4s3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAEA1D8DE1
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305294; cv=none; b=ipu/Wx6neopYDeC2jrlRY5ZiWw+ad7B6wMiKsnNl7g0qQvn+r0Q39Rto4fZEe3bXT9XMPdU5njhFieCJ+S9l/c64MwHZUB1U8P9kGlFo1ySBzSW8M54OJHRsjCS1p2wkiGFcKMXezI0yTlgNnrbEe9VmzqQxCQLQuzYZCtjm3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305294; c=relaxed/simple;
	bh=d+IpnihDr4NXdRPvmqmk0qIWkC/FYIAhSuLCT190ba8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h7uylT4JKGC5wBFRKGT+LPF93Jm05Db5oW0OoOTw7WvkQHkSxfU6DTYS8YD2wzLNSmH8TXLfKqw0YVWVDvJIXObxUv89FBTRNR4SWIkbld7rRUYbMHIi/u+Vd7CfTncb8gd0tMayiooLXh5JobcgFWxG9HXrke+GYiNSfg+AsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDqRi4s3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758305292; x=1789841292;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=d+IpnihDr4NXdRPvmqmk0qIWkC/FYIAhSuLCT190ba8=;
  b=jDqRi4s3mNKi+aMPyat6cYqLGLkDBv0oM/ykGG1kl3iTSHdfJbraVaGE
   b+/ria3yaiXwURgLjABreIlZ+FiKr6hXhYP6oXkqdgY0uorG5/PwyMZb3
   KjahGwSwnNd1l7u3DJZZVLH2vtesTIjYlYGekOBI4V5jT1aakr1meoB+j
   pZ85mm5JfnPmHwIEd3TSSs2app6dxHANkaZDrq7zKGu3Te/IhIP3Xumcc
   hdujgUNoKZ/DiOGtV5DC0hbkEJobfThRfVc5sTFSrlVJWX7zJmNx7FiDk
   XQwR0KYDPAsGqR7v/H0faMlPWezTgE3k+oVmxZkWkwo42WBEcDDiFXJI4
   A==;
X-CSE-ConnectionGUID: jVtAFcixQ625oxhaPS2+SQ==
X-CSE-MsgGUID: cIvfMb4TS0q6DxbK5tnjdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60712313"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60712313"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:08:11 -0700
X-CSE-ConnectionGUID: AxerEPqZR5atSwmZ4HU/VQ==
X-CSE-MsgGUID: vbGHOtBXTF2EzcKvayIs1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175698571"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Sep 2025 11:08:11 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzfWh-0004ed-2X;
	Fri, 19 Sep 2025 18:08:07 +0000
Date: Sat, 20 Sep 2025 02:07:43 +0800
From: kernel test robot <lkp@intel.com>
To: hariconscious@gmail.com
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] net/core : fix KMSAN: uninit value in tipc_rcv
Message-ID: <aM2b79FnV-yP1ZPs@f1e5f3f3c112>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919180601.76152-1-hariconscious@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] net/core : fix KMSAN: uninit value in tipc_rcv
Link: https://lore.kernel.org/stable/20250919180601.76152-1-hariconscious%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




