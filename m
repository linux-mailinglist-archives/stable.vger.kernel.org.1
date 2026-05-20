Return-Path: <stable+bounces-251245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Js9C34WDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:15:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E45995D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DEFB3397196
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF8F372B58;
	Wed, 20 May 2026 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l+ffn1jV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0C331220;
	Wed, 20 May 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297480; cv=none; b=d7jRjFfA3ah9tmFCdgc8v24W45z0XHOAJC5XghmDA0cxFpKm3104mLP1mRvRRt5Ro59ypthP46PFMJLKefAJ6pFo/tF3KsMvVamQvu7Kzxhmppm8BGDElDinSrXAmqHHn6fdzdYxtIDllULDywKx6UHIEOB30XhUEH3c4VAdv8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297480; c=relaxed/simple;
	bh=35UotdP/CVm65DKulhvfBxjUESnRJL6q1LHLfyNVIcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XO+sxajCYPqAsDBR8n/WlUo9YfvGSOncvbkPyuBuHKXgE+SEkyhb6aMKweBFbggBdr5HKWeoHASWNhsXoTQeJ1NOkkIbiuf8CHSJaF2iifKGJWcPRy7EYCVW6Q7gQJyjiqIgm0JlYNL/GSxdNSUQ6g84sqvhRDeMSl5xOXkSxo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l+ffn1jV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A43C1F000E9;
	Wed, 20 May 2026 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297478;
	bh=i2ma8Cue9u9nl5Qak5s6BLkscLerSVZPBSZI0BK2xNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l+ffn1jVd1K4cj3Oao7VTdMWhh9w2WD3y+AdKU2jAwEIkTmyCZeuf0kFc3sX+58t3
	 FEUeAd5CcygXX6zvg2J63qSGLpTZ6LYxLr3JE57mbDzp+pwGIkaryQS8/4X0cYFNwB
	 h8eff4Y1OrnPKueZugrjDLio8nuHIjL0zn/3B/tU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 048/957] ASoC: Intel: avs: Check maximum valid CPUID leaf
Date: Wed, 20 May 2026 18:08:51 +0200
Message-ID: <20260520162135.600130105@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251245-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linutronix.de:email]
X-Rspamd-Queue-Id: AE8E45995D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmed S. Darwish <darwi@linutronix.de>

[ Upstream commit 93a1f0e61329f538cfc7122d7fa0e7a1803e326d ]

The Intel AVS driver queries CPUID(0x15) before checking if the CPUID leaf
is available.  Check the maximum-valid CPU standard leaf beforehand.

Use the CPUID_LEAF_TSC macro instead of the custom local one for the
CPUID(0x15) leaf number.

Fixes: cbe37a4d2b3c ("ASoC: Intel: avs: Configure basefw on TGL-based platforms")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20260327021645.555257-2-darwi@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/tgl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/avs/tgl.c b/sound/soc/intel/avs/tgl.c
index afb0665161010..4649d749b41e0 100644
--- a/sound/soc/intel/avs/tgl.c
+++ b/sound/soc/intel/avs/tgl.c
@@ -11,8 +11,6 @@
 #include "debug.h"
 #include "messages.h"
 
-#define CPUID_TSC_LEAF 0x15
-
 static int avs_tgl_dsp_core_power(struct avs_dev *adev, u32 core_mask, bool power)
 {
 	core_mask &= AVS_MAIN_CORE_MASK;
@@ -49,7 +47,11 @@ static int avs_tgl_config_basefw(struct avs_dev *adev)
 	unsigned int ecx;
 
 #include <asm/cpuid/api.h>
-	ecx = cpuid_ecx(CPUID_TSC_LEAF);
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+		goto no_cpuid;
+
+	ecx = cpuid_ecx(CPUID_LEAF_TSC);
 	if (ecx) {
 		ret = avs_ipc_set_fw_config(adev, 1, AVS_FW_CFG_XTAL_FREQ_HZ, sizeof(ecx), &ecx);
 		if (ret)
@@ -57,6 +59,7 @@ static int avs_tgl_config_basefw(struct avs_dev *adev)
 	}
 #endif
 
+no_cpuid:
 	hwid.device = pci->device;
 	hwid.subsystem = pci->subsystem_vendor | (pci->subsystem_device << 16);
 	hwid.revision = pci->revision;
-- 
2.53.0




