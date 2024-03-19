Return-Path: <stable+bounces-28449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0988058D
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 20:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34F4284565
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7A839FFD;
	Tue, 19 Mar 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJyYx9pm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A4383AC
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877131; cv=none; b=EH/TlJLnnXAXYWkuG8pQ0YXsxUhkvpecUCSoXnWnu8ewHRoIYeed5c1X4JTP1oL6k/sEpblcTfoWY3HdD+ojIutZcz0ouGUpVEGbKJLlLuKTRurNKxoIXQwSDoYe1aXprpmI/SQnPbAAn2nKYPdC7UZXDbifecVVYYRG0sNlH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877131; c=relaxed/simple;
	bh=u2QucK29aRzlK548ra10IX8j7nKFsI0TbBH/OGaVE3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BnfN+EG/S24PhQj51FvjhUdwHYO3KjtLlyLF8D6quCiiJzFhYR28yyFgALuOkb6Eb/QE9s54roc+m2B6kzhr3pOdvV0yppP/xy7S+vcXGfAIcaFxrAnxwz8oS5PzZAQBWZy8MyRng8LBVa2MLXCfD25a15vPGKsfvUuEHsQtBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJyYx9pm; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710877130; x=1742413130;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=u2QucK29aRzlK548ra10IX8j7nKFsI0TbBH/OGaVE3E=;
  b=mJyYx9pmdjn06siQ/CxBYLS31VdkLooU3a28gEitnQkrkivYvZiuKYIu
   yd/We3hLTeWHs4YOun/cGDeboEPh8b4SRqw2EE4tYT1Lpww86/GUBshmp
   mZ+8cQyd6w6MU5PFOdDeRjsntuDY3mDQEA/yd1ZvzQ4c6WT/lxKo7ERVp
   0CIJd5NBcL9AHgiIbSIVAAgkfqOmLzSslvNKSX+Ydz/gtko1QXKFJydEf
   Un6jENfBg2dGtDwOtrd5BGDE0EUmPhkU/sRXhR/Gw1sAAFJHUL2/mrmMj
   Oo2A520G1D1eRAtP4p58vTM9DXPzPPqnSgDhHXlP7OiSniVkh4KNBU0HE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5651894"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5651894"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 12:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="827782265"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="827782265"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 19 Mar 2024 12:38:46 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 19 Mar 2024 21:38:45 +0200
Date: Tue, 19 Mar 2024 21:38:45 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: stable@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Subject: v6.7+ stable backport request for drm/i915
Message-ID: <ZfnpxcS2dXkzlExH@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Patchwork-Hint: comment

Hi stable team,

Please backport the following the commits to 6.7/6.8 to fix
some i915 type-c/thunderbolt PLL issues:
commit 92b47c3b8b24 ("drm/i915: Replace a memset() with zero initialization")
commit ba407525f824 ("drm/i915: Try to preserve the current shared_dpll for fastset on type-c ports")
commit d283ee5662c6 ("drm/i915: Include the PLL name in the debug messages")
commit 33c7760226c7 ("drm/i915: Suppress old PLL pipe_mask checks for MG/TC/TBT PLLs")

6.7 will need two additional dependencies:
commit f215038f4133 ("drm/i915: Use named initializers for DPLL info")
commit 58046e6cf811 ("drm/i915: Stop printing pipe name as hex")

Thanks.

-- 
Ville Syrjälä
Intel

