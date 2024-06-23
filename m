Return-Path: <stable+bounces-54882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69485913939
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12A3282317
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441017F492;
	Sun, 23 Jun 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zjj8sv7u"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235DD51C;
	Sun, 23 Jun 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135145; cv=none; b=Hv2wlgdtta1u4cx6LJKyfAm/iK+9KuLl9Ys34wJs3Pi9HTklSDvj5ic25XTcNTTa3vf3N71+216rRlvaMzm7Wg2TXWMVyO3gDMdtGI+PORQYxYJomvFHVkTt8PJO7+yr5ZsPzZ1K8u6u5DvMIry34MUhUvflhDCqtM5Q03zdUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135145; c=relaxed/simple;
	bh=o+ppC9cqSZaFmTTXQs9RvqE76Ildur/5zLcTVfC39hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8Tt6/RXbQfHtDp4+huK2NhcNsx6AN8spF8XOx3D+O6XjrFMiwzW1fWKknjnF+kizA4+dyyc7uzysaczw1uZGa8TvnDpOv0dZ1iQ50SveekYRBgZdDExjppaWaWVXLIwSFPeZ4oQC4GTGiAeB1FI6Vh4MORplCL89Jqu0iq/XYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zjj8sv7u; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719135143; x=1750671143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+ppC9cqSZaFmTTXQs9RvqE76Ildur/5zLcTVfC39hE=;
  b=Zjj8sv7uyLnhIjxtcYYh9IUiFQ2R/oreF6vD8IfYMp/L3zxLsgilwZwG
   VXAV/raj1NHKjUvzoO2w5UQqP6TyFPAQW/98CnkTtf/fNKrT9hYHZpHeV
   oXnG1EBJUSGnM1WCn4x9ZVkeS1flMQLNkXwIbJO7lLo8WcyCJbzQvVc4c
   d9SpbyEM7NP8AFu+ENDLb/dG7Q315zkAYKrxatz/KyKqUQhAb9ol5feha
   vL/Ll9Qrf7wsQZwvOO2L+UKpmW+zb6PQps9dVP/aKeXQjNNN8nqMiEhWC
   I5oS30ciJPwWv4dnzi9ngNNXYbGl131k1FB9M5H/oQP9JBfjAqGGFMdeG
   w==;
X-CSE-ConnectionGUID: T6dKxOzmQnGlxLU0TuCQOQ==
X-CSE-MsgGUID: NG2ukBj/SBagNhIO6k83VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16089078"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="16089078"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 02:32:23 -0700
X-CSE-ConnectionGUID: 0zZQzj9EQYqUsncoeReyXA==
X-CSE-MsgGUID: 3C4DSRbIRtWyvz8FuqJd1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="73761700"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2024 02:32:21 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH 1/6] mei: vsc: Enhance IVSC chipset reset toggling
Date: Sun, 23 Jun 2024 17:30:51 +0800
Message-Id: <20240623093056.4169438-2-wentong.wu@intel.com>
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

Implementing the hardware recommendation to toggle the chipset reset.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index e6a98dba8a73..dcab5174bf00 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -350,6 +350,8 @@ void vsc_tp_reset(struct vsc_tp *tp)
 	disable_irq(tp->spi->irq);
 
 	/* toggle reset pin */
+	gpiod_set_value_cansleep(tp->resetfw, 1);
+	msleep(VSC_TP_RESET_PIN_TOGGLE_INTERVAL_MS);
 	gpiod_set_value_cansleep(tp->resetfw, 0);
 	msleep(VSC_TP_RESET_PIN_TOGGLE_INTERVAL_MS);
 	gpiod_set_value_cansleep(tp->resetfw, 1);
-- 
2.34.1


