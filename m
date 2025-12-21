Return-Path: <stable+bounces-203175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2422CCD4753
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 00:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 706E63006D87
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE7A3081CA;
	Sun, 21 Dec 2025 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGtSHPqs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8FA2C2353
	for <stable@vger.kernel.org>; Sun, 21 Dec 2025 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766360488; cv=none; b=mN4d/I0ORlom+IuNGKjgjRJ6XFyw8v0stYalGmnWh2hOZoCVL0UpLu8i1QVB1VczdOGXA1eUEwbSlLxd3+I/JaKs0RUBJDi4ZmrT7vVWVEf370HjtkVvgXNmHuuIhrU2LXQwRxiwMz9BTkCjaFrpQ7Bl9hpgCUqHky6bfm+FMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766360488; c=relaxed/simple;
	bh=WSvNmAN01FEGfhc3qDajsxIoS8PpgGcpFcTkYh2ilPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jqo4V+a4YcEviDs8DJR06qGnqM++RXASNEXnTKPhqmWtd8Nn81kUvpvimRsBlUE/KOIA6u+M+nYPPlTsNDyUS790WmToUC4DaG52g7ioiqhGGsLTfjAxJVB0MrWmFCueqZzDAFJv/c8+i1N4PB47o+n19s6ddJ53d4g2IHnWAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGtSHPqs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766360486; x=1797896486;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=WSvNmAN01FEGfhc3qDajsxIoS8PpgGcpFcTkYh2ilPM=;
  b=XGtSHPqsvR6jrgg8SGt0EC81Hw4vzyOJXbbPTySIbSH/ogDbIaqF5L6j
   OcVaF2cMcowV8zToPhY7FBszaM/qoQm7tKuR/6dl2S1mqsZHTreud97aF
   0fqinTRQ7mNeBJ37MdVtRsB4e1EkYMNTW6P4FKBsRtaTCENKslJepIYZj
   Td8qJLFD/KpCBytzEupjqLP/8XhkaBq4AODBNMYPWeRPveSl6iXgriRGJ
   5vrBJuZ6CBZQ8KzmL5j9E2Rj3532AGT9nFoRgpRqaPVsjLTfcL331luwc
   Phchor1ZA+v0vUD6Ke7XT8DPzQQIxXnwYlX662RJjWPJ7bgHKD+j40rnN
   w==;
X-CSE-ConnectionGUID: PQfzp3YTQI6CwjCyeKwSSA==
X-CSE-MsgGUID: 2O6u93WsRxK2GEe6F1pH8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68161237"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68161237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 15:41:25 -0800
X-CSE-ConnectionGUID: LsUi/sF7Rq+Hvy57rAEMfA==
X-CSE-MsgGUID: kG99YSRLQkaPy8yiPKsZIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="199028928"
Received: from lkp-server01.sh.intel.com (HELO 0713df988ca2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 21 Dec 2025 15:41:23 -0800
Received: from kbuild by 0713df988ca2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXT3B-000000000If-24Vg;
	Sun, 21 Dec 2025 23:41:21 +0000
Date: Mon, 22 Dec 2025 07:41:13 +0800
From: kernel test robot <lkp@intel.com>
To: Bing Jiao <bingjiao@google.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] mm/vmscan: respect mems_effective in
 demote_folio_list()
Message-ID: <aUiFmTAt-L7eOnM6@c48d18d1030d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221233635.3761887-2-bingjiao@google.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/2] mm/vmscan: respect mems_effective in demote_folio_list()
Link: https://lore.kernel.org/stable/20251221233635.3761887-2-bingjiao%40google.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




