Return-Path: <stable+bounces-65477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727B3948D8E
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 13:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15DE1C223D2
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5D1BE860;
	Tue,  6 Aug 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4P4WFNi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED113B2AC;
	Tue,  6 Aug 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943234; cv=none; b=nSimS6wQlp0DP1lb2bZPPm45vDP8CU6pvuSynwsdSL1oncJkEiaAuN3XyuHKqGhe67pIXu4nmIg4RLiEXUigQ6Yd4K5fe6Zagtml1DnFGGv+DMOYzUEGyMZrA/B6jPbTONw/1xq1xLewN0qLTbB6tuDVDqS1rqcTYlJngqIjpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943234; c=relaxed/simple;
	bh=7TIBgK+dNhJiyWA3QNNIyIX543Wff4gjFDCPn9FEUKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wm8iQ1zgH3u5Ixcfo1KoxVJuwywKwW5LDNrUXaaf8npgcPfASn3zPE3/9du9nT6AZeYZdaEGRj2qZ9tQwOJnvtpEij4V6+U4DidFnOYQj2icdvPQhM/V+NLf+a811xJZiYeCza6kDRBQN40aE4VCXC0PLLoxUpXyi4PN2dHXH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4P4WFNi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722943233; x=1754479233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7TIBgK+dNhJiyWA3QNNIyIX543Wff4gjFDCPn9FEUKs=;
  b=d4P4WFNiUyzlPsDmeVCDm21SRD7rPb1sXbxlNMJHBdwtpAxyp10Y3iDN
   4u7W7kjh3Sy1j36T7WxRzzWbxo4VmjaBR2NLfDwHM2KbDvaTsY3ZIwnTO
   VJ3jLrecK09HE9Hpap9+XwI+YfhfYgDlbSJAFF8J7h7STB0IqeS59DVcZ
   OeZm145l+RjwTzJgUKF/bI+pevIRD4MQQR0yYtbNjh9BWuYQxFhzcThrI
   CfG1n0I6y0o3i5+LIVZpfovlZ9TrYEGHPGmPsDRKNUJfDtHBhFD4/wAlv
   lk+d0Ul6tiLCpFwymlBoE8xirgmmYoo3O170RYCylgt63cnQxsoRjuxG7
   A==;
X-CSE-ConnectionGUID: iU+nlmsPRuG/Yw2ZUS+MQQ==
X-CSE-MsgGUID: i2yJHgpVR86oGgyOLyVcDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="46355734"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="46355734"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 04:20:32 -0700
X-CSE-ConnectionGUID: 1MAd7I74TDWhkvagvGp9iA==
X-CSE-MsgGUID: Y8df3/3FQ6Ojr0gnxwUYtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56180075"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 06 Aug 2024 04:20:30 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-usb@vger.kernel.org,
	Luciano Coelho <luciano.coelho@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Fix a deadlock in ucsi_send_command_common()
Date: Tue,  6 Aug 2024 14:20:29 +0300
Message-ID: <20240806112029.2984319-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function returns with the ppm_lock held if the PPM is
busy or there's an error.

Reported-and-tested-by: Luciano Coelho <luciano.coelho@intel.com>
Fixes: 5e9c1662a89b ("usb: typec: ucsi: rework command execution functions")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index dcd3765cc1f5..432a2d6266d7 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -238,13 +238,10 @@ static int ucsi_send_command_common(struct ucsi *ucsi, u64 cmd,
 	mutex_lock(&ucsi->ppm_lock);
 
 	ret = ucsi_run_command(ucsi, cmd, &cci, data, size, conn_ack);
-	if (cci & UCSI_CCI_BUSY) {
-		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false);
-		return ret ? ret : -EBUSY;
-	}
-
-	if (cci & UCSI_CCI_ERROR)
-		return ucsi_read_error(ucsi, connector_num);
+	if (cci & UCSI_CCI_BUSY)
+		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false) ?: -EBUSY;
+	else if (cci & UCSI_CCI_ERROR)
+		ret = ucsi_read_error(ucsi, connector_num);
 
 	mutex_unlock(&ucsi->ppm_lock);
 	return ret;
-- 
2.43.0


