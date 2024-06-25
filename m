Return-Path: <stable+bounces-55156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA079160B9
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F642826DE
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF89149006;
	Tue, 25 Jun 2024 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oB1UcvY+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0EF148FE1;
	Tue, 25 Jun 2024 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303111; cv=none; b=PN1h0+/i4nrzd1bFRNtbXgZcwo2ubpmZOPz2hSflY2fMw7k7bjAM2ZZPzGTxF3556mIafF+KtgmptBPaBuUqiT9fppyGshUnlZ3QVLEu1DP7H4RugXP3th5zb/0ZyPeVhu7ySQ3kZHUoO0KZdfbEkeqtqt5h7FOQO7FRuxkPvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303111; c=relaxed/simple;
	bh=NHZgNFEHSi/ZmfdWXySMy89KSP1gWbhSE59sEMp/cJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgskwlkaFyP+UX7WuJ2ixpBhnz/ugCdPm3igmf1OHvLgjL6sH+2wlgWV7j5ADMLLxBwzktF+/FVkN/fwh9g+jRXlkkbNMoIt1Q6hWpg2hy8gWaDXUdGu2wyqwRORHvCCmXaDJHtiHagwKAx66l2POrlalD/PtdoJ97GGu4TyiEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oB1UcvY+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719303109; x=1750839109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHZgNFEHSi/ZmfdWXySMy89KSP1gWbhSE59sEMp/cJ4=;
  b=oB1UcvY+11EiuCeeh/53QFwzHSc/zoeZKh51hcseNUt1pUHC44wOZ+Fz
   cftzC/Vd7WKUoLIUuw5J3JKyWibuBfkWUhS4xXVi98fiY+wPFwsv4vZqx
   ykbSWHW4NgJyTIcRUFqzSedLGllyOC7Ty4drsnNorAPsgWOkA02Be6uqw
   BCdlfSD7fvAjBL6I+8YAkyj0PBSdKcqMSLs0JIsYbar9/qOmOasT/P+Y3
   zyKlpeZaUD+cAudr3hY+qukaD3FQe5d46O3HXRnaC5cR5i6vfFUv1DS3R
   SsRB3bGiNwxzoqj5PDQ0RujgzNIELgjxrJhvwvcOnNmnjTZO0kbcqg4/h
   g==;
X-CSE-ConnectionGUID: Hr2+/MTbQVOkDFRanSKPVw==
X-CSE-MsgGUID: fdHfGqelRSmJCcG5jHKe8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12232505"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="12232505"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:11:49 -0700
X-CSE-ConnectionGUID: w+C+frjHR6i3jWHP7SVo1Q==
X-CSE-MsgGUID: Vbik8qEmRpKWqEiedy7XLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47944905"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 01:11:48 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v4 3/5] mei: vsc: Utilize the appropriate byte order swap function
Date: Tue, 25 Jun 2024 16:10:45 +0800
Message-Id: <20240625081047.4178494-4-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625081047.4178494-1-wentong.wu@intel.com>
References: <20240625081047.4178494-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from cpu_to_be32_array() to be32_to_cpu_array() for the
received ROM data.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 5f3195636e53..876330474444 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -336,7 +336,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 
 	if (ibuf)
-		cpu_to_be32_array(ibuf, tp->rx_buf, words);
+		be32_to_cpu_array(ibuf, tp->rx_buf, words);
 
 	return ret;
 }
-- 
2.34.1


