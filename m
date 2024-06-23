Return-Path: <stable+bounces-54885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5391393F
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 11:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F001A1F2234A
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 09:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734C82C67;
	Sun, 23 Jun 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSWWOgLq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58282C76;
	Sun, 23 Jun 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135163; cv=none; b=YnzjA3Chp2UG4S4bwzlpklUCetCYKr3bNaXMuMhZUFCoHWt+ORg2zG/LELkqYU9PP48Hz03mP8yMhTD6J5W0GXWGs/FapYyFKeHRaNPGuLM4NgXrbga4SbgKpw92+t4BH0hBqeD9qstk5josTPTWSb2CssfXRUQJWmHYZtsCRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135163; c=relaxed/simple;
	bh=cEeXCxkP09Nlfke0tgRhA43h1ZuuPItJ3/CFcKSQk+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=niWBzPJJjtDDztIuFIVMv+LvxKXndTM7MzXoFnOLllHJm9HzJ43YPyt3cfPenLzjP5XsHXM2VG7Rr61/jmtwX5I4GbH0y1/JEaMDEJS30WRiQps3NseB8wn5jXN8BxCKe622apvM9fZB6nZxnguInTm7SGgFRCqMtUKGhY4i7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSWWOgLq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719135162; x=1750671162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cEeXCxkP09Nlfke0tgRhA43h1ZuuPItJ3/CFcKSQk+k=;
  b=fSWWOgLqlYb752eXZzrVqoKnPWQhkYnj4g+ON2jCpffeg3KIoy4XvCHV
   cRCS6DdGebvtcfZICKsXi2ki/n3nvbzuttFsP/2glmVyXbT3pAkgqhmcM
   8RBPos3xhjYmy63O8OFbPCJYgz8lv8dEWtZEWJ0bcPP5TpXk/ZvlZkhXP
   tg8a+bHky4FOeiPM6gEe5/vh9Wr5HcftEJkk+5k3lV4Y21BJ0LFmoFIPp
   z8IpjIOAcc+oiS0SWkmEHhXO0KMWrdlNUn0Kaa0pdC7m7hQMSMhTV6WH5
   g3RDthpZAKjgO79QnvTDs0JlmwHZ3p5Tf0vBVTt3nmDkdRLit+umU2biw
   Q==;
X-CSE-ConnectionGUID: zzt0KeJTSzy1C6+y4NEvVA==
X-CSE-MsgGUID: XzN+xNHqQiOog/RIkdnkzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16089095"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="16089095"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 02:32:41 -0700
X-CSE-ConnectionGUID: /ERllLhMR8+qRP/BuBTf2w==
X-CSE-MsgGUID: 2LMqLRu/TQKZ5B4O00P6PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="73761747"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2024 02:32:40 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH 4/6] mei: vsc: Utilize the appropriate byte order swap function
Date: Sun, 23 Jun 2024 17:30:54 +0800
Message-Id: <20240623093056.4169438-5-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623093056.4169438-1-wentong.wu@intel.com>
References: <20240623093056.4169438-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from cpu_to_be32_array() to be32_to_cpu_array() for the
received rom data.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 7a89e4e5d553..381d7ba4f98a 100644
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


