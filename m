Return-Path: <stable+bounces-196996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257FAC8957E
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 11:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD20F3AA6A6
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1263195E8;
	Wed, 26 Nov 2025 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1kuWUas"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E99315D32
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153695; cv=none; b=Z37ZjMf/N6oJxhfXKUhWOENl5COrZdGvWFiQQOxLMNsZGfDKzsz7So+Zb+kvLq6pbUgSihH4FHB9duDgI4MFRtccstVBaejDgEfBwabGbZjTaZfGIvyddzqlKTt1ngbWzb60LYH11Gl/+SoWDRYMUnm/oS7LFl9P4hXYqwW7rl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153695; c=relaxed/simple;
	bh=+3uf068jfpFAlV9UhJ2AOkoYFxdA8zg9MQS5UQDCqZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j4bFTm/IQ4u6s4/fcK/disM6It09EMmJowZKSRFyllHuwZjKhsKZi2CApN16axHzrpZsoR8C2EbG2idPEvNmpLTv34zmoRdgqrnhOB40KxOuuq0b3lJoEmka2fIV5vdJK/ZtRIhwvGX4AcRJICKeIZHOad6GbqSp/WUdBhSqBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1kuWUas; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764153693; x=1795689693;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=+3uf068jfpFAlV9UhJ2AOkoYFxdA8zg9MQS5UQDCqZM=;
  b=m1kuWUasQ5zmEcIPOTx52u10tKd7dY61b+0sWFrhNZnl1XysRg7vUSc+
   JqgBxx+2YnXS2tDpu4cW2OrDQ+tb2yOxOwSro9RvI7NmPdPmPqVbXg6/l
   PtP397zhZb6sBNFHSFDuH8fV4ahHMxgKj41L4TngdTt36+R3Y4yq9pgU0
   3rUrfWvmFERpj7/JZTZLBOVzSINLfA163Qi7mhDwXGZ4g2tH9nJ4OSFoJ
   qvbkb7ZdQRBte/VJ3SAwg4du76mcZULAvzHBU2e1egZc5sTr4mK/ESDLc
   e1tC/5FeQUjBO0BrLCDGQNwVWVl/TvF/yzcEP+e+ggaMl965/5eM8CkkR
   w==;
X-CSE-ConnectionGUID: HY4DYGyWQpuTWMRPePMBjA==
X-CSE-MsgGUID: EUlLdmvZRli1wTw7IVM4lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="70045409"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="70045409"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 02:41:32 -0800
X-CSE-ConnectionGUID: m4C3dgZRT5OT9DyO8KPYTQ==
X-CSE-MsgGUID: q0aizKdSTSaN+SFibSxcoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="197069984"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.1])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 02:41:31 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: stable@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org, Ankit Nautiyal
 <ankit.k.nautiyal@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Subject: please backport 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3
 when sink doesn't support TPS4"")
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date: Wed, 26 Nov 2025 12:41:28 +0200
Message-ID: <ae09d103eb4427f690685dc7daf428764fed2421@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Stable team, please backport

8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't support TPS4"")

from v6.18-rc1 to v6.15+. It's missing the obvious

Fixes: 584cf613c24a ("drm/i915/dp: Reject HBR3 when sink doesn't support TPS4")


Thanks,
Jani.

-- 
Jani Nikula, Intel

