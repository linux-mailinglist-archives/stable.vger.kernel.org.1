Return-Path: <stable+bounces-55016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD35914EA1
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA0F1C2069E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA83140367;
	Mon, 24 Jun 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRKgS57z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB513FD62;
	Mon, 24 Jun 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235787; cv=none; b=RMyMo6rqy0mAojeWEt5h/GoG28+kUweoVQFOt5X3ZDzh1u1FN7kZGN0y33708TN9qYUPz7FDUrrN464hVeQwvf7n4WF0yakqUdbE/1L+WHktpLXZkNUNjWrQ09ianPjP+zV7pwjSfWUdwZICrpzF6pJu5NrrGpbFy26gFQX6b6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235787; c=relaxed/simple;
	bh=xIsG2R3uWOMJIdmsjuS0JUaO8Tx4hQq+TFIWKfoNBiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bg0Bq66lAvUCVp5NVvc45qdFYJ6PGN5r9QVmY1ROcGDibmlUQtJa5LQTlL4P8TOzAQzC7hVtPEtlNOLFrV94DpfuApq1Y/BusryCI9j58VF55w0ku0rniegu5ThE91MbGZROVbibwi3dE2mKNIYIl3kYcvjIMkx1A9GWQxAw7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRKgS57z; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719235786; x=1750771786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xIsG2R3uWOMJIdmsjuS0JUaO8Tx4hQq+TFIWKfoNBiw=;
  b=bRKgS57z2lEKbX5WXoRZdE7yXhILHIP9tJKWoetvI/dk8aEF2sgcTykl
   5PBSHm0twTrPINjhXSBuWMTcQKzKvi+dYkywCjyhSxwdHYDR+seDsdU11
   LIzxZbWGjopUaZFnDAi8EL+wuX+nyWT8R0qSa72Wsh0xeUZHJj7woO4eP
   VVeJYnvORs2Ff4/EbKUIZwH7UaE8LkDHeR9FfeL+d4EEXrdTFCo0nfn2C
   IsYHRDFGFlJZ7sSRp//GDPPb9LPFxnB7VgB99CnNIQPH7jgmEfl3lFOV/
   SutgIMMPXmNE+epKQQrzhOQDetXxrBOjqK7z3iF4Ix4xn/9L31xVEpi+6
   Q==;
X-CSE-ConnectionGUID: rY8cOEF4QU2WSidjsh3UAg==
X-CSE-MsgGUID: QQU0rmo7T4mtzlks/C/t1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="26830742"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="26830742"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 06:29:45 -0700
X-CSE-ConnectionGUID: eRi+SNWrTxe1e+BHUoIFIg==
X-CSE-MsgGUID: gfnA5DfbSiiFy1QBfd2LcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47746699"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2024 06:29:42 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v3 2/5] mei: vsc: Enhance SPI transfer of IVSC rom
Date: Mon, 24 Jun 2024 21:28:46 +0800
Message-Id: <20240624132849.4174494-3-wentong.wu@intel.com>
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

Constructing the SPI transfer command as per the specific request.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 5f3195636e53..26387e2f1dd7 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 	}
 
-	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
+	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : NULL, len);
 	if (ret)
 		return ret;
 
-- 
2.34.1


