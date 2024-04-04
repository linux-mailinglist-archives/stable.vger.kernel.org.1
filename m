Return-Path: <stable+bounces-35927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB88988C9
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87781F2B19B
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F191272D3;
	Thu,  4 Apr 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Th7SXE+V"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98F86AEE
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237317; cv=none; b=UlN+eE/hrhLx5oNa2bwAFJhG90MKxIf6dQNqak2RoUEh8ZCMJmI/LokekmUhHRfoIiCbY8oCFI9cbseGKCxf9nhZ2bwoe6qNxmlIaoJZ+CY7g0FgX9K0he6UJTsTxbeaJtzD2fd4hWpdC9gGYY6YhmQmYcNmemRccDIozhD4jbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237317; c=relaxed/simple;
	bh=zL/o2dyB0jowlGfVpgC3DOHrmnHMiWgMY0nIbEHPgnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BSdGwQAaGnbn9i9uzP51r4kNqWvFkLyyKf3lsXdqjKmDDNU/notPSU7++rIWlsmPhLTkHuGRDrc3VPwznR1WhYGInv9VHIDTIWsBkRAeK7073t04xs7a4c1QaYVFTRY4DMDPNMBXZApXrJmNU/QpQkLvRM4BY6TpUIC5RkzXPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Th7SXE+V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712237315; x=1743773315;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=zL/o2dyB0jowlGfVpgC3DOHrmnHMiWgMY0nIbEHPgnc=;
  b=Th7SXE+VF6FHhk/mA3CzT7SWRIFyCCyBu03Qj0E/yNYENqQUhWv4aQ+K
   yKO+ezhYbn7bPJ/hPPzh4CpScuju/4WjaQOgLhA48Mxc6bVxdqnoztPGE
   LB0Ru/c7kxfJ226BZmGyJzKV7K0U6NeLo/YLD7S0xZ4yMhZDiCXB9F2So
   M5KaoeTiZbTqS49arbVxDgNFCjXkuW+kgb9sHTI0iGnefp7X/TKWPJpHj
   jRafwBwAg2XfAXxHK4xF+iwR6O3x/ONSEl6AZl3nSqMhONnJVT/x6GucL
   rbx6jrX50jizsKXmcCQN59duy8za7nTEwA193xrhHdW22GeiozxJvvqQ3
   w==;
X-CSE-ConnectionGUID: gbDYw3qJQWalFyWMT31nmg==
X-CSE-MsgGUID: +V8mtAnJScSZFSsilzu1rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11291425"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11291425"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:28:34 -0700
X-CSE-ConnectionGUID: 19c3ccOMR5K2dwTjcWQy9g==
X-CSE-MsgGUID: SZDJqoRQQ9mofuSroIgfjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23541894"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:28:34 -0700
Date: Thu, 4 Apr 2024 16:29:04 +0300
From: Imre Deak <imre.deak@intel.com>
To: stable@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Subject: v6.8 stable backport request for drm/i915
Message-ID: <Zg6rIG0idN3NSTbP@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Stable team, please backport the following upstream commit to 6.8:

commit 7a51a2aa2384 ("drm/i915/dp: Fix DSC state HW readout for SST connectors")

Thanks,
Imre

