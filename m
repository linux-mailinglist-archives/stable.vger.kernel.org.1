Return-Path: <stable+bounces-251971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IERaFGsDDmoD5gUAu9opvQ
	(envelope-from <stable+bounces-251971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:54:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654E597606
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C18830FA0E0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301E7349AFF;
	Wed, 20 May 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QeJjcjJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2642F363F;
	Wed, 20 May 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299406; cv=none; b=WQG2EtaRWLDFtsW0xgnQC5eRShL4I1jBMPnn7VwWay9HTJdS3RH3C1tQoeaHsdhb/KCQpZB8EsOquHkJIbGmrSXliSINz2h0KJay0F3Qn7zlkh7AJ6zruG48QJa2qZS2wZqI9xPiIFuCG09mjBA6Jus4c9Gyw5Cp6AJA0voWC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299406; c=relaxed/simple;
	bh=w6M79GfyH9aahNyyGzMPH50t3XLga4a8AXY95gMB9Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFn0zahXrNjRQL7/hCbw2u75QhfpZfUcxKaAUdatc8GjXxmOXKpi78IPouEdrHA3s4q/Mvbx83fo7sSejlGPTEl/AWMlqHu+lUcjqRuuBX9vtUvc+4kmiPcIV2mVgn5YJ4yURv0PYr6fKJLfkmUvpvFUPVq45inMZ7IIxBNnbOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QeJjcjJm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAE51F000E9;
	Wed, 20 May 2026 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299405;
	bh=y8UNG/strGtQAC0lX2tx60VlNOtX67KJKB+pmRLc+gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QeJjcjJmDe5FAHE8BftcD2jGAjanLtJ+4R26evuZndam/GH0JICwp7U1bU8DWoefq
	 hZkvcUjvAtsK/4S6jdE8GsWswK+PCAnIhHxEL0DFsyaFlxRGoyuf/egkI31VEsFOvH
	 E44+KLLJMl/CGEd2b/iJtgBZyKOt+XrxNkHQkH70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 761/957] ACPICA: Provide #defines for EINJV2 error types
Date: Wed, 20 May 2026 18:20:44 +0200
Message-ID: <20260520162151.067202552@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251971-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6654E597606
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 1f6008538384453eb4c13a3d7ff9e37ee8aee6b9 ]

EINJV2 defined new error types by moving the severity (correctable,
uncorrectable non-fatal, uncorrectable fatal) out of the "type".

ACPI 6.5 introduced EINJV2 and defined a vendor defined error type
using bit 31. This was dropped in ACPI 6.6.

Link: https://github.com/acpica/acpica/commit/e82d2d2fd145
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://patch.msgid.link/20260421150216.11666-2-tony.luck@intel.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 0c00cfbcfcff ("ACPI: APEI: EINJ: Fix EINJV2 memory error injection")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/acpi/actbl1.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7f35eb0e84586..b074244cbdcbf 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1129,6 +1129,12 @@ enum acpi_einj_command_status {
 #define ACPI_EINJ_CXL_MEM_FATAL             (1<<17)
 #define ACPI_EINJ_VENDOR_DEFINED            (1<<31)
 
+/* EINJV2 error types from EINJV2_GET_ERROR_TYPE (ACPI 6.6) */
+
+#define ACPI_EINJV2_PROCESSOR               (1)
+#define ACPI_EINJV2_MEMORY                  (1<<1)
+#define ACPI_EINJV2_PCIE                    (1<<2)
+
 /*******************************************************************************
  *
  * ERST - Error Record Serialization Table (ACPI 4.0)
-- 
2.53.0




