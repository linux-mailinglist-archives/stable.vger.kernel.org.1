Return-Path: <stable+bounces-5880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07080D7A8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFD5282084
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D25537E0;
	Mon, 11 Dec 2023 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7H2k82A"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA11B94
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 10:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702319913; x=1733855913;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=RocPjd2eNWkPQKnRxDp73Jz17fJtzA5sUjwjW0wxTCg=;
  b=m7H2k82A5V42xWIXh+RXO8E4LicOUOs1O9aAnpf4Qf3uyTZfVeCn7S8j
   eA91GeujH8U7JUZcVMFiRwfjP27FP1SnLVGHsi3jztLFWatlntfVHLMTy
   3INFkqw6X3Dq8mZOaA/KYY7Fnb2bpIM6CBw068CnVQgKyAS/mvrNO0AU0
   qv40Lw3zwvWPJhzxZrdF6E3++p0NFvtj7sgjVNc1pZW3h+H2HTIsoYOKq
   QZvpKdn4smPms+xHV9bCwHlVYzAlwHbxROkeWJk6ETWp4qByqKFjwEYNw
   SO/VbIVZc3rBWVYJI8CJFKK+5D24GhdK43BDb1qAqpRv9b6yL9mXcn9Iq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="394441770"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="394441770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:38:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="916950879"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="916950879"
Received: from kbalak2x-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.68])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:38:31 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Matt Roper <matthew.d.roper@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915: fix display ver 12-13 fault error handling
In-Reply-To: <20231208160726.GB5757@mdroper-desk1.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231208112008.2904497-1-jani.nikula@intel.com>
 <20231208160726.GB5757@mdroper-desk1.amr.corp.intel.com>
Date: Mon, 11 Dec 2023 20:38:29 +0200
Message-ID: <878r60y47u.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 08 Dec 2023, Matt Roper <matthew.d.roper@intel.com> wrote:
> On Fri, Dec 08, 2023 at 01:20:08PM +0200, Jani Nikula wrote:
>> Unless I'm completely misreading the bspec, there are no defined bits
>> for plane gtt fault errors in DE PIPE IIR for a display versions
>> 12-14. This would explain why DG2 in the linked bug is getting thousands
>> of fault errors.
>
> I think you might be misreading the spec?  On TGL, bits 7-11 are listed
> as plane1-4+cursor fault status, and bits 20-22 are listed as plane 5-7
> fault status.  Bits 7-11 are tagged with a REMOVEDBY tag that eventually
> drops them for MTL onward, and bits 20-22 are tagged with a REMOVEDBY
> tag that drops them for RKL onward (which makes sense because those
> extra planes stopped existing at that point).
>
> Maybe the bspec's way of displaying things is what's causing the
> confusion?  When you see
>
>         REMOVEDBY(xxxx)
>         [ Foo, Bar, Baz ]
>
> The "Foo, Bar, Baz" platform list is the *remaining* list of platforms
> after the removal is taken into account, not the platforms actually
> being removed.  You can hover over the REMOVEDBY link to see the actual
> platforms being removed and a link to the change record for that.

Yeah. It's not one of the more clear register specs out there. Sorry for
the noise, and thanks for taking the time to explain this.

BR,
Jani.


-- 
Jani Nikula, Intel

