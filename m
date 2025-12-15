Return-Path: <stable+bounces-201028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38410CBD7B5
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 12:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DACFF3006F59
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E732F755;
	Mon, 15 Dec 2025 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIDphC5E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D57314A67;
	Mon, 15 Dec 2025 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797433; cv=none; b=ZmzG9a4lcVndvVuoeAYGx8gUwAWo/IZZ6QyBejhnQheDwN3WB+SJYFDpAL29iChbb/QU7KdjfWzK0TbNdvNaAodYEYHFhdAzqQHLXFNx73U9kVU6/4zbNR7JpVwhEmAvrE9IgGDOCbsYuZ0YUoG1vA5J/E50ytsX0eUutwSyVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797433; c=relaxed/simple;
	bh=PgE/34FVgitUR/gMqcVCEFLuyBMtBbKXHUOAAvoC4Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elCSQfWhCpCUE4dYb5aOdW991nunlPZzTt+99frObQX40QQHJbwZIRBLluIxI5BmcgrP8GWPYfQbPZ/bW2dN9erfeOOYiHLaKIKNUud2pNraM463wvyJ1pt1j4DDD/y/q+LE0SqdbW24OUeq2iqqMgWYD/HIHn4TgOlsyrXPbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIDphC5E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765797432; x=1797333432;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PgE/34FVgitUR/gMqcVCEFLuyBMtBbKXHUOAAvoC4Sc=;
  b=MIDphC5EwQGUA8SrN/Jq8aFsZw9RwnGvPhmgTIRxQduo9xFCjZRQfn6A
   lr7EHUy2140AthnTV0GyYacS0Iwe+skFkJ26fX4iFXSXXwSDRJoUWYxxR
   jpN2wo1APFI0lzZp9RTBC3/hQ9E1ts7K6yW5w84Rsbbfxfk9H3wLD5yvT
   2cJzY329K/eestSarlKHKngqOB74qQdha/sHoo6l303e8fJv9nFiNKyV0
   l7DLUL2exWtX8oKa1B689kbuDfwG0tlqUfOsqZrJsUFeCf/9CO0isKB9B
   SNy9zHHoAGsVPwa5TAk4I1gKAF7IuaVzV9yvPWnDDMYhD9Ss68KxIUI+V
   w==;
X-CSE-ConnectionGUID: DqGZRT8ZSjyrA9ngvKLUGg==
X-CSE-MsgGUID: SgCQyCHHR5WAKgU1fUbUYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="70274437"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="70274437"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 03:17:11 -0800
X-CSE-ConnectionGUID: f4j5+/v3RHCWE9ln/uKt4Q==
X-CSE-MsgGUID: +Mk898CNTiStNTkjdZKlqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202109365"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 03:17:09 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tomas Winkler <tomasw@gmail.com>
Subject: [char-misc] mei: me: add nova lake point S DID
Date: Mon, 15 Dec 2025 12:59:15 +0200
Message-ID: <20251215105915.1672659-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Nova Lake S device id.

Cc: stable@vger.kernel.org
Co-developed-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Tomas Winkler <tomasw@gmail.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw-me-regs.h | 2 ++
 drivers/misc/mei/pci-me.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index a4f75dc36929..fa30899a5fa2 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -122,6 +122,8 @@
 
 #define MEI_DEV_ID_WCL_P      0x4D70  /* Wildcat Lake P */
 
+#define MEI_DEV_ID_NVL_S      0x6E68  /* Nova Lake Point S */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 73cad914be9f..2a6e569558b9 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -129,6 +129,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_WCL_P, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_NVL_S, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
-- 
2.43.0


