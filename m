Return-Path: <stable+bounces-222724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCbmIIMGpmkzJAAAu9opvQ
	(envelope-from <stable+bounces-222724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:52:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE21E42C0
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 419D5340B702
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104A38BF60;
	Mon,  2 Mar 2026 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+auGhWz"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66439FCAC
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772485210; cv=none; b=rb+HMFcJBIFcJk8haddOP6E1Fcy72IyFpSWbMzImf2QTQqVFyw80fEyxUgoHW8o7d7cUOL8maHqAzN6MnBOnt5UXL2sPi8182qjQPlIoTvdPyfjm5ct6cYr8K+RJcUT+JXbfIThAFLIo77DwDSrawl+52+HqRdrVZd6l2TFipTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772485210; c=relaxed/simple;
	bh=dwW89KcA/JtTK2NDUtHzWQkeHZsBnRoWA9pgOfQEpS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARc86uLKJ3J6sOb1dkLWSmIBFl3etxlJ+Koi8oz1uqwqkP7GkdEqwbEuAUMB2WncMBhMKg+2iy1mqvoFvRDGzAPWs5VkaX6vjQVAWYKj1z0dg+vgn1An28sd1/mjb0CB4VNWn4zDGxvyRxe6wTG0V8NQ4HhRcBlBtdHhRsmRtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+auGhWz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772485197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PSUCx0JU19PweJ9T/g5ckfI7DhyuqktfNCfXRjrXL20=;
	b=C+auGhWzPod2NvvlAQUT0tBhrSd3iSIrDLM20hptSrXGEaPBD713ptlmJSnEyUdmuUWana
	1rquX/qrzCuhL+abrG6tmLevlftuzAGT6yvdrcJNnJQPypGn3EP3y2jPN89y1ZyauirnQg
	yEXWbOtV+Diy3dSCGHHOaL68b1PxtOs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/boot: Fix NULL dereference for missing hugepagesz/hugepages value
Date: Mon,  2 Mar 2026 21:58:59 +0100
Message-ID: <20260302205901.39610-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D4DE21E42C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222724-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

In parse_gb_huge_pages(), 'val' can be NULL if '=' is missing from the
boot parameter. The code passes 'val' to memparse() and
simple_strtoull(), which can dereference NULL.

Reject 'hugepagesz' and 'hugepages' when no value has been provided and
log a warning.

Fixes: 9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages handling")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/boot/compressed/kaslr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 3b0948ad449f..88ccc3b2c5aa 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -205,6 +205,11 @@ static void parse_gb_huge_pages(char *param, char *val)
 	char *p;
 
 	if (!strcmp(param, "hugepagesz")) {
+		if (!val) {
+			warn("Missing value in hugepagesz= boot parameter\n");
+			return;
+		}
+
 		p = val;
 		if (memparse(p, &p) != PUD_SIZE) {
 			gbpage_sz = false;
@@ -218,6 +223,11 @@ static void parse_gb_huge_pages(char *param, char *val)
 	}
 
 	if (!strcmp(param, "hugepages") && gbpage_sz) {
+		if (!val) {
+			warn("Missing value in hugepages= boot parameter\n");
+			return;
+		}
+
 		p = val;
 		max_gb_huge_pages = simple_strtoull(p, &p, 0);
 		return;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


