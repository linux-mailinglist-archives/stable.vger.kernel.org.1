Return-Path: <stable+bounces-143020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9EAB0DDF
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96597174523
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3724C27464C;
	Fri,  9 May 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR+ro0yX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFF21FF23;
	Fri,  9 May 2025 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746780934; cv=none; b=kn4AY8DYITM1evIfMZ/7cCfJGns/rOyGTA/9jifxuq0cbQa2ysTo+ghHQK/gev2/EmC8eAUOqMO4hfm+wF8f+ZUr04kThVAtOwzkbmvgGo1k1jVkQ2fY3vAXeVV8oB3UhGKFRdTbo/cjfVd8ClM9qLETRtGUiaIodB5LtkYvGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746780934; c=relaxed/simple;
	bh=3KNYYB6S7E1pxVBypS4/4CVtkEzJcIBkx2/ciYwChZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZaRXtOryBnybv5krX/rliDesti4E2NnpOc7TKRTM86VyV58BmMk2UpJrwaVWBQ+l1raFPCTyA/ReEY+7UuEqXcYBe3Yh7OjwQkiv31U4dpBasyOAzlGGUOlSNJ7qMY8sw///awLJS9jDZRZ3o+/H9XAn75wn6zI7ldaTxYPXmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RR+ro0yX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746780933; x=1778316933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3KNYYB6S7E1pxVBypS4/4CVtkEzJcIBkx2/ciYwChZ4=;
  b=RR+ro0yXG4MtJYCyWNPvi9Lcf5cEi2kBNsK9NtDzjz1p+ZNe5YJJQiPe
   auvxQFpg1v12jNBZvY19Qz1wLtxtUMduJelhoGcfwB7N7kcscGcFdjU1k
   HRYPC7jCVP3NuLaxIJCqVsZ/KdmFLuPqhqjOfTr7lmwh6qoSIRCKgaGuf
   sW9VrSravG+fpurDQy1lE92iDSNMr4ochFWIIJulZghgH0rHrXbRXncKB
   kkM8UEv0KCVyaUSKl8gn4FdNb572zZxq7mm9dVNddeQZEO5v9U1yrspEv
   HDCWyLmObfGvFOiwZ3KvlIJSlvjjM8d1YFezQMA5CsOSlFQRLbRZZocvA
   w==;
X-CSE-ConnectionGUID: 3+zTpTHSTdq8Z4jFvsOrBg==
X-CSE-MsgGUID: 3dj0hr/0S2OAlXMxxKF5lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52253936"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="52253936"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:55:26 -0700
X-CSE-ConnectionGUID: DEfVyEI2TISQESanm79CCA==
X-CSE-MsgGUID: UGj1lN11QgWXclmgCj79Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136444717"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.132])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:55:22 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	seppo.ingalsuo@linux.intel.com,
	liam.r.girdwood@intel.com
Subject: [PATCH] ASoC: SOF: ipc4-control: Use SOF_CTRL_CMD_BINARY as numid for bytes_ext
Date: Fri,  9 May 2025 11:56:33 +0300
Message-ID: <20250509085633.14930-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header.numid is set to scontrol->comp_id in bytes_ext_get and it is
ignored during bytes_ext_put.
The use of comp_id is not quite great as it is kernel internal
identification number.

Set the header.numid to SOF_CTRL_CMD_BINARY during get and validate the
numid during put to provide consistent and compatible identification
number as IPC3.

For IPC4 existing tooling also ignored the numid but with the use of
SOF_CTRL_CMD_BINARY the different handling of the blobs can be dropped,
providing better user experience.

Reported-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Closes: https://github.com/thesofproject/linux/issues/5282
Fixes: a062c8899fed ("ASoC: SOF: ipc4-control: Add support for bytes control get and put")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
---
 sound/soc/sof/ipc4-control.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 576f407cd456..976a4794d610 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -531,6 +531,14 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 		return -EINVAL;
 	}
 
+	/* Check header id */
+	if (header.numid != SOF_CTRL_CMD_BINARY) {
+		dev_err_ratelimited(scomp->dev,
+				    "Incorrect numid for bytes put %d\n",
+				    header.numid);
+		return -EINVAL;
+	}
+
 	/* Verify the ABI header first */
 	if (copy_from_user(&abi_hdr, tlvd->tlv, sizeof(abi_hdr)))
 		return -EFAULT;
@@ -613,7 +621,8 @@ static int _sof_ipc4_bytes_ext_get(struct snd_sof_control *scontrol,
 	if (data_size > size)
 		return -ENOSPC;
 
-	header.numid = scontrol->comp_id;
+	/* Set header id and length */
+	header.numid = SOF_CTRL_CMD_BINARY;
 	header.length = data_size;
 
 	if (copy_to_user(tlvd, &header, sizeof(struct snd_ctl_tlv)))
-- 
2.49.0


