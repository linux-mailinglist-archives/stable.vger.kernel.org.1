Return-Path: <stable+bounces-67656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADB951C90
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABD7B27787
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AFD1B32B1;
	Wed, 14 Aug 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gG3IXTHx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE3E1B29DF;
	Wed, 14 Aug 2024 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644370; cv=none; b=QNY+J5Cc3hNPMN7Zh6uI9hc0HSB6y1CNGTm6yVmF6+cvMRUBxd5pkU116zQkdbKrQp907SkXEEN6usYlSbpY1k3F6tHkuCn6OlB/2rJRVI4nSiXv3/lLB2LhmJT/M8Li1P4aww4oBRe2wcvKI3vEfvxb0JS9YEFZKInMOr9/BAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644370; c=relaxed/simple;
	bh=hXbD/MNaISTuwz3URmp0i6sywhLG6Vsf/+KsLDYciYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kiUNjFQ92UDA4v22qp4Gw5k28Ea4N7BqAg0GA3A4+oEa/thN3ZIt+FWbeN0e/W4qPKr58o9ICueC/1EO5rbn1BosZFDxTA4TVOlaKMhbACDy8IM/gb5uSNwAiesucvQupel7Iu8xVW1/vUqgU7GvrNTWMqp354+DeXSkUqjvYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gG3IXTHx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723644368; x=1755180368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hXbD/MNaISTuwz3URmp0i6sywhLG6Vsf/+KsLDYciYk=;
  b=gG3IXTHxhq4jYf17ewTM3XFbwPTmfxovdRab8UFu7FIxcXWJXx1RjGsI
   ID9fWItWgCKt1ajl2HXrsJ8y8TnK7j17zX3NjC5jVwv5CjHpmRpiY/zAB
   raBMEcMo2AO26SmSc+9VU2Af3wRDIjvJ58Sv1p2kS/Vhxtf9mi/JbbmeI
   hlCCh8/H11nYLYVfb8d1yhpHEIFIE3+AbaTuYbzh7OUTr46pyGgASpsLW
   dKdr1JLAc71vu8VJ2cYNpZW4iOVvgmyhFKaLj7QWyof50r1YDItM/fzIt
   u/7edUqVXuNIb+VOJ0fX2TWxDVaovaPnrOmhleQfw8CZO88iMY/b/SlTT
   A==;
X-CSE-ConnectionGUID: OJ/CXYWuSpOGmWb1ZGnapQ==
X-CSE-MsgGUID: aNUXrdhDRfmNaOLt0apc3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="13010061"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="13010061"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:06:07 -0700
X-CSE-ConnectionGUID: TUucd5uGSj+7BYDcONmK6Q==
X-CSE-MsgGUID: tw5v2nbrSXuMCYS3yB9cfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59305655"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orviesa006.jf.intel.com with ESMTP; 14 Aug 2024 07:06:03 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	tiwai@suse.com,
	perex@perex.cz,
	lgirdwood@gmail.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Vitaly Chikunov <vt@altlinux.org>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH for stable 0/2] ASoC: topology: Fix loading topology issue
Date: Wed, 14 Aug 2024 16:06:55 +0200
Message-Id: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 97ab304ecd95 ("ASoC: topology: Fix references to freed memory")
is a problematic fix for issue in topology loading code, which was
cherry-picked to stable. It was later corrected in
0298f51652be ("ASoC: topology: Fix route memory corruption"), however to
apply cleanly e0e7bc2cbee9 ("ASoC: topology: Clean up route loading")
also needs to be applied.

Link: https://lore.kernel.org/linux-sound/ZrwUCnrtKQ61LWFS@sashalap/T/#mbfd273adf86fe93b208721f1437d36e5d2a9aa19

Amadeusz Sławiński (2):
  ASoC: topology: Clean up route loading
  ASoC: topology: Fix route memory corruption

 sound/soc/soc-topology.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)


base-commit: 878fbff41def4649a2884e9d33bb423f5a7726b0
-- 
2.34.1


