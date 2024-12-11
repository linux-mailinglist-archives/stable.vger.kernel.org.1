Return-Path: <stable+bounces-100605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29A9ECADA
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A520C1888A1E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2DD208986;
	Wed, 11 Dec 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACdpT+oU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD861C5CAC;
	Wed, 11 Dec 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915366; cv=none; b=b9k+2wQ/WrsL/8LNy7AIDtBk43h3ba7Fu+1DK1q2YN0hLUAFabt7cDgvjt1eNbry0DSRwuvx+iQNtAZIxo75ogeCveqanBb4tu6yS4/PQR9tYCmIPtC3as/E0U0AT/8hx0w9A+aFH/SRD2D2dPe4MnfEuqO5/BUxDlDy5hDvYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915366; c=relaxed/simple;
	bh=v46rUQEdI1iE135dLQq98DPBSTcP/lkEL217FYimgpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sfbvCAqqpdaa+kS2Bj9eegHBxOUszFv6Yvwkv3DLSn8rRidcLN3Y8u+7qitjL86ILMaC7K+26VAHgllOhJmd5c8z0VbcWdwwg/Er8dGUGJA5El+hpEzHbn/zdGYUl8KD5rtuJzrJjxBoUftCWa6SMkyGn1i891ntgBUptS9lyzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACdpT+oU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733915366; x=1765451366;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v46rUQEdI1iE135dLQq98DPBSTcP/lkEL217FYimgpg=;
  b=ACdpT+oUVuunujEm9LmHuRiG/nOEX3CGFNG391Jd9DG+yRiCfkCGp2is
   CxyOQVjdTDasKJ5h0G0FaeMLuprhknzNWk2SB3QdJ7Q2r3pahb0Yr1Kdd
   Xbi4Sud9K24FDZTEGUFeuheVy9IDB/AGZkcQaNEzdt6KDq8wDzg10h/MO
   Ky1vGAZx1XZVuEhxRo4XJsZttpe+dya4pY99mXendyx6HE0B1zVrZhnUa
   6rQWZGJNMHJOyRg84jwucbxA7sXmXI1M7it2r7X8kxkbKtU1Cle4x9EmL
   QNeds27pj4gahriqO4iz2GKT3w/oREvNJ101LJXjet0YXx1xpwZBLJ+/F
   g==;
X-CSE-ConnectionGUID: AP6ZUlBcRMaSLxZMWdS9AA==
X-CSE-MsgGUID: KAObasklTFuIDRsPwQon2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="59682781"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="59682781"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 03:09:25 -0800
X-CSE-ConnectionGUID: KeaUiMHVRwylzmxf73VecA==
X-CSE-MsgGUID: sRjwMQwPTCaNBSU1ruw3XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133146993"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2024 03:09:22 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 0/1] Backport a fix for broken avs audio
Date: Wed, 11 Dec 2024 12:10:09 +0100
Message-Id: <20241211111011.3560836-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch fixing the broken audio issue for avs apparently didn't make it
into v6.12 stable tree and playing audio results in NULL pointer
dereference.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219577

Backport a fix.

Amadeusz Sławiński (1):
  ASoC: Intel: avs: Fix return status of avs_pcm_hw_constraints_init()

 sound/soc/intel/avs/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


