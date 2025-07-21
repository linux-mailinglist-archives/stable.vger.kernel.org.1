Return-Path: <stable+bounces-163621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A68B0C9CF
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 19:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7B5542BE8
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899D02E2670;
	Mon, 21 Jul 2025 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9SqYWgk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2852E1C5D;
	Mon, 21 Jul 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119466; cv=none; b=Um8/qAeb0BYr0D89W3c1PLX+ZZ4Wmbyp6Wvt4cbyyeSSg0//FcNn4SqYfXbQ0tWk82TWoswu3sbVUnXulw7DiKy5RdBrGY4x0LWNWDmbgegk8m7fjL7Z4R8/ThqN5pMR/RneL6J6ywIoJ+RhL0a+IXkRVui3wLEersVtPPuvT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119466; c=relaxed/simple;
	bh=ofK6BShVrOsSDYA+Q9gf44K8Em3AzZtcZABwx9y8WNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBnCj8GNexC61aPqhFNQnTGmKXfG2n3cQxbLxN/1eC24deLMU5CdLSXiPVWZ9dx5b1lqJsay2K5nYaU4x8QL1ZFbg/Qh/7RnDYblA7G10Uk2KPoaE77Dlp+BK3uUFzLAnQ/5RGfV7vyhM6H11TpEYF1lDHujdnxYi9NaMLoHCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9SqYWgk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753119465; x=1784655465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ofK6BShVrOsSDYA+Q9gf44K8Em3AzZtcZABwx9y8WNg=;
  b=C9SqYWgkZxBK7xMH0ql3fuANC83FWyS2xAbnScPQxIg6qPWqr/LSK2ye
   KTxZEXwiO/93n/U9ZnuYOgIqtjODijpItucc2Fa5Qyeg0hjx7ILjslUtG
   cgnh42o1gxHKneUWzjizDgy/WDD4DNn6cTJzqd1unwGCQiL/VPl6QDozN
   WjAmggN+xpjX1t7M172sRMo8arkGoTTykfHNknhqIx35WuCyHWIfaRtjb
   yRElfWa+ZB3gLy1vsReLFeY8ZPb/sryQqVF8w0MDPZQwE1eEnamnxEQmq
   KFEeyEYlV+pq4d9KJPVI/u4wLOHCrbOXwtCVnnzZDHFrakIYioV8onYNe
   A==;
X-CSE-ConnectionGUID: iMDFMPDjQzyc2nBNbjoPcw==
X-CSE-MsgGUID: hvpszUPzSpa3cRJ9V3RoNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55193198"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55193198"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:37:41 -0700
X-CSE-ConnectionGUID: rdWYTuhDSeKvRlseEz7Y6w==
X-CSE-MsgGUID: dArM/ylhQheHtbeFi2lFtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158231571"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 21 Jul 2025 10:37:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacek Kowalski <jacek@jacekk.info>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 4/5] e1000e: disregard NVM checksum on tgp when valid checksum bit is not set
Date: Mon, 21 Jul 2025 10:37:25 -0700
Message-ID: <20250721173733.2248057-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
References: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacek Kowalski <jacek@jacekk.info>

As described by Vitaly Lifshits:

> Starting from Tiger Lake, LAN NVM is locked for writes by SW, so the
> driver cannot perform checksum validation and correction. This means
> that all NVM images must leave the factory with correct checksum and
> checksum valid bit set. Since Tiger Lake devices were the first to have
> this lock, some systems in the field did not meet this requirement.
> Therefore, for these transitional devices we skip checksum update and
> verification, if the valid bit is not set.

Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Fixes: 4051f68318ca9 ("e1000e: Do not take care about recovery NVM checksum")
Cc: stable@vger.kernel.org
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 364378133526..df4e7d781cb1 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4274,6 +4274,8 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
 			ret_val = e1000e_update_nvm_checksum(hw);
 			if (ret_val)
 				return ret_val;
+		} else if (hw->mac.type == e1000_pch_tgp) {
+			return 0;
 		}
 	}
 
-- 
2.47.1


