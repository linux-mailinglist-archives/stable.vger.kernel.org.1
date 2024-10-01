Return-Path: <stable+bounces-78471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E772B98BB14
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67CE7B2121C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DF01BE241;
	Tue,  1 Oct 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwh61Zmm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE633201
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782273; cv=none; b=CzoaaIKafDkopvFqZdAqjzY7ltUN0VLd5qd49yOcH4x1jlECYCd0i8/b8i7sozKLPtnjkO3kA14qCu4+H2psOeDKzaw02vtbZeP2bK5vYTxsHUPVpnJTQ4OGwalMYWkA22tpDGFzsqrN3rEAzvxaQMJjJNgNvYX/5iKDI1lZzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782273; c=relaxed/simple;
	bh=LuLaia9qLe/YNo6XGGhjQXzsB9UTUBb0B1ClfWTPDGE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i04ttPvrehxoSo1ILSeNhqWnKah3AvgsxZnfxuENW13AEPEu8lvJBJaC4myJBTQjmSyCIGaSBtZr1iRMsK30wCuct7Nv2w2qQ+p1fDSgeNid3VHX5hPpDJTg7yWlahFOUHCb139xFeJKaRHv/drw+Q+RQhizgQ47Lorsb11HRm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwh61Zmm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727782271; x=1759318271;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=LuLaia9qLe/YNo6XGGhjQXzsB9UTUBb0B1ClfWTPDGE=;
  b=kwh61Zmm7K20q5h9ZO0cLV54eWGg86gHZl1kKMHSgDF8HAeqYuO3NbN6
   fdkYsCMspT3e+buXJl8lfyRU/2uv36RyRB1QVNvA4DI+1FiCjGzbioFhz
   u4wNFVUExqcTdxXlFW0uNn4tIMnnUoXAS122h7hZQdeuCwq3stSxMElx3
   SS9926YRDgdNzJ1C4DY0jfZFcr0vyzq6z7f0DPanp/trH7x65fRhwKwnp
   bXTroz925jb43kKZF0B7e+CiaehVHnu0UpZFO0EJBqq3JCS/ff05V/U/u
   zT0VrHq9EeMTTcIKcOsoN/rChP7xvMADm9PYI4uFqZuITxTE0/mhoGtHH
   w==;
X-CSE-ConnectionGUID: GQqK6nYhSrSkVqsoP0DyDA==
X-CSE-MsgGUID: o91ipApyTkuL8UelX4AA3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="38272114"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="38272114"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 04:31:11 -0700
X-CSE-ConnectionGUID: MItKLJuUTYq4MqgDmwBWuw==
X-CSE-MsgGUID: dXxZRQ8wTS+WH0F1Bu3/9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="111110554"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 Oct 2024 04:31:10 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svb5v-000Qbt-21;
	Tue, 01 Oct 2024 11:31:07 +0000
Date: Tue, 1 Oct 2024 19:30:13 +0800
From: kernel test robot <lkp@intel.com>
To: Anastasia Kovaleva <a.kovaleva@yadro.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net] net: Fix an unsafe loop on the list
Message-ID: <ZvvdRctr2YBQayuf@5b378fdd06de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001111840.24810-1-a.kovaleva@yadro.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net] net: Fix an unsafe loop on the list
Link: https://lore.kernel.org/stable/20241001111840.24810-1-a.kovaleva%40yadro.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




