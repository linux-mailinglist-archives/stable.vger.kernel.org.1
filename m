Return-Path: <stable+bounces-55154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7319160B5
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7C61C21B2D
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918E1487D5;
	Tue, 25 Jun 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bS59Ybso"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A61474B8;
	Tue, 25 Jun 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303106; cv=none; b=NFgl1XH3/fI/DAlQSo0oNzZPG43EUFCW8uh8daGznjOXMjcMUl9enDROvx8QEQWgStdiBipUxmU7J/WyHVA8Z45w7iS0/A036jyE44zIhQ7cfepKgXBR3p7LQulyR/lZ4oZUm0j+OJy/NyTN+EOiE8riPw+2p2NC2GdM4v9k6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303106; c=relaxed/simple;
	bh=dQSS+cisNfaft2A5cQ4bXxLvcIiPOe9EipzRaGlA4QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyNeJct1w9L9nCLnJxljWr5X0LQLVAupaZ/pq1BIXi7Im3EcEfxI6zAkXTg3aUehFBF9NDbLIeGQM3QudlSxz5ZGCpc7RjraDiCcSEKTG7UdphAjx13CAjWNtzWU23dKDvBWuMvTWtd1sZrXl3cqmqumhTbRtOp7H0/FQPZowDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bS59Ybso; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719303104; x=1750839104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dQSS+cisNfaft2A5cQ4bXxLvcIiPOe9EipzRaGlA4QI=;
  b=bS59YbsopAqkSP3afURYz1huHAjlEihAdTY9x4IRhhxZF9K7raG8qAO5
   LmaX/kmMtkJx4iVv5r6ajn1PFsOaGnBJQ9Q5IUjApq2tqeNz5v5CW4w3m
   krBEz7v4EIyvdQ0LDIF/Qj9rWFXSoP3S/kiQPdMGZJQBHmaekk5Yx0YQ/
   CJnZzzgHc3mJWHjP+xE+nh3PNbDDuUKgz8Z039gWh++poGPDnAJkLvuLM
   Aljmn542RqsUhOFmTl5A5qA6IkOcqyTLSkKFuO/UlojnV9LcRIfPAWb5m
   lbVF8RL2PuOHq5NkruhrPkMrj8n11Juu9oQSFSUNVvXjXq6IGCR6RjTS7
   A==;
X-CSE-ConnectionGUID: +qk7eB0UQZCSLIhn0QCGFA==
X-CSE-MsgGUID: gKOhmVeKRUmnKUXio5MEKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12232501"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="12232501"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:11:44 -0700
X-CSE-ConnectionGUID: QqpJtJ98RZuhswRACDjn4g==
X-CSE-MsgGUID: YQsl12d6RimXHYcZVrSz8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="47944896"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 01:11:42 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v4 1/5] mei: vsc: Enhance IVSC chipset stability during warm reboot
Date: Tue, 25 Jun 2024 16:10:43 +0800
Message-Id: <20240625081047.4178494-2-wentong.wu@intel.com>
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

During system shutdown, incorporate reset logic to ensure the IVSC
chipset remains in a valid state. This adjustment guarantees that
the IVSC chipset operates in a known state following a warm reboot.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index e6a98dba8a73..5f3195636e53 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -568,6 +568,19 @@ static void vsc_tp_remove(struct spi_device *spi)
 	free_irq(spi->irq, tp);
 }
 
+static void vsc_tp_shutdown(struct spi_device *spi)
+{
+	struct vsc_tp *tp = spi_get_drvdata(spi);
+
+	platform_device_unregister(tp->pdev);
+
+	mutex_destroy(&tp->mutex);
+
+	vsc_tp_reset(tp);
+
+	free_irq(spi->irq, tp);
+}
+
 static const struct acpi_device_id vsc_tp_acpi_ids[] = {
 	{ "INTC1009" }, /* Raptor Lake */
 	{ "INTC1058" }, /* Tiger Lake */
@@ -580,6 +593,7 @@ MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);
 static struct spi_driver vsc_tp_driver = {
 	.probe = vsc_tp_probe,
 	.remove = vsc_tp_remove,
+	.shutdown = vsc_tp_shutdown,
 	.driver = {
 		.name = "vsc-tp",
 		.acpi_match_table = vsc_tp_acpi_ids,
-- 
2.34.1


