Return-Path: <stable+bounces-96912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCE39E222C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC902163C74
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EA1F7587;
	Tue,  3 Dec 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jFX4X1Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9971D9341;
	Tue,  3 Dec 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238958; cv=none; b=aZ2AgXPo0jR5/O9okCW5MvWh5qFfY1xcpsxPanLUQTXcsDPu0TbqVLv5m9FCanC/RWa+Mmq+C7R4cwnFpfj3cPoapixAxMoMDUzQHZznRw+EZVImmsijhz4ScpwmFC20j8+TueS6PQ20rLOemeht+CeTIbXklTB5SUbb+SJ5ZKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238958; c=relaxed/simple;
	bh=hmL6n13IUjZDh1NU9Qc06VBxIT8p4MXvOOkclkSX6lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAFepyfp2iTd024n5ix1OgzilGw3nMvZhEsNeleWbBCAiFuuut0fWO1/XmMWCplaCNSaEtms+Soe/gTlq9qIgHS3gCfx3qjDbc8VaAR3Rsa3s3/AOgOSeNkMHGaL5amrJCFWMN0zAz/4tLc4TiDYuXvEs+ACH5BIuBNGL6rSeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jFX4X1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BC6C4CECF;
	Tue,  3 Dec 2024 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238957;
	bh=hmL6n13IUjZDh1NU9Qc06VBxIT8p4MXvOOkclkSX6lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1jFX4X1ZjNlC8vhTc6sOQjTySleAhEeYOtgtwKL68CASKwcH+PHHRQpOjfu+TIJTp
	 UX9Z9d+wd1qdEVJKplGIYITc5DsBq3bNlab/774x7/m/eJfAXn0DGP7UJFuaP5sebR
	 Uuv0Fk53mSYsp5SP1xG4+y7Yp9r0xR+FBN648udM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 456/817] dax: delete a stale directory pmem
Date: Tue,  3 Dec 2024 15:40:28 +0100
Message-ID: <20241203144013.675459526@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit b8e6d7ce50673c39514921ac61f7af00bbb58b87 ]

After commit: 83762cb5c7c4 ("dax: Kill DEV_DAX_PMEM_COMPAT") the pmem/
directory is not needed anymore and Makefile changes were made
accordingly in this commit, but there is a Makefile and pmem.c in pmem/
which are now stale and pmem.c is empty, remove them.

Fixes: 83762cb5c7c4 ("dax: Kill DEV_DAX_PMEM_COMPAT")
Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://patch.msgid.link/20241017101144.1654085-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dax/pmem/Makefile |  7 -------
 drivers/dax/pmem/pmem.c   | 10 ----------
 2 files changed, 17 deletions(-)
 delete mode 100644 drivers/dax/pmem/Makefile
 delete mode 100644 drivers/dax/pmem/pmem.c

diff --git a/drivers/dax/pmem/Makefile b/drivers/dax/pmem/Makefile
deleted file mode 100644
index 191c31f0d4f00..0000000000000
--- a/drivers/dax/pmem/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_DEV_DAX_PMEM) += dax_pmem.o
-obj-$(CONFIG_DEV_DAX_PMEM) += dax_pmem_core.o
-
-dax_pmem-y := pmem.o
-dax_pmem_core-y := core.o
-dax_pmem_compat-y := compat.o
diff --git a/drivers/dax/pmem/pmem.c b/drivers/dax/pmem/pmem.c
deleted file mode 100644
index dfe91a2990fec..0000000000000
--- a/drivers/dax/pmem/pmem.c
+++ /dev/null
@@ -1,10 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2016 - 2018 Intel Corporation. All rights reserved. */
-#include <linux/percpu-refcount.h>
-#include <linux/memremap.h>
-#include <linux/module.h>
-#include <linux/pfn_t.h>
-#include <linux/nd.h>
-#include "../bus.h"
-
-
-- 
2.43.0




