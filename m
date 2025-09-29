Return-Path: <stable+bounces-181958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F4BAA1DC
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC43E3C84FE
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382F302170;
	Mon, 29 Sep 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KpSpEJzg"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D33626ACC;
	Mon, 29 Sep 2025 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166282; cv=none; b=JE5EzH6/CQbtntngh2Yu/8+0NNwyUyZzMAM3TmnMAP6b5oHi8vKYb5bHco0pfDMclfa5OrQB8c7xsZYHTe4Jl9KwM3DLtZIQy5+QvJS4DQ5rtr27GZO13cqoBJ5AY4srnyA8Xa7+0asaKmaPJTnZ3fcE5vL7s9MDOrGW8OOy1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166282; c=relaxed/simple;
	bh=lzywvl0/2SbhGOuqVDdcgYucQs8SCzbDgO4M8OMRxcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rC02mWfYeyfjMfJwXRydDfahvJOREx5LdLPTFX6VOllW/KckkDM61u7aJk0ZI/D/672T/Kj5MEgwEOdFznTNhBpeneW6zBBZJCvckmuMUrvfSWEBYW3bWTmW/N2ElPUjo6Cmi+ZC+BjdW4NfvQ2jXzlgh8nRE5KxACbBGNV3XmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KpSpEJzg; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759166280; x=1790702280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TDV161r/7qFlBicXIybWhTsXZSPWT6ddjPuQfDuVP8k=;
  b=KpSpEJzgcWOtvKkq70JFOEJXHx7tkJo6XkrquT/sp+ry6KsfXVSfiDAK
   LBVn9w6HgpVDvdXEHiQzZ6urNqzGrdPkMGfmbx0qDx59Wjt/T6ufvR31R
   CYewg7XUpi7oQNJ3CWLSHGuTWiYX1+tJb34YJuee/TuJEtffMEVFe45n3
   3VqujDLNLlbIObhDi3oS1JNOA2HQf5Vdku/kH4yyJ2NPFqQk/z6TSbQQP
   eSPNXpDdwwx4yNvq8L8TeWM535Wz3krflcQiTESbULY0t19P40v3/c1UV
   gHw4BXrkx2de7ubJsM5sOjxfLiL148bZdBdbHNZVE79vNkfAfLSuPROhW
   g==;
X-CSE-ConnectionGUID: CW+y+aigQ8CusFi4VtLkcA==
X-CSE-MsgGUID: yF3oAc84Q/ytIOgFWVIuMA==
X-IronPort-AV: E=Sophos;i="6.18,302,1751241600"; 
   d="scan'208";a="2740067"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:17:57 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:5274]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.40.83:2525] with esmtp (Farcaster)
 id c1822a22-1090-48cd-a4f5-a1062bff3e7c; Mon, 29 Sep 2025 17:17:56 +0000 (UTC)
X-Farcaster-Flow-ID: c1822a22-1090-48cd-a4f5-a1062bff3e7c
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 17:17:55 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 29 Sep 2025
 17:17:51 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<mario.limonciello@amd.com>, <lijo.lazar@amd.com>, <David.Laight@ACULAB.COM>,
	<arnd@kernel.org>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<farbere@amazon.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, David Laight
	<David.Laight@aculab.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v2 03/12 6.6.y] minmax: don't use max() in situations that want a C constant expression
Date: Mon, 29 Sep 2025 17:17:24 +0000
Message-ID: <20250929171733.20671-4-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250929171733.20671-1-farbere@amazon.com>
References: <20250929171733.20671-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit cb04e8b1d2f24c4c2c92f7b7529031fc35a16fed ]

We only had a couple of array[] declarations, and changing them to just
use 'MAX()' instead of 'max()' fixes the issue.

This will allow us to simplify our min/max macros enormously, since they
can now unconditionally use temporary variables to avoid using the
argument values multiple times.

Cc: David Laight <David.Laight@aculab.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         | 2 +-
 drivers/input/touchscreen/cyttsp4_core.c       | 2 +-
 drivers/irqchip/irq-sun6i-r.c                  | 2 +-
 drivers/net/can/usb/etas_es58x/es58x_devlink.c | 2 +-
 fs/btrfs/tree-checker.c                        | 2 +-
 lib/vsprintf.c                                 | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 12618a583e97..c1962f1974c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -708,7 +708,7 @@ static const char *smu_get_feature_name(struct smu_context *smu,
 size_t smu_cmn_get_pp_feature_mask(struct smu_context *smu,
 				   char *buf)
 {
-	int8_t sort_feature[max(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
+	int8_t sort_feature[MAX(SMU_FEATURE_COUNT, SMU_FEATURE_MAX)];
 	uint64_t feature_mask;
 	int i, feature_index;
 	uint32_t count = 0;
diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 7cb26929dc73..9dc25eb2be44 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -871,7 +871,7 @@ static void cyttsp4_get_mt_touches(struct cyttsp4_mt_data *md, int num_cur_tch)
 	struct cyttsp4_touch tch;
 	int sig;
 	int i, j, t = 0;
-	int ids[max(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
+	int ids[MAX(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
 
 	memset(ids, 0, si->si_ofs.tch_abs[CY_TCH_T].max * sizeof(int));
 	for (i = 0; i < num_cur_tch; i++) {
diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index a01e44049415..99958d470d62 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -270,7 +270,7 @@ static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
 
 static int sun6i_r_intc_suspend(void)
 {
-	u32 buf[BITS_TO_U32(max(SUN6I_NR_TOP_LEVEL_IRQS, SUN6I_NR_MUX_BITS))];
+	u32 buf[BITS_TO_U32(MAX(SUN6I_NR_TOP_LEVEL_IRQS, SUN6I_NR_MUX_BITS))];
 	int i;
 
 	/* Wake IRQs are enabled during system sleep and shutdown. */
diff --git a/drivers/net/can/usb/etas_es58x/es58x_devlink.c b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
index e763a9904bed..0d155eb1b9e9 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_devlink.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
@@ -215,7 +215,7 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 	struct es58x_sw_version *fw_ver = &es58x_dev->firmware_version;
 	struct es58x_sw_version *bl_ver = &es58x_dev->bootloader_version;
 	struct es58x_hw_revision *hw_rev = &es58x_dev->hardware_revision;
-	char buf[max(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];
+	char buf[MAX(sizeof("xx.xx.xx"), sizeof("axxx/xxx"))];
 	int ret = 0;
 
 	if (es58x_sw_version_is_valid(fw_ver)) {
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6d16506bbdc0..6f4c42e66519 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -614,7 +614,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
-			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+			char namebuf[MAX(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 2aa408441cd3..f4ab2750cfc1 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1079,7 +1079,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+	char sym[MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
 		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
 
 	char *p = sym, *pend = sym + sizeof(sym);
-- 
2.47.3


