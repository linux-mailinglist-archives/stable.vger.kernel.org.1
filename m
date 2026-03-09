Return-Path: <stable+bounces-223597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MX0I3ukrmkFHQIAu9opvQ
	(envelope-from <stable+bounces-223597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:44:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B0237492
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E3E83019C8D
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ACE3783CC;
	Mon,  9 Mar 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuTRD4Ww"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67939280C
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053048; cv=none; b=rZjIead5U1yKjXrQa8tJdXLhTYYMqRr8NWwr9qZ/FpVRXqJO39np2M1xTR6uwEJ06IKtPK7xiwag+jAucZ7qqDeAxQTXLuIXVuIkE78rSlm8JtMoul6HaCQr9WTU0VbCyMMBQReyfUz+l0NscVLAwde31Fd9XL6ZpwLV/aGwq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053048; c=relaxed/simple;
	bh=6s2JzudWIB9fKiaz7X0wHZqAAo1bf94j5wi3KvALUa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvyxQyMbculJuJe6r2fxnSjF76cJksqQvX7J9HfErIGLR+N+/QijcZ7svvPexX7fXOBZz2qMjCNsPhIE7xZLKTgUJifjWxmcXTEKJlncyRPe03W7Auy6nxJSB6bqBryZWaEX2PUHEsOpHJbLUIJGpai4txbV/bBaCPdlvR6dzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuTRD4Ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82C7C4CEF7;
	Mon,  9 Mar 2026 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773053048;
	bh=6s2JzudWIB9fKiaz7X0wHZqAAo1bf94j5wi3KvALUa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IuTRD4WwhCusirodmCdkEEkdhqdqA1do+roSzYQQPOfRdpgE1ZoyRSRxVc0MsEYds
	 lxKyz8axfKq+HIZujczN3Ir5jKMOxn5dYYDLWuc0CPV3oHmLsFARwrcZ1SvAFReC65
	 qGPNou1v9AAqVk0fNQdlbSf+tR+LvgIOFYWbDZDq8MCEETB/XK4+AeeEOx3tti47Od
	 exqCf9kqdNK8e7onbUSNORX9IILz4HSR2/UA75GOi/PQBTbGVB3D9XbneehJoY75VZ
	 wBM+iRNvvZ7Pl5sfr9AZQTiUCL104ZUr1MOsiyPm+S0XIHyWA14VIRTWDGHBlAJMDO
	 rNo7dYO6pj/Ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Eric Hu <eric.hu@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] perf/x86/intel/uncore: Support more units on Granite Rapids
Date: Mon,  9 Mar 2026 06:44:05 -0400
Message-ID: <20260309104406.795578-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030906-onion-junkyard-156b@gregkh>
References: <2026030906-onion-junkyard-156b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 330B0237492
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223597-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,infradead.org:email]
X-Rspamd-Action: no action

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 6d642735cdb6cdb814d2b6c81652caa53ce04842 ]

The same CXL PMONs support is also avaiable on GNR. Apply
spr_uncore_cxlcm and spr_uncore_cxldp to GNR as well.

The other units were broken on early HW samples, so they were ignored in
the early enabling patch. The issue has been fixed and verified on the
later production HW. Add UPI, B2UPI, B2HOT, PCIEX16 and PCIEX8 for GNR.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Eric Hu <eric.hu@intel.com>
Link: https://lkml.kernel.org/r/20250108143017.1793781-2-kan.liang@linux.intel.com
Stable-dep-of: 6a8a48644c4b ("perf/x86/intel/uncore: Add per-scheduler IMC CAS count events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 48 ++++++++++++++++++----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 543609d1231ef..76d96df1475a1 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6597,17 +6597,8 @@ void spr_uncore_mmio_init(void)
 /* GNR uncore support */
 
 #define UNCORE_GNR_NUM_UNCORE_TYPES	23
-#define UNCORE_GNR_TYPE_15		15
-#define UNCORE_GNR_B2UPI		18
-#define UNCORE_GNR_TYPE_21		21
-#define UNCORE_GNR_TYPE_22		22
 
 int gnr_uncore_units_ignore[] = {
-	UNCORE_SPR_UPI,
-	UNCORE_GNR_TYPE_15,
-	UNCORE_GNR_B2UPI,
-	UNCORE_GNR_TYPE_21,
-	UNCORE_GNR_TYPE_22,
 	UNCORE_IGNORE_END
 };
 
@@ -6616,6 +6607,31 @@ static struct intel_uncore_type gnr_uncore_ubox = {
 	.attr_update		= uncore_alias_groups,
 };
 
+static struct intel_uncore_type gnr_uncore_pciex8 = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "pciex8",
+};
+
+static struct intel_uncore_type gnr_uncore_pciex16 = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "pciex16",
+};
+
+static struct intel_uncore_type gnr_uncore_upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "upi",
+};
+
+static struct intel_uncore_type gnr_uncore_b2upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "b2upi",
+};
+
+static struct intel_uncore_type gnr_uncore_b2hot = {
+	.name			= "b2hot",
+	.attr_update		= uncore_alias_groups,
+};
+
 static struct intel_uncore_type gnr_uncore_b2cmi = {
 	SPR_UNCORE_PCI_COMMON_FORMAT(),
 	.name			= "b2cmi",
@@ -6640,21 +6656,21 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	&gnr_uncore_ubox,
 	&spr_uncore_imc,
 	NULL,
+	&gnr_uncore_upi,
 	NULL,
 	NULL,
 	NULL,
+	&spr_uncore_cxlcm,
+	&spr_uncore_cxldp,
 	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
+	&gnr_uncore_b2hot,
 	&gnr_uncore_b2cmi,
 	&gnr_uncore_b2cxl,
-	NULL,
+	&gnr_uncore_b2upi,
 	NULL,
 	&gnr_uncore_mdf_sbo,
-	NULL,
-	NULL,
+	&gnr_uncore_pciex16,
+	&gnr_uncore_pciex8,
 };
 
 static struct freerunning_counters gnr_iio_freerunning[] = {
-- 
2.51.0


