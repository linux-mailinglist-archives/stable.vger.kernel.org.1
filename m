Return-Path: <stable+bounces-196998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E6C895DC
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876B03B1DE2
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2037931B825;
	Wed, 26 Nov 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvR33Zcw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738D72E8E13
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153913; cv=none; b=QWavFFZt0wSUD692Au6adJ5CU+tcgbVywitLXWJX+zv/on/Xl2z4FZH1HPnwoBnyVEDuSmLnAiIzby/AXXr68YkGNPC44N2/xX3uMUI2+sLXfwVzlHz0s+nG3+dCjF35eLdSoBYlz8+msxGHRdeTkTDtVQlg/rUR0vOrX2zrMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153913; c=relaxed/simple;
	bh=K2I05FyzOw/B7mEwnNX/H/SxRDfdkwGp4wCutW+BGA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WF5LDT7WuondGe56zDMuh0sjUeFzcvl6L3QqKYUX3KUmVXKlGLXkqFcSFn922zzuZMLvlFvyQCEEdRBIKFd7etsr+HROAO/bhTgX5xlxDc5mLRIRcFwBB+dvRUY1xiOAHeXTh8Oo/sUIPo4I5h10rfKKl/MOKnSx5lMQvT0oIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvR33Zcw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764153911; x=1795689911;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=K2I05FyzOw/B7mEwnNX/H/SxRDfdkwGp4wCutW+BGA4=;
  b=NvR33ZcwYdvh5DQM+UKfb6eLCKzWrdVmAjNg6vKVbSS+aVO2BB6NO8nh
   2xqHhHnMmQ/0Abfqus2uDF0n7Ikrd2WoGUFvg8tW8bsBxmuDqS27pmpNf
   Gt1vt7ZMZqKv8kEF03F5TxmCsGATsjT5jcoil+0iGC/qjt7qI23BDxury
   TzmehSjLMK7hUETJ7DcoLUfRgKGUJaKL7AfnJI6EpY3bYOUO/GbSEM7f3
   9Ok9xQwe1qSj4s5B9YtJyjD6bmbjP4zVIcU+CwJL18e1cwFf3weiqNvBA
   Xkd9K7opiZ/EGYmUF3C367bhLnP15VMnvRwfoDZxIJCOxNI6eKgcXoMHg
   Q==;
X-CSE-ConnectionGUID: iGSNrNx8TiOdAIxlAoj0xw==
X-CSE-MsgGUID: 6dermV3DTJGU7r8X8IUs1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66071888"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66071888"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 02:45:10 -0800
X-CSE-ConnectionGUID: or3qt/oUTOGsLVEFGazTJw==
X-CSE-MsgGUID: k09cuyPFRziGmRLznoR7Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="193332152"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.1])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 02:45:07 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: stable@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org, Ankit Nautiyal
 <ankit.k.nautiyal@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Subject: Re: please backport 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3
 when sink doesn't support TPS4"")
In-Reply-To: <ae09d103eb4427f690685dc7daf428764fed2421@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <ae09d103eb4427f690685dc7daf428764fed2421@intel.com>
Date: Wed, 26 Nov 2025 12:45:04 +0200
Message-ID: <5b080d938b4a6132e407d956a37fd079dbd71a67@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 26 Nov 2025, Jani Nikula <jani.nikula@intel.com> wrote:
> Stable team, please backport
>
> 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't support TPS4"")
>
> from v6.18-rc1 to v6.15+. It's missing the obvious
>
> Fixes: 584cf613c24a ("drm/i915/dp: Reject HBR3 when sink doesn't support TPS4")

Oh, please *also* backport

21c586d9233a ("drm/i915/dp: Add device specific quirk to limit eDP rate to HBR2")

along with it, as it'll fix what the revert breaks.

Thanks,
Jani.


-- 
Jani Nikula, Intel

