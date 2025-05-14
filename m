Return-Path: <stable+bounces-144300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40EAAB61E5
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92AE7B15DE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47791C8614;
	Wed, 14 May 2025 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYwvh/ZZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8826ADD
	for <stable@vger.kernel.org>; Wed, 14 May 2025 05:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747198967; cv=none; b=G1xEYTUgjz+tk5Q5F9OGOq0eOMiqMr5Yk4/fxUfpfjEGH9ycNicAEYpyBuDRcmZ/iMqHBkz+bHODg/IjRIosp7VMBge9oivekjmagcwpM5KBFx1vetcNdHdKPcXbEwa9s+D3ZaQxGkfmmujLPFVWxsCeFVJxspVtKBkB8OA69Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747198967; c=relaxed/simple;
	bh=CP6si3lPNmmlvflVpDvWXIYZhbR1rhQxjCs4eXjrq/s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gcrUvJNA302/go39UUI73u/hCJ6Kl3vTquH/n+zbpD6B8xlSeJh5aJIgE4qHBAlWz6BKYibkV0FmM8qwjMtpp9gCEIjDqJHvuaOHb+pS0IEXTaW1gjYbejdntFHkOUR1h9e14MJ0/RPjUe8aXHBJLbv+ziOXBfHUlu/8NXyRSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYwvh/ZZ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747198966; x=1778734966;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=CP6si3lPNmmlvflVpDvWXIYZhbR1rhQxjCs4eXjrq/s=;
  b=HYwvh/ZZGB2rHh0krD6iEf5yrGoSPtBbaQYcTN8spHHfpi64ejhf2M+m
   htSWoy3dWJ3HYCfeWCWtABmmCrQdLOHg/UTf0VXDosL0l2jmVTU3dz5b3
   /+Gd99Gk/z6BRfq33jq/zHekMQCxakMW1zaqK0AISjBCNv0gU1tXTUqo5
   Fn09mL5oJC5wFmiX+Hvq0WiqOZcilqGIS6GYgC90njtvZ9ZcwL9rSI/yL
   /bE1Y3Ixq4wyXgx18QfKpFBAX0TDEadGBfVx0bDvrrokZtSZstFGd/tdj
   kUmJuNYyKNFAwliPLoXwPQZvVx/KfqGoSp/9MYp8B9jsOVCaNrEu2QoAA
   A==;
X-CSE-ConnectionGUID: /qpvUyWLShOKWcIbKnzBdQ==
X-CSE-MsgGUID: b4v7t//LRCK5m1oYuph/og==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49054705"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49054705"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:02:45 -0700
X-CSE-ConnectionGUID: M+06pidTR9GnVFhswJgGRw==
X-CSE-MsgGUID: Kz85LDEVTyKNKZ81J6GUTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="138416549"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 May 2025 22:02:44 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uF4GQ-000Ggx-0L;
	Wed, 14 May 2025 05:02:42 +0000
Date: Wed, 14 May 2025 13:02:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/4] crypto: octeontx2: Fix address alignment on CN10K
 A0/A1 and OcteonTX2
Message-ID: <aCQj0nmkJt1vkBEF@75fa4dc5d8b3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514050020.3165262-4-bbhushan2@marvell.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 3/4] crypto: octeontx2: Fix address alignment on CN10K A0/A1 and OcteonTX2
Link: https://lore.kernel.org/stable/20250514050020.3165262-4-bbhushan2%40marvell.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




