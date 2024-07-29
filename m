Return-Path: <stable+bounces-62425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5397793F0D5
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A20B280E3F
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492013D630;
	Mon, 29 Jul 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Im04tpnp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D013D25E
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722244802; cv=none; b=BRSCJUVbj7y6MMuZWiFNoVelHGxh/+HBqSWw1csfzVNvMJXBNGv/thXip0/FvTDYV8sg4tVSSIdYYLhFHXJjAiHiD2Z85yu0qEK0hxDYVc1JvQzGSm4g4CqLNij1i2NYhgRCSijs7WwQ/+qWh+MRjWVRAnd+zztkfkVvhNilJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722244802; c=relaxed/simple;
	bh=C0PMAJvuAkhCf4LvFnhv/SQ0JEBYOCjCvGLuPyIoqzg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=slpz3dGqLxpPSw+Jg42XM3z5UzqqqT33yjfoLmyEJzZAUJZ89fbSIi8qexfYVVCKYe3I/9qAd8D+jeMXau7I8oUdq7ITyUT6UM0MpTWDSLpQu9TL/bM9f7BR0RylGhZaEZGTDDIISBDuOwmVP1Sgc2P54UJwVTf4DSi0rPPoO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Im04tpnp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722244800; x=1753780800;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=C0PMAJvuAkhCf4LvFnhv/SQ0JEBYOCjCvGLuPyIoqzg=;
  b=Im04tpnp8ECVWY8SmAYBoFiJ18vS459BXldfxRbm48mfedFQFWzwfEdX
   3jJErJik5SMlFhifpmCjKqq3vIljXst/McVzgfXu0as0Zpi8vi0CkyUtp
   HTTq0XzrONXjNOoKjg9rW+oSZG0sGTJrcnzyDzX4NmPeToMtJ8fsslyU0
   dFW6XiaKfE8nS7Sr8AIjiB3X+6ALooZtdsyM0m6jU2wNd8DHjkLZbW0nc
   +2jJ+Y833CamXW8J5BQmlIUCjRLO/y+PWsIb3eKQMWCWfi1oxM87ZrvAo
   AJyO+rfrSTbW8uOzEDrFW1MCafHvyW4a4WZQCBTsb5+rzRUKye5aE/pA/
   A==;
X-CSE-ConnectionGUID: opPcV/+/TmuTNc9GKGZp4g==
X-CSE-MsgGUID: pbITUbFnTnKOZ6WBDrxWtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19589178"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="19589178"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 02:19:40 -0700
X-CSE-ConnectionGUID: meLj4j0WTXe5+dxYf/K/lw==
X-CSE-MsgGUID: d4zsx+M9T2yK1qjMIlUCcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58053959"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2024 02:19:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYMXZ-000rb4-2E;
	Mon, 29 Jul 2024 09:19:37 +0000
Date: Mon, 29 Jul 2024 17:19:22 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2"
 flag
Message-ID: <Zqdemq9YS4vjc3vE@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729091532.855688-1-max.kellermann@ionos.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] fs/netfs/fscache_io: remove the obsolete "using_pgpriv2" flag
Link: https://lore.kernel.org/stable/20240729091532.855688-1-max.kellermann%40ionos.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




