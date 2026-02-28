Return-Path: <stable+bounces-220149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALYvAV0ro2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:52:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E8E1C527F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3F3230F7B73
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA7748C8B2;
	Sat, 28 Feb 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq20UahS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE1848C8AC;
	Sat, 28 Feb 2026 17:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300058; cv=none; b=Zj1YKE02cVMuDaQc796IUbWgUS2HGM1PqJ4plkUVrZHeKgXkOIfupPZpfolnOExV8xPpOyLDf0C8x/7V5cWjj7OrkZXPWKdV+Ws31MRlMw0hRYOiAP/SGYeReXLXv7gH1o0BIJedKKbn7o9N7fAsZg1CQBB/g8yunZGLjXWvk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300058; c=relaxed/simple;
	bh=BrE/nUq19xa+JatKpg2di0H3+n6ik0XyUYvDeY1PfEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6MEOUq00FnlK0ddEE6uNlWFudit+LtdEAiGNZccAGN6SYv5ygi4ZaYG2PORPRZSTe7uZRYF7AZAH+89s+ElQ0YVdCsG3AEFhJCv5imJyJ5JU62Ww6OEMld5gPPXNMdBtBecabMyFbfXwKHpDkPC90kBHyla38Yjb62Es+IWg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq20UahS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AB5C116D0;
	Sat, 28 Feb 2026 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300058;
	bh=BrE/nUq19xa+JatKpg2di0H3+n6ik0XyUYvDeY1PfEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pq20UahS2gt61RbHDXWoUD/EoPZuIcaMYIS7q1Ng0Hz4aPiu4QFRD49KxADokY7AP
	 n8hO04cXcybe1+QTpJlH92jc7l17zSM0EX7gEIlSDYk0zFjjg4H2ksC/o4lLHYrUp3
	 G8NcGrCJNg8smclh499qNGMh7hc7ycNva4ydAM5/P9x55S1z70LX+cqVi5/6khqrRS
	 I0zRb1OrffuHChvsHqZxBOXq+a/b3VAehFmm+otY11K3uOM9z8slFlNoauVpUjLqTm
	 KRu8C+90knd5CT2qhueETBmX8SDhNKYOkPQrsFixFmIU0qYR/k6dCFQrdPbLnepwqX
	 3DwvJ60tuPJCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 071/844] ACPICA: Abort AML bytecode execution when executing AML_FATAL_OP
Date: Sat, 28 Feb 2026 12:19:44 -0500
Message-ID: <20260228173244.1509663-72-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[gmx.de,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220149-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: C4E8E1C527F
X-Rspamd-Action: no action

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 026ad376a6a48538b576f3589331daa94daae6f0 ]

The ACPI specification states that when executing AML_FATAL_OP,
the OS should log the fatal error event and shutdown in a timely
fashion.

Windows complies with this requirement by immediatly entering a
Bso_d, effectively aborting the execution of the AML bytecode in
question.

ACPICA however might continue with the AML bytecode execution
should acpi_os_signal() simply return AE_OK. This will cause issues
because ACPI BIOS implementations might assume that the Fatal()
operator does not return.

Fix this by aborting the AML bytecode execution in such a case
by returning AE_ERROR. Also turn struct acpi_signal_fatal_info into a
local variable because of its small size (12 bytes) and to ensure
that acpi_os_signal() always receives valid information about the
fatal ACPI BIOS error.

Link: https://github.com/acpica/acpica/commit/d516c7758ba6
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/3325491.5fSG56mABF@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/exoparg3.c | 46 +++++++++++++---------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index bf08110ed6d25..c8c8c4e49563e 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -10,6 +10,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acinterp.h"
+#include <acpi/acoutput.h>
 #include "acparser.h"
 #include "amlcode.h"
 
@@ -51,8 +52,7 @@ ACPI_MODULE_NAME("exoparg3")
 acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object **operand = &walk_state->operands[0];
-	struct acpi_signal_fatal_info *fatal;
-	acpi_status status = AE_OK;
+	struct acpi_signal_fatal_info fatal;
 
 	ACPI_FUNCTION_TRACE_STR(ex_opcode_3A_0T_0R,
 				acpi_ps_get_opcode_name(walk_state->opcode));
@@ -60,28 +60,23 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 	switch (walk_state->opcode) {
 	case AML_FATAL_OP:	/* Fatal (fatal_type fatal_code fatal_arg) */
 
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "FatalOp: Type %X Code %X Arg %X "
-				  "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n",
-				  (u32)operand[0]->integer.value,
-				  (u32)operand[1]->integer.value,
-				  (u32)operand[2]->integer.value));
-
-		fatal = ACPI_ALLOCATE(sizeof(struct acpi_signal_fatal_info));
-		if (fatal) {
-			fatal->type = (u32) operand[0]->integer.value;
-			fatal->code = (u32) operand[1]->integer.value;
-			fatal->argument = (u32) operand[2]->integer.value;
-		}
+		fatal.type = (u32)operand[0]->integer.value;
+		fatal.code = (u32)operand[1]->integer.value;
+		fatal.argument = (u32)operand[2]->integer.value;
 
-		/* Always signal the OS! */
+		ACPI_BIOS_ERROR((AE_INFO,
+				 "Fatal ACPI BIOS error (Type 0x%X Code 0x%X Arg 0x%X)\n",
+				 fatal.type, fatal.code, fatal.argument));
 
-		status = acpi_os_signal(ACPI_SIGNAL_FATAL, fatal);
+		/* Always signal the OS! */
 
-		/* Might return while OS is shutting down, just continue */
+		acpi_os_signal(ACPI_SIGNAL_FATAL, &fatal);
 
-		ACPI_FREE(fatal);
-		goto cleanup;
+		/*
+		 * Might return while OS is shutting down, so abort the AML execution
+		 * by returning an error.
+		 */
+		return_ACPI_STATUS(AE_ERROR);
 
 	case AML_EXTERNAL_OP:
 		/*
@@ -93,21 +88,16 @@ acpi_status acpi_ex_opcode_3A_0T_0R(struct acpi_walk_state *walk_state)
 		 * wrong if an external opcode ever gets here.
 		 */
 		ACPI_ERROR((AE_INFO, "Executed External Op"));
-		status = AE_OK;
-		goto cleanup;
+
+		return_ACPI_STATUS(AE_OK);
 
 	default:
 
 		ACPI_ERROR((AE_INFO, "Unknown AML opcode 0x%X",
 			    walk_state->opcode));
 
-		status = AE_AML_BAD_OPCODE;
-		goto cleanup;
+		return_ACPI_STATUS(AE_AML_BAD_OPCODE);
 	}
-
-cleanup:
-
-	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
-- 
2.51.0


