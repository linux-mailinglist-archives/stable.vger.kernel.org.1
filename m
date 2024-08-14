Return-Path: <stable+bounces-67676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC73951EFF
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E563B1F23CFD
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DAA1B8EBC;
	Wed, 14 Aug 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ge4ULKRh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE71B8E8B;
	Wed, 14 Aug 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650433; cv=none; b=gaJFSQ/MgSBnNRp6G6fmKZdUrLFb0YWCSfFeUiqEYjVPk12++aByvg/glsqwAkdIYMeWbVtQxNUOsol869OLc6dGOtKf1jJk1e6u7I8be0fbNaa2nTNxNFCxonsw1SP0cOiICt27EXXK666idAJj0vsosIVQPUSUYxGieD+TPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650433; c=relaxed/simple;
	bh=CbEh9vZsDIkvt9w/RJG8miSMP2IpSdBMNNw0Z+T+ZdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hKx6+PgN3R79drdRyqyew51wjwJ/BwMsOGrhFhN7HX3eMMnQue/oVJXaKX7qmdki10BLYelFXKTrdupv3ZUI00XOBOygNcpeLR9AHA4HPPr5YeWQLilF0wPgr8UYL8riSvuqZstnLVtbBkrQvQOkQ+MmwRv1hpIvo/9UJH6pP/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ge4ULKRh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723650432; x=1755186432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CbEh9vZsDIkvt9w/RJG8miSMP2IpSdBMNNw0Z+T+ZdQ=;
  b=ge4ULKRhHEysgANy0pQCyrNzr9CWFF/xv0JdMdngXjOppQ2vrtyJqZZd
   r/7HPpLipj2gqSHpY0IrEpDHU3kIb0X9+yEZFyxZh07cVlvXSzbFCPH7Z
   1ZYBpCoIqC0BQRHnrTtc1HdxTovQeFM8lMBxMPOFrq+bc76nDok0GFqF/
   MPREztIV0lj9TIgRqPqHOC/rK7bYhji8q8Mgim65Ux5+sh/Bg/TWHgf0N
   vNsom74zoD3qrZRVmJzhkIgno9WTlJdz7zQ3ctWdnYdtzcYauZ/oIaY0n
   V0VW89mYdl6PSlGgmgCw1fwPr3ccdBYHoEdJn2yzGSD4g8DHxtS1TxuEP
   g==;
X-CSE-ConnectionGUID: NFVANyKMSriEk2Nx7mz/Yw==
X-CSE-MsgGUID: g0QRuBFuSHmFheC+dmK7Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="47279481"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="47279481"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 08:46:58 -0700
X-CSE-ConnectionGUID: nkE4UlE0QZCydyjUw8BQRw==
X-CSE-MsgGUID: W2wVLuKMQZmrfa/wcWgPog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="58936548"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2024 08:46:55 -0700
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
Subject: [PATCH for stable v2 0/2] ASoC: topology: Fix loading topology issue
Date: Wed, 14 Aug 2024 17:47:47 +0200
Message-Id: <20240814154749.2723275-1-amadeuszx.slawinski@linux.intel.com>
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

Should be applied to stable 6.1, 6.6, 6.9.

v2:
 - Mention base commit
 - Sign-off patches again, as those are cherrypicks

Amadeusz Sławiński (2):
  ASoC: topology: Clean up route loading
  ASoC: topology: Fix route memory corruption

 sound/soc/soc-topology.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

-- 
2.34.1


