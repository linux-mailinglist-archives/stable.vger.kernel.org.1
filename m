Return-Path: <stable+bounces-88502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F809B2642
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632C91F21F57
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8318E76F;
	Mon, 28 Oct 2024 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KKg0Ikly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70D18D65C;
	Mon, 28 Oct 2024 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097478; cv=none; b=lG0KoE7QLzjOI++fU43wW5lQaKE5Y/F10g3GJ5EXZLpCYcyNayxgbcFNjgopBH79JbwGW3c+XwA26mQ8AqkcoBEegNfPDKiBp81RcwkXXtxPhjn2npc2IAheWoJPYi2YmF192yZBBZNELax99JJAb7+NqNyjpD8qCaczr+Wkxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097478; c=relaxed/simple;
	bh=k435R9XfFJbb80XTiEnSovSjZLcKqrEsgjc+QwtMlos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsLZSP2u9/yEldDUhxs6QXyW8H7h8Lerkh6daxHYJd8jKETOvgUtUXtNzgv+bH2PsF9ZQWsMw4OzAFTlXPaFX0EmnCNJLoX9I2cyvGBNedc/GBES+C+3k8hpJRarpynC+RsR/jMcVtMVPv+J1+ig93nPWBe0TbTMNX7W0ntAaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KKg0Ikly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B66C4CEC3;
	Mon, 28 Oct 2024 06:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097478;
	bh=k435R9XfFJbb80XTiEnSovSjZLcKqrEsgjc+QwtMlos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKg0Iklydr2JB6jjNOf7HZ2V6nJAakP6gu+wKkSLJ2Z0XBgUsNoyARKu3oJp6Aw0K
	 W5FAOnNbB/wLfPzIWJmliwKjlW4oeeuI/pzBxn1HZl8ofR+rF5x24Ai1MB219K6I+v
	 Ft2HEqHbS97YE81RfKW7F6oIxnMMgDArE+Io523g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Reinette Chatre <reinette.chatre@intel.com>,
	Martin Kletzander <nert.pinx@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 011/208] x86/resctrl: Avoid overflow in MB settings in bw_validate()
Date: Mon, 28 Oct 2024 07:23:11 +0100
Message-ID: <20241028062306.935780692@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kletzander <nert.pinx@gmail.com>

[ Upstream commit 2b5648416e47933939dc310c4ea1e29404f35630 ]

The resctrl schemata file supports specifying memory bandwidth associated with
the Memory Bandwidth Allocation (MBA) feature via a percentage (this is the
default) or bandwidth in MiBps (when resctrl is mounted with the "mba_MBps"
option).

The allowed range for the bandwidth percentage is from
/sys/fs/resctrl/info/MB/min_bandwidth to 100, using a granularity of
/sys/fs/resctrl/info/MB/bandwidth_gran. The supported range for the MiBps
bandwidth is 0 to U32_MAX.

There are two issues with parsing of MiBps memory bandwidth:

* The user provided MiBps is mistakenly rounded up to the granularity
  that is unique to percentage input.

* The user provided MiBps is parsed using unsigned long (thus accepting
  values up to ULONG_MAX), and then assigned to u32 that could result in
  overflow.

Do not round up the MiBps value and parse user provided bandwidth as the u32
it is intended to be. Use the appropriate kstrtou32() that can detect out of
range values.

Fixes: 8205a078ba78 ("x86/intel_rdt/mba_sc: Add schemata support")
Fixes: 6ce1560d35f6 ("x86/resctrl: Switch over to the resctrl mbps_val list")
Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index b44c487727d45..a701e7921ea5c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -27,10 +27,10 @@
  * hardware. The allocated bandwidth percentage is rounded to the next
  * control step available on the hardware.
  */
-static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
-	unsigned long bw;
 	int ret;
+	u32 bw;
 
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
@@ -40,16 +40,21 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	ret = kstrtoul(buf, 10, &bw);
+	ret = kstrtou32(buf, 10, &bw);
 	if (ret) {
-		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
-		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
-				    r->membw.min_bw, r->default_ctrl);
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
+				    bw, r->membw.min_bw, r->default_ctrl);
 		return false;
 	}
 
@@ -63,7 +68,7 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	struct resctrl_staged_config *cfg;
 	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
-	unsigned long bw_val;
+	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
-- 
2.43.0




