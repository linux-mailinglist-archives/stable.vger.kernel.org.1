Return-Path: <stable+bounces-55017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95380914EA3
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523D9284749
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CDF1411C5;
	Mon, 24 Jun 2024 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1CNnFJA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599014038A;
	Mon, 24 Jun 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235790; cv=none; b=Rib89wMZyZ/FOTkFFTKiLfshdHOvH9IiOOoqQpsnUjQzLAIGENu5zoEigvQ46aGpW/le4LPc2X6UExasEbkXRxC7hR03cFU3dSrZTvQiB+C6wSEKwr457SRY9j19hWuFWczXFZoL6s/RRY67lzTbPuQ4VMJWIJu9i9owhcL/oLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235790; c=relaxed/simple;
	bh=UZbBhq5qQXvf1/MvNlBj2IT7czxIpQmTilPKU1BJNX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsrclPhKgOY8JF3KNc6nvQLQlUbdFqQ4hJjM5716iYxKOObzCdZB8pExaKBhk3JvQYsWSHCA5/D6SFy24lHq6rGsCwlgIYMIFPWrjuyyMKmhdZZtne0q1CU2liRQgDB089nh8eAAL7P9N0Ul24JXlUBw5NW62bjuweAbvZPTZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1CNnFJA; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719235789; x=1750771789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UZbBhq5qQXvf1/MvNlBj2IT7czxIpQmTilPKU1BJNX8=;
  b=i1CNnFJAo2AX6uXOoHvvFO6JVT8BcVOFqWr3BZJBUDpM3LgX3eS+WucD
   VfbbxuK096Dlb92dtkk+wvDmfHl571fZMcVmAev4knFOu4SxFez1XOjt3
   UIEpqNJvWYj1PproWk21W31mI1wHKN4It0hIdCBntjBBPbqTEImyxX7je
   YjobRU+7MnN0HHIAON8EiMsZDQKXEMUf4ms4ohgpdBOQ2m69Prj/i3y48
   L5oAzZ1ltQsaL39XoHe8ckVUGvDXkXB47oxx/+sSQCzDtiCDNUTw1sDP6
   oEuTOOUxUSv3icZC6yHbjxvO/QP7BNkI02csQyxr/ITPHqyZWNWUoIH2w
   Q==;
X-CSE-ConnectionGUID: 1oP1fLSNSYWEpzfFvRlRbg==
X-CSE-MsgGUID: fzlC/WqmQfa2YlVCRDWArg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="26830747"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="26830747"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 06:29:49 -0700
X-CSE-ConnectionGUID: 7JY7TR8nTD+D3QR4kmM8pg==
X-CSE-MsgGUID: rQy/JB2/Tk2sBVEgCQfaAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47746718"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2024 06:29:47 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v3 3/5] mei: vsc: Utilize the appropriate byte order swap function
Date: Mon, 24 Jun 2024 21:28:47 +0800
Message-Id: <20240624132849.4174494-4-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624132849.4174494-1-wentong.wu@intel.com>
References: <20240624132849.4174494-1-wentong.wu@intel.com>
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
index 26387e2f1dd7..1618cca9a731 100644
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


