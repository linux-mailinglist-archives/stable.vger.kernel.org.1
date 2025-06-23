Return-Path: <stable+bounces-155332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA724AE3B03
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3133A3D4F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 09:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6822DA0C;
	Mon, 23 Jun 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cn/oaTGX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BE2A1AA;
	Mon, 23 Jun 2025 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672045; cv=none; b=pRdVij8eidO6xrx02A72kwld6nqG84dJbKftD/bOrkLimDErh10l19HhI82cKXjO+iqDxuRCGrKgMYJJVurmnuiDtPsNzlgdBV6J+f3GEEEQdOqAdtWcCDlMlKTUN48+s41DnTY0dvm3RoGzoG336lBUKY2NCOEDd3tnMA1ayjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672045; c=relaxed/simple;
	bh=vYuqwwHqFuRMGFMlzSTUPSPchST16s1IUTyFV/5VtsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIunBxYL2wy68l9BdxL2tgNJ0IthKbVcXRkCLSv2jYaD+j4vNlQ186ymnkcmbcLWan5lSEoWQY5UjuU2vWc23iZedNMU2P02izSko5yzU7XrTeL7g1CNen5dv40Mw3CS+o8D+gTULPU/hKCMz7Sl0+FytJ+XCNSbWUzMAhW/k8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cn/oaTGX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750672045; x=1782208045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vYuqwwHqFuRMGFMlzSTUPSPchST16s1IUTyFV/5VtsE=;
  b=Cn/oaTGXwmH6u+on+uViZXspv1P82iZW0oA8bXjY3FtDR8V2Dso28scT
   IKkfbATvbkGLosC2L44phqdOmiudfTqqiTu1XLRjS9UmzwIRZkJQ6Mi56
   FupG4dU2ps3jFfCK330bcGDihIOUmx1S5dqYH8lwGFG1Arl8XktmUlCQN
   Q/V/sy2u4FSVbhVL/6O320krRXyqVVLWoRKwBVduyY6LOdAS9Wht09jEz
   ID5VuEXHi3xJsbdNKwMIgZUVxO7GpVbrTZBVkM9IIOkDzuiMjhWKFAAXQ
   rdF938PCBaMCfwdNzqeGvXxzOBmOGlzT+EJJGNVD2ffkq+kLocja5ihnJ
   g==;
X-CSE-ConnectionGUID: yGqE7zSSSdG0l1SaVJsv6g==
X-CSE-MsgGUID: FPfCjBcxQIyc+qD8Nmke5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52095735"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52095735"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:47:24 -0700
X-CSE-ConnectionGUID: fJof2gy0S/CMaPKp71RUZQ==
X-CSE-MsgGUID: ijNwKqF8SRyYVEp0LHcqvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="156096901"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 23 Jun 2025 02:47:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 63E55108; Mon, 23 Jun 2025 12:47:19 +0300 (EEST)
Date: Mon, 23 Jun 2025 12:47:19 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com,
	michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
	stable@vger.kernel.org, Alexander Kovacs <Alexander.Kovacs@amd.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] thunderbolt: Fix wake on connect at runtime
Message-ID: <20250623094719.GV2824380@black.fi.intel.com>
References: <20250619213840.2388646-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619213840.2388646-1-superm1@kernel.org>

On Thu, Jun 19, 2025 at 04:38:30PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 1a760d10ded37 ("thunderbolt: Fix a logic error in wake on connect")
> fixated on the USB4 port sysfs wakeup file not working properly to control
> policy, but it had an unintended side effect that the sysfs file controls
> policy both at runtime and at suspend time. The sysfs file is supposed to
> only control behavior while system is suspended.
> 
> Pass whether programming a port for runtime into usb4_switch_set_wake()
> and if runtime then ignore the value in the sysfs file.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Alexander Kovacs <Alexander.Kovacs@amd.com>
> Tested-by: Alexander Kovacs <Alexander.Kovacs@amd.com>
> Fixes: 1a760d10ded37 ("thunderbolt: Fix a logic error in wake on connect")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to thunderbolt.git/fixes, thanks!

